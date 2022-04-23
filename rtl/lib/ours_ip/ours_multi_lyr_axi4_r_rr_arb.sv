// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_multi_lyr_axi4_r_rr_arb #(
  parameter BACKEND_DOMAIN    = 0,
  parameter BUF_IN_DEPTH      = 8,
  parameter BUF_OUT_DEPTH     = 8,
  parameter BUF_MID_DEPTH     = 8,
  parameter N_INPUT           = 2,
  parameter WIDTH             = 64,
  parameter RLAST_POSITION    = 0, // r[RLAST_POSITION] is rlast bit
  parameter ARB_MAX_N_PORT    = 4
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

  // For now, assume maximum 2 level needed
  localparam LYR_CNT                  = ($clog2(N_INPUT) + 1) / 2;
  localparam LYR0_ARB_CNT             = (N_INPUT + ARB_MAX_N_PORT - 1) / ARB_MAX_N_PORT;
  localparam LYR0_FIRST_ARB_PORT_CNT  = ((N_INPUT % ARB_MAX_N_PORT) == 0) ? ARB_MAX_N_PORT : (N_INPUT % ARB_MAX_N_PORT);
  localparam LYR1_ARB_CNT             = (LYR0_ARB_CNT + ARB_MAX_N_PORT - 1) / ARB_MAX_N_PORT;
  localparam LYR1_FIRST_ARB_PORT_CNT  = ((LYR0_ARB_CNT % ARB_MAX_N_PORT) == 0) ? ARB_MAX_N_PORT : (LYR0_ARB_CNT % ARB_MAX_N_PORT);

  generate
    if (LYR_CNT == 0) begin : LYR_CNT_0 // No arbitor, LYR0_FIRST_ARB_PORT_CNT == 1, LRY0_ARB_CNT == 0
      
      // Assertions
      `ifndef SYNTHESIS
      initial begin
        assert (LYR0_FIRST_ARB_PORT_CNT == 1) else $error ("%m : LYR0_FIRST_ARB_PORT_CNT (%d) != 1", LYR0_FIRST_ARB_PORT_CNT);
        assert (N_INPUT == 1) else $error ("%m : N_INPUT (%d) != 1", N_INPUT);
      end
      `endif

      logic clkg;

      ours_vld_rdy_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .WIDTH          (WIDTH),
        .DEPTH          (BUF_IN_DEPTH + BUF_OUT_DEPTH)
      ) lyr0_w_buf_u (
        .slave_valid    (slave_rvld[0]),
        .slave_info     (slave_r[0]),
        .slave_ready    (slave_rrdy[0]),
        .master_valid   (master_rvld),
        .master_info    (master_r),
        .master_ready   (master_rrdy),
        .clk_en         (clk_en),
        .rstn           (rstn),
        .clk            (clkg));

      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

    end else if (LYR_CNT == 1) begin : LYR_CNT_1 // Layer0 has only 1 arbior

      logic clkg;

      ours_axi4_r_rr_arb_buf #(
        .BACKEND_DOMAIN   (BACKEND_DOMAIN),
        .BUF_IN_DEPTH     (BUF_IN_DEPTH),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH),
        .N_INPUT          (LYR0_FIRST_ARB_PORT_CNT),
        .WIDTH            (WIDTH),
        .RLAST_POSITION   (RLAST_POSITION)
      ) lyr0_r_arb_0_u (
        .slave_rvld       (slave_rvld[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_r          (slave_r[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_rrdy       (slave_rrdy[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .master_rvld      (master_rvld),
        .master_r         (master_r),
        .master_rrdy      (master_rrdy),
        .clk_en           (clk_en),
        .rstn             (rstn),
        .clk              (clkg));
 
      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

    end else if (LYR_CNT == 2) begin : LYR_CNT_2 // Layer1 has only 1 arbitor

      // Assertions
      `ifndef SYNTHESIS
      initial begin
        assert (LYR0_ARB_CNT == LYR1_FIRST_ARB_PORT_CNT) else $error ("%m : LYR0_ARB_CNT (%d) != LYR1_FIRST_ARB_PORT_CNT (%d)", LYR0_ARB_CNT, LYR1_FIRST_ARB_PORT_CNT);
      end
      `endif

      logic [LYR0_ARB_CNT-1:0]                lyr1_rvld;
      logic [LYR0_ARB_CNT-1:0][WIDTH-1:0]     lyr1_r;
      logic [LYR0_ARB_CNT-1:0]                lyr1_rrdy;

      logic                                   clkg;
      logic [LYR0_ARB_CNT-1:0]                lyr0_clk_en;
      logic                                   lyr1_clk_en;

      // Layer0
      for (genvar i = 0; i < LYR0_ARB_CNT; i++) begin : LYR0_ARBITOR
        if (i == 0) begin
          ours_axi4_r_rr_arb_buf #(
            .BACKEND_DOMAIN   (BACKEND_DOMAIN),
            .BUF_IN_DEPTH     (BUF_IN_DEPTH),
            .BUF_OUT_DEPTH    (BUF_MID_DEPTH),
            .N_INPUT          (LYR0_FIRST_ARB_PORT_CNT),
            .WIDTH            (WIDTH),
            .RLAST_POSITION   (RLAST_POSITION)
          ) lyr0_r_arb_0_u (
            .slave_rvld       (slave_rvld[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_r          (slave_r[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_rrdy       (slave_rrdy[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .master_rvld      (lyr1_rvld[i]),
            .master_r         (lyr1_r[i]),
            .master_rrdy      (lyr1_rrdy[i]),
            .clk_en           (lyr0_clk_en[i]),
            .rstn             (rstn),
            .clk              (clkg));
        end else begin
          ours_axi4_r_rr_arb_buf #(
            .BACKEND_DOMAIN   (BACKEND_DOMAIN),
            .BUF_IN_DEPTH     (BUF_IN_DEPTH),
            .BUF_OUT_DEPTH    (BUF_MID_DEPTH),
            .N_INPUT          (ARB_MAX_N_PORT),
            .WIDTH            (WIDTH),
            .RLAST_POSITION   (RLAST_POSITION)
          ) lyr0_r_arb_0_u (
            .slave_rvld       (slave_rvld[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_r          (slave_r[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_rrdy       (slave_rrdy[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .master_rvld      (lyr1_rvld[i]),
            .master_r         (lyr1_r[i]),
            .master_rrdy      (lyr1_rrdy[i]),
            .clk_en           (lyr0_clk_en[i]),
            .rstn             (rstn),
            .clk              (clkg));
        end
      end
      // Layer1
      ours_axi4_r_rr_arb_buf #(
        .BACKEND_DOMAIN   (BACKEND_DOMAIN),
        .BUF_IN_DEPTH     (0),
        .BUF_OUT_DEPTH    (BUF_OUT_DEPTH),
        .N_INPUT          (LYR1_FIRST_ARB_PORT_CNT),
        .WIDTH            (WIDTH),
        .RLAST_POSITION   (RLAST_POSITION)
      ) lyr1_r_arb_0_u (
        .slave_rvld       (lyr1_rvld),
        .slave_r          (lyr1_r),
        .slave_rrdy       (lyr1_rrdy),
        .master_rvld      (master_rvld),
        .master_r         (master_r),
        .master_rrdy      (master_rrdy),
        .clk_en           (lyr1_clk_en),
        .rstn             (rstn),
        .clk              (clkg));

      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .async_en(1'b0),
        .async_clk(1'b0),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

      assign clk_en = ~rstn | (|lyr0_clk_en) | lyr1_clk_en;

    end : LYR_CNT_2
  endgenerate
endmodule

