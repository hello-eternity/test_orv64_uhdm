//===========================================================================================
// File   : sd_flop_cam.v
// Author : Anh Tran
//===========================================================================================
// Description:
//    A flop-based CAM
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

`ifndef __SD_FLOP_CAM_V__ 
`define __SD_FLOP_CAM_V__ 

module sd_flop_cam
    #( parameter cam_depth = 8,
       parameter meta_sz = 20,  
       parameter data_sz = 128,
       parameter idx_sz = $clog2(cam_depth)
    )
    (
    input clk,
    input rst,

    //---------- config
   
    //---------- signals
    input                   in_srdy, 
    output                  in_drdy, 
    input [meta_sz-1:0]     in_meta, // 
    input [data_sz-1:0]     in_data,


    input                           probe_en,
    input [meta_sz-1:0]             probe_meta,
    output logic                    probe_match,
    output logic [idx_sz-1:0]       probe_match_idx,
    

    input                       rd_en,
    input [idx_sz-1:0]          rd_idx,
    output                      rd_vld,
    output [data_sz-1:0]        rd_data

    /*AUTOINPUT*/
    );

    logic [cam_depth-1:0]                            buf_vld_array;
    logic [cam_depth-1:0] [meta_sz+data_sz-1:0]      buf_data_array;


    /*AUTOLOGIC*/


    //====================================================//
    //===================== BODY =========================//
    //====================================================//
genvar ii;

    //=========== a poll of available addrs
    logic                   pool_in_srdy;
    logic                   pool_in_drdy;   
    logic [idx_sz-1:0]      pool_in_idx;   
       
    logic                   pool_out_srdy;   
    logic                   pool_out_drdy;   
    logic [idx_sz-1:0]      pool_out_idx;   
      
    sd_id_pool
    #(  .width  (idx_sz),
        .depth  (cam_depth)
    )
    index_pool
    ( 
        .clk               (clk),
        .rst               (rst),           
     
        .c_srdy                (pool_in_srdy),
        .c_drdy                (pool_in_drdy),  
        .c_data                (pool_in_idx), 
        
        .p_srdy                (pool_out_srdy), 
        .p_drdy                (pool_out_drdy),
        .p_data                (pool_out_idx), 
        .usage           ()          
    );    


    //=========== write to the buffer if index_pool is not empty
    logic                               buf_wr_en;
    logic [idx_sz-1:0]                  buf_wr_idx;
    logic [meta_sz+data_sz-1 : 0]       buf_wr_data;

    assign in_drdy = pool_out_srdy; // index pool is not empty
    assign buf_wr_en = in_srdy & pool_out_srdy;
    
    assign pool_out_drdy = buf_wr_en;
    assign buf_wr_idx = pool_out_idx;
    assign buf_wr_data = {in_meta, in_data};
    
generate
    for(ii=0; ii<cam_depth; ii=ii+1) begin: buf_array_entry_ii
        always @(posedge clk) begin
            if (rst) begin
                buf_vld_array[ii] <= 1'b0;
            end
            else begin
                if ((rd_idx == ii[idx_sz-1:0]) & rd_en) begin
                    buf_vld_array[ii] <= 1'b0;
                end
                    
                if ((buf_wr_idx == ii[idx_sz-1:0]) & buf_wr_en) begin
                    buf_vld_array[ii] <= 1'b1;
                end
            end

            if ((buf_wr_idx==ii[idx_sz-1:0]) & buf_wr_en) begin
                buf_data_array[ii] <= buf_wr_data;
            end
        end
    end
endgenerate

    //============ read from the buffer
//     assign rd_meta = buf_data_array[rd_idx][meta_sz+data_sz-1:data_sz]; 
    assign rd_vld = rd_en;
    assign rd_data = buf_data_array[rd_idx][data_sz-1:0];

    assign pool_in_srdy = rd_en;
    assign pool_in_idx = rd_idx;

    //============ probe check

    logic [cam_depth-1:0]             probe_check;

generate    
  for(ii=0; ii<cam_depth; ii=ii+1) begin: probe_check_ii    
    assign probe_check[ii] = buf_vld_array[ii] & 
                             (buf_data_array[ii][meta_sz+data_sz-1:data_sz] == probe_meta) & 
                             probe_en;
  end
endgenerate

    //============ one-hot decoder using sysnopsys directive
