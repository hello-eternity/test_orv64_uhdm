
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef ORV64_TLB_PTW_IF__SV
`define ORV64_TLB_PTW_IF__SV
`define orv64_tlb_ptw_if_tb_s_assign(intf, st) \

`define orv64_tlb_ptw_if_tb_s_wire(intf) \

`define orv64_tlb_ptw_if_tb_s_wire_arr(intf, N) \

`define orv64_tlb_ptw_if_tb_s_port(intf) \


`define orv64_tlb_ptw_if_tb_s_port_arr(intf, N) \


`define orv64_tlb_ptw_if_tb_s_port2struct_assign(intf, st) \


`define orv64_tlb_ptw_if_tb_s_port2struct_arr_assign(intf, st, N) \


`define orv64_tlb_ptw_if_tb_m_assign(intf, st) \

`define orv64_tlb_ptw_if_tb_m_wire(intf) \

`define orv64_tlb_ptw_if_tb_m_wire_arr(intf, N) \

`define orv64_tlb_ptw_if_tb_m_port(intf) \


`define orv64_tlb_ptw_if_tb_m_port_arr(intf, N) \


`define orv64_tlb_ptw_if_tb_m_port2struct_assign(intf, st) \


`define orv64_tlb_ptw_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define orv64_tlb_ptw_if_ptw_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_vpn = ``intf``.req_vpn; \
  ``st``.req.req_access_type = ``intf``.req_access_type; \
  ``intf``.req_ready = ``st``.req_ready; \
  ``intf``.resp_valid = ``st``.resp_valid; \
  ``intf``.resp_excp_valid = ``st``.resp.resp_excp_valid; \
  ``intf``.resp_excp_cause = ``st``.resp.resp_excp_cause; \
  ``intf``.resp_lvl = ``st``.resp.resp_lvl; \
  ``intf``.resp_pte = ``st``.resp.resp_pte; \
  ``st``.resp_ready = ``intf``.resp_ready; \

`define orv64_tlb_ptw_if_ptw_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  orv64_tlb_ptw_if_req_t ``intf``_req; \
  orv64_tlb_ptw_if_resp_t ``intf``_resp; \

`define orv64_tlb_ptw_if_ptw_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  orv64_tlb_ptw_if_req_t ``intf``_req[``N``]; \
  orv64_tlb_ptw_if_resp_t ``intf``_resp[``N``]; \

`define orv64_tlb_ptw_if_ptw_port(intf) \
  input logic ``intf``_req_valid, \
  output logic ``intf``_req_ready, \
  output logic ``intf``_resp_valid, \
  input logic ``intf``_resp_ready, \
  input orv64_tlb_ptw_if_req_t ``intf``_req, \
  output orv64_tlb_ptw_if_resp_t ``intf``_resp

`define orv64_tlb_ptw_if_ptw_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  output logic ``intf``_req_ready[``N``], \
  output logic ``intf``_resp_valid[``N``], \
  input logic ``intf``_resp_ready[``N``], \
  input orv64_tlb_ptw_if_req_t ``intf``_req[``N``], \
  output orv64_tlb_ptw_if_resp_t ``intf``_resp[``N``]

`define orv64_tlb_ptw_if_ptw_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``intf``_req_ready = ``st``.req_ready; \
  ``intf``_resp_valid = ``st``.resp_valid; \
  ``st``.resp_ready = ``intf``_resp_ready; \
  ``st``.req = ``intf``_req; \
  ``intf``_resp = ``st``.resp; \


`define orv64_tlb_ptw_if_ptw_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \
  ``intf``_resp_valid[``N``] = ``st``[``N``].resp_valid; \
  ``st``[``N``].resp_ready = ``intf``_resp_ready[``N``]; \
  ``st``[``N``].req = ``intf``_req[``N``]; \
  ``intf``_resp[``N``] = ``st``[``N``].resp; \


`define orv64_tlb_ptw_if_tlb_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_vpn = ``st``.req.req_vpn; \
  ``intf``.req_access_type = ``st``.req.req_access_type; \
  ``st``.req_ready = ``intf``.req_ready; \
  ``st``.resp_valid = ``intf``.resp_valid; \
  ``st``.resp.resp_excp_valid = ``intf``.resp_excp_valid; \
  ``st``.resp.resp_excp_cause = ``intf``.resp_excp_cause; \
  ``st``.resp.resp_lvl = ``intf``.resp_lvl; \
  ``st``.resp.resp_pte = ``intf``.resp_pte; \
  ``intf``.resp_ready = ``st``.resp_ready; \

`define orv64_tlb_ptw_if_tlb_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  orv64_tlb_ptw_if_req_t ``intf``_req; \
  orv64_tlb_ptw_if_resp_t ``intf``_resp; \

`define orv64_tlb_ptw_if_tlb_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  orv64_tlb_ptw_if_req_t ``intf``_req[``N``]; \
  orv64_tlb_ptw_if_resp_t ``intf``_resp[``N``]; \

`define orv64_tlb_ptw_if_tlb_port(intf) \
  output logic ``intf``_req_valid, \
  input logic ``intf``_req_ready, \
  input logic ``intf``_resp_valid, \
  output logic ``intf``_resp_ready, \
  output orv64_tlb_ptw_if_req_t ``intf``_req, \
  input orv64_tlb_ptw_if_resp_t ``intf``_resp

`define orv64_tlb_ptw_if_tlb_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  input logic ``intf``_req_ready[``N``], \
  input logic ``intf``_resp_valid[``N``], \
  output logic ``intf``_resp_ready[``N``], \
  output orv64_tlb_ptw_if_req_t ``intf``_req[``N``], \
  input orv64_tlb_ptw_if_resp_t ``intf``_resp[``N``]

`define orv64_tlb_ptw_if_tlb_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``st``.req_ready = ``intf``_req_ready; \
  ``st``.resp_valid = ``intf``_resp_valid; \
  ``intf``_resp_ready = ``st``.resp_ready; \
  ``intf``_req = ``st``.req; \
  ``st``.resp = ``intf``_resp; \


`define orv64_tlb_ptw_if_tlb_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \
  ``st``[``N``].resp_valid = ``intf``_resp_valid[``N``]; \
  ``intf``_resp_ready[``N``] = ``st``[``N``].resp_ready; \
  ``intf``_req[``N``] = ``st``[``N``].req; \
  ``st``[``N``].resp = ``intf``_resp[``N``]; \


interface orv64_tlb_ptw_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_typedef::*;
  import orv_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  logic [2 - 1 : 0] valid;
  orv64_vpn_t [2 - 1 : 0] vpn;
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  orv64_tlb_ptw_if_req_t req;
  orv64_tlb_ptw_if_resp_t resp;
  modport tb_s (
    input  valid,
    input  vpn
  );
  modport tb_m (
    output valid,
    output vpn
  );
  modport ptw (
    input  req_valid,
    output req_ready,
    output resp_valid,
    input  resp_ready,
    input  req,
    output resp
  );
  modport tlb (
    output req_valid,
    input  req_ready,
    input  resp_valid,
    output resp_ready,
    output req,
    input  resp
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  valid;
    input  vpn;
    input  req_valid;
    input  req_ready;
    input  resp_valid;
    input  resp_ready;
    input  req;
    input  resp;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output valid;
    output vpn;
    output req_valid;
    output req_ready;
    output resp_valid;
    output resp_ready;
    output req;
    output resp;
  endclocking
  `endif
endinterface
`endif
`endif
