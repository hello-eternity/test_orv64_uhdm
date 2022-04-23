
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef OURSRING_RESP_IF__SV
`define OURSRING_RESP_IF__SV
`define oursring_resp_if_tb_r_m_assign(intf, st) \
  ``st``.r.rid = ``intf``.rid; \
  ``st``.r.rdata = ``intf``.rdata; \
  ``st``.rvalid = ``intf``.rvalid; \
  ``st``.r.rresp = ``intf``.rresp; \
  ``st``.r.rlast = ``intf``.rlast; \

`define oursring_resp_if_tb_r_m_wire(intf) \
  oursring_resp_if_r_t ``intf``_r; \
  logic ``intf``_rvalid; \

`define oursring_resp_if_tb_r_m_wire_arr(intf, N) \
  oursring_resp_if_r_t ``intf``_r[``N``]; \
  logic ``intf``_rvalid[``N``]; \

`define oursring_resp_if_tb_r_m_port(intf) \
  input oursring_resp_if_r_t ``intf``_r, \
  input logic ``intf``_rvalid

`define oursring_resp_if_tb_r_m_port_arr(intf, N) \
  input oursring_resp_if_r_t ``intf``_r[``N``], \
  input logic ``intf``_rvalid[``N``]

`define oursring_resp_if_tb_r_m_port2struct_assign(intf, st) \
  ``st``.r = ``intf``_r; \
  ``st``.rvalid = ``intf``_rvalid; \


`define oursring_resp_if_tb_r_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].r = ``intf``_r[``N``]; \
  ``st``[``N``].rvalid = ``intf``_rvalid[``N``]; \


`define oursring_resp_if_slave_assign(intf, st) \
  ``st``.r.rid = ``intf``.rid; \
  ``st``.r.rdata = ``intf``.rdata; \
  ``st``.rvalid = ``intf``.rvalid; \
  ``st``.r.rresp = ``intf``.rresp; \
  ``st``.r.rlast = ``intf``.rlast; \
  ``intf``.rready = ``st``.rready; \
  ``st``.b.bid = ``intf``.bid; \
  ``st``.b.bresp = ``intf``.bresp; \
  ``st``.bvalid = ``intf``.bvalid; \
  ``intf``.bready = ``st``.bready; \

`define oursring_resp_if_slave_wire(intf) \
  oursring_resp_if_r_t ``intf``_r; \
  logic ``intf``_rvalid; \
  logic ``intf``_rready; \
  logic ``intf``_bvalid; \
  logic ``intf``_bready; \
  oursring_resp_if_b_t ``intf``_b; \

`define oursring_resp_if_slave_wire_arr(intf, N) \
  oursring_resp_if_r_t ``intf``_r[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic ``intf``_rready[``N``]; \
  logic ``intf``_bvalid[``N``]; \
  logic ``intf``_bready[``N``]; \
  oursring_resp_if_b_t ``intf``_b[``N``]; \

`define oursring_resp_if_slave_port(intf) \
  input oursring_resp_if_r_t ``intf``_r, \
  input logic ``intf``_rvalid, \
  output logic ``intf``_rready, \
  input logic ``intf``_bvalid, \
  output logic ``intf``_bready, \
  input oursring_resp_if_b_t ``intf``_b

`define oursring_resp_if_slave_port_arr(intf, N) \
  input oursring_resp_if_r_t ``intf``_r[``N``], \
  input logic ``intf``_rvalid[``N``], \
  output logic ``intf``_rready[``N``], \
  input logic ``intf``_bvalid[``N``], \
  output logic ``intf``_bready[``N``], \
  input oursring_resp_if_b_t ``intf``_b[``N``]

`define oursring_resp_if_slave_port2struct_assign(intf, st) \
  ``st``.r = ``intf``_r; \
  ``st``.rvalid = ``intf``_rvalid; \
  ``intf``_rready = ``st``.rready; \
  ``st``.bvalid = ``intf``_bvalid; \
  ``intf``_bready = ``st``.bready; \
  ``st``.b = ``intf``_b; \


`define oursring_resp_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].r = ``intf``_r[``N``]; \
  ``st``[``N``].rvalid = ``intf``_rvalid[``N``]; \
  ``intf``_rready[``N``] = ``st``[``N``].rready; \
  ``st``[``N``].bvalid = ``intf``_bvalid[``N``]; \
  ``intf``_bready[``N``] = ``st``[``N``].bready; \
  ``st``[``N``].b = ``intf``_b[``N``]; \


`define oursring_resp_if_tb_r_s_assign(intf, st) \
  ``intf``.rid = ``st``.r.rid; \
  ``intf``.rdata = ``st``.r.rdata; \
  ``intf``.rvalid = ``st``.rvalid; \
  ``intf``.rresp = ``st``.r.rresp; \
  ``intf``.rlast = ``st``.r.rlast; \

`define oursring_resp_if_tb_r_s_wire(intf) \
  oursring_resp_if_r_t ``intf``_r; \
  logic ``intf``_rvalid; \

`define oursring_resp_if_tb_r_s_wire_arr(intf, N) \
  oursring_resp_if_r_t ``intf``_r[``N``]; \
  logic ``intf``_rvalid[``N``]; \

`define oursring_resp_if_tb_r_s_port(intf) \
  output oursring_resp_if_r_t ``intf``_r, \
  output logic ``intf``_rvalid

`define oursring_resp_if_tb_r_s_port_arr(intf, N) \
  output oursring_resp_if_r_t ``intf``_r[``N``], \
  output logic ``intf``_rvalid[``N``]

`define oursring_resp_if_tb_r_s_port2struct_assign(intf, st) \
  ``intf``_r = ``st``.r; \
  ``intf``_rvalid = ``st``.rvalid; \


`define oursring_resp_if_tb_r_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_r[``N``] = ``st``[``N``].r; \
  ``intf``_rvalid[``N``] = ``st``[``N``].rvalid; \


`define oursring_resp_if_master_assign(intf, st) \
  ``intf``.rid = ``st``.r.rid; \
  ``intf``.rdata = ``st``.r.rdata; \
  ``intf``.rvalid = ``st``.rvalid; \
  ``intf``.rresp = ``st``.r.rresp; \
  ``intf``.rlast = ``st``.r.rlast; \
  ``st``.rready = ``intf``.rready; \
  ``intf``.bid = ``st``.b.bid; \
  ``intf``.bresp = ``st``.b.bresp; \
  ``intf``.bvalid = ``st``.bvalid; \
  ``st``.bready = ``intf``.bready; \

`define oursring_resp_if_master_wire(intf) \
  oursring_resp_if_r_t ``intf``_r; \
  logic ``intf``_rvalid; \
  logic ``intf``_rready; \
  logic ``intf``_bvalid; \
  logic ``intf``_bready; \
  oursring_resp_if_b_t ``intf``_b; \

`define oursring_resp_if_master_wire_arr(intf, N) \
  oursring_resp_if_r_t ``intf``_r[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic ``intf``_rready[``N``]; \
  logic ``intf``_bvalid[``N``]; \
  logic ``intf``_bready[``N``]; \
  oursring_resp_if_b_t ``intf``_b[``N``]; \

`define oursring_resp_if_master_port(intf) \
  output oursring_resp_if_r_t ``intf``_r, \
  output logic ``intf``_rvalid, \
  input logic ``intf``_rready, \
  output logic ``intf``_bvalid, \
  input logic ``intf``_bready, \
  output oursring_resp_if_b_t ``intf``_b

`define oursring_resp_if_master_port_arr(intf, N) \
  output oursring_resp_if_r_t ``intf``_r[``N``], \
  output logic ``intf``_rvalid[``N``], \
  input logic ``intf``_rready[``N``], \
  output logic ``intf``_bvalid[``N``], \
  input logic ``intf``_bready[``N``], \
  output oursring_resp_if_b_t ``intf``_b[``N``]

`define oursring_resp_if_master_port2struct_assign(intf, st) \
  ``intf``_r = ``st``.r; \
  ``intf``_rvalid = ``st``.rvalid; \
  ``st``.rready = ``intf``_rready; \
  ``intf``_bvalid = ``st``.bvalid; \
  ``st``.bready = ``intf``_bready; \
  ``intf``_b = ``st``.b; \


`define oursring_resp_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_r[``N``] = ``st``[``N``].r; \
  ``intf``_rvalid[``N``] = ``st``[``N``].rvalid; \
  ``st``[``N``].rready = ``intf``_rready[``N``]; \
  ``intf``_bvalid[``N``] = ``st``[``N``].bvalid; \
  ``st``[``N``].bready = ``intf``_bready[``N``]; \
  ``intf``_b[``N``] = ``st``[``N``].b; \


`define oursring_resp_if_tb_r_rdy_s_assign(intf, st) \
  ``st``.rready = ``intf``.rready; \

`define oursring_resp_if_tb_r_rdy_s_wire(intf) \
  logic ``intf``_rready; \

`define oursring_resp_if_tb_r_rdy_s_wire_arr(intf, N) \
  logic ``intf``_rready[``N``]; \

`define oursring_resp_if_tb_r_rdy_s_port(intf) \
  input logic ``intf``_rready

`define oursring_resp_if_tb_r_rdy_s_port_arr(intf, N) \
  input logic ``intf``_rready[``N``]

`define oursring_resp_if_tb_r_rdy_s_port2struct_assign(intf, st) \
  ``st``.rready = ``intf``_rready; \


`define oursring_resp_if_tb_r_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].rready = ``intf``_rready[``N``]; \


`define oursring_resp_if_tb_r_rdy_m_assign(intf, st) \
  ``intf``.rready = ``st``.rready; \

`define oursring_resp_if_tb_r_rdy_m_wire(intf) \
  logic ``intf``_rready; \

`define oursring_resp_if_tb_r_rdy_m_wire_arr(intf, N) \
  logic ``intf``_rready[``N``]; \

`define oursring_resp_if_tb_r_rdy_m_port(intf) \
  output logic ``intf``_rready

`define oursring_resp_if_tb_r_rdy_m_port_arr(intf, N) \
  output logic ``intf``_rready[``N``]

`define oursring_resp_if_tb_r_rdy_m_port2struct_assign(intf, st) \
  ``intf``_rready = ``st``.rready; \


`define oursring_resp_if_tb_r_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_rready[``N``] = ``st``[``N``].rready; \


`define oursring_resp_if_tb_b_m_assign(intf, st) \
  ``st``.b.bid = ``intf``.bid; \
  ``st``.b.bresp = ``intf``.bresp; \
  ``st``.bvalid = ``intf``.bvalid; \

`define oursring_resp_if_tb_b_m_wire(intf) \
  logic ``intf``_bvalid; \
  oursring_resp_if_b_t ``intf``_b; \

`define oursring_resp_if_tb_b_m_wire_arr(intf, N) \
  logic ``intf``_bvalid[``N``]; \
  oursring_resp_if_b_t ``intf``_b[``N``]; \

`define oursring_resp_if_tb_b_m_port(intf) \
  input logic ``intf``_bvalid, \
  input oursring_resp_if_b_t ``intf``_b

`define oursring_resp_if_tb_b_m_port_arr(intf, N) \
  input logic ``intf``_bvalid[``N``], \
  input oursring_resp_if_b_t ``intf``_b[``N``]

`define oursring_resp_if_tb_b_m_port2struct_assign(intf, st) \
  ``st``.bvalid = ``intf``_bvalid; \
  ``st``.b = ``intf``_b; \


`define oursring_resp_if_tb_b_m_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].bvalid = ``intf``_bvalid[``N``]; \
  ``st``[``N``].b = ``intf``_b[``N``]; \


`define oursring_resp_if_tb_b_s_assign(intf, st) \
  ``intf``.bid = ``st``.b.bid; \
  ``intf``.bresp = ``st``.b.bresp; \
  ``intf``.bvalid = ``st``.bvalid; \

`define oursring_resp_if_tb_b_s_wire(intf) \
  logic ``intf``_bvalid; \
  oursring_resp_if_b_t ``intf``_b; \

`define oursring_resp_if_tb_b_s_wire_arr(intf, N) \
  logic ``intf``_bvalid[``N``]; \
  oursring_resp_if_b_t ``intf``_b[``N``]; \

`define oursring_resp_if_tb_b_s_port(intf) \
  output logic ``intf``_bvalid, \
  output oursring_resp_if_b_t ``intf``_b

`define oursring_resp_if_tb_b_s_port_arr(intf, N) \
  output logic ``intf``_bvalid[``N``], \
  output oursring_resp_if_b_t ``intf``_b[``N``]

`define oursring_resp_if_tb_b_s_port2struct_assign(intf, st) \
  ``intf``_bvalid = ``st``.bvalid; \
  ``intf``_b = ``st``.b; \


`define oursring_resp_if_tb_b_s_port2struct_arr_assign(intf, st, N) \
  ``intf``_bvalid[``N``] = ``st``[``N``].bvalid; \
  ``intf``_b[``N``] = ``st``[``N``].b; \


`define oursring_resp_if_tb_b_rdy_s_assign(intf, st) \
  ``st``.bready = ``intf``.bready; \

`define oursring_resp_if_tb_b_rdy_s_wire(intf) \
  logic ``intf``_bready; \

`define oursring_resp_if_tb_b_rdy_s_wire_arr(intf, N) \
  logic ``intf``_bready[``N``]; \

`define oursring_resp_if_tb_b_rdy_s_port(intf) \
  input logic ``intf``_bready

`define oursring_resp_if_tb_b_rdy_s_port_arr(intf, N) \
  input logic ``intf``_bready[``N``]

`define oursring_resp_if_tb_b_rdy_s_port2struct_assign(intf, st) \
  ``st``.bready = ``intf``_bready; \


`define oursring_resp_if_tb_b_rdy_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].bready = ``intf``_bready[``N``]; \


`define oursring_resp_if_tb_b_rdy_m_assign(intf, st) \
  ``intf``.bready = ``st``.bready; \

`define oursring_resp_if_tb_b_rdy_m_wire(intf) \
  logic ``intf``_bready; \

`define oursring_resp_if_tb_b_rdy_m_wire_arr(intf, N) \
  logic ``intf``_bready[``N``]; \

`define oursring_resp_if_tb_b_rdy_m_port(intf) \
  output logic ``intf``_bready

`define oursring_resp_if_tb_b_rdy_m_port_arr(intf, N) \
  output logic ``intf``_bready[``N``]

`define oursring_resp_if_tb_b_rdy_m_port2struct_assign(intf, st) \
  ``intf``_bready = ``st``.bready; \


`define oursring_resp_if_tb_b_rdy_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_bready[``N``] = ``st``[``N``].bready; \


interface oursring_resp_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  logic rvalid;
  logic rready;
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
  oursring_resp_if_r_t r;
  oursring_resp_if_b_t b;
  modport tb_r_m (
    input  rvalid,
    input  r
  );
  modport slave (
    input  rvalid,
    output rready,
    input  bvalid,
    output bready,
    input  r,
    input  b
  );
  modport tb_r_s (
    output rvalid,
    output r
  );
  modport master (
    output rvalid,
    input  rready,
    output bvalid,
    input  bready,
    output r,
    output b
  );
  modport tb_r_rdy_s (
    input  rready
  );
  modport tb_r_rdy_m (
    output rready
  );
  modport tb_b_m (
    input  bvalid,
    input  b
  );
  modport tb_b_s (
    output bvalid,
    output b
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
    input  rvalid;
    input  rready;
    input  bvalid;
    input  bready;
    input  rvalid_d;
    input  bvalid_d;
    input  bready_d;
    input  rready_d;
    input  r;
    input  b;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output rvalid;
    output rready;
    output bvalid;
    output bready;
    output r;
    output b;
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
