
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef CSR_SATP_IF__SV
`define CSR_SATP_IF__SV
`define csr_satp_if_tb_s_assign(intf, st) \

`define csr_satp_if_tb_s_wire(intf) \

`define csr_satp_if_tb_s_wire_arr(intf, N) \

`define csr_satp_if_tb_s_port(intf) \


`define csr_satp_if_tb_s_port_arr(intf, N) \


`define csr_satp_if_tb_s_port2struct_assign(intf, st) \


`define csr_satp_if_tb_s_port2struct_arr_assign(intf, st, N) \


`define csr_satp_if_tb_m_assign(intf, st) \

`define csr_satp_if_tb_m_wire(intf) \

`define csr_satp_if_tb_m_wire_arr(intf, N) \

`define csr_satp_if_tb_m_port(intf) \


`define csr_satp_if_tb_m_port_arr(intf, N) \


`define csr_satp_if_tb_m_port2struct_assign(intf, st) \


`define csr_satp_if_tb_m_port2struct_arr_assign(intf, st, N) \


interface csr_satp_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_typedef::*;
  import orv64_typedef_pkg::*;
  import orv_typedef::*;
  orv64_csr_satp_t satp;
  modport tb_s (
    input  satp
  );
  modport tb_m (
    output satp
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  satp;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output satp;
  endclocking
  `endif
endinterface
`endif
`endif
