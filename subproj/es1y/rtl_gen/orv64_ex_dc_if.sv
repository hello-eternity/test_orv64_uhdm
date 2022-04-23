
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef ORV64_EX_DC_IF__SV
`define ORV64_EX_DC_IF__SV
`define orv64_ex_dc_if_rx_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_vaddr = ``intf``.req_vaddr; \
  ``st``.req.req_rw = ``intf``.req_rw; \
  ``st``.req.req_wdata = ``intf``.req_wdata; \
  ``st``.req.req_mask = ``intf``.req_mask; \

`define orv64_ex_dc_if_rx_wire(intf) \
  logic ``intf``_req_valid; \
  orv64_ex_dc_if_req_t ``intf``_req; \

`define orv64_ex_dc_if_rx_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  orv64_ex_dc_if_req_t ``intf``_req[``N``]; \

`define orv64_ex_dc_if_rx_port(intf) \
  input logic ``intf``_req_valid, \
  input orv64_ex_dc_if_req_t ``intf``_req

`define orv64_ex_dc_if_rx_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  input orv64_ex_dc_if_req_t ``intf``_req[``N``]

`define orv64_ex_dc_if_rx_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``st``.req = ``intf``_req; \


`define orv64_ex_dc_if_rx_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``st``[``N``].req = ``intf``_req[``N``]; \


`define orv64_ex_dc_if_dc_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_vaddr = ``intf``.req_vaddr; \
  ``st``.req.req_rw = ``intf``.req_rw; \
  ``st``.req.req_wdata = ``intf``.req_wdata; \
  ``st``.req.req_mask = ``intf``.req_mask; \
  ``intf``.req_ready = ``st``.req_ready; \

`define orv64_ex_dc_if_dc_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  orv64_ex_dc_if_req_t ``intf``_req; \

`define orv64_ex_dc_if_dc_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  orv64_ex_dc_if_req_t ``intf``_req[``N``]; \

`define orv64_ex_dc_if_dc_port(intf) \
  input logic ``intf``_req_valid, \
  output logic ``intf``_req_ready, \
  input orv64_ex_dc_if_req_t ``intf``_req

`define orv64_ex_dc_if_dc_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  output logic ``intf``_req_ready[``N``], \
  input orv64_ex_dc_if_req_t ``intf``_req[``N``]

`define orv64_ex_dc_if_dc_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``intf``_req_ready = ``st``.req_ready; \
  ``st``.req = ``intf``_req; \


`define orv64_ex_dc_if_dc_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \
  ``st``[``N``].req = ``intf``_req[``N``]; \


`define orv64_ex_dc_if_tx_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_vaddr = ``st``.req.req_vaddr; \
  ``intf``.req_rw = ``st``.req.req_rw; \
  ``intf``.req_wdata = ``st``.req.req_wdata; \
  ``intf``.req_mask = ``st``.req.req_mask; \

`define orv64_ex_dc_if_tx_wire(intf) \
  logic ``intf``_req_valid; \
  orv64_ex_dc_if_req_t ``intf``_req; \

`define orv64_ex_dc_if_tx_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  orv64_ex_dc_if_req_t ``intf``_req[``N``]; \

`define orv64_ex_dc_if_tx_port(intf) \
  output logic ``intf``_req_valid, \
  output orv64_ex_dc_if_req_t ``intf``_req

`define orv64_ex_dc_if_tx_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  output orv64_ex_dc_if_req_t ``intf``_req[``N``]

`define orv64_ex_dc_if_tx_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``intf``_req = ``st``.req; \


`define orv64_ex_dc_if_tx_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``intf``_req[``N``] = ``st``[``N``].req; \


`define orv64_ex_dc_if_orv_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_vaddr = ``st``.req.req_vaddr; \
  ``intf``.req_rw = ``st``.req.req_rw; \
  ``intf``.req_wdata = ``st``.req.req_wdata; \
  ``intf``.req_mask = ``st``.req.req_mask; \
  ``st``.req_ready = ``intf``.req_ready; \

`define orv64_ex_dc_if_orv_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  orv64_ex_dc_if_req_t ``intf``_req; \

`define orv64_ex_dc_if_orv_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  orv64_ex_dc_if_req_t ``intf``_req[``N``]; \

`define orv64_ex_dc_if_orv_port(intf) \
  output logic ``intf``_req_valid, \
  input logic ``intf``_req_ready, \
  output orv64_ex_dc_if_req_t ``intf``_req

`define orv64_ex_dc_if_orv_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  input logic ``intf``_req_ready[``N``], \
  output orv64_ex_dc_if_req_t ``intf``_req[``N``]

`define orv64_ex_dc_if_orv_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``st``.req_ready = ``intf``_req_ready; \
  ``intf``_req = ``st``.req; \


`define orv64_ex_dc_if_orv_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \
  ``intf``_req[``N``] = ``st``[``N``].req; \


`define orv64_ex_dc_if_tx_rdy_assign(intf, st) \
  ``st``.req_ready = ``intf``.req_ready; \

`define orv64_ex_dc_if_tx_rdy_wire(intf) \
  logic ``intf``_req_ready; \

`define orv64_ex_dc_if_tx_rdy_wire_arr(intf, N) \
  logic ``intf``_req_ready[``N``]; \

`define orv64_ex_dc_if_tx_rdy_port(intf) \
  input logic ``intf``_req_ready

`define orv64_ex_dc_if_tx_rdy_port_arr(intf, N) \
  input logic ``intf``_req_ready[``N``]

`define orv64_ex_dc_if_tx_rdy_port2struct_assign(intf, st) \
  ``st``.req_ready = ``intf``_req_ready; \


`define orv64_ex_dc_if_tx_rdy_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \


`define orv64_ex_dc_if_rx_rdy_assign(intf, st) \
  ``intf``.req_ready = ``st``.req_ready; \

`define orv64_ex_dc_if_rx_rdy_wire(intf) \
  logic ``intf``_req_ready; \

`define orv64_ex_dc_if_rx_rdy_wire_arr(intf, N) \
  logic ``intf``_req_ready[``N``]; \

`define orv64_ex_dc_if_rx_rdy_port(intf) \
  output logic ``intf``_req_ready

`define orv64_ex_dc_if_rx_rdy_port_arr(intf, N) \
  output logic ``intf``_req_ready[``N``]

`define orv64_ex_dc_if_rx_rdy_port2struct_assign(intf, st) \
  ``intf``_req_ready = ``st``.req_ready; \


`define orv64_ex_dc_if_rx_rdy_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \


interface orv64_ex_dc_if (input clk, rstn);
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
  orv64_ex_dc_if_req_t req;
  modport rx (
    input  req_valid,
    input  req
  );
  modport dc (
    input  req_valid,
    output req_ready,
    input  req
  );
  modport tx (
    output req_valid,
    output req
  );
  modport orv (
    output req_valid,
    input  req_ready,
    output req
  );
  modport tx_rdy (
    input  req_ready
  );
  modport rx_rdy (
    output req_ready
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  req_valid;
    input  req_valid_d;
    input  req_ready;
    input  req_ready_d;
    input  req;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output req_valid;
    output req_ready;
    output req;
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
endinterface
`endif
`endif
