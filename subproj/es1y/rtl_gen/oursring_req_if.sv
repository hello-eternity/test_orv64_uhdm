
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef OURSRING_REQ_IF__SV
`define OURSRING_REQ_IF__SV
`define oursring_req_if_tb_aw_m_assign(intf, st) \
  ``st``.aw.awid = ``intf``.awid; \
  ``st``.aw.awaddr = ``intf``.awaddr; \
  ``st``.awvalid = ``intf``.awvalid; \

`define oursring_req_if_tb_aw_m_wire(intf) \
  oursring_req_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \

`define oursring_req_if_tb_aw_m_wire_arr(intf, N) \
  oursring_req_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \

`define oursring_req_if_tb_aw_m_port(intf) \
  input oursring_req_if_aw_t ``intf``_aw, \
  input logic ``intf``_awvalid

`define oursring_req_if_tb_aw_m_port_arr(intf, N) \
  input oursring_req_if_aw_t ``intf``_aw[``N``], \
  input logic ``intf``_awvalid[``N``]

`define oursring_req_if_tb_aw_m_port2struct_assign(intf, st) \
  ``st``.aw = ``intf``_aw; \
  ``st``.awvalid = ``intf``_awvalid; \


`define oursring_req_if_tb_aw_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].aw = ``intf``_aw[``N``]; \
  ``st``[``N``].awvalid = ``intf``_awvalid[``N``]; \


`define oursring_req_if_slave_assign(intf, st) \
  ``st``.aw.awid = ``intf``.awid; \
  ``st``.aw.awaddr = ``intf``.awaddr; \
  ``st``.awvalid = ``intf``.awvalid; \
  ``intf``.awready = ``st``.awready; \
  ``st``.w.wdata = ``intf``.wdata; \
  ``st``.w.wstrb = ``intf``.wstrb; \
  ``st``.wvalid = ``intf``.wvalid; \
  ``st``.w.wlast = ``intf``.wlast; \
  ``intf``.wready = ``st``.wready; \
  ``st``.ar.arid = ``intf``.arid; \
  ``st``.ar.araddr = ``intf``.araddr; \
  ``st``.arvalid = ``intf``.arvalid; \
  ``intf``.arready = ``st``.arready; \

`define oursring_req_if_slave_wire(intf) \
  oursring_req_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \
  logic ``intf``_awready; \
  logic ``intf``_wvalid; \
  logic ``intf``_wready; \
  logic ``intf``_arvalid; \
  logic ``intf``_arready; \
  oursring_req_if_w_t ``intf``_w; \
  oursring_req_if_ar_t ``intf``_ar; \

`define oursring_req_if_slave_wire_arr(intf, N) \
  oursring_req_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \
  logic ``intf``_awready[``N``]; \
  logic ``intf``_wvalid[``N``]; \
  logic ``intf``_wready[``N``]; \
  logic ``intf``_arvalid[``N``]; \
  logic ``intf``_arready[``N``]; \
  oursring_req_if_w_t ``intf``_w[``N``]; \
  oursring_req_if_ar_t ``intf``_ar[``N``]; \

`define oursring_req_if_slave_port(intf) \
  input oursring_req_if_aw_t ``intf``_aw, \
  input logic ``intf``_awvalid, \
  output logic ``intf``_awready, \
  input logic ``intf``_wvalid, \
  output logic ``intf``_wready, \
  input logic ``intf``_arvalid, \
  output logic ``intf``_arready, \
  input oursring_req_if_w_t ``intf``_w, \
  input oursring_req_if_ar_t ``intf``_ar

