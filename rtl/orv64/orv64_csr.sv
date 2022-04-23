// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_csr
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  input   [7:0]				  core_id,
  input   orv64_ma2cs_t       ma2cs,
  output  orv64_cs2ma_t       cs2ma,
  output  orv64_trap_t        cs2ma_excp,
  input   orv64_ma2cs_ctrl_t  ma2cs_ctrl,
  // exception
  input   orv64_excp_t        ma2cs_excp,
  output  orv64_npc_t         cs2if_npc,
  // interrupt
  input   logic             timer_int,
  input   logic             ext_int,
  input   logic             sw_int,
  // pipeline ctrl
  input   logic         if_ready, id_ready, ex_ready, ma_ready, wb_ready,
  input   logic         retiring_inst,
  output  logic         cs2if_kill,
  output  logic         cs2id_kill, cs2id_scb_rst,
  output  logic         cs2ex_kill,
  output  logic         cs2ma_kill,
  output  logic         cs2ma_stall,
  output  logic         cs2ib_flush,
  output  logic         is_kill,
  input   logic         inst_buf_idle,
  // privilege level
  output  orv64_prv_t         prv,
  // Translations
  output  orv64_csr_satp_t           satp,
  output  orv64_csr_mstatus_t        mstatus,
  output  orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  output  orv64_csr_pmpaddr_t [15:0] pmpaddr,

  // customized configuration bits for orv64
  output  logic                      cs2ic_bypass_ic,
  // FCSR
  output  orv64_frm_t         frm_csr,
  // Performance Counters
  input   logic         wait_for_npc, // IF: ctrl hazard
                        wait_for_reg, // ID/EX: data hazard
                        wait_for_icr, // icache read miss
                        wait_for_dcr, // dcache read
                        wait_for_dcw, // dcache write
                        wait_for_ex,  // EX: structure hazard
                        ic_hit, ic_miss, // icache hit pulse and miss pulse
                        itlb_hit, itlb_miss,
                        dtlb_hit, dtlb_miss,


  output  orv64_data_t  minstret,
  output  orv64_data_t          mcycle,

  // Interrupts
  input   orv64_vaddr_t id_pc,
  input   logic         if_has_amo_inst,
  input   logic         id_has_amo_inst,
  output  logic         int_stall,
  input   logic         is_pipeline_stalled,
  input   logic         stalled_for_int,

  output  orv64_cs2da_t       cs2da,
  output  logic               wfi_stall,
  input   logic               is_wfe_stall,


`ifdef ORV64_SUPPORT_DMA
  input   dma2mp_ch0_done,
  input   dma2mp_ch1_done,
  input   dma2mp_ch2_done,
  input   dma2mp_ch3_done,
`endif

  input                 cfg_en_hpmcounter,

  // rst & clk
  input                 rst, clk
);

  logic translation_change_vld;
  logic translation_change_rdy;
  orv64_csr_op_t csr_op_masked;
  orv64_ret_type_t ret_type_masked;
  
  assign cs2ma_stall = translation_change_vld & ~translation_change_rdy;

  assign translation_change_rdy =  inst_buf_idle;

  //==========================================================
  // Bypass IC
  assign cs2ic_bypass_ic = mstatus.BYPASS_IC;

  //==========================================================
  // defined CSR
  orv64_misa_ext_t      misa_ext_wdata;
  orv64_csr_misa_t      misa;
  orv64_csr_mstatus_t   mstatus_next;
  orv64_vaddr_t         mepc;
  orv64_data_t          mscratch;
  orv64_csr_tvec_t      mtvec;
  orv64_csr_trap_cause_t    mcause;
  orv64_csr_ip_t        mip, mip_next;
  orv64_csr_ie_t        mie, mie_next;
  orv64_csr_edeleg_t    medeleg;
  orv64_csr_ideleg_t    mideleg;
  orv64_csr_counteren_t mcounteren;
  orv64_data_t              mtval, mtval_next;
  orv64_csr_counter_inhibit_t mcountinhibit;
  orv64_data_t          mimpid;
  orv64_data_t          marchid;
  orv64_data_t          mvendorid;
    // -interrupt only taken if interrupts are enabled and MTIE is set in mie
  logic [7:0]     mhartid;
  orv64_cntr_t    hpmcounter3, hpmcounter4, hpmcounter5, hpmcounter6,
                  hpmcounter7, hpmcounter8, hpmcounter9, hpmcounter10,
                  hpmcounter11, hpmcounter12, hpmcounter13, hpmcounter14,
                  hpmcounter15, hpmcounter16, hpmcounter17;

  orv64_csr_sstatus_t       sstatus;
  orv64_csr_ip_t            sip;
  orv64_csr_ie_t            sie;
  orv64_vaddr_t             sepc;
  orv64_csr_trap_cause_t    scause;
  orv64_data_t              stval, stval_next;
  orv64_csr_tvec_t          stvec;
  orv64_data_t              sscratch;
  orv64_csr_counteren_t     scounteren;
  orv64_csr_edeleg_t        sedeleg;
  orv64_csr_ideleg_t        sideleg;

  orv64_csr_ustatus_t       ustatus;
  orv64_csr_tvec_t          utvec;
  orv64_vaddr_t             uepc;
  orv64_csr_trap_cause_t    ucause;
  orv64_data_t              utval, utval_next;
  orv64_data_t              uscratch;

  orv64_csr_ip_t            masked_int, m_masked_int, s_masked_int;
  orv64_csr_ip_t            uip;
  orv64_csr_ie_t            uie;
  orv64_csr_ip_t            sip_mask, uip_mask;
  orv64_csr_ie_t            sie_mask, uie_mask;

  orv64_csr_mstatus_t       sstatus_mask, ustatus_mask;

  orv64_csr_counteren_t     counteren;

  orv64_data_t              tval_next;
  orv64_csr_pmpcfg_t        pmpcfg0, pmpcfg2;
  orv64_csr_pmpcfg_t        pmpcfg_mask, current_pmpcfg, pmpcfg_wdata;
  orv64_csr_pmpaddr_t       pmpaddr_mask, pmpaddr_wdata;
  logic                     block_pmpaddr_wr;
  orv64_vaddr_t         dff_wfi_pc;

  orv64_vaddr_t         pc_alignment_mask;

  logic is_wfi, rff_wait_for_int, next_wait_for_int, wfi_resume, is_int_pending;

  assign cs2da.mcycle = mcycle;
  assign cs2da.minstret = minstret;
  assign cs2da.mstatus = mstatus;
  assign cs2da.mepc = mepc;
  assign cs2da.mcause = mcause;
  assign cs2da.misa = misa;
  assign cs2da.mip = mip;
  assign cs2da.mie = mie;
  assign cs2da.medeleg = medeleg;
  assign cs2da.mideleg = mideleg;
  assign cs2da.mtvec = mtvec;
  assign cs2da.mtval = mtval;
  assign cs2da.sepc = sepc;
  assign cs2da.satp = satp;
  assign cs2da.scause = scause;
  assign cs2da.sedeleg = sedeleg;
  assign cs2da.sideleg = sideleg;
  assign cs2da.stvec = stvec;
  assign cs2da.stval = stval;
  assign cs2da.uepc = uepc;
  assign cs2da.ucause = ucause;
  assign cs2da.utvec = utvec;
  assign cs2da.utval = utval;
  assign cs2da.hpmcounter3 = hpmcounter3;
  assign cs2da.hpmcounter4 = hpmcounter4;
  assign cs2da.hpmcounter5 = hpmcounter5;
  assign cs2da.hpmcounter6 = hpmcounter6;
  assign cs2da.hpmcounter7 = hpmcounter7;
  assign cs2da.hpmcounter8 = hpmcounter8;
  assign cs2da.hpmcounter9 = hpmcounter9;
  assign cs2da.hpmcounter10 = hpmcounter10;
  assign cs2da.hpmcounter11 = hpmcounter11;
  assign cs2da.hpmcounter12 = hpmcounter12;
  assign cs2da.hpmcounter13 = hpmcounter13;
  assign cs2da.hpmcounter14 = hpmcounter14;
  assign cs2da.hpmcounter15 = hpmcounter15;
  assign cs2da.hpmcounter16 = hpmcounter16;

  assign mhartid = core_id;

