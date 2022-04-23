// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_multi_lyr_vld_rdy_rr_arb #(
  parameter BACKEND_DOMAIN  = 0,
  parameter N_INPUT         = 8,
  parameter WIDTH           = 32,
  parameter BUF_IN_DEPTH    = 0,
  parameter BUF_OUT_DEPTH   = 0,
  parameter BUF_MID_DEPTH   = 2,
  parameter ARB_MAX_N_PORT  = 4
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
      ) lyr0_buf_u (
        .slave_valid    (slave_valid[0]),
        .slave_info     (slave_info[0]),
        .slave_ready    (slave_ready[0]),
        .master_valid   (master_valid),
        .master_info    (master_info),
        .master_ready   (master_ready),
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

      ours_vld_rdy_rr_arb_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .N_INPUT        (LYR0_FIRST_ARB_PORT_CNT),
        .WIDTH          (WIDTH),
        .BUF_IN_DEPTH   (BUF_IN_DEPTH),
        .BUF_OUT_DEPTH  (BUF_OUT_DEPTH)
      ) lyr0_arb_0_u (
        .slave_valid    (slave_valid[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_info     (slave_info[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_ready    (slave_ready[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .master_valid   (master_valid),
        .master_info    (master_info),
        .master_ready   (master_ready),
        .clk_en         (clk_en),
        .rstn           (rstn),
        .clk            (clkg));
 
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

      logic                                clkg;
      logic [LYR0_ARB_CNT-1:0]             lyr1_valid;
      logic [LYR0_ARB_CNT-1:0][WIDTH-1:0]  lyr1_info ;
      logic [LYR0_ARB_CNT-1:0]             lyr1_ready;

      logic [LYR0_ARB_CNT-1:0]             lyr0_clk_en;
      logic                                lyr1_clk_en;
      // Layer0
      for (genvar i = 0; i < LYR0_ARB_CNT; i++) begin : LYR0_ARBITOR
        if (i == 0) begin
          ours_vld_rdy_rr_arb_buf #(
            .BACKEND_DOMAIN (BACKEND_DOMAIN),
            .N_INPUT        (LYR0_FIRST_ARB_PORT_CNT),
            .WIDTH          (WIDTH),
            .BUF_IN_DEPTH   (BUF_IN_DEPTH),
            .BUF_OUT_DEPTH  (BUF_MID_DEPTH)
          ) lyr0_arb_0_u (
            .slave_valid    (slave_valid[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_info     (slave_info[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_ready    (slave_ready[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .master_valid   (lyr1_valid[i]),
            .master_info    (lyr1_info[i]),
            .master_ready   (lyr1_ready[i]),
            .clk_en         (lyr0_clk_en[i]),
            .rstn           (rstn),
            .clk            (clkg));
        end else begin
          ours_vld_rdy_rr_arb_buf #(
            .BACKEND_DOMAIN (BACKEND_DOMAIN),
            .N_INPUT        (ARB_MAX_N_PORT),
            .WIDTH          (WIDTH),
            .BUF_IN_DEPTH   (BUF_IN_DEPTH),
            .BUF_OUT_DEPTH  (BUF_MID_DEPTH)
          ) lyr0_arb_i_u (
            .slave_valid    (slave_valid[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_info     (slave_info[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_ready    (slave_ready[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .master_valid   (lyr1_valid[i]),
            .master_info    (lyr1_info[i]),
            .master_ready   (lyr1_ready[i]),
            .clk_en         (lyr0_clk_en[i]),
            .rstn           (rstn),
            .clk            (clkg));
        end
      end
      // Layer1
      ours_vld_rdy_rr_arb_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .N_INPUT        (LYR1_FIRST_ARB_PORT_CNT),
        .WIDTH          (WIDTH),
        .BUF_IN_DEPTH   (0),
        .BUF_OUT_DEPTH  (BUF_OUT_DEPTH)
      ) lyr1_arb_0_u (
        .slave_valid    (lyr1_valid),
        .slave_info     (lyr1_info),
        .slave_ready    (lyr1_ready),
        .master_valid   (master_valid),
        .master_info    (master_info),
        .master_ready   (master_ready),
        .clk_en         (lyr1_clk_en),
        .rstn           (rstn),
        .clk            (clkg));

      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

      assign clk_en = ~rstn | (|lyr0_clk_en) | lyr1_clk_en;

    end : LYR_CNT_2
  endgenerate
endmodule
