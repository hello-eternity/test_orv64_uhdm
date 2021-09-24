
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef DMA_DATA_AVAIL_IF__SV
`define DMA_DATA_AVAIL_IF__SV
`define dma_data_avail_if_tb_m_assign(intf, st) \

`define dma_data_avail_if_tb_m_wire(intf) \

`define dma_data_avail_if_tb_m_wire_arr(intf, N) \

`define dma_data_avail_if_tb_m_port(intf) \


`define dma_data_avail_if_tb_m_port_arr(intf, N) \


`define dma_data_avail_if_tb_m_port2struct_assign(intf, st) \


`define dma_data_avail_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define dma_data_avail_if_tb_s_assign(intf, st) \

`define dma_data_avail_if_tb_s_wire(intf) \

`define dma_data_avail_if_tb_s_wire_arr(intf, N) \

`define dma_data_avail_if_tb_s_port(intf) \


`define dma_data_avail_if_tb_s_port_arr(intf, N) \


`define dma_data_avail_if_tb_s_port2struct_assign(intf, st) \


`define dma_data_avail_if_tb_s_port2struct_arr_assign(intf, st, N) \


interface dma_data_avail_if (input clk, rstn);
  logic data_avail;
  modport tb_m (
    input  data_avail
  );
  modport tb_s (
    output data_avail
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  data_avail;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output data_avail;
  endclocking
  `endif
endinterface
`endif
`endif
