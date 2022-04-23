
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_PLL_PKG__SV
`define STATION_PLL_PKG__SV
package station_pll_pkg;
  localparam int STATION_PLL_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_PLL_DATA_WIDTH = 'h40;
  localparam [STATION_PLL_RING_ADDR_WIDTH-1:0] STATION_PLL_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_PLL_BLKID_SUB_0 = 'h1;
  localparam int STATION_PLL_BLKID_WIDTH_SUB_0 = 'h2;
  localparam int STATION_PLL_BLKID_SUB_1 = 'h1;
  localparam int STATION_PLL_BLKID_WIDTH_SUB_1 = 'h1;
  localparam bit [25 - 1:0] STATION_PLL_SYSTEM_CFG_OFFSET = 64'h10;
  localparam int STATION_PLL_SYSTEM_CFG_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_SYSTEM_CFG_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_PLL_SYSTEM_CFG_ADDR = 64'h800010;
  localparam bit [25 - 1:0] STATION_PLL_SOFTWARE_INT_VP_0_1_OFFSET = 64'h0;
  localparam int STATION_PLL_SOFTWARE_INT_VP_0_1_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_SOFTWARE_INT_VP_0_1_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_PLL_SOFTWARE_INT_VP_0_1_ADDR = 64'h800000;
  localparam bit [25 - 1:0] STATION_PLL_SOFTWARE_INT_VP_2_3_OFFSET = 64'h8;
  localparam int STATION_PLL_SOFTWARE_INT_VP_2_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_SOFTWARE_INT_VP_2_3_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_PLL_SOFTWARE_INT_VP_2_3_ADDR = 64'h800008;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_0_OFFSET = 64'h4000;
  localparam int STATION_PLL_MTIMECMP_VP_0_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_MTIMECMP_VP_0_RSTVAL = 64'hffffffffffffffff;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_0_ADDR = 64'h804000;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_1_OFFSET = 64'h4008;
  localparam int STATION_PLL_MTIMECMP_VP_1_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_MTIMECMP_VP_1_RSTVAL = 64'hffffffffffffffff;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_1_ADDR = 64'h804008;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_2_OFFSET = 64'h4010;
  localparam int STATION_PLL_MTIMECMP_VP_2_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_MTIMECMP_VP_2_RSTVAL = 64'hffffffffffffffff;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_2_ADDR = 64'h804010;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_3_OFFSET = 64'h4018;
  localparam int STATION_PLL_MTIMECMP_VP_3_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_MTIMECMP_VP_3_RSTVAL = 64'hffffffffffffffff;
  localparam bit [25 - 1:0] STATION_PLL_MTIMECMP_VP_3_ADDR = 64'h804018;
  localparam bit [25 - 1:0] STATION_PLL_MTIME_OFFSET = 64'hbff8;
  localparam int STATION_PLL_MTIME_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_PLL_MTIME_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_PLL_MTIME_ADDR = 64'h80bff8;
  localparam bit [25 - 1:0] STATION_PLL_DEBUG_INFO_ENABLE_OFFSET = 64'h4020;
  localparam int STATION_PLL_DEBUG_INFO_ENABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_PLL_DEBUG_INFO_ENABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_PLL_DEBUG_INFO_ENABLE_ADDR = 64'h804020;
endpackage
`endif
`ifndef STATION_PLL__SV
`define STATION_PLL__SV
module station_pll
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_pll_pkg::*;
  import pygmy_typedef::*;
  (
  output [STATION_PLL_SYSTEM_CFG_WIDTH - 1 : 0] out_system_cfg,
  output [STATION_PLL_SOFTWARE_INT_VP_0_1_WIDTH - 1 : 0] out_software_int_vp_0_1,
  output [STATION_PLL_SOFTWARE_INT_VP_2_3_WIDTH - 1 : 0] out_software_int_vp_2_3,
  output timer_t out_mtimecmp_vp_0,
  output timer_t out_mtimecmp_vp_1,
  output timer_t out_mtimecmp_vp_2,
  output timer_t out_mtimecmp_vp_3,
  output out_debug_info_enable,
  output timer_t out_mtime,
  input logic vld_in_mtime,
  input timer_t in_mtime,
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
  localparam int                                  STATION_ID_WIDTH_0 = STATION_PLL_BLKID_WIDTH_SUB_0;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 = STATION_PLL_BLKID_SUB_0;
  localparam int                                  STATION_ID_WIDTH_1 = STATION_PLL_BLKID_WIDTH_SUB_1;
  localparam logic [STATION_ID_WIDTH_1 - 1 : 0] LOCAL_STATION_ID_1 = STATION_PLL_BLKID_SUB_1;

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .NUM_STATION_ID(2), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .STATION_ID_WIDTH_1(STATION_ID_WIDTH_1), .LOCAL_STATION_ID_1(LOCAL_STATION_ID_1), .RING_ADDR_WIDTH(STATION_PLL_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_PLL_MAX_RING_ADDR)) station_u (

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

  logic [STATION_PLL_SYSTEM_CFG_WIDTH - 1 : 0] rff_system_cfg;
  logic [STATION_PLL_SYSTEM_CFG_WIDTH - 1 : 0] system_cfg;
  logic load_system_cfg;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_system_cfg <= STATION_PLL_SYSTEM_CFG_RSTVAL;
    end else if (load_system_cfg == 1'b1) begin
      rff_system_cfg <= (wmask & system_cfg) | (wmask_inv & rff_system_cfg);
    end
  end
  assign out_system_cfg = rff_system_cfg;
  logic [STATION_PLL_SOFTWARE_INT_VP_0_1_WIDTH - 1 : 0] rff_software_int_vp_0_1;
  logic [STATION_PLL_SOFTWARE_INT_VP_0_1_WIDTH - 1 : 0] software_int_vp_0_1;
  logic load_software_int_vp_0_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_software_int_vp_0_1 <= STATION_PLL_SOFTWARE_INT_VP_0_1_RSTVAL;
    end else if (load_software_int_vp_0_1 == 1'b1) begin
      rff_software_int_vp_0_1 <= (wmask & software_int_vp_0_1) | (wmask_inv & rff_software_int_vp_0_1);
    end
  end
  assign out_software_int_vp_0_1 = rff_software_int_vp_0_1;
  logic [STATION_PLL_SOFTWARE_INT_VP_2_3_WIDTH - 1 : 0] rff_software_int_vp_2_3;
  logic [STATION_PLL_SOFTWARE_INT_VP_2_3_WIDTH - 1 : 0] software_int_vp_2_3;
  logic load_software_int_vp_2_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_software_int_vp_2_3 <= STATION_PLL_SOFTWARE_INT_VP_2_3_RSTVAL;
    end else if (load_software_int_vp_2_3 == 1'b1) begin
      rff_software_int_vp_2_3 <= (wmask & software_int_vp_2_3) | (wmask_inv & rff_software_int_vp_2_3);
    end
  end
  assign out_software_int_vp_2_3 = rff_software_int_vp_2_3;
  timer_t rff_mtimecmp_vp_0;
  timer_t mtimecmp_vp_0;
  logic load_mtimecmp_vp_0;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimecmp_vp_0 <= timer_t'(STATION_PLL_MTIMECMP_VP_0_RSTVAL);
    end else if (load_mtimecmp_vp_0 == 1'b1) begin
      rff_mtimecmp_vp_0 <= timer_t'((wmask & mtimecmp_vp_0) | (wmask_inv & rff_mtimecmp_vp_0));
    end
  end
  assign out_mtimecmp_vp_0 = rff_mtimecmp_vp_0;
  timer_t rff_mtimecmp_vp_1;
  timer_t mtimecmp_vp_1;
  logic load_mtimecmp_vp_1;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimecmp_vp_1 <= timer_t'(STATION_PLL_MTIMECMP_VP_1_RSTVAL);
    end else if (load_mtimecmp_vp_1 == 1'b1) begin
      rff_mtimecmp_vp_1 <= timer_t'((wmask & mtimecmp_vp_1) | (wmask_inv & rff_mtimecmp_vp_1));
    end
  end
  assign out_mtimecmp_vp_1 = rff_mtimecmp_vp_1;
  timer_t rff_mtimecmp_vp_2;
  timer_t mtimecmp_vp_2;
  logic load_mtimecmp_vp_2;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimecmp_vp_2 <= timer_t'(STATION_PLL_MTIMECMP_VP_2_RSTVAL);
    end else if (load_mtimecmp_vp_2 == 1'b1) begin
      rff_mtimecmp_vp_2 <= timer_t'((wmask & mtimecmp_vp_2) | (wmask_inv & rff_mtimecmp_vp_2));
    end
  end
  assign out_mtimecmp_vp_2 = rff_mtimecmp_vp_2;
  timer_t rff_mtimecmp_vp_3;
  timer_t mtimecmp_vp_3;
  logic load_mtimecmp_vp_3;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtimecmp_vp_3 <= timer_t'(STATION_PLL_MTIMECMP_VP_3_RSTVAL);
    end else if (load_mtimecmp_vp_3 == 1'b1) begin
      rff_mtimecmp_vp_3 <= timer_t'((wmask & mtimecmp_vp_3) | (wmask_inv & rff_mtimecmp_vp_3));
    end
  end
  assign out_mtimecmp_vp_3 = rff_mtimecmp_vp_3;
  logic [STATION_PLL_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] rff_debug_info_enable;
  logic [STATION_PLL_DEBUG_INFO_ENABLE_WIDTH - 1 : 0] debug_info_enable;
  logic load_debug_info_enable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_debug_info_enable <= STATION_PLL_DEBUG_INFO_ENABLE_RSTVAL;
    end else if (load_debug_info_enable == 1'b1) begin
      rff_debug_info_enable <= (wmask & debug_info_enable) | (wmask_inv & rff_debug_info_enable);
    end
  end
  assign out_debug_info_enable = rff_debug_info_enable;
  timer_t rff_mtime;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_mtime <= timer_t'(STATION_PLL_MTIME_RSTVAL);

    end else if (vld_in_mtime == 1'b1) begin
      rff_mtime <= in_mtime;

    end
  end
  assign out_mtime = rff_mtime;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_PLL_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_PLL_DATA_WIDTH{1'b0}};
    system_cfg = rff_system_cfg;
    load_system_cfg = 1'b0;
    software_int_vp_0_1 = rff_software_int_vp_0_1;
    load_software_int_vp_0_1 = 1'b0;
    software_int_vp_2_3 = rff_software_int_vp_2_3;
    load_software_int_vp_2_3 = 1'b0;
    mtimecmp_vp_0 = rff_mtimecmp_vp_0;
    load_mtimecmp_vp_0 = 1'b0;
    mtimecmp_vp_1 = rff_mtimecmp_vp_1;
    load_mtimecmp_vp_1 = 1'b0;
    mtimecmp_vp_2 = rff_mtimecmp_vp_2;
    load_mtimecmp_vp_2 = 1'b0;
    mtimecmp_vp_3 = rff_mtimecmp_vp_3;
    load_mtimecmp_vp_3 = 1'b0;
    debug_info_enable = rff_debug_info_enable;
    load_debug_info_enable = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_SYSTEM_CFG_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_system_cfg;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_SOFTWARE_INT_VP_0_1_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          if (station2brb_req_ar.araddr[$clog2(STATION_PLL_DATA_WIDTH/8)-1 : 0] == {$clog2(STATION_PLL_DATA_WIDTH/8){1'b0}}) begin
            data = {32'b0, rff_software_int_vp_0_1[31:0]};
          end else begin
            data = {rff_software_int_vp_0_1[63:32], 32'b0};
          end
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_SOFTWARE_INT_VP_2_3_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          if (station2brb_req_ar.araddr[$clog2(STATION_PLL_DATA_WIDTH/8)-1 : 0] == {$clog2(STATION_PLL_DATA_WIDTH/8){1'b0}}) begin
            data = {32'b0, rff_software_int_vp_2_3[31:0]};
          end else begin
            data = {rff_software_int_vp_2_3[63:32], 32'b0};
          end
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_0_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_mtimecmp_vp_0;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_1_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_mtimecmp_vp_1;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_2_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_mtimecmp_vp_2;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_3_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_mtimecmp_vp_3;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_debug_info_enable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIME_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          data = rff_mtime;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_PLL_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_SYSTEM_CFG_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          system_cfg = station2brb_req_w.wdata[STATION_PLL_SYSTEM_CFG_WIDTH - 1 : 0];
          load_system_cfg = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_SOFTWARE_INT_VP_0_1_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          if (station2brb_req_aw.awaddr[$clog2(STATION_PLL_DATA_WIDTH/8)-1 : 0] == {$clog2(STATION_PLL_DATA_WIDTH/8){1'b0}}) begin
            software_int_vp_0_1[31:0] = station2brb_req_w.wdata[31:0];
            load_software_int_vp_0_1 = station2brb_req_awready & station2brb_req_wready;
          end else begin
            software_int_vp_0_1[63:32] = station2brb_req_w.wdata[63:32];
            load_software_int_vp_0_1 = station2brb_req_awready & station2brb_req_wready;
          end
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_SOFTWARE_INT_VP_2_3_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          if (station2brb_req_aw.awaddr[$clog2(STATION_PLL_DATA_WIDTH/8)-1 : 0] == {$clog2(STATION_PLL_DATA_WIDTH/8){1'b0}}) begin
            software_int_vp_2_3[31:0] = station2brb_req_w.wdata[31:0];
            load_software_int_vp_2_3 = station2brb_req_awready & station2brb_req_wready;
          end else begin
            software_int_vp_2_3[63:32] = station2brb_req_w.wdata[63:32];
            load_software_int_vp_2_3 = station2brb_req_awready & station2brb_req_wready;
          end
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_0_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          mtimecmp_vp_0 = timer_t'(station2brb_req_w.wdata[STATION_PLL_MTIMECMP_VP_0_WIDTH - 1 : 0]);
          load_mtimecmp_vp_0 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_1_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          mtimecmp_vp_1 = timer_t'(station2brb_req_w.wdata[STATION_PLL_MTIMECMP_VP_1_WIDTH - 1 : 0]);
          load_mtimecmp_vp_1 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_2_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          mtimecmp_vp_2 = timer_t'(station2brb_req_w.wdata[STATION_PLL_MTIMECMP_VP_2_WIDTH - 1 : 0]);
          load_mtimecmp_vp_2 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_MTIMECMP_VP_3_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          mtimecmp_vp_3 = timer_t'(station2brb_req_w.wdata[STATION_PLL_MTIMECMP_VP_3_WIDTH - 1 : 0]);
          load_mtimecmp_vp_3 = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_PLL_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_PLL_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_PLL_DATA_WIDTH/8)]} == (STATION_PLL_DEBUG_INFO_ENABLE_OFFSET >> $clog2(STATION_PLL_DATA_WIDTH/8)))): begin
          debug_info_enable = station2brb_req_w.wdata[STATION_PLL_DEBUG_INFO_ENABLE_WIDTH - 1 : 0];
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
