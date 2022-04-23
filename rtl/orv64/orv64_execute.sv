// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_execute
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
  import orv64_decode_func_pkg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  input [7:0]		      core_id,
  // ID -> EX
  input   orv64_id2ex_t       id2ex_ff,
  input   orv64_data_t        id2ex_fp_rs1_ff,

  `ifdef ORV64_SUPPORT_MULDIV
  input   orv64_id2muldiv_t   id2mul_ff, id2div_ff, id2mul, id2div,
  `endif // ORV64_SUPPORT_MULDIV


  input   orv64_id2ex_ctrl_t  id2ex_ctrl_ff,
  input   orv64_excp_t        id2ex_excp_ff,
  // EX -> MA
  output  orv64_ex2ma_t       ex2ma_ff,
  output  orv64_ex2ma_ctrl_t  ex2ma_ctrl_ff,
  output  orv64_excp_t        ex2ma_excp_ff,
  // EX -> L1D$
  output  orv64_ex2dc_t       ex2dc,
  input   orv64_dc2ma_t       dc2ma,
  input   orv64_data_t        ma2ex_amo_ld_data,
  // EX -> IF: next pc
  output  orv64_npc_t         ex2if_npc,
  output  logic         ex2if_kill, ex2id_kill,
  output  logic         branch_solved,
  // EX -> ID: bypass
  output  orv64_bps_t         ex2id_bps,
  // MA -> EX: bypass
  input   orv64_bps_t         ma2ex_bps,
  // EX -> ID: scoreboard kill addr
  output  orv64_reg_addr_t    ex2id_kill_addr,
  // EX -> DTLB
  output logic                       ex2dtlb_flush_req_valid,
  output orv64_tlb_flush_if_req_t    ex2dtlb_flush_req,
  // EX -> DA
  output  orv64_ex2da_t       ex2da,

  // privilege level
  input   orv64_prv_t         prv,
  input   orv64_csr_mstatus_t mstatus,
  // pipeline ctrl
  input   logic         ex_stall, ex_kill, if_ready, id_ready, id_valid, id_valid_ff, ma_ready,
  output  logic         ex_valid, ex_valid_ff, ex_ready,
  output  logic         ex_is_stable_stall,
  // performance counter
  output  logic         wait_for_ex,
  output  logic         ex_wait_for_reg,

  output  orv64_vaddr_t       ex_pc,
  // atomic
  // rst & clk
  input                 rst, clk
);

  orv64_ex2ma_t       ex2ma;
  orv64_ex2ma_ctrl_t  ex2ma_ctrl;
  orv64_excp_t        ex2ma_excp;

  logic     hold_ex2dc, hold_ex2dc_ff, ex2dc_en_ff, ex2dc_en;
  logic     is_sfence, do_trap_sfence;
  logic     do_trap_sret;

  orv64_opcode_t      opcode;
  orv64_reg_addr_t    rd_addr, rs1_addr, rs2_addr, rs3_addr;
  logic [ 1:0]  funct2;
  logic [ 2:0]  funct3;
  logic [ 4:0]  funct5;
  logic [ 5:0]  funct6;
  logic [ 6:0]  funct7;
  logic [11:0]  funct12;
  logic [ 1:0]  fmt;
  orv64_data_t        i_imm, s_imm, b_imm, u_imm, j_imm, z_imm;
  orv64_frm_t         frm;

  orv64_data_t    dff_amo_rs2;

  //==========================================================
  // ICG {{{

  logic en_amo_addr, en_amo_wdata, en_ex2if_npc;
  logic amo_addr_clkg, amo_wdata_clkg, ex2dc_clkg, ex2if_clkg;
  logic amo_rs2_clkg, en_amo_rs2;

  assign en_amo_addr = ex_valid & id2ex_ctrl_ff.is_amo_load & ma_ready;
  assign en_amo_wdata = ex_valid & id2ex_ctrl_ff.is_amo_op & ma_ready;
  assign en_ex2if_npc = ex2if_npc.valid;
  assign en_amo_rs2 = id2ex_ctrl_ff.is_amo_mv;

  icg amo_addr_clk_u(
    .en       (en_amo_addr),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (amo_addr_clkg)
  );

  icg amo_wdata_clk_u(
    .en       (en_amo_wdata),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (amo_wdata_clkg)
  );

  icg ex2dc_clk_u(
    .en       (ex2dc_en),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (ex2dc_clkg)
  );

  icg ex2if_clk_u(
    .en       (en_ex2if_npc),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (ex2if_clkg)
  );

  icg amo_rs2_clk_u(
    .en       (en_amo_rs2),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (amo_rs2_clkg)
  );

  // }}}

  //==========================================================
  // MA2EX forwarding path {{{
  orv64_data_t final_rs1, final_rs2;

  // MA2EX_FORWARDING begin
  //logic        is_reg_not_final;
  //logic        rff_ma2ex_hold_valid;
  //orv64_data_t final_rs1, final_rs2;
  //orv64_data_t dff_ma2ex_hold_data;
  //logic        ma2ex_final_valid;
  //orv64_data_t ma2ex_bps_data;
  //logic        wait_for_rs1, wait_for_rs2;

  //assign is_reg_not_final = id_valid_ff & ~(id2ex_ff.is_rs1_final & id2ex_ff.is_rs2_final) & ~id2ex_ctrl_ff.is_amo_op;

  //assign ma2ex_final_valid = (ma2ex_bps.valid_addr & ma2ex_bps.valid_data) | rff_ma2ex_hold_valid;
  //assign ma2ex_bps_data = rff_ma2ex_hold_valid ? dff_ma2ex_hold_data: ma2ex_bps.rd;

  //assign final_rs1 = id2ex_ctrl_ff.is_amo_op ? ma2ex_amo_ld_data: id2ex_ff.is_rs1_final ? id2ex_ff.rs1: ma2ex_bps_data;
  //assign final_rs2 = id2ex_ctrl_ff.is_amo_op ? dff_amo_rs2: id2ex_ff.is_rs2_final ? id2ex_ff.rs2: ma2ex_bps_data;

  //assign wait_for_rs1 = id_valid_ff & ~id2ex_ff.is_rs1_final & ~ma2ex_final_valid & ~id2ex_ctrl_ff.is_amo_op;
  //assign wait_for_rs2 = id_valid_ff & ~id2ex_ff.is_rs2_final & ~ma2ex_final_valid & ~id2ex_ctrl_ff.is_amo_op;

  //assign ex_wait_for_reg = (wait_for_rs1 | wait_for_rs2) & ~id2ex_excp_ff.valid & ~ex_kill;

  //always_ff @(posedge clk) begin
  //  if (rst) begin
  //    rff_ma2ex_hold_valid <= '0;
  //  end else begin
  //    if (rff_ma2ex_hold_valid) begin
  //      rff_ma2ex_hold_valid <= ~(ex_valid & ma_ready);
  //    end if (is_reg_not_final & ma2ex_bps.valid_addr & ma2ex_bps.valid_data & ~(ex_valid & ma_ready)) begin
  //      rff_ma2ex_hold_valid <= '1;
  //      dff_ma2ex_hold_data <= ma2ex_bps.rd;
  //    end
  //  end
  //end
  // MA2EX_FORWARDING end

  assign ex_wait_for_reg = '0;
  assign final_rs1 = id2ex_ctrl_ff.is_amo_op ? ma2ex_amo_ld_data: id2ex_ff.rs1;
  assign final_rs2 = id2ex_ctrl_ff.is_amo_op ? dff_amo_rs2: id2ex_ff.rs2;


