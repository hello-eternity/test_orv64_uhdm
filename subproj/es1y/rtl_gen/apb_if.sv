
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef APB_IF__SV
`define APB_IF__SV
`define apb_if_tb_m_assign(intf, st) \
  ``st``.paddr = ``intf``.paddr; \
  ``st``.pselx = ``intf``.pselx; \
  ``st``.penable = ``intf``.penable; \
  ``st``.pwrite = ``intf``.pwrite; \
  ``st``.pwdata = ``intf``.pwdata; \

`define apb_if_tb_m_wire(intf) \
  logic [40 - 1 : 0] ``intf``_paddr; \
  logic ``intf``_pselx; \
  logic ``intf``_penable; \
  logic ``intf``_pwrite; \
  logic [64 - 1 : 0] ``intf``_pwdata; \

`define apb_if_tb_m_wire_arr(intf, N) \
  logic [40 - 1 : 0] ``intf``_paddr[``N``]; \
  logic ``intf``_pselx[``N``]; \
  logic ``intf``_penable[``N``]; \
  logic ``intf``_pwrite[``N``]; \
  logic [64 - 1 : 0] ``intf``_pwdata[``N``]; \

`define apb_if_tb_m_port(intf) \
  input logic [40 - 1 : 0] ``intf``_paddr, \
  input logic ``intf``_pselx, \
  input logic ``intf``_penable, \
  input logic ``intf``_pwrite, \
  input logic [64 - 1 : 0] ``intf``_pwdata

`define apb_if_tb_m_port_arr(intf, N) \
  input logic [40 - 1 : 0] ``intf``_paddr[``N``], \
  input logic ``intf``_pselx[``N``], \
  input logic ``intf``_penable[``N``], \
  input logic ``intf``_pwrite[``N``], \
  input logic [64 - 1 : 0] ``intf``_pwdata[``N``]

`define apb_if_tb_m_port2struct_assign(intf, st) \
  ``st``.paddr = ``intf``_paddr; \
  ``st``.pselx = ``intf``_pselx; \
  ``st``.penable = ``intf``_penable; \
  ``st``.pwrite = ``intf``_pwrite; \
  ``st``.pwdata = ``intf``_pwdata; \


`define apb_if_tb_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].paddr = ``intf``_paddr[``N``]; \
  ``st``[``N``].pselx = ``intf``_pselx[``N``]; \
  ``st``[``N``].penable = ``intf``_penable[``N``]; \
  ``st``[``N``].pwrite = ``intf``_pwrite[``N``]; \
  ``st``[``N``].pwdata = ``intf``_pwdata[``N``]; \


`define apb_if_slave_assign(intf, st) \
  ``st``.paddr = ``intf``.paddr; \
  ``st``.pselx = ``intf``.pselx; \
  ``st``.penable = ``intf``.penable; \
  ``st``.pwrite = ``intf``.pwrite; \
  ``st``.pwdata = ``intf``.pwdata; \
  ``intf``.pready = ``st``.pready; \
  ``st``.prdata = ``intf``.prdata; \
  ``st``.pclk = ``intf``.pclk; \
  ``st``.presetn = ``intf``.presetn; \

`define apb_if_slave_wire(intf) \
  logic [40 - 1 : 0] ``intf``_paddr; \
  logic ``intf``_pselx; \
  logic ``intf``_penable; \
  logic ``intf``_pwrite; \
  logic [64 - 1 : 0] ``intf``_pwdata; \
  logic ``intf``_pready; \
  logic [64 - 1 : 0] ``intf``_prdata; \
  logic ``intf``_pclk; \
  logic ``intf``_presetn; \

`define apb_if_slave_wire_arr(intf, N) \
  logic [40 - 1 : 0] ``intf``_paddr[``N``]; \
  logic ``intf``_pselx[``N``]; \
  logic ``intf``_penable[``N``]; \
  logic ``intf``_pwrite[``N``]; \
  logic [64 - 1 : 0] ``intf``_pwdata[``N``]; \
  logic ``intf``_pready[``N``]; \
  logic [64 - 1 : 0] ``intf``_prdata[``N``]; \
  logic ``intf``_pclk[``N``]; \
  logic ``intf``_presetn[``N``]; \

`define apb_if_slave_port(intf) \
  input logic [40 - 1 : 0] ``intf``_paddr, \
  input logic ``intf``_pselx, \
  input logic ``intf``_penable, \
  input logic ``intf``_pwrite, \
  input logic [64 - 1 : 0] ``intf``_pwdata, \
  output logic ``intf``_pready, \
  input logic [64 - 1 : 0] ``intf``_prdata, \
  input logic ``intf``_pclk, \
  input logic ``intf``_presetn