`define oursring_req_if_slave_port_arr(intf, N) \
  input oursring_req_if_aw_t ``intf``_aw[``N``], \
  input logic ``intf``_awvalid[``N``], \
  output logic ``intf``_awready[``N``], \
  input logic ``intf``_wvalid[``N``], \
  output logic ``intf``_wready[``N``], \
  input logic ``intf``_arvalid[``N``], \
  output logic ``intf``_arready[``N``], \
  input oursring_req_if_w_t ``intf``_w[``N``], \
  input oursring_req_if_ar_t ``intf``_ar[``N``]

`define oursring_req_if_slave_port2struct_assign(intf, st) \
  ``st``.aw = ``intf``_aw; \
  ``st``.awvalid = ``intf``_awvalid; \
  ``intf``_awready = ``st``.awready; \
  ``st``.wvalid = ``intf``_wvalid; \
  ``intf``_wready = ``st``.wready; \
  ``st``.arvalid = ``intf``_arvalid; \
  ``intf``_arready = ``st``.arready; \
  ``st``.w = ``intf``_w; \
  ``st``.ar = ``intf``_ar; \


`define oursring_req_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].aw = ``intf``_aw[``N``]; \
  ``st``[``N``].awvalid = ``intf``_awvalid[``N``]; \
  ``intf``_awready[``N``] = ``st``[``N``].awready; \
  ``st``[``N``].wvalid = ``intf``_wvalid[``N``]; \
  ``intf``_wready[``N``] = ``st``[``N``].wready; \
  ``st``[``N``].arvalid = ``intf``_arvalid[``N``]; \
  ``intf``_arready[``N``] = ``st``[``N``].arready; \
  ``st``[``N``].w = ``intf``_w[``N``]; \
  ``st``[``N``].ar = ``intf``_ar[``N``]; \


`define oursring_req_if_tb_aw_s_assign(intf, st) \
  ``intf``.awid = ``st``.aw.awid; \
  ``intf``.awaddr = ``st``.aw.awaddr; \
  ``intf``.awvalid = ``st``.awvalid; \

`define oursring_req_if_tb_aw_s_wire(intf) \
  oursring_req_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \

`define oursring_req_if_tb_aw_s_wire_arr(intf, N) \
  oursring_req_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \

`define oursring_req_if_tb_aw_s_port(intf) \
  output oursring_req_if_aw_t ``intf``_aw, \
  output logic ``intf``_awvalid

`define oursring_req_if_tb_aw_s_port_arr(intf, N) \
  output oursring_req_if_aw_t ``intf``_aw[``N``], \
  output logic ``intf``_awvalid[``N``]

`define oursring_req_if_tb_aw_s_port2struct_assign(intf, st) \
  ``intf``_aw = ``st``.aw; \
  ``intf``_awvalid = ``st``.awvalid; \


`define oursring_req_if_tb_aw_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_aw[``N``] = ``st``[``N``].aw; \
  ``intf``_awvalid[``N``] = ``st``[``N``].awvalid; \


`define oursring_req_if_master_assign(intf, st) \
  ``intf``.awid = ``st``.aw.awid; \
  ``intf``.awaddr = ``st``.aw.awaddr; \
  ``intf``.awvalid = ``st``.awvalid; \
  ``st``.awready = ``intf``.awready; \
  ``intf``.wdata = ``st``.w.wdata; \
  ``intf``.wstrb = ``st``.w.wstrb; \
  ``intf``.wvalid = ``st``.wvalid; \
  ``intf``.wlast = ``st``.w.wlast; \
  ``st``.wready = ``intf``.wready; \
  ``intf``.arid = ``st``.ar.arid; \
  ``intf``.araddr = ``st``.ar.araddr; \
  ``intf``.arvalid = ``st``.arvalid; \
  ``st``.arready = ``intf``.arready; \

`define oursring_req_if_master_wire(intf) \
  oursring_req_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \
  logic ``intf``_awready; \
  logic ``intf``_wvalid; \
  logic ``intf``_wready; \
  logic ``intf``_arvalid; \
  logic ``intf``_arready; \
  oursring_req_if_w_t ``intf``_w; \
  oursring_req_if_ar_t ``intf``_ar; \

