
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef SPI_M_REQ_IF__SV
`define SPI_M_REQ_IF__SV
`define spi_m_req_if_M_assign(intf, st) \

`define spi_m_req_if_M_wire(intf) \

`define spi_m_req_if_M_wire_arr(intf, N) \

`define spi_m_req_if_M_port(intf) \


`define spi_m_req_if_M_port_arr(intf, N) \


`define spi_m_req_if_M_port2struct_assign(intf, st) \


`define spi_m_req_if_M_port2struct_arr_assign(intf, st, N) \


`define spi_m_req_if_S_assign(intf, st) \

`define spi_m_req_if_S_wire(intf) \

`define spi_m_req_if_S_wire_arr(intf, N) \

`define spi_m_req_if_S_port(intf) \


`define spi_m_req_if_S_port_arr(intf, N) \


`define spi_m_req_if_S_port2struct_assign(intf, st) \


`define spi_m_req_if_S_port2struct_arr_assign(intf, st, N) \


interface spi_m_req_if (input clk, rstn);
  logic [4 - 1 : 0] spi_mode;
  logic spi_clk;
  logic cs;
  logic [4 - 1 : 0] din;
  modport M (
    input  spi_mode,
    input  spi_clk,
    input  cs,
    input  din
  );
  modport S (
    output spi_mode,
    output spi_clk,
    output cs,
    output din
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  spi_mode;
    input  spi_clk;
    input  cs;
    input  din;
  endclocking
  clocking drv_cb @(negedge clk);
    default output #1ps;
    output spi_mode;
    output spi_clk;
    output cs;
    output din;
  endclocking
  `endif
endinterface
`endif
`endif
