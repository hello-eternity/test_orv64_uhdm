
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef PCIE_REQ_IF__SV
`define PCIE_REQ_IF__SV
`define pcie_req_if_tb_aw_m_assign(intf, st) \
  ``st``.awid = ``intf``.awid; \
  ``st``.awaddr = ``intf``.awaddr; \
  ``st``.awvalid = ``intf``.awvalid; \

`define pcie_req_if_tb_aw_m_wire(intf) \
  logic [8 - 1 : 0] ``intf``_awid; \
  logic [64 - 1 : 0] ``intf``_awaddr; \
  logic ``intf``_awvalid; \

`define pcie_req_if_tb_aw_m_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_awid[``N``]; \
  logic [64 - 1 : 0] ``intf``_awaddr[``N``]; \
  logic ``intf``_awvalid[``N``]; \

`define pcie_req_if_tb_aw_m_port(intf) \
  input logic [8 - 1 : 0] ``intf``_awid, \
  input logic [64 - 1 : 0] ``intf``_awaddr, \
  input logic ``intf``_awvalid

`define pcie_req_if_tb_aw_m_port_arr(intf, N) \
  input logic [8 - 1 : 0] ``intf``_awid[``N``], \
  input logic [64 - 1 : 0] ``intf``_awaddr[``N``], \
  input logic ``intf``_awvalid[``N``]

`define pcie_req_if_tb_aw_m_port2struct_assign(intf, st) \
  ``st``.awid = ``intf``_awid; \
  ``st``.awaddr = ``intf``_awaddr; \
  ``st``.awvalid = ``intf``_awvalid; \


`define pcie_req_if_tb_aw_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].awid = ``intf``_awid[``N``]; \
  ``st``[``N``].awaddr = ``intf``_awaddr[``N``]; \
  ``st``[``N``].awvalid = ``intf``_awvalid[``N``]; \


`define pcie_req_if_slave_assign(intf, st) \
  ``st``.awid = ``intf``.awid; \
  ``st``.awaddr = ``intf``.awaddr; \
  ``st``.awvalid = ``intf``.awvalid; \
  ``intf``.awready = ``st``.awready; \
  ``st``.wdata = ``intf``.wdata; \
  ``st``.wvalid = ``intf``.wvalid; \
  ``intf``.wready = ``st``.wready; \
  ``st``.arid = ``intf``.arid; \
  ``st``.araddr = ``intf``.araddr; \
  ``st``.arvalid = ``intf``.arvalid; \
  ``intf``.arready = ``st``.arready; \

`define pcie_req_if_slave_wire(intf) \
  logic [8 - 1 : 0] ``intf``_awid; \
  logic [64 - 1 : 0] ``intf``_awaddr; \
  logic ``intf``_awvalid; \
  logic ``intf``_awready; \
  logic [512 - 1 : 0] ``intf``_wdata; \
  logic ``intf``_wvalid; \
  logic ``intf``_wready; \
  logic [8 - 1 : 0] ``intf``_arid; \
  logic [64 - 1 : 0] ``intf``_araddr; \
  logic ``intf``_arvalid; \
  logic ``intf``_arready; \

`define pcie_req_if_slave_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_awid[``N``]; \
  logic [64 - 1 : 0] ``intf``_awaddr[``N``]; \
  logic ``intf``_awvalid[``N``]; \
  logic ``intf``_awready[``N``]; \
  logic [512 - 1 : 0] ``intf``_wdata[``N``]; \
  logic ``intf``_wvalid[``N``]; \
  logic ``intf``_wready[``N``]; \
  logic [8 - 1 : 0] ``intf``_arid[``N``]; \
  logic [64 - 1 : 0] ``intf``_araddr[``N``]; \
  logic ``intf``_arvalid[``N``]; \
  logic ``intf``_arready[``N``]; \

`define pcie_req_if_slave_port(intf) \
  input logic [8 - 1 : 0] ``intf``_awid, \
  input logic [64 - 1 : 0] ``intf``_awaddr, \
  input logic ``intf``_awvalid, \
  output logic ``intf``_awready, \
  input logic [512 - 1 : 0] ``intf``_wdata, \
  input logic ``intf``_wvalid, \
  output logic ``intf``_wready, \
  input logic [8 - 1 : 0] ``intf``_arid, \
  input logic [64 - 1 : 0] ``intf``_araddr, \
  input logic ``intf``_arvalid, \
  output logic ``intf``_arready

