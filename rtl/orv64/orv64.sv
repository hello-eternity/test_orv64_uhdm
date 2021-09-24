// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  input [7:0]                         core_id,
  input                               ext_int,
  input                               sw_int,
  input                               timer_int,
  input                               s2b_ext_event,
  //------------------------------------------------------
  output  cpu_cache_if_req_t          l2_req,
  output                              l2_req_valid,
  input                               l2_req_ready,
  
  input   cpu_cache_if_resp_t         l2_resp,
  input                               l2_resp_valid,
  output                              l2_resp_ready,
  //------------------------------------------------------
  // Sysbus
  output logic                sysbus_req_if_awvalid,
  output logic                sysbus_req_if_wvalid,
  output logic                sysbus_req_if_arvalid,
  output oursring_req_if_ar_t sysbus_req_if_ar,
  output oursring_req_if_aw_t sysbus_req_if_aw,
  output oursring_req_if_w_t  sysbus_req_if_w,
  input                       sysbus_req_if_arready,
  input                       sysbus_req_if_wready,
  input                       sysbus_req_if_awready,

  input oursring_resp_if_b_t  sysbus_resp_if_b,
  input oursring_resp_if_r_t  sysbus_resp_if_r,
  input                       sysbus_resp_if_rvalid,
  output                      sysbus_resp_if_rready,
  input                       sysbus_resp_if_bvalid,
  output                      sysbus_resp_if_bready,
  //------------------------------------------------------
  // debug access
  input logic                 ring_req_if_awvalid,
  input logic                 ring_req_if_wvalid,
  input logic                 ring_req_if_arvalid,
  input oursring_req_if_ar_t  ring_req_if_ar,
  input oursring_req_if_aw_t  ring_req_if_aw,
  input oursring_req_if_w_t   ring_req_if_w,
  output                      ring_req_if_arready,
  output                      ring_req_if_wready,
  output                      ring_req_if_awready,

  output oursring_resp_if_b_t ring_resp_if_b,
  output oursring_resp_if_r_t ring_resp_if_r,
  output                      ring_resp_if_rvalid,
  input                       ring_resp_if_rready,
  output                      ring_resp_if_bvalid,
  input                       ring_resp_if_bready,

`ifdef ORV64_SUPPORT_MAGICMEM
  input   orv64_paddr_t   cfg_magicmem_start_addr,
                    cfg_magicmem_end_addr,
                    cfg_from_host_addr,
                    cfg_to_host_addr,
`endif // ORV64_SUPPORT_MAGICMEM

`ifdef ORV64_SUPPORT_DMA
  input   dma2mp_ch0_done,
  input   dma2mp_ch1_done,
  input   dma2mp_ch2_done,
  input   dma2mp_ch3_done,
`endif

  //------------------------------------------------------
  // atomic 
  //------------------------------------------------------
  input  logic                cpu_amo_store_req_ready,  
  output logic                cpu_amo_store_req_valid, 
  output cpu_cache_if_req_t   cpu_amo_store_req, 
  //------------------------------------------------------
  // Breakpoint
  input   orv64_vaddr_t   s2b_bp_if_pc_0,
  input   orv64_vaddr_t   s2b_bp_if_pc_1,
  input   orv64_vaddr_t   s2b_bp_if_pc_2,
  input   orv64_vaddr_t   s2b_bp_if_pc_3,
  input   logic           s2b_en_bp_if_pc_0,
  input   logic           s2b_en_bp_if_pc_1,
  input   logic           s2b_en_bp_if_pc_2,
  input   logic           s2b_en_bp_if_pc_3,
  input   orv64_vaddr_t   s2b_bp_wb_pc_0,
  input   orv64_vaddr_t   s2b_bp_wb_pc_1,
  input   orv64_vaddr_t   s2b_bp_wb_pc_2,
  input   orv64_vaddr_t   s2b_bp_wb_pc_3,
  input   logic           s2b_en_bp_wb_pc_0,
  input   logic           s2b_en_bp_wb_pc_1,
  input   logic           s2b_en_bp_wb_pc_2,
  input   logic           s2b_en_bp_wb_pc_3,
  input   orv64_data_t    s2b_bp_instret,
  input   logic           s2b_en_bp_instret,
  //------------------------------------------------------
  // trace buffer
  input   orv64_itb_sel_t  s2b_cfg_itb_sel,
  input   logic            s2b_cfg_itb_en,
  input   logic            s2b_cfg_itb_wrap_around,
  output  orv64_itb_addr_t b2s_itb_last_ptr,

  //------------------------------------------------------
  // debug
  input                 s2b_debug_stall,
  input                 s2b_debug_resume,
  output                b2s_debug_stall_out,
  //------------------------------------------------------
  // configure from/to RB
  input   orv64_vaddr_t  s2b_cfg_rst_pc,
  input           s2b_cfg_pwr_on,
  input           s2b_cfg_sleep,
  input   [ 5:0]  s2b_cfg_lfsr_seed,
  output  orv64_vaddr_t  b2s_if_pc,
  input           s2b_cfg_bypass_ic,
  input           s2b_cfg_bypass_tlb, 
  input           s2b_cfg_en_hpmcounter, 


  output  logic   wfi_stall,
  output  logic   wfe_stall,

  input           s2b_early_rst, // early_rst is used to release reset on debug_access for initializing L1 cache before releasing main reset
  input           s2b_rst,
  input           clk
);
  logic          ext_event;
  logic          debug_stall_to_orv;
  logic          debug_stall;
  logic          debug_stall_out;
  orv64_vaddr_t  cfg_rst_pc;
  logic          cfg_pwr_on;
  logic          cfg_sleep;
  logic [5:0]    cfg_lfsr_seed;
  logic          cfg_bypass_ic;
  logic          cfg_bypass_tlb;
  logic          cfg_en_hpmcounter;
  orv64_vaddr_t  if_pc;
  logic          early_rst;
  logic          rst;

  assign ext_event = s2b_ext_event;
  assign cfg_rst_pc = s2b_cfg_rst_pc;
  assign cfg_pwr_on = s2b_cfg_pwr_on;
  assign cfg_sleep = s2b_cfg_sleep;
  assign cfg_lfsr_seed = s2b_cfg_lfsr_seed;
  assign cfg_bypass_ic = s2b_cfg_bypass_ic;
  assign cfg_bypass_tlb = s2b_cfg_bypass_tlb;
  assign early_rst = s2b_early_rst;
  assign rst = s2b_rst;

  assign b2s_if_pc = if_pc;
  assign b2s_debug_stall_out = debug_stall_out;
  assign debug_stall = debug_stall_to_orv;