`define apb_if_slave_port_arr(intf, N) \
  input logic [40 - 1 : 0] ``intf``_paddr[``N``], \
  input logic ``intf``_pselx[``N``], \
  input logic ``intf``_penable[``N``], \
  input logic ``intf``_pwrite[``N``], \
  input logic [64 - 1 : 0] ``intf``_pwdata[``N``], \
  output logic ``intf``_pready[``N``], \
  input logic [64 - 1 : 0] ``intf``_prdata[``N``], \
  input logic ``intf``_pclk[``N``], \
  input logic ``intf``_presetn[``N``]

`define apb_if_slave_port2struct_assign(intf, st) \
  ``st``.paddr = ``intf``_paddr; \
  ``st``.pselx = ``intf``_pselx; \
  ``st``.penable = ``intf``_penable; \
  ``st``.pwrite = ``intf``_pwrite; \
  ``st``.pwdata = ``intf``_pwdata; \
  ``intf``_pready = ``st``.pready; \
  ``st``.prdata = ``intf``_prdata; \
  ``st``.pclk = ``intf``_pclk; \
  ``st``.presetn = ``intf``_presetn; \


`define apb_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].paddr = ``intf``_paddr[``N``]; \
  ``st``[``N``].pselx = ``intf``_pselx[``N``]; \
  ``st``[``N``].penable = ``intf``_penable[``N``]; \
  ``st``[``N``].pwrite = ``intf``_pwrite[``N``]; \
  ``st``[``N``].pwdata = ``intf``_pwdata[``N``]; \
  ``intf``_pready[``N``] = ``st``[``N``].pready; \
  ``st``[``N``].prdata = ``intf``_prdata[``N``]; \
  ``st``[``N``].pclk = ``intf``_pclk[``N``]; \
  ``st``[``N``].presetn = ``intf``_presetn[``N``]; \


`define apb_if_tb_s_assign(intf, st) \
  ``intf``.paddr = ``st``.paddr; \
  ``intf``.pselx = ``st``.pselx; \
  ``intf``.pwrite = ``st``.pwrite; \
  ``intf``.pwdata = ``st``.pwdata; \

`define apb_if_tb_s_wire(intf) \
  logic [40 - 1 : 0] ``intf``_paddr; \
  logic ``intf``_pselx; \
  logic ``intf``_pwrite; \
  logic [64 - 1 : 0] ``intf``_pwdata; \

`define apb_if_tb_s_wire_arr(intf, N) \
  logic [40 - 1 : 0] ``intf``_paddr[``N``]; \
  logic ``intf``_pselx[``N``]; \
  logic ``intf``_pwrite[``N``]; \
  logic [64 - 1 : 0] ``intf``_pwdata[``N``]; \

`define apb_if_tb_s_port(intf) \
  output logic [40 - 1 : 0] ``intf``_paddr, \
  output logic ``intf``_pselx, \
  output logic ``intf``_pwrite, \
  output logic [64 - 1 : 0] ``intf``_pwdata

`define apb_if_tb_s_port_arr(intf, N) \
  output logic [40 - 1 : 0] ``intf``_paddr[``N``], \
  output logic ``intf``_pselx[``N``], \
  output logic ``intf``_pwrite[``N``], \
  output logic [64 - 1 : 0] ``intf``_pwdata[``N``]

`define apb_if_tb_s_port2struct_assign(intf, st) \
  ``intf``_paddr = ``st``.paddr; \
  ``intf``_pselx = ``st``.pselx; \
  ``intf``_pwrite = ``st``.pwrite; \
  ``intf``_pwdata = ``st``.pwdata; \


`define apb_if_tb_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_paddr[``N``] = ``st``[``N``].paddr; \
  ``intf``_pselx[``N``] = ``st``[``N``].pselx; \
  ``intf``_pwrite[``N``] = ``st``[``N``].pwrite; \
  ``intf``_pwdata[``N``] = ``st``[``N``].pwdata; \


`define apb_if_master_assign(intf, st) \
  ``intf``.paddr = ``st``.paddr; \
  ``intf``.pselx = ``st``.pselx; \
  ``intf``.penable = ``st``.penable; \
  ``intf``.pwrite = ``st``.pwrite; \
  ``intf``.pwdata = ``st``.pwdata; \
  ``st``.pready = ``intf``.pready; \
  ``intf``.prdata = ``st``.prdata; \
  ``intf``.pclk = ``st``.pclk; \
  ``intf``.presetn = ``st``.presetn; \

`define apb_if_master_wire(intf) \
  logic [40 - 1 : 0] ``intf``_paddr; \
  logic ``intf``_pselx; \
  logic ``intf``_penable; \
  logic ``intf``_pwrite; \
  logic [64 - 1 : 0] ``intf``_pwdata; \
  logic ``intf``_pready; \
  logic [64 - 1 : 0] ``intf``_prdata; \
  logic ``intf``_pclk; \
  logic ``intf``_presetn; \

`define apb_if_master_wire_arr(intf, N) \
  logic [40 - 1 : 0] ``intf``_paddr[``N``]; \
  logic ``intf``_pselx[``N``]; \
  logic ``intf``_penable[``N``]; \
  logic ``intf``_pwrite[``N``]; \
  logic [64 - 1 : 0] ``intf``_pwdata[``N``]; \
  logic ``intf``_pready[``N``]; \
  logic [64 - 1 : 0] ``intf``_prdata[``N``]; \
  logic ``intf``_pclk[``N``]; \
  logic ``intf``_presetn[``N``]; \

`define apb_if_master_port(intf) \
  output logic [40 - 1 : 0] ``intf``_paddr, \
  output logic ``intf``_pselx, \
  output logic ``intf``_penable, \
  output logic ``intf``_pwrite, \
  output logic [64 - 1 : 0] ``intf``_pwdata, \
  input logic ``intf``_pready, \
  output logic [64 - 1 : 0] ``intf``_prdata, \
  output logic ``intf``_pclk, \
  output logic ``intf``_presetn

`define apb_if_master_port_arr(intf, N) \
  output logic [40 - 1 : 0] ``intf``_paddr[``N``], \
  output logic ``intf``_pselx[``N``], \
  output logic ``intf``_penable[``N``], \
  output logic ``intf``_pwrite[``N``], \
  output logic [64 - 1 : 0] ``intf``_pwdata[``N``], \
  input logic ``intf``_pready[``N``], \
  output logic [64 - 1 : 0] ``intf``_prdata[``N``], \
  output logic ``intf``_pclk[``N``], \
  output logic ``intf``_presetn[``N``]

`define apb_if_master_port2struct_assign(intf, st) \
  ``intf``_paddr = ``st``.paddr; \
  ``intf``_pselx = ``st``.pselx; \
  ``intf``_penable = ``st``.penable; \
  ``intf``_pwrite = ``st``.pwrite; \
  ``intf``_pwdata = ``st``.pwdata; \
  ``st``.pready = ``intf``_pready; \
  ``intf``_prdata = ``st``.prdata; \
  ``intf``_pclk = ``st``.pclk; \
  ``intf``_presetn = ``st``.presetn; \


`define apb_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_paddr[``N``] = ``st``[``N``].paddr; \
  ``intf``_pselx[``N``] = ``st``[``N``].pselx; \
  ``intf``_penable[``N``] = ``st``[``N``].penable; \
  ``intf``_pwrite[``N``] = ``st``[``N``].pwrite; \
  ``intf``_pwdata[``N``] = ``st``[``N``].pwdata; \
  ``st``[``N``].pready = ``intf``_pready[``N``]; \
  ``intf``_prdata[``N``] = ``st``[``N``].prdata; \
  ``intf``_pclk[``N``] = ``st``[``N``].pclk; \
  ``intf``_presetn[``N``] = ``st``[``N``].presetn; \


`define apb_if_tb_pe_s_assign(intf, st) \
  ``intf``.penable = ``st``.penable; \

`define apb_if_tb_pe_s_wire(intf) \
  logic ``intf``_penable; \

`define apb_if_tb_pe_s_wire_arr(intf, N) \
  logic ``intf``_penable[``N``]; \

`define apb_if_tb_pe_s_port(intf) \
  output logic ``intf``_penable

`define apb_if_tb_pe_s_port_arr(intf, N) \
  output logic ``intf``_penable[``N``]

`define apb_if_tb_pe_s_port2struct_assign(intf, st) \
  ``intf``_penable = ``st``.penable; \


`define apb_if_tb_pe_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_penable[``N``] = ``st``[``N``].penable; \


`define apb_if_tb_r_s_assign(intf, st) \
  ``st``.pready = ``intf``.pready; \
  ``st``.prdata = ``intf``.prdata; \

`define apb_if_tb_r_s_wire(intf) \
  logic ``intf``_pready; \
  logic [64 - 1 : 0] ``intf``_prdata; \

`define apb_if_tb_r_s_wire_arr(intf, N) \
  logic ``intf``_pready[``N``]; \
  logic [64 - 1 : 0] ``intf``_prdata[``N``]; \

`define apb_if_tb_r_s_port(intf) \
  input logic ``intf``_pready, \
  input logic [64 - 1 : 0] ``intf``_prdata

`define apb_if_tb_r_s_port_arr(intf, N) \
  input logic ``intf``_pready[``N``], \
  input logic [64 - 1 : 0] ``intf``_prdata[``N``]

`define apb_if_tb_r_s_port2struct_assign(intf, st) \
  ``st``.pready = ``intf``_pready; \
  ``st``.prdata = ``intf``_prdata; \


`define apb_if_tb_r_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].pready = ``intf``_pready[``N``]; \
  ``st``[``N``].prdata = ``intf``_prdata[``N``]; \


`define apb_if_tb_r_m_assign(intf, st) \
  ``intf``.pready = ``st``.pready; \
  ``intf``.prdata = ``st``.prdata; \

`define apb_if_tb_r_m_wire(intf) \
  logic ``intf``_pready; \
  logic [64 - 1 : 0] ``intf``_prdata; \

`define apb_if_tb_r_m_wire_arr(intf, N) \
  logic ``intf``_pready[``N``]; \
  logic [64 - 1 : 0] ``intf``_prdata[``N``]; \

`define apb_if_tb_r_m_port(intf) \
  output logic ``intf``_pready, \
  output logic [64 - 1 : 0] ``intf``_prdata

`define apb_if_tb_r_m_port_arr(intf, N) \
  output logic ``intf``_pready[``N``], \
  output logic [64 - 1 : 0] ``intf``_prdata[``N``]

`define apb_if_tb_r_m_port2struct_assign(intf, st) \
  ``intf``_pready = ``st``.pready; \
  ``intf``_prdata = ``st``.prdata; \


`define apb_if_tb_r_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_pready[``N``] = ``st``[``N``].pready; \
  ``intf``_prdata[``N``] = ``st``[``N``].prdata; \


interface apb_if (input clk, rstn);
  logic [40 - 1 : 0] paddr;
  logic pselx;
  logic penable;
  logic pwrite;
  logic [64 - 1 : 0] pwdata;
  logic pready;
  logic [64 - 1 : 0] prdata;
  logic [0 - 1 : 0] pslverr;
  `ifndef SYNTHESIS
  logic pselx_d;
  `endif
  `ifndef SYNTHESIS
  logic penable_d;
  `endif
  `ifndef SYNTHESIS
  logic pready_d;
  `endif
  logic pclk;
  logic presetn;
  modport tb_m (
    input  paddr,
    input  pselx,
    input  penable,
    input  pwrite,
    input  pwdata
  );
  modport slave (
    input  paddr,
    input  pselx,
    input  penable,
    input  pwrite,
    input  pwdata,
    output pready,
    input  prdata,
    input  pclk,
    input  presetn
  );
  modport tb_s (
    output paddr,
    output pselx,
    output pwrite,
    output pwdata
  );
  modport master (
    output paddr,
    output pselx,
    output penable,
    output pwrite,
    output pwdata,
    input  pready,
    output prdata,
    output pclk,
    output presetn
  );
  modport tb_pe_s (
    output penable
  );
  modport tb_r_s (
    input  pready,
    input  prdata,
    input  pslverr
  );
  modport tb_r_m (
    output pready,
    output prdata,
    output pslverr
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  paddr;
    input  pselx;
    input  penable;
    input  pwrite;
    input  pwdata;
    input  pready;
    input  prdata;
    input  pslverr;
    input  pselx_d;
    input  penable_d;
    input  pready_d;
    input  pclk;
    input  presetn;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output paddr;
    output pselx;
    output penable;
    output pwrite;
    output pwdata;
    output pready;
    output prdata;
    output pslverr;
    output pclk;
    output presetn;
  endclocking
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    pselx_d <= pselx;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    penable_d <= penable;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    pready_d <= pready;
  `endif
endinterface
`endif
`endif
