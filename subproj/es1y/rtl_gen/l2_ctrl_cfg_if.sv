
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef L2_CTRL_CFG_IF__SV
`define L2_CTRL_CFG_IF__SV
`define l2_ctrl_cfg_if_tb_m_assign(intf, st) \

`define l2_ctrl_cfg_if_tb_m_wire(intf) \

`define l2_ctrl_cfg_if_tb_m_wire_arr(intf, N) \

`define l2_ctrl_cfg_if_tb_m_port(intf) \


`define l2_ctrl_cfg_if_tb_m_port_arr(intf, N) \


`define l2_ctrl_cfg_if_tb_m_port2struct_assign(intf, st) \


`define l2_ctrl_cfg_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define l2_ctrl_cfg_if_tb_s_assign(intf, st) \

`define l2_ctrl_cfg_if_tb_s_wire(intf) \

`define l2_ctrl_cfg_if_tb_s_wire_arr(intf, N) \

`define l2_ctrl_cfg_if_tb_s_port(intf) \


`define l2_ctrl_cfg_if_tb_s_port_arr(intf, N) \


`define l2_ctrl_cfg_if_tb_s_port2struct_assign(intf, st) \


`define l2_ctrl_cfg_if_tb_s_port2struct_arr_assign(intf, st, N) \


interface l2_ctrl_cfg_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_typedef::*;
  ctrl_reg_t ctrl_reg;
  modport tb_m (
    input  ctrl_reg
  );
  modport tb_s (
    output ctrl_reg
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  ctrl_reg;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output ctrl_reg;
  endclocking
  `endif
endinterface
`endif
`endif
