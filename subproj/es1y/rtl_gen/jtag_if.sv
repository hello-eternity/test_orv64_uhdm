
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef JTAG_IF__SV
`define JTAG_IF__SV
`define jtag_if_slave_assign(intf, st) \

`define jtag_if_slave_wire(intf) \

`define jtag_if_slave_wire_arr(intf, N) \

`define jtag_if_slave_port(intf) \


`define jtag_if_slave_port_arr(intf, N) \


`define jtag_if_slave_port2struct_assign(intf, st) \


`define jtag_if_slave_port2struct_arr_assign(intf, st, N) \


`define jtag_if_master_assign(intf, st) \

`define jtag_if_master_wire(intf) \

`define jtag_if_master_wire_arr(intf, N) \

`define jtag_if_master_port(intf) \


`define jtag_if_master_port_arr(intf, N) \


`define jtag_if_master_port2struct_assign(intf, st) \


`define jtag_if_master_port2struct_arr_assign(intf, st, N) \


interface jtag_if (input clk, rstn);
  logic trst_n;
  logic tms;
  logic tdi;
  logic tdo;
  logic tck_en;
  modport slave (
    input  trst_n,
    input  tms,
    input  tdi,
    output tdo,
    input  tck_en
  );
  modport master (
    output trst_n,
    output tms,
    output tdi,
    input  tdo,
    output tck_en
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  trst_n;
    input  tms;
    input  tdi;
    input  tdo;
    input  tck_en;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output trst_n;
    output tms;
    output tdi;
    output tdo;
    output tck_en;
  endclocking
  `endif
endinterface
`endif
`endif
