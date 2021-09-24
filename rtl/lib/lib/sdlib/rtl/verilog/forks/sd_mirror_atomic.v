// Copyright (c) 2012 XPliant, Inc -- All rights reserved
//-----------------------------------------------------------------------------
// sd_mirror_atomic.v
// 
// Description:
//      - A simple mirror (100% throughput) for forwarding the same output from 
//          a sender to multiple receivers. The sender only forwards data if
//          all receivers are ready to accept data.
//
//      - In the simplest case, the mirror design has no register inside, only logic. 
//          This may causes combo loop if the I/O of senders and receivers
//          don't have registers for timing closure.
//
//      - For timing closure and avoiding combo loop, 
//        set option values for c_closure and p_closure by:
//
//          + c_closure = 0: no timing closure at the comsuming side; 
//                          this option assumes the outputs of senders already 
//                          have sd_input or sd_output 
//                          (please double check the RTL of senders 
//                          before choosing this option).
//          + c_closure = 1: add sd_input at the consuming side
//          + c_closure = 2: add sd_output at the consuming side
//          + c_closure = 3: add sd_iofull at the consuming side
//
//      - Also consider to use sd_mirror.v which already support timing closure
// Author: Anh Tran
// Written: 2012/12/18
//  
//-----------------------------------------------------------------------------

`ifndef SD_MIRROR_ATOMIC_V
`define SD_MIRROR_ATOMIC_V
module sd_mirror_atomic 
    #(  parameter mirror_cnt=2,
        parameter width=32,
        parameter c_closure=0,
        parameter isinput = 0  // if this mirror is at input of the block, set this to 1
    )
    (

    input   clk,
    input   rst,
    
    input              c_srdy,
    output             c_drdy,
    input [width-1:0]  c_data,
    
    output [mirror_cnt-1:0] p_srdy,
    input [mirror_cnt-1:0]      p_drdy,
    output [width-1:0]  p_data

    /*AUTOINPUT*/    
    );

    logic ic_srdy;
    logic ic_drdy;
    logic [width-1:0]   ic_data;
    
    logic out_srdy;

    logic [mirror_cnt-1:0]  ip_srdy;
    logic [mirror_cnt-1:0]  ip_drdy;
    logic [width-1:0]   ip_data;
    
    //================== BODY ==================
    
    //----------- c_closure option
    generate
        case (c_closure)
            0:  begin:  c_closure_no
                assign ic_srdy = c_srdy;
                assign c_drdy = ic_drdy;
                assign ic_data = c_data;
            end
            1:  begin:  c_closure_sd_input
                sd_input #(.width(width))
                    ic_sd_input (
                        .clk (clk),
                        .reset (rst),
                        .c_srdy (c_srdy),
                        .c_drdy (c_drdy),
                        .c_data (c_data),

                        .ip_srdy (ic_srdy),
                        .ip_drdy (ic_drdy),
                        .ip_data (ic_data)
                    );
            end
            2:  begin:  c_closure_sd_output
                sd_output #(.width(width))
                    ic_sd_output (
                        .clk (clk),
                        .reset (rst),
                        .ic_srdy (c_srdy),
                        .ic_drdy (c_drdy),
                        .ic_data (c_data),

                        .p_srdy (ic_srdy),
                        .p_drdy (ic_drdy),
                        .p_data (ic_data)
                    );
            end
            3:  begin:  c_closure_sd_iofull
                sd_iofull #(.width(width),
                            .isinput (isinput)
                            )
                    ic_sd_iofull (
                        .clk (clk),
                        .reset (rst),
                        .c_srdy (c_srdy),
                        .c_drdy (c_drdy),
                        .c_data (c_data),

                        .p_srdy (ic_srdy),
                        .p_drdy (ic_drdy),
                        .p_data (ic_data)
                    );
            end
        endcase
    endgenerate
    
    //----------- internal logic
    assign ic_drdy = &(ip_drdy);
    
    assign out_srdy = ic_srdy & ic_drdy;
    
    genvar i;
    generate
        for(i=0; i<mirror_cnt; i=i+1) begin: ip_srdy_i
//            assign p_srdy[i] = c_srdy & (c_drdy | ~p_drdy[i]);
            assign ip_srdy[i] = out_srdy;
        end
    endgenerate

    assign ip_data = ic_data;


    //---------- output
    assign p_srdy = ip_srdy;
    assign ip_drdy = p_drdy;
    
    assign p_data = ip_data;
        
endmodule
`endif // SD_MIRROR_ATOMIC_V
