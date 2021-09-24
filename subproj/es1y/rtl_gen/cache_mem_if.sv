
// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.




`ifdef PYGMY_ES1Y
`ifndef CACHE_MEM_IF__SV
`define CACHE_MEM_IF__SV
`define cache_mem_if_aw_slv_assign(intf, st) \
  ``st``.aw.awid = ``intf``.awid; \
  ``st``.aw.awaddr = ``intf``.awaddr; \
  ``st``.awvalid = ``intf``.awvalid; \
  ``st``.aw.awlen = ``intf``.awlen; \

`define cache_mem_if_aw_slv_wire(intf) \
  cache_mem_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \

`define cache_mem_if_aw_slv_wire_arr(intf, N) \
  cache_mem_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \

`define cache_mem_if_aw_slv_port(intf) \
  input cache_mem_if_aw_t ``intf``_aw, \
  input logic ``intf``_awvalid

`define cache_mem_if_aw_slv_port_arr(intf, N) \
  input cache_mem_if_aw_t ``intf``_aw[``N``], \
  input logic ``intf``_awvalid[``N``]

`define cache_mem_if_aw_slv_port2struct_assign(intf, st) \
  ``st``.aw = ``intf``_aw; \
  ``st``.awvalid = ``intf``_awvalid; \


`define cache_mem_if_aw_slv_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].aw = ``intf``_aw[``N``]; \
  ``st``[``N``].awvalid = ``intf``_awvalid[``N``]; \


`define cache_mem_if_slave_assign(intf, st) \
  ``st``.aw.awid = ``intf``.awid; \
  ``st``.aw.awaddr = ``intf``.awaddr; \
  ``st``.awvalid = ``intf``.awvalid; \
  ``st``.aw.awlen = ``intf``.awlen; \
  ``intf``.awready = ``st``.awready; \
  ``st``.w.wdata = ``intf``.wdata; \
  ``st``.wvalid = ``intf``.wvalid; \
  ``st``.w.wlast = ``intf``.wlast; \
  ``st``.w.wid = ``intf``.wid; \
  ``intf``.wready = ``st``.wready; \
  ``st``.ar.arid = ``intf``.arid; \
  ``st``.ar.arlen = ``intf``.arlen; \
  ``st``.ar.araddr = ``intf``.araddr; \
  ``st``.arvalid = ``intf``.arvalid; \
  ``intf``.arready = ``st``.arready; \
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

`define cache_mem_if_slave_wire(intf) \
  cache_mem_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \
  logic ``intf``_awready; \
  logic ``intf``_wvalid; \
  logic ``intf``_wready; \
  logic ``intf``_arvalid; \
  logic ``intf``_arready; \
  logic ``intf``_rvalid; \
  logic ``intf``_rready; \
  logic ``intf``_bvalid; \
  logic ``intf``_bready; \
  cache_mem_if_w_t ``intf``_w; \
  cache_mem_if_ar_t ``intf``_ar; \
  cache_mem_if_r_t ``intf``_r; \
  cache_mem_if_b_t ``intf``_b; \

`define cache_mem_if_slave_wire_arr(intf, N) \
  cache_mem_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \
  logic ``intf``_awready[``N``]; \
  logic ``intf``_wvalid[``N``]; \
  logic ``intf``_wready[``N``]; \
  logic ``intf``_arvalid[``N``]; \
  logic ``intf``_arready[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic ``intf``_rready[``N``]; \
  logic ``intf``_bvalid[``N``]; \
  logic ``intf``_bready[``N``]; \
  cache_mem_if_w_t ``intf``_w[``N``]; \
  cache_mem_if_ar_t ``intf``_ar[``N``]; \
  cache_mem_if_r_t ``intf``_r[``N``]; \
  cache_mem_if_b_t ``intf``_b[``N``]; \

`define cache_mem_if_slave_port(intf) \
  input cache_mem_if_aw_t ``intf``_aw, \
  input logic ``intf``_awvalid, \
  output logic ``intf``_awready, \
  input logic ``intf``_wvalid, \
  output logic ``intf``_wready, \
  input logic ``intf``_arvalid, \
  output logic ``intf``_arready, \
  output logic ``intf``_rvalid, \
  input logic ``intf``_rready, \
  output logic ``intf``_bvalid, \
  input logic ``intf``_bready, \
  input cache_mem_if_w_t ``intf``_w, \
  input cache_mem_if_ar_t ``intf``_ar, \
  output cache_mem_if_r_t ``intf``_r, \
  output cache_mem_if_b_t ``intf``_b

