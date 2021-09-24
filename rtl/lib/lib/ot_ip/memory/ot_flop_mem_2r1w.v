//===========================================================================================
// File   : ot_flop_mem_2r1w.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A flop-based 2r1w memory model.
//    Write latency = 1
//    Read latency = 1
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
//===========================================================================================

`ifndef __OT_FLOP_MEM_2R1W_V__
`define __OT_FLOP_MEM_2R1W_V__

module ot_flop_mem_2r1w
    #( parameter depth = 32,
       parameter width = 512,
       parameter addr_sz = $clog2(depth)
    )
    (
    input   clk,
    input   rst,

    input                   wr_en,
    input [addr_sz-1:0]     wr_addr,
    input [width-1:0]       wr_data,

    input                       rd0_en,
    input [addr_sz-1:0]         rd0_addr,
    output logic                rd0_vld,
    output logic [width-1:0]    rd0_data,

    input                       rd1_en,
    input [addr_sz-1:0]         rd1_addr,
    output logic                rd1_vld,
    output logic [width-1:0]    rd1_data    
    );

`ifdef FPGA    
    (* ram_style = "distributed" *) reg [width-1:0]   array [depth-1:0];
`else
    logic [depth-1:0] [width-1:0]   array;
`endif

genvar ii;

    //-------- write
generate
    for(ii=0; ii<depth; ii=ii+1) begin: array_wr
        always @(posedge clk) begin
            if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                 array[ii] <= wr_data;
        end  
    end  
endgenerate

    //-------- read port0
    logic [width-1:0]       rd0_data_tmp;

    assign rd0_data_tmp = array[rd0_addr];

    always @(posedge clk) begin
        if (rst)
            rd0_vld <= 1'b0;
        else
            rd0_vld <= rd0_en;

        rd0_data <= rd0_data_tmp;
    end

    //--------- read port1
    logic [width-1:0]       rd1_data_tmp;

    assign rd1_data_tmp = array[rd1_addr];

    always @(posedge clk) begin
        if (rst)
            rd1_vld <= 1'b0;
        else
            rd1_vld <= rd1_en;

        rd1_data <= rd1_data_tmp;
    end
    
endmodule
`endif // __OT_FLOP_MEM_2R1W_V__
