// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_axi4_aw_w_rr_arb_buf #(
  parameter BACKEND_DOMAIN    = 0,
  parameter BUF_IN_DEPTH_AW   = 2,
  parameter BUF_OUT_DEPTH_AW  = 2,
  parameter BUF_IN_DEPTH_W    = 8,
  parameter BUF_OUT_DEPTH_W   = 8,
  parameter N_INPUT           = 2,
  parameter AW_WIDTH          = 32,
  parameter W_WIDTH           = 64,
  parameter WLAST_POSITION    = 0 // w[WLAST_POSITION] is wlast bit
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

  // AW
  logic [N_INPUT-1:0]               awvld_ibuf_o;
  logic [N_INPUT-1:0][AW_WIDTH-1:0] aw_ibuf_o;
  logic [N_INPUT-1:0]               awrdy_ibuf_o;

  logic                             awvld_obuf_i;
  logic [AW_WIDTH-1:0]              aw_obuf_i;
  logic                             awrdy_obuf_i;

  // W
  logic [N_INPUT-1:0]               wvld_ibuf_o;
  logic [N_INPUT-1:0][W_WIDTH-1:0]  w_ibuf_o;
  logic [N_INPUT-1:0]               wrdy_ibuf_o;

  logic                             wvld_obuf_i;
  logic [W_WIDTH-1:0]               w_obuf_i;
  logic                             wrdy_obuf_i;

  logic                             clkg;
  logic [N_INPUT-1:0]               aw_ibuf_clk_en;
  logic                             aw_obuf_clk_en;
  logic [N_INPUT-1:0]               w_ibuf_clk_en;
  logic                             w_obuf_clk_en;
  logic                             rffce_aw_sent;
  logic [N_INPUT-1:0]               wlast_ibuf_o;
  logic [N_INPUT-1:0]               grt;
  //logic [N_INPUT-1:0]               arb_vld;
  logic                             rr_nstate_en;

  generate
    for (genvar i = 0; i < N_INPUT; i++) begin : AW_BUF_IN
      ours_vld_rdy_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .WIDTH          (AW_WIDTH), 
        .DEPTH          (BUF_IN_DEPTH_AW)
      ) aw_ibuf_u (
        .slave_valid  (slave_awvld[i]),
        .slave_info   (slave_aw[i]),
        .slave_ready  (slave_awrdy[i]),
        .master_valid (awvld_ibuf_o[i]),
        .master_info  (aw_ibuf_o[i]),
        .master_ready (awrdy_ibuf_o[i]),
        .clk_en       (aw_ibuf_clk_en[i]),
        .rstn         (rstn),
        .clk          (clkg));
    end
    for (genvar i = 0; i < N_INPUT; i++) begin : W_BUF_IN
      ours_vld_rdy_buf #(
        .BACKEND_DOMAIN (BACKEND_DOMAIN),
        .WIDTH          (W_WIDTH), 
        .DEPTH          (BUF_IN_DEPTH_W),
        .RSTN_EN        (1), 
        .RSTN_WIDTH     (1), 
        .RSTN_LSB       (WLAST_POSITION)
      ) w_ibuf_u (
        .slave_valid  (slave_wvld[i]),
        .slave_info   (slave_w[i]),
        .slave_ready  (slave_wrdy[i]),
        .master_valid (wvld_ibuf_o[i]),
        .master_info  (w_ibuf_o[i]),
        .master_ready (wrdy_ibuf_o[i]),
        .clk_en       (w_ibuf_clk_en[i]),
        .rstn         (rstn),
        .clk          (clkg));
    end
  endgenerate

  generate
    if (N_INPUT > 1) begin : N_INPUT_GT_1
      // Arbitor
      logic               arb_rdy;
      logic               dff_awvld_obuf_i;
      logic               rff_vld_d;
      logic               rff_rdy_d;

      for (genvar i = 0; i < N_INPUT; i++) begin : WLAST_IBUF_O
        assign wlast_ibuf_o[i] = w_ibuf_o[i][WLAST_POSITION];
      end

      //assign arb_vld = awvld_ibuf_o & wvld_ibuf_o;
      assign rr_nstate_en = |awrdy_ibuf_o | ~|(grt & awvld_ibuf_o); 
      ours_one_hot_rr_arb #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .N_INPUT(N_INPUT)) arb_u (
        .en   (rr_nstate_en),
        .grt  (grt),
        .rstn (rstn),
        .clk  (clk));

      //always_ff @(posedge clk) begin
      //  if (rstn == 1'b0) begin
      //    rff_vld_d <= 1'b0;
      //    rff_rdy_d <= 1'b0;
      //  end else begin
      //    rff_vld_d <= |(awvld_ibuf_o & {N_INPUT{awrdy_obuf_i}});
      //    rff_rdy_d <= awrdy_ibuf_o;
      //  end
      //end

      //always_ff @(posedge clk) begin
      //  if ((|arb_vld) & (~rff_vld_d | rff_rdy_d)) begin
      //    dff_awvld_obuf_i <= 1'b1;
      //  end else begin
      //    dff_awvld_obuf_i <= 1'b0;
      //  end
      //end

      always_comb begin
        awvld_obuf_i  = |(grt & awvld_ibuf_o & {N_INPUT{wrdy_obuf_i & awrdy_obuf_i}} & wlast_ibuf_o & wvld_ibuf_o);
        awrdy_ibuf_o  = {N_INPUT{wrdy_obuf_i & awrdy_obuf_i}} & grt & wlast_ibuf_o & wvld_ibuf_o & awvld_ibuf_o;

        wvld_obuf_i   = |(grt & wvld_ibuf_o & awvld_ibuf_o & {N_INPUT{wrdy_obuf_i & awrdy_obuf_i}});
        wrdy_ibuf_o   = grt & awvld_ibuf_o & {N_INPUT{wrdy_obuf_i & awrdy_obuf_i}};
      end

      logic [AW_WIDTH-1:0][N_INPUT-1:0] aw_obuf_grt;
      for (genvar i = 0; i < N_INPUT; i++) begin
        for (genvar j = 0; j < AW_WIDTH; j++) begin
          assign aw_obuf_grt[j][i] = aw_ibuf_o[i][j] & grt[i];
        end
      end
      for (genvar i = 0; i < AW_WIDTH; i++) begin
        assign aw_obuf_i[i] = |aw_obuf_grt[i];
      end

      logic [W_WIDTH-1:0][N_INPUT-1:0] w_obuf_grt;
      for (genvar i = 0; i < N_INPUT; i++) begin
        for (genvar j = 0; j < W_WIDTH; j++) begin
          assign w_obuf_grt[j][i] = w_ibuf_o[i][j] & grt[i];
        end
      end
      for (genvar i = 0; i < W_WIDTH; i++) begin
        assign w_obuf_i[i] = |w_obuf_grt[i];
      end
    end else begin : N_INPUT_EQ_1
      assign awvld_obuf_i     = awvld_ibuf_o[0];
      assign aw_obuf_i        = aw_ibuf_o[0];
      assign awrdy_ibuf_o[0]  = awrdy_obuf_i;

      assign wvld_obuf_i      = wvld_ibuf_o[0];
      assign w_obuf_i         = w_ibuf_o[0];
      assign wrdy_ibuf_o[0]   = wrdy_obuf_i;
    end
  endgenerate
  
  always_ff @(posedge clk) begin
    if (~rstn) begin
      rffce_aw_sent <= 1'b0;
    end else if ((awvld_obuf_i & awrdy_obuf_i) ^ (rr_nstate_en & rffce_aw_sent)) begin
      rffce_aw_sent <= ~rffce_aw_sent;
    end
  end
  
  ours_vld_rdy_buf #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(AW_WIDTH), .DEPTH(BUF_OUT_DEPTH_AW)) aw_obuf_u (
    .slave_valid  (awvld_obuf_i),
    .slave_info   (aw_obuf_i),
    .slave_ready  (awrdy_obuf_i),
    .master_valid (master_awvld),
    .master_info  (master_aw),
    .master_ready (master_awrdy),
    .clk_en       (aw_obuf_clk_en),
    .rstn         (rstn),
    .clk          (clkg));

  ours_vld_rdy_buf #(.BACKEND_DOMAIN(BACKEND_DOMAIN),
                     .WIDTH(W_WIDTH), 
                     .DEPTH(BUF_OUT_DEPTH_W), 
                     .RSTN_EN(1), 
                     .RSTN_WIDTH(1), 
                     .RSTN_LSB(WLAST_POSITION))
  w_obuf_u (
    .slave_valid  (wvld_obuf_i),
    .slave_info   (w_obuf_i),
    .slave_ready  (wrdy_obuf_i),
    .master_valid (master_wvld),
    .master_info  (master_w),
    .master_ready (master_wrdy),
    .clk_en       (w_obuf_clk_en),
    .rstn         (rstn),
    .clk          (clkg));

  icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
    .clkg   (clkg),
    .en     (clk_en),
    .tst_en (1'b0),
    .clk    (clk));

  assign clk_en = ~rstn | (|aw_ibuf_clk_en) | (|w_ibuf_clk_en) | aw_obuf_clk_en | w_obuf_clk_en;

endmodule