`define cache_mem_if_slave_port_arr(intf, N) \
  input cache_mem_if_aw_t ``intf``_aw[``N``], \
  input logic ``intf``_awvalid[``N``], \
  output logic ``intf``_awready[``N``], \
  input logic ``intf``_wvalid[``N``], \
  output logic ``intf``_wready[``N``], \
  input logic ``intf``_arvalid[``N``], \
  output logic ``intf``_arready[``N``], \
  output logic ``intf``_rvalid[``N``], \
  input logic ``intf``_rready[``N``], \
  output logic ``intf``_bvalid[``N``], \
  input logic ``intf``_bready[``N``], \
  input cache_mem_if_w_t ``intf``_w[``N``], \
  input cache_mem_if_ar_t ``intf``_ar[``N``], \
  output cache_mem_if_r_t ``intf``_r[``N``], \
  output cache_mem_if_b_t ``intf``_b[``N``]

`define cache_mem_if_slave_port2struct_assign(intf, st) \
  ``st``.aw = ``intf``_aw; \
  ``st``.awvalid = ``intf``_awvalid; \
  ``intf``_awready = ``st``.awready; \
  ``st``.wvalid = ``intf``_wvalid; \
  ``intf``_wready = ``st``.wready; \
  ``st``.arvalid = ``intf``_arvalid; \
  ``intf``_arready = ``st``.arready; \
  ``intf``_rvalid = ``st``.rvalid; \
  ``st``.rready = ``intf``_rready; \
  ``intf``_bvalid = ``st``.bvalid; \
  ``st``.bready = ``intf``_bready; \
  ``st``.w = ``intf``_w; \
  ``st``.ar = ``intf``_ar; \
  ``intf``_r = ``st``.r; \
  ``intf``_b = ``st``.b; \


`define cache_mem_if_slave_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].aw = ``intf``_aw[``N``]; \
  ``st``[``N``].awvalid = ``intf``_awvalid[``N``]; \
  ``intf``_awready[``N``] = ``st``[``N``].awready; \
  ``st``[``N``].wvalid = ``intf``_wvalid[``N``]; \
  ``intf``_wready[``N``] = ``st``[``N``].wready; \
  ``st``[``N``].arvalid = ``intf``_arvalid[``N``]; \
  ``intf``_arready[``N``] = ``st``[``N``].arready; \
  ``intf``_rvalid[``N``] = ``st``[``N``].rvalid; \
  ``st``[``N``].rready = ``intf``_rready[``N``]; \
  ``intf``_bvalid[``N``] = ``st``[``N``].bvalid; \
  ``st``[``N``].bready = ``intf``_bready[``N``]; \
  ``st``[``N``].w = ``intf``_w[``N``]; \
  ``st``[``N``].ar = ``intf``_ar[``N``]; \
  ``intf``_r[``N``] = ``st``[``N``].r; \
  ``intf``_b[``N``] = ``st``[``N``].b; \


`define cache_mem_if_aw_mstr_assign(intf, st) \
  ``intf``.awid = ``st``.aw.awid; \
  ``intf``.awaddr = ``st``.aw.awaddr; \
  ``intf``.awvalid = ``st``.awvalid; \
  ``intf``.awlen = ``st``.aw.awlen; \

`define cache_mem_if_aw_mstr_wire(intf) \
  cache_mem_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \

`define cache_mem_if_aw_mstr_wire_arr(intf, N) \
  cache_mem_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \

`define cache_mem_if_aw_mstr_port(intf) \
  output cache_mem_if_aw_t ``intf``_aw, \
  output logic ``intf``_awvalid

`define cache_mem_if_aw_mstr_port_arr(intf, N) \
  output cache_mem_if_aw_t ``intf``_aw[``N``], \
  output logic ``intf``_awvalid[``N``]

`define cache_mem_if_aw_mstr_port2struct_assign(intf, st) \
  ``intf``_aw = ``st``.aw; \
  ``intf``_awvalid = ``st``.awvalid; \


`define cache_mem_if_aw_mstr_port2struct_arr_assign(intf, st, N) \
  ``intf``_aw[``N``] = ``st``[``N``].aw; \
  ``intf``_awvalid[``N``] = ``st``[``N``].awvalid; \


