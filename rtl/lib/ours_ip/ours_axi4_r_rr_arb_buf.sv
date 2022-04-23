// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_axi4_r_rr_arb_buf #(
  parameter BACKEND_DOMAIN    = 0,
  parameter BUF_IN_DEPTH      = 2,
  parameter BUF_OUT_DEPTH     = 2,
  parameter N_INPUT           = 2,
  parameter WIDTH             = 32,
  parameter RLAST_POSITION    = 0 // r[RLAST_POSITION] is rlast bit
) (
  input   logic [N_INPUT-1:0]               slave_rvld,
  input   logic [N_INPUT-1:0][WIDTH-1:0]    slave_r,
  output  logic [N_INPUT-1:0]               slave_rrdy,

  output  logic                             master_rvld,
  output  logic [WIDTH-1:0]                 master_r,
  input   logic                             master_rrdy,

  output  logic                             clk_en,

  input   logic                             rstn, clk
  );

  logic [N_INPUT-1:0]               rvld_ibuf_o;
  logic [N_INPUT-1:0][WIDTH-1:0]    r_ibuf_o;
  logic [N_INPUT-1:0]               rrdy_ibuf_o;

  logic                             rvld_obuf_i;
  logic [WIDTH-1:0]                 r_obuf_i;
  logic                             rrdy_obuf_i;

  logic                             clkg;
  logic [N_INPUT-1:0]               r_ibuf_clk_en;
  logic                             r_obuf_clk_en;

  generate
    for (genvar i = 0; i < N_INPUT; i++) begin : R_BUF_IN
      ours_vld_rdy_buf #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH), .DEPTH(BUF_IN_DEPTH)) r_ibuf_u (
        .slave_valid  (slave_rvld[i]),
        .slave_info   (slave_r[i]),
        .slave_ready  (slave_rrdy[i]),
        .master_valid (rvld_ibuf_o[i]),
        .master_info  (r_ibuf_o[i]),
        .master_ready (rrdy_ibuf_o[i]),
        .clk_en       (r_ibuf_clk_en[i]),
        .rstn         (rstn),
        .clk          (clkg));
    end
  endgenerate

  generate
    if (N_INPUT > 1) begin : N_INPUT_GT_1
      // Arbitor
      logic [N_INPUT-1:0] grt;
      logic               rff_r_done;
      logic               arb_rdy;

      always_ff @(posedge clk) begin
        if (rstn == 1'b0) begin
          rff_r_done <= 1'b1;
        end else begin
          if (|grt & arb_rdy) begin
            rff_r_done <= 1'b0;
          end else if (rrdy_obuf_i) begin
            rff_r_done <= 1'b1;
          end
        end
      end

      assign arb_rdy = rff_r_done | (rrdy_obuf_i & r_obuf_i[RLAST_POSITION]);

      ours_vld_rdy_rr_arb #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .N_INPUT(N_INPUT)) arb_u (
        .vld  (rvld_ibuf_o),
        .rdy  (arb_rdy),
        .grt  (grt),
        .rstn (rstn),
        .clk  (clk));

      always_comb begin
        rvld_obuf_i   = |grt;
        rrdy_ibuf_o   = {N_INPUT{rrdy_obuf_i}} & grt;
      end

      logic [WIDTH-1:0][N_INPUT-1:0] r_obuf_grt;
      for (genvar i = 0; i < N_INPUT; i++) begin
        for (genvar j = 0; j < WIDTH; j++) begin
          assign r_obuf_grt[j][i] = r_ibuf_o[i][j] & grt[i];
        end
      end
      for (genvar i = 0; i < WIDTH; i++) begin
        assign r_obuf_i[i] = |r_obuf_grt[i];
      end
    end else begin : N_INPUT_EQ_1
      assign rvld_obuf_i    = rvld_ibuf_o[0];
      assign r_obuf_i       = r_ibuf_o[0];
      assign rrdy_ibuf_o[0] = rrdy_obuf_i;
    end
  endgenerate

  ours_vld_rdy_buf #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH), .DEPTH(BUF_OUT_DEPTH)) r_obuf_u (
    .slave_valid  (rvld_obuf_i),
    .slave_info   (r_obuf_i),
    .slave_ready  (rrdy_obuf_i),
    .master_valid (master_rvld),
    .master_info  (master_r),
    .master_ready (master_rrdy),
    .clk_en       (r_obuf_clk_en),
    .rstn         (rstn),
    .clk          (clkg));

  icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
    .clkg   (clkg),
    .en     (clk_en),
    .tst_en (1'b0),
    .clk    (clk));

  assign clk_en = ~rstn | (|r_ibuf_clk_en) | r_obuf_clk_en;

endmodule

