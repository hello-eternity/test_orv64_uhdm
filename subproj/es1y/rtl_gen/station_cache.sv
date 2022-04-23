
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef STATION_CACHE_PKG__SV
`define STATION_CACHE_PKG__SV
package station_cache_pkg;
  localparam int STATION_CACHE_RING_ADDR_WIDTH = 'h19;
  localparam int STATION_CACHE_DATA_WIDTH = 'h40;
  localparam [STATION_CACHE_RING_ADDR_WIDTH-1:0] STATION_CACHE_MAX_RING_ADDR = 'h1ffffff;
  localparam int STATION_CACHE_BLKID_0 = 'ha;
  localparam bit [25 - 1:0] STATION_CACHE_BASE_ADDR_0 = 'ha00000;
  localparam int STATION_CACHE_BLKID_1 = 'hb;
  localparam bit [25 - 1:0] STATION_CACHE_BASE_ADDR_1 = 'hb00000;
  localparam int STATION_CACHE_BLKID_2 = 'hc;
  localparam bit [25 - 1:0] STATION_CACHE_BASE_ADDR_2 = 'hc00000;
  localparam int STATION_CACHE_BLKID_3 = 'hd;
  localparam bit [25 - 1:0] STATION_CACHE_BASE_ADDR_3 = 'hd00000;
  localparam int STATION_CACHE_BLKID_WIDTH = 'h5;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_VLDRAM_OFFSET = 64'h0;
  localparam int STATION_CACHE_DBG_VLDRAM_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_CACHE_DBG_VLDRAM_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_VLDRAM_ADDR_0 = 64'ha00000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_VLDRAM_ADDR_1 = 64'hb00000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_VLDRAM_ADDR_2 = 64'hc00000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_VLDRAM_ADDR_3 = 64'hd00000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DIRTYRAM_OFFSET = 64'h20000;
  localparam int STATION_CACHE_DBG_DIRTYRAM_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_CACHE_DBG_DIRTYRAM_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DIRTYRAM_ADDR_0 = 64'ha20000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DIRTYRAM_ADDR_1 = 64'hb20000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DIRTYRAM_ADDR_2 = 64'hc20000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DIRTYRAM_ADDR_3 = 64'hd20000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_TAGRAM_OFFSET = 64'h40000;
  localparam int STATION_CACHE_DBG_TAGRAM_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_CACHE_DBG_TAGRAM_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_TAGRAM_ADDR_0 = 64'ha40000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_TAGRAM_ADDR_1 = 64'hb40000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_TAGRAM_ADDR_2 = 64'hc40000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_TAGRAM_ADDR_3 = 64'hd40000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DATARAM_OFFSET = 64'h60000;
  localparam int STATION_CACHE_DBG_DATARAM_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_CACHE_DBG_DATARAM_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DATARAM_ADDR_0 = 64'ha60000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DATARAM_ADDR_1 = 64'hb60000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DATARAM_ADDR_2 = 64'hc60000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_DATARAM_ADDR_3 = 64'hd60000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_LRURAM_OFFSET = 64'h80000;
  localparam int STATION_CACHE_DBG_LRURAM_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_CACHE_DBG_LRURAM_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_LRURAM_ADDR_0 = 64'ha80000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_LRURAM_ADDR_1 = 64'hb80000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_LRURAM_ADDR_2 = 64'hc80000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_LRURAM_ADDR_3 = 64'hd80000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_HPM_OFFSET = 64'ha0000;
  localparam int STATION_CACHE_DBG_HPM_WIDTH  = 1048576;
  localparam bit [64 - 1:0] STATION_CACHE_DBG_HPM_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_HPM_ADDR_0 = 64'haa0000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_HPM_ADDR_1 = 64'hba0000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_HPM_ADDR_2 = 64'hca0000;
  localparam bit [25 - 1:0] STATION_CACHE_DBG_HPM_ADDR_3 = 64'hda0000;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_CTRL_REG_OFFSET = 64'hc0000;
  localparam int STATION_CACHE_S2B_CTRL_REG_WIDTH  = 64;
  localparam bit [64 - 1:0] STATION_CACHE_S2B_CTRL_REG_RSTVAL = 40'h0001000000;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_CTRL_REG_ADDR_0 = 64'hac0000;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_CTRL_REG_ADDR_1 = 64'hbc0000;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_CTRL_REG_ADDR_2 = 64'hcc0000;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_CTRL_REG_ADDR_3 = 64'hdc0000;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_RSTN_OFFSET = 64'hc0008;
  localparam int STATION_CACHE_S2B_RSTN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_CACHE_S2B_RSTN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_RSTN_ADDR_0 = 64'hac0008;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_RSTN_ADDR_1 = 64'hbc0008;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_RSTN_ADDR_2 = 64'hcc0008;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_RSTN_ADDR_3 = 64'hdc0008;
  localparam bit [25 - 1:0] STATION_CACHE_S2ICG_CLK_EN_OFFSET = 64'hc0010;
  localparam int STATION_CACHE_S2ICG_CLK_EN_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_CACHE_S2ICG_CLK_EN_RSTVAL = 0;
  localparam bit [25 - 1:0] STATION_CACHE_S2ICG_CLK_EN_ADDR_0 = 64'hac0010;
  localparam bit [25 - 1:0] STATION_CACHE_S2ICG_CLK_EN_ADDR_1 = 64'hbc0010;
  localparam bit [25 - 1:0] STATION_CACHE_S2ICG_CLK_EN_ADDR_2 = 64'hcc0010;
  localparam bit [25 - 1:0] STATION_CACHE_S2ICG_CLK_EN_ADDR_3 = 64'hdc0010;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_ICG_DISABLE_OFFSET = 64'hc0018;
  localparam int STATION_CACHE_S2B_ICG_DISABLE_WIDTH  = 1;
  localparam bit [64 - 1:0] STATION_CACHE_S2B_ICG_DISABLE_RSTVAL = 1;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_ICG_DISABLE_ADDR_0 = 64'hac0018;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_ICG_DISABLE_ADDR_1 = 64'hbc0018;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_ICG_DISABLE_ADDR_2 = 64'hcc0018;
  localparam bit [25 - 1:0] STATION_CACHE_S2B_ICG_DISABLE_ADDR_3 = 64'hdc0018;
endpackage
`endif
`ifndef STATION_CACHE__SV
`define STATION_CACHE__SV
module station_cache
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_cache_pkg::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  # ( parameter int BLOCK_INST_ID = 0 ) (
  output ctrl_reg_t out_s2b_ctrl_reg,
  output out_s2b_rstn,
  output out_s2icg_clk_en,
  output out_s2b_icg_disable,
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
  localparam int                                STATION_ID_WIDTH_0 = STATION_CACHE_BLKID_WIDTH;
  localparam logic [STATION_ID_WIDTH_0 - 1 : 0] LOCAL_STATION_ID_0 =
    (BLOCK_INST_ID == 0) ? STATION_CACHE_BLKID_0 :
    (BLOCK_INST_ID == 1) ? STATION_CACHE_BLKID_1 :
    (BLOCK_INST_ID == 2) ? STATION_CACHE_BLKID_2 :
    (BLOCK_INST_ID == 3) ? STATION_CACHE_BLKID_3 :
    0;

  `ifndef SYNTHESIS
  initial begin
    assert (BLOCK_INST_ID < 4) else $fatal("%m: BLOCK_INST_ID = %d >= 4", BLOCK_INST_ID);
  end
  `endif

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

  oursring_station #(.STATION_ID_WIDTH_0(STATION_ID_WIDTH_0), .LOCAL_STATION_ID_0(LOCAL_STATION_ID_0), .RING_ADDR_WIDTH(STATION_CACHE_RING_ADDR_WIDTH), .MAX_RING_ADDR(STATION_CACHE_MAX_RING_ADDR)) station_u (

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

  ctrl_reg_t rff_s2b_ctrl_reg;
  ctrl_reg_t s2b_ctrl_reg;
  logic load_s2b_ctrl_reg;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_ctrl_reg <= ctrl_reg_t'(STATION_CACHE_S2B_CTRL_REG_RSTVAL);
    end else if (load_s2b_ctrl_reg == 1'b1) begin
      rff_s2b_ctrl_reg <= ctrl_reg_t'((wmask & s2b_ctrl_reg) | (wmask_inv & rff_s2b_ctrl_reg));
    end
  end
  assign out_s2b_ctrl_reg = rff_s2b_ctrl_reg;
  logic [STATION_CACHE_S2B_RSTN_WIDTH - 1 : 0] rff_s2b_rstn;
  logic [STATION_CACHE_S2B_RSTN_WIDTH - 1 : 0] s2b_rstn;
  logic load_s2b_rstn;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_rstn <= STATION_CACHE_S2B_RSTN_RSTVAL;
    end else if (load_s2b_rstn == 1'b1) begin
      rff_s2b_rstn <= (wmask & s2b_rstn) | (wmask_inv & rff_s2b_rstn);
    end
  end
  assign out_s2b_rstn = rff_s2b_rstn;
  logic [STATION_CACHE_S2ICG_CLK_EN_WIDTH - 1 : 0] rff_s2icg_clk_en;
  logic [STATION_CACHE_S2ICG_CLK_EN_WIDTH - 1 : 0] s2icg_clk_en;
  logic load_s2icg_clk_en;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2icg_clk_en <= STATION_CACHE_S2ICG_CLK_EN_RSTVAL;
    end else if (load_s2icg_clk_en == 1'b1) begin
      rff_s2icg_clk_en <= (wmask & s2icg_clk_en) | (wmask_inv & rff_s2icg_clk_en);
    end
  end
  assign out_s2icg_clk_en = rff_s2icg_clk_en;
  logic [STATION_CACHE_S2B_ICG_DISABLE_WIDTH - 1 : 0] rff_s2b_icg_disable;
  logic [STATION_CACHE_S2B_ICG_DISABLE_WIDTH - 1 : 0] s2b_icg_disable;
  logic load_s2b_icg_disable;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_s2b_icg_disable <= STATION_CACHE_S2B_ICG_DISABLE_RSTVAL;
    end else if (load_s2b_icg_disable == 1'b1) begin
      rff_s2b_icg_disable <= (wmask & s2b_icg_disable) | (wmask_inv & rff_s2b_icg_disable);
    end
  end
  assign out_s2b_icg_disable = rff_s2b_icg_disable;

  logic                         rdec;
  logic                         bdec;
  axi4_resp_t                   rresp;
  axi4_resp_t                   bresp;
  logic [STATION_CACHE_DATA_WIDTH - 1 : 0] data;

  always_comb begin
    rdec  = 1'b0;
    bdec  = 1'b0;
    rresp = AXI_RESP_DECERR;
    bresp = AXI_RESP_DECERR;
    data  = {STATION_CACHE_DATA_WIDTH{1'b0}};
    s2b_ctrl_reg = rff_s2b_ctrl_reg;
    load_s2b_ctrl_reg = 1'b0;
    s2b_rstn = rff_s2b_rstn;
    load_s2b_rstn = 1'b0;
    s2icg_clk_en = rff_s2icg_clk_en;
    load_s2icg_clk_en = 1'b0;
    s2b_icg_disable = rff_s2b_icg_disable;
    load_s2b_icg_disable = 1'b0;

    if (station2brb_req_arvalid) begin
      case (1'b1)
        ((station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2B_CTRL_REG_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          data = rff_s2b_ctrl_reg;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2B_RSTN_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          data = rff_s2b_rstn;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          data = rff_s2icg_clk_en;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_ar.araddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2B_ICG_DISABLE_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          data = rff_s2b_icg_disable;
          rdec  = 1'b1;
          rresp = AXI_RESP_OKAY;
        end
        default: begin
          rdec  = 1'b0;
          data  = {STATION_CACHE_DATA_WIDTH{1'b0}};
          rresp = AXI_RESP_DECERR;
        end
      endcase
    end
    if (station2brb_req_awvalid & station2brb_req_wvalid) begin
      case (1'b1)
        ((station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2B_CTRL_REG_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          s2b_ctrl_reg = ctrl_reg_t'(station2brb_req_w.wdata[STATION_CACHE_S2B_CTRL_REG_WIDTH - 1 : 0]);
          load_s2b_ctrl_reg = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2B_RSTN_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          s2b_rstn = station2brb_req_w.wdata[STATION_CACHE_S2B_RSTN_WIDTH - 1 : 0];
          load_s2b_rstn = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2ICG_CLK_EN_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          s2icg_clk_en = station2brb_req_w.wdata[STATION_CACHE_S2ICG_CLK_EN_WIDTH - 1 : 0];
          load_s2icg_clk_en = station2brb_req_awready & station2brb_req_wready;
          bdec  = 1'b1;
          bresp = AXI_RESP_OKAY;
        end
        ((station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-1 -: STATION_ID_WIDTH_0] == LOCAL_STATION_ID_0) && ({{(STATION_ID_WIDTH_0+$clog2(STATION_CACHE_DATA_WIDTH/8)){1'b0}}, station2brb_req_aw.awaddr[STATION_CACHE_RING_ADDR_WIDTH-STATION_ID_WIDTH_0-1:$clog2(STATION_CACHE_DATA_WIDTH/8)]} == (STATION_CACHE_S2B_ICG_DISABLE_OFFSET >> $clog2(STATION_CACHE_DATA_WIDTH/8)))): begin
          s2b_icg_disable = station2brb_req_w.wdata[STATION_CACHE_S2B_ICG_DISABLE_WIDTH - 1 : 0];
          load_s2b_icg_disable = station2brb_req_awready & station2brb_req_wready;
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