`define pcie_req_if_slave_port_arr(intf, N) \
  input logic [8 - 1 : 0] ``intf``_awid[``N``], \
  input logic [64 - 1 : 0] ``intf``_awaddr[``N``], \
  input logic ``intf``_awvalid[``N``], \
  output logic ``intf``_awready[``N``], \
  input logic [512 - 1 : 0] ``intf``_wdata[``N``], \
  input logic ``intf``_wvalid[``N``], \
  output logic ``intf``_wready[``N``], \
  input logic [8 - 1 : 0] ``intf``_arid[``N``], \
  input logic [64 - 1 : 0] ``intf``_araddr[``N``], \
  input logic ``intf``_arvalid[``N``], \
  output logic ``intf``_arready[``N``]

`define pcie_req_if_slave_port2struct_assign(intf, st) \
  ``st``.awid = ``intf``_awid; \
  ``st``.awaddr = ``intf``_awaddr; \
  ``st``.awvalid = ``intf``_awvalid; \
  ``intf``_awready = ``st``.awready; \
  ``st``.wdata = ``intf``_wdata; \
  ``st``.wvalid = ``intf``_wvalid; \
  ``intf``_wready = ``st``.wready; \
  ``st``.arid = ``intf``_arid; \
  ``st``.araddr = ``intf``_araddr; \
  ``st``.arvalid = ``intf``_arvalid; \
  ``intf``_arready = ``st``.arready; \


`define pcie_req_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].awid = ``intf``_awid[``N``]; \
  ``st``[``N``].awaddr = ``intf``_awaddr[``N``]; \
  ``st``[``N``].awvalid = ``intf``_awvalid[``N``]; \
  ``intf``_awready[``N``] = ``st``[``N``].awready; \
  ``st``[``N``].wdata = ``intf``_wdata[``N``]; \
  ``st``[``N``].wvalid = ``intf``_wvalid[``N``]; \
  ``intf``_wready[``N``] = ``st``[``N``].wready; \
  ``st``[``N``].arid = ``intf``_arid[``N``]; \
  ``st``[``N``].araddr = ``intf``_araddr[``N``]; \
  ``st``[``N``].arvalid = ``intf``_arvalid[``N``]; \
  ``intf``_arready[``N``] = ``st``[``N``].arready; \


`define pcie_req_if_tb_aw_s_assign(intf, st) \
  ``intf``.awid = ``st``.awid; \
  ``intf``.awaddr = ``st``.awaddr; \
  ``intf``.awvalid = ``st``.awvalid; \

`define pcie_req_if_tb_aw_s_wire(intf) \
  logic [8 - 1 : 0] ``intf``_awid; \
  logic [64 - 1 : 0] ``intf``_awaddr; \
  logic ``intf``_awvalid; \

`define pcie_req_if_tb_aw_s_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_awid[``N``]; \
  logic [64 - 1 : 0] ``intf``_awaddr[``N``]; \
  logic ``intf``_awvalid[``N``]; \

`define pcie_req_if_tb_aw_s_port(intf) \
  output logic [8 - 1 : 0] ``intf``_awid, \
  output logic [64 - 1 : 0] ``intf``_awaddr, \
  output logic ``intf``_awvalid

`define pcie_req_if_tb_aw_s_port_arr(intf, N) \
  output logic [8 - 1 : 0] ``intf``_awid[``N``], \
  output logic [64 - 1 : 0] ``intf``_awaddr[``N``], \
  output logic ``intf``_awvalid[``N``]

`define pcie_req_if_tb_aw_s_port2struct_assign(intf, st) \
  ``intf``_awid = ``st``.awid; \
  ``intf``_awaddr = ``st``.awaddr; \
  ``intf``_awvalid = ``st``.awvalid; \


`define pcie_req_if_tb_aw_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_awid[``N``] = ``st``[``N``].awid; \
  ``intf``_awaddr[``N``] = ``st``[``N``].awaddr; \
  ``intf``_awvalid[``N``] = ``st``[``N``].awvalid; \


