module dma
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_dma_pkg::*;
  #(
    parameter N_DMA_THREAD    = 4
  ) (
    input  clk,
    input  rstn,

    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_src_addr,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_dst_addr,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_cbuf_size,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_cbuf_thold,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 station_out_dma_thread_cbuf_rp_addr,
    output ring_addr_t [N_DMA_THREAD - 1 : 0]                 station_in_dma_thread_cbuf_rp_addr,
    output logic       [N_DMA_THREAD - 1 : 0]                 station_vld_in_dma_thread_cbuf_rp_addr,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 station_out_dma_thread_cbuf_wp_addr,
    output ring_addr_t [N_DMA_THREAD - 1 : 0]                 station_in_dma_thread_cbuf_wp_addr,
    output logic       [N_DMA_THREAD - 1 : 0]                 station_vld_in_dma_thread_cbuf_wp_addr,
    input  logic       [N_DMA_THREAD - 1 : 0]                 cbuf_mode_data_avail,
    input  logic       [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_cbuf_mode,
    input  ring_data_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_length_in_bytes,
    input  dma_thread_align_t   [N_DMA_THREAD - 1 : 0]        s2b_dma_thread_use_8b_align,
    input  dma_thread_rpt_cnt_t [N_DMA_THREAD - 1 : 0]        s2b_dma_thread_rpt_cnt_less_1,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_gather_grpdepth,
    input  ring_addr_t [N_DMA_THREAD - 1 : 0]                 s2b_dma_thread_gather_stride,
    input  dma_thread_cmd_vld_t [N_DMA_THREAD - 1 : 0]        dma_thread_cmd_vld,
    output dma_thread_cmd_vld_t [N_DMA_THREAD - 1 : 0]        dma_thread_cmd_vld_wdata, 

    input  ring_addr_t                                        s2b_dma_flush_addr,
    input  dma_flush_type_t                                   s2b_dma_flush_req_type,
    input                                                     dma_flush_cmd_vld,
    output                                                    dma_flush_cmd_vld_wdata, 

    //oursring_req_if.master   req_if,
    output logic                o_req_if_awvalid,
    output logic                o_req_if_wvalid,
    output logic                o_req_if_arvalid,
    output oursring_req_if_ar_t o_req_if_ar,
    output oursring_req_if_aw_t o_req_if_aw,
    output oursring_req_if_w_t  o_req_if_w,
    input  logic                o_req_if_arready,
    input  logic                o_req_if_wready,
    input  logic                o_req_if_awready,

    //oursring_resp_if.slave rsp_if,
    input  logic                i_rsp_if_rvalid,
    input  logic                i_rsp_if_bvalid,
    input  oursring_resp_if_r_t i_rsp_if_r,
    input  oursring_resp_if_b_t i_rsp_if_b,
    output logic                i_rsp_if_rready,
    output logic                i_rsp_if_bready,

    //oursring_req_if.slave   req_if,
    input  logic                i_req_if_arvalid,
    output logic                i_req_if_arready,
    input  oursring_req_if_ar_t i_req_if_ar,
    input  logic                i_req_if_awvalid,
    output logic                i_req_if_awready,
    input  oursring_req_if_aw_t i_req_if_aw,
    input  logic                i_req_if_wvalid,
    output logic                i_req_if_wready,
    input  oursring_req_if_w_t  i_req_if_w,

    //oursring_resp_if.master rsp_if,
    output logic                o_rsp_if_rvalid,
    input  logic                o_rsp_if_rready,
    output oursring_resp_if_r_t o_rsp_if_r,
    output logic                o_rsp_if_bvalid,
    input  logic                o_rsp_if_bready,
    output oursring_resp_if_b_t o_rsp_if_b,

    //cpu_cache_if.master     cpu_cache_if,
    output logic               cpu_cache_req_if_req_valid,
    output cpu_cache_if_req_t  cpu_cache_req_if_req,
    input  logic               cpu_cache_req_if_req_ready,
    input  logic               cpu_cache_resp_if_resp_valid,
    input  cpu_cache_if_resp_t cpu_cache_resp_if_resp,
    output logic               cpu_cache_resp_if_resp_ready,

    output logic  [N_DMA_THREAD - 1 : 0]  dma_intr,
    output logic  [N_DMA_THREAD - 1 : 0]  b2s_dma_thread_idle,
    input  logic  [N_DMA_THREAD - 1 : 0]  station_out_dma_thread_cbuf_full_seen,
    output logic  [N_DMA_THREAD - 1 : 0]  station_vld_in_dma_thread_cbuf_full_seen,
    output logic  [N_DMA_THREAD - 1 : 0]  station_in_dma_thread_cbuf_full_seen
  );

  localparam DMA_THREAD_REQ_CNT = 2 * N_DMA_THREAD + 1 + 1;
  localparam DMA_THREAD_RSP_CNT = N_DMA_THREAD + 1 + 1;
  localparam DMA_NOC_PORT_CNT   = 2;

  logic        dma_thread_req_valid   [DMA_THREAD_REQ_CNT];
  logic        dma_thread_req_ready   [DMA_THREAD_REQ_CNT];
  dma_req_t    dma_thread_req         [DMA_THREAD_REQ_CNT];

  logic        dma_thread_resp_valid  [DMA_THREAD_RSP_CNT];
  logic        dma_thread_resp_ready  [DMA_THREAD_RSP_CNT];
  dma_rsp_t    dma_thread_resp        [DMA_THREAD_RSP_CNT];

  logic        dma_noc_req_valid      [DMA_NOC_PORT_CNT];
  logic        dma_noc_req_ready      [DMA_NOC_PORT_CNT];
  dma_req_t    dma_noc_req            [DMA_NOC_PORT_CNT];

  logic        dma_noc_resp_valid     [DMA_NOC_PORT_CNT];
  logic        dma_noc_resp_ready     [DMA_NOC_PORT_CNT];
  dma_rsp_t    dma_noc_resp           [DMA_NOC_PORT_CNT];

  logic  [N_DMA_THREAD-1:0] bar_vld;
  logic  [N_DMA_THREAD-1:0] bar_gnt;
  logic  [N_DMA_THREAD-1:0] bar_done;
  logic                     is_outstanding_barrier;

  assign station_in_dma_thread_cbuf_full_seen = station_vld_in_dma_thread_cbuf_full_seen;

  generate
    for (genvar i = 0; i < N_DMA_THREAD; i ++) begin : DMA_THREAD_LOOP
      dma_thread #(
        .DMA_MAX_LENGTH_IN_BYTES  (1024 * 1024),
        .THREAD_ID                (i)
      ) dma_thread_u (
        .s2b_dma_thread_src_addr        (s2b_dma_thread_src_addr[i]),
        .s2b_dma_thread_dst_addr        (s2b_dma_thread_dst_addr[i]),
        .s2b_dma_thread_cbuf_size       (s2b_dma_thread_cbuf_size[i]),
        .s2b_dma_thread_cbuf_thold      (s2b_dma_thread_cbuf_thold[i]),
        .s2b_dma_thread_cbuf_rp_addr    (station_out_dma_thread_cbuf_rp_addr[i]),
        .b2s_dma_thread_cbuf_rp_addr    (station_in_dma_thread_cbuf_rp_addr[i]),
        .b2s_dma_thread_cbuf_rp_update  (station_vld_in_dma_thread_cbuf_rp_addr[i]),
        .s2b_dma_thread_cbuf_wp_addr    (station_out_dma_thread_cbuf_wp_addr[i]),
        .b2s_dma_thread_cbuf_wp_addr    (station_in_dma_thread_cbuf_wp_addr[i]),
        .b2s_dma_thread_cbuf_wp_update  (station_vld_in_dma_thread_cbuf_wp_addr[i]),
        .cbuf_mode_data_avail           (cbuf_mode_data_avail[i]),
        .s2b_dma_thread_cbuf_mode       (s2b_dma_thread_cbuf_mode[i]),
        .s2b_dma_thread_length_in_bytes (s2b_dma_thread_length_in_bytes[i]),
        .s2b_dma_thread_use_8b_align    (s2b_dma_thread_use_8b_align[i]),
        .s2b_dma_thread_cmd_vld         (dma_thread_cmd_vld[i]),
        .s2b_dma_thread_rpt_cnt_less_1  (s2b_dma_thread_rpt_cnt_less_1[i]),
        .b2s_dma_thread_cmd_vld_wdata   (dma_thread_cmd_vld_wdata[i]),
        .s2b_dma_thread_gather_grpdepth (s2b_dma_thread_gather_grpdepth[i]),
        .s2b_dma_thread_gather_stride   (s2b_dma_thread_gather_stride[i]),
        .wr_req_vld                     (dma_thread_req_valid [i + DMA_THREAD_RSP_CNT]),
        .wr_req                         (dma_thread_req       [i + DMA_THREAD_RSP_CNT]),
        .wr_req_rdy                     (dma_thread_req_ready [i + DMA_THREAD_RSP_CNT]),
        .rd_req_vld                     (dma_thread_req_valid [i]),
        .rd_req                         (dma_thread_req       [i]),
        .rd_req_rdy                     (dma_thread_req_ready [i]),
        .rd_rsp_vld                     (dma_thread_resp_valid[i]),
        .rd_rsp                         (dma_thread_resp      [i]),
        .rd_rsp_rdy                     (dma_thread_resp_ready[i]),
        .bar_vld                        (bar_vld              [i]),
        .bar_gnt                        (bar_gnt              [i]),
        .bar_done                       (bar_done             [i]),
        .intr                           (dma_intr             [i]),
        .b2s_dma_thread_idle            (b2s_dma_thread_idle  [i]),
        .s2b_dma_thread_cbuf_full_seen  (station_out_dma_thread_cbuf_full_seen[i]),
        .b2s_dma_thread_cbuf_full_seen  (station_vld_in_dma_thread_cbuf_full_seen[i]),
        .clk                            (clk),
        .rstn                           (rstn)
        );
    end
  endgenerate

  dma_bar_arb #(
    .DMA_THREAD_CNT(N_DMA_THREAD)
  ) dma_bar_arb_u (
    .req(bar_vld),
    .gnt(bar_gnt),
    .done(bar_done),
    .is_outstanding_barrier,
    .clk, 
    .rstn
  );


  dma_dbg #(
    .THREAD_ID(0)
  ) dma_dbg_u (
    .ring_req_if_arvalid(i_req_if_arvalid),
    .ring_req_if_arready(i_req_if_arready),
    .ring_req_if_ar(i_req_if_ar),
    .ring_req_if_awvalid(i_req_if_awvalid),
    .ring_req_if_awready(i_req_if_awready),
    .ring_req_if_aw(i_req_if_aw),
    .ring_req_if_wvalid(i_req_if_wvalid),
    .ring_req_if_wready(i_req_if_wready),
    .ring_req_if_w(i_req_if_w),
    .ring_resp_if_rvalid(o_rsp_if_rvalid),
    .ring_resp_if_rready(o_rsp_if_rready),
    .ring_resp_if_r(o_rsp_if_r),
    .ring_resp_if_bvalid(o_rsp_if_bvalid),
    .ring_resp_if_bready(o_rsp_if_bready),
    .ring_resp_if_b(o_rsp_if_b),
    .dma_dbg_req_vld            (dma_thread_req_valid [N_DMA_THREAD]),
    .dma_dbg_req                (dma_thread_req       [N_DMA_THREAD]),
    .dma_dbg_req_rdy            (dma_thread_req_ready [N_DMA_THREAD]),
    .dma_dbg_rsp_vld            (dma_thread_resp_valid[N_DMA_THREAD]),
    .dma_dbg_rsp                (dma_thread_resp      [N_DMA_THREAD]),
    .dma_dbg_rsp_rdy            (dma_thread_resp_ready[N_DMA_THREAD]),
    .clk                    (clk),
    .rstn                   (rstn)
  );

  dma_flush #(
    .THREAD_ID(1)
  ) dma_flush_u (
    .s2b_dma_flush_addr(s2b_dma_flush_addr),
    .s2b_dma_flush_req_type(s2b_dma_flush_req_type),
    .s2b_dma_flush_cmd_vld(dma_flush_cmd_vld),
    .b2s_dma_flush_cmd_vld_wdata(dma_flush_cmd_vld_wdata),
    .dma_flush_req_vld           (dma_thread_req_valid [N_DMA_THREAD + 1]),
    .dma_flush_req               (dma_thread_req       [N_DMA_THREAD + 1]),
    .dma_flush_req_rdy           (dma_thread_req_ready [N_DMA_THREAD + 1]),
    .dma_flush_rsp_vld           (dma_thread_resp_valid[N_DMA_THREAD + 1]),
    .dma_flush_rsp               (dma_thread_resp      [N_DMA_THREAD + 1]),
    .dma_flush_rsp_rdy           (dma_thread_resp_ready[N_DMA_THREAD + 1]),
    .clk,
    .rstn
  );


  dma_noc #(
    .BUF_IN_DEPTH       (1),
    .BUF_OUT_DEPTH      (1),
    .DMA_THREAD_REQ_CNT (DMA_THREAD_REQ_CNT),
    .DMA_THREAD_RSP_CNT (DMA_THREAD_RSP_CNT),
    .DMA_NOC_PORT_CNT   (DMA_NOC_PORT_CNT)
  ) dma_noc_u (
    .dma_thread_req_valid   (dma_thread_req_valid),
    .dma_thread_req_ready   (dma_thread_req_ready),
    .dma_thread_req         (dma_thread_req),
    .dma_thread_resp_valid  (dma_thread_resp_valid),
    .dma_thread_resp_ready  (dma_thread_resp_ready),
    .dma_thread_resp        (dma_thread_resp),
    .dma_noc_req_valid      (dma_noc_req_valid),
    .dma_noc_req_ready      (dma_noc_req_ready),
    .dma_noc_req            (dma_noc_req),
    .dma_noc_resp_valid     (dma_noc_resp_valid),
    .dma_noc_resp_ready     (dma_noc_resp_ready),
    .dma_noc_resp           (dma_noc_resp),
    .clk                    (clk),
    .rstn                   (rstn)
    );

  dmanoc2oursring dmanoc2oursring_u (
    .awvalid    (o_req_if_awvalid),
    .aw         (o_req_if_aw),
    .awready    (o_req_if_awready),
    .wvalid     (o_req_if_wvalid),
    .w          (o_req_if_w),
    .wready     (o_req_if_wready),
    .bvalid     (i_rsp_if_bvalid),
    .b          (i_rsp_if_b),
    .bready     (i_rsp_if_bready),
    .arvalid    (o_req_if_arvalid),
    .ar         (o_req_if_ar),
    .arready    (o_req_if_arready),
    .rvalid     (i_rsp_if_rvalid),
    .r          (i_rsp_if_r),
    .rready     (i_rsp_if_rready),
    .req_valid  (dma_noc_req_valid[0]),
    .req        (dma_noc_req[0]),
    .req_ready  (dma_noc_req_ready[0]),
    .rsp_valid  (dma_noc_resp_valid[0]),
    .rsp        (dma_noc_resp[0]),
    .rsp_ready  (dma_noc_resp_ready[0]),
    .clk        (clk),
    .rstn       (rstn)
    );

  assign cpu_cache_req_if_req_valid     = dma_noc_req_valid[1];
  assign cpu_cache_req_if_req.req_paddr = dma_noc_req[1].addr;
  always_comb begin
    case (dma_noc_req[1].addr[4:3])
      2'b00: begin
        cpu_cache_req_if_req.req_mask   = {8'h0, 8'h0, 8'h0, dma_noc_req[1].mask};
        cpu_cache_req_if_req.req_data   = {64'h0, 64'h0, 64'h0, dma_noc_req[1].wdata};
      end
      2'b01: begin
        cpu_cache_req_if_req.req_mask   = {8'h0, 8'h0, dma_noc_req[1].mask, 8'h0};
        cpu_cache_req_if_req.req_data   = {64'h0, 64'h0, dma_noc_req[1].wdata, 64'h0};
      end
      2'b10: begin
        cpu_cache_req_if_req.req_mask   = {8'h0, dma_noc_req[1].mask, 8'h0, 8'h0};
        cpu_cache_req_if_req.req_data   = {64'h0, dma_noc_req[1].wdata, 64'h0, 64'h0};
      end
      default: begin
        cpu_cache_req_if_req.req_mask   = {dma_noc_req[1].mask, 8'h0, 8'h0, 8'h0};
        cpu_cache_req_if_req.req_data   = {dma_noc_req[1].wdata, 64'h0, 64'h0, 64'h0};
      end
    endcase
  end
  assign cpu_cache_req_if_req.req_tid   = {5'b0, dma_noc_req[1].tid};
  assign cpu_cache_req_if_req.req_type  = dma_noc_req[1].req_type;
  assign dma_noc_req_ready[1]           = cpu_cache_req_if_req_ready;

  assign dma_noc_resp_valid[1]          = cpu_cache_resp_if_resp_valid;
  assign dma_noc_resp[1].tid            = cpu_cache_resp_if_resp.resp_tid[6:0];
  assign dma_noc_resp[1].is_wr_rsp      = 1'b0;

  always_comb begin
    case (cpu_cache_resp_if_resp.resp_mask)
      32'hff: begin
        dma_noc_resp[1].rdata = cpu_cache_resp_if_resp.resp_data[63:0];
      end
      32'hff00: begin
        dma_noc_resp[1].rdata = cpu_cache_resp_if_resp.resp_data[127:64];
      end
      32'hff0000: begin
        dma_noc_resp[1].rdata = cpu_cache_resp_if_resp.resp_data[191:128];
      end
      default: begin
        dma_noc_resp[1].rdata = cpu_cache_resp_if_resp.resp_data[255:192];
      end
    endcase
  end
  assign cpu_cache_resp_if_resp_ready = dma_noc_resp_ready[1];

endmodule
