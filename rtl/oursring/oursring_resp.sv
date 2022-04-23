// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module oursring_resp
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter BACKEND_DOMAIN = 0,
  parameter N_IN_PORT = 3,
  parameter N_OUT_PORT = 3
) (
  input oursring_resp_if_b_t i_resp_if_b[N_IN_PORT], 
  input oursring_resp_if_r_t i_resp_if_r[N_IN_PORT], 
  input logic i_resp_if_rvalid[N_IN_PORT], 
  output logic i_resp_if_rready[N_IN_PORT], 
  input logic i_resp_if_bvalid[N_IN_PORT], 
  output logic i_resp_if_bready[N_IN_PORT],
  output oursring_resp_if_b_t o_resp_ppln_if_b[N_OUT_PORT], 
  output oursring_resp_if_r_t o_resp_ppln_if_r[N_OUT_PORT], 
  output logic o_resp_ppln_if_rvalid[N_OUT_PORT], 
  input logic o_resp_ppln_if_rready[N_OUT_PORT], 
  output logic o_resp_ppln_if_bvalid[N_OUT_PORT], 
  input logic o_resp_ppln_if_bready[N_OUT_PORT],
  // if 1, means input port i's destination station id matches output j's station id
  input   logic [N_IN_PORT-1:0] [N_OUT_PORT-1:0]  is_r_dst_match, is_b_dst_match,
  // // extra info for error handling
  // output  logic [N_OUT_PORT-1:0]  o_resp_prev_rvalid, o_resp_prev_rready,
  //                                 o_resp_prev_bvalid, o_resp_prev_bready,
  // rst & clk
  input   logic rstn, clk
);

  oursring_resp_if_b_t  [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_b; 
  oursring_resp_if_r_t  [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_r; 
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_rvld; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_rvld_tmp; 
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_rrdy; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_rrdy_tmp; 
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_bvld; 
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_bvld_tmp; 
  logic                 [N_OUT_PORT-1:0][N_IN_PORT-1:0]  slave_brdy;
  logic                 [N_IN_PORT-1:0][N_OUT_PORT-1:0]  slave_brdy_tmp; 
  oursring_resp_if_b_t  [N_OUT_PORT-1:0] master_b; 
  oursring_resp_if_r_t  [N_OUT_PORT-1:0] master_r; 
  logic                 [N_OUT_PORT-1:0] master_rvld; 
  logic                 [N_OUT_PORT-1:0] master_rrdy; 
  logic                 [N_OUT_PORT-1:0] master_bvld; 
  logic                 [N_OUT_PORT-1:0] master_brdy;

  logic [N_OUT_PORT-1:0] b_clk_en;
  logic [N_OUT_PORT-1:0] r_clk_en;

  logic clkg;

  icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
    .clkg   (clkg),
    .en     (|b_clk_en | |r_clk_en),
    .tst_en (1'b0),
    .clk    (clk));

  generate
    for (genvar i = 0; i < N_IN_PORT; i++) begin : SLAVE_RDY_GEN
      assign i_resp_if_bready[i] = |(slave_brdy_tmp[i] & slave_bvld_tmp[i]);
      assign i_resp_if_rready[i] = |(slave_rrdy_tmp[i] & slave_rvld_tmp[i]);
    end
    for (genvar j = 0; j < N_OUT_PORT; j++) begin : ARB_GEN
      for (genvar i = 0; i < N_IN_PORT; i++) begin : SLAVE_WIRE_GEN
        assign slave_bvld[j][i] = i_resp_if_bvalid[i] & is_b_dst_match[i][j];
        assign slave_b[j][i]    = i_resp_if_b[i];
        assign slave_rvld[j][i] = i_resp_if_rvalid[i] & is_r_dst_match[i][j];
        assign slave_r[j][i]    = i_resp_if_r[i];

        assign slave_bvld_tmp[i][j] = slave_bvld[j][i];
        assign slave_brdy_tmp[i][j] = slave_brdy[j][i];
        assign slave_rvld_tmp[i][j] = slave_rvld[j][i];
        assign slave_rrdy_tmp[i][j] = slave_rrdy[j][i];
      end

      assign o_resp_ppln_if_bvalid[j] = master_bvld[j];
      assign o_resp_ppln_if_b[j]      = master_b[j];
      assign master_brdy[j]           = o_resp_ppln_if_bready[j];

      assign o_resp_ppln_if_rvalid[j] = master_rvld[j];
      assign o_resp_ppln_if_r[j]      = master_r[j];
      assign master_rrdy[j]           = o_resp_ppln_if_rready[j];

      ours_multi_lyr_vld_rdy_rr_arb #(
        .N_INPUT          (N_IN_PORT),
        .WIDTH            ($bits(oursring_resp_if_b_t)),
        .BUF_IN_DEPTH     (2),
        .BUF_OUT_DEPTH    (2),
        .BUF_MID_DEPTH    (2),
        .ARB_MAX_N_PORT   (4)
      ) b_arb_u (
        .slave_valid      (slave_bvld[j]),
        .slave_info       (slave_b[j]),
        .slave_ready      (slave_brdy[j]),
        .master_valid     (master_bvld[j]),
        .master_info      (master_b[j]),
        .master_ready     (master_brdy[j]),
        .clk_en           (b_clk_en[j]),
        .rstn             (rstn),
        .clk              (clkg)
        );

      ours_multi_lyr_axi4_r_rr_arb #(
        .BUF_IN_DEPTH     (2),
        .BUF_OUT_DEPTH    (2),
        .BUF_MID_DEPTH    (2),
        .N_INPUT          (N_IN_PORT),
        .WIDTH            ($bits(oursring_resp_if_r_t)),
        .RLAST_POSITION   (0),
        .ARB_MAX_N_PORT   (4)
      ) r_arb_u (
        .slave_rvld       (slave_rvld[j]),
        .slave_r          (slave_r[j]),
        .slave_rrdy       (slave_rrdy[j]),
        .master_rvld      (master_rvld[j]),
        .master_r         (master_r[j]),
        .master_rrdy      (master_rrdy[j]),
        .clk_en           (r_clk_en[j]),
        .rstn             (rstn),
        .clk              (clkg)
        );
    end
  endgenerate

endmodule

