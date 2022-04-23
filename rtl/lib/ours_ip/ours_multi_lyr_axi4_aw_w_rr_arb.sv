// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_multi_lyr_axi4_aw_w_rr_arb #(
  parameter BACKEND_DOMAIN    = 0,
  parameter BUF_IN_DEPTH_AW   = 2,
  parameter BUF_OUT_DEPTH_AW  = 2,
  parameter BUF_MID_DEPTH_AW  = 2,
  parameter BUF_IN_DEPTH_W    = 8,
  parameter BUF_OUT_DEPTH_W   = 8,
  parameter BUF_MID_DEPTH_W   = 8,
  parameter N_INPUT           = 2,
  parameter AW_WIDTH          = 32,
  parameter W_WIDTH           = 64,
  parameter WLAST_POSITION    = 0, // w[WLAST_POSITION] is wlast bit
  parameter ARB_MAX_N_PORT    = 4
) (
  input   logic [N_INPUT-1:0]               slave_awvld,
  input   logic [N_INPUT-1:0][AW_WIDTH-1:0] slave_aw,
  output  logic [N_INPUT-1:0]               slave_awrdy,

  input   logic [N_INPUT-1:0]               slave_wvld,
  input   logic [N_INPUT-1:0][W_WIDTH-1:0]  slave_w,
  output  logic [N_INPUT-1:0]               slave_wrdy,

  output  logic                             master_awvld,
  output  logic [AW_WIDTH-1:0]              master_aw,
  input   logic                             master_awrdy,

  output  logic                             master_wvld,
  output  logic [W_WIDTH-1:0]               master_w,
  input   logic                             master_wrdy,

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
      end
      `endif

      logic clkg;
      logic aw_clk_en;
      logic w_clk_en;

      ours_vld_rdy_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .WIDTH          (AW_WIDTH),
        .DEPTH          (BUF_IN_DEPTH_AW + BUF_OUT_DEPTH_AW)
      ) lyr0_aw_buf_u (
        .slave_valid    (slave_awvld[0]),
        .slave_info     (slave_aw[0]),
        .slave_ready    (slave_awrdy[0]),
        .master_valid   (master_awvld),
        .master_info    (master_aw),
        .master_ready   (master_awrdy),
        .clk_en         (aw_clk_en),
        .rstn           (rstn),
        .clk            (clkg));

      ours_vld_rdy_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .WIDTH          (W_WIDTH),
        .DEPTH          (BUF_IN_DEPTH_W + BUF_OUT_DEPTH_W)
      ) lyr0_w_buf_u (
        .slave_valid    (slave_wvld[0]),
        .slave_info     (slave_w[0]),
        .slave_ready    (slave_wrdy[0]),
        .master_valid   (master_wvld),
        .master_info    (master_w),
        .master_ready   (master_wrdy),
        .clk_en         (w_clk_en),
        .rstn           (rstn),
        .clk            (clkg));

      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

      assign clk_en = ~rstn | aw_clk_en | w_clk_en;

    end else if (LYR_CNT == 1) begin : LYR_CNT_1 // Layer0 has only 1 arbior

      logic clkg;

      ours_axi4_aw_w_rr_arb_buf #(
        .BACKEND_DOMAIN   (BACKEND_DOMAIN),
        .BUF_IN_DEPTH_AW  (BUF_IN_DEPTH_AW),
        .BUF_OUT_DEPTH_AW (BUF_OUT_DEPTH_AW),
        .BUF_IN_DEPTH_W   (BUF_IN_DEPTH_W),
        .BUF_OUT_DEPTH_W  (BUF_OUT_DEPTH_W),
        .N_INPUT          (LYR0_FIRST_ARB_PORT_CNT),
        .AW_WIDTH         (AW_WIDTH),
        .W_WIDTH          (W_WIDTH),
        .WLAST_POSITION   (WLAST_POSITION)
      ) lyr0_aw_w_arb_0_u (
        .slave_awvld      (slave_awvld[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_aw         (slave_aw[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_awrdy      (slave_awrdy[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_wvld       (slave_wvld[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_w          (slave_w[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .slave_wrdy       (slave_wrdy[LYR0_FIRST_ARB_PORT_CNT-1:0]),
        .master_awvld     (master_awvld),
        .master_aw        (master_aw),
        .master_awrdy     (master_awrdy),
        .master_wvld      (master_wvld),
        .master_w         (master_w),
        .master_wrdy      (master_wrdy),
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

      logic [LYR0_ARB_CNT-1:0]                lyr1_awvld;
      logic [LYR0_ARB_CNT-1:0][AW_WIDTH-1:0]  lyr1_aw;
      logic [LYR0_ARB_CNT-1:0]                lyr1_awrdy;

      logic [LYR0_ARB_CNT-1:0]                lyr1_wvld;
      logic [LYR0_ARB_CNT-1:0][W_WIDTH-1:0]   lyr1_w;
      logic [LYR0_ARB_CNT-1:0]                lyr1_wrdy;

      logic                                   clkg;
      logic [LYR0_ARB_CNT-1:0]                lyr0_clk_en;
      logic                                   lyr1_clk_en;

      // Layer0
      for (genvar i = 0; i < LYR0_ARB_CNT; i++) begin : LYR0_ARBITOR
        if (i == 0) begin
          ours_axi4_aw_w_rr_arb_buf #(
            .BACKEND_DOMAIN   (BACKEND_DOMAIN),
            .BUF_IN_DEPTH_AW  (BUF_IN_DEPTH_AW),
            .BUF_OUT_DEPTH_AW (BUF_MID_DEPTH_AW),
            .BUF_IN_DEPTH_W   (BUF_IN_DEPTH_W),
            .BUF_OUT_DEPTH_W  (BUF_MID_DEPTH_W),
            .N_INPUT          (LYR0_FIRST_ARB_PORT_CNT),
            .AW_WIDTH         (AW_WIDTH),
            .W_WIDTH          (W_WIDTH),
            .WLAST_POSITION   (WLAST_POSITION)
          ) lyr0_aw_w_arb_0_u (
            .slave_awvld      (slave_awvld[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_aw         (slave_aw[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_awrdy      (slave_awrdy[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_wvld       (slave_wvld[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_w          (slave_w[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .slave_wrdy       (slave_wrdy[LYR0_FIRST_ARB_PORT_CNT-1:0]),
            .master_awvld     (lyr1_awvld[i]),
            .master_aw        (lyr1_aw[i]),
            .master_awrdy     (lyr1_awrdy[i]),
            .master_wvld      (lyr1_wvld[i]),
            .master_w         (lyr1_w[i]),
            .master_wrdy      (lyr1_wrdy[i]),
            .clk_en           (lyr0_clk_en[i]),
            .rstn             (rstn),
            .clk              (clkg));
        end else begin
          ours_axi4_aw_w_rr_arb_buf #(
            .BACKEND_DOMAIN   (BACKEND_DOMAIN),
            .BUF_IN_DEPTH_AW  (BUF_IN_DEPTH_AW),
            .BUF_OUT_DEPTH_AW (BUF_MID_DEPTH_AW),
            .BUF_IN_DEPTH_W   (BUF_IN_DEPTH_W),
            .BUF_OUT_DEPTH_W  (BUF_MID_DEPTH_W),
            .N_INPUT          (ARB_MAX_N_PORT),
            .AW_WIDTH         (AW_WIDTH),
            .W_WIDTH          (W_WIDTH),
            .WLAST_POSITION   (WLAST_POSITION)
          ) lyr0_aw_w_arb_0_u (
            .slave_awvld      (slave_awvld[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_aw         (slave_aw[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_awrdy      (slave_awrdy[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_wvld       (slave_wvld[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_w          (slave_w[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .slave_wrdy       (slave_wrdy[i*ARB_MAX_N_PORT+LYR0_FIRST_ARB_PORT_CNT-1 -: ARB_MAX_N_PORT]),
            .master_awvld     (lyr1_awvld[i]),
            .master_aw        (lyr1_aw[i]),
            .master_awrdy     (lyr1_awrdy[i]),
            .master_wvld      (lyr1_wvld[i]),
            .master_w         (lyr1_w[i]),
            .master_wrdy      (lyr1_wrdy[i]),
            .clk_en           (lyr0_clk_en[i]),
            .rstn             (rstn),
            .clk              (clkg));
        end
      end
      // Layer1
      ours_axi4_aw_w_rr_arb_buf #(
        .BACKEND_DOMAIN   (BACKEND_DOMAIN),
        .BUF_IN_DEPTH_AW  (0),
        .BUF_OUT_DEPTH_AW (BUF_OUT_DEPTH_AW),
        .BUF_IN_DEPTH_W   (0),
        .BUF_OUT_DEPTH_W  (BUF_OUT_DEPTH_W),
        .N_INPUT          (LYR1_FIRST_ARB_PORT_CNT),
        .AW_WIDTH         (AW_WIDTH),
        .W_WIDTH          (W_WIDTH),
        .WLAST_POSITION   (WLAST_POSITION)
      ) lyr1_aw_w_arb_0_u (
        .slave_awvld      (lyr1_awvld),
        .slave_aw         (lyr1_aw),
        .slave_awrdy      (lyr1_awrdy),
        .slave_wvld       (lyr1_wvld),
        .slave_w          (lyr1_w),
        .slave_wrdy       (lyr1_wrdy),
        .master_awvld     (master_awvld),
        .master_aw        (master_aw),
        .master_awrdy     (master_awrdy),
        .master_wvld      (master_wvld),
        .master_w         (master_w),
        .master_wrdy      (master_wrdy),
        .clk_en           (lyr1_clk_en),
        .rstn             (rstn),
        .clk              (clkg));

      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

      assign clk_en = ~rstn | (|lyr0_clk_en) | lyr1_clk_en;

    end : LYR_CNT_2
  endgenerate
endmodule

