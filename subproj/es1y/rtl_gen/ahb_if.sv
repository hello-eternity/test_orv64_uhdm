
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef AHB_IF__SV
`define AHB_IF__SV
`define ahb_if_s_assign(intf, st) \
  ``st``.htrans = ``intf``.htrans; \
  ``st``.haddr = ``intf``.haddr; \
  ``st``.hsize = ``intf``.hsize; \
  ``st``.hwrite = ``intf``.hwrite; \
  ``st``.hlock = ``intf``.hlock; \
  ``st``.hbusreq = ``intf``.hbusreq; \
  ``st``.hwdata = ``intf``.hwdata; \
  ``intf``.hrdata = ``st``.hrdata; \
  ``intf``.hresp = ``st``.hresp; \

`define ahb_if_s_wire(intf) \
  ahb_trans_t ``intf``_htrans; \
  ahb_addr_t ``intf``_haddr; \
  ahb_size_t ``intf``_hsize; \
  logic ``intf``_hwrite; \
  logic ``intf``_hlock; \
  logic ``intf``_hbusreq; \
  ahb_data_t ``intf``_hwdata; \
  ahb_data_t ``intf``_hrdata; \
  logic ``intf``_hresp; \

`define ahb_if_s_wire_arr(intf, N) \
  ahb_trans_t ``intf``_htrans[``N``]; \
  ahb_addr_t ``intf``_haddr[``N``]; \
  ahb_size_t ``intf``_hsize[``N``]; \
  logic ``intf``_hwrite[``N``]; \
  logic ``intf``_hlock[``N``]; \
  logic ``intf``_hbusreq[``N``]; \
  ahb_data_t ``intf``_hwdata[``N``]; \
  ahb_data_t ``intf``_hrdata[``N``]; \
  logic ``intf``_hresp[``N``]; \

`define ahb_if_s_port(intf) \
  input ahb_trans_t ``intf``_htrans, \
  input ahb_addr_t ``intf``_haddr, \
  input ahb_size_t ``intf``_hsize, \
  input logic ``intf``_hwrite, \
  input logic ``intf``_hlock, \
  input logic ``intf``_hbusreq, \
  input ahb_data_t ``intf``_hwdata, \
  output ahb_data_t ``intf``_hrdata, \
  output logic ``intf``_hresp

`define ahb_if_s_port_arr(intf, N) \
  input ahb_trans_t ``intf``_htrans[``N``], \
  input ahb_addr_t ``intf``_haddr[``N``], \
  input ahb_size_t ``intf``_hsize[``N``], \
  input logic ``intf``_hwrite[``N``], \
  input logic ``intf``_hlock[``N``], \
  input logic ``intf``_hbusreq[``N``], \
  input ahb_data_t ``intf``_hwdata[``N``], \
  output ahb_data_t ``intf``_hrdata[``N``], \
  output logic ``intf``_hresp[``N``]

`define ahb_if_s_port2struct_assign(intf, st) \
  ``st``.htrans = ``intf``_htrans; \
  ``st``.haddr = ``intf``_haddr; \
  ``st``.hsize = ``intf``_hsize; \
  ``st``.hwrite = ``intf``_hwrite; \
  ``st``.hlock = ``intf``_hlock; \
  ``st``.hbusreq = ``intf``_hbusreq; \
  ``st``.hwdata = ``intf``_hwdata; \
  ``intf``_hrdata = ``st``.hrdata; \
  ``intf``_hresp = ``st``.hresp; \


`define ahb_if_s_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].htrans = ``intf``_htrans[``N``]; \
  ``st``[``N``].haddr = ``intf``_haddr[``N``]; \
  ``st``[``N``].hsize = ``intf``_hsize[``N``]; \
  ``st``[``N``].hwrite = ``intf``_hwrite[``N``]; \
  ``st``[``N``].hlock = ``intf``_hlock[``N``]; \
  ``st``[``N``].hbusreq = ``intf``_hbusreq[``N``]; \
  ``st``[``N``].hwdata = ``intf``_hwdata[``N``]; \
  ``intf``_hrdata[``N``] = ``st``[``N``].hrdata; \
  ``intf``_hresp[``N``] = ``st``[``N``].hresp; \


