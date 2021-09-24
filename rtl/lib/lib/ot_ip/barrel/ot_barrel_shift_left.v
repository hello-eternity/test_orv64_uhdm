//=====================================================================================================
// File   : ot_barrel_shift_left.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  a barrel shift left structure with combination logic only
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
//=====================================================================================================

`ifndef __OT_BARREL_SHIFT_LEFT_V__
`define __OT_BARREL_SHIFT_LEFT_V__

(* use_dsp = "yes" *) module ot_barrel_shift_left 
    #(  parameter   word_width = 8, // in bits
        parameter   word_cnt = 20,  // the number of words of the shifted data
        parameter   max_shift_amt = word_cnt, // maximum value of in_shift_amt
        parameter   shift_lvl_cnt = $clog2(max_shift_amt)    // the number of mux levels in the barrel shifter
    )
    (
        
    //--------- I/O
    input [word_cnt*word_width-1:0]     in_data,
    input [shift_lvl_cnt-1:0]           in_shift_amt,   // how many words would be shifted (< max_shift_amt)
    
    output [word_cnt*word_width-1:0]    out_data
    
    );
    
    logic [shift_lvl_cnt-1:0] [word_cnt*word_width-1:0]     shift_lvl;
    
    //================== BODY ========================
    assign shift_lvl[0] = (in_shift_amt[0]) ? {in_data[(word_cnt-1)*word_width-1:0], {word_width{1'b0}}} :
                          in_data;

genvar ii;
generate
    for (ii=1; ii<shift_lvl_cnt; ii=ii+1) begin: level_ii
        assign shift_lvl[ii] = (in_shift_amt[ii]) ? {shift_lvl[ii-1][(word_cnt-(1<<ii))*word_width-1:0], {((1<<ii)*word_width){1'b0}}} :
                               shift_lvl[ii-1];
    end
endgenerate

    assign out_data = shift_lvl[shift_lvl_cnt-1];
    
endmodule
`endif // __OT_BARREL_SHIFT_LEFT_V__