`define oursring_req_if_master_wire_arr(intf, N) \
  oursring_req_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \
  logic ``intf``_awready[``N``]; \
  logic ``intf``_wvalid[``N``]; \
  logic ``intf``_wready[``N``]; \
  logic ``intf``_arvalid[``N``]; \
  logic ``intf``_arready[``N``]; \
  oursring_req_if_w_t ``intf``_w[``N``]; \
  oursring_req_if_ar_t ``intf``_ar[``N``]; \

`define oursring_req_if_master_port(intf) \
  output oursring_req_if_aw_t ``intf``_aw, \
  output logic ``intf``_awvalid, \
  input logic ``intf``_awready, \
  output logic ``intf``_wvalid, \
  input logic ``intf``_wready, \
  output logic ``intf``_arvalid, \
  input logic ``intf``_arready, \
  output oursring_req_if_w_t ``intf``_w, \
  output oursring_req_if_ar_t ``intf``_ar

`define oursring_req_if_master_port_arr(intf, N) \
  output oursring_req_if_aw_t ``intf``_aw[``N``], \
  output logic ``intf``_awvalid[``N``], \
  input logic ``intf``_awready[``N``], \
  output logic ``intf``_wvalid[``N``], \
  input logic ``intf``_wready[``N``], \
  output logic ``intf``_arvalid[``N``], \
  input logic ``intf``_arready[``N``], \
  output oursring_req_if_w_t ``intf``_w[``N``], \
  output oursring_req_if_ar_t ``intf``_ar[``N``]

`define oursring_req_if_master_port2struct_assign(intf, st) \
  ``intf``_aw = ``st``.aw; \
  ``intf``_awvalid = ``st``.awvalid; \
  ``st``.awready = ``intf``_awready; \
  ``intf``_wvalid = ``st``.wvalid; \
  ``st``.wready = ``intf``_wready; \
  ``intf``_arvalid = ``st``.arvalid; \
  ``st``.arready = ``intf``_arready; \
  ``intf``_w = ``st``.w; \
  ``intf``_ar = ``st``.ar; \


`define oursring_req_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_aw[``N``] = ``st``[``N``].aw; \
  ``intf``_awvalid[``N``] = ``st``[``N``].awvalid; \
  ``st``[``N``].awready = ``intf``_awready[``N``]; \
  ``intf``_wvalid[``N``] = ``st``[``N``].wvalid; \
  ``st``[``N``].wready = ``intf``_wready[``N``]; \
  ``intf``_arvalid[``N``] = ``st``[``N``].arvalid; \
  ``st``[``N``].arready = ``intf``_arready[``N``]; \
  ``intf``_w[``N``] = ``st``[``N``].w; \
  ``intf``_ar[``N``] = ``st``[``N``].ar; \


`define oursring_req_if_tb_aw_rdy_s_assign(intf, st) \
  ``st``.awready = ``intf``.awready; \

`define oursring_req_if_tb_aw_rdy_s_wire(intf) \
  logic ``intf``_awready; \

`define oursring_req_if_tb_aw_rdy_s_wire_arr(intf, N) \
  logic ``intf``_awready[``N``]; \

`define oursring_req_if_tb_aw_rdy_s_port(intf) \
  input logic ``intf``_awready

`define oursring_req_if_tb_aw_rdy_s_port_arr(intf, N) \
  input logic ``intf``_awready[``N``]

`define oursring_req_if_tb_aw_rdy_s_port2struct_assign(intf, st) \
  ``st``.awready = ``intf``_awready; \


`define oursring_req_if_tb_aw_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].awready = ``intf``_awready[``N``]; \


`define oursring_req_if_tb_aw_rdy_m_assign(intf, st) \
  ``intf``.awready = ``st``.awready; \

`define oursring_req_if_tb_aw_rdy_m_wire(intf) \
  logic ``intf``_awready; \

`define oursring_req_if_tb_aw_rdy_m_wire_arr(intf, N) \
  logic ``intf``_awready[``N``]; \

`define oursring_req_if_tb_aw_rdy_m_port(intf) \
  output logic ``intf``_awready

