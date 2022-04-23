
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef MEM_BAR_CLEAR_BANKS_IF__SV
`define MEM_BAR_CLEAR_BANKS_IF__SV
`define mem_bar_clear_banks_if_slave_assign(intf, st) \
  ``st``.clear = ``intf``.clear; \

`define mem_bar_clear_banks_if_slave_wire(intf) \
  mem_barrier_sts_banks_t ``intf``_clear; \

`define mem_bar_clear_banks_if_slave_wire_arr(intf, N) \
  mem_barrier_sts_banks_t ``intf``_clear[``N``]; \

`define mem_bar_clear_banks_if_slave_port(intf) \
  input mem_barrier_sts_banks_t ``intf``_clear

`define mem_bar_clear_banks_if_slave_port_arr(intf, N) \
  input mem_barrier_sts_banks_t ``intf``_clear[``N``]

`define mem_bar_clear_banks_if_slave_port2struct_assign(intf, st) \
  ``st``.clear = ``intf``_clear; \


`define mem_bar_clear_banks_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].clear = ``intf``_clear[``N``]; \


`define mem_bar_clear_banks_if_master_assign(intf, st) \
  ``intf``.clear = ``st``.clear; \

`define mem_bar_clear_banks_if_master_wire(intf) \
  mem_barrier_sts_banks_t ``intf``_clear; \

`define mem_bar_clear_banks_if_master_wire_arr(intf, N) \
  mem_barrier_sts_banks_t ``intf``_clear[``N``]; \

`define mem_bar_clear_banks_if_master_port(intf) \
  output mem_barrier_sts_banks_t ``intf``_clear

`define mem_bar_clear_banks_if_master_port_arr(intf, N) \
  output mem_barrier_sts_banks_t ``intf``_clear[``N``]

`define mem_bar_clear_banks_if_master_port2struct_assign(intf, st) \
  ``intf``_clear = ``st``.clear; \


`define mem_bar_clear_banks_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_clear[``N``] = ``st``[``N``].clear; \


interface mem_bar_clear_banks_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  mem_barrier_sts_banks_t clear;
  modport slave (
    input  clear
  );
  modport master (
    output clear
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  clear;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output clear;
  endclocking
  `endif
endinterface
`endif
`endif