`define pcie_req_if_master_assign(intf, st) \
  ``intf``.awid = ``st``.awid; \
  ``intf``.awaddr = ``st``.awaddr; \
  ``intf``.awvalid = ``st``.awvalid; \
  ``st``.awready = ``intf``.awready; \
  ``intf``.wdata = ``st``.wdata; \
  ``intf``.wvalid = ``st``.wvalid; \
  ``st``.wready = ``intf``.wready; \
  ``intf``.arid = ``st``.arid; \
  ``intf``.araddr = ``st``.araddr; \
  ``intf``.arvalid = ``st``.arvalid; \
  ``st``.arready = ``intf``.arready; \

`define pcie_req_if_master_wire(intf) \
  logic [8 - 1 : 0] ``intf``_awid; \
  logic [64 - 1 : 0] ``intf``_awaddr; \
  logic ``intf``_awvalid; \
  logic ``intf``_awready; \
  logic [512 - 1 : 0] ``intf``_wdata; \
  logic ``intf``_wvalid; \
  logic ``intf``_wready; \
  logic [8 - 1 : 0] ``intf``_arid; \
  logic [64 - 1 : 0] ``intf``_araddr; \
  logic ``intf``_arvalid; \
  logic ``intf``_arready; \

`define pcie_req_if_master_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_awid[``N``]; \
  logic [64 - 1 : 0] ``intf``_awaddr[``N``]; \
  logic ``intf``_awvalid[``N``]; \
  logic ``intf``_awready[``N``]; \
  logic [512 - 1 : 0] ``intf``_wdata[``N``]; \
  logic ``intf``_wvalid[``N``]; \
  logic ``intf``_wready[``N``]; \
  logic [8 - 1 : 0] ``intf``_arid[``N``]; \
  logic [64 - 1 : 0] ``intf``_araddr[``N``]; \
  logic ``intf``_arvalid[``N``]; \
  logic ``intf``_arready[``N``]; \

`define pcie_req_if_master_port(intf) \
  output logic [8 - 1 : 0] ``intf``_awid, \
  output logic [64 - 1 : 0] ``intf``_awaddr, \
  output logic ``intf``_awvalid, \
  input logic ``intf``_awready, \
  output logic [512 - 1 : 0] ``intf``_wdata, \
  output logic ``intf``_wvalid, \
  input logic ``intf``_wready, \
  output logic [8 - 1 : 0] ``intf``_arid, \
  output logic [64 - 1 : 0] ``intf``_araddr, \
  output logic ``intf``_arvalid, \
  input logic ``intf``_arready

`define pcie_req_if_master_port_arr(intf, N) \
  output logic [8 - 1 : 0] ``intf``_awid[``N``], \
  output logic [64 - 1 : 0] ``intf``_awaddr[``N``], \
  output logic ``intf``_awvalid[``N``], \
  input logic ``intf``_awready[``N``], \
  output logic [512 - 1 : 0] ``intf``_wdata[``N``], \
  output logic ``intf``_wvalid[``N``], \
  input logic ``intf``_wready[``N``], \
  output logic [8 - 1 : 0] ``intf``_arid[``N``], \
  output logic [64 - 1 : 0] ``intf``_araddr[``N``], \
  output logic ``intf``_arvalid[``N``], \
  input logic ``intf``_arready[``N``]

`define pcie_req_if_master_port2struct_assign(intf, st) \
  ``intf``_awid = ``st``.awid; \
  ``intf``_awaddr = ``st``.awaddr; \
  ``intf``_awvalid = ``st``.awvalid; \
  ``st``.awready = ``intf``_awready; \
  ``intf``_wdata = ``st``.wdata; \
  ``intf``_wvalid = ``st``.wvalid; \
  ``st``.wready = ``intf``_wready; \
  ``intf``_arid = ``st``.arid; \
  ``intf``_araddr = ``st``.araddr; \
  ``intf``_arvalid = ``st``.arvalid; \
  ``st``.arready = ``intf``_arready; \


`define pcie_req_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_awid[``N``] = ``st``[``N``].awid; \
  ``intf``_awaddr[``N``] = ``st``[``N``].awaddr; \
  ``intf``_awvalid[``N``] = ``st``[``N``].awvalid; \
  ``st``[``N``].awready = ``intf``_awready[``N``]; \
  ``intf``_wdata[``N``] = ``st``[``N``].wdata; \
  ``intf``_wvalid[``N``] = ``st``[``N``].wvalid; \
  ``st``[``N``].wready = ``intf``_wready[``N``]; \
  ``intf``_arid[``N``] = ``st``[``N``].arid; \
  ``intf``_araddr[``N``] = ``st``[``N``].araddr; \
  ``intf``_arvalid[``N``] = ``st``[``N``].arvalid; \
  ``st``[``N``].arready = ``intf``_arready[``N``]; \


`define pcie_req_if_tb_aw_rdy_s_assign(intf, st) \
  ``st``.awready = ``intf``.awready; \

