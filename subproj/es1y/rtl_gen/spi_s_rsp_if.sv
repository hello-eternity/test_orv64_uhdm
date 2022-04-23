
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef SPI_S_RSP_IF__SV
`define SPI_S_RSP_IF__SV
`define spi_s_rsp_if_S_assign(intf, st) \

`define spi_s_rsp_if_S_wire(intf) \

`define spi_s_rsp_if_S_wire_arr(intf, N) \

`define spi_s_rsp_if_S_port(intf) \


`define spi_s_rsp_if_S_port_arr(intf, N) \


`define spi_s_rsp_if_S_port2struct_assign(intf, st) \


`define spi_s_rsp_if_S_port2struct_arr_assign(intf, st, N) \


`define spi_s_rsp_if_M_assign(intf, st) \

`define spi_s_rsp_if_M_wire(intf) \

`define spi_s_rsp_if_M_wire_arr(intf, N) \

`define spi_s_rsp_if_M_port(intf) \


`define spi_s_rsp_if_M_port_arr(intf, N) \


`define spi_s_rsp_if_M_port2struct_assign(intf, st) \


`define spi_s_rsp_if_M_port2struct_arr_assign(intf, st, N) \


interface spi_s_rsp_if (input clk, rstn);
  logic [4 - 1 : 0] dout;
  logic [4 - 1 : 0] oen;
  modport S (
    input  dout,
    input  oen
  );
  modport M (
    output dout,
    output oen
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  dout;
    input  oen;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output dout;
    output oen;
  endclocking
  `endif
endinterface
`endif
`endif
