
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef MEM_BAR_STATUS_IF__SV
`define MEM_BAR_STATUS_IF__SV
`define mem_bar_status_if_master_assign(intf, st) \
  ``st``.status = ``intf``.status; \

`define mem_bar_status_if_master_wire(intf) \
  mem_barrier_sts_t ``intf``_status; \

`define mem_bar_status_if_master_wire_arr(intf, N) \
  mem_barrier_sts_t ``intf``_status[``N``]; \

`define mem_bar_status_if_master_port(intf) \
  input mem_barrier_sts_t ``intf``_status

`define mem_bar_status_if_master_port_arr(intf, N) \
  input mem_barrier_sts_t ``intf``_status[``N``]

`define mem_bar_status_if_master_port2struct_assign(intf, st) \
  ``st``.status = ``intf``_status; \


`define mem_bar_status_if_master_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].status = ``intf``_status[``N``]; \


`define mem_bar_status_if_slave_assign(intf, st) \
  ``intf``.status = ``st``.status; \

`define mem_bar_status_if_slave_wire(intf) \
  mem_barrier_sts_t ``intf``_status; \

`define mem_bar_status_if_slave_wire_arr(intf, N) \
  mem_barrier_sts_t ``intf``_status[``N``]; \

`define mem_bar_status_if_slave_port(intf) \
  output mem_barrier_sts_t ``intf``_status

`define mem_bar_status_if_slave_port_arr(intf, N) \
  output mem_barrier_sts_t ``intf``_status[``N``]

`define mem_bar_status_if_slave_port2struct_assign(intf, st) \
  ``intf``_status = ``st``.status; \


`define mem_bar_status_if_slave_port2struct_arr_assign(intf, st, N) \
  ``intf``_status[``N``] = ``st``[``N``].status; \


interface mem_bar_status_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  mem_barrier_sts_t status;
  modport master (
    input  status
  );
  modport slave (
    output status
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  status;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output status;
  endclocking
  `endif
endinterface
`endif
`endif
