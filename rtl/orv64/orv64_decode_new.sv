// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_decode_new
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
  import orv64_decode_func_pkg::*;
  import pygmy_intf_typedef::*;
(
  // IF -> ID
  input   orv64_if2id_t       if2id_ff,
  input   orv64_if2id_ctrl_t  if2id_ctrl_ff,
  input   orv64_excp_t        if2id_excp_ff,
  input   orv64_itb_packet_t  rff_if2id_itb_data,
  input   logic               if_ready,
  // ID -> IF
  output  orv64_npc_t         id2if_npc,
  output  logic               id2if_kill,
  // ID -> Regfile
  output  orv64_if2irf_t      id2irf,
  // Regfile -> ID
  input   orv64_irf2id_t      irf2id,
`ifdef ORV64_SUPPORT_FP
  input   orv64_fprf2id_t     fprf2id,
`endif
  // ID -> EX
  output  orv64_id2ex_t       id2ex_ff,
  output  orv64_data_t        id2ex_fp_rs1_ff,
  output  orv64_itb_packet_t  rff_id2ex_itb_data,

  // ID -> L1 I$
  output logic                 id2ic_fence_req_valid,
  output cache_fence_if_req_t  id2ic_fence_req,
  input  logic                 ic2id_fence_req_ready,

  input  logic                 ic2id_fence_resp_valid,
  input  cache_fence_if_resp_t ic2id_fence_resp,
  output logic                 id2ic_fence_resp_ready,

  output logic                 id2ib_flush_req_valid,

  // ID -> ITLB
  output logic                       id2itlb_flush_req_valid,
  output orv64_tlb_flush_if_req_t    id2itlb_flush_req,

  // ID -> DA
  output  orv64_id2da_t id2da,
  output  orv64_inst_t  id_inst,

  `ifdef ORV64_SUPPORT_MULDIV
  output  orv64_id2muldiv_t   id2mul_ff, id2div_ff, id2mul, id2div,
  `endif // ORV64_SUPPORT_MULDIV

`ifdef ORV64_SUPPORT_FP
  output  orv64_id2fp_add_t   id2fp_add_s_ff,
  output  orv64_id2fp_mac_t   id2fp_mac_s_ff,
  output  orv64_id2fp_div_t   id2fp_div_s_ff,
  output  orv64_id2fp_sqrt_t  id2fp_sqrt_s_ff,

`ifdef ORV64_SUPPORT_FP_DOUBLE
  output  orv64_id2fp_add_t   id2fp_add_d_ff,
  output  orv64_id2fp_mac_t   id2fp_mac_d_ff,
  output  orv64_id2fp_div_t   id2fp_div_d_ff,
  output  orv64_id2fp_sqrt_t  id2fp_sqrt_d_ff,
`endif // ORV64_SUPPORT_FP_DOUBLE

  output  orv64_id2fp_misc_t  id2fp_misc_ff,
`endif // ORV64_SUPPORT_FP

  output  orv64_id2ex_ctrl_t  id2ex_ctrl_ff,
  output  orv64_excp_t        id2ex_excp_ff,
  // EX/MA/WB -> ID: bypass
  input   orv64_bps_t         ex2id_bps, ma2id_bps, /* wb2id_bps, */
  input   orv64_reg_addr_t    ex2id_kill_addr,
  // MA -> ID: scoreboard
  input   orv64_ma2rf_t       ma2irf,

`ifdef ORV64_SUPPORT_FP
  input   orv64_ma2rf_t       ma2fprf,
`endif
  input   logic         cs2id_scb_rst,
  // privilege level
  input   orv64_prv_t         prv,
  input   orv64_csr_mstatus_t mstatus,
  // pipeline ctrl
  input   logic         id_stall, id_kill, if_valid_ff, ex_ready, ex_valid, if_valid,
  output  logic         id_valid, id_valid_ff, id_ready,
  output  logic         id_is_stable_stall,
  // performance counter
  output  logic         id_wait_for_reg,
  output  orv64_vaddr_t       id_pc,
  // floating point
  input   orv64_frm_t         frm_csr,

  output  logic         id_has_amo_inst,

  input   logic         rst, clk
);
  import orv64_param_pkg::*;

  logic ex_ready_masked;

  orv64_id2ex_t       id2ex;
  orv64_id2ex_ctrl_t  id2ex_ctrl;
  orv64_excp_t        id2ex_excp;
  orv64_itb_packet_t  id2ex_itb_data;

  logic is_fence_inst, wait_for_fence, wait_for_fence_accept;
  logic rff_new_fence_req;

  logic is_sfence_inst, do_trap_sfence;
  logic rff_new_sfence_req;

  logic   fp_access_excp, rs1_is_fp, rs2_is_fp;
  logic   is_fp_instr;

  logic   is_rs1_fp, is_rs2_fp, is_rd_fp, rs1_re, rs2_re, rs3_re, is_rs1_x0, is_rs2_x0, is_rd_x0;


