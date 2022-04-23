
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef ORV64_TLB_FLUSH_IF__SV
`define ORV64_TLB_FLUSH_IF__SV
`define orv64_tlb_flush_if_rx_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_sfence_type = ``intf``.req_sfence_type; \
  ``st``.req.req_flush_asid = ``intf``.req_flush_asid; \
  ``st``.req.req_flush_vpn = ``intf``.req_flush_vpn; \
  ``intf``.resp_valid = ``st``.resp_valid; \
  ``intf``.resp_sfence_is_done = ``st``.resp.resp_sfence_is_done; \

`define orv64_tlb_flush_if_rx_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_resp_valid; \
  orv64_tlb_flush_if_req_t ``intf``_req; \
  orv64_tlb_flush_if_resp_t ``intf``_resp; \

`define orv64_tlb_flush_if_rx_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  orv64_tlb_flush_if_req_t ``intf``_req[``N``]; \
  orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]; \

`define orv64_tlb_flush_if_rx_port(intf) \
  input logic ``intf``_req_valid, \
  output logic ``intf``_resp_valid, \
  input orv64_tlb_flush_if_req_t ``intf``_req, \
  output orv64_tlb_flush_if_resp_t ``intf``_resp

`define orv64_tlb_flush_if_rx_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  output logic ``intf``_resp_valid[``N``], \
  input orv64_tlb_flush_if_req_t ``intf``_req[``N``], \
  output orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]

`define orv64_tlb_flush_if_rx_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``intf``_resp_valid = ``st``.resp_valid; \
  ``st``.req = ``intf``_req; \
  ``intf``_resp = ``st``.resp; \


`define orv64_tlb_flush_if_rx_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``intf``_resp_valid[``N``] = ``st``[``N``].resp_valid; \
  ``st``[``N``].req = ``intf``_req[``N``]; \
  ``intf``_resp[``N``] = ``st``[``N``].resp; \


`define orv64_tlb_flush_if_tlb_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_sfence_type = ``intf``.req_sfence_type; \
  ``st``.req.req_flush_asid = ``intf``.req_flush_asid; \
  ``st``.req.req_flush_vpn = ``intf``.req_flush_vpn; \
  ``intf``.req_ready = ``st``.req_ready; \
  ``intf``.resp_valid = ``st``.resp_valid; \
  ``intf``.resp_sfence_is_done = ``st``.resp.resp_sfence_is_done; \
  ``st``.resp_ready = ``intf``.resp_ready; \

`define orv64_tlb_flush_if_tlb_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  orv64_tlb_flush_if_req_t ``intf``_req; \
  orv64_tlb_flush_if_resp_t ``intf``_resp; \

`define orv64_tlb_flush_if_tlb_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  orv64_tlb_flush_if_req_t ``intf``_req[``N``]; \
  orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]; \

`define orv64_tlb_flush_if_tlb_port(intf) \
  input logic ``intf``_req_valid, \
  output logic ``intf``_req_ready, \
  output logic ``intf``_resp_valid, \
  input logic ``intf``_resp_ready, \
  input orv64_tlb_flush_if_req_t ``intf``_req, \
  output orv64_tlb_flush_if_resp_t ``intf``_resp

`define orv64_tlb_flush_if_tlb_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  output logic ``intf``_req_ready[``N``], \
  output logic ``intf``_resp_valid[``N``], \
  input logic ``intf``_resp_ready[``N``], \
  input orv64_tlb_flush_if_req_t ``intf``_req[``N``], \
  output orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]

`define orv64_tlb_flush_if_tlb_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``intf``_req_ready = ``st``.req_ready; \
  ``intf``_resp_valid = ``st``.resp_valid; \
  ``st``.resp_ready = ``intf``_resp_ready; \
  ``st``.req = ``intf``_req; \
  ``intf``_resp = ``st``.resp; \


