
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_SDIO_PKG__SV
`define STATION_SDIO_PKG__SV
package station_sdio_pkg;
  localparam int STATION_SDIO_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_SDIO_DATA_WIDTH = 'h40;
  localparam [STATION_SDIO_RING_ADDR_WIDTH-1:0] STATION_SDIO_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_SDIO_BLKID = 'h6;
  localparam int STATION_SDIO_BLKID_WIDTH = 'h5;
  localparam bit [25 - 1:0] STATION_SDIO_MSHC_CTRL_OFFSET = 64'h0;
  localparam int STATION_SDIO_MSHC_CTRL_WIDTH  = 32768;
  localparam bit [64 - 1:0] STATION_SDIO_MSHC_CTRL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_MSHC_CTRL_ADDR = 64'h600000;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_OFFSET = 64'h1000;
  localparam int STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_WIDTH  = 10;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_ADDR = 64'h601000;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_OFFSET = 64'h1008;
  localparam int STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH  = 10;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_RSTVAL = 128;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_ADDR = 64'h601008;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD1_SEL_OFFSET = 64'h1010;
  localparam int STATION_SDIO_B2S_SD_VDD1_SEL_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_SD_VDD1_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD1_SEL_ADDR = 64'h601010;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD2_SEL_OFFSET = 64'h1018;
  localparam int STATION_SDIO_B2S_SD_VDD2_SEL_WIDTH  = 3;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_SD_VDD2_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD2_SEL_ADDR = 64'h601018;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_DATXFER_WIDTH_OFFSET = 64'h1020;
  localparam int STATION_SDIO_B2S_SD_DATXFER_WIDTH_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_SD_DATXFER_WIDTH_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_DATXFER_WIDTH_ADDR = 64'h601020;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_CARD_CLK_GEN_SEL_OFFSET = 64'h1028;
  localparam int STATION_SDIO_B2S_CARD_CLK_GEN_SEL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_CARD_CLK_GEN_SEL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_CARD_CLK_GEN_SEL_ADDR = 64'h601028;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_INT_BCLK_STABLE_OFFSET = 64'h1030;
  localparam int STATION_SDIO_S2B_INT_BCLK_STABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_INT_BCLK_STABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_INT_BCLK_STABLE_ADDR = 64'h601030;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_INT_ACLK_STABLE_OFFSET = 64'h1038;
  localparam int STATION_SDIO_S2B_INT_ACLK_STABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_INT_ACLK_STABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_INT_ACLK_STABLE_ADDR = 64'h601038;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD1_ON_OFFSET = 64'h1040;
  localparam int STATION_SDIO_B2S_SD_VDD1_ON_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_SD_VDD1_ON_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD1_ON_ADDR = 64'h601040;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD2_ON_OFFSET = 64'h1048;
  localparam int STATION_SDIO_B2S_SD_VDD2_ON_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_SD_VDD2_ON_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_SD_VDD2_ON_ADDR = 64'h601048;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_HOST_REG_VOL_STABLE_OFFSET = 64'h1050;
  localparam int STATION_SDIO_S2B_HOST_REG_VOL_STABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_HOST_REG_VOL_STABLE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_HOST_REG_VOL_STABLE_ADDR = 64'h601050;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_LED_CONTROL_OFFSET = 64'h1058;
  localparam int STATION_SDIO_B2S_LED_CONTROL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_B2S_LED_CONTROL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_B2S_LED_CONTROL_ADDR = 64'h601058;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_SLP_OFFSET = 64'h1060;
  localparam int STATION_SDIO_S2B_SLP_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_SLP_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_SLP_ADDR = 64'h601060;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_SD_OFFSET = 64'h1068;
  localparam int STATION_SDIO_S2B_SD_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_SD_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_SD_ADDR = 64'h601068;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_RESETN_OFFSET = 64'h1070;
  localparam int STATION_SDIO_S2B_RESETN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_RESETN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_RESETN_ADDR = 64'h601070;
  localparam bit [25 - 1:0] STATION_SDIO_S2ICG_PLLCLK_EN_OFFSET = 64'h1078;
  localparam int STATION_SDIO_S2ICG_PLLCLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2ICG_PLLCLK_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_SDIO_S2ICG_PLLCLK_EN_ADDR = 64'h601078;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_ICG_EN_OFFSET = 64'h1080;
  localparam int STATION_SDIO_S2B_ICG_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_ICG_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_ICG_EN_ADDR = 64'h601080;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_OFFSET = 64'h1088;
  localparam int STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_ADDR = 64'h601088;
  localparam bit [25 - 1:0] STATION_SDIO_DEBUG_INFO_ENABLE_OFFSET = 64'h1090;
  localparam int STATION_SDIO_DEBUG_INFO_ENABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_SDIO_DEBUG_INFO_ENABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_SDIO_DEBUG_INFO_ENABLE_ADDR = 64'h601090;
endpackage
`endif
`ifndef STATION_SDIO__SV
`define STATION_SDIO__SV
module station_sdio
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_sdio_pkg::*;
  (
  output [STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_WIDTH - 1 : 0] out_b2s_card_clk_freq_sel,
  output [STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] out_s2b_test_io_clkdiv_half_div_less_1,
  output [STATION_SDIO_B2S_SD_VDD1_SEL_WIDTH - 1 : 0] out_b2s_sd_vdd1_sel,
  output [STATION_SDIO_B2S_SD_VDD2_SEL_WIDTH - 1 : 0] out_b2s_sd_vdd2_sel,
  output [STATION_SDIO_B2S_SD_DATXFER_WIDTH_WIDTH - 1 : 0] out_b2s_sd_datxfer_width,
  output out_b2s_card_clk_gen_sel,
  output out_s2b_int_bclk_stable,
  output out_s2b_int_aclk_stable,
  output out_b2s_sd_vdd1_on,
  output out_b2s_sd_vdd2_on,
  output out_s2b_host_reg_vol_stable,
  output out_b2s_led_control,
  output out_s2b_slp,
  output out_s2b_sd,
  output out_s2b_resetn,
  output out_s2icg_pllclk_en,
  output out_s2b_icg_en,
  output out_s2b_test_io_pllclk_en,
  output out_debug_info_enable,
  input logic vld_in_b2s_card_clk_freq_sel,
  input [STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_WIDTH - 1 : 0] in_b2s_card_clk_freq_sel,
  input logic vld_in_b2s_sd_vdd1_sel,
  input [STATION_SDIO_B2S_SD_VDD1_SEL_WIDTH - 1 : 0] in_b2s_sd_vdd1_sel,
  input logic vld_in_b2s_sd_vdd2_sel,
  input [STATION_SDIO_B2S_SD_VDD2_SEL_WIDTH - 1 : 0] in_b2s_sd_vdd2_sel,
  input logic vld_in_b2s_sd_datxfer_width,
  input [STATION_SDIO_B2S_SD_DATXFER_WIDTH_WIDTH - 1 : 0] in_b2s_sd_datxfer_width,
  input logic vld_in_b2s_card_clk_gen_sel,
  input in_b2s_card_clk_gen_sel,
  input logic vld_in_b2s_sd_vdd1_on,
  input in_b2s_sd_vdd1_on,
  input logic vld_in_b2s_sd_vdd2_on,
  input in_b2s_sd_vdd2_on,
  input logic vld_in_b2s_led_control,
  input in_b2s_led_control,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_SDIO_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_SDIO_BLKID;

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_SDIO_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_SDIO_MAX_RING_ADDR)) station_u (

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

  logic [STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_WIDTH - 1 : 0] rff_b2s_card_clk_freq_sel;
  logic [STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_WIDTH - 1 : 0] b2s_card_clk_freq_sel;
  logic load_b2s_card_clk_freq_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_card_clk_freq_sel <= STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_RSTVAL;
    end else if (load_b2s_card_clk_freq_sel == 1'b1) begin
      rff_b2s_card_clk_freq_sel <= (wmask & b2s_card_clk_freq_sel) | (wmask_inv & rff_b2s_card_clk_freq_sel);

    end else if (vld_in_b2s_card_clk_freq_sel == 1'b1) begin
      rff_b2s_card_clk_freq_sel <= in_b2s_card_clk_freq_sel;
    end
  end
  assign out_b2s_card_clk_freq_sel = rff_b2s_card_clk_freq_sel;
  logic [STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] rff_s2b_test_io_clkdiv_half_div_less_1;
  logic [STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0] s2b_test_io_clkdiv_half_div_less_1;
  logic load_s2b_test_io_clkdiv_half_div_less_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_test_io_clkdiv_half_div_less_1 <= STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_RSTVAL;
    end else if (load_s2b_test_io_clkdiv_half_div_less_1 == 1'b1) begin
      rff_s2b_test_io_clkdiv_half_div_less_1 <= (wmask & s2b_test_io_clkdiv_half_div_less_1) | (wmask_inv & rff_s2b_test_io_clkdiv_half_div_less_1);
    end
  end
  assign out_s2b_test_io_clkdiv_half_div_less_1 = rff_s2b_test_io_clkdiv_half_div_less_1;
  logic [STATION_SDIO_B2S_SD_VDD1_SEL_WIDTH - 1 : 0] rff_b2s_sd_vdd1_sel;
  logic [STATION_SDIO_B2S_SD_VDD1_SEL_WIDTH - 1 : 0] b2s_sd_vdd1_sel;
  logic load_b2s_sd_vdd1_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_sd_vdd1_sel <= STATION_SDIO_B2S_SD_VDD1_SEL_RSTVAL;
    end else if (load_b2s_sd_vdd1_sel == 1'b1) begin
      rff_b2s_sd_vdd1_sel <= (wmask & b2s_sd_vdd1_sel) | (wmask_inv & rff_b2s_sd_vdd1_sel);

    end else if (vld_in_b2s_sd_vdd1_sel == 1'b1) begin
      rff_b2s_sd_vdd1_sel <= in_b2s_sd_vdd1_sel;
    end
  end
  assign out_b2s_sd_vdd1_sel = rff_b2s_sd_vdd1_sel;
  logic [STATION_SDIO_B2S_SD_VDD2_SEL_WIDTH - 1 : 0] rff_b2s_sd_vdd2_sel;
  logic [STATION_SDIO_B2S_SD_VDD2_SEL_WIDTH - 1 : 0] b2s_sd_vdd2_sel;
  logic load_b2s_sd_vdd2_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_sd_vdd2_sel <= STATION_SDIO_B2S_SD_VDD2_SEL_RSTVAL;
    end else if (load_b2s_sd_vdd2_sel == 1'b1) begin
      rff_b2s_sd_vdd2_sel <= (wmask & b2s_sd_vdd2_sel) | (wmask_inv & rff_b2s_sd_vdd2_sel);

    end else if (vld_in_b2s_sd_vdd2_sel == 1'b1) begin
      rff_b2s_sd_vdd2_sel <= in_b2s_sd_vdd2_sel;
    end
  end
  assign out_b2s_sd_vdd2_sel = rff_b2s_sd_vdd2_sel;
  logic [STATION_SDIO_B2S_SD_DATXFER_WIDTH_WIDTH - 1 : 0] rff_b2s_sd_datxfer_width;
  logic [STATION_SDIO_B2S_SD_DATXFER_WIDTH_WIDTH - 1 : 0] b2s_sd_datxfer_width;
  logic load_b2s_sd_datxfer_width;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_sd_datxfer_width <= STATION_SDIO_B2S_SD_DATXFER_WIDTH_RSTVAL;
    end else if (load_b2s_sd_datxfer_width == 1'b1) begin
      rff_b2s_sd_datxfer_width <= (wmask & b2s_sd_datxfer_width) | (wmask_inv & rff_b2s_sd_datxfer_width);

    end else if (vld_in_b2s_sd_datxfer_width == 1'b1) begin
      rff_b2s_sd_datxfer_width <= in_b2s_sd_datxfer_width;
    end
  end
  assign out_b2s_sd_datxfer_width = rff_b2s_sd_datxfer_width;
  logic [STATION_SDIO_B2S_CARD_CLK_GEN_SEL_WIDTH - 1 : 0] rff_b2s_card_clk_gen_sel;
  logic [STATION_SDIO_B2S_CARD_CLK_GEN_SEL_WIDTH - 1 : 0] b2s_card_clk_gen_sel;
  logic load_b2s_card_clk_gen_sel;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_card_clk_gen_sel <= STATION_SDIO_B2S_CARD_CLK_GEN_SEL_RSTVAL;
    end else if (load_b2s_card_clk_gen_sel == 1'b1) begin
      rff_b2s_card_clk_gen_sel <= (wmask & b2s_card_clk_gen_sel) | (wmask_inv & rff_b2s_card_clk_gen_sel);

    end else if (vld_in_b2s_card_clk_gen_sel == 1'b1) begin
      rff_b2s_card_clk_gen_sel <= in_b2s_card_clk_gen_sel;
    end
  end
  assign out_b2s_card_clk_gen_sel = rff_b2s_card_clk_gen_sel;
  logic [STATION_SDIO_S2B_INT_BCLK_STABLE_WIDTH - 1 : 0] rff_s2b_int_bclk_stable;
  logic [STATION_SDIO_S2B_INT_BCLK_STABLE_WIDTH - 1 : 0] s2b_int_bclk_stable;
  logic load_s2b_int_bclk_stable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_int_bclk_stable <= STATION_SDIO_S2B_INT_BCLK_STABLE_RSTVAL;
    end else if (load_s2b_int_bclk_stable == 1'b1) begin
      rff_s2b_int_bclk_stable <= (wmask & s2b_int_bclk_stable) | (wmask_inv & rff_s2b_int_bclk_stable);
    end
  end
  assign out_s2b_int_bclk_stable = rff_s2b_int_bclk_stable;
  logic [STATION_SDIO_S2B_INT_ACLK_STABLE_WIDTH - 1 : 0] rff_s2b_int_aclk_stable;
  logic [STATION_SDIO_S2B_INT_ACLK_STABLE_WIDTH - 1 : 0] s2b_int_aclk_stable;
  logic load_s2b_int_aclk_stable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_int_aclk_stable <= STATION_SDIO_S2B_INT_ACLK_STABLE_RSTVAL;
    end else if (load_s2b_int_aclk_stable == 1'b1) begin
      rff_s2b_int_aclk_stable <= (wmask & s2b_int_aclk_stable) | (wmask_inv & rff_s2b_int_aclk_stable);
    end
  end
  assign out_s2b_int_aclk_stable = rff_s2b_int_aclk_stable;
  logic [STATION_SDIO_B2S_SD_VDD1_ON_WIDTH - 1 : 0] rff_b2s_sd_vdd1_on;
  logic [STATION_SDIO_B2S_SD_VDD1_ON_WIDTH - 1 : 0] b2s_sd_vdd1_on;
  logic load_b2s_sd_vdd1_on;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_sd_vdd1_on <= STATION_SDIO_B2S_SD_VDD1_ON_RSTVAL;
    end else if (load_b2s_sd_vdd1_on == 1'b1) begin
      rff_b2s_sd_vdd1_on <= (wmask & b2s_sd_vdd1_on) | (wmask_inv & rff_b2s_sd_vdd1_on);

    end else if (vld_in_b2s_sd_vdd1_on == 1'b1) begin
      rff_b2s_sd_vdd1_on <= in_b2s_sd_vdd1_on;
    end
  end
  assign out_b2s_sd_vdd1_on = rff_b2s_sd_vdd1_on;
  logic [STATION_SDIO_B2S_SD_VDD2_ON_WIDTH - 1 : 0] rff_b2s_sd_vdd2_on;
  logic [STATION_SDIO_B2S_SD_VDD2_ON_WIDTH - 1 : 0] b2s_sd_vdd2_on;
  logic load_b2s_sd_vdd2_on;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_sd_vdd2_on <= STATION_SDIO_B2S_SD_VDD2_ON_RSTVAL;
    end else if (load_b2s_sd_vdd2_on == 1'b1) begin
      rff_b2s_sd_vdd2_on <= (wmask & b2s_sd_vdd2_on) | (wmask_inv & rff_b2s_sd_vdd2_on);

    end else if (vld_in_b2s_sd_vdd2_on == 1'b1) begin
      rff_b2s_sd_vdd2_on <= in_b2s_sd_vdd2_on;
    end
  end
  assign out_b2s_sd_vdd2_on = rff_b2s_sd_vdd2_on;
  logic [STATION_SDIO_S2B_HOST_REG_VOL_STABLE_WIDTH - 1 : 0] rff_s2b_host_reg_vol_stable;
  logic [STATION_SDIO_S2B_HOST_REG_VOL_STABLE_WIDTH - 1 : 0] s2b_host_reg_vol_stable;
  logic load_s2b_host_reg_vol_stable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_host_reg_vol_stable <= STATION_SDIO_S2B_HOST_REG_VOL_STABLE_RSTVAL;
    end else if (load_s2b_host_reg_vol_stable == 1'b1) begin
      rff_s2b_host_reg_vol_stable <= (wmask & s2b_host_reg_vol_stable) | (wmask_inv & rff_s2b_host_reg_vol_stable);
    end
  end
  assign out_s2b_host_reg_vol_stable = rff_s2b_host_reg_vol_stable;
  logic [STATION_SDIO_B2S_LED_CONTROL_WIDTH - 1 : 0] rff_b2s_led_control;
  logic [STATION_SDIO_B2S_LED_CONTROL_WIDTH - 1 : 0] b2s_led_control;
  logic load_b2s_led_control;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_b2s_led_control <= STATION_SDIO_B2S_LED_CONTROL_RSTVAL;
    end else if (load_b2s_led_control == 1'b1) begin
      rff_b2s_led_control <= (wmask & b2s_led_control) | (wmask_inv & rff_b2s_led_control);

    end else if (vld_in_b2s_led_control == 1'b1) begin
      rff_b2s_led_control <= in_b2s_led_control;
    end
  end
  assign out_b2s_led_control = rff_b2s_led_control;
  logic [STATION_SDIO_S2B_SLP_WIDTH - 1 : 0] rff_s2b_slp;
  logic [STATION_SDIO_S2B_SLP_WIDTH - 1 : 0] s2b_slp;
  logic load_s2b_slp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_slp <= STATION_SDIO_S2B_SLP_RSTVAL;
    end else if (load_s2b_slp == 1'b1) begin
      rff_s2b_slp <= (wmask & s2b_slp) | (wmask_inv & rff_s2b_slp);
    end
  end
  assign out_s2b_slp = rff_s2b_slp;
  logic [STATION_SDIO_S2B_SD_WIDTH - 1 : 0] rff_s2b_sd;
  logic [STATION_SDIO_S2B_SD_WIDTH - 1 : 0] s2b_sd;
  logic load_s2b_sd;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_sd <= STATION_SDIO_S2B_SD_RSTVAL;
    end else if (load_s2b_sd == 1'b1) begin
      rff_s2b_sd <= (wmask & s2b_sd) | (wmask_inv & rff_s2b_sd);
    end
  end
  assign out_s2b_sd = rff_s2b_sd;
  logic [STATION_SDIO_S2B_RESETN_WIDTH - 1 : 0] rff_s2b_resetn;
  logic [STATION_SDIO_S2B_RESETN_WIDTH - 1 : 0] s2b_resetn;
  logic load_s2b_resetn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_resetn <= STATION_SDIO_S2B_RESETN_RSTVAL;
    end else if (load_s2b_resetn == 1'b1) begin
      rff_s2b_resetn <= (wmask & s2b_resetn) | (wmask_inv & rff_s2b_resetn);
    end
  end
  assign out_s2b_resetn = rff_s2b_resetn;
  logic [STATION_SDIO_S2ICG_PLLCLK_EN_WIDTH - 1 : 0] rff_s2icg_pllclk_en;
  logic [STATION_SDIO_S2ICG_PLLCLK_EN_WIDTH - 1 : 0] s2icg_pllclk_en;
  logic load_s2icg_pllclk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_pllclk_en <= STATION_SDIO_S2ICG_PLLCLK_EN_RSTVAL;
    end else if (load_s2icg_pllclk_en == 1'b1) begin
      rff_s2icg_pllclk_en <= (wmask & s2icg_pllclk_en) | (wmask_inv & rff_s2icg_pllclk_en);
    end
  end
  assign out_s2icg_pllclk_en = rff_s2icg_pllclk_en;
  logic [STATION_SDIO_S2B_ICG_EN_WIDTH - 1 : 0] rff_s2b_icg_en;
  logic [STATION_SDIO_S2B_ICG_EN_WIDTH - 1 : 0] s2b_icg_en;
  logic load_s2b_icg_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_icg_en <= STATION_SDIO_S2B_ICG_EN_RSTVAL;
    end else if (load_s2b_icg_en == 1'b1) begin
      rff_s2b_icg_en <= (wmask & s2b_icg_en) | (wmask_inv & rff_s2b_icg_en);
    end
  end
  assign out_s2b_icg_en = rff_s2b_icg_en;
  logic [STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_WIDTH - 1 : 0] rff_s2b_test_io_pllclk_en;
  logic [STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_WIDTH - 1 : 0] s2b_test_io_pllclk_en;
  logic load_s2b_test_io_pllclk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_test_io_pllclk_en <= STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_RSTVAL;
    end else if (load_s2b_test_io_pllclk_en == 1'b1) begin
      rff_s2b_test_io_pllclk_en <= (wmask & s2b_test_io_pllclk_en) | (wmask_inv & rff_s2b_test_io_pllclk_en);
    end
  end
  assign out_s2b_test_io_pllclk_en = rff_s2b_test_io_pllclk_en;
  logic [STATION_SDIO_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] rff_debug_info_enable;
  logic [STATION_SDIO_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] debug_info_enable;
  logic load_debug_info_enable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_debug_info_enable <= STATION_SDIO_DEBUG_INFO_ENABLE_RSTVAL;
    end else if (load_debug_info_enable == 1'b1) begin
      rff_debug_info_enable <= (wmask & debug_info_enable) | (wmask_inv & rff_debug_info_enable);
    end
  end
  assign out_debug_info_enable = rff_debug_info_enable;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_SDIO_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_SDIO_DATA_WIDTH{1'b0}};
    b2s_card_clk_freq_sel = rff_b2s_card_clk_freq_sel;
    load_b2s_card_clk_freq_sel = 1'b0;
    s2b_test_io_clkdiv_half_div_less_1 = rff_s2b_test_io_clkdiv_half_div_less_1;
    load_s2b_test_io_clkdiv_half_div_less_1 = 1'b0;
    b2s_sd_vdd1_sel = rff_b2s_sd_vdd1_sel;
    load_b2s_sd_vdd1_sel = 1'b0;
    b2s_sd_vdd2_sel = rff_b2s_sd_vdd2_sel;
    load_b2s_sd_vdd2_sel = 1'b0;
    b2s_sd_datxfer_width = rff_b2s_sd_datxfer_width;
    load_b2s_sd_datxfer_width = 1'b0;
    b2s_card_clk_gen_sel = rff_b2s_card_clk_gen_sel;
    load_b2s_card_clk_gen_sel = 1'b0;
    s2b_int_bclk_stable = rff_s2b_int_bclk_stable;
    load_s2b_int_bclk_stable = 1'b0;
    s2b_int_aclk_stable = rff_s2b_int_aclk_stable;
    load_s2b_int_aclk_stable = 1'b0;
    b2s_sd_vdd1_on = rff_b2s_sd_vdd1_on;
    load_b2s_sd_vdd1_on = 1'b0;
    b2s_sd_vdd2_on = rff_b2s_sd_vdd2_on;
    load_b2s_sd_vdd2_on = 1'b0;
    s2b_host_reg_vol_stable = rff_s2b_host_reg_vol_stable;
    load_s2b_host_reg_vol_stable = 1'b0;
    b2s_led_control = rff_b2s_led_control;
    load_b2s_led_control = 1'b0;
    s2b_slp = rff_s2b_slp;
    load_s2b_slp = 1'b0;
    s2b_sd = rff_s2b_sd;
    load_s2b_sd = 1'b0;
    s2b_resetn = rff_s2b_resetn;
    load_s2b_resetn = 1'b0;
    s2icg_pllclk_en = rff_s2icg_pllclk_en;
    load_s2icg_pllclk_en = 1'b0;
    s2b_icg_en = rff_s2b_icg_en;
    load_s2b_icg_en = 1'b0;
    s2b_test_io_pllclk_en = rff_s2b_test_io_pllclk_en;
    load_s2b_test_io_pllclk_en = 1'b0;
    debug_info_enable = rff_debug_info_enable;
    load_debug_info_enable = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_card_clk_freq_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_test_io_clkdiv_half_div_less_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD1_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_sd_vdd1_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD2_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_sd_vdd2_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_DATXFER_WIDTH_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_sd_datxfer_width;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_CARD_CLK_GEN_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_card_clk_gen_sel;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_INT_BCLK_STABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_int_bclk_stable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_INT_ACLK_STABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_int_aclk_stable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD1_ON_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_sd_vdd1_on;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD2_ON_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_sd_vdd2_on;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_HOST_REG_VOL_STABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_host_reg_vol_stable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_LED_CONTROL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_b2s_led_control;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_SLP_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_slp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_SD_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_sd;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_RESETN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_resetn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2ICG_PLLCLK_EN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2icg_pllclk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_ICG_EN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_icg_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_s2b_test_io_pllclk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          data = rff_debug_info_enable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_SDIO_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_card_clk_freq_sel = station2brb_req_w.wdata[STATION_SDIO_B2S_CARD_CLK_FREQ_SEL_WIDTH - 1 : 0];
          load_b2s_card_clk_freq_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_test_io_clkdiv_half_div_less_1 = station2brb_req_w.wdata[STATION_SDIO_S2B_TEST_IO_CLKDIV_HALF_DIV_LESS_1_WIDTH - 1 : 0];
          load_s2b_test_io_clkdiv_half_div_less_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD1_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_sd_vdd1_sel = station2brb_req_w.wdata[STATION_SDIO_B2S_SD_VDD1_SEL_WIDTH - 1 : 0];
          load_b2s_sd_vdd1_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD2_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_sd_vdd2_sel = station2brb_req_w.wdata[STATION_SDIO_B2S_SD_VDD2_SEL_WIDTH - 1 : 0];
          load_b2s_sd_vdd2_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_DATXFER_WIDTH_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_sd_datxfer_width = station2brb_req_w.wdata[STATION_SDIO_B2S_SD_DATXFER_WIDTH_WIDTH - 1 : 0];
          load_b2s_sd_datxfer_width = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_CARD_CLK_GEN_SEL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_card_clk_gen_sel = station2brb_req_w.wdata[STATION_SDIO_B2S_CARD_CLK_GEN_SEL_WIDTH - 1 : 0];
          load_b2s_card_clk_gen_sel = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_INT_BCLK_STABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_int_bclk_stable = station2brb_req_w.wdata[STATION_SDIO_S2B_INT_BCLK_STABLE_WIDTH - 1 : 0];
          load_s2b_int_bclk_stable = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_INT_ACLK_STABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_int_aclk_stable = station2brb_req_w.wdata[STATION_SDIO_S2B_INT_ACLK_STABLE_WIDTH - 1 : 0];
          load_s2b_int_aclk_stable = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD1_ON_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_sd_vdd1_on = station2brb_req_w.wdata[STATION_SDIO_B2S_SD_VDD1_ON_WIDTH - 1 : 0];
          load_b2s_sd_vdd1_on = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_SD_VDD2_ON_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_sd_vdd2_on = station2brb_req_w.wdata[STATION_SDIO_B2S_SD_VDD2_ON_WIDTH - 1 : 0];
          load_b2s_sd_vdd2_on = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_HOST_REG_VOL_STABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_host_reg_vol_stable = station2brb_req_w.wdata[STATION_SDIO_S2B_HOST_REG_VOL_STABLE_WIDTH - 1 : 0];
          load_s2b_host_reg_vol_stable = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_B2S_LED_CONTROL_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          b2s_led_control = station2brb_req_w.wdata[STATION_SDIO_B2S_LED_CONTROL_WIDTH - 1 : 0];
          load_b2s_led_control = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_SLP_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_slp = station2brb_req_w.wdata[STATION_SDIO_S2B_SLP_WIDTH - 1 : 0];
          load_s2b_slp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_SD_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_sd = station2brb_req_w.wdata[STATION_SDIO_S2B_SD_WIDTH - 1 : 0];
          load_s2b_sd = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_RESETN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_resetn = station2brb_req_w.wdata[STATION_SDIO_S2B_RESETN_WIDTH - 1 : 0];
          load_s2b_resetn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2ICG_PLLCLK_EN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2icg_pllclk_en = station2brb_req_w.wdata[STATION_SDIO_S2ICG_PLLCLK_EN_WIDTH - 1 : 0];
          load_s2icg_pllclk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_ICG_EN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_icg_en = station2brb_req_w.wdata[STATION_SDIO_S2B_ICG_EN_WIDTH - 1 : 0];
          load_s2b_icg_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          s2b_test_io_pllclk_en = station2brb_req_w.wdata[STATION_SDIO_S2B_TEST_IO_PLLCLK_EN_WIDTH - 1 : 0];
          load_s2b_test_io_pllclk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_SDIO_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_SDIO_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_SDIO_DATA_WIDTH/8)]} == (STATION_SDIO_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_SDIO_DATA_WIDTH/8)))): begin
          debug_info_enable = station2brb_req_w.wdata[STATION_SDIO_DEBUG_INFO_ENABLE_WIDTH - 1 : 0];
          load_debug_info_enable = station2brb_req_awready & station2brb_req_wready;
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
