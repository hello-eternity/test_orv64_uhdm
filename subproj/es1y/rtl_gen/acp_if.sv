
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef ACP_IF__SV
`define ACP_IF__SV
`define acp_if_slave_assign(intf, st) \
  ``st``.start = ``intf``.start; \
  ``st``.addr = ``intf``.addr; \
  ``intf``.done = ``st``.done; \

`define acp_if_slave_wire(intf) \
  logic ``intf``_start; \
  vaddr_t ``intf``_addr; \
  logic ``intf``_done; \

`define acp_if_slave_wire_arr(intf, N) \
  logic ``intf``_start[``N``]; \
  vaddr_t ``intf``_addr[``N``]; \
  logic ``intf``_done[``N``]; \

`define acp_if_slave_port(intf) \
  input logic ``intf``_start, \
  input vaddr_t ``intf``_addr, \
  output logic ``intf``_done

`define acp_if_slave_port_arr(intf, N) \
  input logic ``intf``_start[``N``], \
  input vaddr_t ``intf``_addr[``N``], \
  output logic ``intf``_done[``N``]

`define acp_if_slave_port2struct_assign(intf, st) \
  ``st``.start = ``intf``_start; \
  ``st``.addr = ``intf``_addr; \
  ``intf``_done = ``st``.done; \


`define acp_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].start = ``intf``_start[``N``]; \
  ``st``[``N``].addr = ``intf``_addr[``N``]; \
  ``intf``_done[``N``] = ``st``[``N``].done; \


`define acp_if_master_assign(intf, st) \
  ``intf``.start = ``st``.start; \
  ``intf``.addr = ``st``.addr; \
  ``st``.done = ``intf``.done; \

`define acp_if_master_wire(intf) \
  logic ``intf``_start; \
  vaddr_t ``intf``_addr; \
  logic ``intf``_done; \

`define acp_if_master_wire_arr(intf, N) \
  logic ``intf``_start[``N``]; \
  vaddr_t ``intf``_addr[``N``]; \
  logic ``intf``_done[``N``]; \

`define acp_if_master_port(intf) \
  output logic ``intf``_start, \
  output vaddr_t ``intf``_addr, \
  input logic ``intf``_done

`define acp_if_master_port_arr(intf, N) \
  output logic ``intf``_start[``N``], \
  output vaddr_t ``intf``_addr[``N``], \
  input logic ``intf``_done[``N``]

`define acp_if_master_port2struct_assign(intf, st) \
  ``intf``_start = ``st``.start; \
  ``intf``_addr = ``st``.addr; \
  ``st``.done = ``intf``_done; \


`define acp_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_start[``N``] = ``st``[``N``].start; \
  ``intf``_addr[``N``] = ``st``[``N``].addr; \
  ``st``[``N``].done = ``intf``_done[``N``]; \


interface acp_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  logic start;
  vaddr_t addr;
  logic done;
  modport slave (
    input  start,
    input  addr,
    output done
  );
  modport master (
    output start,
    output addr,
    input  done
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  start;
    input  addr;
    input  done;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output start;
    output addr;
    output done;
  endclocking
  `endif
endinterface
`endif
`endif
