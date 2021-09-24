// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module oursring_req
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter BACKEND_DOMAIN = 0,
  parameter N_IN_PORT = 3,
  parameter N_OUT_PORT = 3
) (
  input oursring_req_if_ar_t i_req_if_ar[N_IN_PORT], 
  input logic i_req_if_awvalid[N_IN_PORT], 
  output logic i_req_if_awready[N_IN_PORT], 
  input logic i_req_if_wvalid[N_IN_PORT], 
  output logic i_req_if_wready[N_IN_PORT], 
  input logic i_req_if_arvalid[N_IN_PORT], 
  output logic i_req_if_arready[N_IN_PORT], 
  input oursring_req_if_w_t i_req_if_w[N_IN_PORT], 
  input oursring_req_if_aw_t i_req_if_aw[N_IN_PORT],
  output oursring_req_if_ar_t o_req_ppln_if_ar[N_OUT_PORT], 
  output logic o_req_ppln_if_awvalid[N_OUT_PORT], 
  input logic o_req_ppln_if_awready[N_OUT_PORT], 
  output logic o_req_ppln_if_wvalid[N_OUT_PORT], 
  input logic o_req_ppln_if_wready[N_OUT_PORT], 
  output logic o_req_ppln_if_arvalid[N_OUT_PORT], 
  input logic o_req_ppln_if_arready[N_OUT_PORT], 
  output oursring_req_if_w_t o_req_ppln_if_w[N_OUT_PORT], 
  output oursring_req_if_aw_t o_req_ppln_if_aw[N_OUT_PORT],
  // if 1, means input port i's destination station id matches output j's station id
  input   logic [N_IN_PORT-1:0] [N_OUT_PORT-1:0]  is_aw_dst_match, is_ar_dst_match,
  // rst & clk
  input   logic rstn, clk
);
  oursring_req_if_ar_t  [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_ar; 
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_awvld; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_awvld_tmp;
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_awrdy;
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_awrdy_tmp;
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_wvld; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_wvld_tmp;
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_wrdy; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_wrdy_tmp;
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_arvld; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_arvld_tmp;
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_arrdy; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_arrdy_tmp;
  oursring_req_if_w_t   [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_w; 
  oursring_req_if_aw_t  [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_aw;
  oursring_req_if_ar_t  [N_OUT_PORT-1:0] master_ar; 
  logic                 [N_OUT_PORT-1:0] master_awvld; 
  logic                 [N_OUT_PORT-1:0] master_awrdy; 
  logic                 [N_OUT_PORT-1:0] master_wvld; 
  logic                 [N_OUT_PORT-1:0] master_wrdy; 
  logic                 [N_OUT_PORT-1:0] master_arvld; 
  logic                 [N_OUT_PORT-1:0] master_arrdy; 
  oursring_req_if_w_t   [N_OUT_PORT-1:0] master_w; 
  oursring_req_if_aw_t  [N_OUT_PORT-1:0] master_aw;

  logic [N_OUT_PORT-1:0] aw_w_clk_en;
  logic [N_OUT_PORT-1:0] ar_clk_en;

  logic clkg;

  icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
    .clkg   (clkg),
    .en     (|aw_w_clk_en | |ar_clk_en),
    .tst_en (1'b0),
    .clk    (clk));

  generate
    for (genvar i = 0; i < N_IN_PORT; i++) begin : SLAVE_RDY_GEN
      assign i_req_if_awready[i] = |(slave_awrdy_tmp[i] & slave_awvld_tmp[i]);
      assign i_req_if_wready[i]  = |(slave_wrdy_tmp[i] & slave_wvld_tmp[i]);
      assign i_req_if_arready[i] = |(slave_arrdy_tmp[i] & slave_arvld_tmp[i]);
    end
    for (genvar j = 0; j < N_OUT_PORT; j++) begin : ARB_GEN
      for (genvar i = 0; i < N_IN_PORT; i++) begin : SLAVE_WIRE_GEN
        assign slave_awvld[j][i]  = i_req_if_awvalid[i] & i_req_if_wvalid[i] & slave_awrdy[j][i] & slave_wrdy[j][i] & is_aw_dst_match[i][j];
        assign slave_aw[j][i]     = i_req_if_aw[i];
        assign slave_wvld[j][i]   = i_req_if_awvalid[i] & i_req_if_wvalid[i] & slave_awrdy[j][i] & slave_wrdy[j][i] & is_aw_dst_match[i][j];
        assign slave_w[j][i]      = i_req_if_w[i];
        assign slave_arvld[j][i]  = i_req_if_arvalid[i] & is_ar_dst_match[i][j];
        assign slave_ar[j][i]     = i_req_if_ar[i];

        assign slave_awvld_tmp[i][j] = slave_awvld[j][i];
        assign slave_awrdy_tmp[i][j] = slave_awrdy[j][i];
        assign slave_wvld_tmp[i][j]  = slave_wvld[j][i];
        assign slave_wrdy_tmp[i][j]  = slave_wrdy[j][i];
        assign slave_arvld_tmp[i][j] = slave_arvld[j][i];
        assign slave_arrdy_tmp[i][j] = slave_arrdy[j][i];
      end

      assign o_req_ppln_if_awvalid[j] = master_awvld[j];
      assign o_req_ppln_if_aw[j]      = master_aw[j];
      assign master_awrdy[j]          = o_req_ppln_if_awready[j];
      
      assign o_req_ppln_if_wvalid[j]  = master_wvld[j];
      assign o_req_ppln_if_w[j]       = master_w[j];
      assign master_wrdy[j]           = o_req_ppln_if_wready[j];

      assign o_req_ppln_if_arvalid[j] = master_arvld[j];
      assign o_req_ppln_if_ar[j]      = master_ar[j];
      assign master_arrdy[j]          = o_req_ppln_if_arready[j];

      ours_multi_lyr_axi4_aw_w_rr_arb #(
        .BACKEND_DOMAIN   (BACKEND_DOMAIN),
        .BUF_IN_DEPTH_AW  (2),
        .BUF_OUT_DEPTH_AW (2),
        .BUF_MID_DEPTH_AW (2),
        .BUF_IN_DEPTH_W   (2),
        .BUF_OUT_DEPTH_W  (2),
        .BUF_MID_DEPTH_W  (2),
        .N_INPUT          (N_IN_PORT),
        .AW_WIDTH         ($bits(oursring_req_if_aw_t)),
        .W_WIDTH          ($bits(oursring_req_if_w_t)),
        .WLAST_POSITION   (0),
        .ARB_MAX_N_PORT   (4)
      ) aw_w_arb_u (
        .slave_awvld      (slave_awvld[j]),
        .slave_aw         (slave_aw[j]),
        .slave_awrdy      (slave_awrdy[j]),
        .slave_wvld       (slave_wvld[j]),
        .slave_w          (slave_w[j]),
        .slave_wrdy       (slave_wrdy[j]),
        .master_awvld     (master_awvld[j]),
        .master_aw        (master_aw[j]),
        .master_awrdy     (master_awrdy[j]),
        .master_wvld      (master_wvld[j]),
        .master_w         (master_w[j]),
        .master_wrdy      (master_wrdy[j]),
        .clk_en           (aw_w_clk_en[j]),
        .rstn             (rstn),
        .clk              (clkg)
        );

      ours_multi_lyr_vld_rdy_rr_arb #(
        .BACKEND_DOMAIN   (BACKEND_DOMAIN),
        .N_INPUT          (N_IN_PORT),
        .WIDTH            ($bits(oursring_req_if_ar_t)),
        .BUF_IN_DEPTH     (2),
        .BUF_OUT_DEPTH    (2),
        .BUF_MID_DEPTH    (2),
        .ARB_MAX_N_PORT   (4)
      ) ar_arb_u (
        .slave_valid      (slave_arvld[j]),
        .slave_info       (slave_ar[j]),
        .slave_ready      (slave_arrdy[j]),
        .master_valid     (master_arvld[j]),
        .master_info      (master_ar[j]),
        .master_ready     (master_arrdy[j]),
        .clk_en           (ar_clk_en[j]),
        .rstn             (rstn),
        .clk              (clkg)
        );
    end
  endgenerate

endmodule

