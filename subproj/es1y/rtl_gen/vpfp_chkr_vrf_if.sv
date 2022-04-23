
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef VPFP_CHKR_VRF_IF__SV
`define VPFP_CHKR_VRF_IF__SV
`define vpfp_chkr_vrf_if_tb_m_assign(intf, st) \

`define vpfp_chkr_vrf_if_tb_m_wire(intf) \

`define vpfp_chkr_vrf_if_tb_m_wire_arr(intf, N) \

`define vpfp_chkr_vrf_if_tb_m_port(intf) \


`define vpfp_chkr_vrf_if_tb_m_port_arr(intf, N) \


`define vpfp_chkr_vrf_if_tb_m_port2struct_assign(intf, st) \


`define vpfp_chkr_vrf_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define vpfp_chkr_vrf_if_tb_s_assign(intf, st) \

`define vpfp_chkr_vrf_if_tb_s_wire(intf) \

`define vpfp_chkr_vrf_if_tb_s_wire_arr(intf, N) \

`define vpfp_chkr_vrf_if_tb_s_port(intf) \


`define vpfp_chkr_vrf_if_tb_s_port_arr(intf, N) \


`define vpfp_chkr_vrf_if_tb_s_port2struct_assign(intf, st) \


`define vpfp_chkr_vrf_if_tb_s_port2struct_arr_assign(intf, st, N) \


interface vpfp_chkr_vrf_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_intf_typedef::*;
  import orv64_typedef_pkg::*;
  import pygmy_typedef::*;
  logic vdst0_wr_vld;
  logic [3 - 1 : 0] vdst0_wr_id;
  logic [32 - 1 : 0] vdst0_wr_dbyte_vld;
  logic [512 - 1 : 0] vdst0_wr_data;
  logic vdst1_wr_vld;
  logic [3 - 1 : 0] vdst1_wr_id;
  logic [32 - 1 : 0] vdst1_wr_dbyte_vld;
  logic [512 - 1 : 0] vdst1_wr_data;
  modport tb_m (
    input  vdst0_wr_vld,
    input  vdst0_wr_id,
    input  vdst0_wr_dbyte_vld,
    input  vdst0_wr_data,
    input  vdst1_wr_vld,
    input  vdst1_wr_id,
    input  vdst1_wr_dbyte_vld,
    input  vdst1_wr_data
  );
  modport tb_s (
    output vdst0_wr_vld,
    output vdst0_wr_id,
    output vdst0_wr_dbyte_vld,
    output vdst0_wr_data,
    output vdst1_wr_vld,
    output vdst1_wr_id,
    output vdst1_wr_dbyte_vld,
    output vdst1_wr_data
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  vdst0_wr_vld;
    input  vdst0_wr_id;
    input  vdst0_wr_dbyte_vld;
    input  vdst0_wr_data;
    input  vdst1_wr_vld;
    input  vdst1_wr_id;
    input  vdst1_wr_dbyte_vld;
    input  vdst1_wr_data;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output vdst0_wr_vld;
    output vdst0_wr_id;
    output vdst0_wr_dbyte_vld;
    output vdst0_wr_data;
    output vdst1_wr_vld;
    output vdst1_wr_id;
    output vdst1_wr_dbyte_vld;
    output vdst1_wr_data;
  endclocking
  `endif
endinterface
`endif
`endif
