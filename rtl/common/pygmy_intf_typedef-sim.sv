// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef SOC_INTF_TYPEDEF__SV
`define SOC_INTF_TYPEDEF__SV
package pygmy_intf_typedef;
import pygmy_cfg::*;
import pygmy_typedef::*;
typedef struct packed {
  logic start;
  vaddr_t addr;
  logic done;
} acp_if_t;
typedef struct packed {
  ahb_trans_t htrans;
  ahb_addr_t haddr;
  ahb_size_t hsize;
  logic hwrite;
  logic hlock;
  logic hbusreq;
  ahb_data_t hwdata;
  logic hready;
  logic hgrant;
  ahb_data_t hrdata;
  logic hresp;
} ahb_if_t;
typedef struct packed {
  paddr_t req_paddr;
  cpu_data_t req_data;
  cpu_byte_mask_t req_mask;
  cpu_tid_t req_tid;
  cpu_req_type_t req_type;
} amo_store_if_req_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  amo_store_if_req_t req;
} amo_store_if_t;
typedef struct packed {
  logic [40 - 1 : 0] paddr;
  logic pselx;
  logic penable;
  logic pwrite;
  logic [64 - 1 : 0] pwdata;
  logic pready;
  logic [64 - 1 : 0] prdata;
  logic pclk;
  logic presetn;
} apb_if_t;
// import rrv_cfg::*;
// import rrv_typedef::*;
typedef struct packed {
  logic req_is_fence;
} cache_fence_if_req_t;
typedef struct packed {
  logic resp_fence_is_done;
} cache_fence_if_resp_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  cache_fence_if_req_t req;
  cache_fence_if_resp_t resp;
} cache_fence_if_t;
typedef struct packed {
  mem_tid_t awid;
  mem_addr_t awaddr;
  logic [4 - 1 : 0] awlen;
} cache_mem_if_aw_t;
typedef struct packed {
  mem_data_t wdata;
  logic wlast;
  mem_tid_t wid;
} cache_mem_if_w_t;
typedef struct packed {
  mem_tid_t arid;
  logic [2 - 1 : 0] arlen;
  mem_addr_t araddr;
} cache_mem_if_ar_t;
typedef struct packed {
  mem_tid_t rid;
  mem_data_t rdata;
  axi4_resp_t rresp;
  logic rlast;
} cache_mem_if_r_t;
typedef struct packed {
  mem_tid_t bid;
  axi4_resp_t bresp;
} cache_mem_if_b_t;
typedef struct packed {
  cache_mem_if_aw_t aw;
  logic awvalid;
  logic awready;
  logic wvalid;
  logic wready;
  logic arvalid;
  logic arready;
  logic rvalid;
  logic rready;
  logic bvalid;
  logic bready;
  cache_mem_if_w_t w;
  cache_mem_if_ar_t ar;
  cache_mem_if_r_t r;
  cache_mem_if_b_t b;
} cache_mem_if_t;
typedef struct packed {
  paddr_t req_paddr;
  cpu_data_t req_data;
  cpu_byte_mask_t req_mask;
  cpu_tid_t req_tid;
  cpu_req_type_t req_type;
} cpu_cache_if_req_t;
typedef struct packed {
  cpu_data_t resp_data;
  cpu_byte_mask_t resp_mask;
  cpu_tid_t resp_tid;
} cpu_cache_if_resp_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  cpu_cache_if_req_t req;
  cpu_cache_if_resp_t resp;
} cpu_cache_if_t;
typedef struct packed {
  mem_barrier_sts_banks_t clear;
} mem_bar_clear_banks_if_t;
typedef struct packed {
  mem_barrier_sts_banks_t status;
} mem_bar_status_banks_if_t;
typedef struct packed {
  mem_barrier_sts_t status;
} mem_bar_status_if_t;
import orv64_param_pkg::*;
import orv64_typedef_pkg::*;
typedef struct packed {
  orv64_vpn_t req_vpn;
  orv64_access_type_t req_access_type;
} orv64_cache_tlb_if_req_t;
typedef struct packed {
  logic resp_excp_valid;
  orv64_excp_cause_t resp_excp_cause;
  orv64_ppn_t resp_ppn;
} orv64_cache_tlb_if_resp_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  orv64_cache_tlb_if_req_t req;
  orv64_cache_tlb_if_resp_t resp;
} orv64_cache_tlb_if_t;
typedef struct packed {
  orv64_csr_pmpcfg_t pmpcfg0;
  orv64_csr_pmpcfg_t pmpcfg2;
  orv64_csr_satp_t satp;
  orv64_prv_t prv;
  orv64_csr_pmpaddr_t [16 - 1 : 0] pmpaddr;
  orv64_csr_mstatus_t mstatus;
} orv64_csr_mmu_if_t;
typedef struct packed {
  logic resp_excp_valid;
  orv64_excp_cause_t resp_excp_cause;
  orv64_data_t resp_data;
} orv64_dc_ma_if_resp_t;
typedef struct packed {
  logic resp_valid;
  logic resp_ready;
  orv64_dc_ma_if_resp_t resp;
} orv64_dc_ma_if_t;
typedef struct packed {
  orv64_vaddr_t req_vaddr;
  logic req_rw;
  orv64_data_t req_wdata;
  orv64_data_byte_mask_t req_mask;
} orv64_ex_dc_if_req_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  orv64_ex_dc_if_req_t req;
} orv64_ex_dc_if_t;
typedef struct packed {
  orv64_vaddr_t req_vpc;
} orv64_if_ic_if_req_t;
typedef struct packed {
  logic resp_excp_valid;
  orv64_excp_cause_t resp_excp_cause;
  orv64_inst_t resp_inst;
} orv64_if_ic_if_resp_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  orv64_if_ic_if_req_t req;
  orv64_if_ic_if_resp_t resp;
} orv64_if_ic_if_t;
typedef struct packed {
  orv64_sfence_type_t req_sfence_type;
  orv64_asid_t req_flush_asid;
  orv64_vpn_t req_flush_vpn;
} orv64_tlb_flush_if_req_t;
typedef struct packed {
  logic resp_sfence_is_done;
} orv64_tlb_flush_if_resp_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  orv64_tlb_flush_if_req_t req;
  orv64_tlb_flush_if_resp_t resp;
} orv64_tlb_flush_if_t;
typedef struct packed {
  orv64_vpn_t req_vpn;
  orv64_access_type_t req_access_type;
} orv64_tlb_ptw_if_req_t;
typedef struct packed {
  logic resp_excp_valid;
  orv64_excp_cause_t resp_excp_cause;
  orv64_ptw_lvl_t resp_lvl;
  orv64_pte_t resp_pte;
} orv64_tlb_ptw_if_resp_t;
typedef struct packed {
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  orv64_tlb_ptw_if_req_t req;
  orv64_tlb_ptw_if_resp_t resp;
} orv64_tlb_ptw_if_t;
typedef struct packed {
  ring_tid_t awid;
  ring_addr_t awaddr;
} oursring_req_if_aw_t;
typedef struct packed {
  ring_data_t wdata;
  ring_strb_t wstrb;
  logic wlast;
} oursring_req_if_w_t;
typedef struct packed {
  ring_tid_t arid;
  ring_addr_t araddr;
} oursring_req_if_ar_t;
typedef struct packed {
  oursring_req_if_aw_t aw;
  logic awvalid;
  logic awready;
  logic wvalid;
  logic wready;
  logic arvalid;
  logic arready;
  oursring_req_if_w_t w;
  oursring_req_if_ar_t ar;
} oursring_req_if_t;
typedef struct packed {
  ring_tid_t rid;
  ring_data_t rdata;
  axi4_resp_t rresp;
  logic rlast;
} oursring_resp_if_r_t;
typedef struct packed {
  ring_tid_t bid;
  axi4_resp_t bresp;
} oursring_resp_if_b_t;
typedef struct packed {
  oursring_resp_if_r_t r;
  logic rvalid;
  logic rready;
  logic bvalid;
  logic bready;
  oursring_resp_if_b_t b;
} oursring_resp_if_t;
// typedef struct packed {
//   logic [8 - 1 : 0] awid;
//   logic [64 - 1 : 0] awaddr;
//   logic awvalid;
//   logic awready;
//   logic [512 - 1 : 0] wdata;
//   logic wvalid;
//   logic wready;
//   logic [8 - 1 : 0] arid;
//   logic [64 - 1 : 0] araddr;
//   logic arvalid;
//   logic arready;
// } pcie_req_if_t;
// typedef struct packed {
//   logic [8 - 1 : 0] rid;
//   logic [512 - 1 : 0] rdata;
//   logic rvalid;
//   logic [2 - 1 : 0] rresp;
//   logic rready;
//   logic [8 - 1 : 0] bid;
//   logic [2 - 1 : 0] bresp;
//   logic bvalid;
//   logic bready;
// } pcie_resp_if_t;
// typedef struct packed {
//   logic ce;
//   logic we;
//   data_t wdata;
//   data_t rdata;
// } tcm_if_t;
// typedef struct packed {
//   paddr_t req_paddr;
//   cpu_data_t req_data;
//   cpu_byte_mask_t req_mask;
//   cpu_tid_t req_tid;
//   cpu_req_type_t req_type;
// } usb_cache_if_req_t;
// typedef struct packed {
//   cpu_data_t resp_data;
//   cpu_req_type_t resp_type;
//   cpu_byte_mask_t resp_mask;
//   cpu_tid_t resp_tid;
// } usb_cache_if_resp_t;
// typedef struct packed {
//   logic req_valid;
//   logic req_ready;
//   logic resp_valid;
//   logic resp_ready;
//   usb_cache_if_req_t req;
//   usb_cache_if_resp_t resp;
// } usb_cache_if_t;
endpackage
`endif
