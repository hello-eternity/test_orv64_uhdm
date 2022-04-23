//=====================================================================================================
// File   : ot_barrel_gather_demux_kernel.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  a barrel gather kernel using demuxing
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

`ifndef __OT_BARREL_GATHER_DEMUX_KERNEL_V__
`define __OT_BARREL_GATHER_DEMUX_KERNEL_V__

(* use_dsp = "yes" *) module ot_barrel_gather_demux_kernel
    # (
    parameter in_word_cnt = 32,
    parameter out_word_cnt = 16,    // out_word_cnt <= in_word_cnt
    parameter word_sz = 8,
    parameter lvl_cnt = $clog2(in_word_cnt),
    parameter input_reg = 0     // flopped both input data and mux_sel
    )
    (
    input   clk,

    input   [in_word_cnt-1:0]                   in_vld,
    input   [in_word_cnt-1:0] [word_sz-1:0]     in_data,

    input   [lvl_cnt-1:0] [in_word_cnt-1:0]     lvl_demux_sel,  // per stage, per mux
    
    output logic [out_word_cnt-1:0]                 out_vld,
    output logic [out_word_cnt-1:0] [word_sz-1:0]   out_data
    );
    

    //============= BODY
//     genvar ll, jj, kk;
    //----------- optional input pipelining
    logic   [in_word_cnt-1:0]                   in_vld_reg;
    logic   [in_word_cnt-1:0] [word_sz-1:0]     in_data_reg;
    logic   [lvl_cnt-1:0] [in_word_cnt-1:0]     lvl_demux_sel_reg;

generate
if (input_reg==0) begin: input_not_reg
    assign in_vld_reg = in_vld;
    assign in_data_reg = in_data;
    assign lvl_demux_sel_reg = lvl_demux_sel;
end

else begin: input_reged
    always @(posedge clk) begin
        in_vld_reg <= in_vld;
        in_data_reg <= in_data;
        lvl_demux_sel_reg <= lvl_demux_sel;
    end
end
endgenerate


    //----------- kernel logic
    logic   [lvl_cnt-1:0] [in_word_cnt-1:0]                     lvl_vld;
    logic   [lvl_cnt-1:0] [in_word_cnt-1:0] [word_sz-1:0]       lvl_data;

    always @* begin
        // level 0
        for (int jj=0; jj<in_word_cnt; jj=jj+1) begin
            lvl_vld[0][jj] = in_vld_reg[jj];
            lvl_data[0][jj] = in_data_reg[jj];
        end

        // level 1 to lvl_cnt-1
        for (int ll=1; ll<lvl_cnt; ll=ll+1) begin
            for (int jj=0; jj<in_word_cnt; jj=jj+1) begin // lvl_ll_jj_gen
                if (jj<in_word_cnt-2**(ll-1)) begin // mux_cell
                    lvl_vld[ll][jj] = (lvl_demux_sel_reg[ll-1][jj+2**(ll-1)] & lvl_vld[ll-1][jj+2**(ll-1)]) |
                                      (~lvl_demux_sel_reg[ll-1][jj] & lvl_vld[ll-1][jj]);
                    lvl_data[ll][jj] = (lvl_demux_sel_reg[ll-1][jj+2**(ll-1)] & lvl_vld[ll-1][jj+2**(ll-1)]) ? lvl_data[ll-1][jj+2**(ll-1)] : 
                                       lvl_data[ll-1][jj];
                end
                else begin // bypass_cell
                    lvl_vld[ll][jj] = (~lvl_demux_sel_reg[ll-1][jj] & lvl_vld[ll-1][jj]);
                    lvl_data[ll][jj] = lvl_data[ll-1][jj];
                end
            end
        end
    end
    
    // output
    always @* begin
        for (int jj=0; jj<out_word_cnt; jj=jj+1) begin // lvl_ll_jj_gen
            if (jj < in_word_cnt-2**(lvl_cnt-1) ) begin // mux_cell
                out_vld[jj] = (lvl_demux_sel_reg[lvl_cnt-1][jj+2**(lvl_cnt-1)] & lvl_vld[lvl_cnt-1][jj+2**(lvl_cnt-1)]) |
                              (~lvl_demux_sel_reg[lvl_cnt-1][jj] & lvl_vld[lvl_cnt-1][jj]);
                out_data[jj] = (lvl_demux_sel_reg[lvl_cnt-1][jj+2**(lvl_cnt-1)] & lvl_vld[lvl_cnt-1][jj+2**(lvl_cnt-1)]) ? lvl_data[lvl_cnt-1][jj+2**(lvl_cnt-1)] : 
                               lvl_data[lvl_cnt-1][jj];
            end
            else begin // bypass_cell
                out_vld[jj] = (~lvl_demux_sel_reg[lvl_cnt-1][jj] & lvl_vld[lvl_cnt-1][jj]);
                out_data[jj] = lvl_data[lvl_cnt-1][jj];
            end
        end
    end
    
endmodule
`endif // __OT_BARREL_GATHER_DEMUX_KERNEL_V__
