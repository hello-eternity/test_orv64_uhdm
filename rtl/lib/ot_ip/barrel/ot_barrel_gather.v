//=====================================================================================================
// File   : ot_barrel_gather_demux_kernel.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  a barrel gather structure using bitmap
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

`ifndef __OT_BARREL_GATHER_V__
`define __OT_BARREL_GATHER_V__

(* use_dsp = "yes" *) module ot_barrel_gather
    #( parameter in_word_cnt = 100,
       parameter out_word_cnt = 16,     // out_word_cnt must be <= in_word_cnt
       parameter word_sz = 8,
       parameter lvl_cnt = $clog2(in_word_cnt),
       parameter kernel_input_reg = 0     // flopped both input data and demux_sel
    )
    (
    input       clk,

    input [in_word_cnt-1:0]                          in_bmp,    
    input [in_word_cnt-1:0] [word_sz-1:0]            in_data,
    
    output logic [out_word_cnt-1:0]                     out_bmp,
    output logic [out_word_cnt-1:0] [word_sz-1:0]       out_data
    );

// integer rr, ll;
// genvar ii, jj, tt;

    //----------------- compute zero_cnt for each input
    logic [in_word_cnt-1:0] [lvl_cnt-1:0]   zero_cnt;

    assign zero_cnt[0] = {{(lvl_cnt-2){1'b0}}, ~in_bmp[0]};

    always @* begin
        for (int rr=1; rr<in_word_cnt; rr=rr+1) begin
            zero_cnt[rr] = zero_cnt[rr-1] + (in_bmp[rr] ? 1'b0 : 1'b1); // zero_cnt[rr-1] + {{(lvl_cnt-2){1'b0}}, ~in_bmp[rr]};
        end
    end    
    
    //----------------- compute demux_sels per level
    logic [lvl_cnt-1:0] [in_word_cnt-1:0]                   lvl_demux_sel;

    always @* begin
      for (int ll=0; ll<lvl_cnt; ll=ll+1) begin // level ll
        for (int ii=0; ii<in_word_cnt; ii=ii+1) begin // row ii
            lvl_demux_sel[ll][ii] = zero_cnt[ii][ll];
        end
      end

    end

    //-------- barrel gather kernel
    ot_barrel_gather_demux_kernel
    # (
        .in_word_cnt    (in_word_cnt),
        .out_word_cnt   (out_word_cnt),
        .word_sz        (word_sz),
        .lvl_cnt        (lvl_cnt),
        .input_reg      (kernel_input_reg)
    )
    barrel_gather_demux_kernel
    (
        .clk            (clk),

        .in_vld             (in_bmp),
        .in_data            (in_data),
        .lvl_demux_sel      (lvl_demux_sel),  // per stage, per mux
    
        .out_vld        (out_bmp),
        .out_data       (out_data)
    );

endmodule
`endif // __OT_BARREL_GATHER_V__
