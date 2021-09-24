
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef USB_CACHE_IF__SV
`define USB_CACHE_IF__SV
`define usb_cache_if_slave_assign(intf, st) \
  ``st``.req_valid = ``intf``.req_valid; \
  ``st``.req.req_paddr = ``intf``.req_paddr; \
  ``st``.req.req_data = ``intf``.req_data; \
  ``st``.req.req_mask = ``intf``.req_mask; \
  ``st``.req.req_tid = ``intf``.req_tid; \
  ``st``.req.req_type = ``intf``.req_type; \
  ``intf``.req_ready = ``st``.req_ready; \
  ``intf``.resp_valid = ``st``.resp_valid; \
  ``intf``.resp_data = ``st``.resp.resp_data; \
  ``intf``.resp_type = ``st``.resp.resp_type; \
  ``intf``.resp_mask = ``st``.resp.resp_mask; \
  ``intf``.resp_tid = ``st``.resp.resp_tid; \
  ``st``.resp_ready = ``intf``.resp_ready; \

`define usb_cache_if_slave_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  usb_cache_if_req_t ``intf``_req; \
  usb_cache_if_resp_t ``intf``_resp; \

`define usb_cache_if_slave_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  usb_cache_if_req_t ``intf``_req[``N``]; \
  usb_cache_if_resp_t ``intf``_resp[``N``]; \

`define usb_cache_if_slave_port(intf) \
  input logic ``intf``_req_valid, \
  output logic ``intf``_req_ready, \
  output logic ``intf``_resp_valid, \
  input logic ``intf``_resp_ready, \
  input usb_cache_if_req_t ``intf``_req, \
  output usb_cache_if_resp_t ``intf``_resp

`define usb_cache_if_slave_port_arr(intf, N) \
  input logic ``intf``_req_valid[``N``], \
  output logic ``intf``_req_ready[``N``], \
  output logic ``intf``_resp_valid[``N``], \
  input logic ``intf``_resp_ready[``N``], \
  input usb_cache_if_req_t ``intf``_req[``N``], \
  output usb_cache_if_resp_t ``intf``_resp[``N``]

`define usb_cache_if_slave_port2struct_assign(intf, st) \
  ``st``.req_valid = ``intf``_req_valid; \
  ``intf``_req_ready = ``st``.req_ready; \
  ``intf``_resp_valid = ``st``.resp_valid; \
  ``st``.resp_ready = ``intf``_resp_ready; \
  ``st``.req = ``intf``_req; \
  ``intf``_resp = ``st``.resp; \


`define usb_cache_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].req_valid = ``intf``_req_valid[``N``]; \
  ``intf``_req_ready[``N``] = ``st``[``N``].req_ready; \
  ``intf``_resp_valid[``N``] = ``st``[``N``].resp_valid; \
  ``st``[``N``].resp_ready = ``intf``_resp_ready[``N``]; \
  ``st``[``N``].req = ``intf``_req[``N``]; \
  ``intf``_resp[``N``] = ``st``[``N``].resp; \


`define usb_cache_if_master_assign(intf, st) \
  ``intf``.req_valid = ``st``.req_valid; \
  ``intf``.req_paddr = ``st``.req.req_paddr; \
  ``intf``.req_data = ``st``.req.req_data; \
  ``intf``.req_mask = ``st``.req.req_mask; \
  ``intf``.req_tid = ``st``.req.req_tid; \
  ``intf``.req_type = ``st``.req.req_type; \
  ``st``.req_ready = ``intf``.req_ready; \
  ``st``.resp_valid = ``intf``.resp_valid; \
  ``st``.resp.resp_data = ``intf``.resp_data; \
  ``st``.resp.resp_type = ``intf``.resp_type; \
  ``st``.resp.resp_mask = ``intf``.resp_mask; \
  ``st``.resp.resp_tid = ``intf``.resp_tid; \
  ``intf``.resp_ready = ``st``.resp_ready; \

`define usb_cache_if_master_wire(intf) \
  logic ``intf``_req_valid; \
  logic ``intf``_req_ready; \
  logic ``intf``_resp_valid; \
  logic ``intf``_resp_ready; \
  usb_cache_if_req_t ``intf``_req; \
  usb_cache_if_resp_t ``intf``_resp; \

`define usb_cache_if_master_wire_arr(intf, N) \
  logic ``intf``_req_valid[``N``]; \
  logic ``intf``_req_ready[``N``]; \
  logic ``intf``_resp_valid[``N``]; \
  logic ``intf``_resp_ready[``N``]; \
  usb_cache_if_req_t ``intf``_req[``N``]; \
  usb_cache_if_resp_t ``intf``_resp[``N``]; \

`define usb_cache_if_master_port(intf) \
  output logic ``intf``_req_valid, \
  input logic ``intf``_req_ready, \
  input logic ``intf``_resp_valid, \
  output logic ``intf``_resp_ready, \
  output usb_cache_if_req_t ``intf``_req, \
  input usb_cache_if_resp_t ``intf``_resp

`define usb_cache_if_master_port_arr(intf, N) \
  output logic ``intf``_req_valid[``N``], \
  input logic ``intf``_req_ready[``N``], \
  input logic ``intf``_resp_valid[``N``], \
  output logic ``intf``_resp_ready[``N``], \
  output usb_cache_if_req_t ``intf``_req[``N``], \
  input usb_cache_if_resp_t ``intf``_resp[``N``]

`define usb_cache_if_master_port2struct_assign(intf, st) \
  ``intf``_req_valid = ``st``.req_valid; \
  ``st``.req_ready = ``intf``_req_ready; \
  ``st``.resp_valid = ``intf``_resp_valid; \
  ``intf``_resp_ready = ``st``.resp_ready; \
  ``intf``_req = ``st``.req; \
  ``st``.resp = ``intf``_resp; \


`define usb_cache_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_req_valid[``N``] = ``st``[``N``].req_valid; \
  ``st``[``N``].req_ready = ``intf``_req_ready[``N``]; \
  ``st``[``N``].resp_valid = ``intf``_resp_valid[``N``]; \
  ``intf``_resp_ready[``N``] = ``st``[``N``].resp_ready; \
  ``intf``_req[``N``] = ``st``[``N``].req; \
  ``st``[``N``].resp = ``intf``_resp[``N``]; \


interface usb_cache_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  logic req_valid;
  logic req_ready;
  logic resp_valid;
  logic resp_ready;
  usb_cache_if_req_t req;
  usb_cache_if_resp_t resp;
  modport slave (
    input  req_valid,
    output req_ready,
    output resp_valid,
    input  resp_ready,
    input  req,
    output resp
  );
  modport master (
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
    input  req_valid;
    input  req_ready;
    input  resp_valid;
    input  resp_ready;
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
endinterface
`endif
`endif
