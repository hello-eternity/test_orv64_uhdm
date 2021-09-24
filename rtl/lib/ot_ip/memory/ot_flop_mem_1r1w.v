//===========================================================================================
// File   : ot_flop_mem_1r1w.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A flop-based 1r1w memory model.
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

`ifndef __OT_FLOP_MEM_1R1W_V__
`define __OT_FLOP_MEM_1R1W_V__

module ot_flop_mem_1r1w
    #( parameter depth = 32,
       parameter width = 512,
       parameter addr_sz = $clog2(depth),
       parameter init_tbl_data = 0, // init data for some special table (for depth=64, width= 8 only). 0: none; 1: tanh; 2: sigmoid 
       parameter rd_out_ppln_opt = 1    // 0: not pipelined; 1: pipelined
    )
    (
    input   clk,
    input   rst,

    input                   wr_en,
    input [addr_sz-1:0]     wr_addr,
    input [width-1:0]       wr_data,

    input                       rd_en,
    input [addr_sz-1:0]         rd_addr,
    output logic                rd_vld,
    output logic [width-1:0]    rd_data,
    output [addr_sz:0]          usage     // how many entries in the sram have been used
    );

    logic [addr_sz:0]   occupy_cnt;
    logic [addr_sz:0]   nxt_occupy_cnt;

`ifdef FPGA    
    (* ram_style = "distributed" *) reg [width-1:0]   array [depth-1:0];
`else
    logic [depth-1:0] [width-1:0]   array;
`endif

    //----- parallel rst to reduce its fanout
    logic [10-1:0]    rst_d;
    always @(posedge clk) begin
        rst_d <= {10{rst}};
    end

    //-------- write
generate
if ((depth==64) & (width==8) & (init_tbl_data==1)) begin: int8_tanh_tbl // tanh
    for(genvar ii=0; ii<64; ii=ii+1) begin: array_wr
      if (ii<12) begin
        always @(posedge clk) begin
            if (rst_d[0]) begin
                array[ii] <= {ii[3:0], 2'd0}; // = 4*ii
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
        
      else if (ii<24) begin
        always @(posedge clk) begin
            if (rst_d[1]) begin
                array[ii] <= {ii[4:0], 1'b0} + ii[4:0] + 4'd14; // = 3*ii + 14
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
      
      else if (ii<32) begin
        always @(posedge clk) begin
            if (rst_d[2]) begin
                array[ii] <= {ii[4:0], 1'b0} + 6'd36; // = 2*ii + 36
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
      
      else if (ii<40) begin
        always @(posedge clk) begin
            if (rst_d[3]) begin
                array[ii] <= {ii[5:0], 1'b0} - 8'd160; // = 2*ii - 160
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
      
      else if (ii<52) begin
        always @(posedge clk) begin
            if (rst_d[4]) begin
                array[ii] <= {ii[5:0], 1'b0} + ii[5:0]  - 8'd202; // = 3*ii - 202
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
      
      else begin
        always @(posedge clk) begin
            if (rst_d[5]) begin
                array[ii] <= {ii[5:0], 2'd0} - 9'd256;    // = 4*ii - 256 
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
    end    
end
else if ((depth==64) & (width==8) & (init_tbl_data==2)) begin: int8_sigmoid_tbl
    for(genvar ii=0; ii<64; ii=ii+1) begin: array_wr
      if (ii<16) begin
        always @(posedge clk) begin
            if (rst_d[0]) begin
                array[ii] <= ii[4:0] + 7'd66; 
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end

      else if (ii<32) begin
        always @(posedge clk) begin
            if (rst_d[1]) begin
                array[ii] <= ii[4:0] + 7'd66; 
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
      
      else if (ii<48) begin
        always @(posedge clk) begin
            if (rst_d[2]) begin
                array[ii] <= ii[5:0] + 3'd2; 
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end        
      end
      
      else begin
        always @(posedge clk) begin
            if (rst_d[3]) begin
                array[ii] <= ii[5:0] + 3'd2; 
            end
            else begin
                if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                    array[ii] <= wr_data;
            end
        end  
      end
    end      
end
else begin: none_init_tbl
    for(genvar ii=0; ii<depth; ii=ii+1) begin: array_wr
        always @(posedge clk) begin
            if ((wr_addr==ii[addr_sz-1:0]) & wr_en)
                 array[ii] <= wr_data;
        end  
    end  
end    
endgenerate

    //-------- read    
    logic [width-1:0]               rd_data_tmp;

    assign rd_data_tmp = array[rd_addr];
    
generate
if (rd_out_ppln_opt == 0) begin: rd_out_ppln_opt_0
    assign rd_vld = rd_en;
    assign rd_data = rd_data_tmp;
end
else begin: rd_out_ppln_opt_1
    always @(posedge clk) begin
        if (rst_d[8])
            rd_vld <= 1'b0;
        else
            rd_vld <= rd_en;

        rd_data <= rd_data_tmp;
    end
end    
endgenerate

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
    
always @(posedge clk) begin
  if (rst) begin
      occupy_cnt <= {(addr_sz+1){1'b0}};
  end
  else begin
      occupy_cnt <= nxt_occupy_cnt;
  end
end

assign usage = occupy_cnt;

endmodule
`endif // __OT_FLOP_MEM_1R1W_V__