`ifndef SYNTHESIS
  //import ours_logging::*;
`endif

  //------------------------------------------------------
  // pipeline registers
  orv64_if2id_t         if2id_ff;
  orv64_id2ex_t         id2ex_ff;
  orv64_ex2ma_t         ex2ma_ff;

  orv64_data_t          id2ex_fp_rs1_ff;

`ifdef ORV64_SUPPORT_MULDIV
  orv64_id2muldiv_t     id2mul_ff, id2div_ff, id2mul, id2div;
`endif

`ifdef ORV64_SUPPORT_FP
  orv64_id2fp_add_t     id2fp_add_s_ff, id2fp_add_d_ff;
  orv64_id2fp_mac_t     id2fp_mac_s_ff, id2fp_mac_d_ff;
  orv64_id2fp_div_t     id2fp_div_s_ff, id2fp_div_d_ff;
  orv64_id2fp_sqrt_t    id2fp_sqrt_s_ff, id2fp_sqrt_d_ff;
  orv64_id2fp_misc_t    id2fp_misc_ff;
`endif
  //------------------------------------------------------
  // ctrl
  orv64_if2id_ctrl_t    if2id_ctrl_ff;
  orv64_id2ex_ctrl_t    id2ex_ctrl_ff;
  orv64_ex2ma_ctrl_t    ex2ma_ctrl_ff;
  //------------------------------------------------------
  // exception
  orv64_excp_t          if2id_excp_ff,
                  id2ex_excp_ff,
                  ex2ma_excp_ff;
  logic   is_kill;
  logic   cs2if_kill, cs2id_kill, cs2ex_kill, cs2ma_kill;
  //------------------------------------------------------
  // next PC -> IF
  orv64_npc_t     ex2if_npc,
                  wb2if_npc,
                  cs2if_npc;
  logic           ma2if_npc_valid;
  logic           ex2if_kill, ex2id_kill;
  logic           branch_solved;
  //------------------------------------------------------
  // bypass -> ID
  orv64_bps_t     ex2id_bps,
                  ma2id_bps,
                  ma2ex_bps,
                  wb2id_bps;

  orv64_reg_addr_t ex2id_kill_addr;

  //------------------------------------------------------
  // pipeline ctrl
  logic   if_stall, if_kill, if_valid, if_valid_ff, if_ready;
  logic   id_stall, id_kill, id_valid, id_valid_ff, id_ready, id_valid_masked;
  logic   ex_stall, ex_kill, ex_valid, ex_valid_ff, ex_ready;
  logic   ma_stall, ma_kill, ma_valid, ma_valid_ff, ma_ready;
  logic   if_is_stable_stall, id_is_stable_stall, ex_is_stable_stall, ma_is_stable_stall;
  logic   cs2ma_stall;
  logic   wb_valid, wb_ready;
  logic   retiring_inst;
  logic   wait_for_npc;

  logic   cs2id_scb_rst; // reset scoreboard when kill
  logic   cs2ib_flush;
  logic   flush_storebuf;
  logic   is_wfe;

  logic   int_stall, bp_stall, stalled_for_int, is_pipeline_stalled, rff_is_pipeline_stalled;

  logic   inst_buf_idle;

  assign  if_kill = cs2if_kill | ex2if_kill;
  assign  id_kill = cs2id_kill | ex2id_kill;
  assign  ex_kill = cs2ex_kill;
  assign  ma_kill = cs2ma_kill;

//   assign  if_stall = 1'b0;
  assign  if_stall = wfe_stall;
  assign  id_stall = debug_stall;
  assign  ex_stall = 1'b0;
  assign  ma_stall = 1'b0;


  assign is_pipeline_stalled = if_is_stable_stall & id_is_stable_stall & ex_is_stable_stall & ma_is_stable_stall & wb_ready & inst_buf_idle;

  assign debug_stall_out = is_pipeline_stalled & ~stalled_for_int;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_pipeline_stalled <= '0;
    end else begin
      rff_is_pipeline_stalled <= is_pipeline_stalled;
    end
  end

  assign wb_ready = '1;
  //------------------------------------------------------
  // interrupt
  logic         ext_event_dly, ext_event_pulse,
                ext_event_hold,
                is_wfe_dly, is_wfe_pulse,
                is_wfe_stall;
  orv64_int_cause_t   int_cause;
  assign int_cause = ORV64_INT_M_EXT;

  always_ff @ (posedge clk) begin
    ext_event_dly <= ext_event;
    is_wfe_dly <= is_wfe;
   end
  assign ext_event_pulse = ext_event & ~ext_event_dly;
  assign is_wfe_pulse = is_wfe & ~is_wfe_dly;
  assign is_wfe_stall = wfe_stall | is_wfe_pulse;

  always_ff @ (posedge clk) begin
    if (rst) begin
      wfe_stall <= '0;
      ext_event_hold <= '0;
    end else begin
      if (ext_event_pulse & ~is_wfe_pulse)
        ext_event_hold <= '1;
      if (wfe_stall & ext_event_hold)
        ext_event_hold <= '0;

      if (~wfe_stall) begin
        if (is_wfe_pulse & ~ext_event_pulse)
          wfe_stall <= '1;
      end else begin
        if (ext_event_hold | is_kill)
          wfe_stall <= '0;
      end
    end
  end


  //------------------------------------------------------
  // register file
  orv64_if2irf_t    if2irf;
  orv64_irf2id_t    irf2id;
  orv64_ma2rf_t     ma2irf;
  