`define cache_mem_if_master_assign(intf, st) \
  ``intf``.awid = ``st``.aw.awid; \
  ``intf``.awaddr = ``st``.aw.awaddr; \
  ``intf``.awvalid = ``st``.awvalid; \
  ``intf``.awlen = ``st``.aw.awlen; \
  ``st``.awready = ``intf``.awready; \
  ``intf``.wdata = ``st``.w.wdata; \
  ``intf``.wvalid = ``st``.wvalid; \
  ``intf``.wlast = ``st``.w.wlast; \
  ``intf``.wid = ``st``.w.wid; \
  ``st``.wready = ``intf``.wready; \
  ``intf``.arid = ``st``.ar.arid; \
  ``intf``.arlen = ``st``.ar.arlen; \
  ``intf``.araddr = ``st``.ar.araddr; \
  ``intf``.arvalid = ``st``.arvalid; \
  ``st``.arready = ``intf``.arready; \
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

`define cache_mem_if_master_wire(intf) \
  cache_mem_if_aw_t ``intf``_aw; \
  logic ``intf``_awvalid; \
  logic ``intf``_awready; \
  logic ``intf``_wvalid; \
  logic ``intf``_wready; \
  logic ``intf``_arvalid; \
  logic ``intf``_arready; \
  logic ``intf``_rvalid; \
  logic ``intf``_rready; \
  logic ``intf``_bvalid; \
  logic ``intf``_bready; \
  cache_mem_if_w_t ``intf``_w; \
  cache_mem_if_ar_t ``intf``_ar; \
  cache_mem_if_r_t ``intf``_r; \
  cache_mem_if_b_t ``intf``_b; \

`define cache_mem_if_master_wire_arr(intf, N) \
  cache_mem_if_aw_t ``intf``_aw[``N``]; \
  logic ``intf``_awvalid[``N``]; \
  logic ``intf``_awready[``N``]; \
  logic ``intf``_wvalid[``N``]; \
  logic ``intf``_wready[``N``]; \
  logic ``intf``_arvalid[``N``]; \
  logic ``intf``_arready[``N``]; \
  logic ``intf``_rvalid[``N``]; \
  logic ``intf``_rready[``N``]; \
  logic ``intf``_bvalid[``N``]; \
  logic ``intf``_bready[``N``]; \
  cache_mem_if_w_t ``intf``_w[``N``]; \
  cache_mem_if_ar_t ``intf``_ar[``N``]; \
  cache_mem_if_r_t ``intf``_r[``N``]; \
  cache_mem_if_b_t ``intf``_b[``N``]; \

`define cache_mem_if_master_port(intf) \
  output cache_mem_if_aw_t ``intf``_aw, \
  output logic ``intf``_awvalid, \
  input logic ``intf``_awready, \
  output logic ``intf``_wvalid, \
  input logic ``intf``_wready, \
  output logic ``intf``_arvalid, \
  input logic ``intf``_arready, \
  input logic ``intf``_rvalid, \
  output logic ``intf``_rready, \
  input logic ``intf``_bvalid, \
  output logic ``intf``_bready, \
  output cache_mem_if_w_t ``intf``_w, \
  output cache_mem_if_ar_t ``intf``_ar, \
  input cache_mem_if_r_t ``intf``_r, \
  input cache_mem_if_b_t ``intf``_b

`define cache_mem_if_master_port_arr(intf, N) \
  output cache_mem_if_aw_t ``intf``_aw[``N``], \
  output logic ``intf``_awvalid[``N``], \
  input logic ``intf``_awready[``N``], \
  output logic ``intf``_wvalid[``N``], \
  input logic ``intf``_wready[``N``], \
  output logic ``intf``_arvalid[``N``], \
  input logic ``intf``_arready[``N``], \
  input logic ``intf``_rvalid[``N``], \
  output logic ``intf``_rready[``N``], \
  input logic ``intf``_bvalid[``N``], \
  output logic ``intf``_bready[``N``], \
  output cache_mem_if_w_t ``intf``_w[``N``], \
  output cache_mem_if_ar_t ``intf``_ar[``N``], \
  input cache_mem_if_r_t ``intf``_r[``N``], \
  input cache_mem_if_b_t ``intf``_b[``N``]

`define cache_mem_if_master_port2struct_assign(intf, st) \
  ``intf``_aw = ``st``.aw; \
  ``intf``_awvalid = ``st``.awvalid; \
  ``st``.awready = ``intf``_awready; \
  ``intf``_wvalid = ``st``.wvalid; \
  ``st``.wready = ``intf``_wready; \
  ``intf``_arvalid = ``st``.arvalid; \
  ``st``.arready = ``intf``_arready; \
  ``st``.rvalid = ``intf``_rvalid; \
  ``intf``_rready = ``st``.rready; \
  ``st``.bvalid = ``intf``_bvalid; \
  ``intf``_bready = ``st``.bready; \
  ``intf``_w = ``st``.w; \
  ``intf``_ar = ``st``.ar; \
  ``st``.r = ``intf``_r; \
  ``st``.b = ``intf``_b; \


`define cache_mem_if_master_port2struct_arr_assign(intf, st, N) \
  ``intf``_aw[``N``] = ``st``[``N``].aw; \
  ``intf``_awvalid[``N``] = ``st``[``N``].awvalid; \
  ``st``[``N``].awready = ``intf``_awready[``N``]; \
  ``intf``_wvalid[``N``] = ``st``[``N``].wvalid; \
  ``st``[``N``].wready = ``intf``_wready[``N``]; \
  ``intf``_arvalid[``N``] = ``st``[``N``].arvalid; \
  ``st``[``N``].arready = ``intf``_arready[``N``]; \
  ``st``[``N``].rvalid = ``intf``_rvalid[``N``]; \
  ``intf``_rready[``N``] = ``st``[``N``].rready; \
  ``st``[``N``].bvalid = ``intf``_bvalid[``N``]; \
  ``intf``_bready[``N``] = ``st``[``N``].bready; \
  ``intf``_w[``N``] = ``st``[``N``].w; \
  ``intf``_ar[``N``] = ``st``[``N``].ar; \
  ``st``[``N``].r = ``intf``_r[``N``]; \
  ``st``[``N``].b = ``intf``_b[``N``]; \


`define cache_mem_if_aw_rdy_mstr_assign(intf, st) \
  ``st``.awready = ``intf``.awready; \

`define cache_mem_if_aw_rdy_mstr_wire(intf) \
  logic ``intf``_awready; \

`define cache_mem_if_aw_rdy_mstr_wire_arr(intf, N) \
  logic ``intf``_awready[``N``]; \

`define cache_mem_if_aw_rdy_mstr_port(intf) \
  input logic ``intf``_awready

`define cache_mem_if_aw_rdy_mstr_port_arr(intf, N) \
  input logic ``intf``_awready[``N``]

`define cache_mem_if_aw_rdy_mstr_port2struct_assign(intf, st) \
  ``st``.awready = ``intf``_awready; \


`define cache_mem_if_aw_rdy_mstr_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].awready = ``intf``_awready[``N``]; \


`define cache_mem_if_aw_rdy_slv_assign(intf, st) \
  ``intf``.awready = ``st``.awready; \

`define cache_mem_if_aw_rdy_slv_wire(intf) \
  logic ``intf``_awready; \

`define cache_mem_if_aw_rdy_slv_wire_arr(intf, N) \
  logic ``intf``_awready[``N``]; \

`define cache_mem_if_aw_rdy_slv_port(intf) \
  output logic ``intf``_awready

`define cache_mem_if_aw_rdy_slv_port_arr(intf, N) \
  output logic ``intf``_awready[``N``]

`define cache_mem_if_aw_rdy_slv_port2struct_assign(intf, st) \
  ``intf``_awready = ``st``.awready; \


`define cache_mem_if_aw_rdy_slv_port2struct_arr_assign(intf, st, N) \
  ``intf``_awready[``N``] = ``st``[``N``].awready; \


`define cache_mem_if_w_slv_assign(intf, st) \
  ``st``.w.wdata = ``intf``.wdata; \
  ``st``.wvalid = ``intf``.wvalid; \
  ``st``.w.wlast = ``intf``.wlast; \
  ``st``.w.wid = ``intf``.wid; \

`define cache_mem_if_w_slv_wire(intf) \
  logic ``intf``_wvalid; \
  cache_mem_if_w_t ``intf``_w; \

`define cache_mem_if_w_slv_wire_arr(intf, N) \
  logic ``intf``_wvalid[``N``]; \
  cache_mem_if_w_t ``intf``_w[``N``]; \

`define cache_mem_if_w_slv_port(intf) \
  input logic ``intf``_wvalid, \
  input cache_mem_if_w_t ``intf``_w

`define cache_mem_if_w_slv_port_arr(intf, N) \
  input logic ``intf``_wvalid[``N``], \
  input cache_mem_if_w_t ``intf``_w[``N``]

`define cache_mem_if_w_slv_port2struct_assign(intf, st) \
  ``st``.wvalid = ``intf``_wvalid; \
  ``st``.w = ``intf``_w; \


`define cache_mem_if_w_slv_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].wvalid = ``intf``_wvalid[``N``]; \
  ``st``[``N``].w = ``intf``_w[``N``]; \


`define cache_mem_if_w_mstr_assign(intf, st) \
  ``intf``.wdata = ``st``.w.wdata; \
  ``intf``.wvalid = ``st``.wvalid; \
  ``intf``.wlast = ``st``.w.wlast; \
  ``intf``.wid = ``st``.w.wid; \

`define cache_mem_if_w_mstr_wire(intf) \
  logic ``intf``_wvalid; \
  cache_mem_if_w_t ``intf``_w; \

