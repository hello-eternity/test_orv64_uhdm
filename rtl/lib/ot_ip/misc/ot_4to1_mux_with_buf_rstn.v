//=====================================================================================================
// Copyright (c) 2021 RISC-V International Open Source Laboratory (RIOS Lab) -- All Rights Reserved
//=====================================================================================================
// File   : ot_4to1_mux_with_buf_rstn.v
// Author : Anh Tran
//=====================================================================================================
// Description:
//  4-input mux with input buffering
//
//=====================================================================================================
module ot_4to1_mux_with_buf_rstn
    #( parameter    DATA_WIDTH = 128,
       parameter    BUF_DEPTH = 2
    )
    (
        input   clk,
        input   rstn,

        input logic                     in_vld  [4],
        output logic                    in_rdy  [4],
        input logic [DATA_WIDTH-1:0]    in_data [4],

        output logic                     out_vld,
        input logic                      out_rdy,
        output logic [DATA_WIDTH-1:0]    out_data
        
    );
    
    //================ BODY ===================
    //-------- buffering input data in case of congestion
    logic [3:0]                     buf_out_vld;
    logic [3:0]                     buf_out_rdy;
    logic [3:0] [DATA_WIDTH-1:0]    buf_out_data;
    
generate
    for (genvar ii=0; ii<3; ii++) begin: buf_ii
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
endgenerate
    
    //--------- arbitrate among input data
    logic [3:0]     arb_req;
    logic [3:0]     arb_grt;
    
    assign arb_req = {buf_out_vld[3], buf_out_vld[2], buf_out_vld[1], buf_out_vld[0]};
    
    ot_rr_arbiter_rstn 
    #( .input_cnt   (4)
    )
    rr_arbiter_u
    (
        .clk    (clk),
        .rstn    (rstn),
    
        .ready  (out_rdy),
        .req    (arb_req),
        .grt    (arb_grt)
    );
    
    //---------- output
    assign buf_out_rdy[0] = arb_grt[0];
    assign buf_out_rdy[1] = arb_grt[1];
    assign buf_out_rdy[2] = arb_grt[2];
    assign buf_out_rdy[3] = arb_grt[3];
    
    assign out_vld = |arb_grt;
    assign out_data = arb_grt[0] ? buf_out_data[0] :
                      arb_grt[1] ? buf_out_data[1] :
                      arb_grt[2] ? buf_out_data[2] :
                      buf_out_data[3];
    
endmodule
