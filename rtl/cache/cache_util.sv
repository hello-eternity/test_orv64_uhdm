// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// synchronous command fifo (will never full)
module l2_cmd_fifo #(
  parameter WIDTH=2,
  parameter DEPTH=4
) (
  output  logic             empty,
  output  logic [WIDTH-1:0] dout,

  input   logic [WIDTH-1:0] din,
  input   logic             we,
  input   logic             re,
  input   logic             rst, clk
);

// 1. resetable and non-resetable flops
// 2. gate-level style comb logic  
// 3. lint clean up
   logic [DEPTH-1:0][WIDTH-1:0]	dffce_fifo_ram;
   logic[$clog2(DEPTH)-1:0] 	rffce_head, rffce_tail, nhead, ntail;
   logic 						rff_empty;

   `ifndef SYNTHESIS
   initial begin
      assert (DEPTH == 2**$clog2(DEPTH)) else $error ("%m : depth must be pwr of two");
   end
   `endif
	
	// empty	
   	assign empty = rff_empty; 
	always_ff @(posedge clk)
	if (~rst) 
		rff_empty <= 1'b1; 
	else
		rff_empty <= ~we  & re & (nhead == rffce_tail) | ~(we | re) & rff_empty;

	// fifo ram
	assign dout = dffce_fifo_ram[rffce_head];
	always_ff @(posedge clk)
	if (we) dffce_fifo_ram[rffce_tail] <= din;

	// head/tail 
    always_ff @(posedge clk) begin
      if (~rst) begin
         rffce_tail <= $clog2(DEPTH)'(0);
         rffce_head <= $clog2(DEPTH)'(0);
      end
      else begin
         rffce_tail <= (we) ? ntail : rffce_tail;
         rffce_head <= (re) ? nhead : rffce_head;
      end
    end

    always_comb begin
      nhead = rffce_head + $clog2(DEPTH)'(1);
      ntail = rffce_tail + $clog2(DEPTH)'(1);
    end

`ifndef SYNTHESIS
    property chk_underflow;
      disable iff(~rst)
        @(posedge clk)
          (empty |-> re == 0);
    endproperty
    assert property(chk_underflow) else `olog_error("L2CACHE_L2_UTIL_ASSERTION", $sformatf("%m : l2_cmd_fifo underflow"));
`endif
endmodule


// l2 memory command fifo (will never full) two write ports
module l2_cmd_fifo_2w #(parameter WIDTH=2, parameter DEPTH=4)(input logic clk,
                                             input  logic rst,
                                             input  logic [WIDTH-1:0] din0, din1,
                                             input  logic we0, we1,
                                             input  logic re,
                                             output logic empty,
                                             output logic[WIDTH-1:0] dout);

   logic [DEPTH-1:0][WIDTH-1:0] dffce_fifo_ram;
   logic[$clog2(DEPTH)-1:0] 	rffce_head, rffce_tail, tail_1, nhead, ntail;
   logic [DEPTH-1:0] 			fifo_ram_we, fifo_din_sel;
   logic 						rff_empty;

`ifndef SYNTHESIS
   initial begin
      assert (DEPTH == 2**$clog2(DEPTH)) else $error ("%m : depth must be pwr of two");
   end
`endif

	// fifo ram
	assign dout = dffce_fifo_ram[rffce_head];
	always_ff @(posedge clk) begin
      for (int i=0;i<DEPTH;i++) begin
    	if (fifo_ram_we[i])
        	dffce_fifo_ram[i] <= (fifo_din_sel[i]) ? din1 : din0;
      end
	end
	// write enable
	always_comb begin
	  for (int i=0; i<DEPTH; i++) begin
	  	fifo_ram_we[i] = (we0 | we1) & (rffce_tail == $clog2(DEPTH)'(i)) | we0 & we1 & (tail_1 == $clog2(DEPTH)'(i));    	
	  end
	end
	// din select
	always_comb begin
	  for (int i=0; i<DEPTH; i++) begin
		fifo_din_sel[i] = ~we0 & we1 & (rffce_tail == $clog2(DEPTH)'(i)) | we0 & we1 & (tail_1 == $clog2(DEPTH)'(i));
	  end
	end
	// empty
	assign empty = rff_empty;
	always_ff @(posedge clk) 
	if (~rst)
		rff_empty <= 1'b1;
	else
		rff_empty <= ~(we0 | we1)  & re & (nhead == rffce_tail) | ~(we0 | we1 | re) & rff_empty;
	
	// head/tail
    always_ff @(posedge clk) begin
      if (~rst) begin
         rffce_tail <= $clog2(DEPTH)'(0);
         rffce_head <= $clog2(DEPTH)'(0);
      end
      else begin
         rffce_tail <= (we0 | we1) ? ntail : rffce_tail;
         rffce_head <= (re) ? nhead : rffce_head;
      end

   end

    always_comb begin
      nhead  = rffce_head + $clog2(DEPTH)'(1);
      tail_1 = rffce_tail + $clog2(DEPTH)'(1);
      ntail  = rffce_tail + $clog2(DEPTH)'(we0) +  $clog2(DEPTH)'(we1);
    end

`ifndef SYNTHESIS
    property chk_underflow;
      disable iff(~rst)
        @(posedge clk)
          (empty |-> re == 0);
    endproperty
    assert property(chk_underflow) else `olog_error("L2CACHE_L2_UTIL_ASSERTION", $sformatf("%m : l2_cmd_fifo underflow"));
`endif
endmodule