`define pcie_req_if_tb_aw_rdy_s_wire(intf) \
  logic ``intf``_awready; \

`define pcie_req_if_tb_aw_rdy_s_wire_arr(intf, N) \
  logic ``intf``_awready[``N``]; \

`define pcie_req_if_tb_aw_rdy_s_port(intf) \
  input logic ``intf``_awready

`define pcie_req_if_tb_aw_rdy_s_port_arr(intf, N) \
  input logic ``intf``_awready[``N``]

`define pcie_req_if_tb_aw_rdy_s_port2struct_assign(intf, st) \
  ``st``.awready = ``intf``_awready; \


`define pcie_req_if_tb_aw_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].awready = ``intf``_awready[``N``]; \


`define pcie_req_if_tb_aw_rdy_m_assign(intf, st) \
  ``intf``.awready = ``st``.awready; \

`define pcie_req_if_tb_aw_rdy_m_wire(intf) \
  logic ``intf``_awready; \

`define pcie_req_if_tb_aw_rdy_m_wire_arr(intf, N) \
  logic ``intf``_awready[``N``]; \

`define pcie_req_if_tb_aw_rdy_m_port(intf) \
  output logic ``intf``_awready

`define pcie_req_if_tb_aw_rdy_m_port_arr(intf, N) \
  output logic ``intf``_awready[``N``]

`define pcie_req_if_tb_aw_rdy_m_port2struct_assign(intf, st) \
  ``intf``_awready = ``st``.awready; \


`define pcie_req_if_tb_aw_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_awready[``N``] = ``st``[``N``].awready; \


`define pcie_req_if_tb_w_m_assign(intf, st) \
  ``st``.wdata = ``intf``.wdata; \
  ``st``.wvalid = ``intf``.wvalid; \

`define pcie_req_if_tb_w_m_wire(intf) \
  logic [512 - 1 : 0] ``intf``_wdata; \
  logic ``intf``_wvalid; \

`define pcie_req_if_tb_w_m_wire_arr(intf, N) \
  logic [512 - 1 : 0] ``intf``_wdata[``N``]; \
  logic ``intf``_wvalid[``N``]; \

`define pcie_req_if_tb_w_m_port(intf) \
  input logic [512 - 1 : 0] ``intf``_wdata, \
  input logic ``intf``_wvalid

`define pcie_req_if_tb_w_m_port_arr(intf, N) \
  input logic [512 - 1 : 0] ``intf``_wdata[``N``], \
  input logic ``intf``_wvalid[``N``]

`define pcie_req_if_tb_w_m_port2struct_assign(intf, st) \
  ``st``.wdata = ``intf``_wdata; \
  ``st``.wvalid = ``intf``_wvalid; \


`define pcie_req_if_tb_w_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].wdata = ``intf``_wdata[``N``]; \
  ``st``[``N``].wvalid = ``intf``_wvalid[``N``]; \


`define pcie_req_if_tb_w_s_assign(intf, st) \
  ``intf``.wdata = ``st``.wdata; \
  ``intf``.wvalid = ``st``.wvalid; \

`define pcie_req_if_tb_w_s_wire(intf) \
  logic [512 - 1 : 0] ``intf``_wdata; \
  logic ``intf``_wvalid; \

`define pcie_req_if_tb_w_s_wire_arr(intf, N) \
  logic [512 - 1 : 0] ``intf``_wdata[``N``]; \
  logic ``intf``_wvalid[``N``]; \

`define pcie_req_if_tb_w_s_port(intf) \
  output logic [512 - 1 : 0] ``intf``_wdata, \
  output logic ``intf``_wvalid

`define pcie_req_if_tb_w_s_port_arr(intf, N) \
  output logic [512 - 1 : 0] ``intf``_wdata[``N``], \
  output logic ``intf``_wvalid[``N``]

`define pcie_req_if_tb_w_s_port2struct_assign(intf, st) \
  ``intf``_wdata = ``st``.wdata; \
  ``intf``_wvalid = ``st``.wvalid; \


`define pcie_req_if_tb_w_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_wdata[``N``] = ``st``[``N``].wdata; \
  ``intf``_wvalid[``N``] = ``st``[``N``].wvalid; \


`define pcie_req_if_tb_w_rdy_s_assign(intf, st) \
  ``st``.wready = ``intf``.wready; \

