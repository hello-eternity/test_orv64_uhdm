// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_rvc_inst_build 
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
(
  input    orv64_inst_t        rvc_inst,
  output   orv64_inst_t        full_inst
);

  //------------------------------------------------------
  // RVC breakdown
  orv64_rvc_opcode_t  rvc_opcode;
  logic [ 2:0]  rvc_funct3;
  logic [ 1:0]  rvc_funct2_hi, rvc_funct2_lo;
  logic         rvc_funct1;
  orv64_reg_addr_t    rvc_rs1_addr, rvc_rs2_addr, rvc_rd_addr, rvc_rs1_prime_addr, rvc_rs2_prime_addr, rvc_rd_prime_addr;
  orv64_data_t        rvc_nzuimm_9_2, rvc_uimm_7_3, rvc_uimm_8_4, rvc_uimm_6_2, rvc_nzimm_5_0, rvc_nzuimm_5_0, rvc_imm_11_1, rvc_imm_5_0, rvc_nzimm_9_4, rvc_nzimm_17_12, rvc_imm_8_1, rvc_uimm_8_3, rvc_uimm_9_4, rvc_uimm_7_2, rvc_uimm_8_3_c2, rvc_uimm_9_4_c2, rvc_uimm_7_2_c2;

  always_comb begin
    orv64_func_break_inst_rvc (
      .rvc_opcode(rvc_opcode),
      .rvc_funct3(rvc_funct3),
      .rvc_funct2_hi(rvc_funct2_hi),
      .rvc_funct2_lo(rvc_funct2_lo),
      .rvc_funct1(rvc_funct1),
      .rvc_rs1_addr(rvc_rs1_addr),
      .rvc_rs2_addr(rvc_rs2_addr),
      .rvc_rd_addr(rvc_rd_addr),
      .rvc_rs1_prime_addr(rvc_rs1_prime_addr),
      .rvc_rs2_prime_addr(rvc_rs2_prime_addr),
      .rvc_rd_prime_addr(rvc_rd_prime_addr),
      .rvc_nzuimm_9_2(rvc_nzuimm_9_2),
      .rvc_uimm_7_3(rvc_uimm_7_3),
      .rvc_uimm_8_4(rvc_uimm_8_4),
      .rvc_uimm_6_2(rvc_uimm_6_2),
      .rvc_nzimm_5_0(rvc_nzimm_5_0),
      .rvc_nzuimm_5_0(rvc_nzuimm_5_0),
      .rvc_imm_11_1(rvc_imm_11_1),
      .rvc_imm_5_0(rvc_imm_5_0),
      .rvc_nzimm_9_4(rvc_nzimm_9_4),
      .rvc_nzimm_17_12(rvc_nzimm_17_12),
      .rvc_imm_8_1(rvc_imm_8_1),
      .rvc_uimm_8_3(rvc_uimm_8_3),
      .rvc_uimm_9_4(rvc_uimm_9_4),
      .rvc_uimm_7_2(rvc_uimm_7_2),
      .rvc_uimm_8_3_c2(rvc_uimm_8_3_c2),
      .rvc_uimm_9_4_c2(rvc_uimm_9_4_c2),
      .rvc_uimm_7_2_c2(rvc_uimm_7_2_c2),
      .inst(rvc_inst)
    );
  end

  logic [19:0] imm_31_12;
  logic [12:0] imm_12_0;
  logic [11:0] imm_11_0;
  logic [4:0] rs1, rs2, rd;
  logic [4:0] opcode;
  logic [11:0] funct12;
  logic [6:0] funct7;
  logic [2:0] funct3;
  logic [2:0] width;
  logic [5:0] shamt;

  always_comb begin
    opcode = orv64_opcode_t'('0);
    full_inst = '0;
    imm_31_12 = '0;
    imm_12_0 = '0;
    imm_11_0 = '0;
    rs1 = '0; 
    rs2 = '0; 
    rd = '0;
    funct12 = '0;
    funct7 = '0;
    funct3 = '0;
    width = '0;
    shamt = '0;
    case (rvc_opcode)
      RVC_C0: begin
        case (rvc_funct3)
          3'b000: begin 
            if (rvc_inst[15:0] == 16'h0000) begin // illegal
              full_inst = '0;
            end else begin
              if (rvc_nzuimm_9_2 == '0) begin
                full_inst = '0;
              end else begin // c.addi4spn -> addi rd', x2, nzuimm[9:2]
                imm_11_0 = rvc_nzuimm_9_2;
                rs1 = 5'h02;
                funct3 = 3'b000;
                rd = rvc_rs2_prime_addr;
                opcode = ORV64_OP_IMM;
                full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
              end
            end
          end
          3'b001: begin // c.fld -> fld rd', offset[7:3](rs1')
            imm_11_0 = rvc_uimm_7_3[11:0];
            rs1 = rvc_rs1_prime_addr;
            width = 3'b011;
            rd = rvc_rs2_prime_addr;
            opcode = ORV64_LOAD_FP;
            full_inst = {imm_11_0, rs1, width, rd, opcode, 2'b11};
          end
          3'b010: begin // c.lw -> lw rd', offset[6:2](rs1')
            imm_11_0 = rvc_uimm_6_2[11:0];
            rs1 = rvc_rs1_prime_addr;
            funct3 = 3'b010;
            rd = rvc_rs2_prime_addr;
            opcode = ORV64_LOAD;
            full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
          end
          3'b011: begin // c.ld -> ld rd', offset[7:3](rs1')
            imm_11_0 = rvc_uimm_7_3[11:0];
            rs1 = rvc_rs1_prime_addr;
            funct3 = 3'b011;
            rd = rvc_rs2_prime_addr;
            opcode = ORV64_LOAD;
            full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
          end
          3'b101: begin // c.fsd -> fsd rs2', offset[7:3](rs1')
            imm_11_0 = rvc_uimm_7_3[11:0];
            rs2 = rvc_rs2_prime_addr;
            rs1 = rvc_rs1_prime_addr;
            width = 3'b011;
            opcode = ORV64_STORE_FP;
            full_inst = {imm_11_0[11:5], rs2, rs1, width, imm_11_0[4:0], opcode, 2'b11};
          end
          3'b110: begin // c.sw -> sw rs2', offset[6:2](rs1')
            imm_11_0 = rvc_uimm_6_2[11:0];
            rs2 = rvc_rs2_prime_addr;
            rs1 = rvc_rs1_prime_addr;
            width = 3'b010;
            opcode = ORV64_STORE;
            full_inst = {imm_11_0[11:5], rs2, rs1, width, imm_11_0[4:0], opcode, 2'b11};
          end
          3'b111: begin // c.sd -> sd rs2', offset[7:3](rs1')
            imm_11_0 = rvc_uimm_7_3[11:0];
            rs2 = rvc_rs2_prime_addr;
            rs1 = rvc_rs1_prime_addr;
            width = 3'b011;
            opcode = ORV64_STORE;
            full_inst = {imm_11_0[11:5], rs2, rs1, width, imm_11_0[4:0], opcode, 2'b11};
          end
          default: begin
            full_inst = '0;
          end
        endcase
      end
      RVC_C1: begin
        case (rvc_funct3)
          3'b000: begin 
            if (rvc_rd_addr == 5'h00) begin // c.nop -> nop
              full_inst = ORV64_CONST_INST_NOP;
            end else begin // c.addi -> addi rd, rd, nzimm[5:0]
              imm_11_0 = rvc_nzimm_5_0[11:0];
              rs1 = rvc_rd_addr;
              funct3 = 3'b000;
              rd = rvc_rd_addr;
              opcode = ORV64_OP_IMM;
              full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
            end
          end
          3'b001: begin // c.addiw -> addiw rd, rd, imm[5:0]
            if (rvc_rd_addr == '0) begin
              full_inst = '0;
            end else begin
              imm_11_0 = rvc_nzimm_5_0;
              rs1 = rvc_rd_addr;
              funct3 = 3'b000;
              rd = rvc_rd_addr;
              opcode = ORV64_OP_IMM_32;
              full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
            end
          end
          3'b010: begin 
            if (rvc_rd_addr == 5'h00) begin
              full_inst = ORV64_CONST_INST_NOP;
            end else begin// c.li -> addi rd, x0, imm[5:0]
              imm_11_0 = rvc_nzimm_5_0[11:0];
              rs1 = 5'h00;
              funct3 = 3'b000;
              rd = rvc_rd_addr;
              opcode = ORV64_OP_IMM;
              full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
            end
          end
          3'b011: begin
            if (rvc_rd_addr == 5'h02) begin // c.addi16sp -> addi x2, x2, nzimm[9:4]
              if (rvc_nzimm_9_4 == '0) begin
                full_inst = '0;
              end else begin
                imm_11_0 = rvc_nzimm_9_4[11:0];
                rs1 = 5'h02;
                funct3 = 3'b000;
                rd = 5'h02;
                opcode = ORV64_OP_IMM;
                full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
              end
            end else begin // c.lui -> lui rd, nzimm[17:12]
              if (rvc_nzimm_17_12 == '0) begin
                full_inst = '0;
              end else begin
                imm_31_12 = rvc_nzimm_17_12[31:12];
                rd = rvc_rd_addr;
                opcode = ORV64_LUI;
                full_inst = {imm_31_12, rd, opcode, 2'b11};
              end
            end
          end
          3'b100: begin
            case (rvc_funct2_hi)
              2'b00: begin // c.srli -> srli rd', rd', shamt[5:0]
                shamt = rvc_imm_5_0[5:0];
                rs1 = rvc_rd_prime_addr;
                funct3 = 3'b101;
                rd = rvc_rd_prime_addr;
                opcode = ORV64_OP_IMM;
                full_inst = {6'b000000, shamt, rs1, funct3, rd, opcode, 2'b11};
              end
              2'b01: begin // c.srai -> srai rd', rd', shamt[5:0]
                shamt = rvc_imm_5_0[5:0];
                rs1 = rvc_rd_prime_addr;
                funct3 = 3'b101;
                rd = rvc_rd_prime_addr;
                opcode = ORV64_OP_IMM;
                full_inst = {6'b010000, shamt, rs1, funct3, rd, opcode, 2'b11};
              end
              2'b10: begin // c.andi -> andi rd', rd', imm[5:0]
                imm_11_0 = rvc_nzimm_5_0;
                rs1 = rvc_rd_prime_addr;
                funct3 = 3'b111;
                rd = rvc_rd_prime_addr;
                opcode = ORV64_OP_IMM;
                full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
              end
              2'b11: begin
                if (rvc_funct1 == 1'b0) begin
                  case (rvc_funct2_lo)
                    2'b00: begin // c.sub -> sub rd', rd', rs2'
                      funct7 = 7'b0100000;
                      rs2 = rvc_rs2_prime_addr;
                      rs1 = rvc_rd_prime_addr;
                      funct3 = 3'b000;
                      rd = rvc_rd_prime_addr;
                      opcode = ORV64_OP;
                      full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
                    end
                    2'b01: begin // c.xor -> xor rd', rd', rs2'
                      funct7 = 7'h00;
                      rs2 = rvc_rs2_prime_addr;
                      rs1 = rvc_rd_prime_addr;
                      funct3 = 3'b100;
                      rd = rvc_rd_prime_addr;
                      opcode = ORV64_OP;
                      full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
                    end
                    2'b10: begin // c.or -> or rd', rd', rs2'
                      funct7 = 7'h00;
                      rs2 = rvc_rs2_prime_addr;
                      rs1 = rvc_rd_prime_addr;
                      funct3 = 3'b110;
                      rd = rvc_rd_prime_addr;
                      opcode = ORV64_OP;
                      full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
                    end
                    2'b11: begin // c.and -> and rd', rd', rs2'
                      funct7 = 7'h00;
                      rs2 = rvc_rs2_prime_addr;
                      rs1 = rvc_rd_prime_addr;
                      funct3 = 3'b111;
                      rd = rvc_rd_prime_addr;
                      opcode = ORV64_OP;
                      full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
                   end
                   default: begin
                     full_inst = '0;
                   end
                  endcase
                end else begin
                  case (rvc_funct2_lo)
                    2'b00: begin // c.subw -> subw rd', rd', rs2'
                      funct7 = 7'b0100000;
                      rs2 = rvc_rs2_prime_addr;
                      rs1 = rvc_rd_prime_addr;
                      funct3 = 3'b000;
                      rd = rvc_rd_prime_addr;
                      opcode = ORV64_OP_32;
                      full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
                    end
                    2'b01: begin // c.addw -> addw rd', rd', rs2'
                      funct7 = 7'b0000000;
                      rs2 = rvc_rs2_prime_addr;
                      rs1 = rvc_rd_prime_addr;
                      funct3 = 3'b000;
                      rd = rvc_rd_prime_addr;
                      opcode = ORV64_OP_32;
                      full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
                    end
                    default: begin
                      full_inst = '0;
                    end
                  endcase
                end
              end
              default: begin
                full_inst = '0;
              end
            endcase
          end
          3'b101: begin // c.j -> jal x0, offset[11:1]
            imm_31_12 = {rvc_imm_11_1[20], rvc_imm_11_1[10:1], rvc_imm_11_1[11], rvc_imm_11_1[19:12]};
            rd = 5'h00;
            opcode = ORV64_JAL;
            full_inst = {imm_31_12, rd, opcode, 2'b11};
          end
          3'b110: begin // c.beqz -> beq rs1', x0, offset[8:1]
            imm_12_0 = rvc_imm_8_1[12:0];
            rs2 = 5'h00;
            rs1 = rvc_rs1_prime_addr;
            funct3 = 3'b000;
            opcode = ORV64_BRANCH;
            full_inst = {imm_12_0[12], imm_12_0[10:5], rs2, rs1, funct3, imm_12_0[4:1], imm_12_0[11], opcode, 2'b11};
          end
          3'b111: begin // c.bnez -> bne rs1', x0, offset[8:1]
            imm_12_0 = rvc_imm_8_1[12:0];
            rs2 = 5'h00;
            rs1 = rvc_rs1_prime_addr;
            funct3 = 3'b001;
            opcode = ORV64_BRANCH;
            full_inst = {imm_12_0[12], imm_12_0[10:5], rs2, rs1, funct3, imm_12_0[4:1], imm_12_0[11], opcode, 2'b11};
          end
          default: begin
            full_inst = '0;
          end
        endcase
      end
      RVC_C2: begin
        case (rvc_funct3)
          3'b000: begin // c.slli -> slli rd, rd, shamt[5:0]
            shamt = rvc_imm_5_0[5:0];
            rs1 = rvc_rd_addr;
            funct3 = 3'b001;
            rd = rvc_rd_addr;
            opcode = ORV64_OP_IMM;
            full_inst = {6'b000000, shamt, rs1, funct3, rd, opcode, 2'b11};
          end
          3'b001: begin // c.fldsp -> fld rd, offset[8:3](x2)
            imm_11_0 = rvc_uimm_8_3[11:0];
            rs1 = 5'b00010;
            width = 3'b011;
            rd = rvc_rd_addr;
            opcode = ORV64_LOAD_FP;
            full_inst = {imm_11_0, rs1, width, rd, opcode, 2'b11};
          end
          3'b010: begin
            if (rvc_rd_addr == '0) begin
              full_inst = '0;
            end else begin // c.lwsp -> lw rd, offset[7:2](x2)
              imm_11_0 = rvc_uimm_7_2[11:0];
              rs1 = 5'b00010;
              funct3 = 3'b010;
              rd = rvc_rd_addr;
              opcode = ORV64_LOAD;
              full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
            end
          end
          3'b011: begin
            if (rvc_rd_addr == '0) begin
              full_inst = '0;
            end else begin // c.ldsp -> ld rd, offset[8:3](x2)
              imm_11_0 = rvc_uimm_8_3[11:0];
              rs1 = 5'b00010;
              funct3 = 3'b011;
              rd = rvc_rd_addr;
              opcode = ORV64_LOAD;
              full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
            end
          end
          3'b100: begin
            if (rvc_funct1 == 1'b0) begin
              if (rvc_rs2_addr == 5'h00) begin // c.jr -> jalr x0, 0(rs1)
                if (rvc_rs1_addr == '0) begin
                  full_inst = '0;
                end else begin
                  imm_11_0 = '0;
                  rs1 = rvc_rs1_addr;
                  funct3 = 3'b000;
                  rd = 5'h00;
                  opcode = ORV64_JALR;
                  full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
                end
              end else begin // c.mv -> add rd, x0, rs2
                funct7 = 7'h00;
                rs2 = rvc_rs2_addr;
                rs1 = 5'b00000;
                funct3 = 3'b000;
                rd = rvc_rd_addr;
                opcode = ORV64_OP;
                full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
              end
            end else begin
              if (rvc_rs2_addr == 5'h00) begin
                if (rvc_rd_addr == 5'h00) begin // c.ebreak -> ebreak
                  funct12 = 12'h001;
                  rs1 = 5'h00;
                  funct3 = 3'b000;
                  rd = 5'h00;
                  opcode = ORV64_SYSTEM;
                  full_inst = {funct12, rs1, funct3, rd, opcode, 2'b11};
                end else begin // c.jalr -> jalr x1, 0(rs1)
                  imm_11_0 = '0;
                  rs1 = rvc_rs1_addr;
                  funct3 = 3'b000;
                  rd = 5'b00001;
                  opcode = ORV64_JALR;
                  full_inst = {imm_11_0, rs1, funct3, rd, opcode, 2'b11};
                end
              end else begin // c.add -> add rd, rd, rs2
                funct7 = 7'h00;
                rs2 = rvc_rs2_addr;
                rs1 = rvc_rd_addr;
                funct3 = 3'b000;
                rd = rvc_rd_addr;
                opcode = ORV64_OP;
                full_inst = {funct7, rs2, rs1, funct3, rd, opcode, 2'b11};
              end
            end
          end
          3'b101: begin // c.fsdsp -> fsd rs2, offset[8:3](x2)
            imm_11_0 = rvc_uimm_8_3_c2[11:0];
            rs2 = rvc_rs2_addr;
            rs1 = 5'b00010;
            width = 3'b011;
            opcode = ORV64_STORE_FP;
            full_inst = {imm_11_0[11:5], rs2, rs1, width, imm_11_0[4:0], opcode, 2'b11};

          end
          3'b110: begin // c.swsp -> sw rs2, offset[7:2](x2)
            imm_11_0 = rvc_uimm_7_2_c2[11:0];
            rs2 = rvc_rs2_addr;
            rs1 = 5'b00010;
            width = 3'b010;
            opcode = ORV64_STORE;
            full_inst = {imm_11_0[11:5], rs2, rs1, width, imm_11_0[4:0], opcode, 2'b11};
          end
          3'b111: begin // c.sdsp -> sd rs2, offset[8:3](x2)
            imm_11_0 = rvc_uimm_8_3_c2[11:0];
            rs2 = rvc_rs2_addr;
            rs1 = 5'b00010;
            width = 3'b011;
            opcode = ORV64_STORE;
            full_inst = {imm_11_0[11:5], rs2, rs1, width, imm_11_0[4:0], opcode, 2'b11};
          end
          default: begin
            full_inst = '0;
          end
        endcase
      end
      default: begin
        full_inst = '0;
      end
    endcase
  end
endmodule
