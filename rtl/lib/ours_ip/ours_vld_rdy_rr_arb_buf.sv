// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_vld_rdy_rr_arb_buf #(
  parameter BACKEND_DOMAIN = 0,
  parameter N_INPUT       = 2,
  parameter WIDTH         = 32,
  parameter BUF_IN_DEPTH  = 2,
  parameter BUF_OUT_DEPTH = 2
) (
  input   logic [N_INPUT-1:0]             slave_valid,
  input   logic [N_INPUT-1:0][WIDTH-1:0]  slave_info ,
  output  logic [N_INPUT-1:0]             slave_ready,

  output  logic                           master_valid,
  output  logic [WIDTH-1:0]               master_info ,
  input   logic                           master_ready,

  output  logic                           clk_en,

  input   logic                           rstn, clk
);

  logic                           clkg;
  // Input Buffer
  logic [N_INPUT-1:0]             slave_valid_buf_o;
  logic [N_INPUT-1:0][WIDTH-1:0]  slave_info_buf_o ;
  logic [N_INPUT-1:0]             slave_ready_buf_o;

  logic                           master_valid_buf_i;
  logic [WIDTH-1:0]               master_info_buf_i;
  logic                           master_ready_buf_i;

  logic [N_INPUT-1:0]             buf_in_clk_en;
  logic                           buf_out_clk_en;

  generate
    for (genvar i = 0; i < N_INPUT; i++) begin : BUF_IN
      ours_vld_rdy_buf #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH), .DEPTH(BUF_IN_DEPTH)) slave_buf_u (
        .slave_valid  (slave_valid[i]),
        .slave_info   (slave_info[i]),
        .slave_ready  (slave_ready[i]),
        .master_valid (slave_valid_buf_o[i]),
        .master_info  (slave_info_buf_o[i]),
        .master_ready (slave_ready_buf_o[i]),
        .clk_en       (buf_in_clk_en[i]),
        .rstn         (rstn),
        .clk          (clkg));
    end
  endgenerate

  // Arbitor
  logic [N_INPUT-1:0] grt;

  ours_vld_rdy_rr_arb #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .N_INPUT(N_INPUT)) arb_u (
    .vld  (slave_valid_buf_o),
    .rdy  (master_ready_buf_i),
    .grt  (grt),
    .rstn (rstn),
    .clk  (clkg));

  always_comb begin
    master_valid_buf_i  = |grt;
    slave_ready_buf_o = {N_INPUT{master_ready_buf_i}} & grt;
  end

  logic [WIDTH-1:0][N_INPUT-1:0] slave_info_buf_o_grt;
  generate
    for (genvar i = 0; i < N_INPUT; i++) begin
      for (genvar j = 0; j < WIDTH; j++) begin
        assign slave_info_buf_o_grt[j][i] = slave_info_buf_o[i][j] & grt[i];
      end
    end
    for (genvar i = 0; i < WIDTH; i++) begin
      assign master_info_buf_i[i] = |slave_info_buf_o_grt[i];
    end
  endgenerate

  // Output Buffer
  ours_vld_rdy_buf #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH), .DEPTH(BUF_OUT_DEPTH)) master_buf_u (
    .slave_valid  (master_valid_buf_i),
    .slave_info   (master_info_buf_i),
    .slave_ready  (master_ready_buf_i),
    .master_valid (master_valid),
    .master_info  (master_info),
    .master_ready (master_ready),
    .clk_en       (buf_out_clk_en),
    .rstn         (rstn),
    .clk          (clkg));

  icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
    .clkg   (clkg),
    .en     (clk_en),
    .tst_en (1'b0),
    .clk    (clk));
  
  assign clk_en = ~rstn | (|buf_in_clk_en) | buf_out_clk_en;

endmodule

