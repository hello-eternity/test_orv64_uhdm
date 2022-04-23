// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_debug_access
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import station_vp_pkg::*;
  import pygmy_intf_typedef::*;
(
  input                       ring_req_if_awvalid,
  input                       ring_req_if_wvalid,
  input                       ring_req_if_arvalid,
  input oursring_req_if_ar_t  ring_req_if_ar,
  input oursring_req_if_aw_t  ring_req_if_aw,
  input oursring_req_if_w_t   ring_req_if_w,
  output logic                ring_req_if_arready,
  output logic                ring_req_if_wready,
  output logic                ring_req_if_awready,

  output oursring_resp_if_b_t ring_resp_if_b,
  output oursring_resp_if_r_t ring_resp_if_r,
  output                      ring_resp_if_rvalid,
  output                      ring_resp_if_bvalid,
  input                       ring_resp_if_rready,
  input                       ring_resp_if_bready,

  output logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_en_pway,
  output logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_rw_pway,
  output orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_addr_pway,
  output orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_din_pway,
  input  orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_dout_pway,

  output logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_en_pway,
  output logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_rw_pway,
  output orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_addr_pway,
  output cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_bitmask_pway,
  output cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_din_pway,
  input  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_dout_pway,

  input   orv64_if2da_t         if2da,
  input   orv64_id2da_t         id2da,
  input   orv64_ex2da_t         ex2da,
  input   orv64_ma2da_t         ma2da,

  input   orv64_itb2da_t        itb2da,
  output  orv64_da2itb_t        da2itb,

  input   orv64_tlb2da_t        itlb2da,
  output  orv64_da2tlb_t        da2itlb,

  input   orv64_tlb2da_t        dtlb2da,
  output  orv64_da2tlb_t        da2dtlb,


  input   orv64_ib2da_t         ib2da,
  output  orv64_da2ib_t         da2ib,

  input   logic                 update_hash,
  input   orv64_data_t          next_hash,
  output  orv64_data_t          current_hash,


  // debug register input
  input   orv64_vaddr_t   if_pc, id_pc, wb_pc,
  input   orv64_inst_t    if_inst, id_inst,
  input   logic     if_stall, if_kill, if_valid, if_ready, id_stall, id_kill, id_valid, id_ready, ex_stall, ex_kill, ex_valid, ex_ready, ma_stall, ma_kill, ma_valid, ma_ready, wb_valid, wb_ready, cs2if_kill, cs2id_kill, cs2ex_kill, cs2ma_kill, l2_req_valid, l2_req_ready, l2_resp_valid, l2_resp_ready, wfe_stall, wfi_stall, ma2if_npc_valid, ex2if_kill, ex2id_kill, branch_solved,
  input   orv64_prv_t           prv,
  input   orv64_if2ic_t         if2ic,
  input   orv64_ic2if_t         ic2if,
  input   orv64_excp_t          if2id_excp_ff,
  input   orv64_excp_t          id2ex_excp_ff,
  input   orv64_excp_t          ex2ma_excp_ff,
  input   orv64_excp_t          ma2cs_excp,
  input   orv64_if2id_ctrl_t    if2id_ctrl_ff,
  input   orv64_id2ex_ctrl_t    id2ex_ctrl_ff,
  input   orv64_ex2ma_ctrl_t    ex2ma_ctrl_ff,
  input   orv64_ma2cs_ctrl_t    ma2cs_ctrl,
  input   orv64_cs2da_t         cs2da,

  input   rst, clk
);
`ifndef SYNTHESIS
//  import ours_logging::*;
`endif

  localparam ICACHE_WAY0_TAG_BASE = STATION_VP_IC_TAG_WAY_0_OFFSET;
  localparam ICACHE_WAY0_TAG_BOUNDS = ICACHE_WAY0_TAG_BASE + STATION_VP_IC_TAG_WAY_0_WIDTH/8;
  localparam ICACHE_WAY0_DATA_BASE = STATION_VP_IC_DATA_WAY_0_OFFSET;
  localparam ICACHE_WAY0_DATA_BOUNDS = ICACHE_WAY0_DATA_BASE +STATION_VP_IC_DATA_WAY_0_WIDTH/8;
  localparam ICACHE_WAY1_TAG_BASE = STATION_VP_IC_TAG_WAY_1_OFFSET;
  localparam ICACHE_WAY1_TAG_BOUNDS = ICACHE_WAY1_TAG_BASE + STATION_VP_IC_TAG_WAY_1_WIDTH/8;
  localparam ICACHE_WAY1_DATA_BASE = STATION_VP_IC_DATA_WAY_1_OFFSET;
  localparam ICACHE_WAY1_DATA_BOUNDS = ICACHE_WAY1_DATA_BASE +STATION_VP_IC_DATA_WAY_1_WIDTH/8;
  localparam ITB_BASE = STATION_VP_ITB_DATA_OFFSET;
  localparam ITB_BOUNDS = ITB_BASE + STATION_VP_ITB_DATA_WIDTH/8;
  localparam IBUF_LINE0_BASE = STATION_VP_IBUF_LINE_DATA_OFFSET__DEPTH_0;
  localparam IBUF_LINE0_BOUNDS = IBUF_LINE0_BASE + STATION_VP_IBUF_LINE_DATA_WIDTH/8;
  localparam IBUF_LINE1_BASE = STATION_VP_IBUF_LINE_DATA_OFFSET__DEPTH_1;
  localparam IBUF_LINE1_BOUNDS = IBUF_LINE1_BASE + STATION_VP_IBUF_LINE_DATA_WIDTH/8;


  localparam CACHE_LINE_SELECT_WIDTH = $clog2(CPU_DATA_WIDTH/RING_DATA_WIDTH);

  orv64_data_t                            rff_hash;

  ring_addr_t                             dff_req_addr, next_req_addr;
  ring_data_t                             dff_wr_data, next_wr_data;
  logic [31:0]                            dff_rdata, next_rdata;
  axi4_resp_t                             rff_rresp, next_rresp, rff_bresp, next_bresp;
  ring_tid_t                              rff_tid, next_tid;
  logic                                   is_debug_reg_req, is_itb_req, is_ic_tag_req, is_ic_data_req, is_ibuf_data_req, is_hash_req;
  orv64_ic_wyid_t                         ic_wyid;
  logic [CACHE_LINE_SELECT_WIDTH-1:0]     cache_line_select, ibuf_line_select;
  logic                                   ibuf_line_idx;

  enum logic [3:0] {
    ST_IDLE        = 4'b0000,
    ST_RD_REQ      = 4'b0001, 
    ST_WR_REQ      = 4'b0010,
    ST_RD_RESP     = 4'b0011,
    ST_RET_RD_RESP = 4'b0101,
    ST_WR_RESP     = 4'b0110
  } rff_state, next_state;

  //==========================================================
  // ICG {{{

  logic rd_clkg, en_dff_rd_data;
  logic wr_clkg, en_dff_wr_data;
  logic req_addr_clkg, en_req_addr;

  assign en_dff_rd_data = (rff_state == ST_RD_RESP);

  icg wr_clk_u(
    .en       (en_dff_wr_data),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (wr_clkg)
  );

  icg rd_clk_u(
    .en       (en_dff_rd_data),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (rd_clkg)
  );

  icg req_addr_clk_u(
    .en       (en_req_addr),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (req_addr_clkg)
  );

  // }}}

  assign current_hash = rff_hash;

  assign ring_resp_if_bvalid = (rff_state == ST_WR_RESP);
  assign ring_resp_if_rvalid = (rff_state == ST_RET_RD_RESP);
  assign ring_resp_if_b.bresp = rff_bresp;
  assign ring_resp_if_r.rresp = rff_rresp;
  assign ring_resp_if_b.bid = rff_tid;
  assign ring_resp_if_r.rid = rff_tid;
  assign ring_resp_if_r.rdata = ring_data_t'(dff_rdata);
  assign ring_resp_if_r.rlast = '1;

  logic                                   da_write_to_hash;


  always_ff @(posedge clk) begin
    if (rst) begin
      rff_state <= ST_IDLE;
      rff_rresp <= AXI_RESP_DECERR;
      rff_bresp <= AXI_RESP_OKAY;
    end else begin
      rff_state <= next_state;
      rff_tid <= next_tid;
      rff_rresp <= next_rresp;
      rff_bresp <= next_bresp;
    end
  end

  always_ff @(posedge req_addr_clkg) begin
    if (en_req_addr) begin
      dff_req_addr <= next_req_addr;
    end
  end

  always_ff @(posedge wr_clkg) begin
    if (en_dff_wr_data) begin
      dff_wr_data <= next_wr_data;
    end
  end

  always_ff @(posedge rd_clkg) begin
    if (en_dff_rd_data) begin
      dff_rdata <= next_rdata;
    end
  end

  always_comb begin
    next_state = rff_state;
    next_req_addr = dff_req_addr;
    next_wr_data = dff_wr_data;
    next_tid = rff_tid;

    en_req_addr = '0;
    en_dff_wr_data = '0;

    ring_req_if_arready = '0; 
    ring_req_if_awready = '0; 
    ring_req_if_wready  = '0; 

    case (rff_state)
      ST_IDLE: begin
        if (ring_req_if_arvalid) begin
          next_state = ST_RD_REQ;
          next_req_addr = ring_req_if_ar.araddr;
          next_tid = ring_req_if_ar.arid;

          en_req_addr = '1;

          ring_req_if_arready = '1; 
        end else if (ring_req_if_awvalid & ring_req_if_wvalid) begin
          next_state = ST_WR_REQ;
          next_req_addr = ring_req_if_aw.awaddr;
          next_wr_data = ring_req_if_w.wdata;
          next_tid = ring_req_if_aw.awid;

          en_req_addr = '1;
          en_dff_wr_data = '1;

          ring_req_if_awready = '1; 
          ring_req_if_wready  = '1; 
        end
      end
      ST_RD_REQ: begin
        next_state = ST_RD_RESP;
      end
      ST_WR_REQ: begin
        next_state = ST_WR_RESP;
      end
      ST_RD_RESP: begin
        next_state = ST_RET_RD_RESP;
      end
      ST_RET_RD_RESP: begin
        if (ring_resp_if_rready) begin
          next_state = ST_IDLE;
        end
      end
      ST_WR_RESP: begin
        if (ring_resp_if_bready) begin
          next_state = ST_IDLE;
        end
      end
      default: begin
        next_state = ST_IDLE;
      end
    endcase
  end

  always_comb begin
    ic_wyid = '0;
    is_debug_reg_req = '0;
    is_itb_req = '0;
    is_ic_tag_req = '0;
    is_ic_data_req = '0;
    is_ibuf_data_req = '0;
    ibuf_line_idx = '0;
    is_hash_req = '0;
    if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= ICACHE_WAY0_TAG_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < ICACHE_WAY0_TAG_BOUNDS)) begin
      is_ic_tag_req = '1;
      ic_wyid = 1'b0;
    end else if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= ICACHE_WAY0_DATA_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < ICACHE_WAY0_DATA_BOUNDS)) begin
      is_ic_data_req = '1;
      ic_wyid = 1'b0;
    end else if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= ICACHE_WAY1_TAG_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < ICACHE_WAY1_TAG_BOUNDS)) begin
      is_ic_tag_req = '1;
      ic_wyid = 1'b1;
    end else if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= ICACHE_WAY1_DATA_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < ICACHE_WAY1_DATA_BOUNDS)) begin
      is_ic_data_req = '1;
      ic_wyid = 1'b1;
    end else if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= ITB_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < ITB_BOUNDS)) begin
      is_itb_req = '1;
    end else if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= IBUF_LINE0_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < IBUF_LINE0_BOUNDS)) begin
      ibuf_line_idx = 1'b0;
      is_ibuf_data_req = '1;
    end else if ((dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] >= IBUF_LINE1_BASE) & (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0] < IBUF_LINE1_BOUNDS)) begin
      ibuf_line_idx = 1'b1;
      is_ibuf_data_req = '1;
    end else begin
      is_debug_reg_req = '1;
    end
  end

  // TODO: parameterize these
  assign da2itb.addr = dff_req_addr[2 +: ORV64_ITB_ADDR_WIDTH];
  assign da2itb.din = orv64_itb_data_t'(dff_wr_data);

  assign cache_line_select = dff_req_addr[(CACHE_OFFSET_WIDTH-1) -: CACHE_LINE_SELECT_WIDTH];
  assign ibuf_line_select = dff_req_addr[(CACHE_OFFSET_WIDTH-1) -: CACHE_LINE_SELECT_WIDTH];

  generate
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign debug_ic_tag_ram_addr_pway[i] = dff_req_addr[3 +: ORV64_ICACHE_INDEX_WIDTH];
      assign debug_ic_tag_ram_din_pway[i] = orv64_ic_tag_entry_t'(dff_wr_data);
      assign debug_ic_data_ram_addr_pway[i] = dff_req_addr[ORV64_ICACHE_OFFSET_WIDTH +: ORV64_ICACHE_INDEX_WIDTH];
    end
  endgenerate

  always_comb begin
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      debug_ic_data_ram_bitmask_pway[i] = '0;
      debug_ic_data_ram_bitmask_pway[i][cache_line_select*(RING_DATA_WIDTH) +: RING_DATA_WIDTH] = '1;
    end
  end

  assign debug_ic_data_ram_din_pway = {(ORV64_ICACHE_LINE_WIDTH/RING_DATA_WIDTH){dff_wr_data}};

  always_comb begin
    if (rff_state == ST_WR_REQ) begin
      da2itb.en = is_itb_req;
      da2itb.rw = '1;
    end else if (rff_state == ST_RD_REQ) begin
      da2itb.en = is_itb_req;
      da2itb.rw = '0;
    end else begin
      da2itb.en = '0;
      da2itb.rw = '0;
    end
  end

  always_comb begin
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      if ((rff_state == ST_WR_REQ) | (rff_state == ST_RD_REQ)) begin
        debug_ic_tag_ram_en_pway[i] = is_ic_tag_req & (i == ic_wyid);
        debug_ic_data_ram_en_pway[i] = is_ic_data_req & (i == ic_wyid);
      end else begin
        debug_ic_tag_ram_en_pway[i] = '0;
        debug_ic_data_ram_en_pway[i] = '0;
      end
    end
  end

  always_comb begin
    if (rff_state == ST_WR_REQ) begin
      debug_ic_tag_ram_rw_pway = '1;
      debug_ic_data_ram_rw_pway = '1;
    end else begin
      debug_ic_tag_ram_rw_pway = '0;
      debug_ic_data_ram_rw_pway = '0;
    end
  end

  always_comb begin
    next_bresp = rff_bresp;
    if (rff_state == ST_WR_REQ) begin
      if (is_itb_req | is_ic_tag_req | is_ic_data_req | is_hash_req) begin
        next_bresp = AXI_RESP_OKAY;
      end else begin
        next_bresp = AXI_RESP_DECERR;
      end
    end
  end

  always_comb begin
    next_rdata = '0;
    next_rresp = AXI_RESP_OKAY;

    da2itlb = '0;
    da2dtlb = '0;
    da2ib = '0;

    if (rff_state == ST_RD_RESP) begin
      if (is_ic_tag_req) begin
        next_rdata = debug_ic_tag_ram_dout_pway[ic_wyid];
      end else if (is_ic_data_req) begin
        next_rdata = debug_ic_data_ram_dout_pway[ic_wyid][cache_line_select*(RING_DATA_WIDTH) +: RING_DATA_WIDTH];
      end else if (is_itb_req) begin
        next_rdata = itb2da.dout;
      end else if (is_ibuf_data_req) begin
        da2ib.en = '1;
        da2ib.line_idx = ibuf_line_idx;
        next_rdata = ib2da.line_data[ibuf_line_select*(RING_DATA_WIDTH) +: RING_DATA_WIDTH];
      end else if (is_debug_reg_req) begin
        case (dff_req_addr[STATION_VP_RING_ADDR_WIDTH - STATION_VP_BLKID_WIDTH - 1 : 0])
          STATION_VP_PRV_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_prv_t)){1'b0}}, prv};
          end
          STATION_VP_IF_PC_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VIR_ADDR_WIDTH){1'b0}}, if_pc};
          end
          STATION_VP_IF_INST_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_inst_t)){1'b0}}, if_inst};
          end
          STATION_VP_IF_STALL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if_stall} ;
          end
          STATION_VP_IF_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if_kill} ;
          end
          STATION_VP_IF_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if_valid} ;
          end
          STATION_VP_IF_READY_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if_ready} ;
          end
          STATION_VP_ID_PC_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VIR_ADDR_WIDTH){1'b0}}, id_pc};
          end
          STATION_VP_ID_INST_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_inst_t)){1'b0}}, id_inst};
          end
          STATION_VP_ID_STALL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, id_stall} ;
          end
          STATION_VP_ID_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, id_kill} ;
          end
          STATION_VP_ID_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, id_valid} ;
          end
          STATION_VP_ID_READY_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, id_ready} ;
          end
          STATION_VP_EX_STALL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex_stall} ;
          end
          STATION_VP_EX_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex_kill} ;
          end
          STATION_VP_EX_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex_valid} ;
          end
          STATION_VP_EX_READY_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex_ready} ;
          end
          STATION_VP_MA_STALL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ma_stall} ;
          end
          STATION_VP_MA_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ma_kill} ;
          end
          STATION_VP_MA_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ma_valid} ;
          end
          STATION_VP_MA_READY_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ma_ready} ;
          end
          STATION_VP_WB_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, wb_valid} ;
          end
          STATION_VP_WB_READY_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, wb_ready} ;
          end
          STATION_VP_IF_AMO_ST_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-$bits(amo_fsm_t)){1'b0}}, if2da.if_amo_st};
          end
          STATION_VP_IF_STALL_CONDITIONS_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if2da.wait_for_branch};
          end
          STATION_VP_ID_STALL_CONDITIONS_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-4){1'b0}}, id2da.id_wait_for_reg, 1'b0, id2da.wait_for_fence, 1'b0};
          end
          STATION_VP_EX_STALL_CONDITIONS_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-5){1'b0}}, ex2da.wait_for_reg, ex2da.wait_for_mul, ex2da.wait_for_div, ex2da.wait_for_fp, ex2da.hold_ex2if_kill};
          end
          STATION_VP_MA_STALL_CONDITIONS_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-2){1'b0}}, ma2da.cs2ma_stall, ma2da.wait_for_dc} ;
          end
          STATION_VP_CS2IF_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, cs2if_kill} ;
          end
          STATION_VP_CS2ID_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, cs2id_kill} ;
          end
          STATION_VP_CS2EX_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, cs2ex_kill} ;
          end
          STATION_VP_CS2MA_KILL_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, cs2ma_kill} ;
          end
          STATION_VP_WFE_STALL_OFFSET : begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, wfe_stall} ;
          end
          STATION_VP_WFI_STALL_OFFSET : begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, wfi_stall} ;
          end
          STATION_VP_MA2IF_NPC_VALID_OFFSET : begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ma2if_npc_valid} ;
          end
          STATION_VP_EX2IF_KILL_OFFSET : begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex2if_kill} ;
          end
          STATION_VP_EX2ID_KILL_OFFSET : begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex2id_kill} ;
          end
          STATION_VP_BRANCH_SOLVED_OFFSET : begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, branch_solved} ;
          end
          STATION_VP_IF2ID_EXCP_CAUSE_OFFSET: begin
            next_rdata = {{28{1'b0}}, if2id_excp_ff.cause} ;
          end
          STATION_VP_ID2EX_EXCP_CAUSE_OFFSET: begin
            next_rdata = {{28{1'b0}}, id2ex_excp_ff.cause} ;
          end
          STATION_VP_EX2MA_EXCP_CAUSE_OFFSET: begin
            next_rdata = {{28{1'b0}}, ex2ma_excp_ff.cause} ;
          end
          STATION_VP_MA2CS_EXCP_CAUSE_OFFSET: begin
            next_rdata = {{28{1'b0}}, ma2cs_excp.cause} ;
          end
          STATION_VP_IF2ID_EXCP_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if2id_excp_ff.valid} ;
          end
          STATION_VP_ID2EX_EXCP_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, id2ex_excp_ff.valid} ;
          end
          STATION_VP_EX2MA_EXCP_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ex2ma_excp_ff.valid} ;
          end
          STATION_VP_MA2CS_EXCP_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ma2cs_excp.valid} ;
          end
          STATION_VP_IF2IC_EN_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, if2ic.en} ;
          end
          STATION_VP_IF2IC_VPC_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VIR_ADDR_WIDTH){1'b0}}, if2ic.pc} ;
          end
          STATION_VP_IC2IF_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ic2if.valid};
          end
          STATION_VP_IC2IF_INST_OFFSET: begin
            next_rdata = ic2if.inst;
          end
          STATION_VP_IC2IF_EXCP_VALID_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ic2if.excp_valid};
          end
          STATION_VP_IC2IF_EXCP_CAUSE_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_excp_cause_t)){1'b0}}, ic2if.excp_cause};
          end
          STATION_VP_IC2IF_IS_RVC_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ic2if.is_rvc};
          end
          STATION_VP_MCYCLE_OFFSET: begin
            next_rdata = {8'h00, cs2da.mcycle} ;
          end
          STATION_VP_MINSTRET_OFFSET: begin
            next_rdata = {8'h00, cs2da.minstret} ;
          end
          STATION_VP_MSTATUS_OFFSET: begin
            next_rdata = cs2da.mstatus ;
          end
          STATION_VP_MCAUSE_OFFSET: begin
            next_rdata = cs2da.mcause ;
          end
          STATION_VP_MEPC_OFFSET: begin
            next_rdata = cs2da.mepc ;
          end
          STATION_VP_MISA_OFFSET: begin
            next_rdata = cs2da.misa;
          end
          STATION_VP_MIP_OFFSET: begin
            next_rdata = cs2da.mip;
          end
          STATION_VP_MIE_OFFSET: begin
            next_rdata = cs2da.mie;
          end
          STATION_VP_MEDELEG_OFFSET: begin
            next_rdata = cs2da.medeleg;
          end
          STATION_VP_MIDELEG_OFFSET: begin
            next_rdata = cs2da.mideleg;
          end
          STATION_VP_MTVEC_OFFSET: begin
            next_rdata = cs2da.mtvec;
          end
          STATION_VP_MTVAL_OFFSET: begin
            next_rdata = cs2da.mtval;
          end
          STATION_VP_SATP_OFFSET: begin
            next_rdata = cs2da.satp ;
          end
          STATION_VP_SEPC_OFFSET: begin
            next_rdata = cs2da.sepc ;
          end
          STATION_VP_SCAUSE_OFFSET: begin
            next_rdata = cs2da.scause ;
          end
          STATION_VP_SEDELEG_OFFSET: begin
            next_rdata = cs2da.sedeleg;
          end
          STATION_VP_SIDELEG_OFFSET: begin
            next_rdata = cs2da.sideleg;
          end
          STATION_VP_STVEC_OFFSET: begin
            next_rdata = cs2da.stvec;
          end
          STATION_VP_STVAL_OFFSET: begin
            next_rdata = cs2da.stval;
          end
          STATION_VP_UEPC_OFFSET: begin
            next_rdata = cs2da.uepc ;
          end
          STATION_VP_UCAUSE_OFFSET: begin
            next_rdata = cs2da.ucause ;
          end
          STATION_VP_UTVEC_OFFSET: begin
            next_rdata = cs2da.utvec;
          end
          STATION_VP_UTVAL_OFFSET: begin
            next_rdata = cs2da.utval;
          end
          STATION_VP_HPMCOUNTER_3_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter3} ;
          end
          STATION_VP_HPMCOUNTER_4_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter4} ;
          end
          STATION_VP_HPMCOUNTER_5_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter5} ;
          end
          STATION_VP_HPMCOUNTER_6_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter6} ;
          end
          STATION_VP_HPMCOUNTER_7_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter7} ;
          end
          STATION_VP_HPMCOUNTER_8_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter8} ;
          end
          STATION_VP_HPMCOUNTER_9_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter9} ;
          end
          STATION_VP_HPMCOUNTER_10_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter10} ;
          end
          STATION_VP_HPMCOUNTER_11_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter11} ;
          end
          STATION_VP_HPMCOUNTER_12_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter12} ;
          end
          STATION_VP_HPMCOUNTER_13_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter13} ;
          end
          STATION_VP_HPMCOUNTER_14_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter14} ;
          end
          STATION_VP_HPMCOUNTER_15_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter15} ;
          end
          STATION_VP_HPMCOUNTER_16_OFFSET: begin
            next_rdata = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, cs2da.hpmcounter16} ;
          end
          STATION_VP_WB_PC_OFFSET: begin
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VIR_ADDR_WIDTH){1'b0}}, wb_pc};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_0: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_1: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_2: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_3: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_4: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_5: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_6: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VALID_OFFSET__DEPTH_7: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, itlb2da.tlb_valid};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_0: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_1: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_2: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_3: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_4: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_5: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_6: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_VPN_OFFSET__DEPTH_7: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, itlb2da.tlb_vpn};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_0: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_1: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_2: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_3: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_4: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_5: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_6: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_ASID_OFFSET__DEPTH_7: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, itlb2da.tlb_asid};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_0: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_1: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_2: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_3: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_4: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_5: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_6: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_ITLB_PTE_OFFSET__DEPTH_7: begin
            da2itlb.en = '1;
            da2itlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, itlb2da.tlb_pte};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_0: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_1: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_2: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_3: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_4: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_5: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_6: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VALID_OFFSET__DEPTH_7: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, dtlb2da.tlb_valid};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_0: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_1: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_2: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_3: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_4: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_5: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_6: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_VPN_OFFSET__DEPTH_7: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_VPN_WIDTH){1'b0}}, dtlb2da.tlb_vpn};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_0: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_1: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_2: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_3: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_4: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_5: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_6: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_ASID_OFFSET__DEPTH_7: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-ORV64_ASID_WIDTH){1'b0}}, dtlb2da.tlb_asid};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_0: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h0;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_1: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h1;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_2: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h2;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_3: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h3;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_4: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h4;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_5: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h5;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_6: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h6;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end
          STATION_VP_DTLB_PTE_OFFSET__DEPTH_7: begin
            da2dtlb.en = '1;
            da2dtlb.idx = 3'h7;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_pte_t)){1'b0}}, dtlb2da.tlb_pte};
          end

          STATION_VP_IBUF_LINE_PADDR_OFFSET__DEPTH_0: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b0;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_paddr_t)){1'b0}}, ib2da.line_paddr};
          end
          STATION_VP_IBUF_LINE_PADDR_OFFSET__DEPTH_1: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b1;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_paddr_t)){1'b0}}, ib2da.line_paddr};
          end
          STATION_VP_IBUF_LINE_EXCP_VALID_OFFSET__DEPTH_0: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b0;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ib2da.line_excp_valid};
          end
          STATION_VP_IBUF_LINE_EXCP_VALID_OFFSET__DEPTH_1: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b1;
            next_rdata = {{(RING_DATA_WIDTH-1){1'b0}}, ib2da.line_excp_valid};
          end
          STATION_VP_IBUF_LINE_EXCP_CAUSE_OFFSET__DEPTH_0: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b0;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_excp_cause_t)){1'b0}}, ib2da.line_excp_cause};
          end
          STATION_VP_IBUF_LINE_EXCP_CAUSE_OFFSET__DEPTH_1: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b1;
            next_rdata = {{(RING_DATA_WIDTH-$bits(orv64_excp_cause_t)){1'b0}}, ib2da.line_excp_cause};
          end
          STATION_VP_IBUF_CNT_OFFSET: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b0;
            next_rdata = {{(RING_DATA_WIDTH-5){1'b0}}, ib2da.buf_cnt};
          end
          STATION_VP_IBUF_RPTR_OFFSET: begin
            da2ib.en = '1;
            da2ib.line_idx = 1'b0;
            next_rdata = {{(RING_DATA_WIDTH-5){1'b0}}, ib2da.rd_ptr};
          end
          default: begin
            next_rdata = '0;
            next_rresp = AXI_RESP_DECERR;
          end
        endcase
      end
    end
  end // }}}

  assign da_write_to_hash = (rff_state == ST_WR_REQ) & is_hash_req;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_hash <= '0;
    end else begin
      if (da_write_to_hash) begin
        rff_hash <= dff_wr_data;
      end else if (update_hash) begin
        rff_hash <= next_hash;
      end
    end
  end



endmodule
