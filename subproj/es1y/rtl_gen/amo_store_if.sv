
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef AMO_STORE_IF__SV
`define AMO_STORE_IF__SV
`define amo_store_if_slave_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_paddr = ``intf``.req_paddr; \
  ``st``.req.req_data = ``intf``.req_data; \
  ``st``.req.req_mask = ``intf``.req_mask; \
  ``st``.req.req_tid = ``intf``.req_tid; \
  ``st``.req.req_type = ``intf``.req_type; \
  ``intf``.req_ready = ``st``.req_ready; \

`define amo_store_if_slave_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  amo_store_if_req_t ``intf``_req; \

`define amo_store_if_slave_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  amo_store_if_req_t ``intf``_req[``N``]; \

`define amo_store_if_slave_port(intf) \
  input logic ``intf``_req_valid, \
  output logic ``intf``_req_ready, \
  input amo_store_if_req_t ``intf``_req

`define amo_store_if_slave_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  output logic ``intf``_req_ready[``N``], \
  input amo_store_if_req_t ``intf``_req[``N``]

`define amo_store_if_slave_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``intf``_req_ready = ``st``.req_ready; \
  ``st``.req = ``intf``_req; \


`define amo_store_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \
  ``st``[``N``].req = ``intf``_req[``N``]; \


`define amo_store_if_master_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_paddr = ``st``.req.req_paddr; \
  ``intf``.req_data = ``st``.req.req_data; \
  ``intf``.req_mask = ``st``.req.req_mask; \
  ``intf``.req_tid = ``st``.req.req_tid; \
  ``intf``.req_type = ``st``.req.req_type; \
  ``st``.req_ready = ``intf``.req_ready; \

`define amo_store_if_master_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  amo_store_if_req_t ``intf``_req; \

`define amo_store_if_master_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  amo_store_if_req_t ``intf``_req[``N``]; \

`define amo_store_if_master_port(intf) \
  output logic ``intf``_req_valid, \
  input logic ``intf``_req_ready, \
  output amo_store_if_req_t ``intf``_req

`define amo_store_if_master_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  input logic ``intf``_req_ready[``N``], \
  output amo_store_if_req_t ``intf``_req[``N``]

`define amo_store_if_master_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``st``.req_ready = ``intf``_req_ready; \
  ``intf``_req = ``st``.req; \


`define amo_store_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \
  ``intf``_req[``N``] = ``st``[``N``].req; \


interface amo_store_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  `ifndef SYNTHESIS
  logic req_valid_d;
  `endif
  `ifndef SYNTHESIS
  logic req_ready_d;
  `endif
  logic req_valid;
  logic req_ready;
  amo_store_if_req_t req;
  modport slave (
    input  req_valid,
    output req_ready,
    input  req
  );
  modport master (
    output req_valid,
    input  req_ready,
    output req
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  req_valid_d;
    input  req_ready_d;
    input  req_valid;
    input  req_ready;
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
