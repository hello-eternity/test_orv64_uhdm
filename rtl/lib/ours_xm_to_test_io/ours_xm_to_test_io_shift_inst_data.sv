//===============================================
// Filename     : ours_xm_to_test_io_shift_inst_data.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2020-02-08 19:30:34
// Description  : 
//              1) shift instruction and n-bit data into dut through JTAG_TDI
//              2) shift n-bit data from dut through JTAG TDO
//================================================

module ours_xm_to_test_io_shift_inst_data
(
    input  logic                             clk,
    input  logic                             rst_n,
    input  logic                             vld_i,
    input  logic [128-1:0]                   data_i,//shift in data
    input  logic [7 : 0]                     data_size_i,//valid number of bit in data_i
    output logic                             vld_o,//data_o vld
    output logic [64-1:0]                    data_o,
    //test io interface
    output logic                             test_io_eoen,//active low
    output logic                             test_io_eout,
    input  logic                             test_io_ein,
    output logic                             test_io_doen,//active low
    output logic                             test_io_dout,
    input  logic                             test_io_din
);
localparam      ST_IDLE         = 2'b00,
                ST_REQ_SEND     = 2'b01,
                ST_RESP_WAIT    = 2'b10,
                ST_DONE         = 2'b11;
logic   [127:0]     rffce_shift_in_data;

logic               shift_out_data_en;
logic   [127:0]     rffce_shift_out_data;

logic   [7:0]       rffce_data_size;
logic               rffce_op;//1 -> wr, 0 -> rd
logic   [7:0]       resp_cnt_tot;

logic   [1:0]       rff_st;
logic   [1:0]       st_nxt;
logic   [7:0]       rff_req_cnt;
logic   [7:0]       req_cnt_nxt;
logic   [7:0]       rff_resp_cnt;
logic   [7:0]       resp_cnt_nxt;

assign  shift_in_data_nxt       = data_i;
assign  resp_cnt_tot            = rffce_op ? 8'd1 : 8'd64;
    
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rffce_data_size         <= '0;
    end
    else if(vld_i)begin
        rffce_data_size         <= data_size_i;
    end
end
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rffce_shift_in_data  <= '0;
    end
    else if(vld_i)begin
        rffce_shift_in_data  <= data_i;
    end
    else if(rff_st == ST_REQ_SEND)begin
        rffce_shift_in_data  <= {1'b0,rffce_shift_in_data[127:1]};
    end
end
always_ff @(posedge clk)begin
    if(!rst_n)begin
        rffce_op             <= 1'b0;
    end
    else if(vld_i)begin
        rffce_op             <= data_i[1];
    end
end


//FSM
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rff_st          <= ST_IDLE;
        rff_req_cnt     <= '0;
        rff_resp_cnt    <= '0;
    end
    else begin
        rff_st          <= st_nxt;
        rff_req_cnt     <= req_cnt_nxt;
        rff_resp_cnt    <= resp_cnt_nxt;
    end
end

always_comb begin
    st_nxt          = rff_st;
    req_cnt_nxt     = '0;
    resp_cnt_nxt    = '0;
    case(rff_st)
        ST_IDLE : begin
            if(vld_i)begin
                st_nxt  = ST_REQ_SEND;
            end
        end
        ST_REQ_SEND : begin
            req_cnt_nxt    = rff_req_cnt + 1'b1;
            if(req_cnt_nxt == rffce_data_size)begin
                st_nxt     = ST_RESP_WAIT;
            end
        end
        ST_RESP_WAIT : begin
            if(shift_out_data_en)begin
                resp_cnt_nxt   = rff_resp_cnt + 1'b1;
                if(resp_cnt_nxt == resp_cnt_tot)begin
                    st_nxt  = ST_DONE;
                end
            end
        end
        ST_DONE : begin
            st_nxt  = ST_IDLE;
        end
    endcase
end

//get test_io shift out data
assign  shift_out_data_en   = test_io_eoen & test_io_ein;
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rffce_shift_out_data    <= '0;
    end
    else if(vld_i)begin
        rffce_shift_out_data    <= '0;
    end
    else if(shift_out_data_en)begin
        rffce_shift_out_data    <= {rffce_shift_out_data[126:0],test_io_din};
    end
end
//----------------------------------
//generate output
//----------------------------------
assign  vld_o       = (rff_st == ST_DONE);
assign  data_o      = rffce_shift_out_data;
assign  test_io_eoen= (rff_st == ST_REQ_SEND) ? 1'b0 : 1'b1;
assign  test_io_eout= (rff_st == ST_REQ_SEND);
assign  test_io_doen= test_io_eoen;
assign  test_io_dout= rffce_shift_in_data[0];

endmodule