generate
  if (cam_depth == 4) begin: cam_depth_4
    always @* begin
        probe_match = 1'b0;
        probe_match_idx = 0;

        case (1'b1) // synopsys parallel_case
            probe_check[0]:  begin
                probe_match = 1'b1;
                probe_match_idx = 0;
            end
            probe_check[1]:  begin
                probe_match = 1'b1;
                probe_match_idx = 1;
            end
            probe_check[2]:  begin
                probe_match = 1'b1;
                probe_match_idx = 2;
            end
            probe_check[3]:  begin
                probe_match = 1'b1;
                probe_match_idx = 3;
            end
        endcase
    end
  end

  if (cam_depth == 8) begin: cam_depth_8
    always @* begin
        probe_match = 1'b0;
        probe_match_idx = 0;

        case (1'b1) // synopsys parallel_case
            probe_check[0]:  begin
                probe_match = 1'b1;
                probe_match_idx = 0;
            end
            probe_check[1]:  begin
                probe_match = 1'b1;
                probe_match_idx = 1;
            end
            probe_check[2]:  begin
                probe_match = 1'b1;
                probe_match_idx = 2;
            end
            probe_check[3]:  begin
                probe_match = 1'b1;
                probe_match_idx = 3;
            end
            probe_check[4]:  begin
                probe_match = 1'b1;
                probe_match_idx = 4;
            end
            probe_check[5]:  begin
                probe_match = 1'b1;
                probe_match_idx = 5;
            end
            probe_check[6]:  begin
                probe_match = 1'b1;
                probe_match_idx = 6;
            end
            probe_check[7]:  begin
                probe_match = 1'b1;
                probe_match_idx = 7;
            end
        endcase
    end
  end
  
  if (cam_depth == 16) begin: cam_depth_16
    always @* begin
        probe_match = 1'b0;
        probe_match_idx = 0;

        case (1'b1) // synopsys parallel_case
            probe_check[0]:  begin
                probe_match = 1'b1;
                probe_match_idx = 0;
            end
            probe_check[1]:  begin
                probe_match = 1'b1;
                probe_match_idx = 1;
            end
            probe_check[2]:  begin
                probe_match = 1'b1;
                probe_match_idx = 2;
            end
            probe_check[3]:  begin
                probe_match = 1'b1;
                probe_match_idx = 3;
            end
            probe_check[4]:  begin
                probe_match = 1'b1;
                probe_match_idx = 4;
            end
            probe_check[5]:  begin
                probe_match = 1'b1;
                probe_match_idx = 5;
            end
            probe_check[6]:  begin
                probe_match = 1'b1;
                probe_match_idx = 6;
            end
            probe_check[7]:  begin
                probe_match = 1'b1;
                probe_match_idx = 7;
            end
            probe_check[8]:  begin
                probe_match = 1'b1;
                probe_match_idx = 8;
            end
            probe_check[9]:  begin
                probe_match = 1'b1;
                probe_match_idx = 9;
            end
            probe_check[10]:  begin
                probe_match = 1'b1;
                probe_match_idx = 10;
            end
            probe_check[11]:  begin
                probe_match = 1'b1;
                probe_match_idx = 11;
            end
            probe_check[12]:  begin
                probe_match = 1'b1;
                probe_match_idx = 12;
            end
            probe_check[13]:  begin
                probe_match = 1'b1;
                probe_match_idx = 13;
            end
            probe_check[14]:  begin
                probe_match = 1'b1;
                probe_match_idx = 14;
            end
            probe_check[15]:  begin
                probe_match = 1'b1;
                probe_match_idx = 15;
            end
        endcase
    end
  end  
endgenerate
    
    
    //=========================================================//
    //================= FUNCTIONS =============================//
    //=========================================================//
    //============= bitsum function 
    function [idx_sz:0]  bitsum;
        input [cam_depth-1:0] bit_vec;
        
        logic [idx_sz:0] bitsum_tmp;
        
        integer i;
        
        begin
            bitsum_tmp = {(idx_sz+1){1'b0}};
            for (i=0; i<cam_depth; i++) begin
                bitsum_tmp = bitsum_tmp + bit_vec[i];
            end
            
            bitsum = bitsum_tmp;
        end
    endfunction
    
    //=========== convert from 1-hot bit-vector to an id
    function [idx_sz-1:0] onehot_to_id;
        input [cam_depth-1:0] bit_vec;
        
        logic [cam_depth-1:0] mask, not_mask;
        
        begin
            mask = ~bit_vec + 1'b1;
            not_mask = ~mask;
            
            onehot_to_id = bitsum(not_mask); 
        end
        
    endfunction


endmodule
`endif  // __SD_FLOP_CAM_V__ 
// Local Variables:
// verilog-typedef-regexp:"_[t]$"
// verilog-library-directories:("." "./*")
// verilog-library-extensions:(".v" ".vh")
// verilog-auto-inst-param-value:t
// verilog-auto-ignore-concat:nil
// End:
