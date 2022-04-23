
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef PCIE_RESP_IF__SV
`define PCIE_RESP_IF__SV
`define pcie_resp_if_tb_r_m_assign(intf, st) \
  ``st``.rid = ``intf``.rid; \
  ``st``.rdata = ``intf``.rdata; \
  ``st``.rvalid = ``intf``.rvalid; \
  ``st``.rresp = ``intf``.rresp; \

`define pcie_resp_if_tb_r_m_wire(intf) \
  logic [8 - 1 : 0] ``intf``_rid; \
  logic [512 - 1 : 0] ``intf``_rdata; \
  logic ``intf``_rvalid; \
  logic [2 - 1 : 0] ``intf``_rresp; \

`define pcie_resp_if_tb_r_m_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_rid[``N``]; \
  logic [512 - 1 : 0] ``intf``_rdata[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic [2 - 1 : 0] ``intf``_rresp[``N``]; \

`define pcie_resp_if_tb_r_m_port(intf) \
  input logic [8 - 1 : 0] ``intf``_rid, \
  input logic [512 - 1 : 0] ``intf``_rdata, \
  input logic ``intf``_rvalid, \
  input logic [2 - 1 : 0] ``intf``_rresp

`define pcie_resp_if_tb_r_m_port_arr(intf, N) \
  input logic [8 - 1 : 0] ``intf``_rid[``N``], \
  input logic [512 - 1 : 0] ``intf``_rdata[``N``], \
  input logic ``intf``_rvalid[``N``], \
  input logic [2 - 1 : 0] ``intf``_rresp[``N``]

`define pcie_resp_if_tb_r_m_port2struct_assign(intf, st) \
  ``st``.rid = ``intf``_rid; \
  ``st``.rdata = ``intf``_rdata; \
  ``st``.rvalid = ``intf``_rvalid; \
  ``st``.rresp = ``intf``_rresp; \


`define pcie_resp_if_tb_r_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].rid = ``intf``_rid[``N``]; \
  ``st``[``N``].rdata = ``intf``_rdata[``N``]; \
  ``st``[``N``].rvalid = ``intf``_rvalid[``N``]; \
  ``st``[``N``].rresp = ``intf``_rresp[``N``]; \


`define pcie_resp_if_slave_assign(intf, st) \
  ``st``.rid = ``intf``.rid; \
  ``st``.rdata = ``intf``.rdata; \
  ``st``.rvalid = ``intf``.rvalid; \
  ``st``.rresp = ``intf``.rresp; \
  ``intf``.rready = ``st``.rready; \
  ``st``.bid = ``intf``.bid; \
  ``st``.bresp = ``intf``.bresp; \
  ``st``.bvalid = ``intf``.bvalid; \
  ``intf``.bready = ``st``.bready; \

`define pcie_resp_if_slave_wire(intf) \
  logic [8 - 1 : 0] ``intf``_rid; \
  logic [512 - 1 : 0] ``intf``_rdata; \
  logic ``intf``_rvalid; \
  logic [2 - 1 : 0] ``intf``_rresp; \
  logic ``intf``_rready; \
  logic [8 - 1 : 0] ``intf``_bid; \
  logic [2 - 1 : 0] ``intf``_bresp; \
  logic ``intf``_bvalid; \
  logic ``intf``_bready; \

`define pcie_resp_if_slave_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_rid[``N``]; \
  logic [512 - 1 : 0] ``intf``_rdata[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic [2 - 1 : 0] ``intf``_rresp[``N``]; \
  logic ``intf``_rready[``N``]; \
  logic [8 - 1 : 0] ``intf``_bid[``N``]; \
  logic [2 - 1 : 0] ``intf``_bresp[``N``]; \
  logic ``intf``_bvalid[``N``]; \
  logic ``intf``_bready[``N``]; \

`define pcie_resp_if_slave_port(intf) \
  input logic [8 - 1 : 0] ``intf``_rid, \
  input logic [512 - 1 : 0] ``intf``_rdata, \
  input logic ``intf``_rvalid, \
  input logic [2 - 1 : 0] ``intf``_rresp, \
  output logic ``intf``_rready, \
  input logic [8 - 1 : 0] ``intf``_bid, \
  input logic [2 - 1 : 0] ``intf``_bresp, \
  input logic ``intf``_bvalid, \
  output logic ``intf``_bready

