
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef SCAN_F_IF__SV
`define SCAN_F_IF__SV
`define scan_f_if_slave_assign(intf, st) \

`define scan_f_if_slave_wire(intf) \

`define scan_f_if_slave_wire_arr(intf, N) \

`define scan_f_if_slave_port(intf) \


`define scan_f_if_slave_port_arr(intf, N) \


`define scan_f_if_slave_port2struct_assign(intf, st) \


`define scan_f_if_slave_port2struct_arr_assign(intf, st, N) \


`define scan_f_if_master_assign(intf, st) \

`define scan_f_if_master_wire(intf) \

`define scan_f_if_master_wire_arr(intf, N) \

`define scan_f_if_master_port(intf) \


`define scan_f_if_master_port_arr(intf, N) \


`define scan_f_if_master_port2struct_assign(intf, st) \


`define scan_f_if_master_port2struct_arr_assign(intf, st, N) \


interface scan_f_if (input clk, rstn);
  logic scan_in;
  logic scan_out;
  logic mode;
  modport slave (
    input  scan_in,
    output scan_out
  );
  modport master (
    output scan_in,
    input  scan_out
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  scan_in;
    input  scan_out;
    input  mode;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output scan_in;
    output scan_out;
    output mode;
  endclocking
  `endif
endinterface
`endif
`endif
