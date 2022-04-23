
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package orv64_decode_func_pkg;

  import orv64_typedef_pkg::*; 

  function automatic void func_orv64_decode_id2ex_addi (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ADDI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_slti (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLT;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLTI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sltiu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLTU;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLTIU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_andi (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_AND;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ANDI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_ori (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_OR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ORI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_xori (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_XOR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "XORI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_slli (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLLI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_srli (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRLI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_srai (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRA;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRAI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_add (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ADD";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_slt (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLT;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLT";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sltu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLTU;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLTU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_and (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_AND;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AND";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_or (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_OR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "OR";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_xor (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_XOR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "XOR";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sll (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLL";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_srl (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRL";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sra (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRA;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRA";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sub (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SUB;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SUB";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_auipc (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_U;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_PC_ADDER;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AUIPC";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_jal (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_J;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_PC_ADDER;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "JAL";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_jalr (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_PC_ADDER;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "JALR";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_beq (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SEQ;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_B;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_NONE;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "BEQ";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_bne (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SNE;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_B;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_NONE;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "BNE";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_blt (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLT;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_B;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_NONE;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "BLT";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_bltu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLTU;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_B;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_NONE;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "BLTU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_bge (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SGE;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_B;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_NONE;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "BGE";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_bgeu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SGEU;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_B;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_IMM;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_NONE;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "BGEU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lui (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_U;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LUI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lb (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LB";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lbu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LBU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lh (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LH";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lhu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LHU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lwu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LWU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_ld (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LD";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sb (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_S;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SB";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sh (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_S;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SH";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_S;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sd (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_S;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SD";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fence (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FENCE";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fence_i (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FENCE_I";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_csrrw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "CSRRW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_csrrs (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "CSRRS";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_csrrc (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "CSRRC";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_csrrwi (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_Z;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "CSRRWI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_csrrsi (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_Z;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "CSRRSI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_csrrci (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_Z;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "CSRRCI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_ecall (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ECALL";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_ebreak (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "EBREAK";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_wfi (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "WFI";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_wfe (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "WFE";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_addiw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ADDIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_slliw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLLIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_srliw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRLIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sraiw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRA;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRAIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_addw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "ADDW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sllw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SLL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SLLW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_srlw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRL;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRLW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sraw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SRA;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRAW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_subw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SUB;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SUBW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_uret (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "URET";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sret (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SRET";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_mret (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "MRET";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_mul (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_MUL_L;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_L;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "MUL";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_mulh (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_MUL_H;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_HSS;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "MULH";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_mulhu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_MUL_H;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_HUU;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "MULHU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_mulhsu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_MUL_H;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_HSU;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "MULHSU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_mulw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_MUL_L;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_W;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "MULW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_div (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_Q;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_Q;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "DIV";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_rem (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_R;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_R;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "REM";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_divu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_Q;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_QU;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "DIVU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_remu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_R;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_RU;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "REMU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_divw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_Q;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_QW;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "DIVW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_remw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_R;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_RW;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "REMW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_divuw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_Q;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_QUW;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "DIVUW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_remuw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_DIV_R;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_RUW;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "REMUW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_flw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FLW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsw (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_S;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSW";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fld (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FLD";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsd (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_S;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSD";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fadd_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_ADD_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FADD_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsub_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2_INV;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_ADD_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSUB_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmul_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_ZERO;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMUL_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fdiv_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_DIV_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_DIV_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FDIV_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsqrt_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_SQRT_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SQRT_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSQRT_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fadd_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_ADD_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsub_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2_INV;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_ADD_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSUB_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmul_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_ZERO;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMUL_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fdiv_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_DIV_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_DIV_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FDIV_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsqrt_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_SQRT_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SQRT_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSQRT_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmadd_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMADD_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmsub_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3_INV;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMSUB_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fnmadd_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1_INV;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3_INV;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FNMADD_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fnmsub_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1_INV;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FNMSUB_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmadd_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmsub_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3_INV;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMSUB_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fnmadd_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1_INV;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3_INV;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FNMADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fnmsub_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MAC_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1_INV;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_MAC_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FNMSUB_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsgnj_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SGNJ;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSGNJ_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsgnjn_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_JN;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SGNJ;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSGNJN_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsgnjx_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_JX;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SGNJ;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSGNJX_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsgnj_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SGNJ;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSGNJ_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsgnjn_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_JN;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SGNJ;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSGNJN_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fsgnjx_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_JX;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_SGNJ;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FSGNJX_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmin_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_MIN;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMIN_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmax_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_MAX;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMAX_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_feq_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_EQ;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FEQ_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_flt_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_LT;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FLT_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fle_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_S;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_LE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FLE_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmin_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_MIN;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMIN_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmax_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_MAX;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMAX_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_feq_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_EQ;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FEQ_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_flt_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_LT;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FLT_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fle_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_ADD_D;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_LE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CMP_D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FLE_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmv_x_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_FP_RS1_SEXT;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMV_X_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmv_s_x (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_OR;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_F0;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP_MV;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMV_S_X";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmv_x_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_FP_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMV_X_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fmv_d_x (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FMV_D_X";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_s_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_S_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_s_wu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_WU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_S_WU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_s_l (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_L;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_S_L";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_s_lu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_LU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_S_LU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_d_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_D_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_d_wu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_WU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_D_WU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_d_l (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_L;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_D_L";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_d_lu (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_LU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_I2D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_D_LU";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_w_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_S2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_W_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_wu_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_WU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_S2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_WU_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_l_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_L;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_S2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_L_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_lu_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_LU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_S2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_LU_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_w_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_D2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_W_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_wu_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_WU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_D2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_WU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_l_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_L;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_D2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_L_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_lu_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_LU;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_D2I;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_LU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_d_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_S2D;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_D_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fcvt_s_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 1;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CVT_D2S;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCVT_S_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fclass_s (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 1;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CLS;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCLASS_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_fclass_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_FP;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_MISC;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_CLS;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "FCLASS_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sfence_vma (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SFENCE_VMA";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lr_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_0;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 1;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LR_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sc_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_0;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 1;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SC_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoload_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 1;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOLOAD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amostore_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_0;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOSTORE_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoswap_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SWAP;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 1;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOSWAP_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoadd_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 1;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoxor_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_XOR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOXOR_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoand_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_AND;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOAND_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoor_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_OR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOOR_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amomin_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MIN;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMIN_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amomax_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MAX;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMAX_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amominu_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MIN_U;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMINU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amomaxu_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MAX_U;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMAXU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amonop_d (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMONOP_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_lr_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_0;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 1;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "LR_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_sc_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_0;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 1;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "SC_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoload_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_MA;
    id2ex_ctrl.rd_we = 1;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 1;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOLOAD_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amostore_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_0;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_ZERO;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOSTORE_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoswap_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_SWAP;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 1;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOSWAP_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoadd_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 1;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOADD_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoxor_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_XOR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOXOR_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoand_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_AND;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOAND_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amoor_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_OR;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOOR_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amomin_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MIN;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMIN_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amomax_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MAX;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMAX_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amominu_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MIN_U;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMINU_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amomaxu_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_MAX_U;
    id2ex_ctrl.alu_en = 1;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMOMAXU_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_amonop_w (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 1;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_RS1;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_RS2;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 1;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "AMONOP_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_id2ex_default (output orv64_id2ex_ctrl_t id2ex_ctrl);
    id2ex_ctrl = '{default:0};
    id2ex_ctrl.alu_op = ORV64_ALU_OP_ADD;
    id2ex_ctrl.alu_en = 0;
    id2ex_ctrl.is_32 = 0;
    id2ex_ctrl.is_fp_32 = 0;
    id2ex_ctrl.op1_sel = ORV64_OP1_SEL_ZERO;
    id2ex_ctrl.op2_sel = ORV64_OP2_SEL_IMM;
    id2ex_ctrl.imm_sel = ORV64_IMM_SEL_I;
    id2ex_ctrl.rd_avail = ORV64_RD_AVAIL_EX;
    id2ex_ctrl.rd_we = 0;
    id2ex_ctrl.is_rd_fp = 0;
    id2ex_ctrl.ex_pc_sel = ORV64_EX_PC_SEL_P4;
    id2ex_ctrl.ex_out_sel = ORV64_EX_OUT_SEL_ALU_OUT;
    id2ex_ctrl.mul_type = ORV64_MUL_TYPE_NONE;
    id2ex_ctrl.div_type = ORV64_DIV_TYPE_NONE;
    id2ex_ctrl.fp_op = ORV64_FP_OP_NONE;
    id2ex_ctrl.fp_rs1_sel = ORV64_FP_RS1_SEL_RS1;
    id2ex_ctrl.fp_rs2_sel = ORV64_FP_RS2_SEL_RS2;
    id2ex_ctrl.fp_rs3_sel = ORV64_FP_RS3_SEL_RS3;
    id2ex_ctrl.fp_sgnj_sel = ORV64_FP_SGNJ_SEL_J;
    id2ex_ctrl.fp_cmp_sel = ORV64_FP_CMP_SEL_NONE;
    id2ex_ctrl.fp_cvt_sel = ORV64_FP_CVT_SEL_W;
    id2ex_ctrl.fp_out_sel = ORV64_FP_OUT_SEL_NONE;
    id2ex_ctrl.is_amo = 0;
    id2ex_ctrl.is_amo_load = 0;
    id2ex_ctrl.is_amo_store = 0;
    id2ex_ctrl.is_lr = 0;
    id2ex_ctrl.is_sc = 0;
    `ifndef SYNTHESIS
    id2ex_ctrl.inst_code = "default";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_addi (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ADDI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_slti (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLTI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sltiu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLTIU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_andi (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ANDI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_ori (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ORI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_xori (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "XORI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_slli (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLLI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_srli (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRLI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_srai (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRAI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_add (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ADD";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_slt (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLT";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sltu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLTU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_and (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AND";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_or (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "OR";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_xor (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "XOR";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sll (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLL";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_srl (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRL";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sra (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRA";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sub (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SUB";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_auipc (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AUIPC";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_jal (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "JAL";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_jalr (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "JALR";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_beq (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "BEQ";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_bne (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "BNE";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_blt (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "BLT";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_bltu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "BLTU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_bge (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "BGE";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_bgeu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "BGEU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lui (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LUI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lb (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LB";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lbu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_U1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LBU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lh (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_2;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LH";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lhu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_U2;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LHU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lwu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_U4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LWU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_ld (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LD";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sb (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SB";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sh (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_2;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SH";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sd (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SD";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fence (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_FENCE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FENCE";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fence_i (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_FENCE_I;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FENCE_I";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_csrrw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_CSR_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_RW;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "CSRRW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_csrrs (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_CSR_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_RS;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "CSRRS";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_csrrc (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_CSR_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_RC;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "CSRRC";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_csrrwi (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_CSR_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_RW;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "CSRRWI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_csrrsi (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_CSR_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_RS;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "CSRRSI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_csrrci (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_CSR_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_RC;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "CSRRCI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_ecall (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ECALL";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_ebreak (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "EBREAK";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_wfi (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 1;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "WFI";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_wfe (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 1;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "WFE";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_addiw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ADDIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_slliw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLLIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_srliw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRLIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sraiw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRAIW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_addw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "ADDW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sllw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SLLW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_srlw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRLW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sraw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRAW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_subw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SUBW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_uret (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_U;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "URET";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sret (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_S;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SRET";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_mret (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_M;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "MRET";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_mul (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "MUL";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_mulh (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "MULH";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_mulhu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "MULHU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_mulhsu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "MULHSU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_mulw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "MULW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_div (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "DIV";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_rem (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "REM";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_divu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "DIVU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_remu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "REMU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_divw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "DIVW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_remw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "REMW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_divuw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "DIVUW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_remuw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "REMUW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_flw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FLW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsw (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSW";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fld (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FLD";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsd (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSD";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fadd_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FADD_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsub_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSUB_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmul_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMUL_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fdiv_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FDIV_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsqrt_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSQRT_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fadd_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsub_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSUB_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmul_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMUL_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fdiv_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FDIV_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsqrt_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSQRT_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmadd_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMADD_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmsub_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMSUB_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fnmadd_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FNMADD_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fnmsub_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FNMSUB_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmadd_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmsub_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMSUB_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fnmadd_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FNMADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fnmsub_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FNMSUB_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsgnj_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSGNJ_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsgnjn_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSGNJN_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsgnjx_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSGNJX_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsgnj_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSGNJ_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsgnjn_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSGNJN_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fsgnjx_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FSGNJX_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmin_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMIN_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmax_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMAX_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_feq_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FEQ_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_flt_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FLT_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fle_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FLE_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmin_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMIN_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmax_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMAX_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_feq_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FEQ_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_flt_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FLT_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fle_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FLE_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmv_x_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMV_X_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmv_s_x (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMV_S_X";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmv_x_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMV_X_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fmv_d_x (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FMV_D_X";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_s_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_S_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_s_wu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_S_WU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_s_l (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_S_L";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_s_lu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_S_LU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_d_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_D_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_d_wu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_D_WU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_d_l (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_D_L";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_d_lu (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_D_LU";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_w_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_W_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_wu_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_WU_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_l_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_L_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_lu_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_LU_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_w_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_W_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_wu_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_WU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_l_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_L_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_lu_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_LU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_d_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_D_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fcvt_s_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCVT_S_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fclass_s (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCLASS_S";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_fclass_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "FCLASS_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sfence_vma (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_SFENCE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SFENCE_VMA";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lr_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LR_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sc_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SC_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoload_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOLOAD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amostore_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOSTORE_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoswap_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOSWAP_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoadd_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOADD_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoxor_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOXOR_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoand_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOAND_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoor_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOOR_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amomin_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMIN_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amomax_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMAX_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amominu_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMINU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amomaxu_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMAXU_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amonop_d (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMONOP_D";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_lr_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "LR_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_sc_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_4;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "SC_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoload_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 1;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_MEM_READ;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOLOAD_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amostore_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_8;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOSTORE_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoswap_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOSWAP_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoadd_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 1;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOADD_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoxor_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOXOR_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoand_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOAND_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amoor_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOOR_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amomin_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMIN_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amomax_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMAX_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amominu_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMINU_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amomaxu_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMOMAXU_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_amonop_w (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "AMONOP_W";
    `endif
  endfunction

  function automatic void func_orv64_decode_ex2ma_default (output orv64_ex2ma_ctrl_t ex2ma_ctrl);
    ex2ma_ctrl = '{default:0};
    ex2ma_ctrl.is_load = 0;
    ex2ma_ctrl.is_store = 0;
    ex2ma_ctrl.fence_type = ORV64_FENCE_TYPE_NONE;
    ex2ma_ctrl.ma_byte_sel = ORV64_MA_BYTE_SEL_1;
    ex2ma_ctrl.rd_sel = ORV64_RD_SEL_EX_OUT;
    ex2ma_ctrl.csr_op = ORV64_CSR_OP_NONE;
    ex2ma_ctrl.ret_type = ORV64_RET_TYPE_NONE;
    ex2ma_ctrl.is_wfi = 0;
    ex2ma_ctrl.is_wfe = 0;
    `ifndef SYNTHESIS
    ex2ma_ctrl.inst_code = "default";
    `endif
  endfunction

endpackage

import orv64_decode_func_pkg::*;