`define pcie_resp_if_slave_port_arr(intf, N) \
  input logic [8 - 1 : 0] ``intf``_rid[``N``], \
  input logic [512 - 1 : 0] ``intf``_rdata[``N``], \
  input logic ``intf``_rvalid[``N``], \
  input logic [2 - 1 : 0] ``intf``_rresp[``N``], \
  output logic ``intf``_rready[``N``], \
  input logic [8 - 1 : 0] ``intf``_bid[``N``], \
  input logic [2 - 1 : 0] ``intf``_bresp[``N``], \
  input logic ``intf``_bvalid[``N``], \
  output logic ``intf``_bready[``N``]

`define pcie_resp_if_slave_port2struct_assign(intf, st) \
  ``st``.rid = ``intf``_rid; \
  ``st``.rdata = ``intf``_rdata; \
  ``st``.rvalid = ``intf``_rvalid; \
  ``st``.rresp = ``intf``_rresp; \
  ``intf``_rready = ``st``.rready; \
  ``st``.bid = ``intf``_bid; \
  ``st``.bresp = ``intf``_bresp; \
  ``st``.bvalid = ``intf``_bvalid; \
  ``intf``_bready = ``st``.bready; \


`define pcie_resp_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].rid = ``intf``_rid[``N``]; \
  ``st``[``N``].rdata = ``intf``_rdata[``N``]; \
  ``st``[``N``].rvalid = ``intf``_rvalid[``N``]; \
  ``st``[``N``].rresp = ``intf``_rresp[``N``]; \
  ``intf``_rready[``N``] = ``st``[``N``].rready; \
  ``st``[``N``].bid = ``intf``_bid[``N``]; \
  ``st``[``N``].bresp = ``intf``_bresp[``N``]; \
  ``st``[``N``].bvalid = ``intf``_bvalid[``N``]; \
  ``intf``_bready[``N``] = ``st``[``N``].bready; \


`define pcie_resp_if_tb_r_s_assign(intf, st) \
  ``intf``.rid = ``st``.rid; \
  ``intf``.rdata = ``st``.rdata; \
  ``intf``.rvalid = ``st``.rvalid; \
  ``intf``.rresp = ``st``.rresp; \

