// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_fp_div_single
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  output  orv64_data_t        rd,
  output  orv64_fstatus_dw_t  fstatus_dw,
  output  logic         is_div_0,
  output  logic         complete,
  input   orv64_data_t        rs1, rs2,
  input   orv64_frm_dw_t      frm_dw,
  input   logic         start_pulse,
                        rst, clk
);
  localparam sig_width = 23;
  localparam exp_width = 8;
  localparam ieee_compliance = 1;
  localparam num_cyc = ORV64_N_CYCLE_FP_DIV_S;
  localparam rst_mode = 1;
  localparam input_mode = 0;
  localparam output_mode = 0;
  localparam early_start = 0;
  localparam internal_reg = 1; // add internal_reg pipeline to save power
  localparam faithful_round = 0;

  orv64_data_t z;

  //Instance of DW_fp_div
  `ifndef FPGA
  DW_fp_div #(sig_width, exp_width, ieee_compliance) DW_FP_DIV (
    .a(rs1[31:0]), .b(rs2[31:0]), .rnd(frm_dw), .z(z[31:0]), .status(fstatus_dw)
  `else
  DW_fp_div_23_8_1_0  DW_FP_DIV (
    .a(rs1[31:0]), .b(rs2[31:0]), .rnd(frm_dw), .z(z[31:0]), .status(fstatus_dw)
  `endif
  );
  assign  z[63:32] = '0;

  logic   is_nan;
  assign  is_nan = func_fp_is_nan(.in(z), .is_32(1'b1));
  assign  rd[31: 0] = is_nan ? ORV64_CONST_FP_S_CANON_NAN : z[31:0];
  assign  rd[63:32] = {32{1'b1}};
  assign  is_div_0 = (rs2[30:0] == 'b0);
endmodule

module orv64_fp_div_double
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  output  orv64_data_t        rd,
  output  orv64_fstatus_dw_t  fstatus_dw,
  output  logic         is_div_0,
  output  logic         complete,
  input   orv64_data_t        rs1, rs2,
  input   orv64_frm_dw_t      frm_dw,
  input   logic         start_pulse,
                        rst, clk
);
  localparam sig_width = 52;
  localparam exp_width = 11;
  localparam ieee_compliance = 1;
  localparam num_cyc = ORV64_N_CYCLE_FP_DIV_D;
  localparam rst_mode = 1;
  localparam input_mode = 0;
  localparam output_mode = 0;
  localparam early_start = 0;
  localparam internal_reg = 1; // add internal_reg pipeline to save power
  localparam faithful_round = 0;

  orv64_data_t  z;

//   // Instance of DW_fp_div_seq
//   DW_fp_div_seq #(sig_width, exp_width, ieee_compliance, num_cyc, rst_mode, input_mode, output_mode, early_start, internal_reg) DW_FP_DIV_SEQ(
//     .z(z), .status(fstatus_dw), .complete(complete),
//     .a(rs1), .b(rs2), .rnd(frm_dw),
//     .start(start_pulse), .clk(clk), .rst_n(~rst)
//   );

  //Instance of DW_fp_div
  `ifndef FPGA
  DW_fp_div #(sig_width, exp_width, ieee_compliance) DW_FP_DIV (
    .a(rs1), .b(rs2), .rnd(frm_dw), .z(z), .status(fstatus_dw)
  `else
  DW_fp_div_52_11_1_0  DW_FP_DIV (
    .a(rs1), .b(rs2), .rnd(frm_dw), .z(z), .status(fstatus_dw)
  `endif
  );

  logic   is_nan;
  assign  is_nan = func_fp_is_nan(.in(z), .is_32(1'b0));
  assign  rd = is_nan ? ORV64_CONST_FP_D_CANON_NAN : z;
  assign  is_div_0 = (rs2[62:0] == 'b0);
endmodule
