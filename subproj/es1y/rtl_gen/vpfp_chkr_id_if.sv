
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef VPFP_CHKR_ID_IF__SV
`define VPFP_CHKR_ID_IF__SV
`define vpfp_chkr_id_if_tb_m_assign(intf, st) \

`define vpfp_chkr_id_if_tb_m_wire(intf) \

`define vpfp_chkr_id_if_tb_m_wire_arr(intf, N) \

`define vpfp_chkr_id_if_tb_m_port(intf) \


`define vpfp_chkr_id_if_tb_m_port_arr(intf, N) \


`define vpfp_chkr_id_if_tb_m_port2struct_assign(intf, st) \


`define vpfp_chkr_id_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define vpfp_chkr_id_if_tb_s_assign(intf, st) \

`define vpfp_chkr_id_if_tb_s_wire(intf) \

`define vpfp_chkr_id_if_tb_s_wire_arr(intf, N) \

`define vpfp_chkr_id_if_tb_s_port(intf) \


`define vpfp_chkr_id_if_tb_s_port_arr(intf, N) \


`define vpfp_chkr_id_if_tb_s_port2struct_assign(intf, st) \


`define vpfp_chkr_id_if_tb_s_port2struct_arr_assign(intf, st, N) \


interface vpfp_chkr_id_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_intf_typedef::*;
  import orv64_typedef_pkg::*;
  import pygmy_typedef::*;
  logic id_vld;
  orv64_vaddr_t id_pc;
  orv64_if2id_t if2id;
  modport tb_m (
    input  id_vld,
    input  id_pc,
    input  if2id
  );
  modport tb_s (
    output id_vld,
    output id_pc,
    output if2id
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  id_vld;
    input  id_pc;
    input  if2id;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output id_vld;
    output id_pc;
    output if2id;
  endclocking
  `endif
endinterface
`endif
`endif
