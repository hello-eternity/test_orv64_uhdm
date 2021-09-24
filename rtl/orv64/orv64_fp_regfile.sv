// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_fp_regfile
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  // read RS1/RS2
  input   orv64_if2fprf_t   if2fprf,
  output  orv64_fprf2id_t   fprf2id,
  // write RD
  input   orv64_ma2rf_t     ma2rf,

 //input               da2fprf,
 //output              fprf2da,
 input               rst, clk
);

  // alias {{{
`ifndef SYNTHESIS
  orv64_data_t f00_ft0, f01_ft1, f02_ft2, f03_ft3, f04_ft4, f05_ft5, f06_ft6, f07_ft7, f08_fs0, f09_fs1, f10_fa0, f11_fa1, f12_fa2, f13_fa3, f14_fa4, f15_fa5, f16_fa6, f17_fa7, f18_fs2, f19_fs3, f20_fs4, f21_fs5, f22_fs6, f23_fs7, f24_fs8, f25_fs9, f26_fs10, f27_fs11, f28_ft8, f29_ft9, f30_ft10, f31_ft11;

  assign f00_ft0 = RF.regfile[0];
  assign f01_ft1 = RF.regfile[1];
  assign f02_ft2 = RF.regfile[2];
  assign f03_ft3 = RF.regfile[3];
  assign f04_ft4 = RF.regfile[4];
  assign f05_ft5 = RF.regfile[5];
  assign f06_ft6 = RF.regfile[6];
  assign f07_ft7 = RF.regfile[7];

  assign f08_fs0 = RF.regfile[8];
  assign f09_fs1 = RF.regfile[9];

  assign f10_fa0 = RF.regfile[10];
  assign f11_fa1 = RF.regfile[11];
  assign f12_fa2 = RF.regfile[12];
  assign f13_fa3 = RF.regfile[13];
  assign f14_fa4 = RF.regfile[14];
  assign f15_fa5 = RF.regfile[15];
  assign f16_fa6 = RF.regfile[16];
  assign f17_fa7 = RF.regfile[17];

  assign f18_fs2 = RF.regfile[18];
  assign f19_fs3 = RF.regfile[19];
  assign f20_fs4 = RF.regfile[20];
  assign f21_fs5 = RF.regfile[21];
  assign f22_fs6 = RF.regfile[22];
  assign f23_fs7 = RF.regfile[23];
  assign f24_fs8 = RF.regfile[24];
  assign f25_fs9 = RF.regfile[25];
  assign f26_fs10 = RF.regfile[26];
  assign f27_fs11 = RF.regfile[27];

  assign f28_ft8 = RF.regfile[28];
  assign f29_ft9 = RF.regfile[29];
  assign f30_ft10 = RF.regfile[30];
  assign f31_ft11 = RF.regfile[31];
`endif
  // }}}

  orv64_regfile #(.DEPTH(32), .DEPTH_LSB(0), .DEPTH_MSB(31), .N_READ_PORT(3), .N_WRITE_PORT(1)) RF(
    .re({if2fprf.rs3_re, if2fprf.rs2_re, if2fprf.rs1_re}),
    .ra({if2fprf.rs3_addr, if2fprf.rs2_addr, if2fprf.rs1_addr}),
    .rd({fprf2id.rs3, fprf2id.rs2, fprf2id.rs1}),
    .we(ma2rf.rd_we), .wa(ma2rf.rd_addr), .wd(ma2rf.rd),
    //.da2rf(da2fprf), rf2da(fprf2da),
    .*);

endmodule