`ifdef ORV64_SUPPORT_FP
  orv64_if2fprf_t   if2fprf;
  orv64_fprf2id_t   fprf2id;
  orv64_ma2rf_t     ma2fprf;
`endif
  //------------------------------------------------------
  // cache interface
  orv64_if2ic_t     if2ic;
  orv64_ic2if_t     ic2if, temp_ic2if;
  orv64_ex2dc_t     ex2dc;
  orv64_dc2ma_t     dc2ma;
  //------------------------------------------------------
  // performance counter
  logic       id_wait_for_reg, vc_wait_for_reg, ex_wait_for_reg;

  logic       wait_for_icr,
              wait_for_reg,
              wait_for_dcr,
              wait_for_dcw,
              wait_for_ex,
              ic_hit, ic_miss,
              itlb_hit, itlb_miss,
              dtlb_hit, dtlb_miss;

  orv64_vaddr_t     magic_mem_addr1, magic_mem_addr2;
  orv64_vaddr_t     id_pc, ex_pc, ma_pc, wb_pc;
  orv64_inst_t      if_inst, id_inst;

  assign wait_for_reg = id_wait_for_reg | vc_wait_for_reg | ex_wait_for_reg;

  //------------------------------------------------------
  orv64_csr_cfg_t       orv_cfg;
  orv64_prv_t           prv;
  orv64_frm_t           frm_csr;
  orv64_ma2cs_t         ma2cs;
  orv64_cs2ma_t         cs2ma;
  orv64_ma2cs_ctrl_t    ma2cs_ctrl;
  orv64_excp_t          ma2cs_excp;
  orv64_trap_t          cs2ma_excp;
  orv64_if2da_t         if2da;
  orv64_id2da_t         id2da;
  orv64_ex2da_t         ex2da;
  orv64_ma2da_t         ma2da;
  orv64_cs2da_t         cs2da;
//  orv64_da2rf_t         da2irf;
//  orv64_rf2da_t         irf2da;
//  orv64_da2rf_t         da2fprf;
//  orv64_rf2da_t         fprf2da;
  logic                 cs2ic_bypass_ic;
  orv64_csr_mstatus_t        mstatus;
  orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg;
  orv64_csr_pmpaddr_t [15:0] pmpaddr;
  orv64_csr_satp_t           satp;
  orv64_data_t               minstret, mcycle;
  logic                      update_hash;
  orv64_data_t               current_hash, next_hash;
  logic                 dc2if_amo_store_sent;
  logic                 if_has_amo_inst, id_has_amo_inst;
  logic                 if_has_vc_inst, id_has_vc_inst;

  orv64_data_t          ma2ex_amo_ld_data;

  assign id_valid_masked = id_valid & ~debug_stall;

  orv64_fetch                    IF(.dc2if_amo_store_sent, .*);
  orv64_decode                   ID(.*);
  orv64_execute                  EX(.id_valid(id_valid_masked), .*);
  orv64_mem_access               MA(.*);
  orv64_csr                      CS(.is_pipeline_stalled(rff_is_pipeline_stalled), .*);
  orv64_int_regfile              IRF(
    .ma2rf(ma2irf), 
    .*
  );