`ifdef ORV64_SUPPORT_FP
  orv64_csr_fcsr_t      fcsr;
  assign  frm_csr = fcsr.frm;
`endif

  logic               trap_int_valid, is_trapable_int_pending;
  orv64_int_cause_t   trap_int_cause;
  logic               en_m_int, en_s_int/*, en_u_int*/;

  logic               internal_excp_valid; // Exceptions for failing csr checks
  logic               nonexist_csr_excp_valid;// Exceptions for accessing invalid csr addr
  logic               read_only_excp_valid;
  orv64_prv_t         trap_prv_level;
  orv64_prv_t         trap_excp_level;
  orv64_prv_t         trap_int_level;
  logic               edeleg_to_s, edeleg_to_u;
  logic               do_deleg_excp_to_s, do_deleg_excp_to_u;
  logic               trap_to_s, trap_to_u;
  logic               trap_excp_valid, trap_excp_valid_unmasked;
  orv64_excp_cause_t  trap_excp_cause;
  logic               ideleg_to_s, ideleg_to_u;
  logic               do_deleg_int_to_s, do_deleg_int_to_u;
  logic               trap_valid;
  orv64_vaddr_t       trap_cause_pc;
  orv64_csr_trap_cause_t  trap_cause;

  orv64_data_t csr_wdata;

  logic hold_kill_ff;
  logic hold_cs2if_ff;

  assign cs2ma_excp.valid = trap_valid;
  assign cs2ma_excp.cause = trap_cause;

  //==========================================================
  // ICG {{{

  logic cs2if_clkg;
  logic en_cs2if;
  logic wfi_clkg, en_wfi;
  logic mie_clkg, en_mie;
  logic tval_clkg, en_tval, update_tval;
  logic epc_clkg, en_epc;
  logic fcsr_clkg, en_fcsr;
  logic csr_clkg, en_csr;
  logic hpm_clkg;

  assign en_wfi = is_wfi;

  assign en_fcsr = en_csr | (|ma2cs.fflags);

  assign en_csr = (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) | rst;
  assign en_epc = en_csr | trap_valid;

  assign en_tval = (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) | update_tval;
  assign en_cs2if = cs2if_npc.valid & ~hold_cs2if_ff;

  icg mie_clk_u(
    .en       (en_mie | rst),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (mie_clkg)
  );

  icg csr_clk_u(
    .en       (en_csr),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (csr_clkg)
  );

  icg fcsr_clk_u(
    .en       (en_fcsr),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fcsr_clkg)
  );

  icg epc_clk_u(
    .en       (en_epc),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (epc_clkg)
  );
 
  icg tval_clk_u(
    .en       (en_tval),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (tval_clkg)
  );

  icg wfi_clk_u(
    .en       (en_wfi),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (wfi_clkg)
  );

  icg cs2if_clk_u(
    .en       (en_cs2if),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (cs2if_clkg)
  );

  icg hpm_clk_u(
    .en       (cfg_en_hpmcounter),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (hpm_clkg)
  );

  // }}}

  //==========================================================
  // excpetion delegation check

  assign trap_excp_valid = trap_excp_valid_unmasked & translation_change_rdy;

  always_comb begin
    if (ma2cs_excp.valid) begin
      trap_excp_valid_unmasked = '1;
      trap_excp_cause =  ma2cs_excp.cause;
    end else if (internal_excp_valid | nonexist_csr_excp_valid | read_only_excp_valid) begin
      trap_excp_valid_unmasked = '1;
      trap_excp_cause =  ORV64_EXCP_CAUSE_ILLEGAL_INST;
    end else begin
      trap_excp_valid_unmasked = '0;
      trap_excp_cause = ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED;
    end
  end

  orv64_edeleg_checker medeleg_checker_u (
    .excp_valid(trap_excp_valid_unmasked),
    .excp_cause(trap_excp_cause),
    .edeleg(medeleg),
    .do_delegate(edeleg_to_s)
  );
  orv64_edeleg_checker sedeleg_checker_u (
    .excp_valid(trap_excp_valid_unmasked),
    .excp_cause(trap_excp_cause),
    .edeleg(sedeleg),
    .do_delegate(edeleg_to_u)
  );

  assign do_deleg_excp_to_s = edeleg_to_s & ((prv == ORV64_PRV_S) | (prv == ORV64_PRV_U));
  assign do_deleg_excp_to_u = edeleg_to_u & (prv == ORV64_PRV_U);

  always_comb begin
    if (do_deleg_excp_to_s) begin
      if (do_deleg_excp_to_u) begin
        trap_excp_level = ORV64_PRV_U;
      end else begin
        trap_excp_level = ORV64_PRV_S;
      end
    end else begin
      trap_excp_level = ORV64_PRV_M;
    end
  end

  //==========================================================
  // Interrupts

  assign en_m_int = ((prv == ORV64_PRV_M) & mstatus.MIE) | ((prv == ORV64_PRV_S) | (prv == ORV64_PRV_U));
  assign en_s_int = ((prv == ORV64_PRV_S) & mstatus.SIE) | (prv == ORV64_PRV_U);
  assign m_masked_int = (mip & mie) & ~mideleg & {$bits(orv64_csr_ip_t){en_m_int}};
  assign s_masked_int = (mip & mie) & mideleg & {$bits(orv64_csr_ip_t){en_s_int}};

  assign masked_int = (|m_masked_int) ? m_masked_int: s_masked_int;

  // Interrupts handled in fixed priority order
  always_comb begin
    if (masked_int.MEIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_M_EXT;
    end else if (masked_int.MSIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_M_SW;
    end else if (masked_int.MTIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_M_TIME;
    end else if (masked_int.SEIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_S_EXT;
    end else if (masked_int.SSIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_S_SW;
    end else if (masked_int.STIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_S_TIME;
    end else if (masked_int.UEIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_U_EXT;
    end else if (masked_int.USIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_U_SW;
    end else if (masked_int.UTIP) begin
      is_trapable_int_pending = '1;
      trap_int_cause = ORV64_INT_U_TIME;
    end else begin
      is_trapable_int_pending = '0;
      trap_int_cause = ORV64_INT_U_SW;
    end
  end

  assign int_stall = is_trapable_int_pending & ~if_has_amo_inst & ~id_has_amo_inst  & ~is_wfe_stall;
  assign trap_int_valid = is_trapable_int_pending & ((is_pipeline_stalled & stalled_for_int) | rff_wait_for_int) & translation_change_rdy;

  //==========================================================
  // Interrupt delegation check

  orv64_ideleg_checker mideleg_checker_u (
    .int_valid(trap_int_valid),
    .int_cause(trap_int_cause),
    .ideleg(mideleg),
    .do_delegate(ideleg_to_s)
  );

  orv64_ideleg_checker sideleg_checker_u (
    .int_valid(trap_int_valid),
    .int_cause(trap_int_cause),
    .ideleg(sideleg),
    .do_delegate(ideleg_to_u)
  );

  assign do_deleg_int_to_s = ideleg_to_s & ((prv == ORV64_PRV_S) | (prv == ORV64_PRV_U));
  assign do_deleg_int_to_u = ideleg_to_u & (prv == ORV64_PRV_U);

  always_comb begin
    if (do_deleg_int_to_s) begin
      if (do_deleg_int_to_u) begin
        trap_int_level = ORV64_PRV_U;
      end else begin
        trap_int_level = ORV64_PRV_S;
      end
    end else begin
      trap_int_level = ORV64_PRV_M;
    end
  end

  //==========================================================
  // Traps

  always_comb begin
    if (trap_excp_valid) begin
      trap_valid = '1;
      trap_prv_level = trap_excp_level;
      trap_cause = orv64_csr_trap_cause_t'({1'b0, 63'(trap_excp_cause)});
      trap_cause_pc = ma2cs.pc;
    end else if (trap_int_valid) begin
      trap_valid = '1;
      trap_cause = orv64_csr_trap_cause_t'({1'b1, 63'(trap_int_cause)});
      trap_prv_level = trap_int_level;
      trap_cause_pc = rff_wait_for_int ? (dff_wfi_pc + 'h4): id_pc;
    end else begin
      trap_valid = '0;
      trap_prv_level = prv;
      trap_cause = ORV64_TRAP_CAUSE_INST_ADDR_MISALIGNED;
      trap_cause_pc = ma2cs.pc;
    end
  end

  //==========================================================
  // Operation masking

  logic do_mask_out_csr_op;
  logic do_mask_out_ret_type;
  logic is_csr_op_modify_trans;

  always_comb begin
    case (ma2cs.csr_addr)
      ORV64_CSR_ADDR_MSTATUS,
      ORV64_CSR_ADDR_SSTATUS,
      ORV64_CSR_ADDR_SATP,
      ORV64_CSR_ADDR_PMPCFG0,
      ORV64_CSR_ADDR_PMPCFG1,
      ORV64_CSR_ADDR_PMPCFG2,
      ORV64_CSR_ADDR_PMPCFG3,
      ORV64_CSR_ADDR_PMPADDR0,
      ORV64_CSR_ADDR_PMPADDR1,
      ORV64_CSR_ADDR_PMPADDR2,
      ORV64_CSR_ADDR_PMPADDR3,
      ORV64_CSR_ADDR_PMPADDR4,
      ORV64_CSR_ADDR_PMPADDR5,
      ORV64_CSR_ADDR_PMPADDR6,
      ORV64_CSR_ADDR_PMPADDR7,
      ORV64_CSR_ADDR_PMPADDR8,
      ORV64_CSR_ADDR_PMPADDR9,
      ORV64_CSR_ADDR_PMPADDR10,
      ORV64_CSR_ADDR_PMPADDR11,
      ORV64_CSR_ADDR_PMPADDR12,
      ORV64_CSR_ADDR_PMPADDR13,
      ORV64_CSR_ADDR_PMPADDR14,
      ORV64_CSR_ADDR_PMPADDR15: begin
        is_csr_op_modify_trans = (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE);
      end
      default: begin
        is_csr_op_modify_trans = '0;
      end
    endcase
  end

  assign translation_change_vld = trap_excp_valid_unmasked | is_csr_op_modify_trans | (ma2cs_ctrl.ret_type != ORV64_RET_TYPE_NONE);
  assign do_mask_out_csr_op = (is_csr_op_modify_trans & ~translation_change_rdy) | trap_excp_valid_unmasked;
  assign do_mask_out_ret_type = ~translation_change_rdy;

  assign csr_op_masked = do_mask_out_csr_op ? ORV64_CSR_OP_NONE: ma2cs_ctrl.csr_op;
  assign ret_type_masked = do_mask_out_ret_type ? ORV64_RET_TYPE_NONE: ma2cs_ctrl.ret_type;


  //==========================================================
  // privilege level

  always_ff @ (posedge clk)
    if (rst) begin
      prv <= ORV64_PRV_M;
    end else begin
      if (trap_valid) begin
        prv <= trap_prv_level;
      end else if (ret_type_masked != ORV64_RET_TYPE_NONE) begin
        case (ret_type_masked) 
          ORV64_RET_TYPE_M: begin
            prv <= mstatus.MPP;
          end
          ORV64_RET_TYPE_S: begin
            prv <= orv64_prv_t'({1'b0, sstatus.SPP});
          end
          ORV64_RET_TYPE_U: begin
            prv <= ORV64_PRV_U;
          end
        endcase
      end
    end

  //==========================================================
  // interrupt

  assign is_int_pending = |(mip & mie);
  assign is_wfi = ma2cs_ctrl.is_wfi & ~trap_excp_valid_unmasked;
  assign wfi_stall = rff_wait_for_int;

  always_comb begin
    wfi_resume = '0;
    if (rff_wait_for_int) begin
      if (is_int_pending) begin
        if (is_trapable_int_pending) begin
          next_wait_for_int = ~trap_int_valid;
        end else begin
          wfi_resume = '1;
          next_wait_for_int = '0;
        end
      end else begin
        next_wait_for_int = rff_wait_for_int;
      end
    end else begin
      next_wait_for_int = is_wfi;
    end
  end

  always_ff @ (posedge clk) begin
    if (rst) begin
      rff_wait_for_int <= 1'b0;
    end else begin
      rff_wait_for_int <= next_wait_for_int;
    end
  end

  always_ff @ (posedge wfi_clkg) begin
    if (en_wfi) begin
      dff_wfi_pc <= ma2cs.pc;
    end
  end

  //==========================================================
  // kill
  assign is_kill = hold_kill_ff | trap_excp_valid_unmasked | (ma2cs_ctrl.ret_type != ORV64_RET_TYPE_NONE) | trap_int_valid | (is_wfi) | wfi_resume;
  
  always_ff @ (posedge clk)
    if (rst) begin
      hold_kill_ff <= 1'b0;
      hold_cs2if_ff <= 1'b0;
    end else begin
      hold_kill_ff <= is_kill & (~if_ready | ~id_ready | ~ex_ready | ~ma_ready);
      hold_cs2if_ff <= cs2if_npc.valid & (~if_ready | ~id_ready | ~ex_ready | ~ma_ready);
    end

  always_comb
    if (is_kill) begin
      cs2if_kill = 1'b1; cs2id_kill = 1'b1; cs2ex_kill = 1'b1; cs2ma_kill = 1'b0;
    end else begin
      cs2if_kill = 1'b0; cs2id_kill = 1'b0; cs2ex_kill = 1'b0; cs2ma_kill = 1'b0;
    end

  assign cs2ib_flush = (translation_change_vld & translation_change_rdy) | trap_int_valid;

  //==========================================================
  // trap vector pc

  orv64_npc_t cs2if_npc_saved_ff;
  orv64_csr_tvec_t trap_vector;
  orv64_vaddr_t tvec_excp_pc;
  orv64_vaddr_t tvec_int_pc;

  always_comb begin
    case (trap_prv_level)
      ORV64_PRV_U: begin
        trap_vector = utvec;
      end
      ORV64_PRV_S: begin
        trap_vector = stvec;
      end
      default: begin
        trap_vector = mtvec;
      end
    endcase
  end

  assign tvec_excp_pc = {trap_vector.base, 2'b00};
  assign tvec_int_pc = (trap_vector.mode == ORV64_CSR_TVEC_DIRECT) ? {trap_vector.base, 2'b00}: ({trap_vector.base, 2'b00} + (trap_int_cause << 2));

  //==========================================================
  // Status csr
  assign sstatus_mask.SD = 1'b1;
  assign sstatus_mask.BYPASS_IC = 1'b0;
  assign sstatus_mask.reserved_61_to_36 = 26'b0;
  assign sstatus_mask.SXL = 2'b0;
  assign sstatus_mask.UXL = 2'b11;
  assign sstatus_mask.reserved_31_to_23 = 9'b0;
  assign sstatus_mask.TSR = 1'b0;
  assign sstatus_mask.TW = 1'b0;
  assign sstatus_mask.TVM = 1'b0;
  assign sstatus_mask.MXR = 1'b1;
  assign sstatus_mask.SUM = 1'b1;
  assign sstatus_mask.MPRV = 1'b0;
  assign sstatus_mask.XS = 2'b11;
  assign sstatus_mask.FS = 2'b11;
  assign sstatus_mask.MPP = ORV64_PRV_U;
  assign sstatus_mask.reserved_10_to_9 = 2'b0;
  assign sstatus_mask.SPP = 1'b1;
  assign sstatus_mask.MPIE = 1'b0;
  assign sstatus_mask.reserved_6 = 1'b0;
  assign sstatus_mask.SPIE = 1'b1;
  assign sstatus_mask.UPIE = 1'b1;
  assign sstatus_mask.MIE = 1'b0;
  assign sstatus_mask.reserved_2 = 1'b0;
  assign sstatus_mask.SIE = 1'b1;
  assign sstatus_mask.UIE = 1'b1;

  assign ustatus_mask.SD = 1'b0;
  assign ustatus_mask.BYPASS_IC = 1'b0;
  assign ustatus_mask.reserved_61_to_36 = 26'b0;
  assign ustatus_mask.SXL = 2'b0;
  assign ustatus_mask.UXL = 2'b0;
  assign ustatus_mask.reserved_31_to_23 = 9'b0;
  assign ustatus_mask.TSR = 1'b0;
  assign ustatus_mask.TW = 1'b0;
  assign ustatus_mask.TVM = 1'b0;
  assign ustatus_mask.MXR = 1'b0;
  assign ustatus_mask.SUM = 1'b0;
  assign ustatus_mask.MPRV = 1'b0;
  assign ustatus_mask.XS = 2'b0;
  assign ustatus_mask.FS = 2'b0;
  assign ustatus_mask.MPP = ORV64_PRV_U;
  assign ustatus_mask.reserved_10_to_9 = 2'b0;
  assign ustatus_mask.SPP = 1'b0;
  assign ustatus_mask.MPIE = 1'b0;
  assign ustatus_mask.reserved_6 = 1'b0;
  assign ustatus_mask.SPIE = 1'b0;
  assign ustatus_mask.UPIE = 1'b1;
  assign ustatus_mask.MIE = 1'b0;
  assign ustatus_mask.reserved_2 = 1'b0;
  assign ustatus_mask.SIE = 1'b0;
  assign ustatus_mask.UIE = 1'b1;

  assign ustatus = mstatus & ustatus_mask;
  assign sstatus = mstatus & sstatus_mask;

  always_comb begin
    mstatus_next = mstatus;
    // exceptions
    if (trap_excp_valid_unmasked) begin
      // mstatus
      if (do_deleg_excp_to_s) begin
        if (do_deleg_excp_to_u) begin
          mstatus_next.UPIE = mstatus.UIE;
          mstatus_next.UIE = 1'b0;
        end else begin
          mstatus_next.SPIE = mstatus.SIE;
          mstatus_next.SIE = 1'b0;
          mstatus_next.SPP = (prv == ORV64_PRV_S) ? 1'b1: 1'b0;
        end
      end else begin
        mstatus_next.MPIE = mstatus.MIE;
        mstatus_next.MIE = 1'b0;
        mstatus_next.MPP = prv;
      end
    end else if (trap_int_valid) begin
      if (do_deleg_int_to_s) begin
        if (do_deleg_int_to_u) begin
          mstatus_next.UPIE = mstatus.UIE;
          mstatus_next.UIE = 1'b0;
        end else begin
          mstatus_next.SPIE = mstatus.SIE;
          mstatus_next.SIE = 1'b0;
          mstatus_next.SPP = (prv == ORV64_PRV_S) ? 1'b1: 1'b0;
        end
      end else begin
        mstatus_next.MPIE = mstatus.MIE;
        mstatus_next.MIE = 1'b0;
        mstatus_next.MPP = prv;
      end
    // xRET
    end else if (ma2cs_ctrl.ret_type != ORV64_RET_TYPE_NONE) begin
      if (ma2cs_ctrl.ret_type == ORV64_RET_TYPE_M) begin
        mstatus_next.MIE = mstatus.MPIE;
        mstatus_next.MPIE = 1'b1;
        mstatus_next.MPP = ORV64_PRV_U;
      end else if (ma2cs_ctrl.ret_type == ORV64_RET_TYPE_S) begin
        mstatus_next.SIE = mstatus.SPIE;
        mstatus_next.SPIE = 1'b1;
        mstatus_next.SPP = 1'b0;
      end else begin
        mstatus_next.UIE = mstatus.UPIE;
        mstatus_next.UPIE = 1'b1;
      end
    end else if ((ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_MSTATUS)) begin
      mstatus_next = csr_wdata;
    end else if ((ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_SSTATUS)) begin
      mstatus_next = (mstatus & ~sstatus_mask) | (csr_wdata & sstatus_mask);
    end else if ((ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_USTATUS)) begin
      mstatus_next = (mstatus & ~ustatus_mask) | (csr_wdata & ustatus_mask);
`ifdef ORV64_SUPPORT_FP
    end else if ((ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_FFLAGS)) begin
      mstatus_next.FS = 2'b11;
    end else if ((ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_FRM)) begin
      mstatus_next.FS = 2'b11;
    end else if ((ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_FCSR)) begin
      mstatus_next.FS = 2'b11;
`endif
    end
    mstatus_next.SD = (mstatus_next.FS != 2'b00) | (mstatus_next.XS != 2'b00);
    // Hardwired mstatus fields
    mstatus_next.SXL = 2'b10;
    mstatus_next.UXL = 2'b10;
    mstatus_next.XS = 2'b00;
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      mstatus <= 64'h0;
    end else begin
      if (translation_change_rdy) begin
        mstatus <= mstatus_next;
      end
    end
  end

  //==========================================================
  // CS2IF next pc

  assign cs2id_scb_rst = cs2if_npc.valid;

  always_comb begin
    if (hold_cs2if_ff) begin
      cs2if_npc = cs2if_npc_saved_ff;
    end else begin
      case (1'b1)
        // exceptions
        (trap_excp_valid): begin
          cs2if_npc.valid = 1'b1;
          cs2if_npc.pc = tvec_excp_pc;
        end
        (trap_int_valid): begin
          cs2if_npc.valid = 1'b1;
          cs2if_npc.pc = tvec_int_pc;
        end
        // xRET
        (ret_type_masked != ORV64_RET_TYPE_NONE): begin
          cs2if_npc.valid = 1'b1;
          if (ma2cs_ctrl.ret_type == ORV64_RET_TYPE_M) begin
            cs2if_npc.pc = mepc & pc_alignment_mask;
          end else if (ma2cs_ctrl.ret_type == ORV64_RET_TYPE_S) begin
            cs2if_npc.pc = sepc & pc_alignment_mask;
          end else begin
            cs2if_npc.pc = uepc & pc_alignment_mask;
          end
        end
        wfi_resume: begin
          cs2if_npc.valid = 1'b1;
          cs2if_npc.pc = dff_wfi_pc + 'h4;
        end
        default: begin
          cs2if_npc.valid = 1'b0;
          cs2if_npc.pc = mepc;
        end
      endcase
    end
  end

  always_ff @ (posedge cs2if_clkg) begin
    if (en_cs2if) begin
      cs2if_npc_saved_ff <= cs2if_npc;
    end
  end

  //==========================================================
  // n,s,u ie and ip setting

  always_comb begin
    uip_mask = '0;
    sip_mask = '0;

    uip_mask = (mideleg & sideleg);

    uip_mask.UEIP = '1;
    uip_mask.UTIP = '1;
    uip_mask.USIP = '1;

    sip_mask = mideleg;
    sip_mask.SEIP = '1;
    sip_mask.UEIP = '1;
    sip_mask.STIP = '1;
    sip_mask.UTIP = '1;
    sip_mask.SSIP = '1;
    sip_mask.USIP = '1;
  end

  always_comb begin
    uie_mask = '0;
    uie_mask.UEIE = '1;
    uie_mask.UTIE = '1;
    uie_mask.USIE = '1;

    sie_mask = '0;
    sie_mask.SEIE = '1;
    sie_mask.UEIE = '1;
    sie_mask.STIE = '1;
    sie_mask.UTIE = '1;
    sie_mask.SSIE = '1;
    sie_mask.USIE = '1;
  end

  always_ff @(posedge mie_clkg) begin
    if (rst) begin
      mie <= '0;
    end else begin
      if (en_mie) begin
        mie <= mie_next;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      mip <= '0;
    end else begin
      mip <= mip_next;
    end
  end

  always_comb begin
    mip_next = mip;
    if ((csr_op_masked != ORV64_CSR_OP_NONE) & (ma2cs.csr_addr == ORV64_CSR_ADDR_MIP)) begin
      mip_next = csr_wdata;
    end else if ((csr_op_masked != ORV64_CSR_OP_NONE) & (ma2cs.csr_addr == ORV64_CSR_ADDR_SIP)) begin
      mip_next = csr_wdata & sip_mask;
    end else if ((csr_op_masked != ORV64_CSR_OP_NONE) & (ma2cs.csr_addr == ORV64_CSR_ADDR_UIP)) begin
      mip_next = csr_wdata & uip_mask;
    end
    mip_next.MEIP = ext_int;
    mip_next.MTIP = timer_int;
    mip_next.MSIP = sw_int;
  end

  always_comb begin
    mie_next = mie;
    en_mie = '0;
    if ((csr_op_masked != ORV64_CSR_OP_NONE) & (ma2cs.csr_addr == ORV64_CSR_ADDR_MIE)) begin
      mie_next = csr_wdata;
      en_mie = '1;
    end else if ((csr_op_masked != ORV64_CSR_OP_NONE) & (ma2cs.csr_addr == ORV64_CSR_ADDR_SIE)) begin
      mie_next = (mie & ~sie_mask) | (csr_wdata & sie_mask);
      en_mie = '1;
    end else if ((csr_op_masked != ORV64_CSR_OP_NONE) & (ma2cs.csr_addr == ORV64_CSR_ADDR_UIE)) begin
      mie_next = (mie & ~uie_mask) | (csr_wdata & uie_mask);
      en_mie = '1;
    end
  end

  assign sip = mip & sip_mask;
  assign uip = mip & uip_mask;
  assign sie = mie & sie_mask;
  assign uie = mie & uie_mask;

  //==========================================================
  always_comb begin
    internal_excp_valid = '0;
    if (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) begin // CSR privilege access check
      if (((prv == ORV64_PRV_S) | (prv == ORV64_PRV_U)) & (ma2cs.csr_addr[9:8] == 2'b11)) begin
        internal_excp_valid = '1;
      end else if ((prv == ORV64_PRV_U) & (ma2cs.csr_addr[9:8] == 2'b01)) begin // CSR privilege access check
        internal_excp_valid = '1;
      end else if (mstatus.TVM & (prv == ORV64_PRV_S) & (ma2cs.csr_addr == ORV64_CSR_ADDR_SATP)) begin // TVM satp access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_CYCLE) & ~counteren.CY) begin // cycle access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_TIME) & ~counteren.TM) begin // time access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_INSTRET) & ~counteren.IR) begin // instret access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER3) & ~counteren.HPM3) begin // hpmcounter3 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER4) & ~counteren.HPM4) begin // hpmcounter4 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER5) & ~counteren.HPM5) begin // hpmcounter5 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER6) & ~counteren.HPM6) begin // hpmcounter6 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER7) & ~counteren.HPM7) begin // hpmcounter7 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER8) & ~counteren.HPM8) begin // hpmcounter8 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER9) & ~counteren.HPM9) begin // hpmcounter9 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER10) & ~counteren.HPM10) begin // hpmcounter10 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER11) & ~counteren.HPM11) begin // hpmcounter11 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER12) & ~counteren.HPM12) begin // hpmcounter12 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER13) & ~counteren.HPM13) begin // hpmcounter13 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER14) & ~counteren.HPM14) begin // hpmcounter14 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER15) & ~counteren.HPM15) begin // hpmcounter15 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER16) & ~counteren.HPM16) begin // hpmcounter16 access check
        internal_excp_valid = '1;
      end else if ((ma2cs.csr_addr == ORV64_CSR_ADDR_HPMCOUNTER17) & ~counteren.HPM17) begin // hpmcounter17 access check
        internal_excp_valid = '1;
      end
    end else if (mstatus.TW & ((prv == ORV64_PRV_U) | (prv == ORV64_PRV_S)) & ma2cs_ctrl.is_wfi) begin // TW check
      internal_excp_valid = '1;
    end
  end
      
  // read CSR
  always_comb begin
    cs2ma.csr = 64'b0;
    nonexist_csr_excp_valid = '0;
    if (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) begin
      case (ma2cs.csr_addr)
        ORV64_CSR_ADDR_MISA:      cs2ma.csr = {misa.MXL, 36'b0, misa.EXTENSIONS};
        //ORV64_CSR_ADDR_TIME,
        ORV64_CSR_ADDR_CYCLE,
        ORV64_CSR_ADDR_MCYCLE:    cs2ma.csr = mcycle;
        ORV64_CSR_ADDR_INSTRET,
        ORV64_CSR_ADDR_MINSTRET:  cs2ma.csr = minstret;
        ORV64_CSR_ADDR_MHARTID:   cs2ma.csr = {56'b0, mhartid};
        ORV64_CSR_ADDR_MSTATUS:   cs2ma.csr = mstatus;
        ORV64_CSR_ADDR_MEPC:      cs2ma.csr = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){mepc[ORV64_VIR_ADDR_WIDTH-1]}},mepc};
        ORV64_CSR_ADDR_MSCRATCH:  cs2ma.csr = mscratch;
        ORV64_CSR_ADDR_MTVEC:     cs2ma.csr = mtvec;
        ORV64_CSR_ADDR_MCAUSE:    cs2ma.csr = mcause;
        ORV64_CSR_ADDR_MIE:       cs2ma.csr = mie;
        ORV64_CSR_ADDR_MIP:       cs2ma.csr = mip; 
        ORV64_CSR_ADDR_MEDELEG:   cs2ma.csr = medeleg;
        ORV64_CSR_ADDR_MIDELEG:   cs2ma.csr = mideleg;
        ORV64_CSR_ADDR_MCOUNTEREN: cs2ma.csr = mcounteren;
        ORV64_CSR_ADDR_MTVAL:      cs2ma.csr = mtval;
        ORV64_CSR_ADDR_MCOUNTINHIBIT: cs2ma.csr = mcountinhibit;
        ORV64_CSR_ADDR_MIMPID: cs2ma.csr = mimpid;
        ORV64_CSR_ADDR_MARCHID: cs2ma.csr = marchid;
        ORV64_CSR_ADDR_MVENDORID: cs2ma.csr = mvendorid;

        ORV64_CSR_ADDR_SATP: cs2ma.csr = satp;
        ORV64_CSR_ADDR_PMPCFG0: cs2ma.csr = pmpcfg0;
        //ORV64_CSR_ADDR_PMPCFG1: cs2ma.csr = pmpcfg1;
        ORV64_CSR_ADDR_PMPCFG2: cs2ma.csr = pmpcfg2;
        //ORV64_CSR_ADDR_PMPCFG3: cs2ma.csr = pmpcfg3;
        ORV64_CSR_ADDR_PMPADDR0: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[0]};
        ORV64_CSR_ADDR_PMPADDR1: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[1]};
        ORV64_CSR_ADDR_PMPADDR2: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[2]};
        ORV64_CSR_ADDR_PMPADDR3: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[3]};
        ORV64_CSR_ADDR_PMPADDR4: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[4]};
        ORV64_CSR_ADDR_PMPADDR5: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[5]};
        ORV64_CSR_ADDR_PMPADDR6: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[6]};
        ORV64_CSR_ADDR_PMPADDR7: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[7]};
        ORV64_CSR_ADDR_PMPADDR8: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[8]};
        ORV64_CSR_ADDR_PMPADDR9: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[9]};
        ORV64_CSR_ADDR_PMPADDR10: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[10]};
        ORV64_CSR_ADDR_PMPADDR11: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[11]};
        ORV64_CSR_ADDR_PMPADDR12: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[12]};
        ORV64_CSR_ADDR_PMPADDR13: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[13]};
        ORV64_CSR_ADDR_PMPADDR14: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[14]};
        ORV64_CSR_ADDR_PMPADDR15: cs2ma.csr = {{(ORV64_XLEN-$bits(orv64_csr_pmpaddr_t)){1'b0}}, pmpaddr[15]};
        // S MODE REGISTERS
        ORV64_CSR_ADDR_SSTATUS: cs2ma.csr = sstatus;
        ORV64_CSR_ADDR_STVEC: cs2ma.csr = stvec;
        ORV64_CSR_ADDR_SCAUSE: cs2ma.csr = scause;
        ORV64_CSR_ADDR_SEPC: cs2ma.csr = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){sepc[ORV64_VIR_ADDR_WIDTH-1]}},sepc};
        ORV64_CSR_ADDR_STVAL: cs2ma.csr =  stval;
        ORV64_CSR_ADDR_SSCRATCH: cs2ma.csr = sscratch;
        ORV64_CSR_ADDR_SCOUNTEREN: cs2ma.csr = scounteren;
        ORV64_CSR_ADDR_SIE:       cs2ma.csr = sie;
        ORV64_CSR_ADDR_SIP:       cs2ma.csr = sip;
        ORV64_CSR_ADDR_SEDELEG:   cs2ma.csr = sedeleg;
        ORV64_CSR_ADDR_SIDELEG:   cs2ma.csr = sideleg;

        // U MODE REGISTERS
        ORV64_CSR_ADDR_USTATUS: cs2ma.csr = ustatus;
        ORV64_CSR_ADDR_UTVEC: cs2ma.csr = utvec;
        ORV64_CSR_ADDR_UEPC: cs2ma.csr = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){uepc[ORV64_VIR_ADDR_WIDTH-1]}},uepc};
        ORV64_CSR_ADDR_UCAUSE: cs2ma.csr = ucause;
        ORV64_CSR_ADDR_UTVAL: cs2ma.csr = utval;
        ORV64_CSR_ADDR_USCRATCH: cs2ma.csr = uscratch;

        ORV64_CSR_ADDR_HPMCOUNTER3,
        ORV64_CSR_ADDR_MHPMCOUNTER3: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter3};
        ORV64_CSR_ADDR_HPMCOUNTER4,
        ORV64_CSR_ADDR_MHPMCOUNTER4: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter4};
        ORV64_CSR_ADDR_HPMCOUNTER5,
        ORV64_CSR_ADDR_MHPMCOUNTER5: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter5};
        ORV64_CSR_ADDR_HPMCOUNTER6,
        ORV64_CSR_ADDR_MHPMCOUNTER6: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter6};
        ORV64_CSR_ADDR_HPMCOUNTER7,
        ORV64_CSR_ADDR_MHPMCOUNTER7: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter7};
        ORV64_CSR_ADDR_HPMCOUNTER8,
        ORV64_CSR_ADDR_MHPMCOUNTER8: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter8};
        ORV64_CSR_ADDR_HPMCOUNTER9,
        ORV64_CSR_ADDR_MHPMCOUNTER9: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter9};
        ORV64_CSR_ADDR_HPMCOUNTER10,
        ORV64_CSR_ADDR_MHPMCOUNTER10: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter10};
        ORV64_CSR_ADDR_HPMCOUNTER11,
        ORV64_CSR_ADDR_MHPMCOUNTER11: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter11};
        ORV64_CSR_ADDR_HPMCOUNTER12,
        ORV64_CSR_ADDR_MHPMCOUNTER12: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter12};
        ORV64_CSR_ADDR_HPMCOUNTER13,
        ORV64_CSR_ADDR_MHPMCOUNTER13: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter13};
        ORV64_CSR_ADDR_HPMCOUNTER14,
        ORV64_CSR_ADDR_MHPMCOUNTER14: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter14};
        ORV64_CSR_ADDR_HPMCOUNTER15,
        ORV64_CSR_ADDR_MHPMCOUNTER15: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter15};
        ORV64_CSR_ADDR_HPMCOUNTER16,
        ORV64_CSR_ADDR_MHPMCOUNTER16: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter16};
        ORV64_CSR_ADDR_HPMCOUNTER17,
        ORV64_CSR_ADDR_MHPMCOUNTER17: cs2ma.csr = {{(ORV64_XLEN-ORV64_CNTR_WIDTH){1'b0}}, hpmcounter17};

        ORV64_CSR_ADDR_MHPMCOUNTER18, ORV64_CSR_ADDR_HPMCOUNTER18,
        ORV64_CSR_ADDR_MHPMCOUNTER19, ORV64_CSR_ADDR_HPMCOUNTER19,
        ORV64_CSR_ADDR_MHPMCOUNTER20, ORV64_CSR_ADDR_HPMCOUNTER20,
        ORV64_CSR_ADDR_MHPMCOUNTER21, ORV64_CSR_ADDR_HPMCOUNTER21,
        ORV64_CSR_ADDR_MHPMCOUNTER22, ORV64_CSR_ADDR_HPMCOUNTER22,
        ORV64_CSR_ADDR_MHPMCOUNTER23, ORV64_CSR_ADDR_HPMCOUNTER23,
        ORV64_CSR_ADDR_MHPMCOUNTER24, ORV64_CSR_ADDR_HPMCOUNTER24,
        ORV64_CSR_ADDR_MHPMCOUNTER25, ORV64_CSR_ADDR_HPMCOUNTER25,
        ORV64_CSR_ADDR_MHPMCOUNTER26, ORV64_CSR_ADDR_HPMCOUNTER26,
        ORV64_CSR_ADDR_MHPMCOUNTER27, ORV64_CSR_ADDR_HPMCOUNTER27,
        ORV64_CSR_ADDR_MHPMCOUNTER28, ORV64_CSR_ADDR_HPMCOUNTER28,
        ORV64_CSR_ADDR_MHPMCOUNTER29, ORV64_CSR_ADDR_HPMCOUNTER29,
        ORV64_CSR_ADDR_MHPMCOUNTER30, ORV64_CSR_ADDR_HPMCOUNTER30,
        ORV64_CSR_ADDR_MHPMCOUNTER31, ORV64_CSR_ADDR_HPMCOUNTER31,
        ORV64_CSR_ADDR_MHPMEVENT3,
        ORV64_CSR_ADDR_MHPMEVENT4,
        ORV64_CSR_ADDR_MHPMEVENT5,
        ORV64_CSR_ADDR_MHPMEVENT6,
        ORV64_CSR_ADDR_MHPMEVENT7,
        ORV64_CSR_ADDR_MHPMEVENT8,
        ORV64_CSR_ADDR_MHPMEVENT9,
        ORV64_CSR_ADDR_MHPMEVENT10,
        ORV64_CSR_ADDR_MHPMEVENT11,
        ORV64_CSR_ADDR_MHPMEVENT12,
        ORV64_CSR_ADDR_MHPMEVENT13,
        ORV64_CSR_ADDR_MHPMEVENT14,
        ORV64_CSR_ADDR_MHPMEVENT15,
        ORV64_CSR_ADDR_MHPMEVENT16,
        ORV64_CSR_ADDR_MHPMEVENT17,
        ORV64_CSR_ADDR_MHPMEVENT18,
        ORV64_CSR_ADDR_MHPMEVENT19,
        ORV64_CSR_ADDR_MHPMEVENT20,
        ORV64_CSR_ADDR_MHPMEVENT21,
        ORV64_CSR_ADDR_MHPMEVENT22,
        ORV64_CSR_ADDR_MHPMEVENT23,
        ORV64_CSR_ADDR_MHPMEVENT24,
        ORV64_CSR_ADDR_MHPMEVENT25,
        ORV64_CSR_ADDR_MHPMEVENT26,
        ORV64_CSR_ADDR_MHPMEVENT27,
        ORV64_CSR_ADDR_MHPMEVENT28,
        ORV64_CSR_ADDR_MHPMEVENT29,
        ORV64_CSR_ADDR_MHPMEVENT30,
        ORV64_CSR_ADDR_MHPMEVENT31: cs2ma.csr = '0;


`ifdef ORV64_SUPPORT_FP
        ORV64_CSR_ADDR_FFLAGS:    cs2ma.csr = {59'b0, fcsr.fflags};
        ORV64_CSR_ADDR_FRM:       cs2ma.csr = {61'b0, fcsr.frm};
        ORV64_CSR_ADDR_FCSR:      cs2ma.csr = {24'b0, fcsr.frm, fcsr.fflags};
`endif // ORV64_SUPPORT_FP


`ifdef ORV64_SUPPORT_DMA
        ORV64_CSR_ADDR_DMA_DONE: cs2ma.csr = {{(64-4){1'b0}}, dma2mp_ch3_done, dma2mp_ch2_done, dma2mp_ch1_done, dma2mp_ch0_done};
`endif
        default: begin
          nonexist_csr_excp_valid = '1;
        end
      endcase
    end
  end
  
// `ifndef SYNTHESIS
//   access_undefined_csr: assert property (@(posedge clk)
//     (ma2cs_ctrl.csr_op != ORV64_CSR_OP_NONE) |-> (ma2cs.csr_addr inside {ORV64_CSR_ADDR_MISA, ORV64_CSR_ADDR_CYCLE, ORV64_CSR_ADDR_MCYCLE, ORV64_CSR_ADDR_INSTRET, ORV64_CSR_ADDR_MINSTRET, ORV64_CSR_ADDR_MHARTID, ORV64_CSR_ADDR_MSTATUS, ORV64_CSR_ADDR_MEPC, ORV64_CSR_ADDR_MSCRATCH, ORV64_CSR_ADDR_MTVEC, ORV64_CSR_ADDR_MCAUSE, ORV64_CSR_ADDR_MIE, ORV64_CSR_ADDR_MIP, ORV64_CSR_ADDR_MEDELEG, ORV64_CSR_ADDR_MIDELEG, ORV64_CSR_ADDR_MCOUNTEREN, ORV64_CSR_ADDR_HPMCOUNTER3, ORV64_CSR_ADDR_HPMCOUNTER4, ORV64_CSR_ADDR_HPMCOUNTER5, ORV64_CSR_ADDR_HPMCOUNTER6, ORV64_CSR_ADDR_HPMCOUNTER7, ORV64_CSR_ADDR_HPMCOUNTER8, ORV64_CSR_ADDR_HPMCOUNTER9, ORV64_CSR_ADDR_HPMCOUNTER10, ORV64_CSR_ADDR_FCSR}))
//     else $warning("ORV_WARNING: accessing undefined CSR %s", ma2cs.csr_addr.name());
// `endif

  //==========================================================
  // write CSR
  always_comb begin
    case (ma2cs_ctrl.csr_op)
      ORV64_CSR_OP_RW: begin
        csr_wdata = ma2cs.csr_wdata;
        read_only_excp_valid = (ma2cs.csr_addr[11:10] == 2'b11);
      end
      ORV64_CSR_OP_RS: begin
        csr_wdata = ma2cs.csr_wdata | cs2ma.csr;
        read_only_excp_valid = (ma2cs.csr_addr[11:10] == 2'b11) & (ma2cs.rs1_addr != 5'h00);
      end
      ORV64_CSR_OP_RC: begin
        csr_wdata = ~ma2cs.csr_wdata & cs2ma.csr;
        read_only_excp_valid = (ma2cs.csr_addr[11:10] == 2'b11) & (ma2cs.rs1_addr != 5'h00);
      end
      default: begin
        csr_wdata = ma2cs.csr_wdata;
        read_only_excp_valid = 1'b0;
      end
    endcase
  end

  //==========================================================
  // CSR op

  always_ff @ (posedge csr_clkg) begin
    if (rst) begin
      misa.MXL <= 2'b10;
      misa.EXTENSIONS.A <= 1'b1;
      misa.EXTENSIONS.B <= 1'b0;
      misa.EXTENSIONS.C <= 1'b1;
      misa.EXTENSIONS.D <= 1'b1;
      misa.EXTENSIONS.E <= 1'b0;
      misa.EXTENSIONS.F <= 1'b1;
      misa.EXTENSIONS.G <= 1'b0;
      misa.EXTENSIONS.H <= 1'b0;
      misa.EXTENSIONS.I <= 1'b1;
      misa.EXTENSIONS.J <= 1'b0;
      misa.EXTENSIONS.K <= 1'b0;
      misa.EXTENSIONS.L <= 1'b0;
      misa.EXTENSIONS.M <= 1'b1;
`ifdef VCS
      misa.EXTENSIONS.N <= 1'b0;
`else
      misa.EXTENSIONS.N <= 1'b1;
`endif
      misa.EXTENSIONS.O <= 1'b0;
      misa.EXTENSIONS.P <= 1'b0;
      misa.EXTENSIONS.Q <= 1'b0;
      misa.EXTENSIONS.R <= 1'b0;
      misa.EXTENSIONS.S <= 1'b1;
      misa.EXTENSIONS.T <= 1'b0;
      misa.EXTENSIONS.U <= 1'b1;
      misa.EXTENSIONS.V <= 1'b0;
      misa.EXTENSIONS.W <= 1'b0;
      misa.EXTENSIONS.X <= 1'b0;
      misa.EXTENSIONS.Y <= 1'b0;
      misa.EXTENSIONS.Z <= 1'b0;
      //mstatus <= 'b0;
      mtvec <= 'b0;
      mscratch <= 'b0;
      //mie <= 'b0;
      //mip <= 'b0;
      medeleg <= 'b0;
      mideleg <= 'b0;
      mcounteren <= '0;

      mcountinhibit <= '0;
      mimpid <= '0;
      marchid <= '0;
      mvendorid <= '0;

      stvec <= '0;
      //sstatus <= '0;
      //sie <= 'b0;
      //sip <= 'b0;
      scounteren <= '0;
      sedeleg <= '0;
      sideleg <= '0;

      satp <= '0;
      pmpcfg0 <= '0;
      //pmpcfg1 <= '0;
      pmpcfg2 <= '0;
      //pmpcfg3 <= '0;
      pmpaddr[0] <= '0;
      pmpaddr[1] <= '0;
      pmpaddr[2] <= '0;
      pmpaddr[3] <= '0;
      pmpaddr[4] <= '0;
      pmpaddr[5] <= '0;
      pmpaddr[6] <= '0;
      pmpaddr[7] <= '0;
      pmpaddr[8] <= '0;
      pmpaddr[9] <= '0;
      pmpaddr[10] <= '0;
      pmpaddr[11] <= '0;
      pmpaddr[12] <= '0;
      pmpaddr[13] <= '0;
      pmpaddr[14] <= '0;
      pmpaddr[15] <= '0;

      //ustatus <= '0;
      utvec <= '0;
      uscratch <= '0;

    end else begin
      if (en_csr) begin
        if ((csr_op_masked != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready) begin
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MISA) begin
            misa.MXL <= csr_wdata[63:62]; // TODO: warl field
            // TODO: add empty wlrl field
            misa.EXTENSIONS <= misa_ext_wdata; // TODO: warl field
          end
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_MSTATUS)   mstatus <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MSCRATCH)  mscratch <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MTVEC)     mtvec <= csr_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_MIE)       mie <= csr_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_MIP)       mip <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MEDELEG)   medeleg <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MIDELEG)   mideleg <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MCOUNTEREN) mcounteren <= orv64_csr_counteren_t'(csr_wdata);
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MCOUNTINHIBIT) mcountinhibit <= csr_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_MIMPID)    mimpid <= csr_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_MARCHID)    marchid <= csr_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_MVENDORID)    mvendorid <= csr_wdata;
  
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_SATP) satp <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPCFG0) pmpcfg0 <= pmpcfg_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPCFG1) pmpcfg1 <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPCFG2) pmpcfg2 <= pmpcfg_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPCFG3) pmpcfg3 <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR0) pmpaddr[0] <= block_pmpaddr_wr ? pmpaddr[0] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR1) pmpaddr[1] <= block_pmpaddr_wr ? pmpaddr[1] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR2) pmpaddr[2] <= block_pmpaddr_wr ? pmpaddr[2] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR3) pmpaddr[3] <= block_pmpaddr_wr ? pmpaddr[3] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR4) pmpaddr[4] <= block_pmpaddr_wr ? pmpaddr[4] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR5) pmpaddr[5] <= block_pmpaddr_wr ? pmpaddr[5] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR6) pmpaddr[6] <= block_pmpaddr_wr ? pmpaddr[6] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR7) pmpaddr[7] <= block_pmpaddr_wr ? pmpaddr[7] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR8) pmpaddr[8] <= block_pmpaddr_wr ? pmpaddr[8] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR9) pmpaddr[9] <= block_pmpaddr_wr ? pmpaddr[9] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR10) pmpaddr[10] <= block_pmpaddr_wr ? pmpaddr[10] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR11) pmpaddr[11] <= block_pmpaddr_wr ? pmpaddr[11] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR12) pmpaddr[12] <= block_pmpaddr_wr ? pmpaddr[12] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR13) pmpaddr[13] <= block_pmpaddr_wr ? pmpaddr[13] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR14) pmpaddr[14] <= block_pmpaddr_wr ? pmpaddr[14] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPADDR15) pmpaddr[15] <= block_pmpaddr_wr ? pmpaddr[15] :csr_wdata[$bits(orv64_csr_pmpaddr_t)-1:0];
  
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_SSTATUS) sstatus <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_STVEC) stvec <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_SSCRATCH) sscratch <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_SCOUNTEREN) scounteren <= orv64_csr_counteren_t'(csr_wdata);
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_SIE)       sie <= csr_wdata;
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_SIP)       sip <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_SEDELEG)   sedeleg <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_SIDELEG)   sideleg <= csr_wdata;
  
          //if (ma2cs.csr_addr == ORV64_CSR_ADDR_USTATUS) ustatus <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_UTVEC) utvec <= csr_wdata;
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_USCRATCH) uscratch <= csr_wdata;
        end
      end
    end
  end

`ifdef ORV64_SUPPORT_FP
  always_ff @(posedge fcsr_clkg) begin
    if (rst) begin
      fcsr.frm <= ORV64_FRM_RNE;
      fcsr.fflags <= 'b0;
    end else begin
      if (en_fcsr) begin
        if ((csr_op_masked != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready) begin
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_FFLAGS)  fcsr.fflags <= csr_wdata[4:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_FRM)     fcsr.frm <= orv64_frm_t'(csr_wdata[$bits(fcsr.frm)-1:0]);
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_FCSR) begin
            fcsr.frm <= orv64_frm_t'(csr_wdata[7:5]);
            fcsr.fflags <= csr_wdata[4:0];
          end
        end else begin
          fcsr.fflags <= fcsr.fflags | ma2cs.fflags;
        end
      end
    end
  end
`endif // ORV64_SUPPORT_FP


  always_ff @ (posedge epc_clkg)
    if (rst) begin
      mepc <= '0;
      mcause <= orv64_csr_trap_cause_t'('b0);
      sepc <= '0;
      scause <= orv64_csr_trap_cause_t'('b0);
      uepc <= '0;
      ucause <= orv64_csr_trap_cause_t'('b0);
    end else begin
      if (en_epc) begin
        if (trap_valid) begin
          case (trap_prv_level)
            ORV64_PRV_U: begin
              uepc <= trap_cause_pc;
              ucause <= trap_cause;
            end
            ORV64_PRV_S: begin
              sepc <= trap_cause_pc;
              scause <= trap_cause;
            end
            default: begin
              mepc <= trap_cause_pc;
              mcause <= trap_cause;
            end
          endcase
        end else begin
          if (csr_op_masked != ORV64_CSR_OP_NONE) begin
            if (ma2cs.csr_addr == ORV64_CSR_ADDR_MEPC)
              mepc <= csr_wdata;
            if (ma2cs.csr_addr == ORV64_CSR_ADDR_MCAUSE)
              mcause <= orv64_csr_trap_cause_t'(csr_wdata);
            if (ma2cs.csr_addr == ORV64_CSR_ADDR_SEPC) 
              sepc <= csr_wdata;
            if (ma2cs.csr_addr == ORV64_CSR_ADDR_SCAUSE)
              scause <= orv64_csr_trap_cause_t'(csr_wdata);
            if (ma2cs.csr_addr == ORV64_CSR_ADDR_UEPC) 
              uepc <= csr_wdata;
            if (ma2cs.csr_addr == ORV64_CSR_ADDR_UCAUSE)
              ucause <= orv64_csr_trap_cause_t'(csr_wdata);
          end
        end
      end
    end

  `ifndef SYNTHESIS
    orv64_data_t mstatus_plain, mstatus_next_plain, mcause_plain, mtvec_plain;
    assign mstatus_plain = mstatus;
    assign mstatus_next_plain = mstatus_next;
    assign mcause_plain = mcause;
    assign mtvec_plain = mtvec;
    //always @(*) begin
    //  if (trap_valid && (trap_cause == ORV64_TRAP_CAUSE_STORE_ADDR_MISALIGNED)) begin
    //    `olog_error("ORV64_CSR",$sformatf("ORV64_TRAP_CAUSE_STORE_ADDR_MISALIGNED."));
    //  end
    //end
  `endif

  always_ff @(posedge tval_clkg) begin
    if (en_tval) begin
      if ((csr_op_masked != ORV64_CSR_OP_NONE) & ~trap_valid & wb_ready) begin
        if (ma2cs.csr_addr == ORV64_CSR_ADDR_STVAL) stval <= csr_wdata;
        if (ma2cs.csr_addr == ORV64_CSR_ADDR_MTVAL) mtval <= csr_wdata;
        if (ma2cs.csr_addr == ORV64_CSR_ADDR_UTVAL) utval <= csr_wdata;
      end else begin
        mtval <= mtval_next;
        stval <= stval_next;
        utval <= utval_next;
      end
    end
  end
 
  orv64_vaddr_t tval_npc;
  assign tval_npc = ma2cs_excp.is_half1 ? ma2cs.pc: ma2cs.pc + 'h2;
  always_comb begin
    if (trap_valid) begin
      if ((trap_cause == ORV64_TRAP_CAUSE_BREAKPOINT) |
          (trap_cause == ORV64_TRAP_CAUSE_INST_ADDR_MISALIGNED) | 
          (trap_cause == ORV64_TRAP_CAUSE_INST_PAGE_FAULT) |
          (trap_cause == ORV64_TRAP_CAUSE_INST_ACCESS_FAULT)) begin
        //tval_next = ma2cs.pc;
        
        tval_next = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){tval_npc[ORV64_VIR_ADDR_WIDTH-1]}},tval_npc};

      end else if ((trap_cause == ORV64_TRAP_CAUSE_LOAD_ADDR_MISALIGNED) | 
                   (trap_cause == ORV64_TRAP_CAUSE_STORE_ADDR_MISALIGNED) | 
                   (trap_cause == ORV64_TRAP_CAUSE_LOAD_PAGE_FAULT) | 
                   (trap_cause == ORV64_TRAP_CAUSE_STORE_PAGE_FAULT)) begin
        tval_next = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){ma2cs.mem_addr[ORV64_VIR_ADDR_WIDTH-1]}},ma2cs.mem_addr};
      end else if ((trap_cause == ORV64_TRAP_CAUSE_LOAD_ACCESS_FAULT) | 
                   (trap_cause == ORV64_TRAP_CAUSE_STORE_ACCESS_FAULT)) begin
        tval_next = {{(ORV64_XLEN-ORV64_VIR_ADDR_WIDTH){ma2cs.mem_addr[ORV64_VIR_ADDR_WIDTH-1]}},ma2cs.mem_addr};

      end else if (trap_cause == ORV64_TRAP_CAUSE_ILLEGAL_INST) begin
        tval_next = ma2cs_excp.inst;
      end else begin
        tval_next = '0;
      end
    end else begin
      tval_next = '0;
    end
  end

  always_comb begin
    utval_next = utval;
    stval_next = stval;
    mtval_next = mtval;
    update_tval = '0;
    if (trap_valid) begin
      update_tval = '1;
      case (trap_prv_level)
        ORV64_PRV_U: begin
          utval_next = tval_next;
        end
        ORV64_PRV_S: begin
          stval_next = tval_next;
        end
        default: begin
          mtval_next = tval_next;
        end
      endcase
    end
  end


  always_comb begin
    case (prv)
      ORV64_PRV_U: begin
        counteren = mcounteren & scounteren;
      end
      ORV64_PRV_S: begin
        counteren = mcounteren;
      end
      default: begin
        counteren = orv64_csr_counteren_t'('1);
      end
    endcase
  end

  assign current_pmpcfg = (ma2cs.csr_addr == ORV64_CSR_ADDR_PMPCFG0) ? pmpcfg0: pmpcfg2;

  always_comb begin
    for (int i=0; i<ORV64_N_FIELDS_PMPCFG; i++) begin
      pmpcfg_mask.pmpcfg[i] = current_pmpcfg.pmpcfg[i].l ? {($bits(orv64_csr_pmpcfg_part_t)){1'b0}}: {($bits(orv64_csr_pmpcfg_part_t)){1'b1}};
    end
  end

  always_comb begin
    pmpcfg_wdata = (csr_wdata & pmpcfg_mask) | (current_pmpcfg & ~pmpcfg_mask);
  end

  generate
    for (genvar i = 0; i < 8; i++) begin
      assign pmpcfg[i] = pmpcfg0.pmpcfg[i];
    end
    for (genvar i = 0; i < 8; i++) begin
      assign pmpcfg[i+8] = pmpcfg2.pmpcfg[i];
    end
  endgenerate


  always_comb begin
    case (ma2cs.csr_addr)
      ORV64_CSR_ADDR_PMPADDR0: begin
        block_pmpaddr_wr = pmpcfg[0].l | (pmpcfg[1].l & (pmpcfg[1].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR1: begin
        block_pmpaddr_wr = pmpcfg[1].l | (pmpcfg[2].l & (pmpcfg[2].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR2: begin
        block_pmpaddr_wr = pmpcfg[2].l | (pmpcfg[3].l & (pmpcfg[3].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR3: begin
        block_pmpaddr_wr = pmpcfg[3].l | (pmpcfg[4].l & (pmpcfg[4].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR4: begin
        block_pmpaddr_wr = pmpcfg[4].l | (pmpcfg[5].l & (pmpcfg[5].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR5: begin
        block_pmpaddr_wr = pmpcfg[5].l | (pmpcfg[6].l & (pmpcfg[6].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR6: begin
        block_pmpaddr_wr = pmpcfg[6].l | (pmpcfg[7].l & (pmpcfg[7].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR7: begin
        block_pmpaddr_wr = pmpcfg[7].l | (pmpcfg[8].l & (pmpcfg[8].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR8: begin
        block_pmpaddr_wr = pmpcfg[8].l | (pmpcfg[9].l & (pmpcfg[9].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR9: begin
        block_pmpaddr_wr = pmpcfg[9].l | (pmpcfg[10].l & (pmpcfg[10].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR10: begin
        block_pmpaddr_wr = pmpcfg[10].l | (pmpcfg[11].l & (pmpcfg[11].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR11: begin
        block_pmpaddr_wr = pmpcfg[11].l | (pmpcfg[12].l & (pmpcfg[12].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR12: begin
        block_pmpaddr_wr = pmpcfg[12].l | (pmpcfg[13].l & (pmpcfg[13].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR13: begin
        block_pmpaddr_wr = pmpcfg[13].l | (pmpcfg[14].l & (pmpcfg[14].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR14: begin
        block_pmpaddr_wr = pmpcfg[14].l | (pmpcfg[15].l & (pmpcfg[15].a == ORV64_TOR));
      end
      ORV64_CSR_ADDR_PMPADDR15: begin
        block_pmpaddr_wr = pmpcfg[15].l;
      end
      default: begin
        block_pmpaddr_wr = '0;
      end
    endcase
  end

  always_comb begin
    misa_ext_wdata = csr_wdata[25:0];
    if (ma2cs.pc[1:0] == 2'b00) begin
      if (ma2cs.is_rvc) begin
        misa_ext_wdata.C = misa.EXTENSIONS.C;
      end
    end else begin
      if (~ma2cs.is_rvc) begin
        misa_ext_wdata.C = misa.EXTENSIONS.C;
      end
    end
  end  

  always_comb begin
    pc_alignment_mask = '1;
    if (~misa.EXTENSIONS.C) begin
      pc_alignment_mask[1:0] = 2'b00;
    end
  end

  //==========================================================
  // Free running CSR counters
  
  // mcycle
  always_ff @ (posedge clk) begin
    if (rst) begin
      mcycle <= '0;
    end else begin
      if ((csr_op_masked != ORV64_CSR_OP_NONE) & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_MCYCLE)) begin
        mcycle <= csr_wdata;
      end else begin
        mcycle <= mcycle + 64'h1;
      end
    end
  end

  // minstret
  always_ff @ (posedge clk) begin
    if (rst) begin
      minstret <= 'b0;
    end else begin
      if ((csr_op_masked != ORV64_CSR_OP_NONE) & wb_ready & (ma2cs.csr_addr == ORV64_CSR_ADDR_MINSTRET)) begin
        minstret <= csr_wdata;
      end else begin
        if (~trap_valid) begin
          minstret <= minstret + (retiring_inst ? 64'h1: 64'h0);
        end
      end
    end
  end



  always_ff @(posedge hpm_clkg) begin
    if (rst) begin
      hpmcounter3 <= '0;
      hpmcounter4 <= '0;
      hpmcounter5 <= '0;
      hpmcounter6 <= '0;
      hpmcounter7 <= '0;
      hpmcounter8 <= '0;
      hpmcounter9 <= '0;
      hpmcounter10 <= '0;
      hpmcounter11 <= '0;
      hpmcounter12 <= '0;
      hpmcounter13 <= '0;
      hpmcounter14 <= '0;
      hpmcounter15 <= '0;
      hpmcounter16 <= '0;
      hpmcounter17 <= '0;
    end else begin
      if (cfg_en_hpmcounter) begin
        if (wait_for_npc & ~mcountinhibit.HPM3)
          hpmcounter3 <= hpmcounter3 + orv64_cntr_t'('h1);
        if (wait_for_reg & ~mcountinhibit.HPM4)
          hpmcounter4 <= hpmcounter4 + orv64_cntr_t'('h1);
        if (is_kill & ~mcountinhibit.HPM5)
          hpmcounter5 <= hpmcounter5 + orv64_cntr_t'('h1);
        if (wait_for_icr & ~mcountinhibit.HPM6)
          hpmcounter6 <= hpmcounter6 + orv64_cntr_t'('h1);
        if (wait_for_dcr & ~mcountinhibit.HPM7)
          hpmcounter7 <= hpmcounter7 + orv64_cntr_t'('h1);
        if (wait_for_ex & ~mcountinhibit.HPM8)
          hpmcounter8 <= hpmcounter8 + orv64_cntr_t'('h1);
        if (ic_hit & ~mcountinhibit.HPM9)
          hpmcounter9 <= hpmcounter9 + orv64_cntr_t'('h1);
        if (ic_miss & ~mcountinhibit.HPM10)
          hpmcounter10 <= hpmcounter10 + orv64_cntr_t'('h1);
        if (itlb_hit & ~mcountinhibit.HPM11)
          hpmcounter11 <= hpmcounter11 + orv64_cntr_t'('h1);
        if (itlb_miss & ~mcountinhibit.HPM12)
          hpmcounter12 <= hpmcounter12 + orv64_cntr_t'('h1);
        if (dtlb_hit & ~mcountinhibit.HPM13)
          hpmcounter13 <= hpmcounter13 + orv64_cntr_t'('h1);
        if (dtlb_miss & ~mcountinhibit.HPM14)
          hpmcounter14 <= hpmcounter14 + orv64_cntr_t'('h1);
        if (wait_for_dcw & ~mcountinhibit.HPM17)
          hpmcounter17 <= hpmcounter17 + orv64_cntr_t'('h1);
  
        if ((csr_op_masked != ORV64_CSR_OP_NONE) & wb_ready) begin
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER3) hpmcounter3 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER4) hpmcounter4 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER5) hpmcounter5 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER6) hpmcounter6 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER7) hpmcounter7 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER8) hpmcounter8 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER9) hpmcounter9 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER10) hpmcounter10 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER11) hpmcounter11 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER12) hpmcounter12 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER13) hpmcounter13 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER14) hpmcounter14 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER15) hpmcounter15 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER16) hpmcounter16 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
          if (ma2cs.csr_addr == ORV64_CSR_ADDR_MHPMCOUNTER17) hpmcounter17 <= csr_wdata[$bits(orv64_cntr_t)-1:0];
        end
      end
    end
  end

//`ifdef FPGA
//  ila_mstatus ila_mstatus_u(
//    .clk,
//    .probe0(mstatus),
//    .probe1(sstatus_mask),
//    .probe2(ustatus_mask)
//  );
//`endif
endmodule
