module dma_thread
  import pygmy_cfg::*;
  import pygmy_typedef::*;
#(
  parameter DMA_MAX_LENGTH_IN_BYTES = 1024*1024, // 1MB
  parameter THREAD_ID = 0
) (
  input   ring_addr_t s2b_dma_thread_src_addr, // Byte address, 4B or 8B align based on element size
  input   ring_addr_t s2b_dma_thread_dst_addr, // Byte address, 4B or 8B align based on element size
  input   ring_addr_t s2b_dma_thread_cbuf_size, // Bytes, 4B or 8B align based on element size
  input   ring_addr_t s2b_dma_thread_cbuf_thold, // Bytes, 4B or 8B align based on element size
  input   ring_addr_t s2b_dma_thread_cbuf_rp_addr, // Byte address, 4B or 8B align based on element size
  output  ring_addr_t b2s_dma_thread_cbuf_rp_addr,
  output  logic       b2s_dma_thread_cbuf_rp_update,
  input   ring_addr_t s2b_dma_thread_cbuf_wp_addr, // Byte address, 4B or 8B align based on element size
  output  ring_addr_t b2s_dma_thread_cbuf_wp_addr,
  output  logic       b2s_dma_thread_cbuf_wp_update,
  input   logic       cbuf_mode_data_avail,
  input   logic       s2b_dma_thread_cbuf_mode,
  input   ring_data_t s2b_dma_thread_length_in_bytes, // Bytes, 4B or 8B align based on element size
  input   logic       s2b_dma_thread_cmd_vld,
  output  logic       b2s_dma_thread_cmd_vld_wdata,
  input   dma_thread_align_t   s2b_dma_thread_use_8b_align,
  input   dma_thread_rpt_cnt_t s2b_dma_thread_rpt_cnt_less_1,

  input   ring_addr_t s2b_dma_thread_gather_grpdepth, // grpdepth % element size = 0
  input   ring_addr_t s2b_dma_thread_gather_stride, // stride % element size = 0

  output  logic       rd_req_vld,
  output  dma_req_t   rd_req,
  input   logic       rd_req_rdy,

  input   logic       rd_rsp_vld,
  input   dma_rsp_t   rd_rsp,
  output  logic       rd_rsp_rdy,

  output  logic       wr_req_vld,
  output  dma_req_t   wr_req,
  input   logic       wr_req_rdy,

  output  logic       bar_vld,
  input   logic       bar_gnt,
  output  logic       bar_done,

  output  logic       intr,
  output  logic       b2s_dma_thread_idle, // DMA Thread is IDLE
  input   logic       s2b_dma_thread_cbuf_full_seen,
  output  logic       b2s_dma_thread_cbuf_full_seen, // DMA Thread has been full, data has been dropped

  input   logic       clk,
  input   logic       rstn
);
  localparam DMA_DATA_PER_REQ     = 4;
  localparam DMA_DATA_OFFSET      = $clog2(DMA_DATA_PER_REQ);
  localparam DMA_MAX_LENGTH_CNT   = DMA_MAX_LENGTH_IN_BYTES / DMA_DATA_PER_REQ;
  localparam DMA_LENGTH_CNT_WIDTH = $clog2(DMA_MAX_LENGTH_CNT);
  localparam TID_WIDTH            = 4;
  localparam N_TID                = 2 ** TID_WIDTH;

  enum logic [2:0] {
    ST_RD_IDLE    = 3'b000,
    ST_GET_TID    = 3'b001,
    ST_FETCH_REQ  = 3'b010,
    ST_FETCH_DONE = 3'b011,
    ST_GET_BAR    = 3'b100,
    ST_SEND_BAR   = 3'b101,
    ST_BAR_RESP   = 3'b110,
    ST_CBUF_WP_UPDATE = 3'b111
  } rff_rd_st, next_rd_st;

  enum logic {
    MODE_PREFETCH,
    MODE_RW
  } dma_mode;

  logic   is_available_tid;

  logic   cbuf_thold_intr;
  logic   cbuf_full_intr;
  logic   inc_full_detected;
  logic   done;
  assign  intr = done | cbuf_thold_intr | cbuf_full_intr;
  assign  cbuf_full_intr = b2s_dma_thread_cbuf_full_seen;

  logic [N_TID-1:0]                            rff_tid_in_use;
  logic [N_TID-1:0] [DMA_LENGTH_CNT_WIDTH+DMA_RPT_CNT_WIDTH-1:0] dff_tid_addr_offset;
  logic [TID_WIDTH-1:0]                        dff_tid_set_addr, tid_set_addr, tid_clear_addr;
  logic                                        do_set_tid_entry, do_clear_tid_entry;

  logic [DMA_LENGTH_CNT_WIDTH-1:0]             requested_fetch_amt, req_num_pkts;
  logic [DMA_LENGTH_CNT_WIDTH-1:0]             rff_fetch_cnt, next_fetch_cnt, fetch_addr_amount;
  logic [DMA_LENGTH_CNT_WIDTH-1:0]             rff_fetch_cnt_grp, next_fetch_cnt_grp, stride_amount, grp_amount;
  logic [DMA_LENGTH_CNT_WIDTH+DMA_RPT_CNT_WIDTH-1:0]  rff_fetch_cnt_tot, next_fetch_cnt_tot;

  dma_thread_rpt_cnt_t                         rff_rpt_cnt, next_rpt_cnt;

  logic                                        wr_req_accepted;
  logic                                        wr_rsp_rcvd;
  logic                                        wr_req_addr_overflow;

  logic                                        is_dst_addr_oursring;
  logic                                        use_4b_gran;

  assign is_dst_addr_oursring = ~s2b_dma_thread_dst_addr[31];

  assign use_4b_gran = ~s2b_dma_thread_use_8b_align;

  assign fetch_addr_amount = use_4b_gran ? {{(DMA_LENGTH_CNT_WIDTH-2){1'b0}}, 2'b01}: {{(DMA_LENGTH_CNT_WIDTH-2){1'b0}}, 2'b10};
  assign dma_mode = (s2b_dma_thread_src_addr == s2b_dma_thread_dst_addr) ? MODE_PREFETCH: MODE_RW;

  //==========================================================
  // TID array {{{

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_tid_in_use <= '0;
    end else begin
      if (do_set_tid_entry) begin
        rff_tid_in_use[dff_tid_set_addr] <= '1;
      end
      if (do_clear_tid_entry) begin
        rff_tid_in_use[tid_clear_addr] <= '0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (do_set_tid_entry) begin
      dff_tid_addr_offset[dff_tid_set_addr] <= rff_fetch_cnt_tot;
    end
  end

  assign is_available_tid = |(~rff_tid_in_use);

  always_comb begin
    tid_set_addr = '0;
    for (int i=0; i<N_TID; i++) begin
      if (~rff_tid_in_use[i]) begin
        tid_set_addr = TID_WIDTH'(i);
        break;
      end
    end
  end

  always_ff @(posedge clk) begin
    if ((rff_rd_st == ST_GET_TID) & is_available_tid) begin
      dff_tid_set_addr <= tid_set_addr;
    end
  end

  // }}}

  //==========================================================
  // RD req {{{

  assign req_num_pkts = (s2b_dma_thread_length_in_bytes >> DMA_DATA_OFFSET);
  always_comb begin
    if (use_4b_gran) begin
      if (s2b_dma_thread_length_in_bytes[DMA_DATA_OFFSET-1:0] == '0) begin
        requested_fetch_amt = req_num_pkts;
      end else begin
        requested_fetch_amt = req_num_pkts + {{(DMA_LENGTH_CNT_WIDTH-1){1'b0}}, 1'b1};
      end
    end else begin
      if (s2b_dma_thread_length_in_bytes[DMA_DATA_OFFSET:0] == '0) begin
        requested_fetch_amt = req_num_pkts;
      end else begin
        requested_fetch_amt = {req_num_pkts[DMA_LENGTH_CNT_WIDTH-1:1], 1'b0} + {{(DMA_LENGTH_CNT_WIDTH-2){1'b0}}, 2'b10};
      end
    end
  end

  assign stride_amount = (s2b_dma_thread_gather_stride >> DMA_DATA_OFFSET);
  assign grp_amount    = (s2b_dma_thread_gather_grpdepth >> DMA_DATA_OFFSET);

  assign rd_req_vld = (rff_rd_st == ST_FETCH_REQ);

  assign rd_req.tid[6]    = 1'b0; // DMA
  assign rd_req.tid[5:4]  = THREAD_ID; // Thread ID
  assign rd_req.tid[3:0]  = dff_tid_set_addr;
  assign rd_req.req_type  = REQ_READ;
  assign rd_req.addr      = s2b_dma_thread_src_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET){1'b0}}, rff_fetch_cnt, {DMA_DATA_OFFSET{1'b0}}};
  assign rd_req.chk       = rd_req.addr[DMA_DATA_OFFSET +: 2];
  assign rd_req.wdata     = 64'h0;
  assign rd_req.mask      = 8'hff;

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_rd_st <= ST_RD_IDLE;
      rff_fetch_cnt <= '0;
      rff_fetch_cnt_tot <= '0;
      rff_fetch_cnt_grp <= '0;
      rff_rpt_cnt <= '0;
    end else begin
      rff_rd_st <= next_rd_st;
      rff_fetch_cnt <= next_fetch_cnt;
      rff_fetch_cnt_tot <= next_fetch_cnt_tot;
      rff_fetch_cnt_grp <= next_fetch_cnt_grp;
      rff_rpt_cnt <= next_rpt_cnt;
    end
  end

  always_comb begin
    next_rd_st = rff_rd_st;
    next_fetch_cnt = rff_fetch_cnt;
    next_fetch_cnt_tot = rff_fetch_cnt_tot;
    next_fetch_cnt_grp = rff_fetch_cnt_grp;
    next_rpt_cnt = rff_rpt_cnt;
    do_set_tid_entry = '0;
    b2s_dma_thread_cmd_vld_wdata = s2b_dma_thread_cmd_vld;
    done = '0;
    bar_done = '0;
    case (rff_rd_st)
      ST_RD_IDLE: begin
        if (s2b_dma_thread_cmd_vld & ~s2b_dma_thread_cbuf_mode) begin
          next_rd_st = ST_GET_TID;
          next_fetch_cnt = '0;
          next_fetch_cnt_tot = '0;
          next_fetch_cnt_grp = '0;
          next_rpt_cnt = '0;
        end else if (s2b_dma_thread_cmd_vld & s2b_dma_thread_cbuf_mode & cbuf_mode_data_avail) begin
          if (s2b_dma_thread_cbuf_wp_addr != s2b_dma_thread_cbuf_rp_addr) begin
            next_rd_st = ST_GET_TID;
		        next_fetch_cnt = '0;
            next_fetch_cnt_tot = '0;
            next_fetch_cnt_grp = '0;
            next_rpt_cnt = '0;
          end else begin
            b2s_dma_thread_cmd_vld_wdata = 1'b0;
          end
        end
      end
      ST_GET_TID: begin
        if (is_available_tid) begin
          next_rd_st = ST_FETCH_REQ;
        end
      end
      ST_FETCH_REQ: begin
        if (rd_req_rdy) begin
          do_set_tid_entry = '1;
          next_fetch_cnt_grp = rff_fetch_cnt_grp + fetch_addr_amount;
          next_fetch_cnt_tot = rff_fetch_cnt_tot + fetch_addr_amount;
          if (next_fetch_cnt_grp == grp_amount) begin
            next_fetch_cnt_grp = '0;
            next_fetch_cnt = rff_fetch_cnt + fetch_addr_amount + stride_amount - grp_amount;
          end else begin
            next_fetch_cnt = rff_fetch_cnt + fetch_addr_amount;
          end
          if (next_fetch_cnt >= requested_fetch_amt) begin
            next_rd_st = ST_FETCH_DONE;
          end else begin
            next_rd_st = ST_GET_TID;
          end
        end
      end
      ST_FETCH_DONE: begin
        if (~(|rff_tid_in_use)) begin
          if ((dma_mode == MODE_RW) & ~is_dst_addr_oursring) begin
            next_rd_st = ST_GET_BAR;
          end else if (rff_rpt_cnt == s2b_dma_thread_rpt_cnt_less_1) begin
            if (s2b_dma_thread_cbuf_mode) begin
              next_rd_st = ST_CBUF_WP_UPDATE;
            end else begin
              b2s_dma_thread_cmd_vld_wdata = '0;
              done = '1;
              next_rd_st = ST_RD_IDLE;
            end
          end else begin
            next_rpt_cnt = rff_rpt_cnt + 1'b1;
            next_rd_st = ST_GET_TID;
            next_fetch_cnt = '0;
          end
        end
      end
      ST_GET_BAR: begin
        if (bar_gnt) begin
          next_rd_st = ST_SEND_BAR;
        end
      end
      ST_SEND_BAR: begin
        if (wr_req_rdy) begin
          next_rd_st = ST_BAR_RESP;
        end
      end
      ST_BAR_RESP: begin
        if (rd_rsp_vld) begin
          bar_done = '1;
          if (rff_rpt_cnt == s2b_dma_thread_rpt_cnt_less_1) begin
            if (s2b_dma_thread_cbuf_mode) begin
              next_rd_st = ST_CBUF_WP_UPDATE;
            end else begin
              b2s_dma_thread_cmd_vld_wdata = '0;
              done = '1;
              next_rd_st = ST_RD_IDLE;
            end
          end else begin
            next_rpt_cnt = rff_rpt_cnt + 1'b1;
            next_rd_st = ST_GET_TID;
            next_fetch_cnt = '0;
          end
        end
      end
      ST_CBUF_WP_UPDATE: begin
        next_rd_st = ST_RD_IDLE;
        if (s2b_dma_thread_cbuf_full_seen) begin
          b2s_dma_thread_cmd_vld_wdata = '0;
        end
      end
      default: begin
        next_rd_st = ST_RD_IDLE;
        next_fetch_cnt = '0;
        next_rpt_cnt = '0;
      end
    endcase
  end

  // }}}

  //==========================================================
  // WR req {{{

  always_comb begin
    if (dma_mode == MODE_RW) begin
      if (rff_rd_st == ST_BAR_RESP) begin
        rd_rsp_rdy = '1;
        wr_req_vld = '0;
      end else begin
        rd_rsp_rdy = rd_rsp_vld ? (rd_rsp.is_wr_rsp ? '1: wr_req_accepted): '0;
        wr_req_vld = (rff_rd_st == ST_SEND_BAR) ? '1: (rd_rsp_vld & ~rd_rsp.is_wr_rsp & ~wr_req_addr_overflow);
      end
    end else begin
      rd_rsp_rdy = '1;
      wr_req_vld = '0;
    end
  end

  always_comb begin
    if (dma_mode == MODE_RW) begin
      if (rff_rd_st == ST_SEND_BAR) begin
        do_clear_tid_entry = '0;
      end else if (is_dst_addr_oursring) begin
        do_clear_tid_entry = wr_rsp_rcvd;
      end else begin
        do_clear_tid_entry = wr_req_accepted | inc_full_detected;
      end
    end else begin
      do_clear_tid_entry = rd_rsp_vld;
    end
  end

  assign wr_req_accepted = (wr_req_vld & wr_req_rdy);
  assign b2s_dma_thread_cbuf_full_seen = s2b_dma_thread_cbuf_mode & (((rff_rd_st != ST_SEND_BAR) & (rd_rsp_vld & ~rd_rsp.is_wr_rsp & wr_req_addr_overflow)) | (s2b_dma_thread_cbuf_wp_addr == s2b_dma_thread_cbuf_rp_addr));
  assign inc_full_detected = s2b_dma_thread_cbuf_mode & ((rff_rd_st != ST_SEND_BAR) & (rd_rsp_vld & ~rd_rsp.is_wr_rsp & wr_req_addr_overflow));
  always_comb begin
    wr_req_addr_overflow = 1'b0;
    if (s2b_dma_thread_cbuf_mode) begin
      if (s2b_dma_thread_cbuf_wp_addr == (s2b_dma_thread_cbuf_rp_addr & {{($bits(ring_addr_t)-1){1'b1}}, 1'b0})) begin
        if (s2b_dma_thread_cbuf_rp_addr[0] == 1'b1) begin
          wr_req_addr_overflow = 1'b0;
        end else begin
          wr_req_addr_overflow = 1'b1;
        end
      end else if (s2b_dma_thread_cbuf_wp_addr > s2b_dma_thread_cbuf_rp_addr) begin
        if ((wr_req.addr >= s2b_dma_thread_cbuf_rp_addr) && (wr_req.addr < s2b_dma_thread_cbuf_wp_addr)) begin
          wr_req_addr_overflow = 1'b1;
        end
      end else begin
        if ((wr_req.addr >= s2b_dma_thread_cbuf_rp_addr) || (wr_req.addr < s2b_dma_thread_cbuf_wp_addr)) begin
          wr_req_addr_overflow = 1'b1;
        end
      end
    end
  end
  assign wr_rsp_rcvd = (rd_rsp_vld & rd_rsp.is_wr_rsp);

  assign tid_clear_addr = rd_rsp.tid[3:0];

  assign wr_req.tid[6]    = 1'b0; // DMA
  assign wr_req.tid[5:4]  = THREAD_ID; // Thread ID
  assign wr_req.tid[3:0]  = (rff_rd_st == ST_SEND_BAR) ? '0: tid_clear_addr;
  assign wr_req.req_type  = (rff_rd_st == ST_SEND_BAR) ? REQ_BARRIER_SYNC: REQ_WRITE;
  always_comb begin
    if (s2b_dma_thread_cbuf_mode) begin
      if (rff_rd_st == ST_SEND_BAR) begin
        wr_req.addr = s2b_dma_thread_cbuf_wp_addr;
      end else begin
        if ((s2b_dma_thread_cbuf_wp_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, dff_tid_addr_offset[tid_clear_addr], {DMA_DATA_OFFSET{1'b0}}}) < (s2b_dma_thread_dst_addr + s2b_dma_thread_cbuf_size)) begin
          wr_req.addr = s2b_dma_thread_cbuf_wp_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, dff_tid_addr_offset[tid_clear_addr], {DMA_DATA_OFFSET{1'b0}}};
        end else begin
          wr_req.addr = s2b_dma_thread_cbuf_wp_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, dff_tid_addr_offset[tid_clear_addr], {DMA_DATA_OFFSET{1'b0}}} - s2b_dma_thread_cbuf_size;
        end
      end
    end else begin
      if (rff_rd_st == ST_SEND_BAR) begin
        wr_req.addr = s2b_dma_thread_dst_addr;
      end else begin
        wr_req.addr = s2b_dma_thread_dst_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, dff_tid_addr_offset[tid_clear_addr], {DMA_DATA_OFFSET{1'b0}}};
      end
    end
  end
  assign wr_req.chk       = wr_req.addr[DMA_DATA_OFFSET +: 2];
  assign wr_req.wdata     = rd_rsp.rdata;
  assign wr_req.mask      = use_4b_gran ? (wr_req.addr[2] ? 8'hf0: 8'h0f): 8'hff;

  assign b2s_dma_thread_cbuf_wp_update = (rff_rd_st == ST_CBUF_WP_UPDATE);
  always_comb begin
    if ((s2b_dma_thread_cbuf_wp_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, rff_fetch_cnt_tot, {DMA_DATA_OFFSET{1'b0}}}) < (s2b_dma_thread_dst_addr + s2b_dma_thread_cbuf_size)) begin
      b2s_dma_thread_cbuf_wp_addr = s2b_dma_thread_cbuf_wp_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, rff_fetch_cnt_tot, {DMA_DATA_OFFSET{1'b0}}};
    end else begin
      b2s_dma_thread_cbuf_wp_addr = s2b_dma_thread_cbuf_wp_addr + {{(RING_ADDR_WIDTH-DMA_LENGTH_CNT_WIDTH-DMA_DATA_OFFSET-DMA_RPT_CNT_WIDTH){1'b0}}, rff_fetch_cnt_tot, {DMA_DATA_OFFSET{1'b0}}} - s2b_dma_thread_cbuf_size;
    end
  end

  assign cbuf_thold_intr = (s2b_dma_thread_cbuf_mode & ((s2b_dma_thread_cbuf_wp_addr - (s2b_dma_thread_cbuf_rp_addr & {{($bits(ring_addr_t)-1){1'b1}}, 1'b0})) >= s2b_dma_thread_cbuf_thold));

  assign b2s_dma_thread_idle = (rff_rd_st == ST_RD_IDLE);

  assign b2s_dma_thread_cbuf_rp_update = (rff_rd_st == ST_CBUF_WP_UPDATE);
  assign b2s_dma_thread_cbuf_rp_addr   = (s2b_dma_thread_cbuf_rp_addr & {{($bits(ring_addr_t)-1){1'b1}}, 1'b0});

  // }}}

  //==========================================================
  // Memory barrier req {{{

  assign bar_vld = (rff_rd_st == ST_GET_BAR);

  // }}}

`ifndef SYNTHESIS
  clearing_tid_not_in_use: assert property (@(posedge clk) disable iff (rstn !== '1) (do_clear_tid_entry |-> (rff_tid_in_use[tid_clear_addr] === 1'b1)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: clearing unused tid (%h)", tid_clear_addr));
  setting_tid_in_use: assert property (@(posedge clk) disable iff (rstn !== '1) (do_set_tid_entry |-> (rff_tid_in_use[dff_tid_set_addr] === 1'b0)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: setting used tid (%h)", dff_tid_set_addr));
  rd_req_vld_is_x: assert property (@(posedge clk) disable iff (rstn !== '1) (!$isunknown(rd_req_vld)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: rd_req_vld is x"));
  wr_req_vld_is_x: assert property (@(posedge clk) disable iff (rstn !== '1) (!$isunknown(wr_req_vld)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: wr_req_vld is x"));
  rd_rsp_rdy_is_x: assert property (@(posedge clk) disable iff (rstn !== '1) (!$isunknown(rd_rsp_rdy)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: rd_rsp_rdy is x"));
  bar_vld_is_x: assert property (@(posedge clk) disable iff (rstn !== '1) (!$isunknown(bar_vld)))
    else `olog_fatal("DMA_THREAD", $sformatf("%m: bar_vld is x"));
`endif

endmodule
