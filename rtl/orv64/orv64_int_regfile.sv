// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_int_regfile
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  // read RS1/RS2
  input   orv64_if2irf_t    if2irf,
  output  orv64_irf2id_t    irf2id,
  // write RD
  input   orv64_ma2rf_t     ma2rf,

  //input               da2irf,
  //output              irf2da,

  input               rst, clk
);

  // alias {{{
`ifndef SYNTHESIS
  orv64_data_t  x01_ra, x02_sp, x03_gp, x04_tp, x05_t0, x06_t1, x07_t2, x08_s0, x08_fp, x09_s1, x10_a0, x11_a1, x12_a2, x13_a3, x14_a4, x15_a5, x16_a6, x17_a7, x18_s2, x19_s3, x20_s4, x21_s5, x22_s6, x23_s7, x24_s8, x25_s9, x26_s10, x27_s11, x28_t3, x29_t4, x30_t5, x31_t6;
  assign x01_ra = RF.regfile[1];
  assign x02_sp = RF.regfile[2];
  assign x03_gp = RF.regfile[3];
  assign x04_tp = RF.regfile[4];
  assign x05_t0 = RF.regfile[5];
  assign x06_t1 = RF.regfile[6];
  assign x07_t2 = RF.regfile[7];
  assign x08_s0 = RF.regfile[8];
  assign x08_fp = RF.regfile[8];
  assign x09_s1 = RF.regfile[9];
  assign x10_a0 = RF.regfile[10];
  assign x11_a1 = RF.regfile[11];
  assign x12_a2 = RF.regfile[12];
  assign x13_a3 = RF.regfile[13];
  assign x14_a4 = RF.regfile[14];
  assign x15_a5 = RF.regfile[15];
  assign x16_a6 = RF.regfile[16];
  assign x17_a7 = RF.regfile[17];
  assign x18_s2 = RF.regfile[18];
  assign x19_s3 = RF.regfile[19];
  assign x20_s4 = RF.regfile[20];
  assign x21_s5 = RF.regfile[21];
  assign x22_s6 = RF.regfile[22];
  assign x23_s7 = RF.regfile[23];
  assign x24_s8 = RF.regfile[24];
  assign x25_s9 = RF.regfile[25];
  assign x26_s10 = RF.regfile[26];
  assign x27_s11 = RF.regfile[27];
  assign x28_t3 = RF.regfile[28];
  assign x29_t4 = RF.regfile[29];
  assign x30_t5 = RF.regfile[30];
  assign x31_t6 = RF.regfile[31];
`endif
  // }}}

  logic do_ma_write;

  assign do_ma_write = ma2rf.rd_we & ~(ma2rf.rd_addr == '0);


  orv64_regfile #(.WIDTH(ORV64_XLEN), .DEPTH(31), .DEPTH_LSB(1), .DEPTH_MSB(31), .N_READ_PORT(2), .N_WRITE_PORT(1)) RF(
    .re({if2irf.rs2_re, if2irf.rs1_re}), .ra({if2irf.rs2_addr, if2irf.rs1_addr}), .rd({irf2id.rs2, irf2id.rs1}),
    .we(do_ma_write), .wa(ma2rf.rd_addr), .wd(ma2rf.rd),
    //.da2rf(da2irf), rf2da(irf2da),
    .*);


endmodule
