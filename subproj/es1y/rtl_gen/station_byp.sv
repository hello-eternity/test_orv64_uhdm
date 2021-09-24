
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_BYP_PKG__SV
`define STATION_BYP_PKG__SV
package station_byp_pkg;
  localparam int STATION_BYP_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_BYP_DATA_WIDTH = 'h40;
  localparam [STATION_BYP_RING_ADDR_WIDTH-1:0] STATION_BYP_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_BYP_BLKID = 'h1;
  localparam int STATION_BYP_BLKID_WIDTH = 'h1;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_OFFSET = 64'h0;
  localparam int STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_RSTVAL = 5;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_ADDR = 64'h1000000;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_OFFSET = 64'h8;
  localparam int STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_RSTVAL = 4;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_ADDR = 64'h1000008;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_OFFSET = 64'h10;
  localparam int STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_WIDTH  = 16;
  localparam bit [64 - 1:0] STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_ADDR = 64'h1000010;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_OFFSET = 64'h18;
  localparam int STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH  = 4;
  localparam bit [64 - 1:0] STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_RSTVAL = 5;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_ADDR = 64'h1000018;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_OFFSET = 64'h20;
  localparam int STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_RSTVAL = 2;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_ADDR = 64'h1000020;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_OFFSET = 64'h28;
  localparam int STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_ADDR = 64'h1000028;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_OFFSET = 64'h30;
  localparam int STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_ADDR = 64'h1000030;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDR_BYPASS_EN_OFFSET = 64'h38;
  localparam int STATION_BYP_S2B_DDR_BYPASS_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_BYP_S2B_DDR_BYPASS_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDR_BYPASS_EN_ADDR = 64'h1000038;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDR_TOP_ICG_EN_OFFSET = 64'h40;
  localparam int STATION_BYP_S2B_DDR_TOP_ICG_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_BYP_S2B_DDR_TOP_ICG_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_BYP_S2B_DDR_TOP_ICG_EN_ADDR = 64'h1000040;
endpackage
`endif
`ifndef STATION_BYP__SV
`define STATION_BYP__SV
module station_byp
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_byp_pkg::*;
  (
  output [STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_WIDTH - 1 : 0] out_s2b_sdio_cclk_tx_half_div_less_1,
  output [STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_WIDTH - 1 : 0] out_s2b_sdio_tmclk_half_div_less_1,
  output [STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_WIDTH - 1 : 0] out_s2b_sdio_clk_half_div_less_1,
  output [STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] out_s2b_slow_io_clkdiv_half_div_less_1,
  output [STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] out_s2b_ddrls_clkdiv_half_div_less_1,
  output out_s2b_slow_io_clkdiv_divclk_sel,
  output out_s2b_ddrls_clkdiv_divclk_sel,
  output out_s2b_ddr_bypass_en,
  output out_s2b_ddr_top_icg_en,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_BYP_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_BYP_BLKID;

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_BYP_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_BYP_MAX_RING_ADDR)) station_u (

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

  logic [STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_WIDTH - 1 : 0] rff_s2b_sdio_cclk_tx_half_div_less_1;
  logic [STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_WIDTH - 1 : 0] s2b_sdio_cclk_tx_half_div_less_1;
  logic load_s2b_sdio_cclk_tx_half_div_less_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_sdio_cclk_tx_half_div_less_1 <= STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_RSTVAL;
    end else if (load_s2b_sdio_cclk_tx_half_div_less_1 == 1'b1) begin
      rff_s2b_sdio_cclk_tx_half_div_less_1 <= (wmask & s2b_sdio_cclk_tx_half_div_less_1) | (wmask_inv & rff_s2b_sdio_cclk_tx_half_div_less_1);
    end
  end
  assign out_s2b_sdio_cclk_tx_half_div_less_1 = rff_s2b_sdio_cclk_tx_half_div_less_1;
  logic [STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_WIDTH - 1 : 0] rff_s2b_sdio_tmclk_half_div_less_1;
  logic [STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_WIDTH - 1 : 0] s2b_sdio_tmclk_half_div_less_1;
  logic load_s2b_sdio_tmclk_half_div_less_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_sdio_tmclk_half_div_less_1 <= STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_RSTVAL;
    end else if (load_s2b_sdio_tmclk_half_div_less_1 == 1'b1) begin
      rff_s2b_sdio_tmclk_half_div_less_1 <= (wmask & s2b_sdio_tmclk_half_div_less_1) | (wmask_inv & rff_s2b_sdio_tmclk_half_div_less_1);
    end
  end
  assign out_s2b_sdio_tmclk_half_div_less_1 = rff_s2b_sdio_tmclk_half_div_less_1;
  logic [STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_WIDTH - 1 : 0] rff_s2b_sdio_clk_half_div_less_1;
  logic [STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_WIDTH - 1 : 0] s2b_sdio_clk_half_div_less_1;
  logic load_s2b_sdio_clk_half_div_less_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_sdio_clk_half_div_less_1 <= STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_RSTVAL;
    end else if (load_s2b_sdio_clk_half_div_less_1 == 1'b1) begin
      rff_s2b_sdio_clk_half_div_less_1 <= (wmask & s2b_sdio_clk_half_div_less_1) | (wmask_inv & rff_s2b_sdio_clk_half_div_less_1);
    end
  end
  assign out_s2b_sdio_clk_half_div_less_1 = rff_s2b_sdio_clk_half_div_less_1;
  logic [STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] rff_s2b_slow_io_clkdiv_half_div_less_1;
  logic [STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] s2b_slow_io_clkdiv_half_div_less_1;
  logic load_s2b_slow_io_clkdiv_half_div_less_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_slow_io_clkdiv_half_div_less_1 <= STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_RSTVAL;
    end else if (load_s2b_slow_io_clkdiv_half_div_less_1 == 1'b1) begin
      rff_s2b_slow_io_clkdiv_half_div_less_1 <= (wmask & s2b_slow_io_clkdiv_half_div_less_1) | (wmask_inv & rff_s2b_slow_io_clkdiv_half_div_less_1);
    end
  end
  assign out_s2b_slow_io_clkdiv_half_div_less_1 = rff_s2b_slow_io_clkdiv_half_div_less_1;
  logic [STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] rff_s2b_ddrls_clkdiv_half_div_less_1;
  logic [STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] s2b_ddrls_clkdiv_half_div_less_1;
  logic load_s2b_ddrls_clkdiv_half_div_less_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ddrls_clkdiv_half_div_less_1 <= STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_RSTVAL;
    end else if (load_s2b_ddrls_clkdiv_half_div_less_1 == 1'b1) begin
      rff_s2b_ddrls_clkdiv_half_div_less_1 <= (wmask & s2b_ddrls_clkdiv_half_div_less_1) | (wmask_inv & rff_s2b_ddrls_clkdiv_half_div_less_1);
    end
  end
  assign out_s2b_ddrls_clkdiv_half_div_less_1 = rff_s2b_ddrls_clkdiv_half_div_less_1;
  logic [STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_WIDTH - 1 : 0] rff_s2b_slow_io_clkdiv_divclk_sel;
  logic [STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_WIDTH - 1 : 0] s2b_slow_io_clkdiv_divclk_sel;
  logic load_s2b_slow_io_clkdiv_divclk_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_slow_io_clkdiv_divclk_sel <= STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_RSTVAL;
    end else if (load_s2b_slow_io_clkdiv_divclk_sel == 1'b1) begin
      rff_s2b_slow_io_clkdiv_divclk_sel <= (wmask & s2b_slow_io_clkdiv_divclk_sel) | (wmask_inv & rff_s2b_slow_io_clkdiv_divclk_sel);
    end
  end
  assign out_s2b_slow_io_clkdiv_divclk_sel = rff_s2b_slow_io_clkdiv_divclk_sel;
  logic [STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_WIDTH - 1 : 0] rff_s2b_ddrls_clkdiv_divclk_sel;
  logic [STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_WIDTH - 1 : 0] s2b_ddrls_clkdiv_divclk_sel;
  logic load_s2b_ddrls_clkdiv_divclk_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ddrls_clkdiv_divclk_sel <= STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_RSTVAL;
    end else if (load_s2b_ddrls_clkdiv_divclk_sel == 1'b1) begin
      rff_s2b_ddrls_clkdiv_divclk_sel <= (wmask & s2b_ddrls_clkdiv_divclk_sel) | (wmask_inv & rff_s2b_ddrls_clkdiv_divclk_sel);
    end
  end
  assign out_s2b_ddrls_clkdiv_divclk_sel = rff_s2b_ddrls_clkdiv_divclk_sel;
  logic [STATION_BYP_S2B_DDR_BYPASS_EN_WIDTH - 1 : 0] rff_s2b_ddr_bypass_en;
  logic [STATION_BYP_S2B_DDR_BYPASS_EN_WIDTH - 1 : 0] s2b_ddr_bypass_en;
  logic load_s2b_ddr_bypass_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ddr_bypass_en <= STATION_BYP_S2B_DDR_BYPASS_EN_RSTVAL;
    end else if (load_s2b_ddr_bypass_en == 1'b1) begin
      rff_s2b_ddr_bypass_en <= (wmask & s2b_ddr_bypass_en) | (wmask_inv & rff_s2b_ddr_bypass_en);
    end
  end
  assign out_s2b_ddr_bypass_en = rff_s2b_ddr_bypass_en;
  logic [STATION_BYP_S2B_DDR_TOP_ICG_EN_WIDTH - 1 : 0] rff_s2b_ddr_top_icg_en;
  logic [STATION_BYP_S2B_DDR_TOP_ICG_EN_WIDTH - 1 : 0] s2b_ddr_top_icg_en;
  logic load_s2b_ddr_top_icg_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ddr_top_icg_en <= STATION_BYP_S2B_DDR_TOP_ICG_EN_RSTVAL;
    end else if (load_s2b_ddr_top_icg_en == 1'b1) begin
      rff_s2b_ddr_top_icg_en <= (wmask & s2b_ddr_top_icg_en) | (wmask_inv & rff_s2b_ddr_top_icg_en);
    end
  end
  assign out_s2b_ddr_top_icg_en = rff_s2b_ddr_top_icg_en;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_BYP_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_BYP_DATA_WIDTH{1'b0}};
    s2b_sdio_cclk_tx_half_div_less_1 = rff_s2b_sdio_cclk_tx_half_div_less_1;
    load_s2b_sdio_cclk_tx_half_div_less_1 = 1'b0;
    s2b_sdio_tmclk_half_div_less_1 = rff_s2b_sdio_tmclk_half_div_less_1;
    load_s2b_sdio_tmclk_half_div_less_1 = 1'b0;
    s2b_sdio_clk_half_div_less_1 = rff_s2b_sdio_clk_half_div_less_1;
    load_s2b_sdio_clk_half_div_less_1 = 1'b0;
    s2b_slow_io_clkdiv_half_div_less_1 = rff_s2b_slow_io_clkdiv_half_div_less_1;
    load_s2b_slow_io_clkdiv_half_div_less_1 = 1'b0;
    s2b_ddrls_clkdiv_half_div_less_1 = rff_s2b_ddrls_clkdiv_half_div_less_1;
    load_s2b_ddrls_clkdiv_half_div_less_1 = 1'b0;
    s2b_slow_io_clkdiv_divclk_sel = rff_s2b_slow_io_clkdiv_divclk_sel;
    load_s2b_slow_io_clkdiv_divclk_sel = 1'b0;
    s2b_ddrls_clkdiv_divclk_sel = rff_s2b_ddrls_clkdiv_divclk_sel;
    load_s2b_ddrls_clkdiv_divclk_sel = 1'b0;
    s2b_ddr_bypass_en = rff_s2b_ddr_bypass_en;
    load_s2b_ddr_bypass_en = 1'b0;
    s2b_ddr_top_icg_en = rff_s2b_ddr_top_icg_en;
    load_s2b_ddr_top_icg_en = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_sdio_cclk_tx_half_div_less_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_sdio_tmclk_half_div_less_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_sdio_clk_half_div_less_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_slow_io_clkdiv_half_div_less_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ddrls_clkdiv_half_div_less_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_slow_io_clkdiv_divclk_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ddrls_clkdiv_divclk_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDR_BYPASS_EN_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ddr_bypass_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDR_TOP_ICG_EN_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          data = rff_s2b_ddr_top_icg_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_BYP_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_sdio_cclk_tx_half_div_less_1 = station2brb_req_w.wdata[STATION_BYP_S2B_SDIO_CCLK_TX_HALF_DIV_LESS_1_WIDTH - 1 : 0];
          load_s2b_sdio_cclk_tx_half_div_less_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_sdio_tmclk_half_div_less_1 = station2brb_req_w.wdata[STATION_BYP_S2B_SDIO_TMCLK_HALF_DIV_LESS_1_WIDTH - 1 : 0];
          load_s2b_sdio_tmclk_half_div_less_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_sdio_clk_half_div_less_1 = station2brb_req_w.wdata[STATION_BYP_S2B_SDIO_CLK_HALF_DIV_LESS_1_WIDTH - 1 : 0];
          load_s2b_sdio_clk_half_div_less_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_slow_io_clkdiv_half_div_less_1 = station2brb_req_w.wdata[STATION_BYP_S2B_SLOW_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0];
          load_s2b_slow_io_clkdiv_half_div_less_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_ddrls_clkdiv_half_div_less_1 = station2brb_req_w.wdata[STATION_BYP_S2B_DDRLS_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0];
          load_s2b_ddrls_clkdiv_half_div_less_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_slow_io_clkdiv_divclk_sel = station2brb_req_w.wdata[STATION_BYP_S2B_SLOW_IO_CLKDIV_DIVCLK_SEL_WIDTH - 1 : 0];
          load_s2b_slow_io_clkdiv_divclk_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_ddrls_clkdiv_divclk_sel = station2brb_req_w.wdata[STATION_BYP_S2B_DDRLS_CLKDIV_DIVCLK_SEL_WIDTH - 1 : 0];
          load_s2b_ddrls_clkdiv_divclk_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDR_BYPASS_EN_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_ddr_bypass_en = station2brb_req_w.wdata[STATION_BYP_S2B_DDR_BYPASS_EN_WIDTH - 1 : 0];
          load_s2b_ddr_bypass_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_BYP_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_BYP_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_BYP_DATA_WIDTH/8)]} == (STATION_BYP_S2B_DDR_TOP_ICG_EN_OFFSET >> $clog2(STATION_BYP_DATA_WIDTH/8)))): begin
          s2b_ddr_top_icg_en = station2brb_req_w.wdata[STATION_BYP_S2B_DDR_TOP_ICG_EN_WIDTH - 1 : 0];
          load_s2b_ddr_top_icg_en = station2brb_req_awready & station2brb_req_wready;
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