`ifdef ORV64_SUPPORT_FP
  orv64_fp_regfile  FPRF(.ma2rf(ma2fprf), .*);
`endif // ORV64_SUPPORT_FP

  // 3 PTW, icache, dcache
  logic               [4:0]     cpu_if_req_valid; 
  cpu_cache_if_req_t  [4:0]     cpu_if_req; 
  logic               [4:0]     cpu_if_req_ready; 
  logic               [4:0]     cpu_if_resp_valid; 
  cpu_cache_if_resp_t [4:0]     cpu_if_resp; 
  logic               [4:0]     cpu_if_resp_ready;

  logic               [2:0]     ptw_cpu_if_req_valid; 
  cpu_cache_if_req_t  [2:0]     ptw_cpu_if_req; 
  logic               [2:0]     ptw_cpu_if_req_ready; 
  logic               [2:0]     ptw_cpu_if_resp_valid; 
  cpu_cache_if_resp_t [2:0]     ptw_cpu_if_resp; 
  logic               [2:0]     ptw_cpu_if_resp_ready;

  cpu_cache_if_req_t  icache_cpu_req;
  logic      icache_cpu_req_valid;
  logic      icache_cpu_req_ready;

  cpu_cache_if_req_t  dcache_cpu_req;
  logic      dcache_cpu_req_valid;
  logic      dcache_cpu_req_ready;
  
  cpu_cache_if_resp_t  icache_cpu_resp;
  logic      icache_cpu_resp_valid;
  logic      icache_cpu_resp_ready;

  cpu_cache_if_resp_t  dcache_cpu_resp;
  logic      dcache_cpu_resp_valid;
  logic      dcache_cpu_resp_ready;    

  // IPTW
  assign cpu_if_req_valid[ORV64_IPTW_SRC_ID]      = ptw_cpu_if_req_valid[ORV64_IPTW_SRC_ID]; 
  assign cpu_if_req[ORV64_IPTW_SRC_ID]            = ptw_cpu_if_req[ORV64_IPTW_SRC_ID]; 
  assign ptw_cpu_if_req_ready[ORV64_IPTW_SRC_ID]  = cpu_if_req_ready[ORV64_IPTW_SRC_ID]; 
  assign ptw_cpu_if_resp_valid[ORV64_IPTW_SRC_ID] = cpu_if_resp_valid[ORV64_IPTW_SRC_ID]; 
  assign ptw_cpu_if_resp[ORV64_IPTW_SRC_ID]       = cpu_if_resp[ORV64_IPTW_SRC_ID]; 
  assign cpu_if_resp_ready[ORV64_IPTW_SRC_ID]     = ptw_cpu_if_resp_ready[ORV64_IPTW_SRC_ID];

  // DPTW
  assign cpu_if_req_valid[ORV64_DPTW_SRC_ID]      = ptw_cpu_if_req_valid[ORV64_DPTW_SRC_ID]; 
  assign cpu_if_req[ORV64_DPTW_SRC_ID]            = ptw_cpu_if_req[ORV64_DPTW_SRC_ID]; 
  assign ptw_cpu_if_req_ready[ORV64_DPTW_SRC_ID]  = cpu_if_req_ready[ORV64_DPTW_SRC_ID]; 
  assign ptw_cpu_if_resp_valid[ORV64_DPTW_SRC_ID] = cpu_if_resp_valid[ORV64_DPTW_SRC_ID]; 
  assign ptw_cpu_if_resp[ORV64_DPTW_SRC_ID]       = cpu_if_resp[ORV64_DPTW_SRC_ID]; 
  assign cpu_if_resp_ready[ORV64_DPTW_SRC_ID]     = ptw_cpu_if_resp_ready[ORV64_DPTW_SRC_ID];

  // VPTW
  assign cpu_if_req_valid[ORV64_VPTW_SRC_ID]      = ptw_cpu_if_req_valid[ORV64_VPTW_SRC_ID]; 
  assign cpu_if_req[ORV64_VPTW_SRC_ID]            = ptw_cpu_if_req[ORV64_VPTW_SRC_ID]; 
  assign ptw_cpu_if_req_ready[ORV64_VPTW_SRC_ID]  = cpu_if_req_ready[ORV64_VPTW_SRC_ID]; 
  assign ptw_cpu_if_resp_valid[ORV64_VPTW_SRC_ID] = cpu_if_resp_valid[ORV64_VPTW_SRC_ID]; 
  assign ptw_cpu_if_resp[ORV64_VPTW_SRC_ID]       = cpu_if_resp[ORV64_VPTW_SRC_ID]; 
  assign cpu_if_resp_ready[ORV64_VPTW_SRC_ID]     = ptw_cpu_if_resp_ready[ORV64_VPTW_SRC_ID];

  // IC
  assign cpu_if_req_valid[ORV64_IC_SRC_ID]        = icache_cpu_req_valid;
  assign cpu_if_req[ORV64_IC_SRC_ID]              = icache_cpu_req;
  assign icache_cpu_req_ready                     = cpu_if_req_ready[ORV64_IC_SRC_ID];
  assign icache_cpu_resp_valid                    = cpu_if_resp_valid[ORV64_IC_SRC_ID];
  assign icache_cpu_resp                          = cpu_if_resp[ORV64_IC_SRC_ID];
  assign cpu_if_resp_ready[ORV64_IC_SRC_ID]       = icache_cpu_resp_ready;

  // DC
  assign cpu_if_req_valid[ORV64_DC_SRC_ID]        = dcache_cpu_req_valid;
  assign cpu_if_req[ORV64_DC_SRC_ID]              = dcache_cpu_req;
  assign dcache_cpu_req_ready                     = cpu_if_req_ready[ORV64_DC_SRC_ID];
  assign dcache_cpu_resp_valid                    = cpu_if_resp_valid[ORV64_DC_SRC_ID];
  assign dcache_cpu_resp                          = cpu_if_resp[ORV64_DC_SRC_ID];
  assign cpu_if_resp_ready[ORV64_DC_SRC_ID]       = dcache_cpu_resp_ready;
                   
  // debug access to icache
  logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_en_pway;
  logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_rw_pway;
  orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_addr_pway;
  orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_din_pway;
  orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_dout_pway;

  logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_en_pway;
  logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_rw_pway;
  orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_addr_pway;
  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_din_pway;
  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_bitmask_pway;
  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_dout_pway;

  orv64_da2ib_t             da2ib;
  orv64_ib2da_t             ib2da;


  logic                   [2:0] tlb2ptw_valid;
  orv64_tlb_ptw_if_req_t  [2:0] tlb2ptw;
  logic                   [2:0] ptw2tlb_ready;

  logic                   [2:0] ptw2tlb_valid;
  orv64_tlb_ptw_if_resp_t [2:0] ptw2tlb;
  logic                   [2:0] tlb2ptw_ready;

  logic                 id2ic_fence_req_valid;
  cache_fence_if_req_t  id2ic_fence_req;
  logic                 ic2id_fence_req_ready;

  logic                 ic2id_fence_resp_valid;
  cache_fence_if_resp_t ic2id_fence_resp;
  logic                 id2ic_fence_resp_ready;

  logic                 id2ib_flush_req_valid;

  // TLB
  logic                      ic2tlb_valid;
  orv64_cache_tlb_if_req_t   ic2tlb;
  logic                      tlb2ic_ready;

  logic                      tlb2ic_valid;
  orv64_cache_tlb_if_resp_t  tlb2ic;
  logic                      ic2tlb_ready;

  logic                       id2itlb_flush_req_valid;
  orv64_tlb_flush_if_req_t    id2itlb_flush_req;

  orv64_tlb2da_t              itlb2da;
  orv64_da2tlb_t              da2itlb;

  logic ic_sysbus_req_if_awvalid;
  logic ic_sysbus_req_if_awready;
  logic ic_sysbus_req_if_wvalid;
  logic ic_sysbus_req_if_wready;
  logic ic_sysbus_req_if_arvalid;
  logic ic_sysbus_req_if_arready;
  oursring_req_if_ar_t ic_sysbus_req_if_ar;
  oursring_req_if_aw_t ic_sysbus_req_if_aw;
  oursring_req_if_w_t ic_sysbus_req_if_w;

  oursring_resp_if_b_t ic_sysbus_resp_if_b;
  oursring_resp_if_r_t ic_sysbus_resp_if_r;
  logic ic_sysbus_resp_if_rvalid;
  logic ic_sysbus_resp_if_rready;
  logic ic_sysbus_resp_if_bvalid;
  logic ic_sysbus_resp_if_bready;

  logic dc_sysbus_req_if_awvalid;
  logic dc_sysbus_req_if_awready;
  logic dc_sysbus_req_if_wvalid;
  logic dc_sysbus_req_if_wready;
  logic dc_sysbus_req_if_arvalid;
  logic dc_sysbus_req_if_arready;
  oursring_req_if_ar_t dc_sysbus_req_if_ar;
  oursring_req_if_aw_t dc_sysbus_req_if_aw;
  oursring_req_if_w_t dc_sysbus_req_if_w;

  oursring_resp_if_b_t dc_sysbus_resp_if_b;
  oursring_resp_if_r_t dc_sysbus_resp_if_r;
  logic dc_sysbus_resp_if_rvalid;
  logic dc_sysbus_resp_if_rready;
  logic dc_sysbus_resp_if_bvalid;
  logic dc_sysbus_resp_if_bready;
  
  orv64_icache_top ic_top_u (
    .prv,
    .mstatus,
    .pmpcfg,
    .pmpaddr,
    .if2ic,
    .ic2if(temp_ic2if),
    .ic_hit, 
    .ic_miss,
    .id2ic_fence_req_valid,
    .id2ic_fence_req,
    .ic2id_fence_req_ready,
    .ic2id_fence_resp_valid,
    .ic2id_fence_resp,
    .id2ic_fence_resp_ready,
    .id2ib_flush_req_valid,
    .cs2ib_flush_req_valid(cs2ib_flush),
    .ic2tlb_valid,
    .ic2tlb,
    .tlb2ic_ready,
    .tlb2ic_valid,
    .tlb2ic,
    .ic2tlb_ready,
    .cpu_if_req(icache_cpu_req),
    .cpu_if_req_valid(icache_cpu_req_valid),
    .cpu_if_req_ready(icache_cpu_req_ready),
    .cpu_if_resp(icache_cpu_resp),
    .cpu_if_resp_valid(icache_cpu_resp_valid),
    .cpu_if_resp_ready(icache_cpu_resp_ready),
    .sysbus_req_if_awvalid(ic_sysbus_req_if_awvalid),
    .sysbus_req_if_wvalid(ic_sysbus_req_if_wvalid),
    .sysbus_req_if_arvalid(ic_sysbus_req_if_arvalid),
    .sysbus_req_if_ar(ic_sysbus_req_if_ar),
    .sysbus_req_if_aw(ic_sysbus_req_if_aw),
    .sysbus_req_if_w(ic_sysbus_req_if_w),
    .sysbus_req_if_arready(ic_sysbus_req_if_arready),
    .sysbus_req_if_wready(ic_sysbus_req_if_wready),
    .sysbus_req_if_awready(ic_sysbus_req_if_awready),
    .sysbus_resp_if_b(ic_sysbus_resp_if_b),
    .sysbus_resp_if_r(ic_sysbus_resp_if_r),
    .sysbus_resp_if_rvalid(ic_sysbus_resp_if_rvalid),
    .sysbus_resp_if_rready(ic_sysbus_resp_if_rready),
    .sysbus_resp_if_bvalid(ic_sysbus_resp_if_bvalid),
    .sysbus_resp_if_bready(ic_sysbus_resp_if_bready),
    .debug_ic_tag_ram_en_pway,
    .debug_ic_tag_ram_rw_pway,
    .debug_ic_tag_ram_addr_pway,
    .debug_ic_tag_ram_din_pway,
    .debug_ic_tag_ram_dout_pway,
    .debug_ic_data_ram_en_pway,
    .debug_ic_data_ram_rw_pway,
    .debug_ic_data_ram_addr_pway,
    .debug_ic_data_ram_din_pway,
    .debug_ic_data_ram_bitmask_pway,
    .debug_ic_data_ram_dout_pway,
    .da2ib,
    .ib2da,
    .inst_buf_idle,
    .cfg_bypass_ic(cfg_bypass_ic | cs2ic_bypass_ic),
    .cfg_lfsr_seed,
    .cfg_pwr_on,
    .rst, 
    .clk
  );

  orv64_inst_t expanded_inst;

  orv64_rvc_inst_build rvc_build_u (
    .rvc_inst(temp_ic2if.inst),
    .full_inst(expanded_inst)
  );

  assign ic2if.valid = temp_ic2if.valid;
  assign ic2if.is_rvc = ~(temp_ic2if.inst[1:0] == 2'b11);
  assign ic2if.inst = ic2if.is_rvc ? expanded_inst: temp_ic2if.inst;
  assign ic2if.rvc_inst = temp_ic2if.inst;
  assign ic2if.excp_valid = temp_ic2if.excp_valid;
  assign ic2if.excp_cause = temp_ic2if.excp_cause;
  assign ic2if.is_half1_excp = temp_ic2if.is_half1_excp;


  logic                 ex2dc_fence_req_valid;
  cache_fence_if_req_t  ex2dc_fence_req;
  logic                 dc2ex_fence_req_ready;

  logic                 dc2ma_fence_resp_valid;
  cache_fence_if_resp_t dc2ma_fence_resp;
  logic                 ma2dc_fence_resp_ready;

  logic                      dc2tlb_valid;
  orv64_cache_tlb_if_req_t   dc2tlb;
  logic                      tlb2dc_ready;

  logic                      tlb2dc_valid;
  orv64_cache_tlb_if_resp_t  tlb2dc;
  logic                      dc2tlb_ready;

  orv64_tlb2da_t              dtlb2da;
  orv64_da2tlb_t              da2dtlb;

  logic                       ex2dtlb_flush_req_valid;
  orv64_tlb_flush_if_req_t    ex2dtlb_flush_req;



  orv64_dcache_bypass DC(
    .core_id,
    .prv,
    .mstatus,
    .pmpcfg, 
    .pmpaddr,
    .cpu_amo_store_req_valid,
    .cpu_amo_store_req,
    .cpu_amo_store_req_ready,
    .dc2if_amo_store_sent,
    .ex2dc,
    .dc2ma,
    .ex2dc_fence_req_valid,
    .ex2dc_fence_req,
    .dc2ex_fence_req_ready,
    .dc2ma_fence_resp_valid,
    .dc2ma_fence_resp,
    .ma2dc_fence_resp_ready,
    .dc2tlb_valid,
    .dc2tlb,
    .tlb2dc_ready,
    .tlb2dc_valid,
    .tlb2dc,
    .dc2tlb_ready,
    .cpu_if_req(dcache_cpu_req),
    .cpu_if_req_valid(dcache_cpu_req_valid),
    .cpu_if_req_ready(dcache_cpu_req_ready),
    .cpu_if_resp(dcache_cpu_resp),
    .cpu_if_resp_valid(dcache_cpu_resp_valid),
    .cpu_if_resp_ready(dcache_cpu_resp_ready),
    .sysbus_req_if_awvalid(dc_sysbus_req_if_awvalid),
    .sysbus_req_if_wvalid(dc_sysbus_req_if_wvalid),
    .sysbus_req_if_arvalid(dc_sysbus_req_if_arvalid),
    .sysbus_req_if_ar(dc_sysbus_req_if_ar),
    .sysbus_req_if_aw(dc_sysbus_req_if_aw),
    .sysbus_req_if_w(dc_sysbus_req_if_w),
    .sysbus_req_if_arready(dc_sysbus_req_if_arready),
    .sysbus_req_if_wready(dc_sysbus_req_if_wready),
    .sysbus_req_if_awready(dc_sysbus_req_if_awready),
    .sysbus_resp_if_b(dc_sysbus_resp_if_b),
    .sysbus_resp_if_r(dc_sysbus_resp_if_r),
    .sysbus_resp_if_rvalid(dc_sysbus_resp_if_rvalid),
    .sysbus_resp_if_rready(dc_sysbus_resp_if_rready),
    .sysbus_resp_if_bvalid(dc_sysbus_resp_if_bvalid),
    .sysbus_resp_if_bready(dc_sysbus_resp_if_bready),
    .rst,
    .clk
  );

  orv64_tlb itlb_u (
    .satp,
    .prv,
    .mstatus,
    .cc2tlb_req_valid(ic2tlb_valid),
    .cc2tlb_req(ic2tlb),
    .tlb2cc_req_ready(tlb2ic_ready),
    .tlb2cc_resp_valid(tlb2ic_valid),
    .tlb2cc_resp(tlb2ic),
    .cc2tlb_resp_ready(ic2tlb_ready),
    .orv2tlb_flush_req_valid(id2itlb_flush_req_valid),
    .orv2tlb_flush_req(id2itlb_flush_req),
    .tlb2ptw_req_valid(tlb2ptw_valid[0]),
    .tlb2ptw_req(tlb2ptw[0]),
    .ptw2tlb_req_ready(ptw2tlb_ready[0]),
    .ptw2tlb_resp_valid(ptw2tlb_valid[0]),
    .ptw2tlb_resp(ptw2tlb[0]),
    .tlb2ptw_resp_ready(tlb2ptw_ready[0]),
    .tlb2da(itlb2da),
    .da2tlb(da2itlb),
    .tlb_hit(itlb_hit),
    .tlb_miss(itlb_miss),
    .cfg_bypass_tlb,
    .rstn(~rst), 
    .clk
  );

  orv64_tlb #(.is_dtlb('1)) 
  dtlb_u (
    .satp,
    .prv,
    .mstatus,
    .cc2tlb_req_valid(dc2tlb_valid),
    .cc2tlb_req(dc2tlb),
    .tlb2cc_req_ready(tlb2dc_ready),
    .tlb2cc_resp_valid(tlb2dc_valid),
    .tlb2cc_resp(tlb2dc),
    .cc2tlb_resp_ready(dc2tlb_ready),
    .orv2tlb_flush_req_valid(ex2dtlb_flush_req_valid),
    .orv2tlb_flush_req(ex2dtlb_flush_req),
    .tlb2ptw_req_valid(tlb2ptw_valid[1]),
    .tlb2ptw_req(tlb2ptw[1]),
    .ptw2tlb_req_ready(ptw2tlb_ready[1]),
    .ptw2tlb_resp_valid(ptw2tlb_valid[1]),
    .ptw2tlb_resp(ptw2tlb[1]),
    .tlb2ptw_resp_ready(tlb2ptw_ready[1]),
    .tlb2da(dtlb2da),
    .da2tlb(da2dtlb),
    .tlb_hit(dtlb_hit),
    .tlb_miss(dtlb_miss),
    .cfg_bypass_tlb,
    .rstn(~rst), 
    .clk
  );



  orv64_ptw ptw_u (
    .satp,
    .prv,
    .mstatus,
    .pmpcfg, 
    .pmpaddr,
    .tlb2ptw_valid,
    .tlb2ptw,
    .ptw2tlb_ready,
    .ptw2tlb_valid,
    .ptw2tlb,
    .tlb2ptw_ready,
    .cache_if_req_valid(ptw_cpu_if_req_valid), 
    .cache_if_req(ptw_cpu_if_req), 
    .cache_if_req_ready(ptw_cpu_if_req_ready), 
    .cache_if_resp_valid(ptw_cpu_if_resp_valid), 
    .cache_if_resp(ptw_cpu_if_resp), 
    .cache_if_resp_ready(ptw_cpu_if_resp_ready),
    .rstn(~rst), 
    .clk
  );

  orv64_cache_noc #(.N_REQ(5)
  ) orv64_noc_u (
    .cpu_if_req_valid,
    .cpu_if_req, 
    .cpu_if_req_ready, 
    .cpu_if_resp_valid, 
    .cpu_if_resp, 
    .cpu_if_resp_ready,
    .cache_if_req_valid(l2_req_valid), 
    .cache_if_req(l2_req), 
    .cache_if_req_ready(l2_req_ready), 
    .cache_if_resp_valid(l2_resp_valid), 
    .cache_if_resp(l2_resp), 
    .cache_if_resp_ready(l2_resp_ready),
    .rstn(~rst),
    .clk
  );

  orv64_oursring_if_arbiter sysbus_arbiter_u (
    .ic_req_if_awvalid(ic_sysbus_req_if_awvalid),
    .ic_req_if_wvalid(ic_sysbus_req_if_wvalid),
    .ic_req_if_arvalid(ic_sysbus_req_if_arvalid),
    .ic_req_if_ar(ic_sysbus_req_if_ar),
    .ic_req_if_aw(ic_sysbus_req_if_aw),
    .ic_req_if_w(ic_sysbus_req_if_w),
    .ic_req_if_arready(ic_sysbus_req_if_arready),
    .ic_req_if_wready(ic_sysbus_req_if_wready),
    .ic_req_if_awready(ic_sysbus_req_if_awready),
    .ic_resp_ppln_if_b(ic_sysbus_resp_if_b),
    .ic_resp_ppln_if_r(ic_sysbus_resp_if_r),
    .ic_resp_ppln_if_rvalid(ic_sysbus_resp_if_rvalid),
    .ic_resp_ppln_if_rready(ic_sysbus_resp_if_rready),
    .ic_resp_ppln_if_bvalid(ic_sysbus_resp_if_bvalid),
    .ic_resp_ppln_if_bready(ic_sysbus_resp_if_bready),
    .dc_req_if_awvalid(dc_sysbus_req_if_awvalid),
    .dc_req_if_wvalid(dc_sysbus_req_if_wvalid),
    .dc_req_if_arvalid(dc_sysbus_req_if_arvalid),
    .dc_req_if_ar(dc_sysbus_req_if_ar),
    .dc_req_if_aw(dc_sysbus_req_if_aw),
    .dc_req_if_w(dc_sysbus_req_if_w),
    .dc_req_if_arready(dc_sysbus_req_if_arready),
    .dc_req_if_wready(dc_sysbus_req_if_wready),
    .dc_req_if_awready(dc_sysbus_req_if_awready),
    .dc_resp_ppln_if_b(dc_sysbus_resp_if_b),
    .dc_resp_ppln_if_r(dc_sysbus_resp_if_r),
    .dc_resp_ppln_if_rvalid(dc_sysbus_resp_if_rvalid),
    .dc_resp_ppln_if_rready(dc_sysbus_resp_if_rready),
    .dc_resp_ppln_if_bvalid(dc_sysbus_resp_if_bvalid),
    .dc_resp_ppln_if_bready(dc_sysbus_resp_if_bready),
    .req_ppln_if_ar(sysbus_req_if_ar),
    .req_ppln_if_awvalid(sysbus_req_if_awvalid),
    .req_ppln_if_awready(sysbus_req_if_awready),
    .req_ppln_if_wvalid(sysbus_req_if_wvalid),
    .req_ppln_if_wready(sysbus_req_if_wready),
    .req_ppln_if_arvalid(sysbus_req_if_arvalid),
    .req_ppln_if_arready(sysbus_req_if_arready),
    .req_ppln_if_w(sysbus_req_if_w),
    .req_ppln_if_aw(sysbus_req_if_aw),
    .resp_if_b(sysbus_resp_if_b),
    .resp_if_r(sysbus_resp_if_r),
    .resp_if_rvalid(sysbus_resp_if_rvalid),
    .resp_if_rready(sysbus_resp_if_rready),
    .resp_if_bvalid(sysbus_resp_if_bvalid),
    .resp_if_bready(sysbus_resp_if_bready),
    .rstn(~rst),
    .clk
  );


  //------------ muxing icache and dcache paths
