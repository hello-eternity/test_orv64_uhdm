//===========================================================================================
// File   : sd_ppln_delay.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A pipeline cell with flow-control
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

`ifndef __SD_PPLN_DELAY_V__
`define __SD_PPLN_DELAY_V__

module sd_ppln_delay 
    #(parameter width = 64,
      parameter latency = 3,
      parameter pp_type = 1
    )
    (

    input   clk,
    input   rst,
    
    input   cfg_is_clk_gated,

    input               in_srdy,
    output              in_drdy,
    input [width-1:0]   in_data,
    
    output logic                out_srdy,
    input logic                 out_drdy,
    output logic [width-1:0]    out_data
    
    );

    logic [latency:0]               tmp_srdy;
    logic [latency:0]               tmp_drdy;
    logic [latency:0] [width-1:0]   tmp_data;
    
    //================== BODY ==================
genvar ii,jj;  

generate
if (latency == 0) begin: latency_zero
    assign out_srdy = in_srdy;
    assign in_drdy = out_drdy;
    assign out_data = in_data;
end
else begin: latency_non_zero
    assign tmp_srdy[0] = in_srdy;
    assign in_drdy = tmp_drdy[0];
    assign tmp_data[0] = in_data;
    

    for (ii=0; ii<latency; ii=ii+1) begin: cell_ii
        sd_ppln_cell 
        #(.width (width), .pp_type (pp_type)
        )
        ppln_cell_u
        (
            .clk    (clk),   
            .rst    (rst),
    
            .cfg_is_clk_gated   (cfg_is_clk_gated),
    
            .c_srdy     (tmp_srdy[ii]),
            .c_drdy     (tmp_drdy[ii]),
            .c_data     (tmp_data[ii]),
    
            .p_srdy    (tmp_srdy[ii+1]),
            .p_drdy    (tmp_drdy[ii+1]),
            .p_data    (tmp_data[ii+1])
        );
    end

    assign out_srdy = tmp_srdy[latency];
    assign tmp_drdy[latency] = out_drdy;
    assign out_data = tmp_data[latency];
end    
endgenerate

endmodule
`endif //__SD_PPLN_DELAY_V__
