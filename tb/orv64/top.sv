// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// `include "def.sv"
//`define FPGA
  //import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;

module top 
(
  input logic                   tb_clk,
  input logic                   tb_rst
);
  // logic [31:0] tb_clk_cnt;

  logic dut_rst = 1'b1;
  logic dut_rst_ok = 1'b0;
  logic dut_early_rst = 1'b1;
  logic dut_start_en = 1'b0;
  always @(negedge tb_clk) begin
    if (dut_rst_ok == 1'b0) begin
      dut_rst <= 1'b1;
      dut_early_rst <= 1'b1;
      dut_start_en <= 1'b0;
      dut_rst_ok <= 1'b1;
    end else if (dut_early_rst == 1'b1) begin
      dut_early_rst <= 1'b0;
    end else if (dut_rst == 1'b1) begin
      dut_rst <= 1'b0;
    end else if (dut_start_en == 1'b0)begin
      dut_start_en <= 1'b1;
    end
  end

  // break point
  orv64_vaddr_t   s2b_bp_if_pc_0, s2b_bp_if_pc_1, s2b_bp_if_pc_2, s2b_bp_if_pc_3;
  logic           s2b_en_bp_if_pc_0, s2b_en_bp_if_pc_1, s2b_en_bp_if_pc_2, s2b_en_bp_if_pc_3;
  orv64_vaddr_t   s2b_bp_wb_pc_0, s2b_bp_wb_pc_1, s2b_bp_wb_pc_2, s2b_bp_wb_pc_3;
  logic           s2b_en_bp_wb_pc_0, s2b_en_bp_wb_pc_1, s2b_en_bp_wb_pc_2, s2b_en_bp_wb_pc_3;
  orv64_vaddr_t   s2b_bp_mem_addr_0, s2b_bp_mem_addr_1, s2b_bp_mem_addr_2, s2b_bp_mem_addr_3;
  // orv64_bp_mem_cfg_t s2b_bp_mem_cfg_0, s2b_bp_mem_cfg_1, s2b_bp_mem_cfg_2, s2b_bp_mem_cfg_3;
  orv64_data_t    s2b_bp_instret;
  logic           s2b_en_bp_instret;

  // TODO: add testbench option for toggling these
  assign s2b_en_bp_if_pc_0 = '0;
  assign s2b_en_bp_if_pc_1 = '0;
  assign s2b_en_bp_if_pc_2 = '0;
  assign s2b_en_bp_if_pc_3 = '0;
  assign s2b_en_bp_wb_pc_0 = '0;
  assign s2b_en_bp_wb_pc_1 = '0;
  assign s2b_en_bp_wb_pc_2 = '0;
  assign s2b_en_bp_wb_pc_3 = '0;
  // assign s2b_bp_mem_cfg_0 = ORV64_BP_OFF;
  // assign s2b_bp_mem_cfg_1 = ORV64_BP_OFF;
  // assign s2b_bp_mem_cfg_2 = ORV64_BP_OFF;
  // assign s2b_bp_mem_cfg_3 = ORV64_BP_OFF;
  assign s2b_en_bp_instret = '0;

  assign s2b_bp_if_pc_0 = '0;
  assign s2b_bp_if_pc_1 = '0;
  assign s2b_bp_if_pc_2 = '0;
  assign s2b_bp_if_pc_3 = '0;
  assign s2b_bp_wb_pc_0 = '0;
  assign s2b_bp_wb_pc_1 = '0;
  assign s2b_bp_wb_pc_2 = '0;
  assign s2b_bp_wb_pc_3 = '0;
  assign s2b_bp_mem_addr_0 = '0;
  assign s2b_bp_mem_addr_1 = '0;
  assign s2b_bp_mem_addr_2 = '0;
  assign s2b_bp_mem_addr_3 = '0;
  assign s2b_bp_instret = '0;

  // trace buffer
  orv64_itb_sel_t  s2b_cfg_itb_sel;
  logic            s2b_cfg_itb_en;
  logic            s2b_cfg_itb_wrap_around;
  orv64_itb_addr_t b2s_itb_last_ptr;
  // orv64_itb_size_t b2s_itb_size;

  // TODO: add testbench option for toggling this
  assign s2b_cfg_itb_sel = ORV64_ITB_SEL_IF;
  assign s2b_cfg_itb_en = 1'b0;
  assign s2b_cfg_itb_wrap_around = '0;

  logic                             ext_intr_to_orv64;
  logic                             ext_event_to_orv64;
  // always @(posedge tb_clk) begin
  //   if (ext_event_to_orv64 == 1'b1) begin
  //     ext_event_to_orv64 <= '0;
  //   end
  // end
  assign ext_event_to_orv64 = '0;
  assign ext_intr_to_orv64 = '0;
  //orv64_vaddr_t             cfg_orv64_rst_pc;
  bit[$bits(orv64_vaddr_t)-1 : 0]             cfg_orv64_rst_pc;
  initial begin
    if (!$value$plusargs("set_vp0_rst_pc=%h", cfg_orv64_rst_pc)) begin
      cfg_orv64_rst_pc = 39'h80000000;
    end
  end
  logic                             cfg_orv64_pwr_on;
  logic                             cfg_orv64_sleep;
  assign cfg_orv64_pwr_on = 1'b1;
  assign cfg_orv64_sleep = 1'b0;
  logic   [ 5:0]                    cfg_orv64_lfsr_seed;
  assign cfg_orv64_lfsr_seed = 6'h1;
  logic                             cfg_orv64_bypass_ic;
  logic                             cfg_orv64_bypass_tlb;
  logic                             cfg_orv64_en_hpmcounter;
  assign cfg_orv64_en_hpmcounter = 1'b0;
  assign cfg_orv64_bypass_ic = 0;
  assign cfg_orv64_bypass_tlb = 1;
/*  `ifdef RRV_SUPPORT_OURSBUS
  // storebuf <-> oursbus
  logic                             dc2ob_req, dc2ob_rwn;
  orv64_paddr_t                     dc2ob_addr;
  orv64_data_t                      dc2ob_wdata;
  orv64_data_t                      ob2dc_rdata;
  logic                             ob2dc_resp;
  assign ob2dc_resp = 1'b0;
  assign ob2dc_rdata = '0;
  // icache <-> oursbus
  logic                     ic2ob_req, ic2ob_rwn;
  orv64_paddr_t             ic2ob_addr;
  orv64_data_t              ic2ob_wdata;
  logic [5:0]               ic2ob_id;
  orv64_data_t              ob2ic_rdata;
  logic                     ob2ic_resp;
  assign ob2ic_resp = 1'b0;
  assign ob2ic_rdata = '0;
  `ifdef RRV_SUPPORT_MAGICMEM
  orv64_paddr_t             cfg_magicmem_start_addr;
  orv64_paddr_t             cfg_magicmem_end_addr;
  orv64_paddr_t             cfg_from_host_addr;
  orv64_paddr_t             cfg_to_host_addr;
  assign cfg_magicmem_start_addr = '0;
  assign cfg_magicmem_end_addr = '0;
  assign cfg_from_host_addr = '0;
  assign cfg_to_host_addr = '0;
  `endif // RRV_SUPPORT_MAGICMEM
  `endif // RRV_SUPPORT_OURSBUS

  `ifdef RRV_SUPPORT_DMA
  logic                             dma2mp_ch0_done;
  logic                             dma2mp_ch1_done;
  logic                             dma2mp_ch2_done;
  logic                             dma2mp_ch3_done;
  assign dma2mp_ch0_done = 1'b0;
  assign dma2mp_ch1_done = 1'b0;
  assign dma2mp_ch2_done = 1'b0;
  assign dma2mp_ch3_done = 1'b0;
  `endif
*/
  //------------------------------------------------------
  // debug
  logic                          dbg_orv64_debug_stall;
  logic                          dbg_orv64_debug_resume;
  logic                          dbg_orv64_debug_stall_out;
  // assign dbg_orv64_debug_stall = debug_stall;
  // assign dbg_orv64_debug_resume = debug_resume;

  assign dbg_orv64_debug_stall = 1'b0;
  assign dbg_orv64_debug_resume = 1'b0;

  orv64_vaddr_t             orv64_rb_if_pc;
  logic                           early_rst_to_orv64;
  assign early_rst_to_orv64 = dut_early_rst;
  logic                           rst_to_orv64; 
  assign rst_to_orv64 = dut_rst;
  logic                           rstn_to_mm;
  assign rstn_to_mm = ~dut_rst;
  logic                           clk;
  assign clk = tb_clk;
  logic                cpu_amo_store_req_valid;
  cpu_cache_if_req_t   cpu_amo_store_req; 
  logic                cpu_amo_store_req_ready;
  assign cpu_amo_store_req_ready = '1;

  orv64_with_perfect_model dut
  (
    .*
  );

  // Restore
  `define SP_PATH         dut.orv64_u.IRF.RF.regfile[2]
  `define PRV_PATH        dut.orv64_u.CS.prv
  `define MISA_PATH       dut.orv64_u.CS.misa
  `define MSTATUS_PATH    dut.orv64_u.CS.mstatus
  `define MEPC_PATH       dut.orv64_u.CS.mepc
  `define MTVAL_PATH      dut.orv64_u.CS.mtval
  `define MSCRATCH_PATH   dut.orv64_u.CS.mscratch
  `define MTVEC_PATH      dut.orv64_u.CS.mtvec
  `define MCAUSE_PATH     dut.orv64_u.CS.mcause
  `define MINSTRET_PATH   dut.orv64_u.CS.minstret
  `define MIE_PATH        dut.orv64_u.CS.mie
  `define MIP_PATH        dut.orv64_u.CS.mip
  `define MEDELEG_PATH    dut.orv64_u.CS.medeleg
  `define MIDELEG_PATH    dut.orv64_u.CS.mideleg
  `define MCOUNTEREN_PATH dut.orv64_u.CS.mcounteren
  `define SCOUNTEREN_PATH dut.orv64_u.CS.scounteren
  `define SEPC_PATH       dut.orv64_u.CS.sepc
  `define STVAL_PATH      dut.orv64_u.CS.stval
  `define SSCRATCH_PATH   dut.orv64_u.CS.sscratch
  `define STVEC_PATH      dut.orv64_u.CS.stvec
  `define SATP_PATH       dut.orv64_u.CS.satp
  `define SCAUSE_PATH     dut.orv64_u.CS.scause
  `define MTIME           dut.orv64_u.CS.mcycle
  `define MTIMECMP        dut.mtimecmp
  `define MSIP            dut.sw_int

  initial begin
    `ifdef TAKE_SNAPSHOT
      `include "reg0.sv"
      `include "clint0.sv"

      @(negedge dut_rst);

      release `SP_PATH         ;
      release `PRV_PATH        ;
      release `MISA_PATH       ;
      release `MSTATUS_PATH    ;
      release `MEPC_PATH       ;
      release `MTVAL_PATH      ;
      release `MSCRATCH_PATH   ;
      release `MTVEC_PATH      ;
      release `MCAUSE_PATH     ;
      release `MINSTRET_PATH   ;
      release `MIE_PATH        ;
      release `MIP_PATH        ;
      release `MEDELEG_PATH    ;
      release `MIDELEG_PATH    ;
      release `MCOUNTEREN_PATH ;
      release `SCOUNTEREN_PATH ;
      release `SEPC_PATH       ;
      release `STVAL_PATH      ;
      release `SSCRATCH_PATH   ;
      release `STVEC_PATH      ;
      release `SATP_PATH       ;
      release `SCAUSE_PATH     ;
      release `MTIME           ;
      release `MTIMECMP        ;
      release `MSIP            ;
    `endif
  end


  int        report_fd;
  string     image_path;
  string     elf_path;
  initial begin
    int        image_fd;
    int        cnt = 0;
    bit [63:0] data;
    logic[31:0]    bdata;
    int        num_byte;

    string     report_path;
    string     case_name;
    bit [39:0] image_addr;


// Loading Image
      $display("%t Start Loading Image from backdoor", $time);


  if ($value$plusargs("backdoor_load_image=%s", image_path)) begin
      $display("%t Start Loading image from backdoor", $time);
      if ($value$plusargs("report_fdile=%s", report_path)) begin
        report_fd = $fopen(report_path, "a");
        if ($value$plusargs("case_name=%s", case_name))
          $fdisplay(report_fd, "\ncase: %s", case_name);
        else
          $fdisplay(report_fd, "\ncase: unknown", case_name);
      end
      else
        report_fd = 0;

      image_fd = $fopen(image_path, "rb");
      if (image_fd == 0)
        `olog_fatal("TOP", $sformatf("Unable to open %s.hex for read", image_path));
      image_addr ='h80000000; 
      num_byte = $fread(bdata, image_fd);
      while (num_byte > 0) begin
        // align byte endianess
        if (num_byte == 4) begin
          data[31:24] = bdata[7:0];
          data[23:16] = bdata[15:8];
          data[15:8]  = bdata[23:16];
          data[7:0]   = bdata[31:24];
        end
        else if (num_byte == 3) begin
          data[31:24] = 0;
          data[23:16] = bdata[15:8];
          data[15:8]  = bdata[23:16];
          data[7:0]   = bdata[31:24];
        end
        else if (num_byte == 2) begin
          data[31:24] = 0;
          data[23:16] = 0;
          data[15:8]  = bdata[23:16];
          data[7:0]   = bdata[31:24];
        end
        else if (num_byte == 1) begin
          data[31:24] = 0;
          data[23:16] = 0;
          data[15:8]  = 0;
          data[7:0]   = bdata[31:24];
        end

        dut.mm_u.array_data[image_addr >> 2] = data[31:0];
        // $display("Address: 0x%h, Data: 0x%h", image_addr, data);
        // $display("Address: 0x%h, Data: 0x%h", image_addr,  dut.mm_u.array_data[image_addr >> 2]);
        image_addr += 4;

        num_byte = $fread(bdata, image_fd);
      end
      while (image_addr < 'h8102ffff)
      begin
        dut.mm_u.array_data[image_addr >> 2] = 32'd0;
        image_addr += 4;
      end
      $display("%t Done Loading Image from backdoor. addr range: %h", $time, image_addr);
    end
  end


// compatiable with spike
import "DPI-C" context function void cosim_setup_callback(input string image);
  initial begin
    if ($value$plusargs("cosim=%s", elf_path)) begin
      for(int i=0; i<32; i++)
        dut.orv64_u.IRF.RF.regfile[i] = 64'd0;
      dut.orv64_u.IRF.RF.regfile[5] = 64'h80000000;
      dut.orv64_u.IRF.RF.regfile[11] = 64'h1020;
      $display("rtl.elfpath=%s", elf_path);
      cosim_setup_callback(elf_path);
    end
  end

endmodule
