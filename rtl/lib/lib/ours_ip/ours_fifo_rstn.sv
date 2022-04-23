// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_fifo_rstn #(
  parameter BACKEND_DOMAIN=0,
  parameter DATA_WIDTH=32,
  parameter CTRL_WIDTH=4,
  parameter DEPTH=2
) (
  output  logic             empty,
  output  logic             full,
  output  logic [DATA_WIDTH-1:0] dout,
  output  logic [CTRL_WIDTH-1:0] ctrl_out,

  input   logic [DATA_WIDTH-1:0] din,
  input   logic [CTRL_WIDTH-1:0] ctrl_in,
  input   logic             we,
  input   logic             re,
  input   logic             rstn, clk
);

  localparam DEPTH_BITS = $clog2(DEPTH);

  logic [DEPTH-1:0][DATA_WIDTH-1:0]  dff_fifo_ram;
  logic [DEPTH-1:0][CTRL_WIDTH-1:0]  dff_ctrl_fifo_ram;
  logic [DEPTH_BITS-1:0]        rff_head, rff_tail, nhead, ntail;
  logic                         rff_empty, rff_full;
  assign empty = rff_empty;
  assign full  = rff_full;

  `ifndef SYNTHESIS
  initial begin
    assert (DEPTH == 2**DEPTH_BITS) else $error ("%m : depth must be pwr of two");
  end
  `endif

  always @(posedge clk) begin
    if (!rstn) begin
      rff_tail          <= {DEPTH_BITS{1'b0}};
      rff_head          <= {DEPTH_BITS{1'b0}};
      rff_empty         <= 1'b1;
      rff_full          <= 1'b0;
      dff_ctrl_fifo_ram <= {(DEPTH*CTRL_WIDTH){1'b0}};
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

    // RAM
    if (we) begin
      dff_fifo_ram[rff_tail] <= din;
    end
  end

  always_comb begin
    nhead = rff_head + 1;
    ntail = rff_tail + 1;
    dout = dff_fifo_ram[rff_head];
  end

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

