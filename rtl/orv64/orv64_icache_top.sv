// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_icache_top 
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  // i/f to core
  input   orv64_if2ic_t   if2ic,
  output  orv64_ic2if_t   ic2if,
  output  logic           ic_hit, 
                          ic_miss,
  // Fence
  input   logic                 id2ic_fence_req_valid,
  input   cache_fence_if_req_t  id2ic_fence_req,
  output  logic                 ic2id_fence_req_ready,

  output  logic                 ic2id_fence_resp_valid,
  output  cache_fence_if_resp_t ic2id_fence_resp,
  input   logic                 id2ic_fence_resp_ready,

  input   logic                 id2ib_flush_req_valid,
  input   logic                 cs2ib_flush_req_valid,

  // TLB
  output logic                      ic2tlb_valid,
  output orv64_cache_tlb_if_req_t   ic2tlb,
  input  logic                      tlb2ic_ready,

  input  logic                      tlb2ic_valid,
  input  orv64_cache_tlb_if_resp_t  tlb2ic,
  output                            ic2tlb_ready,
  // i/f to cpu noc
  output logic                   cpu_if_req_valid, 
  output cpu_cache_if_req_t      cpu_if_req, 
  input logic                    cpu_if_req_ready, 

  input logic                    cpu_if_resp_valid, 
  input cpu_cache_if_resp_t      cpu_if_resp, 
  output logic                   cpu_if_resp_ready, 

  // SYSBUS
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

  // L1 icache backdoor interface
  input  logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_en_pway,
  input  logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_rw_pway,
  input  orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_addr_pway,
  input  orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_din_pway,
  output orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_dout_pway,

  input  logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_en_pway,
  input  logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_rw_pway,
  input  orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_addr_pway,
  input  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_bitmask_pway,
  input  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_din_pway,
  output cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_dout_pway,

  // Inst buffer debug interface
  input   orv64_da2ib_t             da2ib,
  output  orv64_ib2da_t             ib2da,

  output  logic                     inst_buf_idle,

  input   orv64_prv_t                prv,
  input   orv64_csr_mstatus_t        mstatus,
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,

  input   logic       cfg_pwr_on,
  input   logic [5:0] cfg_lfsr_seed,
  input   logic       cfg_bypass_ic,
  input   logic       rst, clk
);
  orv64_if2ic_t   ib_if2ic;
  orv64_ic2if_t   ib_ic2if;
 
  orv64_ib2icmem_t     ib2ic;
  orv64_icmem2ib_t     ic2ib;

  orv64_ic2sys_t       ic2isys;
  orv64_sys2ic_t       isys2ic;

  logic l1_hit, l1_miss;

  assign ib_flush_req_valid = id2ic_fence_req_valid | id2ib_flush_req_valid | cs2ib_flush_req_valid;

  assign ib_if2ic = if2ic;
  assign ic2if = ib_ic2if;

  orv64_inst_buffer inst_buf_u (
    .if2ib(ib_if2ic),
    .ib2if(ib_ic2if),
    .ic2ib,
    .ib2ic,
    .ib_hit(ic_hit), 
    .ib_miss(ic_miss),
    .l1_hit, 
    .l1_miss,
    .prv,
    .mstatus,
    .pmpcfg,
    .pmpaddr,
    .ib_flush(ib_flush_req_valid),
    .ib_idle(inst_buf_idle),
    .da2ib,
    .ib2da,
    .rst, 
    .clk
  );

  orv64_icache_sysbus ic_sysbus_u
  (
    .ic2isys,
    .isys2ic,
    .sysbus_req_if_awvalid,
    .sysbus_req_if_wvalid,
    .sysbus_req_if_arvalid,
    .sysbus_req_if_ar,
    .sysbus_req_if_aw,
    .sysbus_req_if_w,
    .sysbus_req_if_arready,
    .sysbus_req_if_wready,
    .sysbus_req_if_awready,
    .sysbus_resp_if_b,
    .sysbus_resp_if_r,
    .sysbus_resp_if_rvalid,
    .sysbus_resp_if_rready,
    .sysbus_resp_if_bvalid,
    .sysbus_resp_if_bready,
    .rst, 
    .clk
  );
  orv64_ic_tag_t  [ORV64_N_ICACHE_WAY-1:0] tag_ram_dout;
  orv64_ic_tag_t  [ORV64_N_ICACHE_WAY-1:0] tag_ram_din;
  orv64_inst_t    [ORV64_N_ICACHE_WAY-1:0] [ORV64_N_ICACHE_DATA_BANK-1:0] data_ram_dout;
  orv64_inst_t    [ORV64_N_ICACHE_WAY-1:0] [ORV64_N_ICACHE_DATA_BANK-1:0] data_ram_din;

  logic     [ORV64_N_ICACHE_WAY-1:0] tag_ram_en;
  logic     [ORV64_N_ICACHE_WAY-1:0] tag_ram_rw;
  logic     [ORV64_N_ICACHE_WAY-1:0] [ORV64_N_ICACHE_DATA_BANK-1:0] data_ram_en;
  logic     [ORV64_N_ICACHE_WAY-1:0] [ORV64_N_ICACHE_DATA_BANK-1:0] data_ram_rw;

  orv64_icache ic_l1_u
  (
    // i/f to core
    .ib2ic,
    .ic2ib,
    .ic_hit(l1_hit), 
    .ic_miss(l1_miss),
    .ic2isys,
    .isys2ic,
    // i/f to cpu noc
    .ic2tlb_valid,
    .ic2tlb,
    .tlb2ic_ready,
    .tlb2ic_valid,
    .tlb2ic,
    .ic2tlb_ready,
    .id2ic_fence_req_valid,
    .id2ic_fence_req,
    .ic2id_fence_req_ready,
    .ic2id_fence_resp_valid,
    .ic2id_fence_resp,
    .id2ic_fence_resp_ready,
    .cpu_if_req,
    .cpu_if_req_valid,
    .cpu_if_req_ready,
    .cpu_if_resp,
    .cpu_if_resp_valid,
    .cpu_if_resp_ready,
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
    .cfg_pwr_on,
    .cfg_lfsr_seed,
    .cfg_bypass_ic,
    .rst, 
    .clk
  );

endmodule
