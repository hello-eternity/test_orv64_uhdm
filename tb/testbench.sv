// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef VERILATOR
	`timescale   1ns/1ps
`endif
module testbench
(

);




logic clk;
logic rst;


initial begin
`ifdef VCS
	if ($test$plusargs("dump")) begin
        $vcdpluson();

		//fsdb wave
        $fsdbDumpfile("waves.fsdb");
        $fsdbDumpvars(0, top0);
        $fsdbDumpvars("+struct");
        $fsdbDumpvars("+mda");
        $fsdbDumpvars("+all");
        $fsdbDumpon;
    end
`else
	// $dumpfile("orv64.vcd");
	// $dumpvars(0, top0);
`endif
end

initial begin
	$display("init\n\n");
	clk = 1'b0;
	// $dumpon;
	forever #1 clk = ~clk;
	// $dumpoff;
end

initial begin
	rst = 1'b1;
	#20;
	rst = 1'b0;
end


logic [17:0] cnt;
always @(posedge clk) begin
	if (rst) begin
		cnt <= 0;
	end
	else begin
		cnt <= cnt + 1;
	end
end

top top0
(
  .tb_clk                   (clk),
  .tb_rst                   (rst)
);

endmodule
