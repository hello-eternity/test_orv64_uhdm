// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
`ifndef __ORV_PTW__SV__
`define __ORV_PTW__SV__

module orv64_ptw
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
(
  // CSR i/f
  input   orv64_csr_satp_t      satp,
  input   orv64_prv_t           prv,
  input   orv64_csr_mstatus_t   mstatus,

  //PMP/PMA
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr,

  // TLB i/f
  input   logic                   [2:0]     tlb2ptw_valid,
  input   orv64_tlb_ptw_if_req_t  [2:0]     tlb2ptw,
  output  logic                   [2:0]     ptw2tlb_ready,

  output  logic                   [2:0]     ptw2tlb_valid,
  output  orv64_tlb_ptw_if_resp_t [2:0]     ptw2tlb,
  input   logic                   [2:0]     tlb2ptw_ready,

  output  logic               [2:0] cache_if_req_valid, 
  output  cpu_cache_if_req_t  [2:0] cache_if_req, 
  input   logic               [2:0] cache_if_req_ready, 
  input   logic               [2:0] cache_if_resp_valid, 
  input   cpu_cache_if_resp_t [2:0] cache_if_resp, 
  output  logic               [2:0] cache_if_resp_ready,

  // rst & clk
  input   logic           rstn, clk
);

  localparam ITLB_PORT = ORV64_IPTW_SRC_ID;
  localparam DTLB_PORT = ORV64_DPTW_SRC_ID;
  localparam VTLB_PORT = ORV64_VPTW_SRC_ID;

  orv64_ptw_core #(
    .SRC_ID(ORV64_IPTW_SRC_ID)
  ) orv64_iptw_core_u (
    .satp,
    .prv,
    .mstatus,
    .pmpcfg,
    .pmpaddr,
    .tlb2ptw_valid(tlb2ptw_valid[ITLB_PORT]),
    .tlb2ptw(tlb2ptw[ITLB_PORT]),
    .ptw2tlb_ready(ptw2tlb_ready[ITLB_PORT]),
    .ptw2tlb_valid(ptw2tlb_valid[ITLB_PORT]),
    .ptw2tlb(ptw2tlb[ITLB_PORT]),
    .tlb2ptw_ready(tlb2ptw_ready[ITLB_PORT]),
    .cache_if_req_valid(cache_if_req_valid[ITLB_PORT]), 
    .cache_if_req(cache_if_req[ITLB_PORT]), 
    .cache_if_req_ready(cache_if_req_ready[ITLB_PORT]), 
    .cache_if_resp_valid(cache_if_resp_valid[ITLB_PORT]), 
    .cache_if_resp(cache_if_resp[ITLB_PORT]), 
    .cache_if_resp_ready(cache_if_resp_ready[ITLB_PORT]),
    .rstn, 
    .clk
  );

  orv64_ptw_core #(
    .SRC_ID(ORV64_DPTW_SRC_ID)
  ) orv64_dptw_core_u (
    .satp,
    .prv,
    .mstatus,
    .pmpcfg,
    .pmpaddr,
    .tlb2ptw_valid(tlb2ptw_valid[DTLB_PORT]),
    .tlb2ptw(tlb2ptw[DTLB_PORT]),
    .ptw2tlb_ready(ptw2tlb_ready[DTLB_PORT]),
    .ptw2tlb_valid(ptw2tlb_valid[DTLB_PORT]),
    .ptw2tlb(ptw2tlb[DTLB_PORT]),
    .tlb2ptw_ready(tlb2ptw_ready[DTLB_PORT]),
    .cache_if_req_valid(cache_if_req_valid[DTLB_PORT]), 
    .cache_if_req(cache_if_req[DTLB_PORT]), 
    .cache_if_req_ready(cache_if_req_ready[DTLB_PORT]), 
    .cache_if_resp_valid(cache_if_resp_valid[DTLB_PORT]), 
    .cache_if_resp(cache_if_resp[DTLB_PORT]), 
    .cache_if_resp_ready(cache_if_resp_ready[DTLB_PORT]),
    .rstn, 
    .clk
  );

  orv64_ptw_core #(
    .SRC_ID(ORV64_VPTW_SRC_ID)
  ) orv64_vptw_core_u (
    .satp,
    .prv,
    .mstatus,
    .pmpcfg, 
    .pmpaddr,
    .tlb2ptw_valid(tlb2ptw_valid[VTLB_PORT]),
    .tlb2ptw(tlb2ptw[VTLB_PORT]),
    .ptw2tlb_ready(ptw2tlb_ready[VTLB_PORT]),
    .ptw2tlb_valid(ptw2tlb_valid[VTLB_PORT]),
    .ptw2tlb(ptw2tlb[VTLB_PORT]),
    .tlb2ptw_ready(tlb2ptw_ready[VTLB_PORT]),
    .cache_if_req_valid(cache_if_req_valid[VTLB_PORT]), 
    .cache_if_req(cache_if_req[VTLB_PORT]), 
    .cache_if_req_ready(cache_if_req_ready[VTLB_PORT]), 
    .cache_if_resp_valid(cache_if_resp_valid[VTLB_PORT]), 
    .cache_if_resp(cache_if_resp[VTLB_PORT]), 
    .cache_if_resp_ready(cache_if_resp_ready[VTLB_PORT]),
    .rstn, 
    .clk
  );

endmodule

`endif
