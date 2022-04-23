
module dmanoc2oursring
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  (
    output  logic                 awvalid,
    output  oursring_req_if_aw_t  aw,
    input   logic                 awready,

    output  logic                 wvalid,
    output  oursring_req_if_w_t   w,
    input   logic                 wready,

    input   logic                 bvalid,
    input   oursring_resp_if_b_t  b,
    output  logic                 bready,

    output  logic                 arvalid,
    output  oursring_req_if_ar_t  ar,
    input   logic                 arready,

    input   logic                 rvalid,
    input   oursring_resp_if_r_t  r,
    output  logic                 rready,

    input   logic     req_valid,
    input   dma_req_t req,
    output  logic     req_ready,

    output  logic     rsp_valid,
    output  dma_rsp_t rsp,
    input   logic     rsp_ready,

    input   logic     clk,
    input   logic     rstn
    );

  // REQUEST

  logic                 aw_buf_slave_valid;
  oursring_req_if_aw_t  aw_buf_slave_info;
  logic                 aw_buf_slave_ready;
  logic                 aw_buf_master_valid;
  oursring_req_if_aw_t  aw_buf_master_info;
  logic                 aw_buf_master_ready;

  logic                 w_buf_slave_valid;
  oursring_req_if_w_t   w_buf_slave_info;
  logic                 w_buf_slave_ready;
  logic                 w_buf_master_valid;
  oursring_req_if_w_t   w_buf_master_info;
  logic                 w_buf_master_ready;

  logic                 ar_buf_slave_valid;
  oursring_req_if_ar_t  ar_buf_slave_info;
  logic                 ar_buf_slave_ready;
  logic                 ar_buf_master_valid;
  oursring_req_if_ar_t  ar_buf_master_info;
  logic                 ar_buf_master_ready;

  assign aw_buf_slave_valid       = req_valid & (aw_buf_slave_ready & w_buf_slave_ready) & (req.req_type == REQ_WRITE);
  assign aw_buf_slave_info.awid   = {5'b0, req.tid}; // TODO: Hardcode value
  assign aw_buf_slave_info.awaddr = req.addr;
  assign w_buf_slave_valid        = req_valid & (aw_buf_slave_ready & w_buf_slave_ready) & (req.req_type == REQ_WRITE);
  assign w_buf_slave_info.wdata   = req.wdata;
  assign w_buf_slave_info.wstrb   = req.mask; // TODO: Fix lint
  assign w_buf_slave_info.wlast   = 1'b1;
  assign ar_buf_slave_valid       = req_valid & ar_buf_slave_ready & (req.req_type == REQ_READ);
  assign ar_buf_slave_info.arid   = {5'b0, req.tid}; // TODO: Hardcode value
  assign ar_buf_slave_info.araddr = req.addr;

  always_comb begin
    if (req_valid) begin
      req_ready = (req.req_type == REQ_WRITE) ? (aw_buf_slave_ready & w_buf_slave_ready): ar_buf_slave_ready;
    end else begin
      req_ready = '0;
    end 
  end

  ours_vld_rdy_buf #(
    .WIDTH($bits(oursring_req_if_aw_t)),
    .DEPTH(2),
    .RSTN_EN(0),
    .RSTN_WIDTH(0),
    .RSTN_LSB(0)
  ) aw_buf_u (
    .slave_valid  (aw_buf_slave_valid),
    .slave_info   (aw_buf_slave_info),
    .slave_ready  (aw_buf_slave_ready),
    .master_valid (aw_buf_master_valid),
    .master_info  (aw_buf_master_info),
    .master_ready (aw_buf_master_ready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  ours_vld_rdy_buf #(
    .WIDTH($bits(oursring_req_if_w_t)),
    .DEPTH(2),
    .RSTN_EN(0),
    .RSTN_WIDTH(0),
    .RSTN_LSB(0)
  ) w_buf_u (
    .slave_valid  (w_buf_slave_valid),
    .slave_info   (w_buf_slave_info),
    .slave_ready  (w_buf_slave_ready),
    .master_valid (w_buf_master_valid),
    .master_info  (w_buf_master_info),
    .master_ready (w_buf_master_ready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  ours_vld_rdy_buf #(
    .WIDTH($bits(oursring_req_if_ar_t)),
    .DEPTH(2),
    .RSTN_EN(0),
    .RSTN_WIDTH(0),
    .RSTN_LSB(0)
  ) ar_buf_u (
    .slave_valid  (ar_buf_slave_valid),
    .slave_info   (ar_buf_slave_info),
    .slave_ready  (ar_buf_slave_ready),
    .master_valid (ar_buf_master_valid),
    .master_info  (ar_buf_master_info),
    .master_ready (ar_buf_master_ready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  assign awvalid              = aw_buf_master_valid;
  assign aw                   = aw_buf_master_info;
  assign aw_buf_master_ready  = awready;

  assign wvalid               = w_buf_master_valid;
  assign w                    = w_buf_master_info;
  assign w_buf_master_ready   = wready;

  assign arvalid              = ar_buf_master_valid;
  assign ar                   = ar_buf_master_info;
  assign ar_buf_master_ready  = arready;


  // RESPONSE
  // 0 - r
  // 1 - b
  logic                 [1:0] r_b_buf_slave_valid;
  oursring_resp_if_r_t  [1:0] r_b_buf_slave_info;
  logic                 [1:0] r_b_buf_slave_ready;
  logic                       r_b_buf_master_valid;
  oursring_resp_if_r_t        r_b_buf_master_info;
  logic                       r_b_buf_master_ready;

  assign r_b_buf_slave_valid[0] = rvalid;
  assign r_b_buf_slave_info [0] = r;
  assign rready                 = r_b_buf_slave_ready[0];

  assign r_b_buf_slave_valid[1]       = bvalid;
  assign r_b_buf_slave_info[1].rid    = b.bid;
  assign r_b_buf_slave_info[1].rdata  = 64'b0; // TODO: remove hardcode
  assign r_b_buf_slave_info[1].rresp  = b.bresp;
  assign r_b_buf_slave_info[1].rlast  = 1'b0; // use rlast as is_wr_rsp
  assign bready                       = r_b_buf_slave_ready[1];

  ours_vld_rdy_rr_arb_buf #(
    .N_INPUT      (2),
    .WIDTH        ($bits(oursring_resp_if_r_t)),
    .BUF_IN_DEPTH (2),
    .BUF_OUT_DEPTH(2)
  ) r_b_arb_u (
    .slave_valid  (r_b_buf_slave_valid),
    .slave_info   (r_b_buf_slave_info),
    .slave_ready  (r_b_buf_slave_ready),
    .master_valid (r_b_buf_master_valid),
    .master_info  (r_b_buf_master_info),
    .master_ready (r_b_buf_master_ready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
    );

  assign rsp_valid          = r_b_buf_master_valid;
  assign rsp.tid            = r_b_buf_master_info.rid[6:0]; // TODO: remove hardcode
  assign rsp.rdata          = r_b_buf_master_info.rdata;
  assign rsp.is_wr_rsp      = ~r_b_buf_master_info.rlast; // use rlast as is_wr_rsp
  assign r_b_buf_master_ready = rsp_ready;

endmodule

