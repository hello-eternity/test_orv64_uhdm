// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_fp_cmp
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
#(parameter is_32 = 0)
(
  output  orv64_data_t        rd_cmp,
  output  orv64_fflags_t      fflags,
  //input   orv64_data_t        rs1, rs2_inv, rd_add,
  input   orv64_data_t        rs1, rs2, rd_add,
  //input   orv64_fstatus_dw_t  fstatus_dw,
  input    orv64_fp_cmp_sel_t  fp_cmp_sel
  //input   logic         is_32
);

  localparam CANON_NAN = is_32 ? ORV64_CONST_FP_S_CANON_NAN: ORV64_CONST_FP_D_CANON_NAN;

  //! Declaration
  logic is_eq, temp_is_eq;
  logic is_altb, temp_is_altb;
  logic is_agtb, temp_is_agtb;
  logic is_unordered;
  orv64_data_t temp_max_ab, max_ab;
  orv64_data_t temp_min_ab, min_ab;
  orv64_fstatus_dw_t  fstatus_dw_0;
  orv64_fstatus_dw_t  fstatus_dw_1;
  orv64_fstatus_dw_t  fstatus_dw;
  orv64_fflags_t      fflags_tmp;
  logic is_rs1_nan, is_rs2_nan;
  logic is_rs1_snan, is_rs2_snan;
  logic is_rs1_zero, is_rs2_zero;
  logic is_rs1_neg, is_rs2_neg;
  logic is_rs1_boxed, is_rs2_boxed;

  assign is_rs1_nan = func_fp_is_nan(.in(rs1), .is_32(is_32));
  assign is_rs2_nan = func_fp_is_nan(.in(rs2), .is_32(is_32));
  assign is_rs1_snan = func_fp_is_snan(.in(rs1), .is_32(is_32));
  assign is_rs2_snan = func_fp_is_snan(.in(rs2), .is_32(is_32));

  assign is_rs1_zero = func_fp_is_zero(.in(rs1), .is_32(is_32));
  assign is_rs2_zero = func_fp_is_zero(.in(rs2), .is_32(is_32));
  assign is_rs1_neg = func_fp_is_neg(.in(rs1), .is_32(is_32));
  assign is_rs2_neg = func_fp_is_neg(.in(rs2), .is_32(is_32));

  assign fstatus_dw[7] = 1'b0; // unused for func_fp_fflags
  assign fstatus_dw[6:3] = (fstatus_dw_0[7] ? fstatus_dw_0[6:3] : fstatus_dw_1[6:3]); 
  assign fstatus_dw[2] = (fstatus_dw_0[7] ? fstatus_dw_0[2]  : fstatus_dw_1[7] ? fstatus_dw_1[2] : is_unordered) | is_rs2_snan | is_rs1_snan | (((fp_cmp_sel == ORV64_FP_CMP_SEL_LT) | (fp_cmp_sel == ORV64_FP_CMP_SEL_LE)) & (is_rs1_nan | is_rs2_nan));
  assign fstatus_dw[1:0] = (fstatus_dw_0[7] ? fstatus_dw_0[1:0] : fstatus_dw_1[1:0]); 
  assign fflags_tmp = func_fp_fflags(fstatus_dw); 

  always_comb begin
    case (fp_cmp_sel)
      ORV64_FP_CMP_SEL_LT, ORV64_FP_CMP_SEL_LE: begin
        fflags = fflags_tmp;
      end
      default: begin
        if (is_rs1_snan | is_rs2_snan) begin
          fflags = fflags_tmp;
        end else begin
          fflags.nv = 1'b0;
          fflags.dz = fflags_tmp.dz;
          fflags.of = fflags_tmp.of;
          fflags.uf = fflags_tmp.uf;
          fflags.nx = fflags_tmp.nx;
        end
      end
    endcase
  end

  generate 
  if (is_32) begin
    localparam fp_cmp_exp_width = 8;
    localparam fp_cmp_sig_width = 23;

  `ifndef FPGA
    DW_fp_cmp #(.sig_width(fp_cmp_sig_width),.exp_width(fp_cmp_exp_width),.ieee_compliance(1)) DW_FP_CMP_S (
  `else
    DW_fp_cmp_23_8_1  DW_FP_CMP_S (
  `endif
    .a(rs1[31:0]),
    .b(rs2[31:0]),
    .zctr(1'b0),
    .aeqb(temp_is_eq),
    .altb(temp_is_altb),
    .agtb(temp_is_agtb),
    .unordered(is_unordered),
    .z0(temp_min_ab[31:0]),
    .z1(temp_max_ab[31:0]),
    .status0(fstatus_dw_0),
    .status1(fstatus_dw_1));

    assign temp_min_ab[63:32] = {32{temp_min_ab[31]}};
    assign temp_max_ab[63:32] = {32{temp_max_ab[31]}};

  end else begin
    localparam fp_cmp_exp_width = 11;
    localparam fp_cmp_sig_width = 52;
  `ifndef FPGA
    DW_fp_cmp #(.sig_width(fp_cmp_sig_width),.exp_width(fp_cmp_exp_width),.ieee_compliance(1)) DW_FP_CMP_D (
  `else
    DW_fp_cmp_52_11_1  DW_FP_CMP_D (
  `endif
    .a(rs1),
    .b(rs2),
    .zctr(1'b0),
    .aeqb(temp_is_eq),
    .altb(temp_is_altb),
    .agtb(temp_is_agtb),
    .unordered(is_unordered),
    .z0(temp_min_ab),
    .z1(temp_max_ab),
    .status0(fstatus_dw_0),
    .status1(fstatus_dw_1));
  end
  endgenerate 

  always_comb begin
    if (is_rs1_nan | is_rs2_nan) begin
      if (is_rs1_nan & is_rs2_nan) begin
        min_ab = CANON_NAN;
        max_ab = CANON_NAN;
      end else if (is_rs2_nan) begin
        min_ab = rs1;
        max_ab = rs1;
      end else begin
        min_ab = rs2;
        max_ab = rs2;
      end
    end else if (is_rs1_zero & is_rs2_zero) begin
      min_ab = is_rs1_neg ? rs1: rs2;
      max_ab = is_rs1_neg ? rs2: rs1;
    end else begin
      min_ab = temp_min_ab;
      max_ab = temp_max_ab;
    end
  end

`ifdef ORV64_SUPPORT_FP_DOUBLE
  generate
    if (is_32) begin
      assign is_rs1_boxed = (&rs1[63:32]);
      assign is_rs2_boxed = (&rs2[63:32]);
    end else begin
      assign is_rs1_boxed = '1;
      assign is_rs2_boxed = '1;
    end
  endgenerate
`else 
  assign is_rs1_boxed = '1;
  assign is_rs2_boxed = '1;
`endif

  assign is_eq = temp_is_eq & ~(is_rs1_nan | is_rs2_nan) & is_rs1_boxed & is_rs2_boxed;
  assign is_altb = temp_is_altb & ~(is_rs1_nan | is_rs2_nan) & is_rs1_boxed & is_rs2_boxed;
  assign is_agtb = temp_is_agtb & ~(is_rs1_nan | is_rs2_nan) & is_rs1_boxed & is_rs2_boxed;

  always_comb begin
    unique case(fp_cmp_sel)
      ORV64_FP_CMP_SEL_MIN: rd_cmp = min_ab;
      ORV64_FP_CMP_SEL_EQ:  rd_cmp = is_eq;
      ORV64_FP_CMP_SEL_LT:  rd_cmp = is_altb;
      ORV64_FP_CMP_SEL_LE:  rd_cmp = (is_altb | is_eq);
      default: rd_cmp = max_ab;
    endcase
  end
  /*
  import orv64_param_pkg::*;

  orv64_data_t  rs2;
  assign  rs2 = is_32 ? {rs2_inv[63:32], ~rs2_inv[31], rs2_inv[30:0]} : {~rs2_inv[63], rs2_inv[62:0]};

  logic   is_neg, is_zero,
          is_rs1_nan, is_rs2_nan, is_nan,
          is_snan, is_rs1_snan, is_rs2_snan;
  assign  is_neg = is_32 ? rd_add[31] : rd_add[63];
  assign  is_zero = is_32 ? (rd_add[30:0] == 31'b0) : (rd_add[62:0] == 63'b0);
  assign  is_rs1_nan = func_fp_is_nan(.in(rs1), .is_32(is_32));
  assign  is_rs2_nan = func_fp_is_nan(.in(rs2), .is_32(is_32));
  assign  is_nan = is_rs1_nan | is_rs2_nan;
  assign  is_rs1_snan = func_fp_is_snan(.in(rs1), .is_32(is_32));
  assign  is_rs2_snan = func_fp_is_snan(.in(rs2), .is_32(is_32));
  assign  is_snan = is_rs1_snan | is_rs2_snan;

  orv64_data_t  rd_max, rd_min, ird_eq, ird_lt, ird_le;
  always_comb begin
    if (is_rs1_nan) begin
      rd_max = rs2;
      rd_min = rs2;
    end else if (is_rs2_nan) begin
      rd_max = rs1;
      rd_min = rs1;
    end else begin
      rd_max = is_neg ? rs2 : rs1;
      rd_min = is_neg ? rs1 : rs2;
    end
  end
  assign  ird_eq = is_zero ? 64'h01 : 64'h00;
  assign  ird_lt = (is_neg & ~is_zero) ? 64'h01 : 64'h00;
  assign  ird_le = (is_neg | is_zero) ? 64'h01 : 64'h00;

  orv64_data_t  rd_cmp_raw;
  logic   is_rd_nan;
  always_comb
    case (fp_cmp_sel)
      ORV64_FP_CMP_SEL_MIN: rd_cmp_raw = rd_min;
      ORV64_FP_CMP_SEL_EQ:  rd_cmp_raw = ird_eq;
      ORV64_FP_CMP_SEL_LT:  rd_cmp_raw = ird_lt;
      ORV64_FP_CMP_SEL_LE:  rd_cmp_raw = ird_le;
      default: rd_cmp_raw = rd_max;
    endcase
  assign  is_rd_nan = func_fp_is_nan(.in(rd_cmp_raw), .is_32(is_32));
  assign  rd_cmp = is_rd_nan ? (is_32 ? {{32{1'b1}}, ORV64_CONST_FP_S_CANON_NAN} : ORV64_CONST_FP_D_CANON_NAN) : rd_cmp_raw;

  always_comb begin
    fflags = func_fp_fflags(fstatus_dw);
    fflags.nx = 1'b0;
    case (fp_cmp_sel)
      ORV64_FP_CMP_SEL_EQ:
        if (~is_snan)
          fflags.nv = 1'b0;
      ORV64_FP_CMP_SEL_MIN, ORV64_FP_CMP_SEL_MAX:
        // only signal NaN cause NV
        if (is_snan)
          fflags.nv = 1'b1;
        else
          fflags.nv = 1'b0;
    endcase
  end
*/
endmodule