`ifndef ORV64_SUPPORT_FP
  orv64_ma2rf_t ma2fprf;
  assign  ma2fprf = '{default:0};
`endif

  //==========================================================
  // Decode {{{

  // break-down inst
  orv64_opcode_t      opcode;
  orv64_reg_addr_t    rd_addr, rs1_addr, rs2_addr, rs3_addr;

  orv64_csr_addr_t    csr_addr;
  logic [ 1:0]  funct2;
  logic [ 2:0]  funct3;
  logic [ 4:0]  funct5;
  logic [ 5:0]  funct6;
  logic [ 6:0]  funct7;
  logic [11:0]  funct12;
  logic [ 1:0]  fmt;
  orv64_data_t        i_imm, s_imm, b_imm, u_imm, j_imm, z_imm;
  orv64_frm_t         frm;



  always_comb begin
    func_break_inst(
      .opcode(opcode),
      .rd_addr(rd_addr),
      .rs1_addr(rs1_addr),
      .rs2_addr(rs2_addr),
      .rs3_addr(rs3_addr),
      .funct2(funct2),
      .funct3(funct3),
      .funct5(funct5),
      .funct6(funct6),
      .funct7(funct7),
      .funct12(funct12),
      .fmt(fmt),
      .i_imm(i_imm),
      .s_imm(s_imm),
      .b_imm(b_imm),
      .u_imm(u_imm),
      .j_imm(j_imm),
      .z_imm(z_imm),
      .frm(frm),
      .inst(if2id_ff.inst)
    );


  end

  assign id_has_amo_inst = if_valid_ff & ~id_kill & if2id_ctrl_ff.is_amo;

  // decode
  logic   is_illegal_inst, is_inst_lsb_not_11;

  assign  is_inst_lsb_not_11 = (if2id_ff.inst[1:0] != 2'b11);
  always_comb begin
    is_illegal_inst = 1'b0;
    case (opcode)
	  ORV64_AMO:
		case (funct7[6:2])
                  5'h2:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_lr_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_lr_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h3:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_sc_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_sc_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h1:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amoswap_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amoswap_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h0:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amoadd_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amoadd_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h4:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amoxor_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amoxor_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'hC:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amoand_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amoand_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h8:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amoor_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amoor_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h10:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amomin_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amomin_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h14:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amomax_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amomax_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h18:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amominu_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amominu_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
                  5'h1C:  begin
                    case(funct3)
                      3'h2: func_orv64_decode_id2ex_amomaxu_w(id2ex_ctrl);
                      3'h3: func_orv64_decode_id2ex_amomaxu_d(id2ex_ctrl);
                      default: begin
                        func_orv64_decode_id2ex_default(id2ex_ctrl);
                        is_illegal_inst = 1'b1;
                      end
                    endcase
                  end
     	  default: begin
        		 func_orv64_decode_id2ex_default(id2ex_ctrl);
            	 is_illegal_inst = 1'b1;
          end
        endcase

      ORV64_LUI: func_orv64_decode_id2ex_lui(id2ex_ctrl);
      ORV64_AUIPC: func_orv64_decode_id2ex_auipc(id2ex_ctrl);
      ORV64_JAL: func_orv64_decode_id2ex_jal(id2ex_ctrl);
      ORV64_JALR: begin
        if (funct3 == '0) begin
          func_orv64_decode_id2ex_jalr(id2ex_ctrl);
        end else begin
          func_orv64_decode_id2ex_default(id2ex_ctrl);
          is_illegal_inst = 1'b1;
        end
      end
      ORV64_OP_IMM: // {{{
        case (funct3)
          3'h0: func_orv64_decode_id2ex_addi(id2ex_ctrl);
          3'h2: func_orv64_decode_id2ex_slti(id2ex_ctrl);
          3'h3: func_orv64_decode_id2ex_sltiu(id2ex_ctrl);
          3'h7: func_orv64_decode_id2ex_andi(id2ex_ctrl);
          3'h6: func_orv64_decode_id2ex_ori(id2ex_ctrl);
          3'h4: func_orv64_decode_id2ex_xori(id2ex_ctrl);
          3'h1: begin
            if (funct6 == 6'h00) begin
              func_orv64_decode_id2ex_slli(id2ex_ctrl);
            end else begin
              func_orv64_decode_id2ex_default(id2ex_ctrl);
              is_illegal_inst = 1'b1;
            end
          end
          3'h5:
            case (funct6)
              6'h00: func_orv64_decode_id2ex_srli(id2ex_ctrl);
              6'h10: func_orv64_decode_id2ex_srai(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_OP: // {{{
        case (funct7)
          7'h00:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_add(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_sll(id2ex_ctrl);
              3'h2: func_orv64_decode_id2ex_slt(id2ex_ctrl);
              3'h3: func_orv64_decode_id2ex_sltu(id2ex_ctrl);
              3'h4: func_orv64_decode_id2ex_xor(id2ex_ctrl);
              3'h5: func_orv64_decode_id2ex_srl(id2ex_ctrl);
              3'h6: func_orv64_decode_id2ex_or(id2ex_ctrl);
              3'h7: func_orv64_decode_id2ex_and(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h20:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_sub(id2ex_ctrl);
              3'h5: func_orv64_decode_id2ex_sra(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          `ifdef ORV64_SUPPORT_MULDIV
          7'h01:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_mul(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_mulh(id2ex_ctrl);
              3'h2: func_orv64_decode_id2ex_mulhsu(id2ex_ctrl);
              3'h3: func_orv64_decode_id2ex_mulhu(id2ex_ctrl);
              3'h4: func_orv64_decode_id2ex_div(id2ex_ctrl);
              3'h5: func_orv64_decode_id2ex_divu(id2ex_ctrl);
              3'h6: func_orv64_decode_id2ex_rem(id2ex_ctrl);
              3'h7: func_orv64_decode_id2ex_remu(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          `endif // ORV64_SUPPORT_MULDIV
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_BRANCH: // {{{
        case (funct3)
          3'h0: func_orv64_decode_id2ex_beq(id2ex_ctrl);
          3'h1: func_orv64_decode_id2ex_bne(id2ex_ctrl);
          3'h4: func_orv64_decode_id2ex_blt(id2ex_ctrl);
          3'h6: func_orv64_decode_id2ex_bltu(id2ex_ctrl);
          3'h5: func_orv64_decode_id2ex_bge(id2ex_ctrl);
          3'h7: func_orv64_decode_id2ex_bgeu(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_LOAD: // {{{
        case (funct3)
          3'h0: func_orv64_decode_id2ex_lb(id2ex_ctrl);
          3'h4: func_orv64_decode_id2ex_lbu(id2ex_ctrl);
          3'h1: func_orv64_decode_id2ex_lh(id2ex_ctrl);
          3'h5: func_orv64_decode_id2ex_lhu(id2ex_ctrl);
          3'h2: func_orv64_decode_id2ex_lw(id2ex_ctrl);
          3'h6: func_orv64_decode_id2ex_lwu(id2ex_ctrl);
          3'h3: func_orv64_decode_id2ex_ld(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_STORE: // {{{
        case (funct3)
          3'h0: func_orv64_decode_id2ex_sb(id2ex_ctrl);
          3'h1: func_orv64_decode_id2ex_sh(id2ex_ctrl);
          3'h2: func_orv64_decode_id2ex_sw(id2ex_ctrl);
          3'h3: func_orv64_decode_id2ex_sd(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_SYSTEM: // {{{
        case (funct3)
          3'h0: func_orv64_decode_id2ex_default(id2ex_ctrl); // -> decode in EX
          3'h1: func_orv64_decode_id2ex_csrrw(id2ex_ctrl);
          3'h2: func_orv64_decode_id2ex_csrrs(id2ex_ctrl);
          3'h3: func_orv64_decode_id2ex_csrrc(id2ex_ctrl);
          3'h5: func_orv64_decode_id2ex_csrrwi(id2ex_ctrl);
          3'h6: func_orv64_decode_id2ex_csrrsi(id2ex_ctrl);
          3'h7: func_orv64_decode_id2ex_csrrci(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_OP_IMM_32: // {{{
        case (funct3)
          3'h0: func_orv64_decode_id2ex_addiw(id2ex_ctrl);
          3'h1: begin
            if (funct7 == 7'h00) begin
              func_orv64_decode_id2ex_slliw(id2ex_ctrl);
            end else begin
              func_orv64_decode_id2ex_default(id2ex_ctrl);
              is_illegal_inst = 1'b1;
            end
          end
          3'h5:
            case (funct7)
              7'h00: func_orv64_decode_id2ex_srliw(id2ex_ctrl);
              7'h20: func_orv64_decode_id2ex_sraiw(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_OP_32: // {{{
        case (funct7)
          7'h00:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_addw(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_sllw(id2ex_ctrl);
              3'h5: func_orv64_decode_id2ex_srlw(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h20:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_subw(id2ex_ctrl);
              3'h5: func_orv64_decode_id2ex_sraw(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          `ifdef ORV64_SUPPORT_MULDIV
          7'h01:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_mulw(id2ex_ctrl);
              3'h4: func_orv64_decode_id2ex_divw(id2ex_ctrl);
              3'h5: func_orv64_decode_id2ex_divuw(id2ex_ctrl);
              3'h6: func_orv64_decode_id2ex_remw(id2ex_ctrl);
              3'h7: func_orv64_decode_id2ex_remuw(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          `endif // ORV64_SUPPORT_MULDIV
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_MISC_MEM: begin // {{{
        func_orv64_decode_id2ex_default(id2ex_ctrl);
      end // }}}
      `ifdef ORV64_SUPPORT_FP
      ORV64_LOAD_FP: // {{{
        case (funct3)
          3'h2: func_orv64_decode_id2ex_flw(id2ex_ctrl);
          3'h3: func_orv64_decode_id2ex_fld(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      // }}}
      ORV64_STORE_FP: // {{{
        case (funct3)
          3'h2: func_orv64_decode_id2ex_fsw(id2ex_ctrl);
          3'h3: func_orv64_decode_id2ex_fsd(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      // }}}
      ORV64_FMADD: // {{{
        case (funct2)
          2'h0: func_orv64_decode_id2ex_fmadd_s(id2ex_ctrl);
          2'h1: func_orv64_decode_id2ex_fmadd_d(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      // }}}
      ORV64_FMSUB: // {{{
        case (funct2)
          2'h0: func_orv64_decode_id2ex_fmsub_s(id2ex_ctrl);
          2'h1: func_orv64_decode_id2ex_fmsub_d(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      // }}}
      ORV64_FNMADD: // {{{
        case (funct2)
          2'h0: func_orv64_decode_id2ex_fnmadd_s(id2ex_ctrl);
          2'h1: func_orv64_decode_id2ex_fnmadd_d(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      // }}}
      ORV64_FNMSUB: // {{{
        case (funct2)
          2'h0: func_orv64_decode_id2ex_fnmsub_s(id2ex_ctrl);
          2'h1: func_orv64_decode_id2ex_fnmsub_d(id2ex_ctrl);
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      // }}}
      ORV64_OP_FP: // {{{
        case (funct7)
          7'h00: func_orv64_decode_id2ex_fadd_s(id2ex_ctrl);
          7'h04: func_orv64_decode_id2ex_fsub_s(id2ex_ctrl);
          7'h08: func_orv64_decode_id2ex_fmul_s(id2ex_ctrl);
          7'h0C: func_orv64_decode_id2ex_fdiv_s(id2ex_ctrl);
          7'h2C: func_orv64_decode_id2ex_fsqrt_s(id2ex_ctrl);
          7'h10:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fsgnj_s(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_fsgnjn_s(id2ex_ctrl);
              3'h2: func_orv64_decode_id2ex_fsgnjx_s(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h14:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fmin_s(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_fmax_s(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h50:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fle_s(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_flt_s(id2ex_ctrl);
              3'h2: func_orv64_decode_id2ex_feq_s(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h70:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fmv_x_s(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_fclass_s(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h78: func_orv64_decode_id2ex_fmv_s_x(id2ex_ctrl);
          7'h68:
            case (funct5)
              5'h00: func_orv64_decode_id2ex_fcvt_s_w(id2ex_ctrl);
              5'h01: func_orv64_decode_id2ex_fcvt_s_wu(id2ex_ctrl);
              5'h02: func_orv64_decode_id2ex_fcvt_s_l(id2ex_ctrl);
              5'h03: func_orv64_decode_id2ex_fcvt_s_lu(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h60:
            case (funct5)
              5'h00: func_orv64_decode_id2ex_fcvt_w_s(id2ex_ctrl);
              5'h01: func_orv64_decode_id2ex_fcvt_wu_s(id2ex_ctrl);
              5'h02: func_orv64_decode_id2ex_fcvt_l_s(id2ex_ctrl);
              5'h03: func_orv64_decode_id2ex_fcvt_lu_s(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase

          `ifdef ORV64_SUPPORT_FP_DOUBLE
          7'h01: func_orv64_decode_id2ex_fadd_d(id2ex_ctrl);
          7'h05: func_orv64_decode_id2ex_fsub_d(id2ex_ctrl);
          7'h09: func_orv64_decode_id2ex_fmul_d(id2ex_ctrl);
          7'h0D: func_orv64_decode_id2ex_fdiv_d(id2ex_ctrl);
          7'h2D: func_orv64_decode_id2ex_fsqrt_d(id2ex_ctrl);
          7'h11:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fsgnj_d(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_fsgnjn_d(id2ex_ctrl);
              3'h2: func_orv64_decode_id2ex_fsgnjx_d(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h15:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fmin_d(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_fmax_d(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h51:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fle_d(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_flt_d(id2ex_ctrl);
              3'h2: func_orv64_decode_id2ex_feq_d(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h71:
            case (funct3)
              3'h0: func_orv64_decode_id2ex_fmv_x_d(id2ex_ctrl);
              3'h1: func_orv64_decode_id2ex_fclass_d(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h79: func_orv64_decode_id2ex_fmv_d_x(id2ex_ctrl);
          7'h69:
            case (funct5)
              5'h00: func_orv64_decode_id2ex_fcvt_d_w(id2ex_ctrl);
              5'h01: func_orv64_decode_id2ex_fcvt_d_wu(id2ex_ctrl);
              5'h02: func_orv64_decode_id2ex_fcvt_d_l(id2ex_ctrl);
              5'h03: func_orv64_decode_id2ex_fcvt_d_lu(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h61:
            case (funct5)
              5'h00: func_orv64_decode_id2ex_fcvt_w_d(id2ex_ctrl);
              5'h01: func_orv64_decode_id2ex_fcvt_wu_d(id2ex_ctrl);
              5'h02: func_orv64_decode_id2ex_fcvt_l_d(id2ex_ctrl);
              5'h03: func_orv64_decode_id2ex_fcvt_lu_d(id2ex_ctrl);
              default: begin
                func_orv64_decode_id2ex_default(id2ex_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          7'h21: func_orv64_decode_id2ex_fcvt_d_s(id2ex_ctrl);
          7'h20: func_orv64_decode_id2ex_fcvt_s_d(id2ex_ctrl);
          `endif // ORV64_SUPPORT_FP_DOUBLE
          default: begin
            func_orv64_decode_id2ex_default(id2ex_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
        // }}}
      `endif // ORV64_SUPPORT_FP
      default: begin
        func_orv64_decode_id2ex_default(id2ex_ctrl);
        is_illegal_inst = 1'b1;
      end
    endcase
    id2ex_ctrl.is_rs1_fp = is_rs1_fp;
    id2ex_ctrl.is_rs2_fp = is_rs2_fp;
    id2ex_ctrl.is_aq_rl  = if2id_ctrl_ff.is_aq_rl;
    id2ex_ctrl.is_amo_load  = if2id_ctrl_ff.is_amo_load;
    id2ex_ctrl.is_amo_op    = if2id_ctrl_ff.is_amo_op;
    id2ex_ctrl.is_amo       = if2id_ctrl_ff.is_amo;
    id2ex_ctrl.is_amo_done  = if2id_ctrl_ff.is_amo_done;
    id2ex_ctrl.is_amo_mv    = if2id_ctrl_ff.is_amo_mv;
    id2ex_ctrl.is_amo_store = if2id_ctrl_ff.is_amo_store;
    if (id2ex_ctrl.is_aq_rl | id2ex_ctrl.is_amo_mv) begin
      id2ex_ctrl.rd_we = 1'b0;
    end
  end
  // }}}

  //------------------------------------------------------
  // jal
  logic is_jal_inst;
  logic hold_id2if_kill_ff, clear_id2if_npc_valid;
  orv64_vaddr_t id2if_pc_saved_ff;

  assign is_jal_inst = (opcode == ORV64_JAL) & if_valid_ff & ~id_kill;

  always @(posedge clk) begin
    if (rst) begin
      hold_id2if_kill_ff <= 1'b0;
      clear_id2if_npc_valid <= 1'b0;
    end
    else begin
      hold_id2if_kill_ff <= (id2if_kill & ~if_ready);
      if (~clear_id2if_npc_valid & id2if_npc.valid & if_ready)
        clear_id2if_npc_valid <= '1; // clear kill signal after its accepted
      else if (clear_id2if_npc_valid & if_valid & id_ready)
        clear_id2if_npc_valid <= '0;
    end
  end

  always_ff @(posedge clk) begin
    if (id2if_npc.valid) begin
      id2if_pc_saved_ff <= id2if_npc.pc;
    end
  end

  assign  id2if_npc.pc = hold_id2if_kill_ff ? id2if_pc_saved_ff : if2id_ff.pc + j_imm;
  assign  id2if_npc_valid_pre = hold_id2if_kill_ff | (is_jal_inst & id_valid & ~clear_id2if_npc_valid);
  assign  is_misaligned_if_addr = (id2if_npc.pc[0] != 1'b0) & id2if_npc_valid_pre;
  assign  id2if_npc.valid = id2if_npc_valid_pre & ~id2ex_excp.valid;
  assign  id2if_kill = id2if_npc.valid;

  // }}}

  //------------------------------------------------------
  // fence
  assign is_fence_inst = (opcode == ORV64_MISC_MEM) & ((funct3 == 3'h0) | (funct3 == 3'h1)) & if_valid_ff & ~id_kill;
  assign wait_for_fence_accept = rff_new_fence_req ? ~(id2ic_fence_req_valid & ic2id_fence_req_ready): '0;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_new_fence_req <= '0;
    end else begin
      if (rff_new_fence_req) begin
        rff_new_fence_req <= (id2ic_fence_req_valid & ic2id_fence_req_ready) ? '0: '1;
      end
      else if (/*if_valid & id_ready & */is_fence_inst) begin
        rff_new_fence_req <= '1;
      end
    end
  end
/*
  always_ff @(posedge clk) begin
    if (rst) begin
      rff_new_fence_req <= '0;
    end else begin
      if (if_valid & id_ready) begin
        rff_new_fence_req <= '1;
      end else if (rff_new_fence_req) begin
        rff_new_fence_req <= (id2ic_fence_req_valid & ic2id_fence_req_ready) ? '0: '1;
      end
    end
  end
*/
  always_comb begin
    if (is_fence_inst) begin
      wait_for_fence = wait_for_fence_accept;
    end else begin
      wait_for_fence = '0;
    end
  end

  assign id2ic_fence_req_valid = rff_new_fence_req;//is_fence_inst ? rff_new_fence_req: '0;
  assign id2ic_fence_req.req_is_fence = '1;
  assign id2ic_fence_resp_ready = '1;

  //------------------------------------------------------
  // sfence
  assign do_trap_sfence = mstatus.TVM & (prv == ORV64_PRV_S);
  assign is_sfence_inst = (opcode == ORV64_SYSTEM) & (funct7 == 7'h09) & (funct3 == 3'h0) & (rd_addr == 5'h00) & if_valid_ff & ~id_kill & ~do_trap_sfence;

  always_comb begin
    id2itlb_flush_req.req_flush_asid = id2ex.rs2;
    id2itlb_flush_req.req_flush_vpn = (id2ex.rs1 >> ORV64_PAGE_OFFSET_WIDTH);
    if ((id2itlb_flush_req.req_flush_asid != '0) & (id2itlb_flush_req.req_flush_vpn != '0)) begin
      id2itlb_flush_req.req_sfence_type = ORV64_SFENCE_ASID_VPN;
    end else if ((id2itlb_flush_req.req_flush_asid != '0) & (id2itlb_flush_req.req_flush_vpn == '0)) begin
      id2itlb_flush_req.req_sfence_type = ORV64_SFENCE_ASID;
    end else if ((id2itlb_flush_req.req_flush_asid == '0) & (id2itlb_flush_req.req_flush_vpn != '0)) begin
      id2itlb_flush_req.req_sfence_type = ORV64_SFENCE_VPN;
    end else begin
      id2itlb_flush_req.req_sfence_type = ORV64_SFENCE_ALL;
    end
  end

  assign id2itlb_flush_req_valid = is_sfence_inst & (id_valid & ex_ready_masked);

  //------------------------------------------------------
  // Operations on mmu csrs

  logic is_csr_op_on_mmu;
  assign csr_addr = orv64_csr_addr_t'(funct12);
  always_comb begin
    if (opcode == ORV64_SYSTEM) begin
      case (funct3)
        3'h1, 3'h2, 3'h3, 3'h4, 3'h5, 3'h6, 3'h7: begin
          case (csr_addr)
            ORV64_CSR_ADDR_MSTATUS,            
            ORV64_CSR_ADDR_SSTATUS,
            ORV64_CSR_ADDR_SATP: begin
              is_csr_op_on_mmu = '1;
            end
            default: begin
              is_csr_op_on_mmu = '0;
            end
          endcase
        end
        default: begin
          is_csr_op_on_mmu = '0;
        end
      endcase
    end else begin
      is_csr_op_on_mmu = '0;
    end
  end

  assign id2ib_flush_req_valid = id2itlb_flush_req_valid | (is_csr_op_on_mmu & if_valid_ff & ~id_kill);


  //==========================================================
  // Read RS1/RS2 and bypass {{{

  //------------------------------------------------------
  // if INST is integer or floating point: used as regfile reading enable
  `ifdef ORV64_SUPPORT_FP
  always_comb begin
    // is_rs1_fp
    case (opcode)
      ORV64_FMADD, ORV64_FMSUB, ORV64_FNMADD, ORV64_FNMSUB: begin
        is_rs1_fp = 1'b1;
      end
      ORV64_OP_FP: begin
        case (funct7)
          7'h78, 7'h79, 7'h68, 7'h69: is_rs1_fp = 1'b0;
          default: is_rs1_fp = 1'b1;
        endcase
      end
      default: is_rs1_fp = 1'b0;
    endcase
    // is_rs2_fp
    case (opcode)
      ORV64_STORE_FP, ORV64_FMADD, ORV64_FMSUB, ORV64_FNMADD, ORV64_FNMSUB: is_rs2_fp = 1'b1;
      ORV64_OP_FP:
        case (funct7)
          7'h20, 7'h21, 7'h2C, 7'h2D,
          7'h60, 7'h61, 7'h68, 7'h69,
          7'h70, 7'h71: is_rs2_fp = 1'b0;
          default: is_rs2_fp = 1'b1;
        endcase
      default: is_rs2_fp = 1'b0;
    endcase
  end
  `else // ORV64_SUPPORT_FP
  assign is_rs1_fp = 1'b0;
  assign is_rs2_fp = 1'b0;
  `endif // ORV64_SUPPORT_FP

  assign  is_rs1_x0 = (rs1_addr == 'b0) & ~is_rs1_fp;
  assign  is_rs2_x0 = (rs2_addr == 'b0) & ~is_rs2_fp;

  //------------------------------------------------------
  // if RS1/RS2/RS3 is valid
  always_comb begin
    // rs1_re?
    case (opcode)
      ORV64_AMO: rs1_re = 1'b1;
      ORV64_OP_IMM, ORV64_OP, ORV64_JALR, ORV64_BRANCH, ORV64_LOAD, ORV64_STORE, ORV64_OP_IMM_32, ORV64_OP_32: rs1_re = 1'b1;
      ORV64_SYSTEM: begin
        if (funct7 == 7'h09) begin // sfence
          rs1_re = 1'b1;
        end else begin
          case (funct3)
            3'h1, 3'h2, 3'h3: rs1_re = 1'b1; // load & store
            default: rs1_re = 'b0;
          endcase
        end
      end
      `ifdef ORV64_SUPPORT_FP
      ORV64_LOAD_FP, ORV64_STORE_FP, ORV64_OP_FP, ORV64_FMADD, ORV64_FMSUB, ORV64_FNMADD, ORV64_FNMSUB: rs1_re = 1'b1;
      `endif
      default: rs1_re = 'b0;
    endcase
    // rs2_re?
    case (opcode)
      ORV64_AMO: rs2_re = 1'b1;
      ORV64_OP, ORV64_BRANCH, ORV64_STORE, ORV64_OP_32: rs2_re = 1'b1;
      `ifdef ORV64_SUPPORT_FP
      ORV64_STORE_FP, ORV64_FMADD, ORV64_FMSUB, ORV64_FNMADD, ORV64_FNMSUB: rs2_re = 1'b1;
      ORV64_OP_FP:
        case (funct7)
          7'h20, 7'h21, 7'h2C, 7'h2D,
          7'h60, 7'h61, 7'h68, 7'h69,
          7'h70, 7'h71, 7'h78, 7'h79: rs2_re = 1'b0;
          default: rs2_re = 1'b1;
        endcase
      `endif
      ORV64_SYSTEM: begin
        if (funct7 == 7'h09) begin // sfence
          rs2_re = 1'b1;
        end else begin
          rs2_re = 1'b0;
        end
      end
      default: rs2_re = 'b0;
    endcase
    // rs3_re?
`ifdef ORV64_SUPPORT_FP
    case (opcode)
      ORV64_FMADD, ORV64_FMSUB, ORV64_FNMADD, ORV64_FNMSUB: rs3_re = 1'b1;
      default: rs3_re = 1'b0;
    endcase
`else
    rs3_re = 1'b0;
`endif
  end

  //==========================================================
  // Check if is fp instr {{{
    always_comb begin
    case (opcode) 
      ORV64_LOAD_FP,
      ORV64_STORE_FP,
      ORV64_FMADD,
      ORV64_FMSUB,
      ORV64_FNMADD,
      ORV64_FNMSUB,
      ORV64_OP_FP: is_fp_instr = '1;
      default: is_fp_instr = '0;
    endcase
  end
  //------------------------------------------------------
  // read reg
  // assign  is_rs1_fp = if2id_ctrl_ff.is_rs1_fp;
  // assign  is_rs2_fp = if2id_ctrl_ff.is_rs2_fp;
  assign  is_rd_fp = id2ex_ctrl.is_rd_fp;
  // assign  rs1_re = if2id_ctrl_ff.rs1_re;
  // assign  rs2_re = if2id_ctrl_ff.rs2_re;
  // assign  rs3_re = if2id_ctrl_ff.rs3_re;
  // assign  is_rs1_x0 = if2id_ctrl_ff.is_rs1_x0;
  // assign  is_rs2_x0 = if2id_ctrl_ff.is_rs2_x0;
  assign  is_rd_x0 = ~is_rd_fp & (rd_addr == 'b0);

  assign  id2irf.rs1_addr = rs1_addr;
  assign  id2irf.rs2_addr = rs2_addr;
  assign  id2irf.rs1_re = ~is_rs1_fp & rs1_re & ~is_rs1_x0 & id_valid & ex_ready;
  assign  id2irf.rs2_re = ~is_rs2_fp & rs2_re & ~is_rs2_x0 & id_valid & ex_ready;

  assign  rs1_is_fp = is_rs1_fp & rs1_re & ~is_rs1_x0;
  assign  rs2_is_fp = is_rs2_fp & rs2_re & ~is_rs2_x0;
  assign  fp_access_excp = (mstatus.FS == 2'b00) & (is_fp_instr) & id_valid;

  `ifdef ORV64_SUPPORT_FP
  assign  if2fprf.rs1_addr = rs1_addr;
  assign  if2fprf.rs2_addr = rs2_addr;
  assign  if2fprf.rs3_addr = rs3_addr;
  assign  if2fprf.rs1_re = is_rs1_fp & rs1_re & id_valid & ex_ready & ~fp_access_excp;
  assign  if2fprf.rs2_re = is_rs2_fp & rs2_re & id_valid & ex_ready & ~fp_access_excp;
  assign  if2fprf.rs3_re = rs3_re & id_valid & ex_ready;
  `endif // ORV64_SUPPORT_FP
  // }}}

//--------------------------------------------------------------------------------------------------------
  // select integer or floating-point
  orv64_data_t  rs1_rf, rs2_rf, rs3_rf, rs3;

`ifdef ORV64_SUPPORT_FP
  assign  rs1_rf = is_rs1_fp ? fprf2id.rs1 : (is_rs1_x0 ? 64'b0 : irf2id.rs1);
  assign  rs2_rf = is_rs2_fp ? fprf2id.rs2 : (is_rs2_x0 ? 64'b0 : irf2id.rs2);
  assign  rs3_rf = fprf2id.rs3;
`else
  assign  rs1_rf = is_rs1_x0 ? 64'b0 : irf2id.rs1;
  assign  rs2_rf = is_rs2_x0 ? 64'b0 : irf2id.rs2;
  assign  rs3_rf = '0;
`endif

  //------------------------------------------------------
  // regfile scoreboard
  // flag bits determin wether corresponding register is being processed in
  // later stage, and ID has to wait for its latest value
  // bit-0 is IRF, bit-1 is FPRF
  logic [31:0] [1:0]  scoreboard;


  // set/clear flag
  logic       scb_set_en, scb_set_sel;
  orv64_reg_addr_t  scb_set_addr;
  assign  scb_set_en = id2ex_ctrl.rd_we & ex_ready_masked & ~is_rd_x0 & id_valid & ~id_kill;
  assign  scb_set_sel = is_rd_fp;
  assign  scb_set_addr = rd_addr;

  logic       scb_clear_en_ma, scb_clear_sel_ma;
  orv64_reg_addr_t  scb_clear_addr_ma;



  assign  scb_clear_en_ma = (ma2irf.rd_we | ma2fprf.rd_we) & ~(((ex2id_bps.rd_addr == ma2id_bps.rd_addr) & ex2id_bps.valid_addr) & (ex2id_bps.is_rd_fp == ma2id_bps.is_rd_fp) & ~({ex_valid, ex_ready} == 2'b01)) & ~(({scb_clear_addr_ma, scb_clear_sel_ma} == {scb_set_addr, scb_set_sel}) & scb_set_en);
//`endif
  assign  scb_clear_sel_ma = ma2fprf.rd_we;
  assign  scb_clear_addr_ma = (ma2irf.rd_we ? ma2irf.rd_addr : ma2fprf.rd_addr);



  logic       scb_kill_en, scb_kill_sel;
  orv64_reg_addr_t  scb_kill_addr;

  assign      scb_kill_en = id_kill;
  assign      scb_kill_sel = id2ex_ctrl_ff.is_rd_fp;
  assign      scb_kill_addr = (ma2id_bps.rd_addr == ex2id_kill_addr) ? '0: ex2id_kill_addr;

  logic scb_clkg, en_scb;

  assign en_scb = rst | cs2id_scb_rst | scb_clear_en_ma | scb_set_en | scb_kill_en;

  icg scb_clk_u(
    .en       (en_scb),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (scb_clkg)
  );

  always_ff @ (posedge scb_clkg) begin
    if (rst) begin
      scoreboard <= '{default:0};
    end else if (cs2id_scb_rst) begin
      scoreboard <= '{default:0};

    end else begin
      if (en_scb) begin
        if (scb_clear_en_ma) begin
          scoreboard[scb_clear_addr_ma][scb_clear_sel_ma] <= 1'b0;
        end

        if (scb_set_en) begin
          scoreboard[scb_set_addr][scb_set_sel] <= 1'b1;
        end
        if (scb_kill_en) begin
          scoreboard[scb_kill_addr][scb_kill_sel] <= 1'b0;
        end
      end
    end
  end

`ifndef SYNTHESIS

  orv_clear_zero_scoreboard: assert property (@(posedge clk) disable iff (rst === '1) ((scb_clear_en_ma & (~(scb_clear_addr_ma == 5'h00) & ~(scb_clear_sel_ma == 2'b01))) |-> (scoreboard[scb_clear_addr_ma][scb_clear_sel_ma] == 1'b1))) 
    else `olog_info("ORV_DECODE", $sformatf("%m: scb_clear_addr=%h scb_clear_sel=%h", scb_clear_addr_ma, scb_clear_sel_ma));

`endif

  // read flag
  logic   rs1_busy, rs2_busy, rs3_busy, rd_busy, reg_busy;
  assign  rs1_busy = (|(scoreboard[rs1_addr] & (is_rs1_fp ? 2'b10 : 2'b01))) & ~cs2id_scb_rst & ~is_rs1_x0 & rs1_re & if_valid_ff & ~id2ex_ctrl.is_amo_op;
  assign  rs2_busy = (|(scoreboard[rs2_addr] & (is_rs2_fp ? 2'b10 : 2'b01))) & ~cs2id_scb_rst & ~is_rs2_x0 & rs2_re & if_valid_ff & ~id2ex_ctrl.is_amo_op;
  assign  rs3_busy = scoreboard[rs3_addr][1] & ~cs2id_scb_rst & rs3_re & if_valid_ff;
  assign  rd_busy  = (|(scoreboard[rd_addr] & (2'b00) & (is_rd_fp ? 2'b10 : 2'b01))) & ~cs2id_scb_rst & ~is_rd_x0 & (id2ex_ctrl.rd_we) & if_valid_ff;


  // bypass
  logic ex_bps_match_rs1, ma_bps_match_rs1, wb_bps_match_rs1,
        ex_bps_match_rs2, ma_bps_match_rs2, wb_bps_match_rs2,
        ex_bps_match_rs3, ma_bps_match_rs3, wb_bps_match_rs3;

  logic wait_for_rs1, wait_for_rs2, wait_for_rs3, wait_for_rd;

  // assign ex_bps_match_rs1 = ~is_rs1_x0 & rs1_re & (ex2id_bps.rd_addr == rs1_addr) & (ex2id_bps.is_rd_fp == is_rs1_fp) & ex2id_bps.valid;
  // assign ma_bps_match_rs1 = ~is_rs1_x0 & rs1_re & (ma2id_bps.rd_addr == rs1_addr) & (ma2id_bps.is_rd_fp == is_rs1_fp) & ma2id_bps.valid;
  // assign wb_bps_match_rs1 = ~is_rs1_x0 & rs1_re & (wb2id_bps.rd_addr == rs1_addr) & (wb2id_bps.is_rd_fp == is_rs1_fp) & wb2id_bps.valid;

  // assign ex_bps_match_rs2 = ~is_rs2_x0 & rs2_re & (ex2id_bps.rd_addr == rs2_addr) & (ex2id_bps.is_rd_fp == is_rs2_fp) & ex2id_bps.valid;
  // assign ma_bps_match_rs2 = ~is_rs2_x0 & rs2_re & (ma2id_bps.rd_addr == rs2_addr) & (ma2id_bps.is_rd_fp == is_rs2_fp) & ma2id_bps.valid;
  // assign wb_bps_match_rs2 = ~is_rs2_x0 & rs2_re & (wb2id_bps.rd_addr == rs2_addr) & (wb2id_bps.is_rd_fp == is_rs2_fp) & wb2id_bps.valid;

  // assign ex_bps_match_rs3 = rs3_re & (ex2id_bps.rd_addr == rs3_addr) & ex2id_bps.is_rd_fp & ex2id_bps.valid;
  // assign ma_bps_match_rs3 = rs3_re & (ma2id_bps.rd_addr == rs3_addr) & ma2id_bps.is_rd_fp & ma2id_bps.valid;
  // assign wb_bps_match_rs3 = rs3_re & (wb2id_bps.rd_addr == rs3_addr) & wb2id_bps.is_rd_fp & wb2id_bps.valid;

  assign ex_bps_match_rs1 = (id2ex_ctrl.is_amo_op ? '1: ~is_rs1_x0) & rs1_re & ex2id_bps.valid_addr & (ex2id_bps.rd_addr == rs1_addr) & (ex2id_bps.is_rd_fp == is_rs1_fp);
  assign ma_bps_match_rs1 = (id2ex_ctrl.is_amo_op ? '1: ~is_rs1_x0) & rs1_re & ma2id_bps.valid_addr & (ma2id_bps.rd_addr == rs1_addr) & (ma2id_bps.is_rd_fp == is_rs1_fp);
//   assign wb_bps_match_rs1 = ~is_rs1_x0 & rs1_re & (wb2id_bps.rd_addr == rs1_addr) & (wb2id_bps.is_rd_fp == is_rs1_fp);

  assign ex_bps_match_rs2 = (id2ex_ctrl.is_amo_op ? '1: ~is_rs2_x0) & rs2_re & ex2id_bps.valid_addr & (ex2id_bps.rd_addr == rs2_addr) & (ex2id_bps.is_rd_fp == is_rs2_fp);
  assign ma_bps_match_rs2 = (id2ex_ctrl.is_amo_op ? '1: ~is_rs2_x0) & rs2_re & ma2id_bps.valid_addr & (ma2id_bps.rd_addr == rs2_addr) & (ma2id_bps.is_rd_fp == is_rs2_fp);
//   assign wb_bps_match_rs2 = ~is_rs2_x0 & rs2_re & (wb2id_bps.rd_addr == rs2_addr) & (wb2id_bps.is_rd_fp == is_rs2_fp);

  assign ex_bps_match_rs3 = rs3_re & (ex2id_bps.rd_addr == rs3_addr) & ex2id_bps.is_rd_fp;
  assign ma_bps_match_rs3 = rs3_re & (ma2id_bps.rd_addr == rs3_addr) & ma2id_bps.is_rd_fp;
//   assign wb_bps_match_rs3 = rs3_re & (wb2id_bps.rd_addr == rs3_addr) & wb2id_bps.is_rd_fp;

  always_comb
  begin
  
    if (rs1_busy) begin
        wait_for_rs1 = 1'b0;
        id2ex.rs1 = 'b0;
        if (ex_bps_match_rs1)
          if (ex2id_bps.valid_data)
            id2ex.rs1 = ex2id_bps.rd;
          else
            wait_for_rs1 = 1'b1;
       else if (ma_bps_match_rs1)
         if (ma2id_bps.valid_data)
           id2ex.rs1 = ma2id_bps.rd;
         else
           wait_for_rs1 = 1'b1;
  //       else if (wb_bps_match_rs1)
  //         if (wb2id_bps.valid_data)
  //           id2ex.rs1 = wb2id_bps.rd;
  //         else
  //           wait_for_rs1 = 1'b1;
        else
          wait_for_rs1 = 1'b1;
//      end
    end else begin
      id2ex.rs1 = rs1_rf;
      wait_for_rs1 = 1'b0;
    end
    
  end
  
  always_comb
    if (rs2_busy) begin
        wait_for_rs2 = 1'b0;
        id2ex.rs2 = 'b0;
        if (ex_bps_match_rs2)
          if (ex2id_bps.valid_data)
            id2ex.rs2 = ex2id_bps.rd;
          else
            wait_for_rs2 = 1'b1;
        else if (ma_bps_match_rs2)
          if (ma2id_bps.valid_data)
            id2ex.rs2 = ma2id_bps.rd;
          else
            wait_for_rs2 = 1'b1;
  //       else if (wb_bps_match_rs2)
  //         if (wb2id_bps.valid_data)
  //           id2ex.rs2 = wb2id_bps.rd;
  //         else
  //           wait_for_rs2 = 1'b1;
        else
          wait_for_rs2 = 1'b1;
//      end
    end else begin
      id2ex.rs2 = rs2_rf;
      wait_for_rs2 = 1'b0;
    end

  always_comb
    if (rs3_busy) begin
      wait_for_rs3 = 1'b0;
      rs3 = 'b0;
      if (ex_bps_match_rs3)
        if (ex2id_bps.valid_data)
          rs3 = ex2id_bps.rd;
        else
          wait_for_rs3 = 1'b1;
      else if (ma_bps_match_rs3)
        if (ma2id_bps.valid_data)
          rs3 = ma2id_bps.rd;
        else
          wait_for_rs3 = 1'b1;
//       else if (wb_bps_match_rs3)
//         if (wb2id_bps.valid_data)
//           rs3 = wb2id_bps.rd;
//         else
//           wait_for_rs3 = 1'b1;
      else
        wait_for_rs3 = 1'b1;
    end else begin
      rs3 = rs3_rf;
      wait_for_rs3 = 1'b0;
    end

  logic is_fp_inst;
  logic use_fp_rounding, invalid_fp_rounding;
  assign invalid_fp_rounding = 'b1;
  
  always_comb begin
    case (opcode)
      ORV64_FMADD, 
      ORV64_FMSUB, 
      ORV64_FNMADD,
      ORV64_FNMSUB: begin
        use_fp_rounding = '1;
      end
      ORV64_OP_FP: begin
        case (funct7)
          7'h78,
          7'h10,
          7'h14,
          7'h50,
          7'h70: use_fp_rounding = '0;
`ifdef ORV64_SUPPORT_FP_DOUBLE
          7'h11,
          7'h15,
          7'h51,
          7'h71,
          7'h79: use_fp_rounding = '0;
`endif
          default: begin
            use_fp_rounding = '1;
          end
        endcase
      end
      default: begin
        use_fp_rounding = '0;
      end
    endcase
  end

  assign is_fp_inst = if_valid_ff & (
                      (opcode == ORV64_LOAD_FP) |
                      (opcode == ORV64_STORE_FP) |
                      (opcode == ORV64_OP_FP) |
                      (opcode == ORV64_FMADD) |
                      (opcode == ORV64_FMSUB) |
                      (opcode == ORV64_FNMADD) |
                      (opcode == ORV64_FNMSUB));


  assign wait_for_rd = rd_busy;

  // wait signal
  // assign  wait_for_reg = wait_for_rs1 | wait_for_rs2 | wait_for_rs3 | rd_busy;
  //assign id_wait_for_reg = (wait_for_rs1) | (wait_for_rs2) | (wait_for_rs3) | wait_for_rd;
  // MA2EX_FORWARDING begin
  assign id_wait_for_reg = ((is_fp_inst) & wait_for_rs1) | ((is_fp_inst) & wait_for_rs2) | (wait_for_rs3) | wait_for_rd;
  // MA2EX_FORWARDING end

  //==========================================================
  // select imm {{{
  orv64_data_t imm;
  always_comb
    case (id2ex_ctrl.imm_sel)
      ORV64_IMM_SEL_I: imm = i_imm;
      ORV64_IMM_SEL_S: imm = s_imm;
      ORV64_IMM_SEL_B: imm = b_imm;
      ORV64_IMM_SEL_U: imm = u_imm;
      ORV64_IMM_SEL_J: imm = j_imm;
      ORV64_IMM_SEL_Z: imm = z_imm;
      ORV64_IMM_SEL_F0: imm = {{32{1'b1}}, 32'b0};
      default: imm = 64'b0;
    endcase
  // }}}
  // }}}

  //==========================================================
  // MULDIV {{{
`ifdef ORV64_SUPPORT_MULDIV

  // same RS1/RS2?
  logic       is_same_rs1, is_same_rs2;
  orv64_reg_addr_t  rs1_addr_ff, rs2_addr_ff;
  orv64_mul_type_t  mul_type_ff;
  orv64_div_type_t  div_type_ff;
  always_ff @ (posedge clk) begin
    if (id_valid & ex_ready_masked) begin
      rs1_addr_ff <= rs1_addr;
      rs2_addr_ff <= rs2_addr;
      mul_type_ff <= id2ex_ctrl.mul_type;
      div_type_ff <= id2ex_ctrl.div_type;
    end
  end
  assign  is_same_rs1 = (rs1_addr_ff == rs1_addr);
  assign  is_same_rs2 = (rs2_addr_ff == rs2_addr);

  // same MUL type?
  logic is_prev_mul_h, is_same_mul_type;
  assign is_prev_mul_h = (mul_type_ff == ORV64_MUL_TYPE_HSS) | (mul_type_ff == ORV64_MUL_TYPE_HUU) | (mul_type_ff == ORV64_MUL_TYPE_HSU);
  assign is_same_mul_type = is_prev_mul_h & (id2ex_ctrl.mul_type == ORV64_MUL_TYPE_L);
  //assign id2mul.is_same = is_same_rs1 & is_same_rs2 & is_same_mul_type; // Incomplete optimization. Should check that rd isn't the same as either rs
  assign id2mul.is_same = '0;
  assign id2mul.en = (id_valid & ~id2mul.is_same & id2ex_ctrl.mul_type != ORV64_MUL_TYPE_NONE);
  assign id2mul.rs1 = id2ex.rs1;
  assign id2mul.rs2 = id2ex.rs2;

  // same DIV type?
  logic is_same_div_type_s, is_same_div_type_u, is_same_div_type_w, is_same_div_type_uw, is_same_div_type;
  assign is_same_div_type_s = (div_type_ff == ORV64_DIV_TYPE_Q) & (id2ex_ctrl.div_type == ORV64_DIV_TYPE_R);
  assign is_same_div_type_u = (div_type_ff == ORV64_DIV_TYPE_QU) & (id2ex_ctrl.div_type == ORV64_DIV_TYPE_RU);
  assign is_same_div_type_w = (div_type_ff == ORV64_DIV_TYPE_QW) & (id2ex_ctrl.div_type == ORV64_DIV_TYPE_RW);
  assign is_same_div_type_uw = (div_type_ff == ORV64_DIV_TYPE_QUW) & (id2ex_ctrl.div_type == ORV64_DIV_TYPE_RUW);
  assign is_same_div_type = is_same_div_type_s | is_same_div_type_u | is_same_div_type_w | is_same_div_type_uw;
  //assign id2div.is_same = is_same_rs1 & is_same_rs2 & is_same_div_type;// Incomplete optimization. Should check that rd isn't the same as either rs
  assign id2div.is_same = '0;
  assign id2div.en = (id_valid & ~id2div.is_same & id2ex_ctrl.div_type != ORV64_DIV_TYPE_NONE);
  assign id2div.rs1 = id2ex.rs1;
  assign id2div.rs2 = id2ex.rs2;

`endif // ORV64_SUPPORT_MULDIV
  // }}}

  //==========================================================
  // FPU {{{
`ifdef ORV64_SUPPORT_FP
  orv64_data_t  fp_rs1, fp_rs2, fp_rs3;

  orv64_data_t  fp_rs1_inv, fp_rs2_inv, fp_rs3_inv;
  assign  fp_rs1_inv = func_fp_inv(id2ex.rs1, id2ex_ctrl.is_32);
  assign  fp_rs2_inv = func_fp_inv(id2ex.rs2, id2ex_ctrl.is_32);
  assign  fp_rs3_inv = func_fp_inv(rs3, id2ex_ctrl.is_32);

  always_comb begin
    case (id2ex_ctrl.fp_rs1_sel)
      ORV64_FP_RS1_SEL_RS1_INV: begin
        if (id2ex_ctrl.is_32) begin
          fp_rs1 = (&fp_rs1_inv[63:32]) ? fp_rs1_inv: {{32{1'b1}},32'h7FC00000};
        end else begin
          fp_rs1 = fp_rs1_inv;
        end
      end
      default: begin
        if (id2ex_ctrl.is_32 & is_rs1_fp) begin
          fp_rs1 = (&id2ex.rs1[63:32]) ? id2ex.rs1: {{32{1'b1}},32'h7FC00000};
        end else begin
          fp_rs1 = id2ex.rs1;
        end
      end
    endcase
  end

  always_comb begin
    case (id2ex_ctrl.fp_rs2_sel)
      ORV64_FP_RS2_SEL_RS2_INV: begin
        if (id2ex_ctrl.is_32) begin
          fp_rs2 = (&fp_rs2_inv[63:32]) ? fp_rs2_inv: {{32{1'b1}},32'h7FC00000};
        end else begin
          fp_rs2 = fp_rs2_inv;
        end
      end
      default: begin
        if (id2ex_ctrl.is_32 & is_rs2_fp) begin
          fp_rs2 = (&id2ex.rs2[63:32]) ? id2ex.rs2: {{32{1'b1}},32'h7FC00000};
        end else begin
          fp_rs2 = id2ex.rs2;
        end
      end
    endcase
  end

  always_comb begin
    case (id2ex_ctrl.fp_rs3_sel)
      ORV64_FP_RS3_SEL_RS3_INV: begin
        if (id2ex_ctrl.is_32) begin
          fp_rs3 = (&fp_rs3_inv[63:32]) ? fp_rs3_inv: {{32{1'b1}},32'h7FC00000};
        end else begin
          fp_rs3 = fp_rs3_inv;
        end
      end
      ORV64_FP_RS3_SEL_ZERO: fp_rs3 = 64'b0;
      default: begin
        if (id2ex_ctrl.is_32) begin
          fp_rs3 = (&rs3[63:32]) ? rs3: {{32{1'b1}},32'h7FC00000};
        end else begin
          fp_rs3 = rs3;
        end
      end
    endcase
  end



  // dynamic rounding mode
  orv64_frm_t   frm_real;
  assign  frm_real = (frm == 3'b111) ? frm_csr : frm;

  // DesignWare Rouding Mode
  orv64_frm_dw_t  frm_dw;
  always_comb begin
    invalid_fp_rounding = '0;
    case (frm_real)
      ORV64_FRM_RNE: frm_dw = ORV64_FRM_DW_RNE;
      ORV64_FRM_RTZ: frm_dw = ORV64_FRM_DW_RTZ;
      ORV64_FRM_RDN: frm_dw = ORV64_FRM_DW_RDN;
      ORV64_FRM_RUP: frm_dw = ORV64_FRM_DW_RUP;
      ORV64_FRM_RMM: frm_dw = ORV64_FRM_DW_RMM;
      default: begin
        frm_dw = ORV64_FRM_DW_RNE;
        invalid_fp_rounding = '1;
      end
    endcase
  end

`ifndef SYNTHESIS
  assert_nan_boxing_rs1: assert property (@(posedge clk) disable iff (rst === '0) (id2ex_ctrl.is_32 & rs1_re & is_rs1_fp) |-> (id2ex.rs1[63:32] == {32{1'b1}}));
  assert_nan_boxing_rs2: assert property (@(posedge clk) disable iff (rst === '0) (id2ex_ctrl.is_32 & rs2_re & is_rs2_fp) |-> (id2ex.rs2[63:32] == {32{1'b1}}));
  assert_nan_boxing_rs3: assert property (@(posedge clk) disable iff (rst === '0) (id2ex_ctrl.is_32 & rs3_re) |-> (rs3[63:32] == {32{1'b1}}));
  assert_rounding_mode: assert property (@(posedge clk) disable iff (rst === '0) ((id2ex_ctrl.fp_op != ORV64_FP_OP_NONE) & id_valid) |-> (frm_real inside {ORV64_FRM_RNE, ORV64_FRM_RTZ, ORV64_FRM_RDN, ORV64_FRM_RUP, ORV64_FRM_RMM})) else `olog_fatal("ORV_DECODE", $sformatf("illegal rounding mode 'b%b", frm_real));
`endif

`endif // ORV64_SUPPORT_FP
  // }}}

  //==========================================================
  // exception {{{
  always_comb begin
    id2ex_excp.inst = if2id_excp_ff.inst;
    if (id_kill) begin
      id2ex_excp.valid = 1'b0;
      id2ex_excp.is_half1 = 1'b0;
      id2ex_excp.cause = ORV64_EXCP_CAUSE_NONE;
    end else begin
      case (1'b1)
        (if2id_excp_ff.valid): begin
          id2ex_excp.valid = 1'b1;
          id2ex_excp.is_half1 = if2id_excp_ff.is_half1;
          id2ex_excp.cause = if2id_excp_ff.cause;
        end
        (is_illegal_inst | is_inst_lsb_not_11): begin
          id2ex_excp.valid = 1'b1;
          id2ex_excp.is_half1 = 1'b0;
          id2ex_excp.cause = ORV64_EXCP_CAUSE_ILLEGAL_INST;
        end
        (use_fp_rounding & invalid_fp_rounding): begin
          id2ex_excp.valid = 1'b1;
          id2ex_excp.is_half1 = 1'b0;
          id2ex_excp.cause = ORV64_EXCP_CAUSE_ILLEGAL_INST;
        end
        is_misaligned_if_addr: begin
          id2ex_excp.valid = 1'b1;
          id2ex_excp.is_half1 = 1'b0;
          id2ex_excp.cause = ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED;
        end
        default: begin
          id2ex_excp.valid = 1'b0;
          id2ex_excp.is_half1 = 1'b0;
          id2ex_excp.cause = if2id_excp_ff.cause;
        end
      endcase
    end
  end
  // }}}

  //==========================================================
  // pipeline ctrl {{{
  assign id_valid = ~id_kill & if_valid_ff & ~id_wait_for_reg & ~wait_for_fence & ~hold_id2if_kill_ff;
  assign id_ready = (ex_ready_masked | ~id_valid) & ~id_wait_for_reg & ~wait_for_fence & ~hold_id2if_kill_ff;
  assign ex_ready_masked = ex_ready & ~id_stall;

  assign id_is_stable_stall = id_valid & ~id_ready;

  assign id2da.id_wait_for_reg = id_wait_for_reg;
  assign id2da.wait_for_fence = wait_for_fence;
  assign id_inst = id2ex.inst;

  always_ff @ (posedge clk)
    if (rst)
      id_valid_ff <= 1'b0;
    else if (ex_ready)
      id_valid_ff <= id_valid & ~id_stall;

  `ifndef SYNTHESIS
    logic [63:0] id_status;
    always_comb
      case ({id_valid, id_ready})
        2'b00: id_status = "BUSY";
        2'b01: id_status = "IDLE";
        2'b10: id_status = "BLOCK";
        2'b11: id_status = "DONE";
        default: id_status = 64'bx;
      endcase
  `endif
  // }}}

  //==========================================================
  // ITB Stack trace {{{

  assign id2ex_itb_data = rff_if2id_itb_data;

  // }}}

  //==========================================================
  // output {{{
  assign id2ex.pc = if2id_ff.pc;
  assign id2ex.rd_addr = rd_addr;
  assign id2ex.inst = if2id_ff.inst;
  assign id2ex.is_rvc = if2id_ff.is_rvc;
  // MA2EX_FORWARDING begin
  assign id2ex.is_rs1_final = ~wait_for_rs1;
  assign id2ex.is_rs2_final = ~wait_for_rs2;
  // MA2EX_FORWARDING end
  // assign id2ex.is_rs1_final = '0;
  // assign id2ex.is_rs2_final = '0;
  assign id_pc = id2ex.pc;
  always_ff @ (posedge clk) begin
    if (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) begin
      id2ex_ff.inst <= ORV64_CONST_INST_NOP;
      id2ex_ff.pc <= id2ex.pc;

      rff_id2ex_itb_data.push_to_stack <= 1'b0;

      id2ex_ctrl_ff.is_rs2_fp <= 1'b0;
      id2ex_ctrl_ff.alu_op <= ORV64_ALU_OP_ADD;
      id2ex_ctrl_ff.alu_en <= 1'b0;
      id2ex_ctrl_ff.is_32 <= 1'b0;
      id2ex_ctrl_ff.op1_sel <= ORV64_OP1_SEL_RS1;
      id2ex_ctrl_ff.op2_sel <= ORV64_OP2_SEL_RS2;
      id2ex_ctrl_ff.imm_sel <= ORV64_IMM_SEL_I;
      id2ex_ctrl_ff.rd_avail <= ORV64_RD_AVAIL_EX;
      id2ex_ctrl_ff.rd_we <= 1'b0;
      id2ex_ctrl_ff.is_rd_fp <= 1'b0;
      id2ex_ctrl_ff.ex_pc_sel <= ORV64_EX_PC_SEL_P4;
      id2ex_ctrl_ff.ex_out_sel <= ORV64_EX_OUT_SEL_ALU_OUT;
      id2ex_ctrl_ff.is_aq_rl <= 1'b0;
      id2ex_ctrl_ff.is_amo_load <= 1'b0;
      id2ex_ctrl_ff.is_amo_op <= 1'b0;
      id2ex_ctrl_ff.is_amo <= 1'b0;
      id2ex_ctrl_ff.is_amo_done <= 1'b0;
      id2ex_ctrl_ff.is_amo_store <= 1'b0;
      id2ex_ctrl_ff.is_amo_mv <= 1'b0;
      id2ex_ctrl_ff.is_lr <= 1'b0;
      id2ex_ctrl_ff.is_sc <= 1'b0;

    `ifndef SYNTHESIS
      id2ex_ctrl_ff.inst_code <= "none";
    `endif
    end else if (ex_ready_masked & id_valid) begin
      id2ex_ff <= id2ex; // spyglass disable UndrivenInTerm-ML W123

      rff_id2ex_itb_data <= id2ex_itb_data;

      id2ex_ctrl_ff.is_rs1_fp <= id2ex_ctrl.is_rs1_fp;
      id2ex_ctrl_ff.is_rs2_fp <= id2ex_ctrl.is_rs2_fp;
      id2ex_ctrl_ff.alu_op <= id2ex_ctrl.alu_op;
      id2ex_ctrl_ff.alu_en <= id2ex_ctrl.alu_en;
      id2ex_ctrl_ff.is_32 <= id2ex_ctrl.is_32;
      id2ex_ctrl_ff.op1_sel <= id2ex_ctrl.op1_sel;
      id2ex_ctrl_ff.op2_sel <= id2ex_ctrl.op2_sel;
      id2ex_ctrl_ff.imm_sel <= id2ex_ctrl.imm_sel;
      id2ex_ctrl_ff.rd_avail <= id2ex_ctrl.rd_avail;
      id2ex_ctrl_ff.rd_we <= id2ex_ctrl.rd_we;
      id2ex_ctrl_ff.is_rd_fp <= id2ex_ctrl.is_rd_fp;
      id2ex_ctrl_ff.ex_pc_sel <= id2ex_ctrl.ex_pc_sel;
      id2ex_ctrl_ff.ex_out_sel <= id2ex_ctrl.ex_out_sel;
      id2ex_ctrl_ff.is_aq_rl <= id2ex_ctrl.is_aq_rl;
      id2ex_ctrl_ff.is_amo_load <= id2ex_ctrl.is_amo_load;
      id2ex_ctrl_ff.is_amo_op <= id2ex_ctrl.is_amo_op;
      id2ex_ctrl_ff.is_amo <= id2ex_ctrl.is_amo;
      id2ex_ctrl_ff.is_amo_done <= id2ex_ctrl.is_amo_done;
      id2ex_ctrl_ff.is_amo_store <= id2ex_ctrl.is_amo_store;
      id2ex_ctrl_ff.is_amo_mv <= id2ex_ctrl.is_amo_mv;
      id2ex_ctrl_ff.is_lr <= id2ex_ctrl.is_lr;
      id2ex_ctrl_ff.is_sc <= id2ex_ctrl.is_sc;

    `ifndef SYNTHESIS
      id2ex_ctrl_ff.inst_code <= id2ex_ctrl.inst_code;
    `endif
    end

    if (rst | (id_kill & ex_ready_masked)) begin
      id2ex_excp_ff.valid <= 1'b0;
      id2ex_excp_ff.is_half1 <= 1'b0;
      id2ex_excp_ff.cause <= ORV64_EXCP_CAUSE_NONE;
    end else if (ex_ready & ~ex_ready_masked) begin
      id2ex_excp_ff.valid <= 1'b0;
      id2ex_excp_ff.is_half1 <= 1'b0;
      id2ex_excp_ff.cause <= ORV64_EXCP_CAUSE_NONE;
    end else if (ex_ready_masked & id_valid) begin
      id2ex_excp_ff <= id2ex_excp;
    end
  end

`ifdef ORV64_SUPPORT_MULDIV // {{{
  always_ff @ (posedge clk) begin
    if (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) begin
      id2mul_ff.en <= 1'b0;
      id2div_ff.en <= 1'b0;
    end else if (ex_ready_masked & id_valid) begin
      id2mul_ff.en <= id2mul.en;
      id2div_ff.en <= id2div.en;
    end
  end

  logic muldiv_clkg, en_muldiv;

  assign en_muldiv = (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) | id2mul.en | id2div.en;

  icg muldiv_clk_u(
    .en       (en_muldiv),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (muldiv_clkg)
  );

  always_ff @ (posedge muldiv_clkg) begin
    if (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) begin
      id2ex_ctrl_ff.mul_type <= ORV64_MUL_TYPE_NONE;
      id2ex_ctrl_ff.div_type <= ORV64_DIV_TYPE_NONE;
      id2mul_ff.is_same <= 1'b0;
      id2div_ff.is_same <= 1'b0;
    end else if (en_muldiv) begin
      if (ex_ready_masked & id_valid) begin
        if (id2mul.en) begin
          id2ex_ctrl_ff.mul_type <= id2ex_ctrl.mul_type;
          id2mul_ff.rs1 <= id2ex.rs1;
          id2mul_ff.rs2 <= id2ex.rs2;
        end
        if (id2div.en) begin
          id2ex_ctrl_ff.div_type <= id2ex_ctrl.div_type;
          id2div_ff.rs1 <= id2ex.rs1;
          id2div_ff.rs2 <= id2ex.rs2;
        end
        id2mul_ff.is_same <= id2mul.is_same;
        id2div_ff.is_same <= id2div.is_same;
      end
    end
  end

`endif // ORV64_SUPPORT_MULDIV}}}

`ifdef ORV64_SUPPORT_FP // {{{

  logic fp_clkg, en_fp;
  logic fp_rs1_clkg, en_fp_rs1;

  assign en_fp = (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) | (id2ex_ctrl.fp_op != ORV64_FP_OP_NONE);
  assign en_fp_rs1 = (id_valid & ex_ready_masked & ((id2ex_ctrl.op1_sel == ORV64_OP1_SEL_FP_RS1) | (id2ex_ctrl.op1_sel == ORV64_OP1_SEL_FP_RS1_SEXT)));

  icg fp_clk_u(
    .en       (en_fp),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_clkg)
  );

  icg fp_rs1_clk_u(
    .en       (en_fp_rs1),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_rs1_clkg)
  );

  always_ff @(posedge clk) begin
    if (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) begin
      id2ex_ctrl_ff.fp_op <= ORV64_FP_OP_NONE;
      id2ex_ctrl_ff.fp_out_sel <= ORV64_FP_OUT_SEL_NONE;
    end else if (ex_ready_masked & id_valid) begin
      id2ex_ctrl_ff.is_fp_32 <= id2ex_ctrl.is_fp_32;
      id2ex_ctrl_ff.fp_op <= id2ex_ctrl.fp_op;
      id2ex_ctrl_ff.fp_out_sel <= id2ex_ctrl.fp_out_sel;
    end
  end

  always_ff @ (posedge fp_clkg) begin
    if (rst | ((id_kill | id2ex_excp.valid) & ex_ready_masked)) begin
      id2ex_ctrl_ff.fp_sgnj_sel <= ORV64_FP_SGNJ_SEL_J;
      id2ex_ctrl_ff.fp_cmp_sel <= ORV64_FP_CMP_SEL_NONE;
      id2ex_ctrl_ff.fp_cvt_sel <= ORV64_FP_CVT_SEL_W;
    end else if (en_fp) begin
      if (ex_ready_masked & id_valid) begin
        id2ex_ctrl_ff.fp_sgnj_sel <= id2ex_ctrl.fp_sgnj_sel;
        id2ex_ctrl_ff.fp_cmp_sel <= id2ex_ctrl.fp_cmp_sel;
        id2ex_ctrl_ff.fp_cvt_sel <= id2ex_ctrl.fp_cvt_sel;
      end
    end
  end

  always_ff @(posedge fp_rs1_clkg) begin
    if (en_fp_rs1) begin
      id2ex_fp_rs1_ff <= fp_rs1;
    end
  end

  //------------------------------------------------------
  // FP_ADD_S

  logic fp_add_s_clkg, en_fp_add_s;

  assign en_fp_add_s = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_ADD_S);

  icg fp_add_s_clk_u(
    .en       (en_fp_add_s),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_add_s_clkg)
  );

  always_ff @ (posedge fp_add_s_clkg) begin
    if (en_fp_add_s) begin
      id2fp_add_s_ff.rs1 <= fp_rs1;
      id2fp_add_s_ff.rs2 <= fp_rs2;
      id2fp_add_s_ff.frm_dw <= frm_dw;
    end
  end

  //------------------------------------------------------
  // FP_MAC_S

  logic fp_mac_s_clkg, en_fp_mac_s;

  assign en_fp_mac_s = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_MAC_S);

  icg fp_mac_s_clk_u(
    .en       (en_fp_mac_s),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_mac_s_clkg)
  );

  always_ff @(posedge fp_mac_s_clkg) begin
    if (en_fp_mac_s) begin
      id2fp_mac_s_ff.rs1 <= fp_rs1;
      id2fp_mac_s_ff.rs2 <= fp_rs2;
      id2fp_mac_s_ff.rs3 <= fp_rs3;
      id2fp_mac_s_ff.frm_dw <= frm_dw;
      id2fp_mac_s_ff.is_mul <= (opcode == ORV64_OP_FP);
    end
  end

  //------------------------------------------------------
  // FP_DIV_S

  logic fp_div_s_clkg, en_fp_div_s;

  assign en_fp_div_s = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_DIV_S);

  icg fp_div_s_clk_u(
    .en       (en_fp_div_s),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_div_s_clkg)
  );

  always_ff @(posedge fp_div_s_clkg) begin
    if (en_fp_div_s) begin
      id2fp_div_s_ff.rs1 <= fp_rs1;
      id2fp_div_s_ff.rs2 <= fp_rs2;
      id2fp_div_s_ff.frm_dw <= frm_dw;
    end
  end

  //------------------------------------------------------
  // FP_SQRT_S

  logic fp_sqrt_s_clkg, en_fp_sqrt_s;

  assign en_fp_sqrt_s = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_SQRT_S);

  icg fp_sqrt_s_clk_u(
    .en       (en_fp_sqrt_s),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_sqrt_s_clkg)
  );

  always_ff @(posedge fp_sqrt_s_clkg) begin
    if (en_fp_sqrt_s) begin
      id2fp_sqrt_s_ff.rs1 <= fp_rs1;
      id2fp_sqrt_s_ff.frm_dw <= frm_dw;
    end
  end

`ifdef ORV64_SUPPORT_FP_DOUBLE

  //------------------------------------------------------
  // FP_ADD_D

  logic fp_add_d_clkg, en_fp_add_d;

  assign en_fp_add_d = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_ADD_D);

  icg fp_add_d_clk_u(
    .en       (en_fp_add_d),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_add_d_clkg)
  );

  always_ff @(posedge fp_add_d_clkg) begin
    if (en_fp_add_d) begin
      id2fp_add_d_ff.rs1 <= fp_rs1;
      id2fp_add_d_ff.rs2 <= fp_rs2;
      id2fp_add_d_ff.frm_dw <= frm_dw;
    end
  end

  //------------------------------------------------------
  // FP_MAC_D

  logic fp_mac_d_clkg, en_fp_mac_d;

  assign en_fp_mac_d = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_MAC_D);

  icg fp_mac_d_clk_u(
    .en       (en_fp_mac_d),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_mac_d_clkg)
  );

  always_ff @(posedge fp_mac_d_clkg) begin
    if (en_fp_mac_d) begin
      id2fp_mac_d_ff.rs1 <= fp_rs1;
      id2fp_mac_d_ff.rs2 <= fp_rs2;
      id2fp_mac_d_ff.rs3 <= fp_rs3;
      id2fp_mac_d_ff.frm_dw <= frm_dw;
      id2fp_mac_d_ff.is_mul <= (opcode == ORV64_OP_FP);
    end
  end

  //------------------------------------------------------
  // FP_DIV_D

  logic fp_div_d_clkg, en_fp_div_d;

  assign en_fp_div_d = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_DIV_D);

  icg fp_div_d_clk_u(
    .en       (en_fp_div_d),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_div_d_clkg)
  );

  always_ff @(posedge fp_div_d_clkg) begin
    if (en_fp_div_d) begin
      id2fp_div_d_ff.rs1 <= fp_rs1;
      id2fp_div_d_ff.rs2 <= fp_rs2;
      id2fp_div_d_ff.frm_dw <= frm_dw;
    end
  end

  //------------------------------------------------------
  // FP_SQRT_D

  logic fp_sqrt_d_clkg, en_fp_sqrt_d;

  assign en_fp_sqrt_d = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_SQRT_D);

  icg fp_sqrt_d_clk_u(
    .en       (en_fp_sqrt_d),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_sqrt_d_clkg)
  );

  always_ff @(posedge fp_sqrt_d_clkg) begin
    if (en_fp_sqrt_d) begin
      id2fp_sqrt_d_ff.rs1 <= fp_rs1;
      id2fp_sqrt_d_ff.frm_dw <= frm_dw;
    end
  end

  //------------------------------------------------------
  // FP_MISC

  logic fp_misc_clkg, en_fp_misc;

  assign en_fp_misc = id_valid & ex_ready_masked & (id2ex_ctrl.fp_op == ORV64_FP_OP_MISC);

  icg fp_misc_clk_u(
    .en       (en_fp_misc),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fp_misc_clkg)
  );

  always_ff @(posedge fp_misc_clkg) begin
    if (en_fp_misc) begin
      id2fp_misc_ff.rs1 <= fp_rs1;
      id2fp_misc_ff.rs2 <= fp_rs2;
      id2fp_misc_ff.frm_dw <= frm_dw;
    end
  end

`endif // ORV64_SUPPORT_FP_DOUBLE

`endif // ORV64_SUPPORT_FP}}}


endmodule
