// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_alu
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
(
  output  logic     cmp_out,
  output  orv64_data_t    adder_out, alu_out,
  input   orv64_data_t    op1, op2,
  input   orv64_alu_op_t  alu_op,
  input   logic     is_32
);

  // ctrl signals
  logic   is_sub, is_cmp, is_cmp_u, is_cmp_inv, is_cmp_eq;
  assign  is_sub = alu_op[3];
  assign  is_cmp = (alu_op >= ORV64_ALU_OP_SLT);
  assign  is_cmp_u = alu_op[1];
  assign  is_cmp_inv = alu_op[0];
  assign  is_cmp_eq = ~alu_op[3];

  // ADD, SUB
  orv64_data_t  op2_inv, op1_xor_op2;
  assign  op2_inv = is_sub ? ~op2 : op2;
  assign  op1_xor_op2 = op1 ^ op2;
  assign  adder_out = op1 + op2_inv + {63'b0, is_sub};


  // SLT, SLTU
  logic   slt;
  assign  slt = (op1[63] == op2[63]) ? adder_out[63] : ((is_cmp_u ? op2[63] : op1[63]));
  assign  cmp_out = is_cmp_inv ^ (is_cmp_eq ? (op1_xor_op2 == 'b0) : slt);

  // SLL, SRL, SRA
  orv64_data_t  shout;

  logic [ 5:0]  shamt;
  logic [31:0]  shin_hi;
  orv64_data_t  shin_r, shin_l, shin, shout_r, shout_l;
  assign  shin_hi = ~is_32 ? op1[63:32] : {32{(is_sub & op1[31])}};
  assign  shamt = {(op2[5] & (~is_32)), op2[4:0]};
  assign  shin_r = {shin_hi, op1[31:0]};
  assign  shin_l = func_reverse(shin_r);
  assign  shin = ((alu_op == ORV64_ALU_OP_SRL) | (alu_op == ORV64_ALU_OP_SRA)) ? shin_r : shin_l;
  assign  shout_r = 64'(signed'({{is_sub & shin[63]}, shin}) >>> shamt);
  assign  shout_l = func_reverse(shout_r);
  assign  shout = (((alu_op == ORV64_ALU_OP_SRL) | (alu_op == ORV64_ALU_OP_SRA)) ? shout_r : 'b0)
                  | ((alu_op == ORV64_ALU_OP_SLL) ? shout_l : 'b0);


  // AND, OR, XOR
  orv64_data_t  logic_out;

  assign  logic_out = (((alu_op == ORV64_ALU_OP_XOR) | (alu_op == ORV64_ALU_OP_OR)) ? op1_xor_op2 : 'b0)
                      | (((alu_op == ORV64_ALU_OP_OR) | (alu_op == ORV64_ALU_OP_AND)) ? op1 & op2 : 'b0);

  // final out
  orv64_data_t  alu_out_64;
  orv64_data_t    amo_op1, amo_op2;
  assign  alu_out_64 = (alu_op == ORV64_ALU_OP_ADD) | (alu_op == ORV64_ALU_OP_SUB) ? adder_out   : 
					   (alu_op == ORV64_ALU_OP_MAX)   ? ($signed(op1) > $signed(op2) ? op1: op2) :
					   (alu_op == ORV64_ALU_OP_MIN)   ? ($signed(op1) < $signed(op2) ? op1: op2) :
					   (alu_op == ORV64_ALU_OP_MAX_U) ? (op1 > op2 ? op1: op2)					 :
					   (alu_op == ORV64_ALU_OP_MIN_U) ? (op1 < op2 ? op1: op2)					 :
					   (alu_op == ORV64_ALU_OP_SWAP)  ?  op2									 :
					   ({63'b0, is_cmp & slt} | logic_out | shout);

  assign  alu_out = is_32 ? {{32{alu_out_64[31]}}, alu_out_64[31:0]} : alu_out_64;

  // TOOD: delete after verified
  orv64_data_t  alu_out_ref;
  always_comb begin
    case (alu_op)
      ORV64_ALU_OP_ADD : alu_out_ref = op1 + op2;
      ORV64_ALU_OP_SLL : alu_out_ref = op1 << shamt;
      ORV64_ALU_OP_XOR : alu_out_ref = op1 ^ op2;
      ORV64_ALU_OP_OR  : alu_out_ref = op1 | op2;
      ORV64_ALU_OP_AND : alu_out_ref = op1 & op2;
      ORV64_ALU_OP_SRL : alu_out_ref = op1 >> shamt;
      ORV64_ALU_OP_SEQ : alu_out_ref = {63'b0, op1 == op2};
      ORV64_ALU_OP_SNE : alu_out_ref = {63'b0, op1 != op2};
      ORV64_ALU_OP_SUB : alu_out_ref = op1 - op2;
      ORV64_ALU_OP_SRA : alu_out_ref = $signed(op1) >>> shamt;
      ORV64_ALU_OP_SLT : alu_out_ref = {63'b0, $signed(op1) < $signed(op2)};
      ORV64_ALU_OP_SGE : alu_out_ref = {63'b0, $signed(op1) >= $signed(op2)};
      ORV64_ALU_OP_SLTU : alu_out_ref = {63'b0, op1 < op2};
      ORV64_ALU_OP_SGEU : alu_out_ref = {63'b0, op1 >= op2};
      ORV64_ALU_OP_MAX  : alu_out_ref = $signed(op1) > $signed(op2) ? op1: op2;
      ORV64_ALU_OP_MIN  : alu_out_ref = $signed(op1) < $signed(op2) ? op1: op2;
      ORV64_ALU_OP_MAX_U : alu_out_ref = op1 > op2 ? op1: op2;
      ORV64_ALU_OP_MIN_U : alu_out_ref = op1 < op2 ? op1: op2;
      default : alu_out_ref = 'b0;
    endcase // case alu_op
  end

endmodule
