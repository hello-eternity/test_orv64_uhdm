//===============================================
// Filename     : ours_xm_to_jtag_shift_inst_data.sv
// Author       : cuiluping
// Email        : luping.cui@rivai-ic.com.cn
// Date         : 2020-02-08 19:30:34
// Description  : 
//              1) shift instruction and n-bit data into dut through JTAG_TDI
//              2) shift n-bit data from dut through JTAG TDO
//================================================

module ours_xm_to_jtag_shift_inst_data
#(
    parameter JTAG2OR_CODE_SIZE = 4
)
(
    input                               clk,
    input                               rst_n,
    input                               vld_i,
    input   [JTAG2OR_CODE_SIZE-1:0]     inst_i,//shift in code
    input   [128-1:0]                   data_i,//shift in data
    input   [7 : 0]                     data_size_i,//valid number of bit in data_i
    output                              vld_o,//data_o vld
    output  [64-1:0]                    data_o,
//    output                              jtag_tck_o,
    output                              jtag_tms_o,
    output                              jtag_tdi_o,
    input                               jtag_tdo_i
);
localparam      TMS_FLD_0   = 5'b00110;
//localparam      TMS_FLD_1   = 4'b1000
localparam      TMS_FLD_2   = 4'b0011;
//localparam      TMS_FLD_3   =
localparam      TMS_FLD_4   = 2'b01;

localparam      TDI_FLD_0   = 5'b00000;
//localparam      TDI_FLD_1   = //code
localparam      TDI_FLD_2   = 4'b0000;
//localparam      TDI_FLD_3   = //data
localparam      TDI_FLD_4   = 2'b00;

localparam      ST_IDLE     = 2'b00,
                ST_XFER     = 2'b01,
                ST_DONE     = 2'b10;
logic   [JTAG2OR_CODE_SIZE-1:0] tms_fld_1;
logic   [128-1:0]   data_i_shfl;
logic   [128-1:0]   data_i_useful;
logic   [255:0]     rffce_shift_in_pld_tms;
logic   [255:0]     shift_in_pld_tms_nxt;
logic   [255:0]     rffce_shift_in_pld_tdi;
logic   [255:0]     shift_in_pld_tdi_nxt;

logic               shift_out_data_en;
logic   [127:0]     rffce_shift_out_data;
logic   [6:0]       rffce_shift_out_data_ptr;

logic   [7:0] rffce_data_size;
logic   [7:0] rffce_shift_num_tot;

logic   [1:0]                   rff_st;
logic   [1:0]                   st_nxt;
logic   [7:0] rff_xfer_cnt;
logic   [7:0] xfer_cnt_nxt;
assign      tms_fld_1                                       = {1'b1,{JTAG2OR_CODE_SIZE-1{1'b0}}};
assign      shift_in_pld_tms_nxt[0+:9+JTAG2OR_CODE_SIZE]    = {TMS_FLD_2,tms_fld_1,TMS_FLD_0};
assign      shift_in_pld_tms_nxt[9+JTAG2OR_CODE_SIZE+:130]  = {127'h0,TMS_FLD_4,1'b1} << (data_size_i-1);
assign      shift_in_pld_tms_nxt[255:139+JTAG2OR_CODE_SIZE] = '0;

assign      data_i_shfl                     = data_i << (128-data_size_i);
assign      data_i_useful                   = data_i_shfl >> (128-data_size_i);
assign      shift_in_pld_tdi_nxt            = {{256-139-JTAG2OR_CODE_SIZE{1'b0}},TDI_FLD_4,data_i_useful,TDI_FLD_2,inst_i,TDI_FLD_0};
    
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rffce_data_size         <= '0;
        rffce_shift_num_tot     <= '0;
    end
    else if(vld_i)begin
        rffce_data_size         <= data_size_i;
        rffce_shift_num_tot     <= data_size_i + 15;
    end
end
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rffce_shift_in_pld_tms  <= '0;
        rffce_shift_in_pld_tdi  <= '0;
    end
    else if(vld_i)begin
        rffce_shift_in_pld_tms  <= shift_in_pld_tms_nxt;
        rffce_shift_in_pld_tdi  <= shift_in_pld_tdi_nxt;
    end
    else if(rff_st == ST_XFER)begin
        rffce_shift_in_pld_tms  <= {1'b0,rffce_shift_in_pld_tms[255:1]}; 
        rffce_shift_in_pld_tdi  <= {1'b0,rffce_shift_in_pld_tdi[255:1]};
    end
end


//FSM
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rff_st          <= ST_IDLE;
        rff_xfer_cnt    <= '0;
    end
    else begin
        rff_st          <= st_nxt;
        rff_xfer_cnt    <= xfer_cnt_nxt;
    end
end

always_comb begin
    st_nxt          = rff_st;
    xfer_cnt_nxt    = '0;
    case(rff_st)
        ST_IDLE : begin
            if(vld_i)begin
                st_nxt  = ST_XFER;
            end
        end
        ST_XFER : begin
            xfer_cnt_nxt    = rff_xfer_cnt + 1'b1;
            if(xfer_cnt_nxt == rffce_shift_num_tot)begin
                st_nxt      = ST_DONE;
            end
        end
        ST_DONE : begin
            xfer_cnt_nxt    = '0;
            st_nxt          = ST_IDLE;
        end
    endcase
end
//get jtag shift out data
assign  shift_out_data_en = (rff_xfer_cnt >= 13) & (rff_xfer_cnt < rffce_data_size + 13);
always_ff @(posedge clk )begin
    if(!rst_n)begin
        rffce_shift_out_data    <= '0;
        rffce_shift_out_data_ptr<= '0;
    end
    else if(vld_i)begin
        rffce_shift_out_data    <= '0;
        rffce_shift_out_data_ptr<= '0;
    end
    else if(shift_out_data_en)begin
        rffce_shift_out_data[rffce_shift_out_data_ptr]  <= jtag_tdo_i;
        rffce_shift_out_data_ptr                        <= rffce_shift_out_data_ptr + 1'b1;
    end
end
//----------------------------------
//generate output
//----------------------------------
assign  vld_o       = (rff_st == ST_DONE);
assign  data_o      = rffce_shift_out_data;
assign  jtag_tms_o  = rffce_shift_in_pld_tms[0];
assign  jtag_tdi_o  = rffce_shift_in_pld_tdi[0];

endmodule