`define pcie_resp_if_tb_r_s_wire(intf) \
  logic [8 - 1 : 0] ``intf``_rid; \
  logic [512 - 1 : 0] ``intf``_rdata; \
  logic ``intf``_rvalid; \
  logic [2 - 1 : 0] ``intf``_rresp; \

`define pcie_resp_if_tb_r_s_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_rid[``N``]; \
  logic [512 - 1 : 0] ``intf``_rdata[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic [2 - 1 : 0] ``intf``_rresp[``N``]; \

`define pcie_resp_if_tb_r_s_port(intf) \
  output logic [8 - 1 : 0] ``intf``_rid, \
  output logic [512 - 1 : 0] ``intf``_rdata, \
  output logic ``intf``_rvalid, \
  output logic [2 - 1 : 0] ``intf``_rresp

`define pcie_resp_if_tb_r_s_port_arr(intf, N) \
  output logic [8 - 1 : 0] ``intf``_rid[``N``], \
  output logic [512 - 1 : 0] ``intf``_rdata[``N``], \
  output logic ``intf``_rvalid[``N``], \
  output logic [2 - 1 : 0] ``intf``_rresp[``N``]

`define pcie_resp_if_tb_r_s_port2struct_assign(intf, st) \
  ``intf``_rid = ``st``.rid; \
  ``intf``_rdata = ``st``.rdata; \
  ``intf``_rvalid = ``st``.rvalid; \
  ``intf``_rresp = ``st``.rresp; \


`define pcie_resp_if_tb_r_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_rid[``N``] = ``st``[``N``].rid; \
  ``intf``_rdata[``N``] = ``st``[``N``].rdata; \
  ``intf``_rvalid[``N``] = ``st``[``N``].rvalid; \
  ``intf``_rresp[``N``] = ``st``[``N``].rresp; \


`define pcie_resp_if_master_assign(intf, st) \
  ``intf``.rid = ``st``.rid; \
  ``intf``.rdata = ``st``.rdata; \
  ``intf``.rvalid = ``st``.rvalid; \
  ``intf``.rresp = ``st``.rresp; \
  ``st``.rready = ``intf``.rready; \
  ``intf``.bid = ``st``.bid; \
  ``intf``.bresp = ``st``.bresp; \
  ``intf``.bvalid = ``st``.bvalid; \
  ``st``.bready = ``intf``.bready; \

`define pcie_resp_if_master_wire(intf) \
  logic [8 - 1 : 0] ``intf``_rid; \
  logic [512 - 1 : 0] ``intf``_rdata; \
  logic ``intf``_rvalid; \
  logic [2 - 1 : 0] ``intf``_rresp; \
  logic ``intf``_rready; \
  logic [8 - 1 : 0] ``intf``_bid; \
  logic [2 - 1 : 0] ``intf``_bresp; \
  logic ``intf``_bvalid; \
  logic ``intf``_bready; \

`define pcie_resp_if_master_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_rid[``N``]; \
  logic [512 - 1 : 0] ``intf``_rdata[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic [2 - 1 : 0] ``intf``_rresp[``N``]; \
  logic ``intf``_rready[``N``]; \
  logic [8 - 1 : 0] ``intf``_bid[``N``]; \
  logic [2 - 1 : 0] ``intf``_bresp[``N``]; \
  logic ``intf``_bvalid[``N``]; \
  logic ``intf``_bready[``N``]; \

`define pcie_resp_if_master_port(intf) \
  output logic [8 - 1 : 0] ``intf``_rid, \
  output logic [512 - 1 : 0] ``intf``_rdata, \
  output logic ``intf``_rvalid, \
  output logic [2 - 1 : 0] ``intf``_rresp, \
  input logic ``intf``_rready, \
  output logic [8 - 1 : 0] ``intf``_bid, \
  output logic [2 - 1 : 0] ``intf``_bresp, \
  output logic ``intf``_bvalid, \
  input logic ``intf``_bready

`define pcie_resp_if_master_port_arr(intf, N) \
  output logic [8 - 1 : 0] ``intf``_rid[``N``], \
  output logic [512 - 1 : 0] ``intf``_rdata[``N``], \
  output logic ``intf``_rvalid[``N``], \
  output logic [2 - 1 : 0] ``intf``_rresp[``N``], \
  input logic ``intf``_rready[``N``], \
  output logic [8 - 1 : 0] ``intf``_bid[``N``], \
  output logic [2 - 1 : 0] ``intf``_bresp[``N``], \
  output logic ``intf``_bvalid[``N``], \
  input logic ``intf``_bready[``N``]

`define pcie_resp_if_master_port2struct_assign(intf, st) \
  ``intf``_rid = ``st``.rid; \
  ``intf``_rdata = ``st``.rdata; \
  ``intf``_rvalid = ``st``.rvalid; \
  ``intf``_rresp = ``st``.rresp; \
  ``st``.rready = ``intf``_rready; \
  ``intf``_bid = ``st``.bid; \
  ``intf``_bresp = ``st``.bresp; \
  ``intf``_bvalid = ``st``.bvalid; \
  ``st``.bready = ``intf``_bready; \


`define pcie_resp_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_rid[``N``] = ``st``[``N``].rid; \
  ``intf``_rdata[``N``] = ``st``[``N``].rdata; \
  ``intf``_rvalid[``N``] = ``st``[``N``].rvalid; \
  ``intf``_rresp[``N``] = ``st``[``N``].rresp; \
  ``st``[``N``].rready = ``intf``_rready[``N``]; \
  ``intf``_bid[``N``] = ``st``[``N``].bid; \
  ``intf``_bresp[``N``] = ``st``[``N``].bresp; \
  ``intf``_bvalid[``N``] = ``st``[``N``].bvalid; \
  ``st``[``N``].bready = ``intf``_bready[``N``]; \


`define pcie_resp_if_tb_r_rdy_s_assign(intf, st) \
  ``st``.rready = ``intf``.rready; \

`define pcie_resp_if_tb_r_rdy_s_wire(intf) \
  logic ``intf``_rready; \

`define pcie_resp_if_tb_r_rdy_s_wire_arr(intf, N) \
  logic ``intf``_rready[``N``]; \

`define pcie_resp_if_tb_r_rdy_s_port(intf) \
  input logic ``intf``_rready

`define pcie_resp_if_tb_r_rdy_s_port_arr(intf, N) \
  input logic ``intf``_rready[``N``]

`define pcie_resp_if_tb_r_rdy_s_port2struct_assign(intf, st) \
  ``st``.rready = ``intf``_rready; \


`define pcie_resp_if_tb_r_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].rready = ``intf``_rready[``N``]; \


`define pcie_resp_if_tb_r_rdy_m_assign(intf, st) \
  ``intf``.rready = ``st``.rready; \

`define pcie_resp_if_tb_r_rdy_m_wire(intf) \
  logic ``intf``_rready; \

`define pcie_resp_if_tb_r_rdy_m_wire_arr(intf, N) \
  logic ``intf``_rready[``N``]; \

`define pcie_resp_if_tb_r_rdy_m_port(intf) \
  output logic ``intf``_rready

`define pcie_resp_if_tb_r_rdy_m_port_arr(intf, N) \
  output logic ``intf``_rready[``N``]

`define pcie_resp_if_tb_r_rdy_m_port2struct_assign(intf, st) \
  ``intf``_rready = ``st``.rready; \


`define pcie_resp_if_tb_r_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_rready[``N``] = ``st``[``N``].rready; \


`define pcie_resp_if_tb_b_m_assign(intf, st) \
  ``st``.bid = ``intf``.bid; \
  ``st``.bresp = ``intf``.bresp; \
  ``st``.bvalid = ``intf``.bvalid; \

`define pcie_resp_if_tb_b_m_wire(intf) \
  logic [8 - 1 : 0] ``intf``_bid; \
  logic [2 - 1 : 0] ``intf``_bresp; \
  logic ``intf``_bvalid; \

`define pcie_resp_if_tb_b_m_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_bid[``N``]; \
  logic [2 - 1 : 0] ``intf``_bresp[``N``]; \
  logic ``intf``_bvalid[``N``]; \

`define pcie_resp_if_tb_b_m_port(intf) \
  input logic [8 - 1 : 0] ``intf``_bid, \
  input logic [2 - 1 : 0] ``intf``_bresp, \
  input logic ``intf``_bvalid

`define pcie_resp_if_tb_b_m_port_arr(intf, N) \
  input logic [8 - 1 : 0] ``intf``_bid[``N``], \
  input logic [2 - 1 : 0] ``intf``_bresp[``N``], \
  input logic ``intf``_bvalid[``N``]

`define pcie_resp_if_tb_b_m_port2struct_assign(intf, st) \
  ``st``.bid = ``intf``_bid; \
  ``st``.bresp = ``intf``_bresp; \
  ``st``.bvalid = ``intf``_bvalid; \


`define pcie_resp_if_tb_b_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].bid = ``intf``_bid[``N``]; \
  ``st``[``N``].bresp = ``intf``_bresp[``N``]; \
  ``st``[``N``].bvalid = ``intf``_bvalid[``N``]; \


`define pcie_resp_if_tb_b_s_assign(intf, st) \
  ``intf``.bid = ``st``.bid; \
  ``intf``.bresp = ``st``.bresp; \
  ``intf``.bvalid = ``st``.bvalid; \

`define pcie_resp_if_tb_b_s_wire(intf) \
  logic [8 - 1 : 0] ``intf``_bid; \
  logic [2 - 1 : 0] ``intf``_bresp; \
  logic ``intf``_bvalid; \

`define pcie_resp_if_tb_b_s_wire_arr(intf, N) \
  logic [8 - 1 : 0] ``intf``_bid[``N``]; \
  logic [2 - 1 : 0] ``intf``_bresp[``N``]; \
  logic ``intf``_bvalid[``N``]; \

`define pcie_resp_if_tb_b_s_port(intf) \
  output logic [8 - 1 : 0] ``intf``_bid, \
  output logic [2 - 1 : 0] ``intf``_bresp, \
  output logic ``intf``_bvalid

`define pcie_resp_if_tb_b_s_port_arr(intf, N) \
  output logic [8 - 1 : 0] ``intf``_bid[``N``], \
  output logic [2 - 1 : 0] ``intf``_bresp[``N``], \
  output logic ``intf``_bvalid[``N``]

`define pcie_resp_if_tb_b_s_port2struct_assign(intf, st) \
  ``intf``_bid = ``st``.bid; \
  ``intf``_bresp = ``st``.bresp; \
  ``intf``_bvalid = ``st``.bvalid; \


`define pcie_resp_if_tb_b_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_bid[``N``] = ``st``[``N``].bid; \
  ``intf``_bresp[``N``] = ``st``[``N``].bresp; \
  ``intf``_bvalid[``N``] = ``st``[``N``].bvalid; \


`define pcie_resp_if_tb_b_rdy_s_assign(intf, st) \
  ``st``.bready = ``intf``.bready; \

`define pcie_resp_if_tb_b_rdy_s_wire(intf) \
  logic ``intf``_bready; \

`define pcie_resp_if_tb_b_rdy_s_wire_arr(intf, N) \
  logic ``intf``_bready[``N``]; \

`define pcie_resp_if_tb_b_rdy_s_port(intf) \
  input logic ``intf``_bready

`define pcie_resp_if_tb_b_rdy_s_port_arr(intf, N) \
  input logic ``intf``_bready[``N``]

`define pcie_resp_if_tb_b_rdy_s_port2struct_assign(intf, st) \
  ``st``.bready = ``intf``_bready; \


`define pcie_resp_if_tb_b_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].bready = ``intf``_bready[``N``]; \


`define pcie_resp_if_tb_b_rdy_m_assign(intf, st) \
  ``intf``.bready = ``st``.bready; \

`define pcie_resp_if_tb_b_rdy_m_wire(intf) \
  logic ``intf``_bready; \

`define pcie_resp_if_tb_b_rdy_m_wire_arr(intf, N) \
  logic ``intf``_bready[``N``]; \

`define pcie_resp_if_tb_b_rdy_m_port(intf) \
  output logic ``intf``_bready

`define pcie_resp_if_tb_b_rdy_m_port_arr(intf, N) \
  output logic ``intf``_bready[``N``]

`define pcie_resp_if_tb_b_rdy_m_port2struct_assign(intf, st) \
  ``intf``_bready = ``st``.bready; \


`define pcie_resp_if_tb_b_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_bready[``N``] = ``st``[``N``].bready; \


interface pcie_resp_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  logic [8 - 1 : 0] rid;
  logic [512 - 1 : 0] rdata;
  logic rvalid;
  logic [2 - 1 : 0] rresp;
  logic rready;
  logic [8 - 1 : 0] bid;
  logic [2 - 1 : 0] bresp;
  logic bvalid;
  logic bready;
  `ifndef SYNTHESIS
  logic rvalid_d;
  `endif
  `ifndef SYNTHESIS
  logic bvalid_d;
  `endif
  `ifndef SYNTHESIS
  logic bready_d;
  `endif
  `ifndef SYNTHESIS
  logic rready_d;
  `endif
  modport tb_r_m (
    input  rid,
    input  rdata,
    input  rvalid,
    input  rresp
  );
  modport slave (
    input  rid,
    input  rdata,
    input  rvalid,
    input  rresp,
    output rready,
    input  bid,
    input  bresp,
    input  bvalid,
    output bready
  );
  modport tb_r_s (
    output rid,
    output rdata,
    output rvalid,
    output rresp
  );
  modport master (
    output rid,
    output rdata,
    output rvalid,
    output rresp,
    input  rready,
    output bid,
    output bresp,
    output bvalid,
    input  bready
  );
  modport tb_r_rdy_s (
    input  rready
  );
  modport tb_r_rdy_m (
    output rready
  );
  modport tb_b_m (
    input  bid,
    input  bresp,
    input  bvalid
  );
  modport tb_b_s (
    output bid,
    output bresp,
    output bvalid
  );
  modport tb_b_rdy_s (
    input  bready
  );
  modport tb_b_rdy_m (
    output bready
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  rid;
    input  rdata;
    input  rvalid;
    input  rresp;
    input  rready;
    input  bid;
    input  bresp;
    input  bvalid;
    input  bready;
    input  rvalid_d;
    input  bvalid_d;
    input  bready_d;
    input  rready_d;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output rid;
    output rdata;
    output rvalid;
    output rresp;
    output rready;
    output bid;
    output bresp;
    output bvalid;
    output bready;
  endclocking
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    rvalid_d <= rvalid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    bvalid_d <= bvalid;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    bready_d <= bready;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    rready_d <= rready;
  `endif
endinterface
`endif
`endif
