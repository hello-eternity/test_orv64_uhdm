// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_fifo #(
  parameter int BACKEND_DOMAIN = 0,
  parameter WIDTH=32,
  parameter DEPTH=2,
  parameter RSTN_EN=0,
  parameter RSTN_WIDTH=0,
  parameter RSTN_LSB=0
) (
  output  logic             empty,
  output  logic             full,
  output  logic [WIDTH-1:0] dout,

  input   logic [WIDTH-1:0] din,
  input   logic             we,
  input   logic             re,
  input   logic             rstn, clk
);

  localparam DEPTH_BITS = $clog2(DEPTH);

generate
  if (DEPTH == 1) begin

    logic            [WIDTH-1:0]  dff_fifo_ram;
    logic                         rff_empty, rff_full;
    assign empty = rff_empty;
    assign full  = rff_full;

    assign dout = dff_fifo_ram;

    if (RSTN_EN != 0) begin : RFF_FIFO
      always @(posedge clk)
        if(!rstn)
          dff_fifo_ram[RSTN_LSB+RSTN_WIDTH-1:RSTN_LSB] <= {RSTN_WIDTH{1'b0}};
        else if (we) 
          dff_fifo_ram <= din;

    end // RFF_FIFO
    else begin : DFF_FIFO
      always @(posedge clk)
        if (we) 
          dff_fifo_ram <= din;
    end // DFF_FIFO

    always @(posedge clk) begin
      if (!rstn) begin
        rff_empty     <= 1'b1;
        rff_full      <= 1'b0;
      end else begin
        unique case ({we, re})
          2'b10: begin
            rff_empty <= 1'b0;
            rff_full  <= 1'b1;
          end
          2'b01: begin
            rff_empty <= 1'b1;
            rff_full  <= 1'b0;
          end
          default: begin
            rff_empty <= rff_empty;
            rff_full  <= rff_full;
          end
        endcase
      end
    end

  end else begin

    logic [DEPTH-1:0][WIDTH-1:0]  dff_fifo_ram;
    logic [DEPTH_BITS-1:0]        rff_head, rff_tail, nhead, ntail;
    logic                         rff_empty, rff_full;
    assign empty = rff_empty;
    assign full  = rff_full;

`ifndef SYNTHESIS
    initial begin
      assert (DEPTH == 2**DEPTH_BITS) else $error ("%m : depth must be pwr of two");
    end
`endif

    if (RSTN_EN != 0) begin : RFF_FIFO
      assign dout = dff_fifo_ram[rff_head];
      always @(posedge clk)
        if(!rstn)
          for (int i=0; i<DEPTH; i++)
            dff_fifo_ram[i][RSTN_LSB+RSTN_WIDTH-1:RSTN_LSB] <= {RSTN_WIDTH{1'b0}};
        else if (we) 
            dff_fifo_ram[rff_tail] <= din;

    end // RFF_FIFO
    else begin : DFF_FIFO
      assign dout = dff_fifo_ram[rff_head];
      always @(posedge clk)
        if (we) 
          dff_fifo_ram[rff_tail] <= din;
    end // DFF_FIFO

    always @(posedge clk) begin
      if (!rstn) begin
        rff_tail      <= {DEPTH_BITS{1'b0}};
        rff_head      <= {DEPTH_BITS{1'b0}};
        rff_empty     <= 1'b1;
        rff_full      <= 1'b0;
      end else begin
        if (we)
          rff_tail    <= ntail;

        if (re)
          rff_head    <= nhead;

        unique case ({we, re})
          2'b10: begin
            rff_empty <= 1'b0;
            rff_full  <= (ntail == rff_head);
          end
          2'b01: begin
            rff_empty <= (nhead == rff_tail);
            rff_full  <= 1'b0;
          end
          default: begin
            rff_empty <= rff_empty;
            rff_full  <= rff_full;
          end
        endcase
      end


    end

    always_comb begin
      nhead = rff_head + 1;
      ntail = rff_tail + 1;
    end
  end
endgenerate

`ifndef SYNTHESIS
  property chk_overflow;
    disable iff(!rstn)
      @(posedge clk)
        (full |-> we == 0);
  endproperty
  assert property(chk_overflow) else `olog_error("OURSRING_UTIL_ASSERTION", $sformatf("%m : oursring_fifo overflow"));
  property chk_underflow;
    disable iff(!rstn)
      @(posedge clk)
        (empty |-> re == 0);
  endproperty
  assert property(chk_underflow) else `olog_error("OURSRING_UTIL_ASSERTION", $sformatf("%m : oursring_fifo underflow"));
`endif
endmodule