//  assign l2_req_valid = icache_cpu_req_valid | dcache_cpu_req_valid;
//  assign dcache_cpu_req_ready = dcache_cpu_req_valid ? l2_req_ready : 1'b1;
//  assign icache_cpu_req_ready = dcache_cpu_req_valid ? 1'b0 :  
//                                icache_cpu_req_valid ? l2_req_ready : 1'b1;
//  always_comb begin
//    l2_req = dcache_cpu_req_valid ? dcache_cpu_req : icache_cpu_req; // give dcache higher priority
//    l2_req.req_tid.cpu_noc_id = 5'd0;   // don't care; CPU-NOC will reassign this
//    l2_req.req_tid.src = dcache_cpu_req_valid ? 1'b1 : 1'b0;
//  end
//
//  assign dcache_cpu_resp_valid = l2_resp_valid & (l2_resp.resp_tid.src == 4'h1);
//  assign icache_cpu_resp_valid = l2_resp_valid & (l2_resp.resp_tid.src == 4'h0);
//  assign l2_resp_ready = dcache_cpu_resp_valid ? dcache_cpu_resp_ready :
//                         icache_cpu_resp_valid ? icache_cpu_resp_ready : 1'b1;
//  assign dcache_cpu_resp = l2_resp;
//  assign icache_cpu_resp = l2_resp;

  //------------------------------------------------------
  // L1 debug access
  orv64_itb2da_t        itb2da;
  orv64_da2itb_t        da2itb;

  orv64_debug_access  DBG ( .rst(early_rst),
                          .*);

  orv64_stall stall_u (
    .bp_stall,
    .int_stall,
    .crb_stall(s2b_debug_stall),
    .crb_resume(s2b_debug_resume),
    .debug_stall_to_orv,
    .stalled_for_int,
    .rst, 
    .clk
  );

  orv64_breakpoint breakpoint_u (
    .bp_if_pc_0(s2b_bp_if_pc_0),
    .bp_if_pc_1(s2b_bp_if_pc_1),
    .bp_if_pc_2(s2b_bp_if_pc_2),
    .bp_if_pc_3(s2b_bp_if_pc_3),
    .en_bp_if_pc_0(s2b_en_bp_if_pc_0),
    .en_bp_if_pc_1(s2b_en_bp_if_pc_1),
    .en_bp_if_pc_2(s2b_en_bp_if_pc_2),
    .en_bp_if_pc_3(s2b_en_bp_if_pc_3),
    .bp_wb_pc_0(s2b_bp_wb_pc_0),
    .bp_wb_pc_1(s2b_bp_wb_pc_1),
    .bp_wb_pc_2(s2b_bp_wb_pc_2),
    .bp_wb_pc_3(s2b_bp_wb_pc_3),
    .en_bp_wb_pc_0(s2b_en_bp_wb_pc_0),
    .en_bp_wb_pc_1(s2b_en_bp_wb_pc_1),
    .en_bp_wb_pc_2(s2b_en_bp_wb_pc_2),
    .en_bp_wb_pc_3(s2b_en_bp_wb_pc_3),
    .minstret,
    .instret_bp(s2b_bp_instret),
    .instret_bp_en(s2b_en_bp_instret),
    .if_pc,
    .wb_pc,
    .if_valid,
    .wb_valid,
    .bp_stall,
    .rst,
    .clk
  );

  orv64_inst_trace_buf itb_u
  (
    .if_pc, 
    .id_pc, 
    .ex_pc, 
    .ma_pc, 
    .wb_pc,
    .if_valid, 
    .id_valid, 
    .ex_valid, 
    .ma_valid, 
    .wb_valid,
    .id_ready, 
    .ex_ready, 
    .ma_ready, 
    .wb_ready,
    .da2itb,
    .itb2da,
    .itb_last_ptr(b2s_itb_last_ptr),
    .cfg_itb_en(s2b_cfg_itb_en),
    .cfg_itb_sel(s2b_cfg_itb_sel),
    .cfg_itb_wrap_around(s2b_cfg_itb_wrap_around),
    .rst, 
    .clk
  );

