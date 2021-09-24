
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef DMA_INTR_IF__SV
`define DMA_INTR_IF__SV
`define dma_intr_if_imp_assign(intf, st) \

`define dma_intr_if_imp_wire(intf) \

`define dma_intr_if_imp_wire_arr(intf, N) \

`define dma_intr_if_imp_port(intf) \


`define dma_intr_if_imp_port_arr(intf, N) \


`define dma_intr_if_imp_port2struct_assign(intf, st) \


`define dma_intr_if_imp_port2struct_arr_assign(intf, st, N) \


`define dma_intr_if_exp_assign(intf, st) \

`define dma_intr_if_exp_wire(intf) \

`define dma_intr_if_exp_wire_arr(intf, N) \

`define dma_intr_if_exp_port(intf) \


`define dma_intr_if_exp_port_arr(intf, N) \


`define dma_intr_if_exp_port2struct_assign(intf, st) \


`define dma_intr_if_exp_port2struct_arr_assign(intf, st, N) \


interface dma_intr_if (input clk, rstn);
  logic [4 - 1 : 0] intr;
  `ifndef SYNTHESIS
  logic [4 - 1 : 0] intr_d;
  `endif
  modport imp (
    input  intr
  );
  modport exp (
    output intr
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  intr;
    input  intr_d;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output intr;
  endclocking
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    intr_d <= intr;
  `endif
endinterface
`endif
`endif
