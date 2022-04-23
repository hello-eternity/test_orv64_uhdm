
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef ORV64_DC_MA_IF__SV
`define ORV64_DC_MA_IF__SV
`define orv64_dc_ma_if_ma_assign(intf, st) \
  ``st``.resp_valid = ``intf``.resp_valid; \
  ``st``.resp.resp_excp_valid = ``intf``.resp_excp_valid; \
  ``st``.resp.resp_excp_cause = ``intf``.resp_excp_cause; \
  ``st``.resp.resp_data = ``intf``.resp_data; \
  ``intf``.resp_ready = ``st``.resp_ready; \

`define orv64_dc_ma_if_ma_wire(intf) \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  orv64_dc_ma_if_resp_t ``intf``_resp; \

`define orv64_dc_ma_if_ma_wire_arr(intf, N) \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  orv64_dc_ma_if_resp_t ``intf``_resp[``N``]; \

`define orv64_dc_ma_if_ma_port(intf) \
  input logic ``intf``_resp_valid, \
  output logic ``intf``_resp_ready, \
  input orv64_dc_ma_if_resp_t ``intf``_resp

`define orv64_dc_ma_if_ma_port_arr(intf, N) \
  input logic ``intf``_resp_valid[``N``], \
  output logic ``intf``_resp_ready[``N``], \
  input orv64_dc_ma_if_resp_t ``intf``_resp[``N``]

`define orv64_dc_ma_if_ma_port2struct_assign(intf, st) \
  ``st``.resp_valid = ``intf``_resp_valid; \
  ``intf``_resp_ready = ``st``.resp_ready; \
  ``st``.resp = ``intf``_resp; \


`define orv64_dc_ma_if_ma_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].resp_valid = ``intf``_resp_valid[``N``]; \
  ``intf``_resp_ready[``N``] = ``st``[``N``].resp_ready; \
  ``st``[``N``].resp = ``intf``_resp[``N``]; \


`define orv64_dc_ma_if_dc_assign(intf, st) \
  ``intf``.resp_valid = ``st``.resp_valid; \
  ``intf``.resp_excp_valid = ``st``.resp.resp_excp_valid; \
  ``intf``.resp_excp_cause = ``st``.resp.resp_excp_cause; \
  ``intf``.resp_data = ``st``.resp.resp_data; \
  ``st``.resp_ready = ``intf``.resp_ready; \

`define orv64_dc_ma_if_dc_wire(intf) \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  orv64_dc_ma_if_resp_t ``intf``_resp; \

`define orv64_dc_ma_if_dc_wire_arr(intf, N) \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  orv64_dc_ma_if_resp_t ``intf``_resp[``N``]; \

`define orv64_dc_ma_if_dc_port(intf) \
  output logic ``intf``_resp_valid, \
  input logic ``intf``_resp_ready, \
  output orv64_dc_ma_if_resp_t ``intf``_resp

`define orv64_dc_ma_if_dc_port_arr(intf, N) \
  output logic ``intf``_resp_valid[``N``], \
  input logic ``intf``_resp_ready[``N``], \
  output orv64_dc_ma_if_resp_t ``intf``_resp[``N``]

`define orv64_dc_ma_if_dc_port2struct_assign(intf, st) \
  ``intf``_resp_valid = ``st``.resp_valid; \
  ``st``.resp_ready = ``intf``_resp_ready; \
  ``intf``_resp = ``st``.resp; \


`define orv64_dc_ma_if_dc_port2struct_arr_assign(intf, st, N) \
  ``intf``_resp_valid[``N``] = ``st``[``N``].resp_valid; \
  ``st``[``N``].resp_ready = ``intf``_resp_ready[``N``]; \
  ``intf``_resp[``N``] = ``st``[``N``].resp; \


interface orv64_dc_ma_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  logic resp_valid;
  logic resp_ready;
  orv64_dc_ma_if_resp_t resp;
  modport ma (
    input  resp_valid,
    output resp_ready,
    input  resp
  );
  modport dc (
    output resp_valid,
    input  resp_ready,
    output resp
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  resp_valid;
    input  resp_ready;
    input  resp;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output resp_valid;
    output resp_ready;
    output resp;
  endclocking
  `endif
endinterface
`endif
`endif