`define pcie_req_if_tb_w_rdy_s_wire(intf) \
  logic ``intf``_wready; \

`define pcie_req_if_tb_w_rdy_s_wire_arr(intf, N) \
  logic ``intf``_wready[``N``]; \

`define pcie_req_if_tb_w_rdy_s_port(intf) \
  input logic ``intf``_wready

`define pcie_req_if_tb_w_rdy_s_port_arr(intf, N) \
  input logic ``intf``_wready[``N``]

`define pcie_req_if_tb_w_rdy_s_port2struct_assign(intf, st) \
  ``st``.wready = ``intf``_wready; \


`define pcie_req_if_tb_w_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].wready = ``intf``_wready[``N``]; \


`define pcie_req_if_tb_w_rdy_m_assign(intf, st) \
  ``intf``.wready = ``st``.wready; \

`define pcie_req_if_tb_w_rdy_m_wire(intf) \
  logic ``intf``_wready; \

`define pcie_req_if_tb_w_rdy_m_wire_arr(intf, N) \
  logic ``intf``_wready[``N``]; \

`define pcie_req_if_tb_w_rdy_m_port(intf) \
  output logic ``intf``_wready

`define pcie_req_if_tb_w_rdy_m_port_arr(intf, N) \
  output logic ``intf``_wready[``N``]

`define pcie_req_if_tb_w_rdy_m_port2struct_assign(intf, st) \
  ``intf``_wready = ``st``.wready; \


`define pcie_req_if_tb_w_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_wready[``N``] = ``st``[``N``].wready; \


`define pcie_req_if_tb_ar_m_assign(intf, st) \
  ``st``.arid = ``intf``.arid; \
  ``st``.araddr = ``intf``.araddr; \
  ``st``.arvalid = ``intf``.arvalid; \

`define pcie_req_if_tb_ar_m_wire(intf) \
  logic [8 - 1 : 0] ``intf``_arid; \
  logic [64 - 1 : 0] ``intf``_araddr; \
  logic ``intf``_arvalid; \

`define pcie_req_if_tb_ar_m_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_arid[``N``]; \
  logic [64 - 1 : 0] ``intf``_araddr[``N``]; \
  logic ``intf``_arvalid[``N``]; \

`define pcie_req_if_tb_ar_m_port(intf) \
  input logic [8 - 1 : 0] ``intf``_arid, \
  input logic [64 - 1 : 0] ``intf``_araddr, \
  input logic ``intf``_arvalid

`define pcie_req_if_tb_ar_m_port_arr(intf, N) \
  input logic [8 - 1 : 0] ``intf``_arid[``N``], \
  input logic [64 - 1 : 0] ``intf``_araddr[``N``], \
  input logic ``intf``_arvalid[``N``]

`define pcie_req_if_tb_ar_m_port2struct_assign(intf, st) \
  ``st``.arid = ``intf``_arid; \
  ``st``.araddr = ``intf``_araddr; \
  ``st``.arvalid = ``intf``_arvalid; \


`define pcie_req_if_tb_ar_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].arid = ``intf``_arid[``N``]; \
  ``st``[``N``].araddr = ``intf``_araddr[``N``]; \
  ``st``[``N``].arvalid = ``intf``_arvalid[``N``]; \


`define pcie_req_if_tb_ar_s_assign(intf, st) \
  ``intf``.arid = ``st``.arid; \
  ``intf``.araddr = ``st``.araddr; \
  ``intf``.arvalid = ``st``.arvalid; \

`define pcie_req_if_tb_ar_s_wire(intf) \
  logic [8 - 1 : 0] ``intf``_arid; \
  logic [64 - 1 : 0] ``intf``_araddr; \
  logic ``intf``_arvalid; \

`define pcie_req_if_tb_ar_s_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_arid[``N``]; \
  logic [64 - 1 : 0] ``intf``_araddr[``N``]; \
  logic ``intf``_arvalid[``N``]; \

`define pcie_req_if_tb_ar_s_port(intf) \
  output logic [8 - 1 : 0] ``intf``_arid, \
  output logic [64 - 1 : 0] ``intf``_araddr, \
  output logic ``intf``_arvalid