`define ahb_if_slave_assign(intf, st) \
  ``st``.htrans = ``intf``.htrans; \
  ``st``.haddr = ``intf``.haddr; \
  ``st``.hsize = ``intf``.hsize; \
  ``st``.hwrite = ``intf``.hwrite; \
  ``st``.hlock = ``intf``.hlock; \
  ``st``.hbusreq = ``intf``.hbusreq; \
  ``st``.hwdata = ``intf``.hwdata; \
  ``intf``.hready = ``st``.hready; \
  ``intf``.hgrant = ``st``.hgrant; \
  ``intf``.hrdata = ``st``.hrdata; \
  ``intf``.hresp = ``st``.hresp; \

`define ahb_if_slave_wire(intf) \
  ahb_trans_t ``intf``_htrans; \
  ahb_addr_t ``intf``_haddr; \
  ahb_size_t ``intf``_hsize; \
  logic ``intf``_hwrite; \
  logic ``intf``_hlock; \
  logic ``intf``_hbusreq; \
  ahb_data_t ``intf``_hwdata; \
  logic ``intf``_hready; \
  logic ``intf``_hgrant; \
  ahb_data_t ``intf``_hrdata; \
  logic ``intf``_hresp; \

`define ahb_if_slave_wire_arr(intf, N) \
  ahb_trans_t ``intf``_htrans[``N``]; \
  ahb_addr_t ``intf``_haddr[``N``]; \
  ahb_size_t ``intf``_hsize[``N``]; \
  logic ``intf``_hwrite[``N``]; \
  logic ``intf``_hlock[``N``]; \
  logic ``intf``_hbusreq[``N``]; \
  ahb_data_t ``intf``_hwdata[``N``]; \
  logic ``intf``_hready[``N``]; \
  logic ``intf``_hgrant[``N``]; \
  ahb_data_t ``intf``_hrdata[``N``]; \
  logic ``intf``_hresp[``N``]; \

`define ahb_if_slave_port(intf) \
  input ahb_trans_t ``intf``_htrans, \
  input ahb_addr_t ``intf``_haddr, \
  input ahb_size_t ``intf``_hsize, \
  input logic ``intf``_hwrite, \
  input logic ``intf``_hlock, \
  input logic ``intf``_hbusreq, \
  input ahb_data_t ``intf``_hwdata, \
  output logic ``intf``_hready, \
  output logic ``intf``_hgrant, \
  output ahb_data_t ``intf``_hrdata, \
  output logic ``intf``_hresp

`define ahb_if_slave_port_arr(intf, N) \
  input ahb_trans_t ``intf``_htrans[``N``], \
  input ahb_addr_t ``intf``_haddr[``N``], \
  input ahb_size_t ``intf``_hsize[``N``], \
  input logic ``intf``_hwrite[``N``], \
  input logic ``intf``_hlock[``N``], \
  input logic ``intf``_hbusreq[``N``], \
  input ahb_data_t ``intf``_hwdata[``N``], \
  output logic ``intf``_hready[``N``], \
  output logic ``intf``_hgrant[``N``], \
  output ahb_data_t ``intf``_hrdata[``N``], \
  output logic ``intf``_hresp[``N``]

`define ahb_if_slave_port2struct_assign(intf, st) \
  ``st``.htrans = ``intf``_htrans; \
  ``st``.haddr = ``intf``_haddr; \
  ``st``.hsize = ``intf``_hsize; \
  ``st``.hwrite = ``intf``_hwrite; \
  ``st``.hlock = ``intf``_hlock; \
  ``st``.hbusreq = ``intf``_hbusreq; \
  ``st``.hwdata = ``intf``_hwdata; \
  ``intf``_hready = ``st``.hready; \
  ``intf``_hgrant = ``st``.hgrant; \
  ``intf``_hrdata = ``st``.hrdata; \
  ``intf``_hresp = ``st``.hresp; \