`define oursring_req_if_tb_aw_rdy_m_port_arr(intf, N) \
  output logic ``intf``_awready[``N``]

`define oursring_req_if_tb_aw_rdy_m_port2struct_assign(intf, st) \
  ``intf``_awready = ``st``.awready; \


`define oursring_req_if_tb_aw_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_awready[``N``] = ``st``[``N``].awready; \


`define oursring_req_if_tb_w_m_assign(intf, st) \
  ``st``.w.wdata = ``intf``.wdata; \
  ``st``.w.wstrb = ``intf``.wstrb; \
  ``st``.wvalid = ``intf``.wvalid; \
  ``st``.w.wlast = ``intf``.wlast; \

`define oursring_req_if_tb_w_m_wire(intf) \
  logic ``intf``_wvalid; \
  oursring_req_if_w_t ``intf``_w; \

`define oursring_req_if_tb_w_m_wire_arr(intf, N) \
  logic ``intf``_wvalid[``N``]; \
  oursring_req_if_w_t ``intf``_w[``N``]; \

`define oursring_req_if_tb_w_m_port(intf) \
  input logic ``intf``_wvalid, \
  input oursring_req_if_w_t ``intf``_w

`define oursring_req_if_tb_w_m_port_arr(intf, N) \
  input logic ``intf``_wvalid[``N``], \
  input oursring_req_if_w_t ``intf``_w[``N``]

`define oursring_req_if_tb_w_m_port2struct_assign(intf, st) \
  ``st``.wvalid = ``intf``_wvalid; \
  ``st``.w = ``intf``_w; \


`define oursring_req_if_tb_w_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].wvalid = ``intf``_wvalid[``N``]; \
  ``st``[``N``].w = ``intf``_w[``N``]; \


`define oursring_req_if_tb_w_s_assign(intf, st) \
  ``intf``.wdata = ``st``.w.wdata; \
  ``intf``.wstrb = ``st``.w.wstrb; \
  ``intf``.wvalid = ``st``.wvalid; \
  ``intf``.wlast = ``st``.w.wlast; \

`define oursring_req_if_tb_w_s_wire(intf) \
  logic ``intf``_wvalid; \
  oursring_req_if_w_t ``intf``_w; \

`define oursring_req_if_tb_w_s_wire_arr(intf, N) \
  logic ``intf``_wvalid[``N``]; \
  oursring_req_if_w_t ``intf``_w[``N``]; \

`define oursring_req_if_tb_w_s_port(intf) \
  output logic ``intf``_wvalid, \
  output oursring_req_if_w_t ``intf``_w

`define oursring_req_if_tb_w_s_port_arr(intf, N) \
  output logic ``intf``_wvalid[``N``], \
  output oursring_req_if_w_t ``intf``_w[``N``]

`define oursring_req_if_tb_w_s_port2struct_assign(intf, st) \
  ``intf``_wvalid = ``st``.wvalid; \
  ``intf``_w = ``st``.w; \


`define oursring_req_if_tb_w_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_wvalid[``N``] = ``st``[``N``].wvalid; \
  ``intf``_w[``N``] = ``st``[``N``].w; \


`define oursring_req_if_tb_w_rdy_s_assign(intf, st) \
  ``st``.wready = ``intf``.wready; \

`define oursring_req_if_tb_w_rdy_s_wire(intf) \
  logic ``intf``_wready; \

`define oursring_req_if_tb_w_rdy_s_wire_arr(intf, N) \
  logic ``intf``_wready[``N``]; \

`define oursring_req_if_tb_w_rdy_s_port(intf) \
  input logic ``intf``_wready

`define oursring_req_if_tb_w_rdy_s_port_arr(intf, N) \
  input logic ``intf``_wready[``N``]

`define oursring_req_if_tb_w_rdy_s_port2struct_assign(intf, st) \
  ``st``.wready = ``intf``_wready; \


`define oursring_req_if_tb_w_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].wready = ``intf``_wready[``N``]; \