`define orv64_tlb_flush_if_tlb_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \
  ``intf``_resp_valid[``N``] = ``st``[``N``].resp_valid; \
  ``st``[``N``].resp_ready = ``intf``_resp_ready[``N``]; \
  ``st``[``N``].req = ``intf``_req[``N``]; \
  ``intf``_resp[``N``] = ``st``[``N``].resp; \


`define orv64_tlb_flush_if_tx_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_sfence_type = ``st``.req.req_sfence_type; \
  ``intf``.req_flush_asid = ``st``.req.req_flush_asid; \
  ``intf``.req_flush_vpn = ``st``.req.req_flush_vpn; \
  ``st``.resp_valid = ``intf``.resp_valid; \
  ``st``.resp.resp_sfence_is_done = ``intf``.resp_sfence_is_done; \

`define orv64_tlb_flush_if_tx_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_resp_valid; \
  orv64_tlb_flush_if_req_t ``intf``_req; \
  orv64_tlb_flush_if_resp_t ``intf``_resp; \

`define orv64_tlb_flush_if_tx_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  orv64_tlb_flush_if_req_t ``intf``_req[``N``]; \
  orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]; \

`define orv64_tlb_flush_if_tx_port(intf) \
  output logic ``intf``_req_valid, \
  input logic ``intf``_resp_valid, \
  output orv64_tlb_flush_if_req_t ``intf``_req, \
  input orv64_tlb_flush_if_resp_t ``intf``_resp

`define orv64_tlb_flush_if_tx_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  input logic ``intf``_resp_valid[``N``], \
  output orv64_tlb_flush_if_req_t ``intf``_req[``N``], \
  input orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]

`define orv64_tlb_flush_if_tx_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``st``.resp_valid = ``intf``_resp_valid; \
  ``intf``_req = ``st``.req; \
  ``st``.resp = ``intf``_resp; \


`define orv64_tlb_flush_if_tx_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``st``[``N``].resp_valid = ``intf``_resp_valid[``N``]; \
  ``intf``_req[``N``] = ``st``[``N``].req; \
  ``st``[``N``].resp = ``intf``_resp[``N``]; \


`define orv64_tlb_flush_if_orv_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_sfence_type = ``st``.req.req_sfence_type; \
  ``intf``.req_flush_asid = ``st``.req.req_flush_asid; \
  ``intf``.req_flush_vpn = ``st``.req.req_flush_vpn; \
  ``st``.req_ready = ``intf``.req_ready; \
  ``st``.resp_valid = ``intf``.resp_valid; \
  ``st``.resp.resp_sfence_is_done = ``intf``.resp_sfence_is_done; \
  ``intf``.resp_ready = ``st``.resp_ready; \

`define orv64_tlb_flush_if_orv_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  orv64_tlb_flush_if_req_t ``intf``_req; \
  orv64_tlb_flush_if_resp_t ``intf``_resp; \

`define orv64_tlb_flush_if_orv_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  orv64_tlb_flush_if_req_t ``intf``_req[``N``]; \
  orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]; \

`define orv64_tlb_flush_if_orv_port(intf) \
  output logic ``intf``_req_valid, \
  input logic ``intf``_req_ready, \
  input logic ``intf``_resp_valid, \
  output logic ``intf``_resp_ready, \
  output orv64_tlb_flush_if_req_t ``intf``_req, \
  input orv64_tlb_flush_if_resp_t ``intf``_resp

`define orv64_tlb_flush_if_orv_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  input logic ``intf``_req_ready[``N``], \
  input logic ``intf``_resp_valid[``N``], \
  output logic ``intf``_resp_ready[``N``], \
  output orv64_tlb_flush_if_req_t ``intf``_req[``N``], \
  input orv64_tlb_flush_if_resp_t ``intf``_resp[``N``]

`define orv64_tlb_flush_if_orv_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``st``.req_ready = ``intf``_req_ready; \
  ``st``.resp_valid = ``intf``_resp_valid; \
  ``intf``_resp_ready = ``st``.resp_ready; \
  ``intf``_req = ``st``.req; \
  ``st``.resp = ``intf``_resp; \


