// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// Vld Rdy Buffer. WIDTH is the info size, DEPTH is the fifo depth.
module ours_vld_rdy_buf #(
  parameter BACKEND_DOMAIN = 0,
  parameter WIDTH = 32,
  parameter DEPTH = 2,
  parameter RSTN_EN = 0,
  parameter RSTN_WIDTH = 0,
  parameter RSTN_LSB = 0
) (
  input   logic             slave_valid,
  input   logic [WIDTH-1:0] slave_info,
  output  logic             slave_ready,

  output  logic             master_valid,
  output  logic [WIDTH-1:0] master_info,
  input   logic             master_ready,

  output  logic             clk_en,

  input   logic             rstn, clk
);

  generate
    if (DEPTH == 0) begin : DEPTH_EQ_0
      assign master_valid = slave_valid;
      assign master_info  = slave_info;
      assign slave_ready  = master_ready;
      assign clk_en       = ~rstn | slave_valid;
    end else begin : DEPTH_GT_0
      logic             clkg;
      logic             fifo_empty;
      logic             fifo_full;
      logic [WIDTH-1:0] fifo_dout;
      logic [WIDTH-1:0] fifo_din;
      logic             fifo_we;
      logic             fifo_re;

      icg #(.BACKEND_DOMAIN(BACKEND_DOMAIN)) icg_u (
        .clkg   (clkg),
        .en     (clk_en),
        .tst_en (1'b0),
        .clk    (clk));

      assign clk_en = ~rstn | slave_valid | ~fifo_empty;

      ours_fifo #(.BACKEND_DOMAIN(BACKEND_DOMAIN),
                  .WIDTH(WIDTH), 
                  .DEPTH(DEPTH), 
                  .RSTN_EN(RSTN_EN), 
                  .RSTN_WIDTH(RSTN_WIDTH), 
                  .RSTN_LSB(RSTN_LSB)) 
      fifo_u (
        .empty(fifo_empty),
        .full (fifo_full),
        .dout (fifo_dout),
        .din  (fifo_din),
        .we   (fifo_we),
        .re   (fifo_re),
        .rstn (rstn),
        .clk  (clkg));
    
      assign fifo_we      = slave_valid & ~fifo_full;
      assign fifo_din     = slave_info;
      assign slave_ready  = ~fifo_full;
    
      assign master_valid = ~fifo_empty;
      assign master_info  = fifo_dout;
      assign fifo_re      = master_ready & ~fifo_empty;

    end
  endgenerate

`ifndef SYNTHESIS
 //chk_slave_valid_not_x: assert property (@(posedge clk) disable iff (~rstn) ##1 rstn |-> !$isunknown(slave_valid))
 //   					else `olog_error("OURS_VLD_RDY_BUF", $sformatf("%m: slave_valid is X after reset"));
 //chk_slave_ready_not_x: assert property (@(posedge clk) disable iff (~rstn) ##1 rstn |-> !$isunknown(slave_ready))
 //   					else `olog_error("OURS_VLD_RDY_BUF", $sformatf("%m: slave_ready is X after reset"));
 //chk_master_valid_not_x: assert property (@(posedge clk) disable iff (~rstn) ##1 rstn |-> !$isunknown(master_valid))
 //   					else `olog_error("OURS_VLD_RDY_BUF", $sformatf("%m: master_valid is X after reset"));
 //chk_master_ready_not_x: assert property (@(posedge clk) disable iff (~rstn) ##1 rstn |-> !$isunknown(master_ready))
 //   					else `olog_error("OURS_VLD_RDY_BUF", $sformatf("%m: master_ready is X after reset"));
`endif

endmodule