`define cache_mem_if_w_mstr_wire_arr(intf, N) \
  logic ``intf``_wvalid[``N``]; \
  cache_mem_if_w_t ``intf``_w[``N``]; \

`define cache_mem_if_w_mstr_port(intf) \
  output logic ``intf``_wvalid, \
  output cache_mem_if_w_t ``intf``_w

`define cache_mem_if_w_mstr_port_arr(intf, N) \
  output logic ``intf``_wvalid[``N``], \
  output cache_mem_if_w_t ``intf``_w[``N``]

`define cache_mem_if_w_mstr_port2struct_assign(intf, st) \
  ``intf``_wvalid = ``st``.wvalid; \
  ``intf``_w = ``st``.w; \


`define cache_mem_if_w_mstr_port2struct_arr_assign(intf, st, N) \
  ``intf``_wvalid[``N``] = ``st``[``N``].wvalid; \
  ``intf``_w[``N``] = ``st``[``N``].w; \


`define cache_mem_if_w_rdy_mstr_assign(intf, st) \
  ``st``.wready = ``intf``.wready; \

`define cache_mem_if_w_rdy_mstr_wire(intf) \
  logic ``intf``_wready; \

`define cache_mem_if_w_rdy_mstr_wire_arr(intf, N) \
  logic ``intf``_wready[``N``]; \

`define cache_mem_if_w_rdy_mstr_port(intf) \
  input logic ``intf``_wready

`define cache_mem_if_w_rdy_mstr_port_arr(intf, N) \
  input logic ``intf``_wready[``N``]

`define cache_mem_if_w_rdy_mstr_port2struct_assign(intf, st) \
  ``st``.wready = ``intf``_wready; \


`define cache_mem_if_w_rdy_mstr_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].wready = ``intf``_wready[``N``]; \


`define cache_mem_if_w_rdy_slv_assign(intf, st) \
  ``intf``.wready = ``st``.wready; \

`define cache_mem_if_w_rdy_slv_wire(intf) \
  logic ``intf``_wready; \

`define cache_mem_if_w_rdy_slv_wire_arr(intf, N) \
  logic ``intf``_wready[``N``]; \

`define cache_mem_if_w_rdy_slv_port(intf) \
  output logic ``intf``_wready

`define cache_mem_if_w_rdy_slv_port_arr(intf, N) \
  output logic ``intf``_wready[``N``]

`define cache_mem_if_w_rdy_slv_port2struct_assign(intf, st) \
  ``intf``_wready = ``st``.wready; \


`define cache_mem_if_w_rdy_slv_port2struct_arr_assign(intf, st, N) \
  ``intf``_wready[``N``] = ``st``[``N``].wready; \


`define cache_mem_if_ar_slv_assign(intf, st) \
  ``st``.ar.arid = ``intf``.arid; \
  ``st``.ar.arlen = ``intf``.arlen; \
  ``st``.ar.araddr = ``intf``.araddr; \
  ``st``.arvalid = ``intf``.arvalid; \

`define cache_mem_if_ar_slv_wire(intf) \
  logic ``intf``_arvalid; \
  cache_mem_if_ar_t ``intf``_ar; \

`define cache_mem_if_ar_slv_wire_arr(intf, N) \
  logic ``intf``_arvalid[``N``]; \
  cache_mem_if_ar_t ``intf``_ar[``N``]; \

`define cache_mem_if_ar_slv_port(intf) \
  input logic ``intf``_arvalid, \
  input cache_mem_if_ar_t ``intf``_ar

`define cache_mem_if_ar_slv_port_arr(intf, N) \
  input logic ``intf``_arvalid[``N``], \
  input cache_mem_if_ar_t ``intf``_ar[``N``]

`define cache_mem_if_ar_slv_port2struct_assign(intf, st) \
  ``st``.arvalid = ``intf``_arvalid; \
  ``st``.ar = ``intf``_ar; \


`define cache_mem_if_ar_slv_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].arvalid = ``intf``_arvalid[``N``]; \
  ``st``[``N``].ar = ``intf``_ar[``N``]; \


`define cache_mem_if_ar_mstr_assign(intf, st) \
  ``intf``.arid = ``st``.ar.arid; \
  ``intf``.arlen = ``st``.ar.arlen; \
  ``intf``.araddr = ``st``.ar.araddr; \
  ``intf``.arvalid = ``st``.arvalid; \

`define cache_mem_if_ar_mstr_wire(intf) \
  logic ``intf``_arvalid; \
  cache_mem_if_ar_t ``intf``_ar; \

`define cache_mem_if_ar_mstr_wire_arr(intf, N) \
  logic ``intf``_arvalid[``N``]; \
  cache_mem_if_ar_t ``intf``_ar[``N``]; \

`define cache_mem_if_ar_mstr_port(intf) \
  output logic ``intf``_arvalid, \
  output cache_mem_if_ar_t ``intf``_ar

