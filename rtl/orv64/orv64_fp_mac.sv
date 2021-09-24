// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_fp_mac_single
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  output  orv64_data_t        rd,
  output  orv64_fstatus_dw_t  fstatus_dw,
  input   orv64_data_t        rs1, rs2, rs3,
  input   orv64_frm_dw_t      frm_dw,
  input   logic               is_mul
);
  localparam sig_width = 23;
  localparam exp_width = 8;
  localparam ieee_compliance = 1;
  // Instance of DW_fp_mac
  orv64_data_t z;
  `ifndef FPGA
  DW_fp_mac #(sig_width, exp_width, ieee_compliance) DW_FP_MAC(
    .a(rs1[31:0]), .b(rs2[31:0]), .c(rs3[31:0]), .rnd(frm_dw), .z(z[31:0]), .status(fstatus_dw)
  `else
  DW_fp_mac_23_8_1  DW_FP_MAC(
    .a(rs1[31:0]), .b(rs2[31:0]), .c(rs3[31:0]), .rnd(frm_dw), .z(z[31:0]), .status(fstatus_dw)
  `endif
  );
  assign  z[63:32] = '0;

  logic   is_nan;
  assign  is_nan = func_fp_is_nan(.in(z), .is_32(1'b1));
  assign  rd[31: 0] = is_nan ? ORV64_CONST_FP_S_CANON_NAN : ((fstatus_dw.zero & is_mul) ? ((rs1[31] ^ rs2[31]) ? {1'b1, 31'h0}: 32'h0): z[31:0]);
  assign  rd[63:32] = {32{1'b1}};
endmodule

module orv64_fp_mac_double
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  output  orv64_data_t        rd,
  output  orv64_fstatus_dw_t  fstatus_dw,
  input   orv64_data_t        rs1, rs2, rs3,
  input   orv64_frm_dw_t      frm_dw,
  input   logic               is_mul
);
  localparam sig_width = 52;
  localparam exp_width = 11;
  localparam ieee_compliance = 1;
  // Instance of DW_fp_mac
  orv64_data_t z;
  `ifndef FPGA
  DW_fp_mac #(sig_width, exp_width, ieee_compliance) DW_FP_MAC(
    .a(rs1), .b(rs2), .c(rs3), .rnd(frm_dw), .z(z), .status(fstatus_dw)
  `else
  DW_fp_mac_52_11_1  DW_FP_MAC(
    .a(rs1), .b(rs2), .c(rs3), .rnd(frm_dw), .z(z), .status(fstatus_dw)
  `endif
  );

  logic   is_nan;
  assign  is_nan = func_fp_is_nan(.in(z), .is_32(1'b0));
  assign  rd = is_nan ? ORV64_CONST_FP_D_CANON_NAN : ((fstatus_dw.zero & is_mul) ? ((rs1[63] ^ rs2[63]) ? {1'b1, 63'h0}: 64'h0): z);
endmodule
