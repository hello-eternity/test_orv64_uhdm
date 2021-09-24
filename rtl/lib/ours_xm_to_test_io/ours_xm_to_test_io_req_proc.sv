//===============================================
// Filename     : ours_xm_to_test_io_req_proc.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2020-02-09 02:38:20
// Description  : 
//  1) for write will shift in 106-bit pld( op(2-bit) + addr(40-bit) + data(64-bit)),and get 1-bit resp
//  2) for read will  shift in 42-bit pld( op(2-bit) + addr(40-bit)), and get 64-bit data resp
//  3) op : write -> 2'b01, read -> 2'b00
//  4) LSB first
//================================================

module ours_xm_to_test_io_req_proc
#(
    parameter TEST_IO_OP_W      = 2 ,
    parameter TEST_IO_ADDR_W    = 40,
    parameter TEST_IO_DATA_W    = 64 
)
(
     input  logic                      clk                   
    ,input  logic                      rst_n                 
    ,input  logic                      test_io_req_vld       
    ,output logic                      test_io_req_rdy       
    ,input  logic  [TEST_IO_OP_W-1:0]  test_io_req_op        
    ,input  logic  [TEST_IO_ADDR_W-1:0]test_io_req_addr      
    ,input  logic  [TEST_IO_DATA_W-1:0]test_io_req_data      
    ,output logic                      test_io_rd_resp_vld   
    ,input  logic                      test_io_rd_resp_rdy   
    ,output logic  [TEST_IO_DATA_W-1:0]test_io_rd_resp_data  
    ,output logic                      test_io_eoen
    ,output logic                      test_io_eout
    ,input  logic                      test_io_ein
    ,output logic                      test_io_doen
    ,output logic                      test_io_dout
    ,input  logic                      test_io_din
);
localparam      ST_IDLE             = 5'd0 ,
                ST_WR_REQ_SEND      = 5'd1 ,
                ST_WR_RESP_WAIT     = 5'd2 ,
                ST_RD_REQ_SEND      = 5'd3 ,
                ST_RD_RESP_WAIT     = 5'd4 ,
                ST_RD_RSLT_SEND     = 5'd5 ;


logic   [4:0]                       rff_st;
logic   [4:0]                       st_nxt;

logic   [128-1:0]                   rffce_shift_in_data;
logic   [7:0]                       rffce_shift_in_size;
logic                               shift_in_vld;
logic   [128-1:0]                   shift_in_data;
logic   [7:0]                       shift_in_size;
logic                               shift_out_data_vld;
logic   [64-1:0]                    shift_out_data;
logic   [TEST_IO_OP_W-1:0]          test_io_req_op_reverse;
logic   [TEST_IO_ADDR_W-1:0]        test_io_req_addr_reverse;
logic   [TEST_IO_DATA_W-1:0]        test_io_req_data_reverse;
genvar i;
generate
    for(i=0;i<TEST_IO_OP_W;i++)begin : GEN_TEST_IO_REQ_OP_REVERSE
        assign  test_io_req_op_reverse[i]   = test_io_req_op[TEST_IO_OP_W-1-i];
    end
    for(i=0;i<TEST_IO_ADDR_W;i++)begin : GEN_TEST_IO_REQ_ADDR_REVERSE
        assign  test_io_req_addr_reverse[i]   = test_io_req_addr[TEST_IO_ADDR_W-1-i];
    end
    for(i=0;i<TEST_IO_DATA_W;i++)begin : GEN_TEST_IO_REQ_DATA_REVERSE
        assign  test_io_req_data_reverse[i]   = test_io_req_data[TEST_IO_DATA_W-1-i];
    end
endgenerate

assign  shift_in_data   = rffce_shift_in_data;
assign  shift_in_size   = rffce_shift_in_size;
assign  test_io_rd_resp_data = shift_out_data;
always_ff @(posedge clk)begin
    if(!rst_n)begin
        rffce_shift_in_data <= '0;
        rffce_shift_in_size <= '0;
    end
    else if(test_io_req_vld & test_io_req_rdy)begin
        rffce_shift_in_data <= {{128-TEST_IO_DATA_W - TEST_IO_ADDR_W - TEST_IO_OP_W{1'b0}},
                                test_io_req_data_reverse,
                                test_io_req_addr_reverse,
                                test_io_req_op_reverse};
        rffce_shift_in_size <= test_io_req_op[0] ? 8'd106 : 8'd42;
    end
end

always_ff @(posedge clk)begin
    if(!rst_n)begin
        rff_st  <= ST_IDLE;
    end
    else begin
        rff_st  <= st_nxt;
    end
end

always_comb begin
    st_nxt              = rff_st;
    test_io_req_rdy     = 1'b0;
    shift_in_vld        = 1'b0;
    test_io_rd_resp_vld = 1'b0;
    case(rff_st)
        ST_IDLE : begin
            test_io_req_rdy = 1'b1;
            if(test_io_req_vld)begin
                if(test_io_req_op[0])begin
                    st_nxt = ST_WR_REQ_SEND;
                end
                else begin
                    st_nxt = ST_RD_REQ_SEND;
                end
            end
        end
        ST_WR_REQ_SEND : begin
            shift_in_vld    = 1'b1;
            st_nxt          = ST_WR_RESP_WAIT;
        end
        ST_WR_RESP_WAIT : begin
            if(shift_out_data_vld)begin
                st_nxt      = ST_IDLE;
            end
        end
        ST_RD_REQ_SEND : begin
            shift_in_vld    = 1'b1;
            st_nxt          = ST_RD_RESP_WAIT;
        end
        ST_RD_RESP_WAIT : begin
            if(shift_out_data_vld)begin
                test_io_rd_resp_vld = 1'b1;
                if(test_io_rd_resp_rdy)begin
                    st_nxt  = ST_IDLE;
                end
                else begin
                    st_nxt  = ST_RD_RSLT_SEND;
                end
            end
        end
        ST_RD_RSLT_SEND : begin
            test_io_rd_resp_vld = 1'b1;
            if(test_io_rd_resp_rdy)begin
                st_nxt      = ST_IDLE;
            end
        end

    endcase

end

ours_xm_to_test_io_shift_inst_data OURS_XM_TO_TEST_IO_SHIFT_INST_DATA_U
(
     .clk               ( clk                   )
    ,.rst_n             ( rst_n                 )
    ,.vld_i             ( shift_in_vld          )
    ,.data_i            ( shift_in_data         )
    ,.data_size_i       ( shift_in_size         )
    ,.vld_o             ( shift_out_data_vld    )
    ,.data_o            ( shift_out_data        )
    ,.test_io_eoen      ( test_io_eoen          ) 
    ,.test_io_eout      ( test_io_eout          )
    ,.test_io_ein       ( test_io_ein           )
    ,.test_io_doen      ( test_io_doen          )
    ,.test_io_dout      ( test_io_dout          )
    ,.test_io_din       ( test_io_din           )


);

endmodule
