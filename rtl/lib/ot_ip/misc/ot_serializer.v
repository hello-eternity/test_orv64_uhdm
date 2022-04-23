//=====================================================================================================
// File   : ot_serializer.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  Serialize a large bitwidth data to multiple smaller bitwidth data
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

`ifndef __OT_SERIALIZER_V__
`define __OT_SERIALIZER_V__

(* use_dsp = "yes" *) module ot_serializer 
    #( parameter    in_word_cnt = 9,
       parameter    word_width = 32, // the output bitwidth
       parameter    out_ppln_opt //0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
    )
    (
    input   clk,
    input   rst,
        
    //--------- config
    input       cfg_is_clk_gated,
    
    //--------- I/O
    input                                       in_srdy,
    output                                      in_drdy, 
    input [in_word_cnt-1:0] [word_width-1:0]    in_data,

    output logic                        out_srdy,
    input                               out_drdy,  
    output logic [word_width-1:0]       out_data
    );

    localparam in_word_cnt_sub1 = in_word_cnt - 1;
    
    logic                        out_srdy_tmp;
    logic                        out_drdy_tmp;  
    logic [word_width-1:0]       out_data_tmp;    
    
    logic [$clog2(in_word_cnt)-1:0]     tran_id, nxt_tran_id;
    
    assign nxt_tran_id = (in_srdy & in_drdy) ? {($clog2(in_word_cnt)){1'b0}} :
                         (out_srdy_tmp & out_drdy_tmp) ? (tran_id + 1'b1) :
                         tran_id;
    
    always @(posedge clk) begin
        if (rst) 
            tran_id <= {($clog2(in_word_cnt)){1'b0}};
        else
            tran_id <= nxt_tran_id;
    end
    
    assign out_srdy_tmp = in_srdy;
    assign in_drdy = out_drdy_tmp & 
                     (tran_id == in_word_cnt_sub1[$clog2(in_word_cnt)-1:0]);
    
    assign out_data_tmp = in_data[tran_id];
    
    sd_ppln_cell 
    #( .width       (word_width),
       .pp_type     (out_ppln_opt)    //0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
    )
    output_ppln_cell_u
    (
        .clk    (clk),
        .rst    (rst),

        .cfg_is_clk_gated   (cfg_is_clk_gated),
    
        .c_srdy     (out_srdy_tmp),     
        .c_drdy     (out_drdy_tmp),
        .c_data     (out_data_tmp),    
    
        .p_srdy     (out_srdy),    
        .p_drdy     (out_drdy),
        .p_data     (out_data)
    );
    
endmodule
`endif // __OT_SERIALIZER_V__
