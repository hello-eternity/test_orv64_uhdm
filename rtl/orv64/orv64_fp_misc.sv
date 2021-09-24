module orv64_fp_misc
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  input   logic               clk, rstn,
  output  orv64_data_t        rd_sgnj,
                              rd_cls,
                              rd_i2s, rd_i2d,
                              rd_s2i, rd_d2i,
                              rd_s2d, rd_d2s,
  output  orv64_fstatus_dw_t  fstatus_dw_i2s, fstatus_dw_i2d,
                              fstatus_dw_s2i, fstatus_dw_d2i,
                              fstatus_dw_s2d, fstatus_dw_d2s,
  output  orv64_fflags_t      fflags_s2i, fflags_d2i,
  input   orv64_data_t        rs1, rs2,
  input   logic               is_32,
  input   orv64_frm_dw_t      frm_dw,
  input   orv64_fp_sgnj_sel_t fp_sgnj_sel,
  input   orv64_fp_cvt_sel_t  fp_cvt_sel
);

  import orv64_param_pkg::*;

  //==========================================================
  // SGNJ {{{
  logic   sign_rs1, sign_rs2, sign_rd,d2s_nan;
  assign  sign_rs1 = is_32 ? rs1[31] : rs1[63];
  assign  sign_rs2 = is_32 ? rs2[31] : rs2[63];

  //! Check for NaN64 regardless of single or double
  always_comb begin : SIGN_EXTRACTION
    sign_rd = 1'b0;
      case (fp_sgnj_sel)
        ORV64_FP_SGNJ_SEL_JN: sign_rd = ~sign_rs2;
        ORV64_FP_SGNJ_SEL_JX: sign_rd = sign_rs1 ^ sign_rs2;
        default:        sign_rd = sign_rs2;
      endcase
  end

  always_comb begin : DATA_EXTRACTION
    rd_sgnj = {$bits(orv64_data_t){1'b0}};
    unique if(is_32 == 1'b1) begin
      rd_sgnj = {{32{1'b1}},sign_rd,rs1[30:0]};
    end else begin
      rd_sgnj = {sign_rd,rs1[62:0]};
    end
  end
  // }}}

  //==========================================================
  // CLS {{{
  orv64_fp_cls_t      rs1_cls;
  logic         rs1_sign_s, rs1_sign_d;
  logic [ 7:0]  rs1_exp_s;
  logic [10:0]  rs1_exp_d;
  logic [22:0]  rs1_sig_s;
  logic [51:0]  rs1_sig_d;

  assign  rs1_sign_s = rs1[31];
  assign  rs1_sign_d = rs1[63];
  assign  rs1_exp_s  = rs1[30:23];
  assign  rs1_exp_d  = rs1[62:52];
  assign  rs1_sig_s  = rs1[22:0];
  assign  rs1_sig_d  = rs1[51:0];

  assign  rs1_cls.neg_inf = func_fp_is_neg_inf(.in(rs1), .is_32(is_32));
  assign  rs1_cls.pos_inf = func_fp_is_pos_inf(.in(rs1), .is_32(is_32));
  assign  rs1_cls.neg_zero = func_fp_is_neg_zero(.in(rs1), .is_32(is_32));
  assign  rs1_cls.pos_zero = func_fp_is_pos_zero(.in(rs1), .is_32(is_32));
  assign  rs1_cls.neg_sub = func_fp_is_neg_sub(.in(rs1), .is_32(is_32));
  assign  rs1_cls.pos_sub = func_fp_is_pos_sub(.in(rs1), .is_32(is_32));
  assign  rs1_cls.q_nan = func_fp_is_qnan(.in(rs1), .is_32(is_32));
  assign  rs1_cls.s_nan = func_fp_is_snan(.in(rs1), .is_32(is_32));
  assign  rs1_cls.pos = (is_32 ? ~rs1_sign_s : ~rs1_sign_d) & ~(rs1_cls.neg_inf | rs1_cls.pos_inf | rs1_cls.neg_zero | rs1_cls.pos_zero | rs1_cls.neg_sub | rs1_cls.pos_sub | rs1_cls.q_nan | rs1_cls.s_nan);
  assign  rs1_cls.neg = (is_32 ? rs1_sign_s : rs1_sign_d) & ~(rs1_cls.neg_inf | rs1_cls.pos_inf | rs1_cls.neg_zero | rs1_cls.pos_zero | rs1_cls.neg_sub | rs1_cls.pos_sub | rs1_cls.q_nan | rs1_cls.s_nan);

  assign  rd_cls = {54'b0, rs1_cls};
  // }}}

  //==========================================================
  // CVT: integer -> single/double {{{
  logic [64:0]  rs_i2sd;

  always_comb
    case (fp_cvt_sel)
      ORV64_FP_CVT_SEL_W:   rs_i2sd = {{33{rs1[31]}}, rs1[31:0]};
      ORV64_FP_CVT_SEL_WU:  rs_i2sd = {33'b0, rs1[31:0]};
      ORV64_FP_CVT_SEL_L:   rs_i2sd = {rs1[63], rs1};
      default:        rs_i2sd = {1'b0, rs1}; // ORV64_FP_CVT_SEL_L
    endcase

  // 65-bit signed integer -> single precision floating-point
  localparam i2s_sig_width = 23;
  localparam i2s_exp_width = 8;
  localparam i2s_isize = 65;
  localparam i2s_isign = 1;

  `ifndef FPGA
  DW_fp_i2flt #(i2s_sig_width, i2s_exp_width, i2s_isize, i2s_isign) DW_FP_I2S(
    .a(rs_i2sd), .rnd(frm_dw), .z(rd_i2s[31:0]), .status(fstatus_dw_i2s));
  `else
  DW_fp_i2flt_23_8_65_1  DW_FP_I2S(
    .a(rs_i2sd), .rnd(frm_dw), .z(rd_i2s[31:0]), .status(fstatus_dw_i2s));
  //XIL_fp_i2f_single f_i2f_u (
  //  .aclk(clk),
  //  .aclken(1'b1),
  //  .aresetn(rstn),
  //  .s_axis_a_tvalid(1'b1),
  //  .s_axis_a_tdata(rs_i2sd),
  //  .m_axis_result_tvalid(),
  //  .m_axis_result_tdata(rd_i2s[31:0])
  //  );
  //assign fstatus_dw_i2s = '0;
  `endif
  assign rd_i2s[63:32] = {32{1'b1}};

  `ifdef ORV64_SUPPORT_FP_DOUBLE
  // 65-bit signed integer -> double precision floating-point
  localparam i2d_sig_width = 52;
  localparam i2d_exp_width = 11;
  localparam i2d_isize = 65;
  localparam i2d_isign = 1;

  `ifndef FPGA
  DW_fp_i2flt #(i2d_sig_width, i2d_exp_width, i2d_isize, i2d_isign) DW_FP_I2D(
    .a(rs_i2sd), .rnd(frm_dw), .z(rd_i2d), .status(fstatus_dw_i2d));
  `else
  DW_fp_i2flt_52_11_65_1  DW_FP_I2D(
    .a(rs_i2sd), .rnd(frm_dw), .z(rd_i2d), .status(fstatus_dw_i2d));
  //XIL_fp_i2f_double d_i2f_u (
  //  .aclk(clk),
  //  .aclken(1'b1),
  //  .aresetn(rstn),
  //  .s_axis_a_tvalid(1'b1),
  //  .s_axis_a_tdata(rs_i2sd),
  //  .m_axis_result_tvalid(),
  //  .m_axis_result_tdata(rd_i2d)
  //  );
  //assign fstatus_dw_i2d = '0;
  `endif
  `endif
  // }}}

  //==========================================================
  // CVT: single/double to integer {{{

  // single precision floating-point -> 65-bit signed integer
  logic [64:0]  rd_65bit_s2i;
  orv64_fp2i_ovl_t    s2i_ovl;
  localparam s2i_sig_width = 23;
  localparam s2i_exp_width = 8;
  localparam s2i_isize = 65;
  localparam s2i_ieee_compliance = 1;

  `ifndef FPGA
  DW_fp_flt2i #(s2i_sig_width, s2i_exp_width, s2i_isize, s2i_ieee_compliance) DW_FP_S2I(
    .a(rs1[31:0]), .rnd(frm_dw), .z(rd_65bit_s2i), .status(fstatus_dw_s2i));
  `else
  DW_fp_flt2i_23_8_65_1  DW_FP_S2I(
    .a(rs1[31:0]), .rnd(frm_dw), .z(rd_65bit_s2i), .status(fstatus_dw_s2i));
  //XIL_fp_f2i_single f_f2i_u (
  //  .aclk(clk),
  //  .aclken(1'b1),
  //  .aresetn(rstn),
  //  .s_axis_a_tvalid(1'b1),
  //  .s_axis_a_tdata(rs1[31:0]),
  //  .m_axis_result_tvalid(),
  //  .m_axis_result_tdata(rd_65bit_s2i[63:0]),
  //  .m_axis_result_tuser({fstatus_dw_s2i.invalid, fstatus_dw_s2i.hugeint})
  //  );
  //assign rd_65bit_s2i[64] = rd_65bit_s2i[63];
  //assign fstatus_dw_s2i.compspecific = '0;
  //assign fstatus_dw_s2i.inexact = '0;
  //assign fstatus_dw_s2i.huge = '0;
  //assign fstatus_dw_s2i.tiny = '0;
  //assign fstatus_dw_s2i.infinity = '0;
  //assign fstatus_dw_s2i.zero = '0;
  `endif

  assign  s2i_ovl.ovl_32   = fstatus_dw_s2i.hugeint | ((rd_65bit_s2i[64:31] != 34'b0) & (rd_65bit_s2i[64:31] != {34{1'b1}}));
  assign  s2i_ovl.ovl_64   = fstatus_dw_s2i.hugeint | ((rd_65bit_s2i[64:63] != 2'b0) & (rd_65bit_s2i[64:63] != 2'b11));
  assign  s2i_ovl.ovl_32u  = fstatus_dw_s2i.hugeint | (rd_65bit_s2i[64:32] != 33'b0);
  assign  s2i_ovl.ovl_64u  = fstatus_dw_s2i.hugeint | (rd_65bit_s2i[64] != 1'b0);

  always_comb begin
    fflags_s2i = func_fp_fflags(fstatus_dw_s2i);
    fflags_s2i.nv = 1'b1; // reset to 0 if not special cases
    case (fp_cvt_sel)
      ORV64_FP_CVT_SEL_W: begin
        case (1'b1)
          rs1_cls.neg_inf:
            rd_s2i = 64'hffffffff80000000;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_s2i = 64'h000000007fffffff;
          default: begin
            if (s2i_ovl.ovl_32 & ~fstatus_dw_s2i.invalid) begin
              rd_s2i = rs1[31] ? 64'hffffffff80000000: 64'h000000007fffffff;
            end else begin
              rd_s2i = {{32{rd_65bit_s2i[31]}}, rd_65bit_s2i[31:0]};
              fflags_s2i.nv = 1'b0;
            end
          end
        endcase
      end
      ORV64_FP_CVT_SEL_WU: begin
        case (1'b1)
          rs1_cls.neg_inf:
            rd_s2i = 64'h0;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_s2i = 64'hffffffffffffffff;
          default: begin
            if (s2i_ovl.ovl_32u & ~fstatus_dw_s2i.invalid) begin
              rd_s2i = rs1[31] ? 64'h0: 64'hffffffffffffffff;
            end else begin
              rd_s2i = {{32{rd_65bit_s2i[31]}}, rd_65bit_s2i[31:0]}; // according to SPIKE, they do sign-extension altought it's unsigned number
              fflags_s2i.nv = 1'b0;
            end
          end
        endcase
      end
      ORV64_FP_CVT_SEL_L: begin
        unique case (1'b1)
          rs1_cls.neg_inf:
            rd_s2i = 64'h8000000000000000;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_s2i = 64'h7fffffffffffffff;
          default: begin
            if (s2i_ovl.ovl_64 & ~fstatus_dw_s2i.invalid) begin
              rd_s2i = rs1[31] ? 64'h8000000000000000: 64'h7fffffffffffffff;
            end else begin
              rd_s2i = rd_65bit_s2i[63:0];
              fflags_s2i.nv = 1'b0;
            end
          end
        endcase
      end
      ORV64_FP_CVT_SEL_LU: begin
        unique case (1'b1)
          rs1_cls.neg_inf:
            rd_s2i = 64'h0;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_s2i = 64'hffffffffffffffff;
          default: begin
            if (s2i_ovl.ovl_64u & ~fstatus_dw_s2i.invalid) begin
              rd_s2i = rs1[31] ? 64'h0: 64'hffffffffffffffff;
            end else begin
              rd_s2i = rd_65bit_s2i[63:0];
              fflags_s2i.nv = 1'b0;
            end
          end
        endcase
      end
      default: begin
        rd_s2i = rd_65bit_s2i[63:0];
        fflags_s2i.nv = 1'b0;
      end
    endcase
  end

  `ifdef ORV64_SUPPORT_FP_DOUBLE
  // double precision floating-point -> 65-bit signed integer
  logic [64:0]  rd_65bit_d2i;
  orv64_fp2i_ovl_t    d2i_ovl;
  localparam d2i_sig_width = 52;
  localparam d2i_exp_width = 11;
  localparam d2i_isize = 65;
  localparam d2i_ieee_compliance = 1;

    `ifndef FPGA
  DW_fp_flt2i #(d2i_sig_width, d2i_exp_width, d2i_isize, d2i_ieee_compliance) DW_FP_D2I(
    .a(rs1), .rnd(frm_dw), .z(rd_65bit_d2i), .status(fstatus_dw_d2i));
    `else
  DW_fp_flt2i_52_11_65_1  DW_FP_D2I(
    .a(rs1), .rnd(frm_dw), .z(rd_65bit_d2i), .status(fstatus_dw_d2i));
  //  XIL_fp_f2i_double d_f2i_u(
  //  .aclk(clk),
  //  .aclken(1'b1),
  //  .aresetn(rstn),
  //  .s_axis_a_tvalid(1'b1),
  //  .s_axis_a_tdata(rs1),
  //  .m_axis_result_tvalid(),
  //  .m_axis_result_tdata(rd_65bit_d2i[63:0]),
  //  .m_axis_result_tuser({fstatus_dw_d2i.invalid, fstatus_dw_d2i.hugeint})
  //  );
  //assign rd_65bit_d2i[64] = rd_65bit_d2i[63];
  //assign fstatus_dw_d2i.compspecific = '0;
  //assign fstatus_dw_d2i.inexact = '0;
  //assign fstatus_dw_d2i.huge = '0;
  //assign fstatus_dw_d2i.tiny = '0;
  //assign fstatus_dw_d2i.infinity = '0;
  //assign fstatus_dw_d2i.zero = '0;
    `endif

  assign  d2i_ovl.ovl_32   = fstatus_dw_d2i.hugeint | ((rd_65bit_d2i[64:31] != 34'b0) & (rd_65bit_d2i[64:31] != {34{1'b1}}));
  assign  d2i_ovl.ovl_64   = fstatus_dw_d2i.hugeint | ((rd_65bit_d2i[64:63] != 2'b0) & (rd_65bit_d2i[64:63] != 2'b11));
  assign  d2i_ovl.ovl_32u  = fstatus_dw_d2i.hugeint | (rd_65bit_d2i[64:32] != 33'b0);
  assign  d2i_ovl.ovl_64u  = fstatus_dw_d2i.hugeint | (rd_65bit_d2i[64] != 1'b0);

  always_comb begin
    fflags_d2i = func_fp_fflags(fstatus_dw_d2i);
    fflags_d2i.nv = 1'b1; // reset to 0 if not special cases
    case (fp_cvt_sel)
      ORV64_FP_CVT_SEL_W: begin
        unique case (1'b1)
          rs1_cls.neg_inf:
            rd_d2i = 64'hffffffff80000000;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_d2i = 64'h000000007fffffff;
          default: begin
            if (d2i_ovl.ovl_32 & ~fstatus_dw_d2i.invalid) begin
              rd_d2i = rs1[63] ? 64'hffffffff80000000: 64'h000000007fffffff;
            end else begin
              rd_d2i = {{32{rd_65bit_d2i[31]}}, rd_65bit_d2i[31:0]};
              fflags_d2i.nv = 1'b0;
            end
          end
        endcase
      end
      ORV64_FP_CVT_SEL_WU: begin
        unique case (1'b1)
          rs1_cls.neg_inf:
            rd_d2i = 64'h0;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_d2i = 64'hffffffffffffffff;
          default: begin
            if (d2i_ovl.ovl_32u & ~fstatus_dw_d2i.invalid) begin
              rd_d2i = rs1[63] ? 64'h0: 64'hffffffffffffffff;
            end else begin
              rd_d2i = {{32{rd_65bit_d2i[31]}}, rd_65bit_d2i[31:0]}; // according to SPIKE, they do sign-extension altought it's unsigned number
              fflags_d2i.nv = 1'b0;
            end
          end
        endcase
      end
      ORV64_FP_CVT_SEL_L: begin
        unique case (1'b1)
          rs1_cls.neg_inf:
            rd_d2i = 64'h8000000000000000;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_d2i = 64'h7fffffffffffffff;
          default: begin
            if (d2i_ovl.ovl_64 & ~fstatus_dw_d2i.invalid) begin
              rd_d2i = rs1[63] ? 64'h8000000000000000: 64'h7fffffffffffffff;
            end else begin
              rd_d2i = rd_65bit_d2i[63:0];
              fflags_d2i.nv = 1'b0;
            end
          end
        endcase
      end
      ORV64_FP_CVT_SEL_LU: begin
        unique case (1'b1)
          rs1_cls.neg_inf:
            rd_d2i = 64'h0;
          rs1_cls.pos_inf | rs1_cls.q_nan | rs1_cls.s_nan:
            rd_d2i = 64'hffffffffffffffff;
          default: begin
            if (d2i_ovl.ovl_64u & ~fstatus_dw_d2i.invalid) begin
              rd_d2i = rs1[63] ? 64'h0: 64'hffffffffffffffff;
            end else begin
              rd_d2i = rd_65bit_d2i[63:0];
              fflags_d2i.nv = 1'b0;
            end
          end
        endcase
      end
      default: begin
        rd_d2i = rd_65bit_d2i[63:0];
        fflags_d2i.nv = 1'b0;
      end
    endcase
    if (fflags_d2i.nv) begin
      fflags_d2i.nx = '0;
    end
  end
  `endif
  // }}}

  //==========================================================
  // double/single to single/double
  `ifdef ORV64_SUPPORT_FP_DOUBLE
  orv64_fp_cvt_d2s CVT_D2S(.single(rd_d2s), .double(rs1), .frm_dw(frm_dw), .fstatus_dw(fstatus_dw_d2s), .is_nan(d2s_nan));
  orv64_fp_cvt_s2d CVT_S2D(.single(rs1), .double(rd_s2d), .frm_dw(frm_dw), .fstatus_dw(fstatus_dw_s2d));
  `endif

endmodule

////////////////////////////////////////////////////////////////

module orv64_fp_cvt_s2d
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  output  orv64_data_t        double,
  output  orv64_fstatus_dw_t  fstatus_dw,
  input   orv64_data_t        single,
  input   orv64_frm_dw_t      frm_dw
);

  logic         is_zero;
  logic         is_denormal;

  logic         sign_s, sign_d;
  logic [ 7:0]  exp_s;
  logic [10:0]  exp_d, denormal_exp_d, final_exp_s;
  logic [22:0]  sig_s, first_1_pos;
  logic [51:0]  sig_d, denormal_sig_d;

  // single
  assign  sign_s  = single[31];
  assign  exp_s   = single[30:23];
  assign  sig_s   = single[22:0];

  assign  sign_d  = sign_s;
  assign  exp_d   = 11'(exp_s) - 11'd127 + 11'd1023;

  assign is_zero = (exp_s == '0) & (sig_s == '0);
  assign is_denormal = (exp_s == '0) & ~(sig_s == '0);

  always_comb begin
    first_1_pos = '0;
    for (int i = 0; i<23; i++) begin
      if (sig_s[i]) begin
        first_1_pos = 23'(i);
      end
    end
  end

  assign  denormal_exp_d   = $signed(exp_s) - 127 - (23-first_1_pos) + 1023 + 1;
  assign  denormal_sig_d   = {23'((sig_s) << (23-first_1_pos)), 29'b0};

  assign fstatus_dw = '0;
  always_comb begin
    sig_d   = {sig_s, 29'b0};
    if(exp_s == 8'hff) begin
      if (sig_s == '0) begin //inf
        double = sign_s ? ORV64_CONST_FP_D_NEG_INF: ORV64_CONST_FP_D_POS_INF;
      end else begin // NaN
        double = ORV64_CONST_FP_D_CANON_NAN;
      end
    end else if (is_zero) begin
      double = sign_s ? ORV64_CONST_FP_D_NEG_ZERO: ORV64_CONST_FP_D_POS_ZERO;
    end else if (is_denormal) begin
      double = {sign_s, denormal_exp_d, denormal_sig_d};
    end else begin
      double  = {sign_d, exp_d, sig_d}; 
    end
  end
endmodule

////////////////////////////////////////////////////////////////

module orv64_fp_cvt_d2s
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import orv64_func_pkg::*;
(
  output  orv64_data_t        single,
  output  orv64_fstatus_dw_t  fstatus_dw,
  input   orv64_data_t        double,
  input   orv64_frm_dw_t      frm_dw,
  output  logic               is_nan
);
  orv64_data_t  single_tmp;
  logic         sign_s, sign_d;
  logic [ 7:0]  exp_s, exp_s_unrounded, exp_s_rounded, denormal_exp_s;
  logic [10:0]  exp_d, final_exp_d;
  logic [22:0]  sig_s, sig_s_unrounded, sig_s_rounded, denormal_sig_s;
  logic [51:0]  sig_d, denormal_sig_d;

  logic [30:0]  abs_val_single, abs_val_single_unrounded;

  logic   guard_bit, rnd_bit, sticky_bit;

  logic exp_overflow, exp_underflow;
  logic is_d_denormal, is_s_denormal;
  logic is_zero;
  logic exp_too_small;
  logic s_underflow;

  // rounding
  logic halfway;
  logic less_halfway;

  // double
  assign  sign_d  = double[63];
  assign  exp_d   = double[62:52];
  assign  sig_d   = double[51:0];
  
  logic [10:0]  denormal_shift_amt;

  logic [10:0]  exp_s_lower_limit, exp_s_upper_limit, denorm_exp_s_limit;

  assign exp_s_lower_limit = -11'd127;
  assign exp_s_upper_limit = 11'd128;

  assign denorm_exp_s_limit = -11'd149;

  assign final_exp_d = $signed(exp_d - 11'd1023);

  assign exp_overflow = ($signed(final_exp_d) >= $signed(exp_s_upper_limit));
  assign exp_underflow = ($signed(final_exp_d) <= $signed(exp_s_lower_limit));

  assign denormal_shift_amt = -11'd127-final_exp_d;

  assign is_d_denormal = (exp_d == '0);
  assign is_s_denormal = exp_underflow;

  assign is_zero = (exp_d == '0) & (sig_d == '0);

  assign exp_too_small = ($signed(final_exp_d) <= $signed(denorm_exp_s_limit));
  assign s_underflow = is_d_denormal | exp_too_small;

  // sign/exp
  assign  sign_s = sign_d;
  assign  exp_s  = (exp_d - 11'd1023 + 11'd127);
  assign  denormal_exp_s  = '0;

  always_comb begin
    if(exp_d == 11'h7ff) begin
      if (sig_d == '0) begin //inf
        single = sign_d ? {{32{1'b1}}, 32'(ORV64_CONST_FP_S_NEG_INF)}: {{32{1'b1}}, 32'(ORV64_CONST_FP_S_POS_INF)};
      end else begin // NaN
        single = {{32{1'b1}}, 32'(ORV64_CONST_FP_S_CANON_NAN)};
      end
    end else if (is_zero | s_underflow) begin
      single = sign_d ? {{32{1'b1}}, 32'(ORV64_CONST_FP_S_NEG_ZERO)}: {{32{1'b1}}, 32'(ORV64_CONST_FP_S_POS_ZERO)};
    end else if (exp_overflow) begin
      single = sign_d ? {{32{1'b1}}, 32'(ORV64_CONST_FP_S_NEG_INF)}: {{32{1'b1}}, 32'(ORV64_CONST_FP_S_POS_INF)};
    end else begin
      single = single_tmp;
    end
  end

  // Mantissa 
  assign sig_s   = sig_d[51:29];
  assign denormal_sig_d = {1'b1, sig_d[51:1]} >> denormal_shift_amt;
  assign denormal_sig_s = denormal_sig_d[51:29];

  always_comb begin
    if (is_s_denormal) begin
      abs_val_single_unrounded = {denormal_exp_s, denormal_sig_s};
      guard_bit = denormal_sig_d[28];
      rnd_bit = denormal_sig_d[27];
      sticky_bit = |(denormal_sig_d[26:0]);
    end else begin
      abs_val_single_unrounded = {exp_s, sig_s};
      guard_bit = sig_d[28];
      rnd_bit = sig_d[27];
      sticky_bit = |(sig_d[26:0]);
    end
  end

  // Rounding
  assign halfway = guard_bit & ~(rnd_bit | sticky_bit);
  assign less_halfway = ~guard_bit;

  always_comb begin
    case (frm_dw)
      ORV64_FRM_DW_RTZ: begin
        abs_val_single = abs_val_single_unrounded;
      end
      ORV64_FRM_DW_RDN: begin
        if (sign_s & (guard_bit | rnd_bit | sticky_bit)) begin
          abs_val_single = abs_val_single_unrounded + 30'h1;
        end else begin
          abs_val_single = abs_val_single_unrounded;
        end
      end
      ORV64_FRM_DW_RUP: begin
        if (~sign_s & (guard_bit | rnd_bit | sticky_bit)) begin
          abs_val_single = abs_val_single_unrounded + 30'h1;
        end else begin
          abs_val_single = abs_val_single_unrounded;
        end
      end
      ORV64_FRM_DW_RMM: begin
        if (guard_bit | rnd_bit | sticky_bit) begin
          abs_val_single = abs_val_single_unrounded + 30'h1;
        end else begin
          abs_val_single = abs_val_single_unrounded;
        end
      end
      default: begin // RNE
        if (halfway) begin
          if (abs_val_single_unrounded[0]) begin
            abs_val_single = abs_val_single_unrounded + 30'h1;
          end else begin
            abs_val_single = abs_val_single_unrounded;
          end
        end else if (less_halfway) begin
          abs_val_single = abs_val_single_unrounded;
        end else begin
          abs_val_single = abs_val_single_unrounded + 30'h1;
        end
      end
    endcase
  end

  assign single_tmp = {{32{1'b1}}, sign_s, abs_val_single};

  assign fstatus_dw.compspecific= 1'b0;
  assign fstatus_dw.hugeint= 1'b0;
  assign fstatus_dw.inexact= exp_overflow | exp_underflow;
  assign fstatus_dw.huge= exp_overflow;
  assign fstatus_dw.tiny= exp_underflow;
  assign fstatus_dw.invalid= 1'b0;
  assign fstatus_dw.infinity= 1'b0;
  assign fstatus_dw.zero= 1'b0;
endmodule
