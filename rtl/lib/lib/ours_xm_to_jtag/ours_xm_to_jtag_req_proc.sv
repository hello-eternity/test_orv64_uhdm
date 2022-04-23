//===============================================
// Filename     : ours_xm_to_jtag_req_proc.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2020-02-09 02:38:20
// Description  : 
//================================================

module ours_xm_to_jtag_req_proc
#(
`ifdef PYGMY_E
    parameter JTAG2OR_CODE_SIZE     = 4,
    parameter JTAG2OR_CMDBUF_CODE   = 4'b1101,
    parameter JTAG2OR_CMDVLD_CODE   = 4'b0010,
    parameter JTAG2OR_RDATAVLD_CODE = 4'b0111,
    parameter JTAG2OR_RDATA_CODE    = 4'b1010,
`elsif PYGMY_ES1Y
    parameter JTAG2OR_CODE_SIZE     = 5,
    parameter JTAG2OR_CMDBUF_CODE   = 5'b11101,
    parameter JTAG2OR_CMDVLD_CODE   = 5'b10010,
    parameter JTAG2OR_RDATAVLD_CODE = 5'b10111,
    parameter JTAG2OR_RDATA_CODE    = 5'b11010,
`endif
    parameter JTAG_OP_W      = 2 ,
    parameter JTAG_ADDR_W    = 40,
    parameter JTAG_DATA_W    = 64 
)
(
    input  logic                      clk                ,
    input  logic                      rst_n              ,
    input  logic                      jtag_req_vld       ,
    output logic                      jtag_req_rdy       ,
    input  logic  [JTAG_OP_W-1:0]     jtag_req_op        ,
    input  logic  [JTAG_ADDR_W-1:0]   jtag_req_addr      ,
    input  logic  [JTAG_DATA_W-1:0]   jtag_req_data      ,
    output logic                      jtag_rd_resp_vld   ,
    input  logic                      jtag_rd_resp_rdy   ,
    output logic  [JTAG_DATA_W-1:0]   jtag_rd_resp_data  ,
    output logic                      jtag_trst_n        ,
//    output logic                      jtag_tck           ,
    output logic                      jtag_tms           ,
    output logic                      jtag_tdi           ,
    input  logic                      jtag_tdo           
);
localparam      ST_IDLE             = 5'd0 ,
                ST_WR_RD_STG_0_SEND = 5'd1 ,
                ST_WR_RD_STG_0_WAIT = 5'd2 ,
                ST_WR_RD_STG_1_SEND = 5'd3 ,
                ST_WR_RD_STG_1_WAIT = 5'd4 ,
                ST_WR_RD_STG_2_SEND = 5'd5 ,
                ST_WR_RD_STG_2_WAIT = 5'd6 ,
                ST_RD_STG_3_SEND    = 5'd7 ,
                ST_RD_STG_3_WAIT    = 5'd8 ,
                ST_RD_STG_4_SEND    = 5'd9 ,
                ST_RD_STG_4_WAIT    = 5'd10,
                ST_RD_STG_5_SEND    = 5'd11,
                ST_RD_STG_5_WAIT    = 5'd12,
                ST_RD_STG_6         = 5'd13;


                

logic   [19:0]  rff_rst_st_jtag_shift_in_trst_n;
logic   [19:0]  rff_rst_st_jtag_shift_in_tms;
logic           rff_rst_st;
logic           rst_st_nxt;
logic   [4:0]   rff_rst_st_xfer_cnt;
logic   [4:0]   rst_st_xfer_cnt_nxt;


logic   [4:0]   rff_st;
logic   [4:0]   st_nxt;

logic                                   shift_in_vld;
logic   [JTAG2OR_CODE_SIZE - 1 : 0]     shift_in_inst;
logic   [128-1:0]                       shift_in_data;
logic   [7:0]                           shift_in_size;
logic                                   shift_out_data_vld;
logic   [64-1:0]                        shift_out_data;
logic                                   nrm_jtag_tms;
logic                                   nrm_jtag_tdi;
//----------------------------------------------
//reset sequence after hardware reset release
//----------------------------------------------

always_ff @(posedge clk)begin
    if(!rst_n)begin
        rff_rst_st              <= 1'b1;
        rff_rst_st_xfer_cnt     <= 5'd20;
    end
    else begin
        rff_rst_st              <= rst_st_nxt;
        rff_rst_st_xfer_cnt     <= rst_st_xfer_cnt_nxt;
    end
end

always_comb begin
    rst_st_nxt          = rff_rst_st;
    rst_st_xfer_cnt_nxt = rff_rst_st_xfer_cnt;
    case(rff_rst_st)
        1'b1 : begin
            rst_st_xfer_cnt_nxt = rff_rst_st_xfer_cnt - 1'b1;
            if(rst_st_xfer_cnt_nxt == 5'd0)begin
                rst_st_nxt  = 1'b0;
            end
        end
        1'b0 : begin
            rst_st_xfer_cnt_nxt = 5'd0;
            rst_st_nxt          = 1'b0;
        end
    endcase
end

always_ff @(posedge clk )begin
    if(!rst_n)begin
        rff_rst_st_jtag_shift_in_trst_n     <= {{10{1'b1}},{10{1'b0}}};
        rff_rst_st_jtag_shift_in_tms        <= {{10{1'b1}},{10{1'b0}}};
    end
    else if(rff_rst_st)begin
        rff_rst_st_jtag_shift_in_trst_n     <= {1'b1,rff_rst_st_jtag_shift_in_trst_n[19:1]};
        rff_rst_st_jtag_shift_in_tms        <= {1'b0,rff_rst_st_jtag_shift_in_tms[19:1]};
    end
end
assign  jtag_trst_n     = rff_rst_st_jtag_shift_in_trst_n[0];
assign  jtag_tms        = rff_rst_st ? rff_rst_st_jtag_shift_in_tms[0] : nrm_jtag_tms;
assign  jtag_tdi        = rff_rst_st ? 1'b0 : nrm_jtag_tdi;

always_ff @(posedge clk)begin
    if(!rst_n)begin
        rff_st  <= ST_IDLE;
    end
    else begin
        rff_st  <= st_nxt;
    end
end

always_comb begin
    st_nxt          = rff_st;
    shift_in_vld    = 1'b0;
    shift_in_inst   = '0;
    shift_in_data   = '0;
    shift_in_size   = '0;
    jtag_req_rdy    = 1'b0;
    jtag_rd_resp_vld    = 1'b0;
    case( rff_st )
        ST_IDLE     : begin
            if(~rff_rst_st & jtag_req_vld)begin
                 st_nxt  = ST_WR_RD_STG_0_SEND;
            end
        end
        ST_WR_RD_STG_0_SEND : begin
            shift_in_vld    = 1'b1;
            shift_in_inst   = JTAG2OR_CMDVLD_CODE;
            shift_in_data   = 128'b11111;
            shift_in_size   = 5;
            st_nxt          = ST_WR_RD_STG_0_WAIT;
        end
        ST_WR_RD_STG_0_WAIT : begin
            if(shift_out_data_vld)begin
                st_nxt  = ST_WR_RD_STG_1_SEND;
            end
        end
        ST_WR_RD_STG_1_SEND : begin
            shift_in_vld    = 1'b1;
            shift_in_inst   = JTAG2OR_CMDBUF_CODE;
            shift_in_data   = {jtag_req_data,jtag_req_addr,jtag_req_op}; 
            shift_in_size   = 128;
            st_nxt          = ST_WR_RD_STG_1_WAIT;
        end
        ST_WR_RD_STG_1_WAIT : begin
            if(shift_out_data_vld)begin
                st_nxt      = ST_WR_RD_STG_2_SEND;
            end
        end
        ST_WR_RD_STG_2_SEND : begin
            shift_in_vld    = 1'b1;
            shift_in_inst   = JTAG2OR_CMDVLD_CODE;
            shift_in_data   = 128'b00000;
            shift_in_size   = 5;
            st_nxt          = ST_WR_RD_STG_2_WAIT;
        end
        ST_WR_RD_STG_2_WAIT : begin
            if(shift_out_data_vld)begin
                if(jtag_req_op[0])begin
                    st_nxt = ST_IDLE;
                    jtag_req_rdy = 1'b1;
                end
                else begin
                    st_nxt = ST_RD_STG_3_SEND;
                end
            end
        end
        ST_RD_STG_3_SEND : begin
            shift_in_vld    = 1'b1;
            shift_in_inst   = JTAG2OR_CMDVLD_CODE;
            shift_in_data   = 128'b00000;
            shift_in_size   = 5;
            st_nxt          = ST_RD_STG_3_WAIT;
        end
        ST_RD_STG_3_WAIT : begin
            if(shift_out_data_vld)begin
                st_nxt      = ST_RD_STG_4_SEND;
            end
        end
        ST_RD_STG_4_SEND : begin
            shift_in_vld    = 1'b1;
            shift_in_inst   = JTAG2OR_RDATAVLD_CODE;
            shift_in_data   = 128'b00000;
            shift_in_size   = 5;
            st_nxt          = ST_RD_STG_4_WAIT;

        end
        ST_RD_STG_4_WAIT : begin
            if(shift_out_data_vld)begin
                if(shift_out_data[0])begin
                    st_nxt = ST_RD_STG_5_SEND;
                end
                else begin
                    st_nxt = ST_RD_STG_3_SEND;
                end
            end
        end
        ST_RD_STG_5_SEND : begin
            shift_in_vld    = 1'b1;
            shift_in_inst   = JTAG2OR_RDATA_CODE;
            shift_in_data   = 128'b00000;
            shift_in_size   = 64;
            st_nxt          = ST_RD_STG_5_WAIT;
        end
        ST_RD_STG_5_WAIT : begin
            if(shift_out_data_vld)begin
                jtag_rd_resp_vld    = 1'b1;
            end
            if(jtag_rd_resp_vld)begin
                if(jtag_rd_resp_rdy)begin
                    jtag_req_rdy        = 1'b1;
                    st_nxt              = ST_IDLE;
                end
                else begin
                    st_nxt              = ST_RD_STG_6;
                end
            end
        end
        ST_RD_STG_6 : begin
            jtag_rd_resp_vld    = 1'b1;
            if(jtag_rd_resp_rdy)begin
                jtag_req_rdy    = 1'b1;
                st_nxt          = ST_IDLE;
            end
        end
    endcase
end
assign  jtag_rd_resp_data = shift_out_data;

ours_xm_to_jtag_shift_inst_data
#(
    .JTAG2OR_CODE_SIZE  ( JTAG2OR_CODE_SIZE   )
)
OURS_XM_TO_JTAG_SHIFT_INST_DATA_U
(
     .clk               ( clk                   )
    ,.rst_n             ( rst_n                 )
    ,.vld_i             ( shift_in_vld          )
    ,.inst_i            ( shift_in_inst         )
    ,.data_i            ( shift_in_data         )
    ,.data_size_i       ( shift_in_size         )
    ,.vld_o             ( shift_out_data_vld    )
    ,.data_o            ( shift_out_data        )
    ,.jtag_tms_o        ( nrm_jtag_tms          )
    ,.jtag_tdi_o        ( nrm_jtag_tdi          )
    ,.jtag_tdo_i        ( jtag_tdo              )
);

endmodule
