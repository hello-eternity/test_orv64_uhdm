
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_DT_PKG__SV
`define STATION_DT_PKG__SV
package station_dt_pkg;
  localparam int STATION_DT_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_DT_DATA_WIDTH = 'h40;
  localparam [STATION_DT_RING_ADDR_WIDTH-1:0] STATION_DT_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_DT_BLKID = 'h7;
  localparam int STATION_DT_BLKID_WIDTH = 'h4;
  localparam bit [25 - 1:0] STATION_DT_PRAM_ADDR_OFFSET = 64'h0;
  localparam int STATION_DT_PRAM_ADDR_WIDTH  = 8192;
  localparam bit [64 - 1:0] STATION_DT_PRAM_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_PRAM_ADDR_ADDR = 64'he00000;
  localparam bit [25 - 1:0] STATION_DT_PRAM_DATA_OFFSET = 64'h400;
  localparam int STATION_DT_PRAM_DATA_WIDTH  = 8192;
  localparam bit [64 - 1:0] STATION_DT_PRAM_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_PRAM_DATA_ADDR = 64'he00400;
  localparam bit [25 - 1:0] STATION_DT_ERAM_ADDR_OFFSET = 64'h800;
  localparam int STATION_DT_ERAM_ADDR_WIDTH  = 512;
  localparam bit [64 - 1:0] STATION_DT_ERAM_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_ERAM_ADDR_ADDR = 64'he00800;
  localparam bit [25 - 1:0] STATION_DT_ERAM_DATA_OFFSET = 64'h840;
  localparam int STATION_DT_ERAM_DATA_WIDTH  = 512;
  localparam bit [64 - 1:0] STATION_DT_ERAM_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_ERAM_DATA_ADDR = 64'he00840;
  localparam bit [25 - 1:0] STATION_DT_ACTIVATE_OFFSET = 64'h880;
  localparam int STATION_DT_ACTIVATE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_ACTIVATE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_ACTIVATE_ADDR = 64'he00880;
  localparam bit [25 - 1:0] STATION_DT_MODE_OFFSET = 64'h888;
  localparam int STATION_DT_MODE_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_MODE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_MODE_ADDR = 64'he00888;
  localparam bit [25 - 1:0] STATION_DT_ERR_CNT_OFFSET = 64'h890;
  localparam int STATION_DT_ERR_CNT_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_ERR_CNT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_ERR_CNT_ADDR = 64'he00890;
  localparam bit [25 - 1:0] STATION_DT_BUSY_OFFSET = 64'h898;
  localparam int STATION_DT_BUSY_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_BUSY_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_BUSY_ADDR = 64'he00898;
  localparam bit [25 - 1:0] STATION_DT_DBG_ADDR_OFFSET = 64'h8a0;
  localparam int STATION_DT_DBG_ADDR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_DBG_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_DBG_ADDR_ADDR = 64'he008a0;
  localparam bit [25 - 1:0] STATION_DT_DBG_DATA_OFFSET = 64'h8a8;
  localparam int STATION_DT_DBG_DATA_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_DBG_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_DBG_DATA_ADDR = 64'he008a8;
  localparam bit [25 - 1:0] STATION_DT_INIT_MSB_ADDR_OFFSET = 64'h8b0;
  localparam int STATION_DT_INIT_MSB_ADDR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_INIT_MSB_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_INIT_MSB_ADDR_ADDR = 64'he008b0;
  localparam bit [25 - 1:0] STATION_DT_INIT_MSB_DATA_OFFSET = 64'h8b8;
  localparam int STATION_DT_INIT_MSB_DATA_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_INIT_MSB_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_INIT_MSB_DATA_ADDR = 64'he008b8;
  localparam bit [25 - 1:0] STATION_DT_INIT_POLY_ADDR_OFFSET = 64'h8c0;
  localparam int STATION_DT_INIT_POLY_ADDR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_INIT_POLY_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_INIT_POLY_ADDR_ADDR = 64'he008c0;
  localparam bit [25 - 1:0] STATION_DT_INIT_POLY_DATA_OFFSET = 64'h8c8;
  localparam int STATION_DT_INIT_POLY_DATA_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_INIT_POLY_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_INIT_POLY_DATA_ADDR = 64'he008c8;
  localparam bit [25 - 1:0] STATION_DT_INIT_LFSR_ADDR_OFFSET = 64'h8d0;
  localparam int STATION_DT_INIT_LFSR_ADDR_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_INIT_LFSR_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_INIT_LFSR_ADDR_ADDR = 64'he008d0;
  localparam bit [25 - 1:0] STATION_DT_INIT_LFSR_DATA_OFFSET = 64'h8d8;
  localparam int STATION_DT_INIT_LFSR_DATA_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_DT_INIT_LFSR_DATA_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_DT_INIT_LFSR_DATA_ADDR = 64'he008d8;
  localparam bit [25 - 1:0] STATION_DT_S2ICG_CLK_EN_OFFSET = 64'h8e0;
  localparam int STATION_DT_S2ICG_CLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_DT_S2ICG_CLK_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_DT_S2ICG_CLK_EN_ADDR = 64'he008e0;
endpackage
`endif
`ifndef STATION_DT__SV
`define STATION_DT__SV
module station_dt
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_dt_pkg::*;
  (
  output out_s2icg_clk_en,
  input  logic                clk,
  input  logic                rstn,
  // i_req_ring_if & o_resp_ring_if
  output oursring_resp_if_b_t o_resp_ring_if_b,
  output oursring_resp_if_r_t o_resp_ring_if_r,
  output                      o_resp_ring_if_rvalid,
  input                       o_resp_ring_if_rready,
  output                      o_resp_ring_if_bvalid,
  input                       o_resp_ring_if_bready,
  input                       i_req_ring_if_awvalid,
  input                       i_req_ring_if_wvalid,
  input                       i_req_ring_if_arvalid,
  input  oursring_req_if_ar_t i_req_ring_if_ar,
  input  oursring_req_if_aw_t i_req_ring_if_aw,
  input  oursring_req_if_w_t  i_req_ring_if_w,
  output                      i_req_ring_if_arready,
  output                      i_req_ring_if_wready,
  output                      i_req_ring_if_awready,
  // o_req_ring_if & i_resp_ring_if
  input  oursring_resp_if_b_t i_resp_ring_if_b,
  input  oursring_resp_if_r_t i_resp_ring_if_r,
  input                       i_resp_ring_if_rvalid,
  output                      i_resp_ring_if_rready,
  input                       i_resp_ring_if_bvalid,
  output                      i_resp_ring_if_bready,
  output                      o_req_ring_if_awvalid,
  output                      o_req_ring_if_wvalid,
  output                      o_req_ring_if_arvalid,
  output oursring_req_if_ar_t o_req_ring_if_ar,
  output oursring_req_if_aw_t o_req_ring_if_aw,
  output oursring_req_if_w_t  o_req_ring_if_w,
  input                       o_req_ring_if_arready,
  input                       o_req_ring_if_wready,
  input                       o_req_ring_if_awready,
  // i_req_local_if & o_resp_local_if
  output oursring_resp_if_b_t o_resp_local_if_b,
  output oursring_resp_if_r_t o_resp_local_if_r,
  output                      o_resp_local_if_rvalid,
  input                       o_resp_local_if_rready,
  output                      o_resp_local_if_bvalid,
  input                       o_resp_local_if_bready,
  input                       i_req_local_if_awvalid,
  input                       i_req_local_if_wvalid,
  input                       i_req_local_if_arvalid,
  input  oursring_req_if_ar_t i_req_local_if_ar,
  input  oursring_req_if_aw_t i_req_local_if_aw,
  input  oursring_req_if_w_t  i_req_local_if_w,
  output                      i_req_local_if_arready,
  output                      i_req_local_if_wready,
  output                      i_req_local_if_awready,
  // o_req_local_if & i_resp_local_if
  input  oursring_resp_if_b_t i_resp_local_if_b,
  input  oursring_resp_if_r_t i_resp_local_if_r,
  input                       i_resp_local_if_rvalid,
  output                      i_resp_local_if_rready,
  input                       i_resp_local_if_bvalid,
  output                      i_resp_local_if_bready,
  output                      o_req_local_if_awvalid,
  output                      o_req_local_if_wvalid,
  output                      o_req_local_if_arvalid,
  output oursring_req_if_ar_t o_req_local_if_ar,
  output oursring_req_if_aw_t o_req_local_if_aw,
  output oursring_req_if_w_t  o_req_local_if_w,
  input                       o_req_local_if_arready,
  input                       o_req_local_if_wready,
  input                       o_req_local_if_awready
);
  localparam int                                STATION_ID_WIDTH_0 = STATION_DT_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_DT_BLKID;

  oursring_resp_if_b_t      station2brb_rsp_b;
  oursring_resp_if_r_t      station2brb_rsp_r;
  logic                     station2brb_rsp_rvalid;
  logic                     station2brb_rsp_rready;
  logic                     station2brb_rsp_bvalid;
  logic                     station2brb_rsp_bready;
  logic                     station2brb_req_awvalid;
  logic                     station2brb_req_wvalid;
  logic                     station2brb_req_arvalid;
  oursring_req_if_ar_t      station2brb_req_ar;
  oursring_req_if_aw_t      station2brb_req_aw;
  oursring_req_if_w_t       station2brb_req_w;
  logic                     station2brb_req_arready;
  logic                     station2brb_req_wready;
  logic                     station2brb_req_awready;

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_DT_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_DT_MAX_RING_ADDR)) station_u (

    .i_req_local_if_ar      (i_req_local_if_ar), 
    .i_req_local_if_awvalid (i_req_local_if_awvalid), 
    .i_req_local_if_awready (i_req_local_if_awready), 
    .i_req_local_if_wvalid  (i_req_local_if_wvalid), 
    .i_req_local_if_wready  (i_req_local_if_wready), 
    .i_req_local_if_arvalid (i_req_local_if_arvalid), 
    .i_req_local_if_arready (i_req_local_if_arready), 
    .i_req_local_if_w       (i_req_local_if_w), 
    .i_req_local_if_aw      (i_req_local_if_aw),
    .i_req_ring_if_ar       (i_req_ring_if_ar), 
    .i_req_ring_if_awvalid  (i_req_ring_if_awvalid), 
    .i_req_ring_if_awready  (i_req_ring_if_awready), 
    .i_req_ring_if_wvalid   (i_req_ring_if_wvalid), 
    .i_req_ring_if_wready   (i_req_ring_if_wready), 
    .i_req_ring_if_arvalid  (i_req_ring_if_arvalid), 
    .i_req_ring_if_arready  (i_req_ring_if_arready), 
    .i_req_ring_if_w        (i_req_ring_if_w), 
    .i_req_ring_if_aw       (i_req_ring_if_aw),
    .o_req_local_if_ar      (station2brb_req_ar), 
    .o_req_local_if_awvalid (station2brb_req_awvalid), 
    .o_req_local_if_awready (station2brb_req_awready), 
    .o_req_local_if_wvalid  (station2brb_req_wvalid), 
    .o_req_local_if_wready  (station2brb_req_wready), 
    .o_req_local_if_arvalid (station2brb_req_arvalid), 
    .o_req_local_if_arready (station2brb_req_arready), 
    .o_req_local_if_w       (station2brb_req_w), 
    .o_req_local_if_aw      (station2brb_req_aw),
    .o_req_ring_if_ar       (o_req_ring_if_ar), 
    .o_req_ring_if_awvalid  (o_req_ring_if_awvalid), 
    .o_req_ring_if_awready  (o_req_ring_if_awready), 
    .o_req_ring_if_wvalid   (o_req_ring_if_wvalid), 
    .o_req_ring_if_wready   (o_req_ring_if_wready), 
    .o_req_ring_if_arvalid  (o_req_ring_if_arvalid), 
    .o_req_ring_if_arready  (o_req_ring_if_arready), 
    .o_req_ring_if_w        (o_req_ring_if_w), 
    .o_req_ring_if_aw       (o_req_ring_if_aw),
    .i_resp_local_if_b      (station2brb_rsp_b), 
    .i_resp_local_if_r      (station2brb_rsp_r), 
    .i_resp_local_if_rvalid (station2brb_rsp_rvalid), 
    .i_resp_local_if_rready (station2brb_rsp_rready), 
    .i_resp_local_if_bvalid (station2brb_rsp_bvalid), 
    .i_resp_local_if_bready (station2brb_rsp_bready),
    .i_resp_ring_if_b       (i_resp_ring_if_b), 
    .i_resp_ring_if_r       (i_resp_ring_if_r), 
    .i_resp_ring_if_rvalid  (i_resp_ring_if_rvalid), 
    .i_resp_ring_if_rready  (i_resp_ring_if_rready), 
    .i_resp_ring_if_bvalid  (i_resp_ring_if_bvalid), 
    .i_resp_ring_if_bready  (i_resp_ring_if_bready),
    .o_resp_local_if_b      (o_resp_local_if_b), 
    .o_resp_local_if_r      (o_resp_local_if_r), 
    .o_resp_local_if_rvalid (o_resp_local_if_rvalid), 
    .o_resp_local_if_rready (o_resp_local_if_rready), 
    .o_resp_local_if_bvalid (o_resp_local_if_bvalid), 
    .o_resp_local_if_bready (o_resp_local_if_bready),
    .o_resp_ring_if_b       (o_resp_ring_if_b), 
    .o_resp_ring_if_r       (o_resp_ring_if_r), 
    .o_resp_ring_if_rvalid  (o_resp_ring_if_rvalid), 
    .o_resp_ring_if_rready  (o_resp_ring_if_rready), 
    .o_resp_ring_if_bvalid  (o_resp_ring_if_bvalid), 
    .o_resp_ring_if_bready  (o_resp_ring_if_bready),
    .clk                    (clk),
    .rstn                   (rstn)
    );

  ring_data_t wmask, wmask_inv;
  generate
    for (genvar i = 0; i < $bits(ring_strb_t); i++) begin : WMASK_GEN
      assign wmask[i * 8 +: 8]      = (station2brb_req_w.wstrb[i]) ? 8'hff : 8'h00;
      assign wmask_inv[i * 8 +: 8]  = (station2brb_req_w.wstrb[i]) ? 8'h00 : 8'hff;
    end
  endgenerate

  logic [STATION_DT_S2ICG_CLK_EN_WIDTH - 1 : 0] rff_s2icg_clk_en;
  logic [STATION_DT_S2ICG_CLK_EN_WIDTH - 1 : 0] s2icg_clk_en;
  logic load_s2icg_clk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_clk_en <= STATION_DT_S2ICG_CLK_EN_RSTVAL;
    end else if (load_s2icg_clk_en == 1'b1) begin
      rff_s2icg_clk_en <= (wmask & s2icg_clk_en) | (wmask_inv & rff_s2icg_clk_en);
    end
  end
  assign out_s2icg_clk_en = rff_s2icg_clk_en;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_DT_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_DT_DATA_WIDTH{1'b0}};
    s2icg_clk_en = rff_s2icg_clk_en;
    load_s2icg_clk_en = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_DT_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DT_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_DT_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DT_DATA_WIDTH/8)]} == (STATION_DT_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_DT_DATA_WIDTH/8)))): begin
          data = rff_s2icg_clk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_DT_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_DT_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_DT_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_DT_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_DT_DATA_WIDTH/8)]} == (STATION_DT_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_DT_DATA_WIDTH/8)))): begin
          s2icg_clk_en = station2brb_req_w.wdata[STATION_DT_S2ICG_CLK_EN_WIDTH - 1 : 0];
          load_s2icg_clk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        default: begin
          bdec  = 1'b0;
          bresp = AXI_RESP_DECERR;
        end
      endcase
    end
  end

  // Response Muxing
  oursring_resp_if_b_t  i_resp_if_b[2];
  oursring_resp_if_r_t  i_resp_if_r[2];
  logic                 i_resp_if_rvalid[2];
  logic                 i_resp_if_rready[2];
  logic                 i_resp_if_bvalid[2];
  logic                 i_resp_if_bready[2];
  oursring_resp_if_b_t  o_resp_ppln_if_b[1];
  oursring_resp_if_r_t  o_resp_ppln_if_r[1];
  logic                 o_resp_ppln_if_rvalid[1];
  logic                 o_resp_ppln_if_rready[1];
  logic                 o_resp_ppln_if_bvalid[1];
  logic                 o_resp_ppln_if_bready[1];

  logic                 rff_awrdy, rff_wrdy, next_awrdy, next_wrdy;
  // Request Bypassing
  assign o_req_local_if_awvalid  = (station2brb_req_awvalid & ~bdec) & ~rff_awrdy;
  assign o_req_local_if_wvalid   = (station2brb_req_wvalid & ~bdec) & ~rff_wrdy;
  assign o_req_local_if_arvalid  = (station2brb_req_arvalid & ~rdec);
  assign o_req_local_if_ar       = station2brb_req_ar;
  assign o_req_local_if_aw       = station2brb_req_aw;
  assign o_req_local_if_w        = station2brb_req_w;

  // Request Readys
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_awrdy <= 1'b0;
      rff_wrdy  <= 1'b0;
    end else begin
      rff_awrdy <= next_awrdy;
      rff_wrdy  <= next_wrdy;
    end
  end
  always_comb begin
    next_awrdy = rff_awrdy;
    next_wrdy  = rff_wrdy;
    if ((~bdec & o_req_local_if_awready & o_req_local_if_awvalid) | (bdec & i_resp_if_bready[0])) begin
      next_awrdy = 1'b1;
    end else if (rff_awrdy & rff_wrdy) begin
      next_awrdy = 1'b0;
    end
    if ((~bdec & o_req_local_if_wready & o_req_local_if_wvalid)  | (bdec & i_resp_if_bready[0])) begin
      next_wrdy = 1'b1;
    end else if (rff_awrdy & rff_wrdy) begin
      next_wrdy = 1'b0;
    end
  end
  assign station2brb_req_awready  = rff_awrdy & rff_wrdy;
  assign station2brb_req_wready   = rff_awrdy & rff_wrdy;

  assign station2brb_req_arready  = (~rdec & o_req_local_if_arready) | (rdec & i_resp_if_rready[0]);

  // if 1, means input port i's destination station id matches output j's station id
  logic [1:0][0:0]      is_r_dst_match;
  logic [1:0][0:0]      is_b_dst_match;

  oursring_resp_if_b_t  brb_b;
  oursring_resp_if_r_t  brb_r;

  assign brb_b.bid   = station2brb_req_aw.awid;
  assign brb_b.bresp = bresp;

  assign brb_r.rid   = station2brb_req_ar.arid;
  assign brb_r.rresp = rresp;
  assign brb_r.rdata = data;
  assign brb_r.rlast = 1'b1;

  assign i_resp_if_b[0] = brb_b;
  assign i_resp_if_b[1] = i_resp_local_if_b;

  assign i_resp_if_r[0] = brb_r;
  assign i_resp_if_r[1] = i_resp_local_if_r;

  assign i_resp_if_rvalid[0] = station2brb_req_arvalid & rdec;
  assign i_resp_if_rvalid[1] = i_resp_local_if_rvalid;

  assign i_resp_local_if_rready = i_resp_if_rready[1];

  assign i_resp_if_bvalid[0] = station2brb_req_awvalid & station2brb_req_wvalid & bdec & ~rff_awrdy & ~rff_wrdy;
  assign i_resp_if_bvalid[1] = i_resp_local_if_bvalid;

  assign i_resp_local_if_bready = i_resp_if_bready[1];

  assign station2brb_rsp_b        = o_resp_ppln_if_b[0];
  assign station2brb_rsp_r        = o_resp_ppln_if_r[0];
  assign station2brb_rsp_rvalid   = o_resp_ppln_if_rvalid[0];
  assign o_resp_ppln_if_rready[0] = station2brb_rsp_rready;
  assign station2brb_rsp_bvalid   = o_resp_ppln_if_bvalid[0];
  assign o_resp_ppln_if_bready[0] = station2brb_rsp_bready;
  
  assign is_r_dst_match = 2'b11;
  assign is_b_dst_match = 2'b11;

  oursring_resp #(.N_IN_PORT(2), .N_OUT_PORT(1)) resp_u (
    .i_resp_if_b            (i_resp_if_b),
    .i_resp_if_r            (i_resp_if_r),
    .i_resp_if_rvalid       (i_resp_if_rvalid),
    .i_resp_if_rready       (i_resp_if_rready),
    .i_resp_if_bvalid       (i_resp_if_bvalid),
    .i_resp_if_bready       (i_resp_if_bready),
    .o_resp_ppln_if_b       (o_resp_ppln_if_b),
    .o_resp_ppln_if_r       (o_resp_ppln_if_r),
    .o_resp_ppln_if_rvalid  (o_resp_ppln_if_rvalid),
    .o_resp_ppln_if_rready  (o_resp_ppln_if_rready),
    .o_resp_ppln_if_bvalid  (o_resp_ppln_if_bvalid),
    .o_resp_ppln_if_bready  (o_resp_ppln_if_bready),
    .is_r_dst_match         (is_r_dst_match),
    .is_b_dst_match         (is_b_dst_match),
    .rstn                   (rstn),
    .clk                    (clk)
    );
  
endmodule
`endif
`endif
