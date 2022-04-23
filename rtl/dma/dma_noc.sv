module dma_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  # (
    parameter BUF_IN_DEPTH        = 1,
    parameter BUF_OUT_DEPTH       = 1,
    parameter DMA_THREAD_REQ_CNT  = 10,
    parameter DMA_THREAD_RSP_CNT  = 6,
    parameter DMA_NOC_PORT_CNT    = 2
  )
  (
    input   logic        dma_thread_req_valid   [DMA_THREAD_REQ_CNT],
    output  logic        dma_thread_req_ready   [DMA_THREAD_REQ_CNT],
    input   dma_req_t    dma_thread_req         [DMA_THREAD_REQ_CNT],

    output  logic        dma_thread_resp_valid  [DMA_THREAD_RSP_CNT],
    input   logic        dma_thread_resp_ready  [DMA_THREAD_RSP_CNT],
    output  dma_rsp_t    dma_thread_resp        [DMA_THREAD_RSP_CNT],

    output  logic        dma_noc_req_valid      [DMA_NOC_PORT_CNT],
    input   logic        dma_noc_req_ready      [DMA_NOC_PORT_CNT],
    output  dma_req_t    dma_noc_req            [DMA_NOC_PORT_CNT],

    input   logic        dma_noc_resp_valid     [DMA_NOC_PORT_CNT],
    output  logic        dma_noc_resp_ready     [DMA_NOC_PORT_CNT],
    input   dma_rsp_t    dma_noc_resp           [DMA_NOC_PORT_CNT],

    input   logic        clk,
    input   logic        rstn

    );

  // REQUEST
  // Request Buffer
  logic      [DMA_THREAD_REQ_CNT-1:0] dma_thread_req_valid_buf_o;
  dma_req_t  [DMA_THREAD_REQ_CNT-1:0] dma_thread_req_info_buf_o ;
  logic      [DMA_THREAD_REQ_CNT-1:0] dma_thread_req_ready_buf_o;

  generate
    for (genvar i = 0; i < DMA_THREAD_REQ_CNT; i++) begin : REQ_IN_BUFFER
      ours_vld_rdy_buf #(.WIDTH($bits(dma_req_t)), .DEPTH(BUF_IN_DEPTH)) req_buf_u (
        .slave_valid  (dma_thread_req_valid[i]),
        .slave_info   (dma_thread_req[i]),
        .slave_ready  (dma_thread_req_ready[i]),
        .master_valid (dma_thread_req_valid_buf_o[i]),
        .master_info  (dma_thread_req_info_buf_o[i]),
        .master_ready (dma_thread_req_ready_buf_o[i]),
        .clk_en       (),
        .rstn         (rstn),
        .clk          (clk));
    end
  endgenerate

  logic      [DMA_THREAD_REQ_CNT-1:0] req_valid_arb_i[DMA_NOC_PORT_CNT];
  dma_req_t  [DMA_THREAD_REQ_CNT-1:0] req_info_arb_i [DMA_NOC_PORT_CNT];
  logic      [DMA_THREAD_REQ_CNT-1:0] req_ready_arb_i[DMA_NOC_PORT_CNT];

  generate
    for (genvar i = 0; i < DMA_NOC_PORT_CNT; i++) begin : REQ_ARB_I_DMA_NOC_PORT_CNT
      for (genvar j = 0; j < DMA_THREAD_REQ_CNT; j++) begin : REQ_ARB_I_DMA_THREAD_CNT
        assign req_valid_arb_i[i][j] = dma_thread_req_valid_buf_o[j] & (dma_thread_req_info_buf_o[j].addr[31] == i);
        assign req_info_arb_i[i][j]  = dma_thread_req_info_buf_o[j];
      end
    end
    for (genvar i = 0; i < DMA_THREAD_REQ_CNT; i++) begin : REQ_RDY_ARB_I_DMA_THREAD_CNT
      logic [DMA_NOC_PORT_CNT-1:0] req_ready_arb_i_tmp;
      for (genvar j = 0; j < DMA_NOC_PORT_CNT; j++) begin
        assign req_ready_arb_i_tmp[j] = req_ready_arb_i[j][i];
      end
      assign dma_thread_req_ready_buf_o[i] = |req_ready_arb_i_tmp;
    end
  endgenerate

  generate
    for (genvar i = 0; i < DMA_NOC_PORT_CNT; i++) begin : MULTI_LYR_REQ_ARBITOR
      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT        (DMA_THREAD_REQ_CNT),
        .WIDTH          ($bits(dma_req_t)),
        .BUF_IN_DEPTH   (0),
        .BUF_OUT_DEPTH  (BUF_OUT_DEPTH),
        .BUF_MID_DEPTH  (2),
        .ARB_MAX_N_PORT (4)
      ) dma_noc_req_arb_u (
        .slave_valid    (req_valid_arb_i[i]),
        .slave_info     (req_info_arb_i[i]),
        .slave_ready    (req_ready_arb_i[i]),
        .master_valid   (dma_noc_req_valid[i]),
        .master_info    (dma_noc_req[i]),
        .master_ready   (dma_noc_req_ready[i]),
        .clk_en         (),
        .rstn           (rstn),
        .clk            (clk));
    end : MULTI_LYR_REQ_ARBITOR
  endgenerate

  // RESPONSE
  // Response Buffer
  logic     [DMA_NOC_PORT_CNT-1:0] dma_noc_resp_valid_buf_o;
  dma_rsp_t [DMA_NOC_PORT_CNT-1:0] dma_noc_resp_info_buf_o ;
  logic     [DMA_NOC_PORT_CNT-1:0] dma_noc_resp_ready_buf_o;

  generate
    for (genvar i = 0; i < DMA_NOC_PORT_CNT; i++) begin : RESP_IN_BUFFER
      ours_vld_rdy_buf #(.WIDTH($bits(dma_rsp_t)), .DEPTH(BUF_IN_DEPTH)) resp_buf_u (
        .slave_valid  (dma_noc_resp_valid[i]),
        .slave_info   (dma_noc_resp[i]),
        .slave_ready  (dma_noc_resp_ready[i]),
        .master_valid (dma_noc_resp_valid_buf_o[i]),
        .master_info  (dma_noc_resp_info_buf_o[i]),
        .master_ready (dma_noc_resp_ready_buf_o[i]),
        .clk_en       (),
        .rstn         (rstn),
        .clk          (clk));
    end
  endgenerate

  logic     [DMA_NOC_PORT_CNT-1:0] rsp_valid_arb_i[DMA_THREAD_RSP_CNT];
  dma_rsp_t [DMA_NOC_PORT_CNT-1:0] rsp_info_arb_i [DMA_THREAD_RSP_CNT];
  logic     [DMA_NOC_PORT_CNT-1:0] rsp_ready_arb_i[DMA_THREAD_RSP_CNT];

  generate
    for (genvar i = 0; i < DMA_THREAD_RSP_CNT; i++) begin : RSP_ARB_I_DMA_THREAD_CNT
      for (genvar j = 0; j < DMA_NOC_PORT_CNT; j++) begin : RSP_ARB_I_DMA_NOC_PORT_CNT
        assign rsp_valid_arb_i[i][j] = dma_noc_resp_valid_buf_o[j] & (dma_noc_resp_info_buf_o[j].tid[6:4] == i);
        assign rsp_info_arb_i[i][j]  = dma_noc_resp_info_buf_o[j];
      end
    end
    for (genvar i = 0; i < DMA_NOC_PORT_CNT; i++) begin : RSP_RDY_ARB_I_DMA_NOC_PORT_CNT
      logic [DMA_THREAD_RSP_CNT-1:0] rsp_ready_arb_i_tmp;
      for (genvar j = 0; j < DMA_THREAD_RSP_CNT; j++) begin
        assign rsp_ready_arb_i_tmp[j] = rsp_ready_arb_i[j][i];
      end
      assign dma_noc_resp_ready_buf_o[i] = |rsp_ready_arb_i_tmp;
    end
  endgenerate

  generate
    for (genvar i = 0; i < DMA_THREAD_RSP_CNT; i++) begin : MULTI_LYR_RSP_ARBITOR
      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT        (DMA_NOC_PORT_CNT),
        .WIDTH          ($bits(dma_rsp_t)),
        .BUF_IN_DEPTH   (0),
        .BUF_OUT_DEPTH  (BUF_OUT_DEPTH),
        .BUF_MID_DEPTH  (2),
        .ARB_MAX_N_PORT (4)
      ) dma_noc_rsp_arb_u (
        .slave_valid    (rsp_valid_arb_i[i]),
        .slave_info     (rsp_info_arb_i[i]),
        .slave_ready    (rsp_ready_arb_i[i]),
        .master_valid   (dma_thread_resp_valid[i]),
        .master_info    (dma_thread_resp[i]),
        .master_ready   (dma_thread_resp_ready[i]),
        .clk_en         (),
        .rstn           (rstn),
        .clk            (clk));
    end : MULTI_LYR_RSP_ARBITOR
  endgenerate

endmodule