`define oursring_req_if_tb_w_rdy_m_assign(intf, st) \
  ``intf``.wready = ``st``.wready; \

`define oursring_req_if_tb_w_rdy_m_wire(intf) \
  logic ``intf``_wready; \

`define oursring_req_if_tb_w_rdy_m_wire_arr(intf, N) \
  logic ``intf``_wready[``N``]; \

`define oursring_req_if_tb_w_rdy_m_port(intf) \
  output logic ``intf``_wready

`define oursring_req_if_tb_w_rdy_m_port_arr(intf, N) \
  output logic ``intf``_wready[``N``]

`define oursring_req_if_tb_w_rdy_m_port2struct_assign(intf, st) \
  ``intf``_wready = ``st``.wready; \


`define oursring_req_if_tb_w_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_wready[``N``] = ``st``[``N``].wready; \


`define oursring_req_if_tb_ar_m_assign(intf, st) \
  ``st``.ar.arid = ``intf``.arid; \
  ``st``.ar.araddr = ``intf``.araddr; \
  ``st``.arvalid = ``intf``.arvalid; \

`define oursring_req_if_tb_ar_m_wire(intf) \
  logic ``intf``_arvalid; \
  oursring_req_if_ar_t ``intf``_ar; \

`define oursring_req_if_tb_ar_m_wire_arr(intf, N) \
  logic ``intf``_arvalid[``N``]; \
  oursring_req_if_ar_t ``intf``_ar[``N``]; \

`define oursring_req_if_tb_ar_m_port(intf) \
  input logic ``intf``_arvalid, \
  input oursring_req_if_ar_t ``intf``_ar

`define oursring_req_if_tb_ar_m_port_arr(intf, N) \
  input logic ``intf``_arvalid[``N``], \
  input oursring_req_if_ar_t ``intf``_ar[``N``]

`define oursring_req_if_tb_ar_m_port2struct_assign(intf, st) \
  ``st``.arvalid = ``intf``_arvalid; \
  ``st``.ar = ``intf``_ar; \


`define oursring_req_if_tb_ar_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].arvalid = ``intf``_arvalid[``N``]; \
  ``st``[``N``].ar = ``intf``_ar[``N``]; \


`define oursring_req_if_tb_ar_s_assign(intf, st) \
  ``intf``.arid = ``st``.ar.arid; \
  ``intf``.araddr = ``st``.ar.araddr; \
  ``intf``.arvalid = ``st``.arvalid; \

`define oursring_req_if_tb_ar_s_wire(intf) \
  logic ``intf``_arvalid; \
  oursring_req_if_ar_t ``intf``_ar; \

`define oursring_req_if_tb_ar_s_wire_arr(intf, N) \
  logic ``intf``_arvalid[``N``]; \
  oursring_req_if_ar_t ``intf``_ar[``N``]; \

`define oursring_req_if_tb_ar_s_port(intf) \
  output logic ``intf``_arvalid, \
  output oursring_req_if_ar_t ``intf``_ar

`define oursring_req_if_tb_ar_s_port_arr(intf, N) \
  output logic ``intf``_arvalid[``N``], \
  output oursring_req_if_ar_t ``intf``_ar[``N``]

`define oursring_req_if_tb_ar_s_port2struct_assign(intf, st) \
  ``intf``_arvalid = ``st``.arvalid; \
  ``intf``_ar = ``st``.ar; \


`define oursring_req_if_tb_ar_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_arvalid[``N``] = ``st``[``N``].arvalid; \
  ``intf``_ar[``N``] = ``st``[``N``].ar; \


`define oursring_req_if_tb_ar_rdy_s_assign(intf, st) \
  ``st``.arready = ``intf``.arready; \

`define oursring_req_if_tb_ar_rdy_s_wire(intf) \
  logic ``intf``_arready; \

`define oursring_req_if_tb_ar_rdy_s_wire_arr(intf, N) \
  logic ``intf``_arready[``N``]; \