`define pcie_req_if_tb_ar_s_port_arr(intf, N) \
  output logic [8 - 1 : 0] ``intf``_arid[``N``], \
  output logic [64 - 1 : 0] ``intf``_araddr[``N``], \
  output logic ``intf``_arvalid[``N``]

`define pcie_req_if_tb_ar_s_port2struct_assign(intf, st) \
  ``intf``_arid = ``st``.arid; \
  ``intf``_araddr = ``st``.araddr; \
  ``intf``_arvalid = ``st``.arvalid; \


`define pcie_req_if_tb_ar_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_arid[``N``] = ``st``[``N``].arid; \
  ``intf``_araddr[``N``] = ``st``[``N``].araddr; \
  ``intf``_arvalid[``N``] = ``st``[``N``].arvalid; \


`define pcie_req_if_tb_ar_rdy_s_assign(intf, st) \
  ``st``.arready = ``intf``.arready; \

`define pcie_req_if_tb_ar_rdy_s_wire(intf) \
  logic ``intf``_arready; \

`define pcie_req_if_tb_ar_rdy_s_wire_arr(intf, N) \
  logic ``intf``_arready[``N``]; \

`define pcie_req_if_tb_ar_rdy_s_port(intf) \
  input logic ``intf``_arready

`define pcie_req_if_tb_ar_rdy_s_port_arr(intf, N) \
  input logic ``intf``_arready[``N``]

`define pcie_req_if_tb_ar_rdy_s_port2struct_assign(intf, st) \
  ``st``.arready = ``intf``_arready; \


`define pcie_req_if_tb_ar_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].arready = ``intf``_arready[``N``]; \


`define pcie_req_if_tb_ar_rdy_m_assign(intf, st) \
  ``intf``.arready = ``st``.arready; \

`define pcie_req_if_tb_ar_rdy_m_wire(intf) \
  logic ``intf``_arready; \

`define pcie_req_if_tb_ar_rdy_m_wire_arr(intf, N) \
  logic ``intf``_arready[``N``]; \

`define pcie_req_if_tb_ar_rdy_m_port(intf) \
  output logic ``intf``_arready

`define pcie_req_if_tb_ar_rdy_m_port_arr(intf, N) \
  output logic ``intf``_arready[``N``]

`define pcie_req_if_tb_ar_rdy_m_port2struct_assign(intf, st) \
  ``intf``_arready = ``st``.arready; \


`define pcie_req_if_tb_ar_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_arready[``N``] = ``st``[``N``].arready; \


interface pcie_req_if (input clk, rstn);
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
  logic [8 - 1 : 0] awid;
  logic [64 - 1 : 0] awaddr;
  logic awvalid;
  logic awready;
  logic [512 - 1 : 0] wdata;
  logic wvalid;
  logic wready;
  logic [8 - 1 : 0] arid;
  logic [64 - 1 : 0] araddr;
  logic arvalid;
  logic arready;
  modport tb_aw_m (
    input  awid,
    input  awaddr,
    input  awvalid
  );
  modport slave (
    input  awid,
    input  awaddr,
    input  awvalid,
    output awready,
    input  wdata,
    input  wvalid,
    output wready,
    input  arid,
    input  araddr,
    input  arvalid,
    output arready
  );
  modport tb_aw_s (
    output awid,
    output awaddr,
    output awvalid
  );
  modport master (
    output awid,
    output awaddr,
    output awvalid,
    input  awready,
    output wdata,
    output wvalid,
    input  wready,
    output arid,
    output araddr,
    output arvalid,
    input  arready
  );
  modport tb_aw_rdy_s (
    input  awready
  );
  modport tb_aw_rdy_m (
    output awready
  );
  modport tb_w_m (
    input  wdata,
    input  wvalid
  );
  modport tb_w_s (
    output wdata,
    output wvalid
  );
  modport tb_w_rdy_s (
    input  wready
  );
  modport tb_w_rdy_m (
    output wready
  );
  modport tb_ar_m (
    input  arid,
    input  araddr,
    input  arvalid
  );
  modport tb_ar_s (
    output arid,
    output araddr,
    output arvalid
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
    input  awid;
    input  awaddr;
    input  awvalid;
    input  awready;
    input  wdata;
    input  wvalid;
    input  wready;
    input  arid;
    input  araddr;
    input  arvalid;
    input  arready;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output awid;
    output awaddr;
    output awvalid;
    output awready;
    output wdata;
    output wvalid;
    output wready;
    output arid;
    output araddr;
    output arvalid;
    output arready;
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
