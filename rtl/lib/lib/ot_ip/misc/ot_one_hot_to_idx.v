//=====================================================================================================
// File   : ot_one_hot_to_idx.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  Convert from one-hot vector to index
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

`ifndef __OT_ONE_HOT_TO_IDX_V__
`define __OT_ONE_HOT_TO_IDX_V__

module ot_one_hot_to_idx 
    #( parameter    bit_cnt = 16,
       parameter    idx_sz = $clog2(bit_cnt)
    )
    (
        input [bit_cnt-1:0]     in_one_hot,
        output [idx_sz-1:0]     out_idx
    );

    logic [bit_cnt-1:0] mask, not_mask;
    
    assign mask = ~in_one_hot + 1'b1;
    assign not_mask = ~mask;
    
    assign out_idx = bitsum(.bit_vec(not_mask));
    
    //------- bitsum function 
    function [idx_sz:0]  bitsum;
        input [bit_cnt-1:0] bit_vec;
        
        logic [idx_sz:0] bitsum_tmp;
        
        integer i;
        
        begin
            bitsum_tmp = {(idx_sz+1){1'b0}};
            for (i=0; i<bit_cnt; i++) begin
                bitsum_tmp = bitsum_tmp + bit_vec[i];
            end
            
            bitsum = bitsum_tmp;
        end
    endfunction
endmodule
`endif // __OT_ONE_HOT_TO_IDX_V__