`ifndef SYNTHESIS
  //logic [63:0] mcycle;
  //assign mcycle = CS.mcycle;

  logic [63:0] id_inst_code, ex_inst_code, ma_inst_code, wb_inst_code;
  assign id_inst_code = ID.id2ex_ctrl.inst_code;
  assign ex_inst_code = EX.ex2ma_ctrl.inst_code;
  assign ma_inst_code = MA.ex2ma_ctrl_ff.inst_code;
  assign wb_inst_code = MA.wb_inst_code;

  int fdebug;
  initial begin
    if ($test$plusargs("orv_enable_debug_info") == 1'b1)
      $display("start to dump ORV debug info into orv_debug_info.csv");
      fdebug = $fopen("orv_debug_info.csv");
  end

  final begin
    $fclose(fdebug);
    $display("mcycle = %d", mcycle);
    $display("    wait_for_npc = %d (IF branch/jump)",  CS.hpmcounter3);
    $display("    wait_for_reg = %d (ID data hazard)",  CS.hpmcounter4);
    $display("    wait_for_ex  = %d (EX unit busy)",    CS.hpmcounter8);
    $display("    wait_for_icr = %d (icache)",          CS.hpmcounter6);
    $display("    wait_for_dcr = %d (dcache read)",     CS.hpmcounter7);
    $display("    wait_for_dcw = %d (dcache write)",    CS.hpmcounter17);
    $display("    kill         = %d (flush pipeline)",  CS.hpmcounter5);
  end

  string info;
  always @ (negedge clk) begin
    if (!rst && ($test$plusargs("orv_enable_debug_info") == 1'b1)) begin
      $fwrite(fdebug, "%h; ", mcycle);
      $fwrite(fdebug, "%h (%h); ", if_inst, if_pc);
      $fwrite(fdebug, "%s (%h); ", id_inst_code, id_pc);
      $fwrite(fdebug, "%s (%h); ", ex_inst_code, ex_pc);
      $fwrite(fdebug, "%s (%h); ", ma_inst_code, ma_pc);
      $fwrite(fdebug, "%s (%h); ", wb_inst_code, wb_pc);

      info = "";
      if (ID.wait_for_rs1)
        info = {info, "=RS1"};
      if (ID.wait_for_rs2)
        info = {info, "=RS2"};
      if (ID.rd_busy)
        info = {info, "=RD"};
      $fwrite(fdebug, "%s; ", info);
      
      $fwrite(fdebug, "\n");
    end
  end
`endif

