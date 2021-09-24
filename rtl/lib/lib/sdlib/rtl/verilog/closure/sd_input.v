//----------------------------------------------------------------------
// Srdy/Drdy input block
//
// Halts timing on all signals except ic_drdy
// ic_drdy is a combinatorial path from p_drdy
//
// Naming convention: c = consumer, p = producer, i = internal interface
//----------------------------------------------------------------------
// Author: Guy Hutchison
//----------------------------------------------------------------------
//
// This is free and unencumbered software released into the public domain.
//
// Anyone is free to copy, modify, publish, use, compile, sell, or
// distribute this software, either in source code form or as a compiled
// binary, for any purpose, commercial or non-commercial, and by any
// means.
//
// In jurisdictions that recognize copyright laws, the author or authors
// of this software dedicate any and all copyright interest in the
// software to the public domain. We make this dedication for the benefit
// of the public at large and to the detriment of our heirs and
// successors. We intend this dedication to be an overt act of
// relinquishment in perpetuity of all present and future rights to this
// software under copyright law.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
// IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
// OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
// ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
// For more information, please refer to <http://unlicense.org/> 
//----------------------------------------------------------------------

`ifndef _SD_INPUT_V_
`define _SD_INPUT_V_

// Clocking statement for synchronous blocks.  Default is for
// posedge clocking and positive async reset
`ifndef SDLIB_CLOCKING 
 `define SDLIB_CLOCKING posedge clk
`endif

// delay unit for nonblocking assigns, default is to #1
`ifndef SDLIB_DELAY 
 `define SDLIB_DELAY #1 
`endif

module sd_input
  #(parameter width = 8)
  (
   input              clk,
   input              reset,
   input              c_srdy,
   output reg         c_drdy,
   input [width-1:0]  c_data,

   output reg         ip_srdy,
   input              ip_drdy,
   output reg [width-1:0] ip_data
   );

  reg 	  load;
  reg 	  drain;
  reg 	  occupied, nxt_occupied;
  reg [width-1:0] hold, nxt_hold;
  reg 		  nxt_c_drdy;

  
  always @*
    begin
      nxt_hold = hold;
      nxt_occupied = occupied;

      drain = occupied & ip_drdy;
      load = c_srdy & c_drdy & (!ip_drdy | drain);
      if (occupied)
	ip_data = hold;
      else
	ip_data = c_data;

      ip_srdy = (c_srdy & c_drdy) | occupied;

      if (load)
	begin
	  nxt_hold = c_data;
	  nxt_occupied =  1;
	end
      else if (drain)
	nxt_occupied = 0;

      nxt_c_drdy = (!occupied & !load) | (drain & !load);
    end

  always @(`SDLIB_CLOCKING)
    begin

      hold <= `SDLIB_DELAY nxt_hold; // no reset for hold

      if (reset)
	begin
	  occupied <= `SDLIB_DELAY 0;
	  c_drdy   <= `SDLIB_DELAY 0;
	end
      else
	begin
	  occupied <= `SDLIB_DELAY nxt_occupied;
	  c_drdy   <= `SDLIB_DELAY nxt_c_drdy;
	end // else: !if(reset)
    end // always @ (posedge clk)  
 
endmodule
`endif
