// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_mem_access
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
  import pygmy_intf_typedef::*;
(
  // EX -> MA
  input   orv64_ex2ma_t       ex2ma_ff,
  input   orv64_ex2ma_ctrl_t  ex2ma_ctrl_ff,
  input   orv64_excp_t        ex2ma_excp_ff,
  // L1D$ -> MA
  input   orv64_ex2dc_t       ex2dc,
  input   orv64_dc2ma_t       dc2ma,

  // MA -> EX
  output  orv64_data_t        ma2ex_amo_ld_data,

  // MA -> IF
  output  logic         ma2if_npc_valid,
  // WB -> IF
  output  orv64_npc_t         wb2if_npc,
  // MA -> Regfile
  output  orv64_ma2rf_t       ma2irf,
`ifdef ORV64_SUPPORT_FP
  output  orv64_ma2rf_t       ma2fprf,
`endif
  // MA <-> CS
  output  orv64_ma2cs_t       ma2cs,
  output  orv64_ma2cs_ctrl_t  ma2cs_ctrl,
  output  orv64_excp_t        ma2cs_excp,
  input   orv64_cs2ma_t       cs2ma,
  input   orv64_trap_t        cs2ma_excp,
  input   orv64_data_t        minstret,
  input   orv64_data_t        mcycle,
  // bypass
  output  orv64_bps_t         ma2id_bps,
  output  orv64_bps_t         ma2ex_bps,/* wb2id_bps, */
  // MA -> DA
  output  orv64_ma2da_t ma2da,
  // pipeline ctrl
  input   logic         ma_stall, ma_kill, ex_valid_ff, wb_ready, if_ready,
  output  logic         ma_valid, ma_ready, wb_valid,
  output  logic         ma_is_stable_stall,
  input   logic         cs2ma_stall,
  // performance counter
  output  logic         wait_for_dcr,
  output  logic         wait_for_dcw,
  output  orv64_vaddr_t ma_pc, wb_pc,
  output  logic         retiring_inst,
  // hash check
  input   orv64_data_t  current_hash,
  output  logic         update_hash,
  output  orv64_data_t  next_hash,
  // rst & clk
  input                 rst, clk
);

  orv64_ma2wb_t ma2wb_ff;
  orv64_ma2wb_ctrl_t ma2wb_ctrl_ff;
  logic ma_valid_ff;



  //==========================================================
  // ICG {{{

  logic en_rd;

  logic dc2ma_clkg;
  logic rd_clkg;

  assign en_rd = (ma_valid & wb_ready & ma2irf.rd_we) | rst;

  icg dc2ma_clk_u(
    .en       (dc2ma.valid),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (dc2ma_clkg)
  );

  icg rd_clk_u(
    .en       (en_rd),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (rd_clkg)
  );

  // }}}

  //==========================================================
  // break-down inst {{{
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

  always_comb
    func_break_inst(.opcode(opcode), .rd_addr(rd_addr), .rs1_addr(rs1_addr), .rs2_addr(rs2_addr), .rs3_addr(rs3_addr), .funct2(funct2), .funct3(funct3), .funct5(funct5), .funct6(funct6), .funct7(funct7), .funct12(funct12), .fmt(fmt), .i_imm(i_imm), .s_imm(s_imm), .b_imm(b_imm), .u_imm(u_imm), .j_imm(j_imm), .z_imm(z_imm), .frm(frm), .inst(ex2ma_ff.inst));

  // }}}

  //==========================================================
  // D-Cache read (the write part is in EX, before its output flip-flop stage) {{{
  orv64_data_t        ma_rdata;
  logic [ 7:0]  rdata_byte;
  logic [15:0]  rdata_word;
  logic [31:0]  rdata_dword;
  logic         is_load_addr_misaligned_word, is_load_addr_misaligned_dword, is_load_addr_misaligned_qword, is_load_addr_misaligned;

  logic         ex2dc_en_ff;
  orv64_dc2ma_t       dc2ma_saved_ff, dc2ma_hold;
  logic         hold_dc2ma, hold_dc2ma_ff;

  assign hold_dc2ma = (ma_stall | ~wb_ready | cs2ma_stall) & dc2ma_hold.valid;

  always_ff @ (posedge clk) begin
    if (rst) begin
      ex2dc_en_ff <= '0;
      hold_dc2ma_ff <= '0;
    end else begin
      ex2dc_en_ff <= ex2dc.re | ex2dc.we | ex2dc.aq_rl;
      hold_dc2ma_ff <= hold_dc2ma;
    end
  end

  always_ff @(posedge dc2ma_clkg) begin
    if (dc2ma.valid) begin
      dc2ma_saved_ff <= dc2ma;
    end
  end

  assign dc2ma_hold = hold_dc2ma_ff ? dc2ma_saved_ff : dc2ma;

  // load byte
  always_comb
    case (ex2ma_ff.ex_out[2:0])
      3'b001:   rdata_byte = dc2ma_hold.rdata[15: 8];
      3'b010:   rdata_byte = dc2ma_hold.rdata[23:16];
      3'b011:   rdata_byte = dc2ma_hold.rdata[31:24];
      3'b100:   rdata_byte = dc2ma_hold.rdata[39:32];
      3'b101:   rdata_byte = dc2ma_hold.rdata[47:40];
      3'b110:   rdata_byte = dc2ma_hold.rdata[55:48];
      3'b111:   rdata_byte = dc2ma_hold.rdata[63:56];
      default:  rdata_byte = dc2ma_hold.rdata[ 7: 0];
    endcase

  // load 2-byte
  always_comb begin
    is_load_addr_misaligned_word = 1'b0;
    case (ex2ma_ff.ex_out[2:0])
      3'b000: rdata_word = dc2ma_hold.rdata[15: 0];
      3'b010: rdata_word = dc2ma_hold.rdata[31:16];
      3'b100: rdata_word = dc2ma_hold.rdata[47:32];
      3'b110: rdata_word = dc2ma_hold.rdata[63:48];
      default: begin
        rdata_word = dc2ma_hold.rdata[15: 0];
        is_load_addr_misaligned_word = ex2ma_ctrl_ff.is_load;
      end
    endcase
  end

  // load 4-byte
  always_comb begin
    is_load_addr_misaligned_dword = 1'b0;
    case (ex2ma_ff.ex_out[2:0])
      3'b000: rdata_dword = dc2ma_hold.rdata[31: 0];
      3'b100: rdata_dword = dc2ma_hold.rdata[63:32];
      default: begin
        rdata_dword = dc2ma_hold.rdata[31: 0];
        is_load_addr_misaligned_dword = ex2ma_ctrl_ff.is_load;
      end
    endcase
  end

  // load 8-byte
  assign is_load_addr_misaligned_qword = (ex2ma_ff.ex_out[2:0] != 3'b000) & ex2ma_ctrl_ff.is_load;

  always_comb
    case (ex2ma_ctrl_ff.ma_byte_sel)
      ORV64_MA_BYTE_SEL_2, ORV64_MA_BYTE_SEL_U2:
        is_load_addr_misaligned = is_load_addr_misaligned_word;
      ORV64_MA_BYTE_SEL_4, ORV64_MA_BYTE_SEL_U4:
        is_load_addr_misaligned = is_load_addr_misaligned_dword;
      ORV64_MA_BYTE_SEL_8:
        is_load_addr_misaligned = is_load_addr_misaligned_qword;
      default:
        is_load_addr_misaligned = 1'b0;
    endcase

  always_comb
    if (ex2ma_ctrl_ff.is_sc) begin
      ma_rdata = dc2ma.rdata;
    end else begin
      case (ex2ma_ctrl_ff.ma_byte_sel)
        ORV64_MA_BYTE_SEL_1:   ma_rdata = {{(64-8){rdata_byte[7]}}, rdata_byte};
        ORV64_MA_BYTE_SEL_U1:  ma_rdata = {{(64-8){1'b0}}, rdata_byte};
        ORV64_MA_BYTE_SEL_2:   ma_rdata = ({{(64-16){rdata_word[15]}}, rdata_word});
        ORV64_MA_BYTE_SEL_U2:  ma_rdata = ({{(64-16){1'b0}}, rdata_word});
        ORV64_MA_BYTE_SEL_4:   ma_rdata = ({{(64-32){rdata_dword[31]}}, rdata_dword});
        ORV64_MA_BYTE_SEL_U4:  ma_rdata = ({{(64-32){1'b0}}, rdata_dword});
  //       ORV64_MA_BYTE_SEL_8:   ma_rdata = dc2ma_hold.rdata;
        default:         ma_rdata = dc2ma_hold.rdata;
      endcase
    end
  // }}}

  orv64_data_t dff_amo_ld_data;

  assign ma2ex_amo_ld_data = dff_amo_ld_data;

  always_ff @(posedge clk) begin
    if (dc2ma.valid & ex2ma_ctrl_ff.is_amo_load) begin
      dff_amo_ld_data <= ma_rdata;
    end
  end

  //==========================================================
  // fence {{{
  logic hold_ma2if, hold_ma2if_ff, ma2if_npc_valid_ff;
  assign hold_ma2if = ~if_ready;
  always_ff @ (posedge clk) begin
    hold_ma2if_ff <= hold_ma2if;
    if (~hold_ma2if)
      ma2if_npc_valid_ff <= ma2if_npc_valid;
  end
  always_comb begin
    case (ex2ma_ctrl_ff.fence_type)
      ORV64_FENCE_TYPE_NONE: begin
        ma2if_npc_valid = 1'b0;
      end
      default: begin
        ma2if_npc_valid = hold_ma2if ? ma2if_npc_valid_ff : ma_valid;
      end
    endcase
  end
  // }}}

  //==========================================================
  // Pipeline blocking csr operation done {{{
  logic               is_csr_op_resume_pipeline;
  orv64_npc_t         rff_wb2if_npc;
  assign wb2if_npc  = rff_wb2if_npc;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_wb2if_npc <= '0;
    end else begin
      if (wb2if_npc.valid & if_ready) begin
        rff_wb2if_npc <= '0;
      end
      if (ma_valid & wb_ready & ~cs2ma_excp.valid) begin
        rff_wb2if_npc.valid <= is_csr_op_resume_pipeline;
        rff_wb2if_npc.pc <= ex2ma_ff.pc + (ex2ma_ff.is_rvc ? 'h2: 'h4);
      end
    end
  end

  always_comb begin
    if (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) begin
      case (ma2cs.csr_addr)
        ORV64_CSR_ADDR_MSTATUS,
        ORV64_CSR_ADDR_SSTATUS,
        ORV64_CSR_ADDR_SATP,
        ORV64_CSR_ADDR_FRM: begin
          is_csr_op_resume_pipeline = '1;
        end
        default: begin
          is_csr_op_resume_pipeline = '0;
        end
      endcase
    end else begin
      is_csr_op_resume_pipeline = '0;
    end
  end

  // }}}

  //==========================================================
  // Prepare to write to Regfile {{{
  orv64_data_t rd, rd_fp, rd_ir;
  always_comb
    case (ex2ma_ctrl_ff.rd_sel)
      ORV64_RD_SEL_MEM_READ:  rd = ma_rdata;
      ORV64_RD_SEL_CSR_READ:  rd = cs2ma.csr;
      default:          rd = ex2ma_ff.ex_out;
    endcase

`ifdef ORV64_SUPPORT_FP_DOUBLE
  assign rd_fp = ex2ma_ctrl_ff.is_fp_32 ? {{32{1'b1}}, rd[31:0]}: rd;
`else
  assign rd_fp = rd;
`endif

  assign rd_ir = rd;

  assign ma2irf.rd = rd_ir;
  assign ma2irf.rd_addr = ex2ma_ff.rd_addr;
  assign ma2irf.rd_we = ma_valid & wb_ready & ~ex2ma_ctrl_ff.is_rd_fp & ex2ma_ctrl_ff.rd_we & (ex2ma_ff.rd_addr != 'b0) & ~cs2ma_excp.valid;
`ifdef ORV64_SUPPORT_FP
  assign ma2fprf.rd = rd_fp;
  assign ma2fprf.rd_addr = ex2ma_ff.rd_addr;
  assign ma2fprf.rd_we = ma_valid & wb_ready & ex2ma_ctrl_ff.is_rd_fp & ex2ma_ctrl_ff.rd_we & ~cs2ma_excp.valid;
`endif
  // }}}

  //==========================================================
  // bypass {{{

  // ma2id_bps
  assign ma2id_bps.valid_data = ((ex2ma_ctrl_ff.rd_avail == ORV64_RD_AVAIL_MA) | (ex2ma_ctrl_ff.rd_avail == ORV64_RD_AVAIL_EX)) & ex2ma_ctrl_ff.rd_we & ma_valid;
  assign ma2id_bps.is_rd_fp = ex2ma_ctrl_ff.is_rd_fp;
  assign ma2id_bps.rd_addr = ex2ma_ff.rd_addr;
  assign ma2id_bps.valid_addr = {5{ex2ma_ctrl_ff.rd_we & ex_valid_ff & ~ma_kill}};
  assign ma2id_bps.rd = ex2ma_ctrl_ff.is_rd_fp ? rd_fp: rd_ir;

  assign ma2ex_bps.valid_data = ((ex2ma_ctrl_ff.rd_avail == ORV64_RD_AVAIL_MA) | (ex2ma_ctrl_ff.rd_avail == ORV64_RD_AVAIL_EX)) & ex2ma_ctrl_ff.rd_we & ma_valid;
  assign ma2ex_bps.is_rd_fp = ex2ma_ctrl_ff.is_rd_fp;
  assign ma2ex_bps.rd_addr = ex2ma_ff.rd_addr;
  assign ma2ex_bps.valid_addr = {5{ex2ma_ctrl_ff.rd_we & ex_valid_ff & ~ma_kill}};
  assign ma2ex_bps.rd = ex2ma_ctrl_ff.is_rd_fp ? rd_fp: rd_ir;
  // }}}


  logic wait_for_dc;



  //==========================================================
  // to CSR {{{
  assign ma2cs.pc = ex2ma_ff.pc;
  assign ma2cs.inst = ex2ma_ff.inst;
  assign ma2cs.mem_addr = ex2ma_ff.ex_out;
  assign ma2cs.csr_addr = ex2ma_ff.csr_addr;
  assign ma2cs.rs1_addr = rs1_addr;
  assign ma2cs.csr_wdata = ex2ma_ff.ex_out;
  assign ma2cs.fflags = ex2ma_ff.fflags;
  assign ma2cs.is_rvc = ex2ma_ff.is_rvc;
  assign ma2cs_ctrl.csr_op = ex_valid_ff ? ex2ma_ctrl_ff.csr_op: ORV64_CSR_OP_NONE;
  assign ma2cs_ctrl.ret_type = ex_valid_ff ? ex2ma_ctrl_ff.ret_type: ORV64_RET_TYPE_NONE;
  assign ma2cs_ctrl.is_wfi = ex_valid_ff ? ex2ma_ctrl_ff.is_wfi: '0;
  // }}}

  //==========================================================
  // exception {{{
  always_comb begin
    ma2cs_excp.inst = ex2ma_excp_ff.inst;
    if (ex2ma_excp_ff.valid) begin
      ma2cs_excp.valid = ex2ma_excp_ff.valid & wb_ready;
      ma2cs_excp.is_half1 = ex2ma_excp_ff.is_half1;
      ma2cs_excp.cause = ex2ma_excp_ff.cause;
    end else begin
      if (ex2ma_ctrl_ff.is_load & is_load_addr_misaligned) begin
        ma2cs_excp.valid = wb_ready;
        ma2cs_excp.is_half1 = 1'b0;
        ma2cs_excp.cause = ORV64_EXCP_CAUSE_LOAD_ADDR_MISALIGNED;
      end else if (dc2ma_hold.valid & dc2ma_hold.excp_valid) begin
        ma2cs_excp.valid = wb_ready;
        ma2cs_excp.is_half1 = 1'b0;
        ma2cs_excp.cause = dc2ma_hold.excp_cause;
      end else begin
        ma2cs_excp.valid = 1'b0;
        ma2cs_excp.is_half1 = 1'b0;
        ma2cs_excp.cause = ex2ma_excp_ff.cause;
      end
    end
  end
  // }}}

  //==========================================================
  // pipeline control {{{
  assign wait_for_dc = ex2dc_en_ff & ~dc2ma.valid;
  assign wait_for_dcw = wait_for_dc & (ex2dc.we & ~ex2dc.sc & ~ex2dc.amo_store);
  assign wait_for_dcr = wait_for_dc & (ex2dc.re & ~ex2dc.lr & ~ex2dc.amo_load);

  assign ma_valid = ~ma_kill & ex_valid_ff & ~wait_for_dc & ~cs2ma_stall;
  assign ma_ready = (wb_ready | ~ma_valid) & ~wait_for_dc & ~cs2ma_stall;

  assign ma_is_stable_stall = ~ma_valid & ma_ready;

  assign ma2da.cs2ma_stall = cs2ma_stall;
  assign ma2da.wait_for_dc = wait_for_dc;

  always_ff @ (posedge clk)
    if (rst)
      ma_valid_ff <= 1'b0;
    else if (wb_ready)
      ma_valid_ff <= ma_valid & (~ex2ma_ctrl_ff.is_amo | ex2ma_ctrl_ff.is_amo_done) & (~cs2ma_excp.valid | ((cs2ma_excp.cause == ORV64_TRAP_CAUSE_BREAKPOINT) | (cs2ma_excp.cause == ORV64_TRAP_CAUSE_ECALL_FROM_M) | (cs2ma_excp.cause == ORV64_TRAP_CAUSE_ECALL_FROM_S) | (cs2ma_excp.cause == ORV64_TRAP_CAUSE_ECALL_FROM_U)));

  assign retiring_inst = ma_valid & (~ex2ma_ctrl_ff.is_amo | ex2ma_ctrl_ff.is_amo_done) & wb_ready;

  assign wb_valid = ma_valid_ff;

  assign ma_pc = ex2ma_ff.pc;
  always @ (posedge clk)
    if (ma_valid & wb_ready) begin
      wb_pc <= ex2ma_ff.pc;
    end

`ifndef SYNTHESIS
  logic [63:0]  wb_inst_code = "default";
  always @ (posedge clk)
    if (ma_valid & wb_ready) begin
      wb_inst_code <= ex2ma_ctrl_ff.inst_code;
    end
  logic [63:0] ma_status;
  always @ (*)
    case ({ma_valid, ma_ready})
      2'b00: ma_status = "BUSY";
      2'b01: ma_status = "IDLE";
      2'b10: ma_status = "BLOCK";
      2'b11: ma_status = "DONE";
      default: ma_status = 64'bx;
    endcase
`endif
  // }}}

  //==========================================================
  // Byte parity checksum {{{
  
  orv64_data_t             wb_pc_ext;
  orv64_data_t             rff_wb_hash;
  orv64_data_t             rff_rd;

  assign wb_pc_ext = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){wb_pc[ORV64_VIR_ADDR_WIDTH-1]}}, wb_pc};

  always_ff @(posedge rd_clkg) begin
    if (rst) begin
      rff_rd <= '0;
    end else begin
      if (en_rd) begin
        rff_rd <= rd;
      end
    end
  end

  assign next_hash = current_hash ^ wb_pc_ext ^ rff_rd;
  assign update_hash = wb_valid;

  // }}}

//`ifndef SYNTHESIS
//  always @ (posedge clk) begin
//    if (cs2ma_excp.valid & ma_valid & wb_ready)
//      $warning ("excp %s @ %t (PC=%h)", cs2ma_excp.cause.name(), $time, ma2cs.pc);
//  end
//`endif

  orv64_data_t  rff_mcycle;

`ifndef SYNTHESIS

  int mtime_file;
  logic print_mtime_flag;

  initial begin
    if ($test$plusargs("print_mtime")) begin
      mtime_file = $fopen("./mtime", "w");
      print_mtime_flag = 1'b1;
    end else begin
      print_mtime_flag = 1'b0;
    end
  end

  always_ff @ (posedge clk) begin
    if (~rst) begin
      if (print_mtime_flag) begin
        if (wb_valid) begin
          $fdisplay(mtime_file, "%t time_end PC=%h, mtime=%h", $time, wb_pc, mcycle);
        end
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_mcycle <= '1;
    end else begin
      if (wb_valid) begin
        rff_mcycle <= mcycle;
      end
    end
  end

  assert_mtime_incr: assert property (@(posedge clk) disable iff (rst === '0) (wb_valid) |-> (mcycle === (rff_mcycle + 64'h1)))
    else `olog_fatal("ORV_MEM_ACC", $sformatf("mtime value err"));
`endif


endmodule