`define oursring_req_if_tb_ar_rdy_s_port(intf) \
  input logic ``intf``_arready

`define oursring_req_if_tb_ar_rdy_s_port_arr(intf, N) \
  input logic ``intf``_arready[``N``]

`define oursring_req_if_tb_ar_rdy_s_port2struct_assign(intf, st) \
  ``st``.arready = ``intf``_arready; \


`define oursring_req_if_tb_ar_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].arready = ``intf``_arready[``N``]; \


`define oursring_req_if_tb_ar_rdy_m_assign(intf, st) \
  ``intf``.arready = ``st``.arready; \

`define oursring_req_if_tb_ar_rdy_m_wire(intf) \
  logic ``intf``_arready; \

`define oursring_req_if_tb_ar_rdy_m_wire_arr(intf, N) \
  logic ``intf``_arready[``N``]; \

`define oursring_req_if_tb_ar_rdy_m_port(intf) \
  output logic ``intf``_arready

`define oursring_req_if_tb_ar_rdy_m_port_arr(intf, N) \
  output logic ``intf``_arready[``N``]

`define oursring_req_if_tb_ar_rdy_m_port2struct_assign(intf, st) \
  ``intf``_arready = ``st``.arready; \


`define oursring_req_if_tb_ar_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_arready[``N``] = ``st``[``N``].arready; \


interface oursring_req_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  `ifndef SYNTHESIS
  logic awvalid_d;
  `endif
  `ifndef SYNTHESIS
  logic wvalid_d;
  `endif
  `ifndef SYNTHESIS
  logic arvalid_d;
  `endif
  `ifndef SYNTHESIS
  logic awready_d;
  `endif
  `ifndef SYNTHESIS
  logic wready_d;
  `endif
  `ifndef SYNTHESIS
  logic arready_d;
  `endif
  logic awvalid;
  logic awready;
  logic wvalid;
  logic wready;
  logic arvalid;
  logic arready;
  oursring_req_if_aw_t aw;
  oursring_req_if_w_t w;
  oursring_req_if_ar_t ar;
  modport tb_aw_m (
    input  awvalid,
    input  aw
  );
  modport slave (
    input  awvalid,
    output awready,
    input  wvalid,
    output wready,
    input  arvalid,
    output arready,
    input  aw,
    input  w,
    input  ar
  );
  modport tb_aw_s (
    output awvalid,
    output aw
  );
  modport master (
    output awvalid,
    input  awready,
    output wvalid,
    input  wready,
    output arvalid,
    input  arready,
    output aw,
    output w,
    output ar
  );
  modport tb_aw_rdy_s (
    input  awready
  );
  modport tb_aw_rdy_m (
    output awready
  );
  modport tb_w_m (
    input  wvalid,
    input  w
  );
  modport tb_w_s (
    output wvalid,
    output w
  );
  modport tb_w_rdy_s (
    input  wready
  );
  modport tb_w_rdy_m (
    output wready
  );
  modport tb_ar_m (
    input  arvalid,
    input  ar
  );
  modport tb_ar_s (
    output arvalid,
    output ar
  );
  modport tb_ar_rdy_s (
    input  arready
  );
  modport tb_ar_rdy_m (
    output arready
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  awvalid_d;
    input  wvalid_d;
    input  arvalid_d;
    input  awready_d;
    input  wready_d;
    input  arready_d;
    input  awvalid;
    input  awready;
    input  wvalid;
    input  wready;
    input  arvalid;
    input  arready;
    input  aw;
    input  w;
    input  ar;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output awvalid;
    output awready;
    output wvalid;
    output wready;
    output arvalid;
    output arready;
    output aw;
    output w;
    output ar;
  endclocking
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    awvalid_d <= awvalid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    wvalid_d <= wvalid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    arvalid_d <= arvalid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    awready_d <= awready;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    wready_d <= wready;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    arready_d <= arready;
  `endif
endinterface
`endif
`endif
