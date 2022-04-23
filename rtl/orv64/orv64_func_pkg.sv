// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


package orv64_func_pkg;

  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;

  //==========================================================
  function automatic void func_pipe_ctrl (
    output  logic self_ready,
    output  logic self_valid,
    input   logic prev_valid_ff,
    input   logic next_ready,
    input   logic int_valid,
    input   logic kill,
    input   logic stall
  );
    self_ready = next_ready & ~stall;
    self_valid = ~kill & prev_valid_ff & int_valid;
  endfunction

  //==========================================================
  function automatic void func_break_inst (
    output  orv64_opcode_t      opcode,
    output  orv64_reg_addr_t    rd_addr, rs1_addr, rs2_addr, rs3_addr,
    output  logic [ 1:0]  funct2,
    output  logic [ 2:0]  funct3,
    output  logic [ 4:0]  funct5,
    output  logic [ 5:0]  funct6,
    output  logic [ 6:0]  funct7,
    output  logic [11:0]  funct12,
    output  logic [ 1:0]  fmt,
    output  orv64_data_t        i_imm, s_imm, b_imm, u_imm, j_imm, z_imm,
    output  orv64_frm_t         frm,
    input   orv64_inst_t        inst
  );
    opcode    = orv64_opcode_t'(inst[6:2]);
    rd_addr   = inst[11:7];
    rs1_addr  = inst[19:15];
    rs2_addr  = inst[24:20];
    rs3_addr  = inst[31:27];
    funct2    = inst[26:25];
    funct3    = inst[14:12];
    funct5    = inst[24:20];
    funct6    = inst[31:26];
    funct7    = inst[31:25];
    funct12   = inst[31:20];

    fmt       = inst[26:25];

    i_imm = { {53{inst[31]}}, inst[30:20] };
    s_imm = { {53{inst[31]}}, inst[30:25], inst[11:7] };
    b_imm = { {52{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };
    u_imm = { {32{inst[31]}}, inst[31:12], 12'b0 };
    j_imm = { {44{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0 };
    z_imm = { 59'b0, inst[19:15] };

    frm = orv64_frm_t'(inst[14:12]);
  endfunction

  //==========================================================
  function automatic orv64_data_t func_fp_inv (orv64_data_t in, logic is_32);
    func_fp_inv = is_32 ? {{32{1'b1}}, ~in[31], in[30:0]} : {~in[63], in[62:0]};
  endfunction

  function automatic orv64_data_t func_fp_is_neg (orv64_data_t in, logic is_32);
    func_fp_is_neg = is_32 ? in[31]: in[63];
  endfunction

  function automatic orv64_fflags_t func_fp_fflags (orv64_fstatus_dw_t fstatus_dw);
    func_fp_fflags.nv = fstatus_dw.invalid;
    func_fp_fflags.dz = 1'b0;
    func_fp_fflags.of = fstatus_dw.huge;
    func_fp_fflags.uf = fstatus_dw.tiny;
    func_fp_fflags.nx = fstatus_dw.inexact;
  endfunction

  function automatic logic func_fp_is_nan (orv64_data_t in, logic is_32);
    if (is_32)
      func_fp_is_nan = (in[30:23] == 8'hFF) & (in[22:0] != 'b0);
    else
      func_fp_is_nan = (in[62:52] == 11'h7FF) & (in[51:0] != 'b0);
  endfunction

  function automatic logic func_fp_is_snan (orv64_data_t in, logic is_32);
    logic is_nan;
    is_nan = func_fp_is_nan(.in(in), .is_32(is_32));

    if (is_32)
      func_fp_is_snan = is_nan & (in[22] == 1'b0);
    else
      func_fp_is_snan = is_nan & (in[51] == 1'b0);
  endfunction

  function automatic logic func_fp_is_qnan (orv64_data_t in, logic is_32);
    logic is_nan;
    is_nan = func_fp_is_nan(.in(in), .is_32(is_32));

    if (is_32)
      func_fp_is_qnan = is_nan & (in[22] == 1'b1);
    else
      func_fp_is_qnan = is_nan & (in[51] == 1'b1);
  endfunction

  function automatic logic func_fp_is_neg_inf (orv64_data_t in, logic is_32);
    func_fp_is_neg_inf = is_32 ? (in[31:0] == ORV64_CONST_FP_S_NEG_INF) : (in == ORV64_CONST_FP_D_NEG_INF);
  endfunction

  function automatic logic func_fp_is_pos_inf (orv64_data_t in, logic is_32);
    func_fp_is_pos_inf = is_32 ? (in[31:0] == ORV64_CONST_FP_S_POS_INF) : (in == ORV64_CONST_FP_D_POS_INF);
  endfunction

  function automatic logic func_fp_is_neg_zero (orv64_data_t in, logic is_32);
    func_fp_is_neg_zero = is_32 ? (in[31:0] == ORV64_CONST_FP_S_NEG_ZERO) : (in == ORV64_CONST_FP_D_NEG_ZERO);
  endfunction

  function automatic logic func_fp_is_pos_zero (orv64_data_t in, logic is_32);
    func_fp_is_pos_zero = is_32 ? (in[31:0] == ORV64_CONST_FP_S_POS_ZERO) : (in == ORV64_CONST_FP_D_POS_ZERO);
  endfunction

  function automatic logic func_fp_is_zero (orv64_data_t in, logic is_32);
    func_fp_is_zero = is_32 ? (in[30:0] == ORV64_CONST_FP_S_ZERO) : (in[62:0] == ORV64_CONST_FP_D_ZERO);
  endfunction

  function automatic logic func_fp_is_neg_sub (orv64_data_t in, logic is_32);
    func_fp_is_neg_sub = is_32 ? (in[31] & (in[30:23] == 'b0) & (in[22:0] != 'b0)) : (in[63] & (in[62:52] == 'b0) & (in[51:0] != 'b0));
  endfunction

  function automatic logic func_fp_is_pos_sub (orv64_data_t in, logic is_32);
    func_fp_is_pos_sub = is_32 ? (~in[31] & (in[30:23] == 'b0) & (in[22:0] != 'b0)) : (~in[63] & (in[62:52] == 'b0) & (in[51:0] != 'b0));
  endfunction

  //TODO: Add code here for fp16
  function automatic logic func_fp16_is_nan (logic [15:0] in);
      func_fp16_is_nan = (in[14:10] == 5'b11111) & (in[9:0] != 'b0);
  endfunction

  function automatic logic func_fp16_is_snan (logic [15:0] in);
    logic is_nan;
    is_nan = func_fp16_is_nan(.in(in));
      func_fp16_is_snan = is_nan & (in[9] == 1'b0);

  endfunction

  function automatic logic func_fp16_is_qnan (logic [15:0] in);
    logic is_nan;
    is_nan = func_fp16_is_nan(.in(in));

      func_fp16_is_qnan = is_nan & (in[9] == 1'b1);
  endfunction

  function automatic logic func_fp16_is_neg_inf (logic [15:0] in);
    func_fp16_is_neg_inf = (in[15:0] == ORV64_CONST_FP16_S_NEG_INF) ;
  endfunction

  function automatic logic func_fp16_is_pos_inf (logic [15:0] in);
    func_fp16_is_pos_inf =  (in[15:0] == ORV64_CONST_FP16_S_POS_INF);
  endfunction

  function automatic logic func_fp16_is_neg_zero (logic [15:0] in);
    func_fp16_is_neg_zero = (in[15:0] == ORV64_CONST_FP16_S_NEG_ZERO) ;
  endfunction

  function automatic logic func_fp16_is_pos_zero (logic [15:0] in);
    func_fp16_is_pos_zero = (in[14:0] == ORV64_CONST_FP16_S_ZERO) ;
  endfunction

  function automatic logic func_fp16_is_zero (logic [15:0] in);
    func_fp16_is_zero = (in[14:0] == ORV64_CONST_FP16_S_ZERO) ;
  endfunction

  function automatic logic func_fp16_is_neg_sub (logic [15:0] in);
    func_fp16_is_neg_sub = (in[15] & (in[14:10] == 'b0) & (in[9:0] != 'b0));
  endfunction

  function automatic logic func_fp16_is_pos_sub (logic [15:0] in);
    func_fp16_is_pos_sub =  (~in[15] & (in[14:10] == 'b0) & (in[9:0] != 'b0)) ;
  endfunction
  
  //==========================================================
  function automatic orv64_data_t func_reverse (orv64_data_t in);
    for (int i = 0; i < 64; i++) begin
      func_reverse[63 - i] = in[i];
    end
  endfunction

  //==========================================================
  function automatic orv64_data_t func_expand_byte_mask (logic [7:0] byte_mask);
    for (int i = 0; i < 8; i++) begin
      for (int j = 0; j < 8; j++) begin
        func_expand_byte_mask[i*8+j] = byte_mask[i];
      end
    end
  endfunction

  //==========================================================
  function automatic void orv64_get_excp_perm_type (
    input orv64_access_type_t access_type,
    output orv64_excp_cause_t excp_cause
  );
    case (access_type)
      ORV64_ACCESS_FETCH: begin
        excp_cause = ORV64_EXCP_CAUSE_INST_ACCESS_FAULT;
      end
      ORV64_ACCESS_LOAD: begin
        excp_cause = ORV64_EXCP_CAUSE_LOAD_ACCESS_FAULT;
      end
      ORV64_ACCESS_STORE: begin
        excp_cause = ORV64_EXCP_CAUSE_STORE_ACCESS_FAULT;
      end
      ORV64_ACCESS_AMO: begin
        excp_cause = ORV64_EXCP_CAUSE_STORE_ACCESS_FAULT;
      end
      default: begin
        excp_cause = ORV64_EXCP_CAUSE_NONE;
      end
    endcase
  endfunction

  function automatic void orv64_get_fault_type (
    input orv64_access_type_t access_type,
    output orv64_excp_cause_t excp_cause
  );
    case (access_type)
      ORV64_ACCESS_FETCH: begin
        excp_cause = ORV64_EXCP_CAUSE_INST_PAGE_FAULT;
      end
      ORV64_ACCESS_LOAD: begin
        excp_cause = ORV64_EXCP_CAUSE_LOAD_PAGE_FAULT;
      end
      ORV64_ACCESS_STORE: begin
        excp_cause = ORV64_EXCP_CAUSE_STORE_PAGE_FAULT;
      end
      ORV64_ACCESS_AMO: begin
        excp_cause = ORV64_EXCP_CAUSE_STORE_PAGE_FAULT;
      end
      default: begin
        excp_cause = ORV64_EXCP_CAUSE_NONE;
      end
    endcase
  endfunction

  function automatic void orv64_func_break_inst_rvc (
    output  orv64_rvc_opcode_t  rvc_opcode,
    output  logic [ 2:0]  rvc_funct3,
    output  logic [ 1:0]  rvc_funct2_hi, rvc_funct2_lo,
    output  logic         rvc_funct1,
    output  orv64_reg_addr_t    rvc_rs1_addr, rvc_rs2_addr, rvc_rd_addr, rvc_rs1_prime_addr, rvc_rs2_prime_addr, rvc_rd_prime_addr,
    output  orv64_data_t        rvc_nzuimm_9_2, rvc_uimm_7_3, rvc_uimm_8_4, rvc_uimm_6_2, rvc_nzimm_5_0, rvc_nzuimm_5_0, rvc_imm_11_1, rvc_imm_5_0, rvc_nzimm_9_4, rvc_nzimm_17_12, rvc_imm_8_1, rvc_uimm_8_3, rvc_uimm_9_4, rvc_uimm_7_2, rvc_uimm_8_3_c2, rvc_uimm_9_4_c2, rvc_uimm_7_2_c2,
    input   orv64_inst_t        inst
  );
    rvc_opcode  = orv64_rvc_opcode_t'(inst[1:0]);
    rvc_funct3  = inst[15:13];
    rvc_funct1  = inst[12];
    rvc_funct2_hi = inst[11:10];
    rvc_funct2_lo = inst[6:5];

    rvc_rs1_addr        = inst[11:7];
    rvc_rs2_addr        = inst[6:2];
    rvc_rd_addr         = inst[11:7];
    rvc_rs1_prime_addr  = 5'({2'b01, inst[9:7]});
    rvc_rs2_prime_addr  = 5'({2'b01, inst[4:2]});
    rvc_rd_prime_addr   = 5'({2'b01, inst[9:7]});

    rvc_nzuimm_9_2  = ORV64_XLEN'({ 64'b0, inst[10:7], inst[12:11], inst[5], inst[6], 2'b0});
    rvc_uimm_7_3    = ORV64_XLEN'({ 64'b0, inst[6:5], inst[12:10], 3'b0});
    rvc_uimm_8_4    = ORV64_XLEN'({ 64'b0, inst[10], inst[6:5], inst[12:11], 4'b0});
    rvc_uimm_6_2    = ORV64_XLEN'({ 64'b0, inst[5], inst[12:10], inst[6], 2'b0});
    rvc_nzimm_5_0   = ORV64_XLEN'({ {64{inst[12]}}, inst[12], inst[6:2]});
    rvc_nzuimm_5_0  = ORV64_XLEN'({ 64'b0, inst[12], inst[6:2]});
    rvc_imm_11_1    = ORV64_XLEN'({ {64{inst[12]}}, inst[12], inst[8], inst[10:9], inst[6], inst[7], inst[2], inst[11], inst[5:3], 1'b0});
    rvc_imm_5_0     = ORV64_XLEN'({ {64{inst[12]}}, inst[12], inst[6:2]});
    rvc_nzimm_9_4   = ORV64_XLEN'({ {64{inst[12]}}, inst[12], inst[4:3], inst[5], inst[2], inst[6], 4'b0});
    rvc_nzimm_17_12 = ORV64_XLEN'({ {64{inst[12]}}, inst[12], inst[6:2], 12'b0});
    rvc_imm_8_1     = ORV64_XLEN'({ {64{inst[12]}}, inst[12], inst[6:5], inst[2], inst[11:10], inst[4:3], 1'b0});
    rvc_uimm_8_3    = ORV64_XLEN'({ 64'b0, inst[4:2], inst[12], inst[6:5], 3'b0});
    rvc_uimm_9_4    = ORV64_XLEN'({ 64'b0, inst[5:2], inst[12], inst[6], 4'b0});
    rvc_uimm_7_2    = ORV64_XLEN'({ 64'b0, inst[3:2], inst[12], inst[6:4], 2'b0});
    rvc_uimm_8_3_c2 = ORV64_XLEN'({ 64'b0, inst[9:7], inst[12:10], 3'b0});
    rvc_uimm_9_4_c2 = ORV64_XLEN'({ 64'b0, inst[10:7], inst[12:11], 4'b0});
    rvc_uimm_7_2_c2 = ORV64_XLEN'({ 64'b0, inst[8:7], inst[12:9], 2'b0});

  endfunction



endpackage
