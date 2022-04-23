//===========================================================================================
// File   : sd_flop_fifo_rstn.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A flop-based FIFO with parameterized depth (okie for non-power-of-two depth).
//    This implementation follows the srdy/drdy protocol  
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

`ifndef __SD_FLOP_FIFO_RSTN_V__
`define __SD_FLOP_FIFO_RSTN_V__

module sd_flop_fifo_rstn 
    #( parameter width=32,
       parameter depth=8,
       parameter asz=$clog2(depth)
    )
    (
        
    //--------- configuration
    
    //-------- interrupt

    //--------- I/O
    input clk,
    input rstn,

    input               c_srdy,  
    output              c_drdy,
    input [width-1:0]   c_data,    
    
    output              p_srdy,    
    input               p_drdy,
    output [width-1:0]  p_data,
    
    output [asz:0]      usage     // how many entries in the fifo have been used
    
    /*AUTOINPUT*/
    
    );
    
    localparam depth_sub_1 = depth-1;
    
    logic wr_en;
    logic rd_en;
    
    logic [asz-1:0] wr_addr;
    logic [asz-1:0] rd_addr;

    logic [asz-1:0] nxt_wr_addr;
    logic [asz-1:0] nxt_rd_addr;
    
`ifdef FPGA    
    (* ram_style = "distributed" *) reg [width-1:0]   array [depth-1:0];
`else
    logic [depth-1:0] [width-1:0]   array;
`endif    
    
    logic [asz:0]   occupy_cnt;
    logic [asz:0]   nxt_occupy_cnt;

    logic full;
    logic empty;
    
    
    /*AUTOLOGIC*/
    
    //================== BODY ========================
    assign wr_en = c_srdy & ~full;
    assign rd_en = p_srdy & p_drdy;
    
    genvar ii;
    
    generate
        for(ii=0; ii<depth; ii=ii+1) begin: array_entry_ii
            always @(posedge clk) begin
                if ((wr_addr==ii[asz-1:0]) & wr_en)
                    array[ii] <= c_data;
            end
        end
    endgenerate

    assign p_data = array[rd_addr];
    
    //=============== update wr_addr and rd_addr
    assign nxt_wr_addr = (wr_en) ? ((wr_addr==depth_sub_1[asz-1:0]) ? {asz{1'b0}} : wr_addr+1'b1) :
                         wr_addr;
    
    always @(posedge clk) begin
        if (~rstn)
            wr_addr <= {asz{1'b0}};
        else
            wr_addr <= nxt_wr_addr;
    end

    assign nxt_rd_addr = (rd_en) ? ((rd_addr==depth_sub_1[asz-1:0]) ? {asz{1'b0}} : rd_addr+1'b1) :
                         rd_addr;
    
    always @(posedge clk) begin
        if (~rstn)
            rd_addr <= {asz{1'b0}};
        else
            rd_addr <= nxt_rd_addr;
    end
    
    //=============== full/empty check
//spyglass disable_block W71           
    always @* begin
        case ({wr_en, rd_en})
            2'b00:  begin 
                nxt_occupy_cnt = occupy_cnt;
            end
            2'b01:  begin 
                nxt_occupy_cnt = occupy_cnt-1'b1;
            end    
            2'b10:  begin 
                nxt_occupy_cnt = occupy_cnt+1'b1;
            end    
            2'b11:  begin 
                nxt_occupy_cnt = occupy_cnt;
            end    
        endcase
    end
//spyglass enable_block W71           
    
    always @(posedge clk) begin
        if (~rstn) begin
            occupy_cnt <= {(asz+1){1'b0}};
        end
        else begin
            occupy_cnt <= nxt_occupy_cnt;
        end
    end
    
    
    assign empty = (occupy_cnt == {(asz+1){1'b0}}) ? 1'b1 : 1'b0;
    assign full = (occupy_cnt == depth[asz:0]) ? 1'b1 : 1'b0;
    
    assign c_drdy = ~full;
    assign p_srdy = ~empty;
    
    assign usage = occupy_cnt;
    
endmodule
`endif  // __SD_FLOP_FIFO_V__
// Local Variables:
// verilog-typedef-regexp:"_S$"
// verilog-library-directories:(".")
// verilog-library-extensions:(".v" ".vh")
// verilog-auto-inst-param-value:t
// End:
