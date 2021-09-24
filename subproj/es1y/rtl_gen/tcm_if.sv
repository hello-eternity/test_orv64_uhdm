
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef TCM_IF__SV
`define TCM_IF__SV
`define tcm_if_slave_assign(intf, st) \
  ``st``.ce = ``intf``.ce; \
  ``st``.we = ``intf``.we; \
  ``st``.wdata = ``intf``.wdata; \
  ``intf``.rdata = ``st``.rdata; \

`define tcm_if_slave_wire(intf) \
  logic ``intf``_ce; \
  logic ``intf``_we; \
  data_t ``intf``_wdata; \
  data_t ``intf``_rdata; \

`define tcm_if_slave_wire_arr(intf, N) \
  logic ``intf``_ce[``N``]; \
  logic ``intf``_we[``N``]; \
  data_t ``intf``_wdata[``N``]; \
  data_t ``intf``_rdata[``N``]; \

`define tcm_if_slave_port(intf) \
  input logic ``intf``_ce, \
  input logic ``intf``_we, \
  input data_t ``intf``_wdata, \
  output data_t ``intf``_rdata

`define tcm_if_slave_port_arr(intf, N) \
  input logic ``intf``_ce[``N``], \
  input logic ``intf``_we[``N``], \
  input data_t ``intf``_wdata[``N``], \
  output data_t ``intf``_rdata[``N``]

`define tcm_if_slave_port2struct_assign(intf, st) \
  ``st``.ce = ``intf``_ce; \
  ``st``.we = ``intf``_we; \
  ``st``.wdata = ``intf``_wdata; \
  ``intf``_rdata = ``st``.rdata; \


`define tcm_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].ce = ``intf``_ce[``N``]; \
  ``st``[``N``].we = ``intf``_we[``N``]; \
  ``st``[``N``].wdata = ``intf``_wdata[``N``]; \
  ``intf``_rdata[``N``] = ``st``[``N``].rdata; \


`define tcm_if_master_assign(intf, st) \
  ``intf``.ce = ``st``.ce; \
  ``intf``.we = ``st``.we; \
  ``intf``.wdata = ``st``.wdata; \
  ``st``.rdata = ``intf``.rdata; \

`define tcm_if_master_wire(intf) \
  logic ``intf``_ce; \
  logic ``intf``_we; \
  data_t ``intf``_wdata; \
  data_t ``intf``_rdata; \

`define tcm_if_master_wire_arr(intf, N) \
  logic ``intf``_ce[``N``]; \
  logic ``intf``_we[``N``]; \
  data_t ``intf``_wdata[``N``]; \
  data_t ``intf``_rdata[``N``]; \

`define tcm_if_master_port(intf) \
  output logic ``intf``_ce, \
  output logic ``intf``_we, \
  output data_t ``intf``_wdata, \
  input data_t ``intf``_rdata

`define tcm_if_master_port_arr(intf, N) \
  output logic ``intf``_ce[``N``], \
  output logic ``intf``_we[``N``], \
  output data_t ``intf``_wdata[``N``], \
  input data_t ``intf``_rdata[``N``]

`define tcm_if_master_port2struct_assign(intf, st) \
  ``intf``_ce = ``st``.ce; \
  ``intf``_we = ``st``.we; \
  ``intf``_wdata = ``st``.wdata; \
  ``st``.rdata = ``intf``_rdata; \


`define tcm_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_ce[``N``] = ``st``[``N``].ce; \
  ``intf``_we[``N``] = ``st``[``N``].we; \
  ``intf``_wdata[``N``] = ``st``[``N``].wdata; \
  ``st``[``N``].rdata = ``intf``_rdata[``N``]; \


interface tcm_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv_cfg::*;
  import orv_typedef::*;
  logic ce;
  logic we;
  data_t wdata;
  data_t rdata;
  modport slave (
    input  ce,
    input  we,
    input  wdata,
    output rdata
  );
  modport master (
    output ce,
    output we,
    output wdata,
    input  rdata
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  ce;
    input  we;
    input  wdata;
    input  rdata;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output ce;
    output we;
    output wdata;
    output rdata;
  endclocking
  `endif
endinterface
`endif
`endif
