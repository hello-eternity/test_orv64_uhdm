//===========================================================================================
// File   : ot_ppln_delay.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A pipeline cell without flow-control
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

`ifndef __OT_NOFC_PPLN_CELL_V__
`define __OT_NOFC_PPLN_CELL_V__

module ot_nofc_ppln_cell 
    #( parameter width = 64,
       parameter ppln_opt = 1 // 0: no pipeline; 1: pipeline
    )
    (

    input   clk,
    input   rst,
    
    input   cfg_is_clk_gated,

    input               in_vld,
    input [width-1:0]   in_data,
    
    output logic              out_vld,
    output logic [width-1:0]  out_data
    
    );

    //================== BODY ==================
generate    
if (ppln_opt == 0) begin: ppln_opt_0
    assign out_vld = in_vld;
    assign out_data = in_data;
end
else begin: ppln_opt_1
    always @(posedge clk) begin
        if (rst) begin
            out_vld <= 1'b0;
        end
        else begin
            out_vld <= in_vld;
        end
        
        if (/*~cfg_is_clk_gated &*/ in_vld)
            out_data <= in_data;
    end
end    
endgenerate

endmodule
`endif //__OT_NOFC_PPLN_CELL_V__