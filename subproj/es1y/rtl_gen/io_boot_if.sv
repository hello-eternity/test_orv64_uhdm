
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef IO_BOOT_IF__SV
`define IO_BOOT_IF__SV
`define io_boot_if_tb_m_assign(intf, st) \

`define io_boot_if_tb_m_wire(intf) \

`define io_boot_if_tb_m_wire_arr(intf, N) \

`define io_boot_if_tb_m_port(intf) \


`define io_boot_if_tb_m_port_arr(intf, N) \


`define io_boot_if_tb_m_port2struct_assign(intf, st) \


`define io_boot_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define io_boot_if_tb_s_assign(intf, st) \

`define io_boot_if_tb_s_wire(intf) \

`define io_boot_if_tb_s_wire_arr(intf, N) \

`define io_boot_if_tb_s_port(intf) \


`define io_boot_if_tb_s_port_arr(intf, N) \


`define io_boot_if_tb_s_port2struct_assign(intf, st) \


`define io_boot_if_tb_s_port2struct_arr_assign(intf, st, N) \


interface io_boot_if (input clk, rstn);
  logic dir;
  logic sclk_en;
  logic txd;
  logic rxd;
  modport tb_m (
    input  dir,
    input  sclk_en,
    input  txd,
    output rxd
  );
  modport tb_s (
    output dir,
    output sclk_en,
    output txd,
    input  rxd
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  dir;
    input  sclk_en;
    input  txd;
    input  rxd;
  endclocking
  clocking drv_cb @(negedge clk);
    default output #1ps;
    output dir;
    output sclk_en;
    output txd;
    output rxd;
  endclocking
  `endif
endinterface
`endif
`endif
