//===========================================================================================
// File   : ot_rr_arbiter_with_hold.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A round-robin arbiter with hold signal for burst transfers.
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

`ifndef __OT_RR_ARBITER_WITH_HOLD_V__
`define __OT_RR_ARBITER_WITH_HOLD_V__
module ot_rr_arbiter_with_hold 
    #(parameter input_cnt = 8
    )
    (
    input clk,
    input rst,
    
    input                       ready,
    input [input_cnt-1:0]       req,
    input                       hold,
    
    output [input_cnt-1:0]      grt
    );

    reg [input_cnt-1:0] rr_state;
    wire [input_cnt-1:0] nxt_rr_state;
    
    //================== BODY ==================

    // update rr_state at clock edge 
    // rr_state: is a round-robin vector that gives the first priority to its first left request bit
    always @(posedge clk) begin
        if (rst) begin
            rr_state <=  {1'b1,{(input_cnt-1){1'b0}}};    // initial priority is given to the 1st requestor
        end
        else begin
            rr_state <=  nxt_rr_state;
        end
    end

    // update grt based on req and rr_state
    assign grt = ready ? (hold ? (req & rr_state) : grt_comp(.rr_state(rr_state), .req(req))) : 
                 {input_cnt{1'b0}};
    
    // compute nxt_rr_state based on grt
    assign nxt_rr_state = (|grt) ? grt : rr_state;
    
    // a round-robin granting function 
    function [input_cnt-1:0]    grt_comp;
        input [input_cnt-1:0]   rr_state;
        input [input_cnt-1:0]   req;
        
        reg [input_cnt-1:0] msk_req;
        reg [input_cnt-1:0] tmp_grant;
        begin
            msk_req = req & ~((rr_state - 1'b1) | rr_state);
            tmp_grant = msk_req & (~msk_req + 1'b1);

            if (msk_req != {input_cnt{1'b0}})
                grt_comp = tmp_grant;
            else
                grt_comp = req & (~req + 1'b1);
        end
    endfunction

endmodule
`endif //__OT_RR_ARBITER_WITH_HOLD_V__
