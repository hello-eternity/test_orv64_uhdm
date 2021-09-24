
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef TEST_IO_IF__SV
`define TEST_IO_IF__SV
`define test_io_if_CHIP_assign(intf, st) \

`define test_io_if_CHIP_wire(intf) \

`define test_io_if_CHIP_wire_arr(intf, N) \

`define test_io_if_CHIP_port(intf) \


`define test_io_if_CHIP_port_arr(intf, N) \


`define test_io_if_CHIP_port2struct_assign(intf, st) \


`define test_io_if_CHIP_port2struct_arr_assign(intf, st, N) \


`define test_io_if_FPGA_assign(intf, st) \

`define test_io_if_FPGA_wire(intf) \

`define test_io_if_FPGA_wire_arr(intf, N) \

`define test_io_if_FPGA_port(intf) \


`define test_io_if_FPGA_port_arr(intf, N) \


`define test_io_if_FPGA_port2struct_assign(intf, st) \


`define test_io_if_FPGA_port2struct_arr_assign(intf, st, N) \


interface test_io_if (input clk, rstn);
  logic ein;
  logic eout;
  logic din;
  logic dout;
  logic dir;
  modport CHIP (
    input  ein,
    output eout,
    input  din,
    output dout
  );
  modport FPGA (
    output ein,
    input  eout,
    output din,
    input  dout
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  ein;
    input  eout;
    input  din;
    input  dout;
    input  dir;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output ein;
    output eout;
    output din;
    output dout;
    output dir;
  endclocking
  `endif
endinterface
`endif
`endif