//assign if2ic_fence_req_valid = '0;
//assign if2ic_fence_resp_ready = '0;
assign ex2dc_fence_req_valid = '0;
assign ma2dc_fence_resp_ready = '0;

`ifndef SYNTHESIS

  int do_cosim;
  int sysbus_file;
  logic sysbus_print_flag;

  initial begin
    if ($test$plusargs("print_sys_access")) begin
      sysbus_file = $fopen("./dsys_access", "w");
      sysbus_print_flag = 1'b1;
    end else begin
      sysbus_print_flag = 1'b0;
    end
    if ($test$plusargs("cosim")) begin
      do_cosim = 1'b1;
    end else begin
      do_cosim = 1'b0;
    end
  end

  always_ff @ (posedge clk) begin
    if (sysbus_print_flag) begin
      if (~rst) begin
        if (sysbus_req_if_awvalid) begin
          $fdisplay(sysbus_file, "%t time_end PC=%h, addr=%h", $time, MA.ex2ma_ff.pc, sysbus_req_if_aw.awaddr);
        end else if (sysbus_req_if_arvalid) begin
          $fdisplay(sysbus_file, "%t time_end PC=%h, addr=%h", $time, MA.ex2ma_ff.pc, sysbus_req_if_ar.araddr);
        end
      end
    end
  end

  import "DPI-C" function void inst_finish_callback(input logic [31:1][63:0] nums, input orv64_vaddr_t pc);
  orv64_vaddr_t ma_pc_lat;
  always_comb
    if (rst) begin
      ma_pc_lat = ma_pc;
    end
    else if (do_cosim && ma_valid) begin
      if (!(ma_pc_lat === ma_pc)) begin
        inst_finish_callback(IRF.RF.regfile, ma_pc);
        ma_pc_lat = ma_pc;
      end
    end
`endif


endmodule
