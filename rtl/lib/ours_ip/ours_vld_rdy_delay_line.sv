// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_vld_rdy_delay_line #(
  parameter WIDTH = 32,
  parameter DELAY = 2
) (
  input   logic             slave_valid,
  input   logic [WIDTH-1:0] slave_info,
  output  logic             slave_ready,

  output  logic             master_valid,
  output  logic [WIDTH-1:0] master_info,
  input   logic             master_ready,

  input   logic             rstn, clk
  );

  // Instantiation
  logic [DELAY-1:0]             slave_valid_tmp;
  logic [DELAY-1:0][WIDTH-1:0]  slave_info_tmp;
  logic [DELAY-1:0]             slave_ready_tmp;

  logic [DELAY-1:0]             master_valid_tmp;
  logic [DELAY-1:0][WIDTH-1:0]  master_info_tmp;
  logic [DELAY-1:0]             master_ready_tmp;

  generate
    for (genvar i = 0; i < DELAY; i++) begin : OURS_VLD_RDY_BUF
      ours_vld_rdy_buf #(
        .WIDTH(WIDTH),
        .DEPTH(2)
      ) buf_u (
        .slave_valid  (slave_valid_tmp[i]),
        .slave_info   (slave_info_tmp[i]),
        .slave_ready  (slave_ready_tmp[i]),
        .master_valid (master_valid_tmp[i]),
        .master_info  (master_info_tmp[i]),
        .master_ready (master_ready_tmp[i]),
        .rstn         (rstn),
        .clk          (clk));
    end
  endgenerate

  // Connection
  generate
    for (genvar i = 0; i < DELAY-1; i++) begin : CONNECTION
      assign slave_valid_tmp[i+1]  = master_valid_tmp[i];
      assign slave_info_tmp[i+1]   = master_info_tmp[i];
      assign master_ready_tmp[i]   = slave_ready_tmp[i+1];
    end
  endgenerate

  assign slave_valid_tmp[0]        = slave_valid;
  assign slave_info_tmp[0]         = slave_info;
  assign slave_ready               = slave_ready_tmp[0];

  assign master_valid              = master_valid_tmp[DELAY-1];
  assign master_info               = master_info_tmp[DELAY-1];
  assign master_ready_tmp[DELAY-1] = master_ready;

endmodule