`define cache_mem_if_ar_mstr_port_arr(intf, N) \
  output logic ``intf``_arvalid[``N``], \
  output cache_mem_if_ar_t ``intf``_ar[``N``]

`define cache_mem_if_ar_mstr_port2struct_assign(intf, st) \
  ``intf``_arvalid = ``st``.arvalid; \
  ``intf``_ar = ``st``.ar; \


`define cache_mem_if_ar_mstr_port2struct_arr_assign(intf, st, N) \
  ``intf``_arvalid[``N``] = ``st``[``N``].arvalid; \
  ``intf``_ar[``N``] = ``st``[``N``].ar; \


`define cache_mem_if_ar_rdy_mstr_assign(intf, st) \
  ``st``.arready = ``intf``.arready; \

`define cache_mem_if_ar_rdy_mstr_wire(intf) \
  logic ``intf``_arready; \

`define cache_mem_if_ar_rdy_mstr_wire_arr(intf, N) \
  logic ``intf``_arready[``N``]; \

`define cache_mem_if_ar_rdy_mstr_port(intf) \
  input logic ``intf``_arready

`define cache_mem_if_ar_rdy_mstr_port_arr(intf, N) \
  input logic ``intf``_arready[``N``]

`define cache_mem_if_ar_rdy_mstr_port2struct_assign(intf, st) \
  ``st``.arready = ``intf``_arready; \


`define cache_mem_if_ar_rdy_mstr_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].arready = ``intf``_arready[``N``]; \


`define cache_mem_if_ar_rdy_slv_assign(intf, st) \
  ``intf``.arready = ``st``.arready; \

`define cache_mem_if_ar_rdy_slv_wire(intf) \
  logic ``intf``_arready; \

`define cache_mem_if_ar_rdy_slv_wire_arr(intf, N) \
  logic ``intf``_arready[``N``]; \

`define cache_mem_if_ar_rdy_slv_port(intf) \
  output logic ``intf``_arready

`define cache_mem_if_ar_rdy_slv_port_arr(intf, N) \
  output logic ``intf``_arready[``N``]

`define cache_mem_if_ar_rdy_slv_port2struct_assign(intf, st) \
  ``intf``_arready = ``st``.arready; \


`define cache_mem_if_ar_rdy_slv_port2struct_arr_assign(intf, st, N) \
  ``intf``_arready[``N``] = ``st``[``N``].arready; \


`define cache_mem_if_r_slv_assign(intf, st) \
  ``st``.r.rid = ``intf``.rid; \
  ``st``.r.rdata = ``intf``.rdata; \
  ``st``.rvalid = ``intf``.rvalid; \
  ``st``.r.rresp = ``intf``.rresp; \
  ``st``.r.rlast = ``intf``.rlast; \

`define cache_mem_if_r_slv_wire(intf) \
  logic ``intf``_rvalid; \
  cache_mem_if_r_t ``intf``_r; \

`define cache_mem_if_r_slv_wire_arr(intf, N) \
  logic ``intf``_rvalid[``N``]; \
  cache_mem_if_r_t ``intf``_r[``N``]; \

`define cache_mem_if_r_slv_port(intf) \
  input logic ``intf``_rvalid, \
  input cache_mem_if_r_t ``intf``_r

`define cache_mem_if_r_slv_port_arr(intf, N) \
  input logic ``intf``_rvalid[``N``], \
  input cache_mem_if_r_t ``intf``_r[``N``]

`define cache_mem_if_r_slv_port2struct_assign(intf, st) \
  ``st``.rvalid = ``intf``_rvalid; \
  ``st``.r = ``intf``_r; \


`define cache_mem_if_r_slv_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].rvalid = ``intf``_rvalid[``N``]; \
  ``st``[``N``].r = ``intf``_r[``N``]; \


`define cache_mem_if_r_mstr_assign(intf, st) \
  ``intf``.rid = ``st``.r.rid; \
  ``intf``.rdata = ``st``.r.rdata; \
  ``intf``.rvalid = ``st``.rvalid; \
  ``intf``.rresp = ``st``.r.rresp; \
  ``intf``.rlast = ``st``.r.rlast; \

`define cache_mem_if_r_mstr_wire(intf) \
  logic ``intf``_rvalid; \
  cache_mem_if_r_t ``intf``_r; \

`define cache_mem_if_r_mstr_wire_arr(intf, N) \
  logic ``intf``_rvalid[``N``]; \
  cache_mem_if_r_t ``intf``_r[``N``]; \

`define cache_mem_if_r_mstr_port(intf) \
  output logic ``intf``_rvalid, \
  output cache_mem_if_r_t ``intf``_r

`define cache_mem_if_r_mstr_port_arr(intf, N) \
  output logic ``intf``_rvalid[``N``], \
  output cache_mem_if_r_t ``intf``_r[``N``]

`define cache_mem_if_r_mstr_port2struct_assign(intf, st) \
  ``intf``_rvalid = ``st``.rvalid; \
  ``intf``_r = ``st``.r; \


`define cache_mem_if_r_mstr_port2struct_arr_assign(intf, st, N) \
  ``intf``_rvalid[``N``] = ``st``[``N``].rvalid; \
  ``intf``_r[``N``] = ``st``[``N``].r; \


`define cache_mem_if_r_rdy_mstr_assign(intf, st) \
  ``st``.rready = ``intf``.rready; \

`define cache_mem_if_r_rdy_mstr_wire(intf) \
  logic ``intf``_rready; \

`define cache_mem_if_r_rdy_mstr_wire_arr(intf, N) \
  logic ``intf``_rready[``N``]; \

`define cache_mem_if_r_rdy_mstr_port(intf) \
  input logic ``intf``_rready

`define cache_mem_if_r_rdy_mstr_port_arr(intf, N) \
  input logic ``intf``_rready[``N``]

`define cache_mem_if_r_rdy_mstr_port2struct_assign(intf, st) \
  ``st``.rready = ``intf``_rready; \


`define cache_mem_if_r_rdy_mstr_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].rready = ``intf``_rready[``N``]; \


`define cache_mem_if_r_rdy_slv_assign(intf, st) \
  ``intf``.rready = ``st``.rready; \

`define cache_mem_if_r_rdy_slv_wire(intf) \
  logic ``intf``_rready; \

`define cache_mem_if_r_rdy_slv_wire_arr(intf, N) \
  logic ``intf``_rready[``N``]; \

`define cache_mem_if_r_rdy_slv_port(intf) \
  output logic ``intf``_rready

`define cache_mem_if_r_rdy_slv_port_arr(intf, N) \
  output logic ``intf``_rready[``N``]

`define cache_mem_if_r_rdy_slv_port2struct_assign(intf, st) \
  ``intf``_rready = ``st``.rready; \


`define cache_mem_if_r_rdy_slv_port2struct_arr_assign(intf, st, N) \
  ``intf``_rready[``N``] = ``st``[``N``].rready; \


`define cache_mem_if_b_slv_assign(intf, st) \
  ``st``.b.bid = ``intf``.bid; \
  ``st``.b.bresp = ``intf``.bresp; \
  ``st``.bvalid = ``intf``.bvalid; \

`define cache_mem_if_b_slv_wire(intf) \
  logic ``intf``_bvalid; \
  cache_mem_if_b_t ``intf``_b; \

`define cache_mem_if_b_slv_wire_arr(intf, N) \
  logic ``intf``_bvalid[``N``]; \
  cache_mem_if_b_t ``intf``_b[``N``]; \

`define cache_mem_if_b_slv_port(intf) \
  input logic ``intf``_bvalid, \
  input cache_mem_if_b_t ``intf``_b

`define cache_mem_if_b_slv_port_arr(intf, N) \
  input logic ``intf``_bvalid[``N``], \
  input cache_mem_if_b_t ``intf``_b[``N``]

`define cache_mem_if_b_slv_port2struct_assign(intf, st) \
  ``st``.bvalid = ``intf``_bvalid; \
  ``st``.b = ``intf``_b; \


`define cache_mem_if_b_slv_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].bvalid = ``intf``_bvalid[``N``]; \
  ``st``[``N``].b = ``intf``_b[``N``]; \


`define cache_mem_if_b_mstr_assign(intf, st) \
  ``intf``.bid = ``st``.b.bid; \
  ``intf``.bresp = ``st``.b.bresp; \
  ``intf``.bvalid = ``st``.bvalid; \

`define cache_mem_if_b_mstr_wire(intf) \
  logic ``intf``_bvalid; \
  cache_mem_if_b_t ``intf``_b; \

`define cache_mem_if_b_mstr_wire_arr(intf, N) \
  logic ``intf``_bvalid[``N``]; \
  cache_mem_if_b_t ``intf``_b[``N``]; \

`define cache_mem_if_b_mstr_port(intf) \
  output logic ``intf``_bvalid, \
  output cache_mem_if_b_t ``intf``_b

`define cache_mem_if_b_mstr_port_arr(intf, N) \
  output logic ``intf``_bvalid[``N``], \
  output cache_mem_if_b_t ``intf``_b[``N``]

`define cache_mem_if_b_mstr_port2struct_assign(intf, st) \
  ``intf``_bvalid = ``st``.bvalid; \
  ``intf``_b = ``st``.b; \


`define cache_mem_if_b_mstr_port2struct_arr_assign(intf, st, N) \
  ``intf``_bvalid[``N``] = ``st``[``N``].bvalid; \
  ``intf``_b[``N``] = ``st``[``N``].b; \


`define cache_mem_if_b_rdy_mstr_assign(intf, st) \
  ``st``.bready = ``intf``.bready; \

`define cache_mem_if_b_rdy_mstr_wire(intf) \
  logic ``intf``_bready; \

`define cache_mem_if_b_rdy_mstr_wire_arr(intf, N) \
  logic ``intf``_bready[``N``]; \

`define cache_mem_if_b_rdy_mstr_port(intf) \
  input logic ``intf``_bready

`define cache_mem_if_b_rdy_mstr_port_arr(intf, N) \
  input logic ``intf``_bready[``N``]

`define cache_mem_if_b_rdy_mstr_port2struct_assign(intf, st) \
  ``st``.bready = ``intf``_bready; \


`define cache_mem_if_b_rdy_mstr_port2struct_arr_assign(intf, st, N) \
  ``st``[``N``].bready = ``intf``_bready[``N``]; \


`define cache_mem_if_b_rdy_slv_assign(intf, st) \
  ``intf``.bready = ``st``.bready; \

`define cache_mem_if_b_rdy_slv_wire(intf) \
  logic ``intf``_bready; \

`define cache_mem_if_b_rdy_slv_wire_arr(intf, N) \
  logic ``intf``_bready[``N``]; \

`define cache_mem_if_b_rdy_slv_port(intf) \
  output logic ``intf``_bready

`define cache_mem_if_b_rdy_slv_port_arr(intf, N) \
  output logic ``intf``_bready[``N``]

`define cache_mem_if_b_rdy_slv_port2struct_assign(intf, st) \
  ``intf``_bready = ``st``.bready; \


`define cache_mem_if_b_rdy_slv_port2struct_arr_assign(intf, st, N) \
  ``intf``_bready[``N``] = ``st``[``N``].bready; \


interface cache_mem_if (input clk, rstn);
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
  logic [8 - 1 : 0] wstrb;
  logic wready;
  logic arvalid;
  logic arready;
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
  cache_mem_if_aw_t aw;
  cache_mem_if_w_t w;
  cache_mem_if_ar_t ar;
  cache_mem_if_r_t r;
  cache_mem_if_b_t b;
  modport aw_slv (
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
    output rvalid,
    input  rready,
    output bvalid,
    input  bready,
    input  aw,
    input  w,
    input  ar,
    output r,
    output b
  );
  modport aw_mstr (
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
    input  rvalid,
    output rready,
    input  bvalid,
    output bready,
    output aw,
    output w,
    output ar,
    input  r,
    input  b
  );
  modport aw_rdy_mstr (
    input  awready
  );
  modport aw_rdy_slv (
    output awready
  );
  modport w_slv (
    input  wvalid,
    input  wstrb,
    input  w
  );
  modport w_mstr (
    output wvalid,
    output wstrb,
    output w
  );
  modport w_rdy_mstr (
    input  wready
  );
  modport w_rdy_slv (
    output wready
  );
  modport ar_slv (
    input  arvalid,
    input  ar
  );
  modport ar_mstr (
    output arvalid,
    output ar
  );
  modport ar_rdy_mstr (
    input  arready
  );
  modport ar_rdy_slv (
    output arready
  );
  modport r_slv (
    input  rvalid,
    input  r
  );
  modport r_mstr (
    output rvalid,
    output r
  );
  modport r_rdy_mstr (
    input  rready
  );
  modport r_rdy_slv (
    output rready
  );
  modport b_slv (
    input  bvalid,
    input  b
  );
  modport b_mstr (
    output bvalid,
    output b
  );
  modport b_rdy_mstr (
    input  bready
  );
  modport b_rdy_slv (
    output bready
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
    input  wstrb;
    input  wready;
    input  arvalid;
    input  arready;
    input  rvalid;
    input  rready;
    input  bvalid;
    input  bready;
    input  rvalid_d;
    input  bvalid_d;
    input  bready_d;
    input  rready_d;
    input  aw;
    input  w;
    input  ar;
    input  r;
    input  b;
  endclocking
  clocking drv_cb @(posedge clk);
    default output #1ps;
    output awvalid;
    output awready;
    output wvalid;
    output wstrb;
    output wready;
    output arvalid;
    output arready;
    output rvalid;
    output rready;
    output bvalid;
    output bready;
    output aw;
    output w;
    output ar;
    output r;
    output b;
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
