`timescale 1ns/1ps

module dft_or2 (
  input in0,
  input in1,
  output out);
  
  assign out = in0 | in1;

endmodule

module dft_and (
  input in0,
  input in1,
  output out);
  
  assign out = in0 & in1;

endmodule

module dft_inv (
  input in,
  output out
);
`ifndef FPGA
  INVD1BWP40P140 dft1 ( .I(in), .ZN(out) );
`else
  assign out = ~in;
`endif
endmodule



module dft_clk_buf (
  input in,
  output out
);

`ifndef FPGA
  CKBD8BWP30P140  clk_buf (.Z(out), .I(in));
`else
  assign out = in;
`endif

endmodule


module scan_supressed_clk (
  input   clk_in,
  input   scan_mode,
  output  clk_out
);

`ifndef FPGA
  CKMUX2D1BWP40P140 dft20 ( .I0(clk_in), .I1(1'b0), .S(scan_mode), .Z(clk_out) );
`else
  assign clk_out = clk_in;
`endif

endmodule



module dft_reset_inv (
  input reset_in, 
  output reset_out
);

`ifndef FPGA
  INVD1BWP40P140 dft21 ( .I(reset_in), .ZN(reset_out) );
`else
  assign reset_out = ~reset_in;
`endif

endmodule



// create 1 bit and two bit versions
module dft_mux4x2 (
  input   sel0,
  input   sel1,
  input   din0,
  input   din1,
  input   din2,
  input   din3,
  output  dout
);

`ifndef FPGA
  MUX4D0BWP40P140 dft23 ( .I0(din0), .I1(din1), .I2(din2) , .I3(din3), .S0(sel0), .S1(sel1) , .Z(dout) );
`else
  assign dout = ({sel1,sel0} == 2'b00) ? din0 : 
                ({sel1,sel0} == 2'b01) ? din1 : 
                ({sel1,sel0} == 2'b10) ? din2 : din3;
`endif

endmodule


module dft_mux2x1  (
  input  sel,
  input  din0,
  input  din1,
  output dout
);

`ifndef FPGA
  MUX2D1BWP40P140 dft22 ( .I0(din0), .I1(din1), .S(sel), .Z(dout) );
`else
  assign dout = sel ? din1 : din0;
`endif

endmodule


// for ddr bypass muxes
module dft_clk_mux_sel (
  input  scan_mode,
  input  sel_in,
  output sel_out
);

`ifndef FPGA
  MUX2D1BWP40P140 dft13 ( .I0(sel_in), .I1(1'b0), .S(scan_mode), .Z(sel_out) );
`else
  assign sel_out = sel_in;
`endif

endmodule



module dft_icg_enable (
  input  test_mode,
  input  scan_mode,
  output enable0,
  output enable1
);

`ifndef FPGA
INVD1BWP40P140 dft6 ( .I(test_mode), .ZN(test_mode_inv) );
INVD1BWP40P140 dft7 ( .I(scan_mode), .ZN(scan_mode_inv) );

AN2D1BWP40P140 usb_icg_ten_and   ( .A1(scan_mode),      .A2(test_mode_inv),  .Z(enable0)  );
AN2D1BWP40P140 vcore_icg_ten_and ( .A1(scan_mode_inv),  .A2(test_mode),      .Z(enable1)  );
`else
assign enable0 = 1'b0;
assign enable1 = 1'b0;
`endif

endmodule



module dft_bscan_tck_icg (
  input  scan_tap_compliance,
  input  clk,
  output clkg
); 

`ifndef FPGA
  CKLNQD4BWP35P140 d4_LNQ ( .CP(clk), .E(1'b0), .TE(scan_tap_compliance), .Q(clkg) );
`else 
  assign clkg = clk;
`endif

endmodule




module usb_tck_icg (
  input  scan_tap_compliance,
  input  clk,
  output clkg
); 

`ifndef FPGA
  CKLNQD4BWP35P140 d4_LNQ ( .CP(clk), .E(scan_tap_compliance), .TE(1'b0), .Q(clkg) );
`else 
  assign clkg = clk;
`endif

endmodule

module dft_mode_usb_pwrdown_ssp_ctrl (
  input  scan_mode,
  input  scan_tap_compliance,
  output dft_mode_usb_pwrdown_ssp
);

  wire scan_tap_compliance_inv; 
  
`ifndef FPGA
  INVD1BWP40P140 tap_comp_inv ( .I(scan_tap_compliance), .ZN(scan_tap_compliance_inv) );
  AN2D1BWP40P140 and_ssp_ctrl ( .A1(scan_tap_compliance_inv),     .A2(scan_mode),     .Z(dft_mode_usb_pwrdown_ssp)  );
`else
  assign dft_mode_usb_pwrdown_ssp = 0;
`endif


endmodule



module dft_mode_usb_pwrdown_hsp_ctrl (
  input  scan_mode,
  input  scan_tap_compliance,
  output dft_mode_usb_pwrdown_hsp
);

`ifndef FPGA
  AN2D1BWP40P140 and_hsp_ctrl ( .A1(scan_tap_compliance),     .A2(scan_mode),     .Z(dft_mode_usb_pwrdown_hsp)  );
`else
  assign dft_mode_usb_pwrdown_hsp = 0;
`endif


endmodule




module dft_scanmode_gated_g_se (
  input  scan_mode,
  input  scan_enable,
  output g_scan_enable
);

`ifndef FPGA
  AN2D1BWP40P140 and_g_se ( .A1(scan_mode),     .A2(scan_enable),     .Z(g_scan_enable)  );
`else
  assign g_scan_enable = 0;
`endif

endmodule


module dft_vcore_scan_f_en (
  input  scan_f_enable,
  input  test_mode,
  output g_vcore_se
);

`ifndef FPGA
  AN2D1BWP40P140 and_v_se ( .A1(test_mode),     .A2(scan_f_enable),     .Z(g_vcore_se)  );
`else
  assign g_vcore_se = 0;
`endif

endmodule

module dft_mode_enable (
  input  p2c_scan_mode,
  input  B3_dft_mbist_mode,
  output dft_mode
);

`ifndef FPGA
  OR2D1BWP40P140 OR0 (.A1(p2c_scan_mode), .A2(B3_dft_mbist_mode), .Z(dft_mode));
`else
  assign dft_mode = 0;
`endif

endmodule

module dft_mux #(parameter width=1) (
  input sel,
  input  [width-1:0] din0,
  input  [width-1:0] din1,
  output [width-1:0] dout
);

  assign dout = sel ? din1 : din0;

endmodule

// https://www.youtube.com/watch?v=MKCkCVXeV8Q
module decoder2to4_onehot(
    Data_in,
    Data_out
    );

    //what are the input ports and their sizes.
    input [1:0] Data_in;
    //what are the output ports and their sizes.
    output [2:0] Data_out;
    
    wire Data_in_inv_0;
    wire Data_in_inv_1;


`ifndef FPGA
INVD8BWP30P140 Data_in_0_inv_0 ( .I(Data_in[0]), .ZN(Data_in_inv_0) );
INVD8BWP30P140 Data_in_1_inv_1 ( .I(Data_in[1]), .ZN(Data_in_inv_1) );
     
//     case (Data_in)   //case statement. Check all the 8 combinations.
//         2'b01 : Data_out = 4'b0001;
//         2'b10 : Data_out = 4'b0010;
//         2'b11 : Data_out = 4'b0100;
//         //To make sure that latches are not created create a default value for output.
//         default : Data_out = 4'b0000; 
//     endcase

AN2D1BWP40P140 AND0 ( .A1(Data_in[0]),     .A2(Data_in[1]),     .Z(Data_out[2])  );
AN2D1BWP40P140 AND1 ( .A1(Data_in[0]),     .A2(Data_in_inv_1), .Z(Data_out[0])  );
AN2D1BWP40P140 AND2 ( .A1(Data_in_inv_0), .A2(Data_in[1]),     .Z(Data_out[1])  );
// Obselete  AN2D1BWP40P140 AND3 ( .A1(Data_in_inv_0), .A2(Data_in_inv_1), .Z(Data_out[3])  );

`else
  assign Data_in_inv_0 = Data_in[0];
  assign Data_in_inv_1 = Data_in[1];
  assign Data_out[2] = Data_in[0] & Data_in[1];
  assign Data_out[0] = Data_in[0] & Data_in_inv_1;
  assign Data_out[1] = Data_in_inv_0 & Data_in[1];
`endif

endmodule 

module icg_ddr_one_hot ( clkg, en, tst_en, clk );
  input en, tst_en, clk;
  output clkg;

`ifndef FPGA
  CKLNQD4BWP30P140 d4_LNQ ( .CP(clk), .E(en), .TE(tst_en), .Q(clkg) );
`else
  assign clkg = clk;
`endif
endmodule


module dft_clk_mux (din0, din1, sel, dout);
  input din0, din1, sel;
  output dout;
`ifndef FPGA
  CKMUX2D0BWP40P140 (.I0(din0), .I1(din1), .S(sel), .Z(dout));
`else
  assign dout = din0;
`endif
endmodule

module dft_ddr_atpg_one_hot (
    input  rstn, 
	input  clk, 
	input  scan_mode,  
	input  dft_ddr_DfiCtlClk, 
	input  dft_ddr_DfiClk, 
	input  dft_ddr_APBClk,  
	output DFT_ONE_HOT_DfiClk, 
	output DFT_ONE_HOT_DfiCtlClk, 
	output DFT_ONE_HOT_APBClk);

`ifndef FPGA
wire [1:0] ddr_clk_sel;
wire [2:0] ddr_clk_sel_out;
wire [2:0] ddr_clk_sel_inv; 
wire [2:0] ddr_clk_sel_icg;
wire [2:0] ddr_clk_sel_icg_inv;

reg [1:0] dft_ddr_capture_clk_select_reg_out;

decoder2to4_onehot decoder_ddr_clk_select(
    .Data_in(ddr_clk_sel),
    .Data_out(ddr_clk_sel_out)
    );

INVD8BWP30P140 scanmode_inv ( .I(scan_mode), .ZN(scan_mode_inv) );


OR2D2BWP30P140 ddr_clk_sel_icg_0 ( .A1(scan_mode_inv), .A2(ddr_clk_sel_out[0]), .Z(ddr_clk_sel_icg[0]) );
OR2D2BWP30P140 ddr_clk_sel_icg_1 ( .A1(scan_mode_inv), .A2(ddr_clk_sel_out[1]), .Z(ddr_clk_sel_icg[1]) );
OR2D2BWP30P140 ddr_clk_sel_icg_2 ( .A1(scan_mode_inv), .A2(ddr_clk_sel_out[2]), .Z(ddr_clk_sel_icg[2]) );



//For all 3 DDR clcoks: DfiClk, DfiCtlClk, APBClk
icg_ddr_one_hot one_hot_DfiClk    (.tst_en(scan_mode), .en(ddr_clk_sel_icg[0]), .clk(dft_ddr_DfiClk),    .clkg(DFT_ONE_HOT_DfiClk));
icg_ddr_one_hot one_hot_DfiCtlClk (.tst_en(scan_mode), .en(ddr_clk_sel_icg[1]), .clk(dft_ddr_DfiCtlClk), .clkg(DFT_ONE_HOT_DfiCtlClk));
icg_ddr_one_hot one_hot_APBClk    (.tst_en(scan_mode), .en(ddr_clk_sel_icg[2]), .clk(dft_ddr_APBClk),    .clkg(DFT_ONE_HOT_APBClk));


DFKCNQD1BWP40P140 ddr_one_hot_clk_sel_0 ( .CN(rstn), .D(1'b0),  .CP(clk), .Q(ddr_clk_sel[0]) );
DFKCNQD1BWP40P140 ddr_one_hot_clk_sel_1 ( .CN(rstn), .D(1'b0),  .CP(clk), .Q(ddr_clk_sel[1]) );

`else
  assign DFT_ONE_HOT_DfiClk = dft_ddr_DfiCtlClk;
  assign DFT_ONE_HOT_DfiCtlClk = dft_ddr_DfiClk;
  assign DFT_ONE_HOT_APBClk = dft_ddr_APBClk;
`endif 

endmodule
