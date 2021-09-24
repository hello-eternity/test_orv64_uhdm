
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef ORV64_CSR_MMU_IF__SV
`define ORV64_CSR_MMU_IF__SV
`define orv64_csr_mmu_if_mmu_assign(intf, st) \
  ``st``.pmpcfg0 = ``intf``.pmpcfg0; \
  ``st``.pmpcfg2 = ``intf``.pmpcfg2; \
  ``st``.satp = ``intf``.satp; \
  ``st``.prv = ``intf``.prv; \
  ``st``.pmpaddr = ``intf``.pmpaddr; \
  ``st``.mstatus = ``intf``.mstatus; \

`define orv64_csr_mmu_if_mmu_wire(intf) \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg0; \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg2; \
  orv64_csr_satp_t ``intf``_satp; \
  orv64_prv_t ``intf``_prv; \
  orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr; \
  orv64_csr_mstatus_t ``intf``_mstatus; \

`define orv64_csr_mmu_if_mmu_wire_arr(intf, N) \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg0[``N``]; \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg2[``N``]; \
  orv64_csr_satp_t ``intf``_satp[``N``]; \
  orv64_prv_t ``intf``_prv[``N``]; \
  orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr[``N``]; \
  orv64_csr_mstatus_t ``intf``_mstatus[``N``]; \

`define orv64_csr_mmu_if_mmu_port(intf) \
  input orv64_csr_pmpcfg_t ``intf``_pmpcfg0, \
  input orv64_csr_pmpcfg_t ``intf``_pmpcfg2, \
  input orv64_csr_satp_t ``intf``_satp, \
  input orv64_prv_t ``intf``_prv, \
  input orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr, \
  input orv64_csr_mstatus_t ``intf``_mstatus

`define orv64_csr_mmu_if_mmu_port_arr(intf, N) \
  input orv64_csr_pmpcfg_t ``intf``_pmpcfg0[``N``], \
  input orv64_csr_pmpcfg_t ``intf``_pmpcfg2[``N``], \
  input orv64_csr_satp_t ``intf``_satp[``N``], \
  input orv64_prv_t ``intf``_prv[``N``], \
  input orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr[``N``], \
  input orv64_csr_mstatus_t ``intf``_mstatus[``N``]

`define orv64_csr_mmu_if_mmu_port2struct_assign(intf, st) \
  ``st``.pmpcfg0 = ``intf``_pmpcfg0; \
  ``st``.pmpcfg2 = ``intf``_pmpcfg2; \
  ``st``.satp = ``intf``_satp; \
  ``st``.prv = ``intf``_prv; \
  ``st``.pmpaddr = ``intf``_pmpaddr; \
  ``st``.mstatus = ``intf``_mstatus; \


`define orv64_csr_mmu_if_mmu_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].pmpcfg0 = ``intf``_pmpcfg0[``N``]; \
  ``st``[``N``].pmpcfg2 = ``intf``_pmpcfg2[``N``]; \
  ``st``[``N``].satp = ``intf``_satp[``N``]; \
  ``st``[``N``].prv = ``intf``_prv[``N``]; \
  ``st``[``N``].pmpaddr = ``intf``_pmpaddr[``N``]; \
  ``st``[``N``].mstatus = ``intf``_mstatus[``N``]; \


`define orv64_csr_mmu_if_csr_assign(intf, st) \
  ``intf``.pmpcfg0 = ``st``.pmpcfg0; \
  ``intf``.pmpcfg2 = ``st``.pmpcfg2; \
  ``intf``.satp = ``st``.satp; \
  ``intf``.prv = ``st``.prv; \
  ``intf``.pmpaddr = ``st``.pmpaddr; \
  ``intf``.mstatus = ``st``.mstatus; \

`define orv64_csr_mmu_if_csr_wire(intf) \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg0; \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg2; \
  orv64_csr_satp_t ``intf``_satp; \
  orv64_prv_t ``intf``_prv; \
  orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr; \
  orv64_csr_mstatus_t ``intf``_mstatus; \

`define orv64_csr_mmu_if_csr_wire_arr(intf, N) \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg0[``N``]; \
  orv64_csr_pmpcfg_t ``intf``_pmpcfg2[``N``]; \
  orv64_csr_satp_t ``intf``_satp[``N``]; \
  orv64_prv_t ``intf``_prv[``N``]; \
  orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr[``N``]; \
  orv64_csr_mstatus_t ``intf``_mstatus[``N``]; \

`define orv64_csr_mmu_if_csr_port(intf) \
  output orv64_csr_pmpcfg_t ``intf``_pmpcfg0, \
  output orv64_csr_pmpcfg_t ``intf``_pmpcfg2, \
  output orv64_csr_satp_t ``intf``_satp, \
  output orv64_prv_t ``intf``_prv, \
  output orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr, \
  output orv64_csr_mstatus_t ``intf``_mstatus

`define orv64_csr_mmu_if_csr_port_arr(intf, N) \
  output orv64_csr_pmpcfg_t ``intf``_pmpcfg0[``N``], \
  output orv64_csr_pmpcfg_t ``intf``_pmpcfg2[``N``], \
  output orv64_csr_satp_t ``intf``_satp[``N``], \
  output orv64_prv_t ``intf``_prv[``N``], \
  output orv64_csr_pmpaddr_t [16 - 1 : 0] ``intf``_pmpaddr[``N``], \
  output orv64_csr_mstatus_t ``intf``_mstatus[``N``]

`define orv64_csr_mmu_if_csr_port2struct_assign(intf, st) \
  ``intf``_pmpcfg0 = ``st``.pmpcfg0; \
  ``intf``_pmpcfg2 = ``st``.pmpcfg2; \
  ``intf``_satp = ``st``.satp; \
  ``intf``_prv = ``st``.prv; \
  ``intf``_pmpaddr = ``st``.pmpaddr; \
  ``intf``_mstatus = ``st``.mstatus; \


`define orv64_csr_mmu_if_csr_port2struct_arr_assign(intf, st, N) \
  ``intf``_pmpcfg0[``N``] = ``st``[``N``].pmpcfg0; \
  ``intf``_pmpcfg2[``N``] = ``st``[``N``].pmpcfg2; \
  ``intf``_satp[``N``] = ``st``[``N``].satp; \
  ``intf``_prv[``N``] = ``st``[``N``].prv; \
  ``intf``_pmpaddr[``N``] = ``st``[``N``].pmpaddr; \
  ``intf``_mstatus[``N``] = ``st``[``N``].mstatus; \


interface orv64_csr_mmu_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  orv64_csr_pmpcfg_t pmpcfg0;
  orv64_csr_pmpcfg_t pmpcfg2;
  orv64_csr_satp_t satp;
  orv64_prv_t prv;
  orv64_csr_pmpaddr_t [16 - 1 : 0] pmpaddr;
  orv64_csr_mstatus_t mstatus;
  modport mmu (
    input  pmpcfg0,
    input  pmpcfg2,
    input  satp,
    input  prv,
    input  pmpaddr,
    input  mstatus
  );
  modport csr (
    output pmpcfg0,
    output pmpcfg2,
    output satp,
    output prv,
    output pmpaddr,
    output mstatus
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  pmpcfg0;
    input  pmpcfg2;
    input  satp;
    input  prv;
    input  pmpaddr;
    input  mstatus;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output pmpcfg0;
    output pmpcfg2;
    output satp;
    output prv;
    output pmpaddr;
    output mstatus;
  endclocking
  `endif
endinterface
`endif
`endif
