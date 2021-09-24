
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_TEST_PKG__SV
`define STATION_TEST_PKG__SV
package station_test_pkg;
  localparam int STATION_TEST_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_TEST_DATA_WIDTH = 'h40;
  localparam [STATION_TEST_RING_ADDR_WIDTH-1:0] STATION_TEST_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_TEST_BLKID = 'h10;
  localparam int STATION_TEST_BLKID_WIDTH = 'h8;
  localparam bit [25 - 1:0] STATION_TEST_ORV_RST_PC_OFFSET = 64'h0;
  localparam int STATION_TEST_ORV_RST_PC_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_ORV_RST_PC_RSTVAL = 32'h20000000;
  localparam bit [25 - 1:0] STATION_TEST_ORV_RST_PC_ADDR = 64'h200000;
  localparam bit [25 - 1:0] STATION_TEST_MTIME_OFFSET = 64'h1000;
  localparam int STATION_TEST_MTIME_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_MTIME_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_MTIME_ADDR = 64'h201000;
  localparam bit [25 - 1:0] STATION_TEST_MTIMEH_OFFSET = 64'h1008;
  localparam int STATION_TEST_MTIMEH_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_MTIMEH_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_MTIMEH_ADDR = 64'h201008;
  localparam bit [25 - 1:0] STATION_TEST_MTIMECMP_OFFSET = 64'h1010;
  localparam int STATION_TEST_MTIMECMP_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_MTIMECMP_RSTVAL = 32'hffffffff;
  localparam bit [25 - 1:0] STATION_TEST_MTIMECMP_ADDR = 64'h201010;
  localparam bit [25 - 1:0] STATION_TEST_MTIMECMPH_OFFSET = 64'h1018;
  localparam int STATION_TEST_MTIMECMPH_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_MTIMECMPH_RSTVAL = 32'hffffffff;
  localparam bit [25 - 1:0] STATION_TEST_MTIMECMPH_ADDR = 64'h201018;
  localparam bit [25 - 1:0] STATION_TEST_TIMER0_OFFSET = 64'h2000;
  localparam int STATION_TEST_TIMER0_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_TIMER0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_TIMER0_ADDR = 64'h202000;
  localparam bit [25 - 1:0] STATION_TEST_TIMER0H_OFFSET = 64'h2008;
  localparam int STATION_TEST_TIMER0H_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_TIMER0H_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_TIMER0H_ADDR = 64'h202008;
  localparam bit [25 - 1:0] STATION_TEST_TIMERCMP0_OFFSET = 64'h2010;
  localparam int STATION_TEST_TIMERCMP0_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_TIMERCMP0_RSTVAL = 32'hffffffff;
  localparam bit [25 - 1:0] STATION_TEST_TIMERCMP0_ADDR = 64'h202010;
  localparam bit [25 - 1:0] STATION_TEST_TIMERCMP0H_OFFSET = 64'h2018;
  localparam int STATION_TEST_TIMERCMP0H_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_TIMERCMP0H_RSTVAL = 32'hffffffff;
  localparam bit [25 - 1:0] STATION_TEST_TIMERCMP0H_ADDR = 64'h202018;
  localparam bit [25 - 1:0] STATION_TEST_DBG_MEM_START_ADDR_OFFSET = 64'h3000;
  localparam int STATION_TEST_DBG_MEM_START_ADDR_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_DBG_MEM_START_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DBG_MEM_START_ADDR_ADDR = 64'h203000;
  localparam bit [25 - 1:0] STATION_TEST_DBG_MEM_END_ADDR_OFFSET = 64'h3008;
  localparam int STATION_TEST_DBG_MEM_END_ADDR_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_DBG_MEM_END_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DBG_MEM_END_ADDR_ADDR = 64'h203008;
  localparam bit [25 - 1:0] STATION_TEST_DBG_FROMHOST_ADDR_OFFSET = 64'h3010;
  localparam int STATION_TEST_DBG_FROMHOST_ADDR_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_DBG_FROMHOST_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DBG_FROMHOST_ADDR_ADDR = 64'h203010;
  localparam bit [25 - 1:0] STATION_TEST_DBG_TOHOST_ADDR_OFFSET = 64'h3018;
  localparam int STATION_TEST_DBG_TOHOST_ADDR_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_DBG_TOHOST_ADDR_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DBG_TOHOST_ADDR_ADDR = 64'h203018;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_0_OFFSET = 64'h5000;
  localparam int STATION_TEST_BP_IF_PC_0_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_BP_IF_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_0_ADDR = 64'h205000;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_1_OFFSET = 64'h5008;
  localparam int STATION_TEST_BP_IF_PC_1_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_BP_IF_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_1_ADDR = 64'h205008;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_2_OFFSET = 64'h5010;
  localparam int STATION_TEST_BP_IF_PC_2_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_BP_IF_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_2_ADDR = 64'h205010;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_3_OFFSET = 64'h5018;
  localparam int STATION_TEST_BP_IF_PC_3_WIDTH  = 32;
  localparam bit [64 - 1:0] STATION_TEST_BP_IF_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_BP_IF_PC_3_ADDR = 64'h205018;
  localparam bit [25 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_DAT_OFFSET = 64'h8;
  localparam int STATION_TEST_DDR_BYPASS_IN_DATA_DAT_WIDTH  = 24;
  localparam bit [64 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_DAT_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_DAT_ADDR = 64'h200008;
  localparam bit [25 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_AC_OFFSET = 64'h10;
  localparam int STATION_TEST_DDR_BYPASS_IN_DATA_AC_WIDTH  = 12;
  localparam bit [64 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_AC_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_AC_ADDR = 64'h200010;
  localparam bit [25 - 1:0] STATION_TEST_DBG_SPI_MODE_OFFSET = 64'h3020;
  localparam int STATION_TEST_DBG_SPI_MODE_WIDTH  = 4;
  localparam bit [64 - 1:0] STATION_TEST_DBG_SPI_MODE_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DBG_SPI_MODE_ADDR = 64'h203020;
  localparam bit [25 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_OFFSET = 64'h18;
  localparam int STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_WIDTH  = 2;
  localparam bit [64 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_ADDR = 64'h200018;
  localparam bit [25 - 1:0] STATION_TEST_ORV_EARLY_RSTN_OFFSET = 64'h20;
  localparam int STATION_TEST_ORV_EARLY_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_ORV_EARLY_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_ORV_EARLY_RSTN_ADDR = 64'h200020;
  localparam bit [25 - 1:0] STATION_TEST_ORV_RSTN_OFFSET = 64'h28;
  localparam int STATION_TEST_ORV_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_ORV_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_ORV_RSTN_ADDR = 64'h200028;
  localparam bit [25 - 1:0] STATION_TEST_EN_TIMER0_OFFSET = 64'h2020;
  localparam int STATION_TEST_EN_TIMER0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_EN_TIMER0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_EN_TIMER0_ADDR = 64'h202020;
  localparam bit [25 - 1:0] STATION_TEST_UPDATE_TIMER0_OFFSET = 64'h2028;
  localparam int STATION_TEST_UPDATE_TIMER0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_UPDATE_TIMER0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_UPDATE_TIMER0_ADDR = 64'h202028;
  localparam bit [25 - 1:0] STATION_TEST_DEBUG_STALL_OFFSET = 64'h4000;
  localparam int STATION_TEST_DEBUG_STALL_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_DEBUG_STALL_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_DEBUG_STALL_ADDR = 64'h204000;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_0_OFFSET = 64'h5020;
  localparam int STATION_TEST_EN_BP_IF_PC_0_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_EN_BP_IF_PC_0_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_0_ADDR = 64'h205020;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_1_OFFSET = 64'h5028;
  localparam int STATION_TEST_EN_BP_IF_PC_1_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_EN_BP_IF_PC_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_1_ADDR = 64'h205028;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_2_OFFSET = 64'h5030;
  localparam int STATION_TEST_EN_BP_IF_PC_2_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_EN_BP_IF_PC_2_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_2_ADDR = 64'h205030;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_3_OFFSET = 64'h5038;
  localparam int STATION_TEST_EN_BP_IF_PC_3_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_TEST_EN_BP_IF_PC_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_TEST_EN_BP_IF_PC_3_ADDR = 64'h205038;
endpackage
`endif
`ifndef STATION_TEST__SV
`define STATION_TEST__SV
module station_test
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_test_pkg::*;
  (
  output [STATION_TEST_ORV_RST_PC_WIDTH - 1 : 0] out_orv_rst_pc,
  output [STATION_TEST_MTIME_WIDTH - 1 : 0] out_mtime,
  output [STATION_TEST_MTIMEH_WIDTH - 1 : 0] out_mtimeh,
  output [STATION_TEST_MTIMECMP_WIDTH - 1 : 0] out_mtimecmp,
  output [STATION_TEST_MTIMECMPH_WIDTH - 1 : 0] out_mtimecmph,
  output [STATION_TEST_TIMER0_WIDTH - 1 : 0] out_timer0,
  output [STATION_TEST_TIMER0H_WIDTH - 1 : 0] out_timer0h,
  output [STATION_TEST_TIMERCMP0_WIDTH - 1 : 0] out_timercmp0,
  output [STATION_TEST_TIMERCMP0H_WIDTH - 1 : 0] out_timercmp0h,
  output [STATION_TEST_DBG_MEM_START_ADDR_WIDTH - 1 : 0] out_dbg_mem_start_addr,
  output [STATION_TEST_DBG_MEM_END_ADDR_WIDTH - 1 : 0] out_dbg_mem_end_addr,
  output [STATION_TEST_DBG_FROMHOST_ADDR_WIDTH - 1 : 0] out_dbg_fromhost_addr,
  output [STATION_TEST_DBG_TOHOST_ADDR_WIDTH - 1 : 0] out_dbg_tohost_addr,
  output [STATION_TEST_BP_IF_PC_0_WIDTH - 1 : 0] out_bp_if_pc_0,
  output [STATION_TEST_BP_IF_PC_1_WIDTH - 1 : 0] out_bp_if_pc_1,
  output [STATION_TEST_BP_IF_PC_2_WIDTH - 1 : 0] out_bp_if_pc_2,
  output [STATION_TEST_BP_IF_PC_3_WIDTH - 1 : 0] out_bp_if_pc_3,
  output [STATION_TEST_DDR_BYPASS_IN_DATA_DAT_WIDTH - 1 : 0] out_ddr_bypass_in_data_dat,
  output [STATION_TEST_DDR_BYPASS_IN_DATA_AC_WIDTH - 1 : 0] out_ddr_bypass_in_data_ac,
  output [STATION_TEST_DBG_SPI_MODE_WIDTH - 1 : 0] out_dbg_spi_mode,
  output [STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_WIDTH - 1 : 0] out_ddr_bypass_in_data_master,
  output out_orv_early_rstn,
  output out_orv_rstn,
  output out_en_timer0,
  output out_update_timer0,
  output out_debug_stall,
  output out_en_bp_if_pc_0,
  output out_en_bp_if_pc_1,
  output out_en_bp_if_pc_2,
  output out_en_bp_if_pc_3,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_TEST_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_TEST_BLKID;

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_TEST_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_TEST_MAX_RING_ADDR)) station_u (

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

  logic [STATION_TEST_ORV_RST_PC_WIDTH - 1 : 0] rff_orv_rst_pc;
  logic [STATION_TEST_ORV_RST_PC_WIDTH - 1 : 0] orv_rst_pc;
  logic load_orv_rst_pc;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_orv_rst_pc <= STATION_TEST_ORV_RST_PC_RSTVAL;
    end else if (load_orv_rst_pc == 1'b1) begin
      rff_orv_rst_pc <= (wmask & orv_rst_pc) | (wmask_inv & rff_orv_rst_pc);
    end
  end
  assign out_orv_rst_pc = rff_orv_rst_pc;
  logic [STATION_TEST_MTIME_WIDTH - 1 : 0] rff_mtime;
  logic [STATION_TEST_MTIME_WIDTH - 1 : 0] mtime;
  logic load_mtime;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtime <= STATION_TEST_MTIME_RSTVAL;
    end else if (load_mtime == 1'b1) begin
      rff_mtime <= (wmask & mtime) | (wmask_inv & rff_mtime);
    end
  end
  assign out_mtime = rff_mtime;
  logic [STATION_TEST_MTIMEH_WIDTH - 1 : 0] rff_mtimeh;
  logic [STATION_TEST_MTIMEH_WIDTH - 1 : 0] mtimeh;
  logic load_mtimeh;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimeh <= STATION_TEST_MTIMEH_RSTVAL;
    end else if (load_mtimeh == 1'b1) begin
      rff_mtimeh <= (wmask & mtimeh) | (wmask_inv & rff_mtimeh);
    end
  end
  assign out_mtimeh = rff_mtimeh;
  logic [STATION_TEST_MTIMECMP_WIDTH - 1 : 0] rff_mtimecmp;
  logic [STATION_TEST_MTIMECMP_WIDTH - 1 : 0] mtimecmp;
  logic load_mtimecmp;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimecmp <= STATION_TEST_MTIMECMP_RSTVAL;
    end else if (load_mtimecmp == 1'b1) begin
      rff_mtimecmp <= (wmask & mtimecmp) | (wmask_inv & rff_mtimecmp);
    end
  end
  assign out_mtimecmp = rff_mtimecmp;
  logic [STATION_TEST_MTIMECMPH_WIDTH - 1 : 0] rff_mtimecmph;
  logic [STATION_TEST_MTIMECMPH_WIDTH - 1 : 0] mtimecmph;
  logic load_mtimecmph;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimecmph <= STATION_TEST_MTIMECMPH_RSTVAL;
    end else if (load_mtimecmph == 1'b1) begin
      rff_mtimecmph <= (wmask & mtimecmph) | (wmask_inv & rff_mtimecmph);
    end
  end
  assign out_mtimecmph = rff_mtimecmph;
  logic [STATION_TEST_TIMER0_WIDTH - 1 : 0] rff_timer0;
  logic [STATION_TEST_TIMER0_WIDTH - 1 : 0] timer0;
  logic load_timer0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_timer0 <= STATION_TEST_TIMER0_RSTVAL;
    end else if (load_timer0 == 1'b1) begin
      rff_timer0 <= (wmask & timer0) | (wmask_inv & rff_timer0);
    end
  end
  assign out_timer0 = rff_timer0;
  logic [STATION_TEST_TIMER0H_WIDTH - 1 : 0] rff_timer0h;
  logic [STATION_TEST_TIMER0H_WIDTH - 1 : 0] timer0h;
  logic load_timer0h;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_timer0h <= STATION_TEST_TIMER0H_RSTVAL;
    end else if (load_timer0h == 1'b1) begin
      rff_timer0h <= (wmask & timer0h) | (wmask_inv & rff_timer0h);
    end
  end
  assign out_timer0h = rff_timer0h;
  logic [STATION_TEST_TIMERCMP0_WIDTH - 1 : 0] rff_timercmp0;
  logic [STATION_TEST_TIMERCMP0_WIDTH - 1 : 0] timercmp0;
  logic load_timercmp0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_timercmp0 <= STATION_TEST_TIMERCMP0_RSTVAL;
    end else if (load_timercmp0 == 1'b1) begin
      rff_timercmp0 <= (wmask & timercmp0) | (wmask_inv & rff_timercmp0);
    end
  end
  assign out_timercmp0 = rff_timercmp0;
  logic [STATION_TEST_TIMERCMP0H_WIDTH - 1 : 0] rff_timercmp0h;
  logic [STATION_TEST_TIMERCMP0H_WIDTH - 1 : 0] timercmp0h;
  logic load_timercmp0h;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_timercmp0h <= STATION_TEST_TIMERCMP0H_RSTVAL;
    end else if (load_timercmp0h == 1'b1) begin
      rff_timercmp0h <= (wmask & timercmp0h) | (wmask_inv & rff_timercmp0h);
    end
  end
  assign out_timercmp0h = rff_timercmp0h;
  logic [STATION_TEST_DBG_MEM_START_ADDR_WIDTH - 1 : 0] rff_dbg_mem_start_addr;
  logic [STATION_TEST_DBG_MEM_START_ADDR_WIDTH - 1 : 0] dbg_mem_start_addr;
  logic load_dbg_mem_start_addr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_dbg_mem_start_addr <= STATION_TEST_DBG_MEM_START_ADDR_RSTVAL;
    end else if (load_dbg_mem_start_addr == 1'b1) begin
      rff_dbg_mem_start_addr <= (wmask & dbg_mem_start_addr) | (wmask_inv & rff_dbg_mem_start_addr);
    end
  end
  assign out_dbg_mem_start_addr = rff_dbg_mem_start_addr;
  logic [STATION_TEST_DBG_MEM_END_ADDR_WIDTH - 1 : 0] rff_dbg_mem_end_addr;
  logic [STATION_TEST_DBG_MEM_END_ADDR_WIDTH - 1 : 0] dbg_mem_end_addr;
  logic load_dbg_mem_end_addr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_dbg_mem_end_addr <= STATION_TEST_DBG_MEM_END_ADDR_RSTVAL;
    end else if (load_dbg_mem_end_addr == 1'b1) begin
      rff_dbg_mem_end_addr <= (wmask & dbg_mem_end_addr) | (wmask_inv & rff_dbg_mem_end_addr);
    end
  end
  assign out_dbg_mem_end_addr = rff_dbg_mem_end_addr;
  logic [STATION_TEST_DBG_FROMHOST_ADDR_WIDTH - 1 : 0] rff_dbg_fromhost_addr;
  logic [STATION_TEST_DBG_FROMHOST_ADDR_WIDTH - 1 : 0] dbg_fromhost_addr;
  logic load_dbg_fromhost_addr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_dbg_fromhost_addr <= STATION_TEST_DBG_FROMHOST_ADDR_RSTVAL;
    end else if (load_dbg_fromhost_addr == 1'b1) begin
      rff_dbg_fromhost_addr <= (wmask & dbg_fromhost_addr) | (wmask_inv & rff_dbg_fromhost_addr);
    end
  end
  assign out_dbg_fromhost_addr = rff_dbg_fromhost_addr;
  logic [STATION_TEST_DBG_TOHOST_ADDR_WIDTH - 1 : 0] rff_dbg_tohost_addr;
  logic [STATION_TEST_DBG_TOHOST_ADDR_WIDTH - 1 : 0] dbg_tohost_addr;
  logic load_dbg_tohost_addr;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_dbg_tohost_addr <= STATION_TEST_DBG_TOHOST_ADDR_RSTVAL;
    end else if (load_dbg_tohost_addr == 1'b1) begin
      rff_dbg_tohost_addr <= (wmask & dbg_tohost_addr) | (wmask_inv & rff_dbg_tohost_addr);
    end
  end
  assign out_dbg_tohost_addr = rff_dbg_tohost_addr;
  logic [STATION_TEST_BP_IF_PC_0_WIDTH - 1 : 0] rff_bp_if_pc_0;
  logic [STATION_TEST_BP_IF_PC_0_WIDTH - 1 : 0] bp_if_pc_0;
  logic load_bp_if_pc_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_bp_if_pc_0 <= STATION_TEST_BP_IF_PC_0_RSTVAL;
    end else if (load_bp_if_pc_0 == 1'b1) begin
      rff_bp_if_pc_0 <= (wmask & bp_if_pc_0) | (wmask_inv & rff_bp_if_pc_0);
    end
  end
  assign out_bp_if_pc_0 = rff_bp_if_pc_0;
  logic [STATION_TEST_BP_IF_PC_1_WIDTH - 1 : 0] rff_bp_if_pc_1;
  logic [STATION_TEST_BP_IF_PC_1_WIDTH - 1 : 0] bp_if_pc_1;
  logic load_bp_if_pc_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_bp_if_pc_1 <= STATION_TEST_BP_IF_PC_1_RSTVAL;
    end else if (load_bp_if_pc_1 == 1'b1) begin
      rff_bp_if_pc_1 <= (wmask & bp_if_pc_1) | (wmask_inv & rff_bp_if_pc_1);
    end
  end
  assign out_bp_if_pc_1 = rff_bp_if_pc_1;
  logic [STATION_TEST_BP_IF_PC_2_WIDTH - 1 : 0] rff_bp_if_pc_2;
  logic [STATION_TEST_BP_IF_PC_2_WIDTH - 1 : 0] bp_if_pc_2;
  logic load_bp_if_pc_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_bp_if_pc_2 <= STATION_TEST_BP_IF_PC_2_RSTVAL;
    end else if (load_bp_if_pc_2 == 1'b1) begin
      rff_bp_if_pc_2 <= (wmask & bp_if_pc_2) | (wmask_inv & rff_bp_if_pc_2);
    end
  end
  assign out_bp_if_pc_2 = rff_bp_if_pc_2;
  logic [STATION_TEST_BP_IF_PC_3_WIDTH - 1 : 0] rff_bp_if_pc_3;
  logic [STATION_TEST_BP_IF_PC_3_WIDTH - 1 : 0] bp_if_pc_3;
  logic load_bp_if_pc_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_bp_if_pc_3 <= STATION_TEST_BP_IF_PC_3_RSTVAL;
    end else if (load_bp_if_pc_3 == 1'b1) begin
      rff_bp_if_pc_3 <= (wmask & bp_if_pc_3) | (wmask_inv & rff_bp_if_pc_3);
    end
  end
  assign out_bp_if_pc_3 = rff_bp_if_pc_3;
  logic [STATION_TEST_DDR_BYPASS_IN_DATA_DAT_WIDTH - 1 : 0] rff_ddr_bypass_in_data_dat;
  logic [STATION_TEST_DDR_BYPASS_IN_DATA_DAT_WIDTH - 1 : 0] ddr_bypass_in_data_dat;
  logic load_ddr_bypass_in_data_dat;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_ddr_bypass_in_data_dat <= STATION_TEST_DDR_BYPASS_IN_DATA_DAT_RSTVAL;
    end else if (load_ddr_bypass_in_data_dat == 1'b1) begin
      rff_ddr_bypass_in_data_dat <= (wmask & ddr_bypass_in_data_dat) | (wmask_inv & rff_ddr_bypass_in_data_dat);
    end
  end
  assign out_ddr_bypass_in_data_dat = rff_ddr_bypass_in_data_dat;
  logic [STATION_TEST_DDR_BYPASS_IN_DATA_AC_WIDTH - 1 : 0] rff_ddr_bypass_in_data_ac;
  logic [STATION_TEST_DDR_BYPASS_IN_DATA_AC_WIDTH - 1 : 0] ddr_bypass_in_data_ac;
  logic load_ddr_bypass_in_data_ac;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_ddr_bypass_in_data_ac <= STATION_TEST_DDR_BYPASS_IN_DATA_AC_RSTVAL;
    end else if (load_ddr_bypass_in_data_ac == 1'b1) begin
      rff_ddr_bypass_in_data_ac <= (wmask & ddr_bypass_in_data_ac) | (wmask_inv & rff_ddr_bypass_in_data_ac);
    end
  end
  assign out_ddr_bypass_in_data_ac = rff_ddr_bypass_in_data_ac;
  logic [STATION_TEST_DBG_SPI_MODE_WIDTH - 1 : 0] rff_dbg_spi_mode;
  logic [STATION_TEST_DBG_SPI_MODE_WIDTH - 1 : 0] dbg_spi_mode;
  logic load_dbg_spi_mode;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_dbg_spi_mode <= STATION_TEST_DBG_SPI_MODE_RSTVAL;
    end else if (load_dbg_spi_mode == 1'b1) begin
      rff_dbg_spi_mode <= (wmask & dbg_spi_mode) | (wmask_inv & rff_dbg_spi_mode);
    end
  end
  assign out_dbg_spi_mode = rff_dbg_spi_mode;
  logic [STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_WIDTH - 1 : 0] rff_ddr_bypass_in_data_master;
  logic [STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_WIDTH - 1 : 0] ddr_bypass_in_data_master;
  logic load_ddr_bypass_in_data_master;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_ddr_bypass_in_data_master <= STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_RSTVAL;
    end else if (load_ddr_bypass_in_data_master == 1'b1) begin
      rff_ddr_bypass_in_data_master <= (wmask & ddr_bypass_in_data_master) | (wmask_inv & rff_ddr_bypass_in_data_master);
    end
  end
  assign out_ddr_bypass_in_data_master = rff_ddr_bypass_in_data_master;
  logic [STATION_TEST_ORV_EARLY_RSTN_WIDTH - 1 : 0] rff_orv_early_rstn;
  logic [STATION_TEST_ORV_EARLY_RSTN_WIDTH - 1 : 0] orv_early_rstn;
  logic load_orv_early_rstn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_orv_early_rstn <= STATION_TEST_ORV_EARLY_RSTN_RSTVAL;
    end else if (load_orv_early_rstn == 1'b1) begin
      rff_orv_early_rstn <= (wmask & orv_early_rstn) | (wmask_inv & rff_orv_early_rstn);
    end
  end
  assign out_orv_early_rstn = rff_orv_early_rstn;
  logic [STATION_TEST_ORV_RSTN_WIDTH - 1 : 0] rff_orv_rstn;
  logic [STATION_TEST_ORV_RSTN_WIDTH - 1 : 0] orv_rstn;
  logic load_orv_rstn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_orv_rstn <= STATION_TEST_ORV_RSTN_RSTVAL;
    end else if (load_orv_rstn == 1'b1) begin
      rff_orv_rstn <= (wmask & orv_rstn) | (wmask_inv & rff_orv_rstn);
    end
  end
  assign out_orv_rstn = rff_orv_rstn;
  logic [STATION_TEST_EN_TIMER0_WIDTH - 1 : 0] rff_en_timer0;
  logic [STATION_TEST_EN_TIMER0_WIDTH - 1 : 0] en_timer0;
  logic load_en_timer0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_en_timer0 <= STATION_TEST_EN_TIMER0_RSTVAL;
    end else if (load_en_timer0 == 1'b1) begin
      rff_en_timer0 <= (wmask & en_timer0) | (wmask_inv & rff_en_timer0);
    end
  end
  assign out_en_timer0 = rff_en_timer0;
  logic [STATION_TEST_UPDATE_TIMER0_WIDTH - 1 : 0] rff_update_timer0;
  logic [STATION_TEST_UPDATE_TIMER0_WIDTH - 1 : 0] update_timer0;
  logic load_update_timer0;

  logic dff_load_update_timer0_d;
  always_ff @(posedge clk) begin
    dff_load_update_timer0_d <= load_update_timer0;
  end

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_update_timer0 <= STATION_TEST_UPDATE_TIMER0_RSTVAL;
    end else if (load_update_timer0 == 1'b1) begin
      rff_update_timer0 <= (wmask & update_timer0) | (wmask_inv & rff_update_timer0);

    end else if (dff_load_update_timer0_d == 1'b1) begin
      rff_update_timer0 <= STATION_TEST_UPDATE_TIMER0_RSTVAL;
    end
  end
  assign out_update_timer0 = rff_update_timer0;
  logic [STATION_TEST_DEBUG_STALL_WIDTH - 1 : 0] rff_debug_stall;
  logic [STATION_TEST_DEBUG_STALL_WIDTH - 1 : 0] debug_stall;
  logic load_debug_stall;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_debug_stall <= STATION_TEST_DEBUG_STALL_RSTVAL;
    end else if (load_debug_stall == 1'b1) begin
      rff_debug_stall <= (wmask & debug_stall) | (wmask_inv & rff_debug_stall);
    end
  end
  assign out_debug_stall = rff_debug_stall;
  logic [STATION_TEST_EN_BP_IF_PC_0_WIDTH - 1 : 0] rff_en_bp_if_pc_0;
  logic [STATION_TEST_EN_BP_IF_PC_0_WIDTH - 1 : 0] en_bp_if_pc_0;
  logic load_en_bp_if_pc_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_en_bp_if_pc_0 <= STATION_TEST_EN_BP_IF_PC_0_RSTVAL;
    end else if (load_en_bp_if_pc_0 == 1'b1) begin
      rff_en_bp_if_pc_0 <= (wmask & en_bp_if_pc_0) | (wmask_inv & rff_en_bp_if_pc_0);
    end
  end
  assign out_en_bp_if_pc_0 = rff_en_bp_if_pc_0;
  logic [STATION_TEST_EN_BP_IF_PC_1_WIDTH - 1 : 0] rff_en_bp_if_pc_1;
  logic [STATION_TEST_EN_BP_IF_PC_1_WIDTH - 1 : 0] en_bp_if_pc_1;
  logic load_en_bp_if_pc_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_en_bp_if_pc_1 <= STATION_TEST_EN_BP_IF_PC_1_RSTVAL;
    end else if (load_en_bp_if_pc_1 == 1'b1) begin
      rff_en_bp_if_pc_1 <= (wmask & en_bp_if_pc_1) | (wmask_inv & rff_en_bp_if_pc_1);
    end
  end
  assign out_en_bp_if_pc_1 = rff_en_bp_if_pc_1;
  logic [STATION_TEST_EN_BP_IF_PC_2_WIDTH - 1 : 0] rff_en_bp_if_pc_2;
  logic [STATION_TEST_EN_BP_IF_PC_2_WIDTH - 1 : 0] en_bp_if_pc_2;
  logic load_en_bp_if_pc_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_en_bp_if_pc_2 <= STATION_TEST_EN_BP_IF_PC_2_RSTVAL;
    end else if (load_en_bp_if_pc_2 == 1'b1) begin
      rff_en_bp_if_pc_2 <= (wmask & en_bp_if_pc_2) | (wmask_inv & rff_en_bp_if_pc_2);
    end
  end
  assign out_en_bp_if_pc_2 = rff_en_bp_if_pc_2;
  logic [STATION_TEST_EN_BP_IF_PC_3_WIDTH - 1 : 0] rff_en_bp_if_pc_3;
  logic [STATION_TEST_EN_BP_IF_PC_3_WIDTH - 1 : 0] en_bp_if_pc_3;
  logic load_en_bp_if_pc_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_en_bp_if_pc_3 <= STATION_TEST_EN_BP_IF_PC_3_RSTVAL;
    end else if (load_en_bp_if_pc_3 == 1'b1) begin
      rff_en_bp_if_pc_3 <= (wmask & en_bp_if_pc_3) | (wmask_inv & rff_en_bp_if_pc_3);
    end
  end
  assign out_en_bp_if_pc_3 = rff_en_bp_if_pc_3;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_TEST_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_TEST_DATA_WIDTH{1'b0}};
    orv_rst_pc = rff_orv_rst_pc;
    load_orv_rst_pc = 1'b0;
    mtime = rff_mtime;
    load_mtime = 1'b0;
    mtimeh = rff_mtimeh;
    load_mtimeh = 1'b0;
    mtimecmp = rff_mtimecmp;
    load_mtimecmp = 1'b0;
    mtimecmph = rff_mtimecmph;
    load_mtimecmph = 1'b0;
    timer0 = rff_timer0;
    load_timer0 = 1'b0;
    timer0h = rff_timer0h;
    load_timer0h = 1'b0;
    timercmp0 = rff_timercmp0;
    load_timercmp0 = 1'b0;
    timercmp0h = rff_timercmp0h;
    load_timercmp0h = 1'b0;
    dbg_mem_start_addr = rff_dbg_mem_start_addr;
    load_dbg_mem_start_addr = 1'b0;
    dbg_mem_end_addr = rff_dbg_mem_end_addr;
    load_dbg_mem_end_addr = 1'b0;
    dbg_fromhost_addr = rff_dbg_fromhost_addr;
    load_dbg_fromhost_addr = 1'b0;
    dbg_tohost_addr = rff_dbg_tohost_addr;
    load_dbg_tohost_addr = 1'b0;
    bp_if_pc_0 = rff_bp_if_pc_0;
    load_bp_if_pc_0 = 1'b0;
    bp_if_pc_1 = rff_bp_if_pc_1;
    load_bp_if_pc_1 = 1'b0;
    bp_if_pc_2 = rff_bp_if_pc_2;
    load_bp_if_pc_2 = 1'b0;
    bp_if_pc_3 = rff_bp_if_pc_3;
    load_bp_if_pc_3 = 1'b0;
    ddr_bypass_in_data_dat = rff_ddr_bypass_in_data_dat;
    load_ddr_bypass_in_data_dat = 1'b0;
    ddr_bypass_in_data_ac = rff_ddr_bypass_in_data_ac;
    load_ddr_bypass_in_data_ac = 1'b0;
    dbg_spi_mode = rff_dbg_spi_mode;
    load_dbg_spi_mode = 1'b0;
    ddr_bypass_in_data_master = rff_ddr_bypass_in_data_master;
    load_ddr_bypass_in_data_master = 1'b0;
    orv_early_rstn = rff_orv_early_rstn;
    load_orv_early_rstn = 1'b0;
    orv_rstn = rff_orv_rstn;
    load_orv_rstn = 1'b0;
    en_timer0 = rff_en_timer0;
    load_en_timer0 = 1'b0;
    update_timer0 = rff_update_timer0;
    load_update_timer0 = 1'b0;
    debug_stall = rff_debug_stall;
    load_debug_stall = 1'b0;
    en_bp_if_pc_0 = rff_en_bp_if_pc_0;
    load_en_bp_if_pc_0 = 1'b0;
    en_bp_if_pc_1 = rff_en_bp_if_pc_1;
    load_en_bp_if_pc_1 = 1'b0;
    en_bp_if_pc_2 = rff_en_bp_if_pc_2;
    load_en_bp_if_pc_2 = 1'b0;
    en_bp_if_pc_3 = rff_en_bp_if_pc_3;
    load_en_bp_if_pc_3 = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_ORV_RST_PC_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_orv_rst_pc;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIME_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_mtime;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIMEH_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_mtimeh;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIMECMP_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_mtimecmp;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIMECMPH_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_mtimecmph;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMER0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_timer0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMER0H_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_timer0h;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMERCMP0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_timercmp0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMERCMP0H_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_timercmp0h;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_MEM_START_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_dbg_mem_start_addr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_MEM_END_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_dbg_mem_end_addr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_FROMHOST_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_dbg_fromhost_addr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_TOHOST_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_dbg_tohost_addr;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_bp_if_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_1_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_bp_if_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_2_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_bp_if_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_3_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_bp_if_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DDR_BYPASS_IN_DATA_DAT_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_ddr_bypass_in_data_dat;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DDR_BYPASS_IN_DATA_AC_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_ddr_bypass_in_data_ac;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_SPI_MODE_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_dbg_spi_mode;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_ddr_bypass_in_data_master;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_ORV_EARLY_RSTN_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_orv_early_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_ORV_RSTN_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_orv_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_TIMER0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_en_timer0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_UPDATE_TIMER0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_update_timer0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DEBUG_STALL_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_debug_stall;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_en_bp_if_pc_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_1_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_en_bp_if_pc_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_2_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_en_bp_if_pc_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_3_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          data = rff_en_bp_if_pc_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_TEST_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_ORV_RST_PC_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          orv_rst_pc = station2brb_req_w.wdata[STATION_TEST_ORV_RST_PC_WIDTH - 1 : 0];
          load_orv_rst_pc = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIME_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          mtime = station2brb_req_w.wdata[STATION_TEST_MTIME_WIDTH - 1 : 0];
          load_mtime = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIMEH_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          mtimeh = station2brb_req_w.wdata[STATION_TEST_MTIMEH_WIDTH - 1 : 0];
          load_mtimeh = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIMECMP_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          mtimecmp = station2brb_req_w.wdata[STATION_TEST_MTIMECMP_WIDTH - 1 : 0];
          load_mtimecmp = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_MTIMECMPH_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          mtimecmph = station2brb_req_w.wdata[STATION_TEST_MTIMECMPH_WIDTH - 1 : 0];
          load_mtimecmph = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMER0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          timer0 = station2brb_req_w.wdata[STATION_TEST_TIMER0_WIDTH - 1 : 0];
          load_timer0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMER0H_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          timer0h = station2brb_req_w.wdata[STATION_TEST_TIMER0H_WIDTH - 1 : 0];
          load_timer0h = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMERCMP0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          timercmp0 = station2brb_req_w.wdata[STATION_TEST_TIMERCMP0_WIDTH - 1 : 0];
          load_timercmp0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_TIMERCMP0H_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          timercmp0h = station2brb_req_w.wdata[STATION_TEST_TIMERCMP0H_WIDTH - 1 : 0];
          load_timercmp0h = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_MEM_START_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          dbg_mem_start_addr = station2brb_req_w.wdata[STATION_TEST_DBG_MEM_START_ADDR_WIDTH - 1 : 0];
          load_dbg_mem_start_addr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_MEM_END_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          dbg_mem_end_addr = station2brb_req_w.wdata[STATION_TEST_DBG_MEM_END_ADDR_WIDTH - 1 : 0];
          load_dbg_mem_end_addr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_FROMHOST_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          dbg_fromhost_addr = station2brb_req_w.wdata[STATION_TEST_DBG_FROMHOST_ADDR_WIDTH - 1 : 0];
          load_dbg_fromhost_addr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_TOHOST_ADDR_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          dbg_tohost_addr = station2brb_req_w.wdata[STATION_TEST_DBG_TOHOST_ADDR_WIDTH - 1 : 0];
          load_dbg_tohost_addr = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          bp_if_pc_0 = station2brb_req_w.wdata[STATION_TEST_BP_IF_PC_0_WIDTH - 1 : 0];
          load_bp_if_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_1_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          bp_if_pc_1 = station2brb_req_w.wdata[STATION_TEST_BP_IF_PC_1_WIDTH - 1 : 0];
          load_bp_if_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_2_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          bp_if_pc_2 = station2brb_req_w.wdata[STATION_TEST_BP_IF_PC_2_WIDTH - 1 : 0];
          load_bp_if_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_BP_IF_PC_3_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          bp_if_pc_3 = station2brb_req_w.wdata[STATION_TEST_BP_IF_PC_3_WIDTH - 1 : 0];
          load_bp_if_pc_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DDR_BYPASS_IN_DATA_DAT_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          ddr_bypass_in_data_dat = station2brb_req_w.wdata[STATION_TEST_DDR_BYPASS_IN_DATA_DAT_WIDTH - 1 : 0];
          load_ddr_bypass_in_data_dat = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DDR_BYPASS_IN_DATA_AC_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          ddr_bypass_in_data_ac = station2brb_req_w.wdata[STATION_TEST_DDR_BYPASS_IN_DATA_AC_WIDTH - 1 : 0];
          load_ddr_bypass_in_data_ac = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DBG_SPI_MODE_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          dbg_spi_mode = station2brb_req_w.wdata[STATION_TEST_DBG_SPI_MODE_WIDTH - 1 : 0];
          load_dbg_spi_mode = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          ddr_bypass_in_data_master = station2brb_req_w.wdata[STATION_TEST_DDR_BYPASS_IN_DATA_MASTER_WIDTH - 1 : 0];
          load_ddr_bypass_in_data_master = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_ORV_EARLY_RSTN_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          orv_early_rstn = station2brb_req_w.wdata[STATION_TEST_ORV_EARLY_RSTN_WIDTH - 1 : 0];
          load_orv_early_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_ORV_RSTN_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          orv_rstn = station2brb_req_w.wdata[STATION_TEST_ORV_RSTN_WIDTH - 1 : 0];
          load_orv_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_TIMER0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          en_timer0 = station2brb_req_w.wdata[STATION_TEST_EN_TIMER0_WIDTH - 1 : 0];
          load_en_timer0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_UPDATE_TIMER0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          update_timer0 = station2brb_req_w.wdata[STATION_TEST_UPDATE_TIMER0_WIDTH - 1 : 0];
          load_update_timer0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_DEBUG_STALL_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          debug_stall = station2brb_req_w.wdata[STATION_TEST_DEBUG_STALL_WIDTH - 1 : 0];
          load_debug_stall = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_0_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          en_bp_if_pc_0 = station2brb_req_w.wdata[STATION_TEST_EN_BP_IF_PC_0_WIDTH - 1 : 0];
          load_en_bp_if_pc_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_1_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          en_bp_if_pc_1 = station2brb_req_w.wdata[STATION_TEST_EN_BP_IF_PC_1_WIDTH - 1 : 0];
          load_en_bp_if_pc_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_2_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          en_bp_if_pc_2 = station2brb_req_w.wdata[STATION_TEST_EN_BP_IF_PC_2_WIDTH - 1 : 0];
          load_en_bp_if_pc_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_TEST_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_TEST_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_TEST_DATA_WIDTH/8)]} == (STATION_TEST_EN_BP_IF_PC_3_OFFSET >> $clog2(STATION_TEST_DATA_WIDTH/8)))): begin
          en_bp_if_pc_3 = station2brb_req_w.wdata[STATION_TEST_EN_BP_IF_PC_3_WIDTH - 1 : 0];
          load_en_bp_if_pc_3 = station2brb_req_awready & station2brb_req_wready;
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
