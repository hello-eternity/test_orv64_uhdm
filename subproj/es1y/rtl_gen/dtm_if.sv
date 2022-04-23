
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef DTM_IF__SV
`define DTM_IF__SV
`define dtm_if_sender_assign(intf, st) \

`define dtm_if_sender_wire(intf) \

`define dtm_if_sender_wire_arr(intf, N) \

`define dtm_if_sender_port(intf) \


`define dtm_if_sender_port_arr(intf, N) \


`define dtm_if_sender_port2struct_assign(intf, st) \


`define dtm_if_sender_port2struct_arr_assign(intf, st, N) \


`define dtm_if_receiver_assign(intf, st) \

`define dtm_if_receiver_wire(intf) \

`define dtm_if_receiver_wire_arr(intf, N) \

`define dtm_if_receiver_port(intf) \


`define dtm_if_receiver_port_arr(intf, N) \


`define dtm_if_receiver_port2struct_assign(intf, st) \


`define dtm_if_receiver_port2struct_arr_assign(intf, st, N) \


interface dtm_if (input clk, rstn);
  logic req_valid;
  logic req_ready;
  logic [7 - 1 : 0] req_bits_addr;
  logic [2 - 1 : 0] req_bits_op;
  logic [32 - 1 : 0] req_bits_data;
  logic [64 - 1 : 0] fromhost_addr;
  logic [64 - 1 : 0] tohost_addr;
  logic resp_valid;
  logic resp_ready;
  logic [2 - 1 : 0] resp_bits_resp;
  logic [32 - 1 : 0] resp_bits_data;
  modport sender (
    input  req_valid,
    output req_ready,
    input  req_bits_addr,
    input  req_bits_op,
    input  req_bits_data,
    input  fromhost_addr,
    input  tohost_addr,
    output resp_valid,
    input  resp_ready,
    output resp_bits_resp,
    output resp_bits_data
  );
  modport receiver (
    output req_valid,
    input  req_ready,
    output req_bits_addr,
    output req_bits_op,
    output req_bits_data,
    output fromhost_addr,
    output tohost_addr,
    input  resp_valid,
    output resp_ready,
    input  resp_bits_resp,
    input  resp_bits_data
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  req_valid;
    input  req_ready;
    input  req_bits_addr;
    input  req_bits_op;
    input  req_bits_data;
    input  fromhost_addr;
    input  tohost_addr;
    input  resp_valid;
    input  resp_ready;
    input  resp_bits_resp;
    input  resp_bits_data;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output req_valid;
    output req_ready;
    output req_bits_addr;
    output req_bits_op;
    output req_bits_data;
    output fromhost_addr;
    output tohost_addr;
    output resp_valid;
    output resp_ready;
    output resp_bits_resp;
    output resp_bits_data;
  endclocking
  `endif
endinterface
`endif
`endif
