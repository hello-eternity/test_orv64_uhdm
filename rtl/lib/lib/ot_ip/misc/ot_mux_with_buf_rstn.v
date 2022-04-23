//=====================================================================================================
// Copyright (c) 2021 RISC-V International Open Source Laboratory (RIOS Lab) -- All Rights Reserved
//=====================================================================================================
// File   : ot_mux_with_buf_rstn.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  multi-input mux with input buffering.
//  the number of inputs is not larger than 4.
//
//=====================================================================================================
module ot_mux_with_buf_rstn 
    #( parameter    IN_CNT = 4,
       parameter    DATA_WIDTH = 128,
       parameter    IN_HAS_BUF = 1,     // 0: a normal pipeline at input ports; 1: a buffer at input ports
       parameter    BUF_DEPTH = 2,
       parameter    IN_PPLN_OPT = 0,    // for IN_HAS_BUF==0. 0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
       parameter    OUT_PPLN_OPT = 0    //0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
    )
    (
        input   clk,
        input   rstn,

        input logic [IN_CNT-1:0]                     in_vld,
        output logic [IN_CNT-1:0]                    in_rdy,
        input logic [IN_CNT-1:0] [DATA_WIDTH-1:0]    in_data,

        output logic                     out_vld,
        input logic                      out_rdy,
        output logic [DATA_WIDTH-1:0]    out_data
        
    );
    
    logic                     out_vld_tmp;
    logic                     out_rdy_tmp;
    logic [DATA_WIDTH-1:0]    out_data_tmp;
        
    //================ BODY ===================
    //-------- buffering input data in case of congestion
    logic [IN_CNT-1:0]                     buf_out_vld;
    logic [IN_CNT-1:0]                     buf_out_rdy;
    logic [IN_CNT-1:0] [DATA_WIDTH-1:0]    buf_out_data;
    
generate
 if (IN_HAS_BUF==1) begin: in_has_buf_1
  for (genvar ii=0; ii<IN_CNT; ii++) begin: in_buf_gen
    sd_flop_fifo_rstn 
    #( .width   (DATA_WIDTH),
       .depth   (BUF_DEPTH)
    )
    buf_fifo_u
    (
        .clk    (clk),
        .rstn    (rstn),
        .c_srdy     (in_vld[ii]),  
        .c_drdy     (in_rdy[ii]),
        .c_data     (in_data[ii]),    

        .p_srdy     (buf_out_vld[ii]),    
        .p_drdy     (buf_out_rdy[ii]),
        .p_data     (buf_out_data[ii]),
    
        .usage      ()     // how many entries in the fifo have been used
    );
  end
 end
 else begin: in_has_buf_0
  for (genvar ii=0; ii<IN_CNT; ii++) begin: in_ppln_gen
    sd_ppln_cell_rstn 
    #( .width       (DATA_WIDTH),
       .pp_type     (IN_PPLN_OPT)    //0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
    )
    input_ppln_cell_u
    (
        .clk    (clk),
        .rstn    (rstn),

        //--------- config
        .cfg_is_clk_gated   (1'b0),
    
        //-------- interrupt

        //--------- I/O
        .c_srdy     (in_vld[ii]),  
        .c_drdy     (in_rdy[ii]),
        .c_data     (in_data[ii]),    
    
        .p_srdy     (buf_out_vld[ii]),    
        .p_drdy     (buf_out_rdy[ii]),
        .p_data     (buf_out_data[ii])
    );
  end
 end
endgenerate
    
    //--------- arbitrate among input data
    logic [IN_CNT-1:0]     arb_req;
    logic [IN_CNT-1:0]     arb_grt;
    
    assign arb_req = buf_out_vld;
    
    ot_rr_arbiter_rstn 
    #( .input_cnt   (IN_CNT)
    )
    rr_arbiter_u
    (
        .clk    (clk),
        .rstn    (rstn),
    
        .ready  (out_rdy_tmp),
        .req    (arb_req),
        .grt    (arb_grt)
    );
    
    //---------- output
    assign buf_out_rdy = arb_grt;
    
    assign out_vld_tmp = |arb_grt;
    
generate   
 case(IN_CNT)
    2:
begin
	assign out_data_tmp = arb_grt[0] ? buf_out_data[0] : buf_out_data[1];
  end
 3:
begin 
    assign out_data_tmp = arb_grt[0] ? buf_out_data[0] :
                          arb_grt[1] ? buf_out_data[1] :
                          buf_out_data[2];
  end
 4: 
begin
    assign out_data_tmp = arb_grt[0] ? buf_out_data[0] :
                          arb_grt[1] ? buf_out_data[1] :
                          arb_grt[2] ? buf_out_data[2] :
                          buf_out_data[3];
  end
endcase

/** FIXME: Vitorio was here */
/* if (IN_CNT==2) begin: IN_CNT_2
    assign out_data_tmp = arb_grt[0] ? buf_out_data[0] :
                          buf_out_data[1];
  end
  
  if (IN_CNT==3) begin: IN_CNT_3
    assign out_data_tmp = arb_grt[0] ? buf_out_data[0] :
                          arb_grt[1] ? buf_out_data[1] :
                          buf_out_data[2];
  end
  
  if (IN_CNT==4) begin: IN_CNT_4
    assign out_data_tmp = arb_grt[0] ? buf_out_data[0] :
                          arb_grt[1] ? buf_out_data[1] :
                          arb_grt[2] ? buf_out_data[2] :
                          buf_out_data[3];
  end
*/  
endgenerate    
    
    //---------- optional output pipline
    sd_ppln_cell_rstn 
    #( .width       (DATA_WIDTH),
       .pp_type     (OUT_PPLN_OPT)    //0: not pipelined; 1: sd_flop; 2: sd_output; 3: sd_iofull
    )
    output_ppln_cell_u
    (
        .clk    (clk),
        .rstn    (rstn),

        //--------- config
        .cfg_is_clk_gated   (1'b0),
    
        //-------- interrupt

        //--------- I/O
        .c_srdy     (out_vld_tmp),  
        .c_drdy     (out_rdy_tmp),
        .c_data     (out_data_tmp),    
    
        .p_srdy     (out_vld),    
        .p_drdy     (out_rdy),
        .p_data     (out_data)
    );
    
endmodule
