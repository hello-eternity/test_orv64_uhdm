// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_axi_delay_line #(
  parameter AW_WIDTH  = 32,
  parameter W_WIDTH   = 64,
  parameter B_WIDTH   = 8,
  parameter AR_WIDTH  = 32,
  parameter R_WIDTH   = 64,
  parameter DELAY     = 2
) (
  // Slave
  // AW
  input  logic                slave_aw_valid,
  input  logic [AW_WIDTH-1:0] slave_aw_info,
  output logic                slave_aw_ready,
  // W
  input  logic                slave_w_valid,
  input  logic [W_WIDTH-1:0]  slave_w_info,
  output logic                slave_w_ready,
  // AR
  input  logic                slave_ar_valid,
  input  logic [AR_WIDTH-1:0] slave_ar_info,
  output logic                slave_ar_ready,
  // B
  output logic                slave_b_valid,
  output logic [B_WIDTH-1:0]  slave_b_info,
  input  logic                slave_b_ready,
  // R
  output logic                slave_r_valid,
  output logic [R_WIDTH-1:0]  slave_r_info,
  input  logic                slave_r_ready,

  // Master
  // AW
  output logic                master_aw_valid,
  output logic [AW_WIDTH-1:0] master_aw_info,
  input  logic                master_aw_ready,
  // W
  output logic                master_w_valid,
  output logic [W_WIDTH-1:0]  master_w_info,
  input  logic                master_w_ready,
  // AR
  output logic                master_ar_valid,
  output logic [AR_WIDTH-1:0] master_ar_info,
  input  logic                master_ar_ready,
  // B
  input  logic                master_b_valid,
  input  logic [B_WIDTH-1:0]  master_b_info,
  output logic                master_b_ready,
  // R
  input  logic                master_r_valid,
  input  logic [R_WIDTH-1:0]  master_r_info,
  output logic                master_r_ready,

  input  logic                rstn, clk
  );

  // AW
  ours_vld_rdy_delay_line #(
    .WIDTH(AW_WIDTH),
    .DELAY(DELAY)
  ) aw_delay_line_u (
    .slave_valid  (slave_aw_valid),
    .slave_info   (slave_aw_info),
    .slave_ready  (slave_aw_ready),
    .master_valid (master_aw_valid),
    .master_info  (master_aw_info),
    .master_ready (master_aw_ready),
    .rstn         (rstn),
    .clk          (clk)
    );

  // W
  ours_vld_rdy_delay_line #(
    .WIDTH(W_WIDTH),
    .DELAY(DELAY)
  ) w_delay_line_u (
    .slave_valid  (slave_w_valid),
    .slave_info   (slave_w_info),
    .slave_ready  (slave_w_ready),
    .master_valid (master_w_valid),
    .master_info  (master_w_info),
    .master_ready (master_w_ready),
    .rstn         (rstn),
    .clk          (clk)
    );

  // AR
  ours_vld_rdy_delay_line #(
    .WIDTH(AR_WIDTH),
    .DELAY(DELAY)
  ) ar_delay_line_u (
    .slave_valid  (slave_ar_valid),
    .slave_info   (slave_ar_info),
    .slave_ready  (slave_ar_ready),
    .master_valid (master_ar_valid),
    .master_info  (master_ar_info),
    .master_ready (master_ar_ready),
    .rstn         (rstn),
    .clk          (clk)
    );

  // B
  ours_vld_rdy_delay_line #(
    .WIDTH(B_WIDTH),
    .DELAY(DELAY)
  ) b_delay_line_u (
    .slave_valid  (slave_b_valid),
    .slave_info   (slave_b_info),
    .slave_ready  (slave_b_ready),
    .master_valid (master_b_valid),
    .master_info  (master_b_info),
    .master_ready (master_b_ready),
    .rstn         (rstn),
    .clk          (clk)
    );

  // R
  ours_vld_rdy_delay_line #(
    .WIDTH(R_WIDTH),
    .DELAY(DELAY)
  ) r_delay_line_u (
    .slave_valid  (slave_r_valid),
    .slave_info   (slave_r_info),
    .slave_ready  (slave_r_ready),
    .master_valid (master_r_valid),
    .master_info  (master_r_info),
    .master_ready (master_r_ready),
    .rstn         (rstn),
    .clk          (clk)
    );