`ifndef SYNTHESIS
  ma2ex_fwd_rs1_mismatch: assert property (@(posedge clk) disable iff (rst === '0) ((id_valid_ff & ~id2ex_ff.is_rs1_final & ma2ex_bps.valid_addr & ma2ex_bps.valid_data & ~id2ex_excp_ff.valid) |-> (ma2ex_bps.rd_addr == rs1_addr))) else `olog_error("ORV_EXECUTE", $sformatf("%m: ma2ex_rd_addr=%h rs1_addr=%h", ma2ex_bps.rd_addr, rs1_addr));
  ma2ex_fwd_rs2_mismatch: assert property (@(posedge clk) disable iff (rst === '0) ((id_valid_ff & ~id2ex_ff.is_rs2_final & ma2ex_bps.valid_addr & ma2ex_bps.valid_data & ~id2ex_excp_ff.valid) |-> (ma2ex_bps.rd_addr == rs2_addr))) else `olog_error("ORV_EXECUTE", $sformatf("%m: ma2ex_rd_addr=%h rs2_addr=%h", ma2ex_bps.rd_addr, rs2_addr));
`endif

  // }}}

  //==========================================================
  // flop value of rs2 for amo op{{{

  always_ff @(posedge amo_rs2_clkg) begin
    if (en_amo_rs2) begin
      dff_amo_rs2 <= final_rs2;
    end
  end 

  //------------------------------------------------------
  // DTLB sfence

  logic ex2dtlb_flush_req_valid_unmasked;

  assign do_trap_sfence = mstatus.TVM & (prv == ORV64_PRV_S);
  assign is_sfence = (opcode == ORV64_SYSTEM) & (funct7 == 7'h09) & (funct3 == 3'h0) & (rd_addr == 5'h00) & id_valid_ff & ~ex_kill & ~do_trap_sfence;

  always_comb begin
    ex2dtlb_flush_req.req_flush_asid = final_rs2;
    ex2dtlb_flush_req.req_flush_vpn = (final_rs1 >> ORV64_PAGE_OFFSET_WIDTH);
    if ((ex2dtlb_flush_req.req_flush_asid != '0) & (ex2dtlb_flush_req.req_flush_vpn != '0)) begin
      ex2dtlb_flush_req.req_sfence_type = ORV64_SFENCE_ASID_VPN;
    end else if ((ex2dtlb_flush_req.req_flush_asid != '0) & (ex2dtlb_flush_req.req_flush_vpn == '0)) begin
      ex2dtlb_flush_req.req_sfence_type = ORV64_SFENCE_ASID;
    end else if ((ex2dtlb_flush_req.req_flush_asid == '0) & (ex2dtlb_flush_req.req_flush_vpn != '0)) begin
      ex2dtlb_flush_req.req_sfence_type = ORV64_SFENCE_VPN;
    end else begin
      ex2dtlb_flush_req.req_sfence_type = ORV64_SFENCE_ALL;
    end
  end

  assign ex2dtlb_flush_req_valid = is_sfence & (ex_valid & ma_ready);


  //==========================================================
  // TSR check
  assign do_trap_sret = (mstatus.TSR & (prv == ORV64_PRV_S)) | ~((prv == ORV64_PRV_S) | (prv == ORV64_PRV_M));

  //==========================================================
  // imm selection {{{
  orv64_data_t imm;
  always_comb
    case (id2ex_ctrl_ff.imm_sel)
      ORV64_IMM_SEL_I: imm = i_imm;
      ORV64_IMM_SEL_S: imm = s_imm;
      ORV64_IMM_SEL_B: imm = b_imm;
      ORV64_IMM_SEL_U: imm = u_imm;
      ORV64_IMM_SEL_J: imm = j_imm;
      ORV64_IMM_SEL_Z: imm = z_imm;
      default: imm = 64'b0;
    endcase
  // }}}

  //==========================================================
  // ALU {{{

  // select op1 & op2
  orv64_data_t    op1, op2;
  always_comb begin
    case (id2ex_ctrl_ff.op1_sel)
      ORV64_OP1_SEL_RS1:    op1 = final_rs1;
      
      ORV64_OP1_SEL_ZERO:   op1 = 'b0;
      default:        op1 = 'b0;
    endcase
  end

  always_comb begin
    case (id2ex_ctrl_ff.op2_sel)
      ORV64_OP2_SEL_RS2:      op2 = final_rs2;
      default:          op2 = imm;
    endcase
  end

  orv64_data_t  alu_out, adder_out;
  orv64_data_t  final_op1, final_op2;
  logic   cmp_out;

  generate
    for (genvar i=0; i<32; i++) begin
      assign final_op1[i] = op1[i];
      assign final_op2[i] = op2[i];
    end
  endgenerate

  generate
    for (genvar i=32; i<64; i++) begin
      assign final_op1[i] = id2ex_ctrl_ff.is_32 ? op1[31]: op1[i];
      assign final_op2[i] = id2ex_ctrl_ff.is_32 ? op2[31]: op2[i];
    end
  endgenerate

  orv64_alu ALU(
    .alu_out, .adder_out, .cmp_out,
    .op1(final_op1), .op2(final_op2), .alu_op(id2ex_ctrl_ff.alu_op), .is_32(id2ex_ctrl_ff.is_32)
  );
  // }}}

  //==========================================================
  // PC adder and branch taken logic {{{
  orv64_data_t pc_adder_out;
  orv64_data_t 	pc_adder_ext;
  logic   branch_taken;
  logic   ex2if_npc_valid_pre;
  logic   is_misaligned_if_addr;
  assign  pc_adder_ext = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){id2ex_ff.pc[ORV64_VIR_ADDR_WIDTH-1]}}, id2ex_ff.pc};
  assign  pc_adder_out = pc_adder_ext + ((id2ex_ctrl_ff.ex_pc_sel == ORV64_EX_PC_SEL_P4) ? (id2ex_ff.is_rvc ? 'h2: 'h4) : imm);

  orv64_vaddr_t   ex2if_pc_saved_ff;
  logic   hold_ex2if_kill_ff, ex2if_kill_saved_ff, clear_ex2if_npc_valid;
  always_ff @ (posedge clk) begin
    if (rst) begin
      hold_ex2if_kill_ff <= 1'b0;
      clear_ex2if_npc_valid <= 1'b0;
      ex2if_kill_saved_ff <= 1'b0;
    end else begin
      hold_ex2if_kill_ff <= (ex2if_kill & (~if_ready | ~id_ready)); // when IF or ID is not ready, they are not ready to be killed. so need to hold the kill signal till after they are ready to be killed
      if (~clear_ex2if_npc_valid & ex2if_npc.valid & if_ready & id_ready)
        clear_ex2if_npc_valid <= '1; // clear kill signal after its accepted
      else if (clear_ex2if_npc_valid & id_valid & ex_ready)
        clear_ex2if_npc_valid <= '0;
      if (ex2if_npc.valid) begin
        ex2if_kill_saved_ff <= ex2if_kill;
      end
    end
  end

  always_ff @(posedge ex2if_clkg) begin
    if (en_ex2if_npc) begin
      ex2if_pc_saved_ff <= ex2if_npc.pc;
    end
  end

  assign  branch_taken = (opcode == ORV64_BRANCH) ? cmp_out : 1'b0;
  assign  branch_solved = (opcode == ORV64_BRANCH) & ex_valid & ~clear_ex2if_npc_valid; // clear branch_solved if it's accepted
  assign  ex2if_npc.pc = hold_ex2if_kill_ff ? ex2if_pc_saved_ff: ((opcode == ORV64_JALR) ? {alu_out[ORV64_XLEN-1:1], 1'b0} : pc_adder_out);
  assign  ex2if_npc_valid_pre = hold_ex2if_kill_ff | ((((opcode == ORV64_JALR) | branch_taken)) & ex_valid & ~clear_ex2if_npc_valid);
  assign  is_misaligned_if_addr = (ex2if_npc.pc[0] != 1'b0) & ex2if_npc_valid_pre;
  assign  ex2if_npc.valid = ex2if_npc_valid_pre & ~ex2ma_excp.valid;

  assign  ex2if_kill = ex2if_npc.valid;
  assign  ex2id_kill = ex2if_kill;
  // }}}
 
  //==========================================================
  // MULDIV {{{
  logic wait_for_mul, wait_for_div;
`ifdef ORV64_SUPPORT_MULDIV

  // explicitly defined clock gating
  logic   clkg_mul, clkg_div;
//   logic   mul_en, mul_en_ff;
//   logic   div_en, div_en_ff;
  orv64_clk_gating CG_MUL(.tst_en(1'b0), .en(id2mul_ff.en), .clk(clk), .rst(rst), .clkg(clkg_mul));
  orv64_clk_gating CG_DIV(.tst_en(1'b0), .en(id2div_ff.en), .clk(clk), .rst(rst), .clkg(clkg_div));

  // MUL {{{
  orv64_data_t  mul_rdh, mul_rdl;
  logic   mul_start_pulse, mul_complete;

  always_ff @ (posedge clk)
    if (rst | (id2mul.en & mul_complete & ~id2mul.is_same & ex_ready))
      mul_start_pulse <= 1'b1;
    else if (id2mul_ff.en & ~ex_wait_for_reg & mul_start_pulse)
      mul_start_pulse <= 1'b0;

//   assign  mul_en = (id2ex_ctrl_ff.mul_type != ORV64_MUL_TYPE_NONE) & id_valid_ff;
  assign  wait_for_mul = id2mul_ff.en & ~mul_complete;

  // MA2EX_FORWARDING begin
  //orv64_mul MUL(.rdh(mul_rdh), .rdl(mul_rdl), .complete(mul_complete),
  //  .rs1(final_rs1), .rs2(final_rs2), .mul_type(id2ex_ctrl_ff.mul_type), .start_pulse(mul_start_pulse),
  //  .clk(clkg_mul), .*);
  // MA2EX_FORWARDING end
  orv64_mul MUL(.rdh(mul_rdh), .rdl(mul_rdl), .complete(mul_complete),
    .rs1(id2mul_ff.rs1), .rs2(id2mul_ff.rs2), .mul_type(id2ex_ctrl_ff.mul_type), .start_pulse(mul_start_pulse),
    .clk(clkg_mul), .*);
  // }}}

  // DIV {{{
  orv64_data_t  div_rdq, div_rdr;
  logic   div_start_pulse, div_complete;

  always_ff @ (posedge clk)
    if (rst | (id2div.en & div_complete & ~id2div.is_same & ex_ready))
      div_start_pulse <= 1'b1;
    else if (id2div_ff.en & ~ex_wait_for_reg & div_start_pulse)
      div_start_pulse <= 1'b0;

//   assign  div_en = (id2ex_ctrl_ff.div_type != ORV64_DIV_TYPE_NONE) & id_valid_ff;
  assign  wait_for_div = id2div_ff.en & ~div_complete;

  // MA2EX_FORWARDING begin
  //orv64_div DIV(.rdq(div_rdq), .rdr(div_rdr), .complete(div_complete),
  //  .rs1(final_rs1), .rs2(final_rs2), .div_type(id2ex_ctrl_ff.div_type), .start_pulse(div_start_pulse),
  //  .clk(clkg_div), .*);
  // MA2EX_FORWARDING end
  orv64_div DIV(.rdq(div_rdq), .rdr(div_rdr), .complete(div_complete),
    .rs1(id2div_ff.rs1), .rs2(id2div_ff.rs2), .div_type(id2ex_ctrl_ff.div_type), .start_pulse(div_start_pulse),
    .clk(clkg_div), .*);
  // }}}
`else
  
  assign wait_for_mul = '0;
  assign wait_for_div = '0;

`endif // ORV64_SUPPORT_MULDIV
  // }}}

  //==========================================================
  // FP {{{



  logic wait_for_fp;
  assign wait_for_fp = 1'b0;
  assign ex2ma.fflags = 5'b0;





  //==========================================================
  // select ex_out {{{
  always_comb
    case (id2ex_ctrl_ff.ex_out_sel)
      ORV64_EX_OUT_SEL_RS1:       ex2ma.ex_out = final_rs1;
      ORV64_EX_OUT_SEL_PC_ADDER:  ex2ma.ex_out = pc_adder_out;
      `ifdef ORV64_SUPPORT_MULDIV
      ORV64_EX_OUT_SEL_MUL_L: ex2ma.ex_out = mul_rdl;
      ORV64_EX_OUT_SEL_MUL_H: ex2ma.ex_out = mul_rdh;
      ORV64_EX_OUT_SEL_DIV_Q: ex2ma.ex_out = div_rdq;
      ORV64_EX_OUT_SEL_DIV_R: ex2ma.ex_out = div_rdr;
      `endif // ORV64_SUPPORT_MULDIV
      
      default:          ex2ma.ex_out = alu_out;
    endcase
  // }}}
  
  //==========================================================
  // bypass {{{
  assign ex2id_bps.valid_data = (id2ex_ctrl_ff.rd_avail == ORV64_RD_AVAIL_EX) & id2ex_ctrl_ff.rd_we & ex_valid;
  assign ex2id_bps.is_rd_fp = id2ex_ctrl_ff.is_rd_fp & id2ex_ctrl_ff.rd_we;
  assign ex2id_bps.rd_addr = ex2ma.rd_addr;
  assign ex2id_bps.valid_addr = {5{ex2ma_ctrl.rd_we & id_valid_ff & ~ex_kill}};
  assign ex2id_bps.rd = ex2ma.ex_out;

  assign ex2id_kill_addr = ex2ma.rd_addr & {5{ex2ma_ctrl.rd_we & id_valid_ff & ex_kill}};

  //==========================================================
  // decode for MA {{{

  // break-down inst

  always_comb
    func_break_inst(.opcode(opcode), .rd_addr(rd_addr), .rs1_addr(rs1_addr), .rs2_addr(rs2_addr), .rs3_addr(rs3_addr), .funct2(funct2), .funct3(funct3), .funct5(funct5), .funct6(funct6), .funct7(funct7), .funct12(funct12), .fmt(fmt), .i_imm(i_imm), .s_imm(s_imm), .b_imm(b_imm), .u_imm(u_imm), .j_imm(j_imm), .z_imm(z_imm), .frm(frm), .inst(id2ex_ff.inst));


  logic is_illegal_inst, is_ecall, is_ebreak;
  always_comb begin
    is_illegal_inst = 1'b0;
    is_ecall = 1'b0;
    is_ebreak = 1'b0;

    case (opcode)
      ORV64_AMO: begin
	case (funct7[3:2])
          2'b10: begin
            case(funct3)
              3'h2: func_orv64_decode_ex2ma_lr_w(ex2ma_ctrl);
              3'h3: func_orv64_decode_ex2ma_lr_d(ex2ma_ctrl);
              default: begin
                func_orv64_decode_ex2ma_default(ex2ma_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          end
          2'b11: begin
            case(funct3)
              3'h2: func_orv64_decode_ex2ma_sc_w(ex2ma_ctrl);
              3'h3: func_orv64_decode_ex2ma_sc_d(ex2ma_ctrl);
              default: begin
                func_orv64_decode_ex2ma_default(ex2ma_ctrl);
                is_illegal_inst = 1'b1;
              end
            endcase
          end
	  default: begin
	    func_orv64_decode_ex2ma_default(ex2ma_ctrl);
	  end
	endcase
      end
      ORV64_LOAD: // {{{
        case (funct3)
          3'h0: func_orv64_decode_ex2ma_lb(ex2ma_ctrl);
          3'h4: func_orv64_decode_ex2ma_lbu(ex2ma_ctrl);
          3'h1: func_orv64_decode_ex2ma_lh(ex2ma_ctrl);
          3'h5: func_orv64_decode_ex2ma_lhu(ex2ma_ctrl);
          3'h2: func_orv64_decode_ex2ma_lw(ex2ma_ctrl);
          3'h6: func_orv64_decode_ex2ma_lwu(ex2ma_ctrl);
          3'h3: func_orv64_decode_ex2ma_ld(ex2ma_ctrl);
          default: begin
            func_orv64_decode_ex2ma_default(ex2ma_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_STORE: // {{{
        case (funct3)
          3'h0: func_orv64_decode_ex2ma_sb(ex2ma_ctrl);
          3'h1: func_orv64_decode_ex2ma_sh(ex2ma_ctrl);
          3'h2: func_orv64_decode_ex2ma_sw(ex2ma_ctrl);
          3'h3: func_orv64_decode_ex2ma_sd(ex2ma_ctrl);
          default: begin
            func_orv64_decode_ex2ma_default(ex2ma_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
     
      ORV64_SYSTEM: // {{{
        case (funct3)
          3'h0: begin
            if ((funct7 == 7'h09) & (rd_addr == 5'h0)) begin
              if (do_trap_sfence) begin
                is_illegal_inst = 1'b1;
                func_orv64_decode_ex2ma_default(ex2ma_ctrl);
              end else begin
                func_orv64_decode_ex2ma_sfence_vma(ex2ma_ctrl);
              end
            end else begin
              if ((rs1_addr == 5'h00) & (rd_addr == 5'h00)) begin
                case (funct12)
                  12'h000: begin
                    is_ecall = 1'b1;
                    func_orv64_decode_ex2ma_ecall(ex2ma_ctrl);
                  end
                  12'h001: begin
                    is_ebreak = 1'b1;
                    func_orv64_decode_ex2ma_ebreak(ex2ma_ctrl);
                  end
                  12'h105: begin
                    func_orv64_decode_ex2ma_wfi(ex2ma_ctrl);
                  end
                  12'h106: begin
                    func_orv64_decode_ex2ma_wfe(ex2ma_ctrl);
                  end
                  12'h002: func_orv64_decode_ex2ma_uret(ex2ma_ctrl);
                  12'h102: begin
                    if (do_trap_sret) begin
                      is_illegal_inst = 1'b1;
                      func_orv64_decode_ex2ma_default(ex2ma_ctrl);
                    end else begin
                      func_orv64_decode_ex2ma_sret(ex2ma_ctrl);
                    end
                  end
                  12'h302: begin
                    if (prv == ORV64_PRV_M) begin
                      func_orv64_decode_ex2ma_mret(ex2ma_ctrl);
                    end else begin
                      func_orv64_decode_ex2ma_default(ex2ma_ctrl);
                      is_illegal_inst = 1'b1;
                    end
                  end
                  default: begin
                    func_orv64_decode_ex2ma_default(ex2ma_ctrl);
                    is_illegal_inst = 1'b1;
                  end 
                endcase
              end else begin
                func_orv64_decode_ex2ma_default(ex2ma_ctrl);
                is_illegal_inst = 1'b1;
              end
            end
          end
          3'h1: func_orv64_decode_ex2ma_csrrw(ex2ma_ctrl);
          3'h2: func_orv64_decode_ex2ma_csrrs(ex2ma_ctrl);
          3'h3: func_orv64_decode_ex2ma_csrrc(ex2ma_ctrl);
          3'h5: func_orv64_decode_ex2ma_csrrwi(ex2ma_ctrl);
          3'h6: func_orv64_decode_ex2ma_csrrsi(ex2ma_ctrl);
          3'h7: func_orv64_decode_ex2ma_csrrci(ex2ma_ctrl);
          default: begin
            func_orv64_decode_ex2ma_default(ex2ma_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase // }}}
      ORV64_MISC_MEM: begin // {{{
        case(funct3)
          3'h0: func_orv64_decode_ex2ma_fence(ex2ma_ctrl);
          3'h1: func_orv64_decode_ex2ma_fence_i(ex2ma_ctrl);
          default: begin
            func_orv64_decode_ex2ma_default(ex2ma_ctrl);
            is_illegal_inst = 1'b1;
          end
        endcase
      end
      // }}}
      default: begin
        func_orv64_decode_ex2ma_default(ex2ma_ctrl);
      end
    endcase

    // copy from ID ctrl
    ex2ma_ctrl.is_rd_fp = id2ex_ctrl_ff.is_rd_fp;
    ex2ma_ctrl.rd_we = id2ex_ctrl_ff.rd_we;
    ex2ma_ctrl.rd_avail = id2ex_ctrl_ff.rd_avail;
    ex2ma_ctrl.is_lr = id2ex_ctrl_ff.is_lr;
    ex2ma_ctrl.is_sc = id2ex_ctrl_ff.is_sc;
    ex2ma_ctrl.is_aq_rl = id2ex_ctrl_ff.is_aq_rl;
    ex2ma_ctrl.is_amo_load = id2ex_ctrl_ff.is_amo_load;
    ex2ma_ctrl.is_amo_op = id2ex_ctrl_ff.is_amo_op;
    ex2ma_ctrl.is_amo_store = id2ex_ctrl_ff.is_amo_store;
    ex2ma_ctrl.is_amo = id2ex_ctrl_ff.is_amo;
    ex2ma_ctrl.is_amo_done = id2ex_ctrl_ff.is_amo_done;
    ex2ma_ctrl.is_fp_32 = id2ex_ctrl_ff.is_fp_32;
    `ifndef SYNTHESIS
      if (ex2ma_ctrl.inst_code == "default")
        ex2ma_ctrl.inst_code = id2ex_ctrl_ff.inst_code;
    `endif
  end

  // }}}
  
  //==========================================================
  // prepare to read/write L1D$ {{{
  orv64_ex2dc_t ex2dc_saved_ff; // hold the address while rmiss/wmiss
  orv64_vaddr_t ex2dc_addr_mux;
  assign hold_ex2dc = ex2dc_en_ff & ~dc2ma.valid;

  always_ff @ (posedge clk)
    if (rst) begin
      hold_ex2dc_ff <= '0;
      ex2dc_saved_ff.re <= '0;
      ex2dc_saved_ff.we <= '0;
      ex2dc_en_ff <= '0;
      ex2dc_saved_ff.lr <= '0;
      ex2dc_saved_ff.sc <= '0;
      ex2dc_saved_ff.aq_rl <= '0;
      ex2dc_saved_ff.amo_load <= '0;
      ex2dc_saved_ff.amo_store <= '0;
    end else begin
      ex2dc_en_ff <= ex2dc_en;
      ex2dc_saved_ff.re <= ex2dc.re;
      ex2dc_saved_ff.we <= ex2dc.we;
      ex2dc_saved_ff.lr <= ex2dc.lr;
      ex2dc_saved_ff.sc <= ex2dc.sc;
      ex2dc_saved_ff.amo_load <= ex2dc.amo_load;
      ex2dc_saved_ff.amo_store <= ex2dc.amo_store;
      ex2dc_saved_ff.aq_rl <= ex2dc.aq_rl;
      hold_ex2dc_ff <= hold_ex2dc;
    end

  always_ff @(posedge ex2dc_clkg) begin
    if (ex2dc_en) begin
      ex2dc_saved_ff.addr <= ex2dc.addr;
      ex2dc_saved_ff.wdata <= ex2dc.wdata;
      ex2dc_saved_ff.mask <= ex2dc.mask;
      ex2dc_saved_ff.width <= ex2dc.width;
    end
  end

  assign ex2dc_en = ex2dc.re | ex2dc.we | ex2dc.aq_rl;

  //------------------------------------------------------
  // write {{{

  // write en

  // write addr
  orv64_vaddr_t waddr;
  orv64_data_t 	ex2dc_amo_wdata;
  assign  waddr = ex2ma.ex_out;

  // write data
  orv64_data_t  wdata;

  logic [7:0] wbyte0, wbyte1, wbyte2, wbyte3;
  assign  wbyte0 = id2ex_ctrl_ff.is_amo_store ? ex2dc_amo_wdata[7:0]: final_rs2[ 7: 0];
  assign  wbyte1 = id2ex_ctrl_ff.is_amo_store ? ex2dc_amo_wdata[15:8]: final_rs2[15: 8];
  assign  wbyte2 = id2ex_ctrl_ff.is_amo_store ? ex2dc_amo_wdata[23:16]: final_rs2[23:16];
  assign  wbyte3 = id2ex_ctrl_ff.is_amo_store ? ex2dc_amo_wdata[31:24]: final_rs2[31:24];

  always_comb begin
    case (ex2ma_ctrl.ma_byte_sel)
      ORV64_MA_BYTE_SEL_1:
        case (ex2dc_addr_mux[2:0])
          3'b001:   wdata = {48'b0,  wbyte0,    8'b0};
          3'b010:   wdata = {40'b0,  wbyte0,   16'b0};
          3'b011:   wdata = {32'b0,  wbyte0,   24'b0};
          3'b100:   wdata = {24'b0,  wbyte0,   32'b0};
          3'b101:   wdata = {16'b0,  wbyte0,   40'b0};
          3'b110:   wdata = { 8'b0,  wbyte0,   48'b0};
          3'b111:   wdata = {wbyte0, 56'b0          };
          default:  wdata = {56'b0,           wbyte0};
        endcase
      ORV64_MA_BYTE_SEL_2:
        case (ex2dc_addr_mux[2:0])
          3'b000: wdata = {48'b0,  wbyte1, wbyte0};
          3'b010: wdata = {32'b0,  wbyte1, wbyte0, 16'b0};
          3'b100: wdata = {16'b0,  wbyte1, wbyte0, 32'b0};
          3'b110: wdata = {wbyte1, wbyte0, 48'b0};
          default: begin
            wdata = 64'b0;
          end
        endcase
      ORV64_MA_BYTE_SEL_4:
        case (ex2dc_addr_mux[2:0])
          3'b000: wdata = {32'b0, wbyte3, wbyte2, wbyte1, wbyte0};
          3'b100: wdata = {wbyte3, wbyte2, wbyte1, wbyte0, 32'b0};
          default: begin
            wdata = 64'b0;
          end
        endcase
      ORV64_MA_BYTE_SEL_8:
        case (ex2dc_addr_mux[2:0])
          3'b000: wdata = id2ex_ctrl_ff.is_amo_store ? ex2dc_amo_wdata: final_rs2;
          default: begin
            wdata = 64'b0;
          end
        endcase
      default:
        wdata = 64'b0;
    endcase
  end

  cpu_byte_mask_t width;

  // write mask
  logic [7:0] wmask;
  always_comb begin
    case (ex2ma_ctrl.ma_byte_sel)
      ORV64_MA_BYTE_SEL_1: begin
        case (ex2dc_addr_mux[2:0])
          3'b001:   wmask = 8'b00000010; 
          3'b010:   wmask = 8'b00000100;
          3'b011:   wmask = 8'b00001000;
          3'b100:   wmask = 8'b00010000;
          3'b101:   wmask = 8'b00100000;
          3'b110:   wmask = 8'b01000000;
          3'b111:   wmask = 8'b10000000;
          default:  wmask = 8'b00000001;
        endcase
      end
      ORV64_MA_BYTE_SEL_2: begin
        case (ex2dc_addr_mux[2:0])
          3'b000: wmask = 8'b00000011;
          3'b010: wmask = 8'b00001100;
          3'b100: wmask = 8'b00110000;
          3'b110: wmask = 8'b11000000;
          default: begin
            wmask = 8'b00000000;
          end
        endcase
      end
      ORV64_MA_BYTE_SEL_4: begin
        case (ex2dc_addr_mux[2:0])
          3'b000: wmask = 8'b00001111;
          3'b100: wmask = 8'b11110000;
          default: begin
            wmask = 8'b00000000;
          end
        endcase
      end
      ORV64_MA_BYTE_SEL_8: begin
        wmask = 8'b11111111;
      end
      default: begin
        wmask = 8'b00000000;
      end
    endcase
  end

  always_comb begin
    case (ex2ma_ctrl.ma_byte_sel)
      ORV64_MA_BYTE_SEL_1, ORV64_MA_BYTE_SEL_U1:  width = 'h1;
      ORV64_MA_BYTE_SEL_2, ORV64_MA_BYTE_SEL_U2:  width = 'h2;
      ORV64_MA_BYTE_SEL_4, ORV64_MA_BYTE_SEL_U4:  width = 'h4;
      ORV64_MA_BYTE_SEL_8:                        width = 'h8;
      default:                                    width = 'h0;
    endcase
  end
  // }}}

  orv64_vaddr_t rff_amo_ld_addr;

  always_ff @ (posedge amo_wdata_clkg) begin
    if (en_amo_wdata) begin
      ex2dc_amo_wdata <= alu_out;
    end
  end

  always_ff @ (posedge amo_addr_clkg) begin
    if (en_amo_addr) begin
      rff_amo_ld_addr <= ex2dc.addr;
    end
  end

  assign  ex2dc.we = hold_ex2dc ? ex2dc_saved_ff.we : ex2ma_ctrl.is_store & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.re = hold_ex2dc ? ex2dc_saved_ff.re : ex2ma_ctrl.is_load & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.lr = hold_ex2dc ? ex2dc_saved_ff.lr : ex2ma_ctrl.is_lr & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.sc = hold_ex2dc ? ex2dc_saved_ff.sc : ex2ma_ctrl.is_sc & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.aq_rl = hold_ex2dc ? ex2dc_saved_ff.aq_rl : ex2ma_ctrl.is_aq_rl & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.amo_load = hold_ex2dc ? ex2dc_saved_ff.amo_load : ex2ma_ctrl.is_amo_load & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.amo_store = hold_ex2dc ? ex2dc_saved_ff.amo_store : ex2ma_ctrl.is_amo_store & ex_valid & ~ex2ma_excp.valid & ma_ready & ~ex_stall;
  assign  ex2dc.width = hold_ex2dc ? ex2dc_saved_ff.width : width;

  always_comb begin
    if (id2ex_ctrl_ff.is_amo_store) begin
      ex2dc_addr_mux = rff_amo_ld_addr;
    end else begin
      ex2dc_addr_mux = alu_out;
    end
  end

  assign  ex2dc.addr = hold_ex2dc ? ex2dc_saved_ff.addr : ex2dc_addr_mux;
  assign  ex2dc.wdata = hold_ex2dc ? ex2dc_saved_ff.wdata : wdata;
  assign  ex2dc.mask = hold_ex2dc ? ex2dc_saved_ff.mask : wmask;
  // }}}

  //------------------------------------------------------
  // address misaligned exception {{{
  logic is_addr_misaligned;

  always_comb begin
    is_addr_misaligned = 1'b0;
    case (ex2ma_ctrl.ma_byte_sel)
      ORV64_MA_BYTE_SEL_2, ORV64_MA_BYTE_SEL_U2:
        if (ex2dc_addr_mux[0] != 1'b0) begin
          is_addr_misaligned = 1'b1;
        end
      ORV64_MA_BYTE_SEL_4, ORV64_MA_BYTE_SEL_U4:
        if (ex2dc_addr_mux[1:0] != 2'b00) begin
          is_addr_misaligned = 1'b1;
        end
      ORV64_MA_BYTE_SEL_8:
        if (ex2dc_addr_mux[2:0] != 3'b000) begin
          is_addr_misaligned = 1'b1;
        end
    endcase
  end
  // }}}
  
  //==========================================================
  // exception {{{
  logic is_kill;
  always_comb begin
    is_kill = '0;
    ex2ma_excp.inst = id2ex_excp_ff.inst;
    if (ex_kill) begin
      ex2ma_excp.valid = 1'b0;
      ex2ma_excp.is_half1 = 1'b0;
      ex2ma_excp.cause = ORV64_EXCP_CAUSE_NONE;
      is_kill = '1;
    end else begin
      case (1'b1)
        (id2ex_excp_ff.valid): begin
          ex2ma_excp = id2ex_excp_ff;
          is_kill = '1;
        end
        (is_illegal_inst | is_addr_misaligned): begin
          ex2ma_excp.valid = 1'b1;
          ex2ma_excp.is_half1 = 1'b0;
          ex2ma_excp.cause = is_addr_misaligned ? (ex2ma_ctrl.is_store ? ORV64_EXCP_CAUSE_STORE_ADDR_MISALIGNED: ORV64_EXCP_CAUSE_LOAD_ADDR_MISALIGNED) : ORV64_EXCP_CAUSE_ILLEGAL_INST;
          is_kill = '1;
        end
        is_ecall: begin
          ex2ma_excp.valid = 1'b1;
          ex2ma_excp.is_half1 = 1'b0;
          case (prv)
            ORV64_PRV_U: ex2ma_excp.cause = ORV64_EXCP_CAUSE_ECALL_FROM_U;
            ORV64_PRV_S: ex2ma_excp.cause = ORV64_EXCP_CAUSE_ECALL_FROM_S;
            ORV64_PRV_M: ex2ma_excp.cause = ORV64_EXCP_CAUSE_ECALL_FROM_M;
            default: ex2ma_excp.cause = ORV64_EXCP_CAUSE_ILLEGAL_INST;
          endcase
        end
        is_ebreak: begin
          ex2ma_excp.valid = 1'b1;
          ex2ma_excp.is_half1 = 1'b0;
          ex2ma_excp.cause = ORV64_EXCP_CAUSE_BREAKPOINT;
        end
        is_misaligned_if_addr: begin
          ex2ma_excp.valid = 1'b1;
          ex2ma_excp.is_half1 = 1'b0;
          ex2ma_excp.cause = ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED;
        end
        default: begin
          ex2ma_excp.valid = 1'b0;
          ex2ma_excp.is_half1 = 1'b0;
          ex2ma_excp.cause = id2ex_excp_ff.cause;
        end
      endcase
    end
  end
  // }}}

  //==========================================================
  // pipeline control {{{
  assign wait_for_ex = wait_for_mul | wait_for_div | wait_for_fp | hold_ex2if_kill_ff;
  assign ex_valid = ~ex_kill & id_valid_ff & ~wait_for_ex & ~ex_wait_for_reg;
  assign ex_ready = (ma_ready | ~ex_valid) & ~wait_for_ex & ~ex_wait_for_reg;

  assign ex_is_stable_stall = ~ex_valid & ex_ready;

  assign ex2da.wait_for_reg = ex_wait_for_reg;
  assign ex2da.wait_for_mul = wait_for_mul;
  assign ex2da.wait_for_div = wait_for_div;
  assign ex2da.wait_for_fp = wait_for_fp;
  assign ex2da.hold_ex2if_kill = hold_ex2if_kill_ff;

  always_ff @ (posedge clk)
    if (rst)
      ex_valid_ff <= 1'b0;
    else if (ma_ready)
      ex_valid_ff <= ex_valid;
  `ifndef SYNTHESIS
    logic [63:0] ex_status;
    always_comb
      case ({ex_valid, ex_ready})
        2'b00: ex_status = "BUSY";
        2'b01: ex_status = "IDLE";
        2'b10: ex_status = "BLOCK";
        2'b11: ex_status = "DONE";
        default: ex_status = 64'bx;
      endcase
  `endif
  // }}}

  //==========================================================
  // output {{{
  assign ex2ma.pc = id2ex_ff.pc;
  assign ex2ma.inst = id2ex_ff.inst;
  assign ex2ma.rd_addr = rd_addr;
  assign ex2ma.is_rvc = id2ex_ff.is_rvc;

  assign ex_pc = ex2ma.pc;

  assign ex2ma.csr_addr = orv64_csr_addr_t'(funct12);

  always_ff @ (posedge clk) begin
//     if (rst | ((ex_kill | ex2ma_excp.valid) & ma_ready)) begin
    if (rst | (is_kill & ma_ready)) begin
      ex2ma_ctrl_ff.is_rd_fp <= 1'b0;
      ex2ma_ctrl_ff.rd_we <= 1'b0;
      ex2ma_ctrl_ff.rd_avail <= ORV64_RD_AVAIL_EX;
      ex2ma_ctrl_ff.is_load <= 1'b0;
      ex2ma_ctrl_ff.is_store <= 1'b0;
      ex2ma_ctrl_ff.fence_type <= ORV64_FENCE_TYPE_NONE;
      ex2ma_ctrl_ff.rd_sel <= ORV64_RD_SEL_EX_OUT;
      ex2ma_ctrl_ff.ma_byte_sel <= ORV64_MA_BYTE_SEL_8;
      ex2ma_ctrl_ff.csr_op <= ORV64_CSR_OP_NONE;
      ex2ma_ctrl_ff.ret_type <= ORV64_RET_TYPE_NONE;
      ex2ma_ctrl_ff.is_wfi <= 1'b0;
      ex2ma_ctrl_ff.is_wfe <= 1'b0;
`ifndef SYNTHESIS
        ex2ma_ctrl_ff.inst_code = "none";
`endif
    end else if (ma_ready & ex_valid) begin
      ex2ma_ctrl_ff <= ex2ma_ctrl;
    end

    if (ex_valid & ma_ready) begin
      ex2ma_ff <= ex2ma;
    end

    if (rst | (ex_kill & ma_ready)) begin
      ex2ma_excp_ff.valid <= 1'b0;
      ex2ma_excp_ff.is_half1 <= 1'b0;
      ex2ma_excp_ff.cause <= ORV64_EXCP_CAUSE_NONE;
    end else if (ma_ready & ex_valid) begin
      ex2ma_excp_ff <= ex2ma_excp;
    end
  end
  // }}}

`ifndef SYNTHESIS
//  logic [63:0] cnt, mill;
//  assign mill = 64'd1000000;
//  always_ff @(posedge clk) begin
//    if (rst) begin
//      cnt <= '0;
//    end else begin
//      cnt <= cnt + ((ex_valid & ma_ready) ? 64'd1: 64'd0);
//    end
//  end
//
//  always_ff @(posedge clk) begin
//    if (~rst) begin
//      if (((cnt % mill) == '0) & ex_valid & ma_ready) begin
//        $display("%t instret%d=%1d", $time, core_id, cnt);
//      end
//    end 
//  end
//
  string filename;
  int pc_file;
  logic pc_print_flag;
  logic inst_print_flag;

  initial begin
    if ($test$plusargs("print_orv_pc")) begin
      #1;
      filename = $sformatf("core%0d.log", core_id);
      pc_file = $fopen(filename, "w");
      pc_print_flag = 1'b1;
    end else begin
      pc_print_flag = 1'b0;
    end
    if ($test$plusargs("print_orv_inst")) begin
      inst_print_flag = 1'b1;
    end else begin
      inst_print_flag = 1'b0;
    end
  end

  always_ff @ (posedge clk) begin
    if (pc_print_flag) begin
      if (~rst) begin
        if (ex_valid & ma_ready & (~id2ex_ctrl_ff.is_amo | id2ex_ctrl_ff.is_amo_done)) begin
          if (inst_print_flag) begin
            $fdisplay(pc_file, "%t PC=%h, INST=%h", $time, id2ex_ff.pc, id2ex_ff.inst);
          end else begin
            $fdisplay(pc_file, "%t PC=%h", $time, id2ex_ff.pc);
          end
        end
      end
    end
  end
`endif

endmodule