`define orv64_tlb_flush_if_orv_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \
  ``st``[``N``].resp_valid = ``intf``_resp_valid[``N``]; \
  ``intf``_resp_ready[``N``] = ``st``[``N``].resp_ready; \
  ``intf``_req[``N``] = ``st``[``N``].req; \
  ``st``[``N``].resp = ``intf``_resp[``N``]; \


`define orv64_tlb_flush_if_tx_rdy_assign(intf, st) \
  ``st``.req_ready = ``intf``.req_ready; \
  ``intf``.resp_ready = ``st``.resp_ready; \

`define orv64_tlb_flush_if_tx_rdy_wire(intf) \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_ready; \

`define orv64_tlb_flush_if_tx_rdy_wire_arr(intf, N) \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_ready[``N``]; \

`define orv64_tlb_flush_if_tx_rdy_port(intf) \
  input logic ``intf``_req_ready, \
  output logic ``intf``_resp_ready

`define orv64_tlb_flush_if_tx_rdy_port_arr(intf, N) \
  input logic ``intf``_req_ready[``N``], \
  output logic ``intf``_resp_ready[``N``]

`define orv64_tlb_flush_if_tx_rdy_port2struct_assign(intf, st) \
  ``st``.req_ready = ``intf``_req_ready; \
  ``intf``_resp_ready = ``st``.resp_ready; \


`define orv64_tlb_flush_if_tx_rdy_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \
  ``intf``_resp_ready[``N``] = ``st``[``N``].resp_ready; \


`define orv64_tlb_flush_if_rx_rdy_assign(intf, st) \
  ``intf``.req_ready = ``st``.req_ready; \
  ``st``.resp_ready = ``intf``.resp_ready; \

`define orv64_tlb_flush_if_rx_rdy_wire(intf) \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_ready; \

`define orv64_tlb_flush_if_rx_rdy_wire_arr(intf, N) \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_ready[``N``]; \

`define orv64_tlb_flush_if_rx_rdy_port(intf) \
  output logic ``intf``_req_ready, \
  input logic ``intf``_resp_ready

`define orv64_tlb_flush_if_rx_rdy_port_arr(intf, N) \
  output logic ``intf``_req_ready[``N``], \
  input logic ``intf``_resp_ready[``N``]

`define orv64_tlb_flush_if_rx_rdy_port2struct_assign(intf, st) \
  ``intf``_req_ready = ``st``.req_ready; \
  ``st``.resp_ready = ``intf``_resp_ready; \


`define orv64_tlb_flush_if_rx_rdy_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \
  ``st``[``N``].resp_ready = ``intf``_resp_ready[``N``]; \


interface orv64_tlb_flush_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  logic req_valid;
  `ifndef SYNTHESIS
  logic req_valid_d;
  `endif
  logic req_ready;
  `ifndef SYNTHESIS
  logic req_ready_d;
  `endif
  logic resp_valid;
  `ifndef SYNTHESIS
  logic resp_valid_d;
  `endif
  logic resp_ready;
  `ifndef SYNTHESIS
  logic resp_ready_d;
  `endif
  orv64_tlb_flush_if_req_t req;
  orv64_tlb_flush_if_resp_t resp;
  modport rx (
    input  req_valid,
    output resp_valid,
    input  req,
    output resp
  );
  modport tlb (
    input  req_valid,
    output req_ready,
    output resp_valid,
    input  resp_ready,
    input  req,
    output resp
  );
  modport tx (
    output req_valid,
    input  resp_valid,
    output req,
    input  resp
  );
  modport orv (
    output req_valid,
    input  req_ready,
    input  resp_valid,
    output resp_ready,
    output req,
    input  resp
  );
  modport tx_rdy (
    input  req_ready,
    output resp_ready
  );
  modport rx_rdy (
    output req_ready,
    input  resp_ready
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  req_valid;
    input  req_valid_d;
    input  req_ready;
    input  req_ready_d;
    input  resp_valid;
    input  resp_valid_d;
    input  resp_ready;
    input  resp_ready_d;
    input  req;
    input  resp;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output req_valid;
    output req_ready;
    output resp_valid;
    output resp_ready;
    output req;
    output resp;
  endclocking
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    req_valid_d <= req_valid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    req_ready_d <= req_ready;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    resp_valid_d <= resp_valid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    resp_ready_d <= resp_ready;
  `endif
endinterface
`endif
`endif