`define ahb_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].htrans = ``intf``_htrans[``N``]; \
  ``st``[``N``].haddr = ``intf``_haddr[``N``]; \
  ``st``[``N``].hsize = ``intf``_hsize[``N``]; \
  ``st``[``N``].hwrite = ``intf``_hwrite[``N``]; \
  ``st``[``N``].hlock = ``intf``_hlock[``N``]; \
  ``st``[``N``].hbusreq = ``intf``_hbusreq[``N``]; \
  ``st``[``N``].hwdata = ``intf``_hwdata[``N``]; \
  ``intf``_hready[``N``] = ``st``[``N``].hready; \
  ``intf``_hgrant[``N``] = ``st``[``N``].hgrant; \
  ``intf``_hrdata[``N``] = ``st``[``N``].hrdata; \
  ``intf``_hresp[``N``] = ``st``[``N``].hresp; \


`define ahb_if_m_assign(intf, st) \
  ``intf``.htrans = ``st``.htrans; \
  ``intf``.haddr = ``st``.haddr; \
  ``intf``.hsize = ``st``.hsize; \
  ``intf``.hwrite = ``st``.hwrite; \
  ``intf``.hlock = ``st``.hlock; \
  ``intf``.hbusreq = ``st``.hbusreq; \
  ``intf``.hwdata = ``st``.hwdata; \
  ``st``.hrdata = ``intf``.hrdata; \
  ``st``.hresp = ``intf``.hresp; \

`define ahb_if_m_wire(intf) \
  ahb_trans_t ``intf``_htrans; \
  ahb_addr_t ``intf``_haddr; \
  ahb_size_t ``intf``_hsize; \
  logic ``intf``_hwrite; \
  logic ``intf``_hlock; \
  logic ``intf``_hbusreq; \
  ahb_data_t ``intf``_hwdata; \
  ahb_data_t ``intf``_hrdata; \
  logic ``intf``_hresp; \

`define ahb_if_m_wire_arr(intf, N) \
  ahb_trans_t ``intf``_htrans[``N``]; \
  ahb_addr_t ``intf``_haddr[``N``]; \
  ahb_size_t ``intf``_hsize[``N``]; \
  logic ``intf``_hwrite[``N``]; \
  logic ``intf``_hlock[``N``]; \
  logic ``intf``_hbusreq[``N``]; \
  ahb_data_t ``intf``_hwdata[``N``]; \
  ahb_data_t ``intf``_hrdata[``N``]; \
  logic ``intf``_hresp[``N``]; \

`define ahb_if_m_port(intf) \
  output ahb_trans_t ``intf``_htrans, \
  output ahb_addr_t ``intf``_haddr, \
  output ahb_size_t ``intf``_hsize, \
  output logic ``intf``_hwrite, \
  output logic ``intf``_hlock, \
  output logic ``intf``_hbusreq, \
  output ahb_data_t ``intf``_hwdata, \
  input ahb_data_t ``intf``_hrdata, \
  input logic ``intf``_hresp

`define ahb_if_m_port_arr(intf, N) \
  output ahb_trans_t ``intf``_htrans[``N``], \
  output ahb_addr_t ``intf``_haddr[``N``], \
  output ahb_size_t ``intf``_hsize[``N``], \
  output logic ``intf``_hwrite[``N``], \
  output logic ``intf``_hlock[``N``], \
  output logic ``intf``_hbusreq[``N``], \
  output ahb_data_t ``intf``_hwdata[``N``], \
  input ahb_data_t ``intf``_hrdata[``N``], \
  input logic ``intf``_hresp[``N``]

`define ahb_if_m_port2struct_assign(intf, st) \
  ``intf``_htrans = ``st``.htrans; \
  ``intf``_haddr = ``st``.haddr; \
  ``intf``_hsize = ``st``.hsize; \
  ``intf``_hwrite = ``st``.hwrite; \
  ``intf``_hlock = ``st``.hlock; \
  ``intf``_hbusreq = ``st``.hbusreq; \
  ``intf``_hwdata = ``st``.hwdata; \
  ``st``.hrdata = ``intf``_hrdata; \
  ``st``.hresp = ``intf``_hresp; \


`define ahb_if_m_port2struct_arr_assign(intf, st, N) \
  ``intf``_htrans[``N``] = ``st``[``N``].htrans; \
  ``intf``_haddr[``N``] = ``st``[``N``].haddr; \
  ``intf``_hsize[``N``] = ``st``[``N``].hsize; \
  ``intf``_hwrite[``N``] = ``st``[``N``].hwrite; \
  ``intf``_hlock[``N``] = ``st``[``N``].hlock; \
  ``intf``_hbusreq[``N``] = ``st``[``N``].hbusreq; \
  ``intf``_hwdata[``N``] = ``st``[``N``].hwdata; \
  ``st``[``N``].hrdata = ``intf``_hrdata[``N``]; \
  ``st``[``N``].hresp = ``intf``_hresp[``N``]; \


`define ahb_if_master_assign(intf, st) \
  ``intf``.htrans = ``st``.htrans; \
  ``intf``.haddr = ``st``.haddr; \
  ``intf``.hsize = ``st``.hsize; \
  ``intf``.hwrite = ``st``.hwrite; \
  ``intf``.hlock = ``st``.hlock; \
  ``intf``.hbusreq = ``st``.hbusreq; \
  ``intf``.hwdata = ``st``.hwdata; \
  ``st``.hready = ``intf``.hready; \
  ``st``.hgrant = ``intf``.hgrant; \
  ``st``.hrdata = ``intf``.hrdata; \
  ``st``.hresp = ``intf``.hresp; \

`define ahb_if_master_wire(intf) \
  ahb_trans_t ``intf``_htrans; \
  ahb_addr_t ``intf``_haddr; \
  ahb_size_t ``intf``_hsize; \
  logic ``intf``_hwrite; \
  logic ``intf``_hlock; \
  logic ``intf``_hbusreq; \
  ahb_data_t ``intf``_hwdata; \
  logic ``intf``_hready; \
  logic ``intf``_hgrant; \
  ahb_data_t ``intf``_hrdata; \
  logic ``intf``_hresp; \

`define ahb_if_master_wire_arr(intf, N) \
  ahb_trans_t ``intf``_htrans[``N``]; \
  ahb_addr_t ``intf``_haddr[``N``]; \
  ahb_size_t ``intf``_hsize[``N``]; \
  logic ``intf``_hwrite[``N``]; \
  logic ``intf``_hlock[``N``]; \
  logic ``intf``_hbusreq[``N``]; \
  ahb_data_t ``intf``_hwdata[``N``]; \
  logic ``intf``_hready[``N``]; \
  logic ``intf``_hgrant[``N``]; \
  ahb_data_t ``intf``_hrdata[``N``]; \
  logic ``intf``_hresp[``N``]; \

`define ahb_if_master_port(intf) \
  output ahb_trans_t ``intf``_htrans, \
  output ahb_addr_t ``intf``_haddr, \
  output ahb_size_t ``intf``_hsize, \
  output logic ``intf``_hwrite, \
  output logic ``intf``_hlock, \
  output logic ``intf``_hbusreq, \
  output ahb_data_t ``intf``_hwdata, \
  input logic ``intf``_hready, \
  input logic ``intf``_hgrant, \
  input ahb_data_t ``intf``_hrdata, \
  input logic ``intf``_hresp

`define ahb_if_master_port_arr(intf, N) \
  output ahb_trans_t ``intf``_htrans[``N``], \
  output ahb_addr_t ``intf``_haddr[``N``], \
  output ahb_size_t ``intf``_hsize[``N``], \
  output logic ``intf``_hwrite[``N``], \
  output logic ``intf``_hlock[``N``], \
  output logic ``intf``_hbusreq[``N``], \
  output ahb_data_t ``intf``_hwdata[``N``], \
  input logic ``intf``_hready[``N``], \
  input logic ``intf``_hgrant[``N``], \
  input ahb_data_t ``intf``_hrdata[``N``], \
  input logic ``intf``_hresp[``N``]

`define ahb_if_master_port2struct_assign(intf, st) \
  ``intf``_htrans = ``st``.htrans; \
  ``intf``_haddr = ``st``.haddr; \
  ``intf``_hsize = ``st``.hsize; \
  ``intf``_hwrite = ``st``.hwrite; \
  ``intf``_hlock = ``st``.hlock; \
  ``intf``_hbusreq = ``st``.hbusreq; \
  ``intf``_hwdata = ``st``.hwdata; \
  ``st``.hready = ``intf``_hready; \
  ``st``.hgrant = ``intf``_hgrant; \
  ``st``.hrdata = ``intf``_hrdata; \
  ``st``.hresp = ``intf``_hresp; \


`define ahb_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_htrans[``N``] = ``st``[``N``].htrans; \
  ``intf``_haddr[``N``] = ``st``[``N``].haddr; \
  ``intf``_hsize[``N``] = ``st``[``N``].hsize; \
  ``intf``_hwrite[``N``] = ``st``[``N``].hwrite; \
  ``intf``_hlock[``N``] = ``st``[``N``].hlock; \
  ``intf``_hbusreq[``N``] = ``st``[``N``].hbusreq; \
  ``intf``_hwdata[``N``] = ``st``[``N``].hwdata; \
  ``st``[``N``].hready = ``intf``_hready[``N``]; \
  ``st``[``N``].hgrant = ``intf``_hgrant[``N``]; \
  ``st``[``N``].hrdata = ``intf``_hrdata[``N``]; \
  ``st``[``N``].hresp = ``intf``_hresp[``N``]; \


interface ahb_if (input clk, rstn);
  import pygmy_intf_typedef::*;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  ahb_trans_t htrans;
  ahb_addr_t haddr;
  ahb_size_t hsize;
  logic hwrite;
  logic hlock;
  logic hbusreq;
  ahb_data_t hwdata;
  logic hready;
  logic hgrant;
  ahb_data_t hrdata;
  logic hresp;
  `ifndef SYNTHESIS
  logic hready_d;
  `endif
  `ifndef SYNTHESIS
  logic hgrant_d;
  `endif
  `ifndef SYNTHESIS
  logic hwrite_d;
  `endif
  `ifndef SYNTHESIS
  logic hready_d2;
  `endif
  `ifndef SYNTHESIS
  logic hgrant_d2;
  `endif
  `ifndef SYNTHESIS
  ahb_trans_t htrans_d;
  `endif
  `ifndef SYNTHESIS
  ahb_trans_t htrans_d2;
  `endif
  modport s (
    input  htrans,
    input  haddr,
    input  hsize,
    input  hwrite,
    input  hlock,
    input  hbusreq,
    input  hwdata,
    output hrdata,
    output hresp
  );
  modport slave (
    input  htrans,
    input  haddr,
    input  hsize,
    input  hwrite,
    input  hlock,
    input  hbusreq,
    input  hwdata,
    output hready,
    output hgrant,
    output hrdata,
    output hresp
  );
  modport m (
    output htrans,
    output haddr,
    output hsize,
    output hwrite,
    output hlock,
    output hbusreq,
    output hwdata,
    input  hrdata,
    input  hresp
  );
  modport master (
    output htrans,
    output haddr,
    output hsize,
    output hwrite,
    output hlock,
    output hbusreq,
    output hwdata,
    input  hready,
    input  hgrant,
    input  hrdata,
    input  hresp
  );
  `ifndef SYNTHESIS
  clocking mon_cb @(posedge clk);
    default input #1step;
    input  htrans;
    input  haddr;
    input  hsize;
    input  hwrite;
    input  hlock;
    input  hbusreq;
    input  hwdata;
    input  hready;
    input  hgrant;
    input  hrdata;
    input  hresp;
    input  hready_d;
    input  hgrant_d;
    input  hwrite_d;
    input  hready_d2;
    input  hgrant_d2;
    input  htrans_d;
    input  htrans_d2;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output htrans;
    output haddr;
    output hsize;
    output hwrite;
    output hlock;
    output hbusreq;
    output hwdata;
    output hready;
    output hgrant;
    output hrdata;
    output hresp;
  endclocking
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    hready_d <= hready;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    hgrant_d <= hgrant;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    hwrite_d <= hwrite;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    hready_d2 <= hready_d;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    hgrant_d2 <= hgrant_d;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    htrans_d <= htrans;
  `endif
  `ifndef SYNTHESIS
  always @(posedge clk)
    htrans_d2 <= htrans_d;
  `endif
endinterface
`endif
`endif
