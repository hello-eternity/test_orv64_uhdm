
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef VPFP_CHKR_CSR_IF__SV
`define VPFP_CHKR_CSR_IF__SV
`define vpfp_chkr_csr_if_tb_m_assign(intf, st) \

`define vpfp_chkr_csr_if_tb_m_wire(intf) \

`define vpfp_chkr_csr_if_tb_m_wire_arr(intf, N) \

`define vpfp_chkr_csr_if_tb_m_port(intf) \


`define vpfp_chkr_csr_if_tb_m_port_arr(intf, N) \


`define vpfp_chkr_csr_if_tb_m_port2struct_assign(intf, st) \


`define vpfp_chkr_csr_if_tb_m_port2struct_arr_assign(intf, st, N) \


`define vpfp_chkr_csr_if_tb_s_assign(intf, st) \

`define vpfp_chkr_csr_if_tb_s_wire(intf) \

`define vpfp_chkr_csr_if_tb_s_wire_arr(intf, N) \

`define vpfp_chkr_csr_if_tb_s_port(intf) \


`define vpfp_chkr_csr_if_tb_s_port_arr(intf, N) \


`define vpfp_chkr_csr_if_tb_s_port2struct_assign(intf, st) \


`define vpfp_chkr_csr_if_tb_s_port2struct_arr_assign(intf, st, N) \


interface vpfp_chkr_csr_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_intf_typedef::*;
  import orv64_typedef_pkg::*;
  import pygmy_typedef::*;
  orv64_ma2cs_t ma2cs;
  orv64_ma2cs_ctrl_t ma2cs_ctrl;
  modport tb_m (
    input  ma2cs,
    input  ma2cs_ctrl
  );
  modport tb_s (
    output ma2cs,
    output ma2cs_ctrl
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  ma2cs;
    input  ma2cs_ctrl;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output ma2cs;
    output ma2cs_ctrl;
  endclocking
  `endif
endinterface
`endif
`endif
