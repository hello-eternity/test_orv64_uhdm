//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
//Date        : Thu Nov 14 15:35:32 2019
//Host        : ours-nfs running 64-bit CentOS Linux release 7.7.1908 (Core)
//Command     : generate_target jtag_wrapper.bd
//Design      : jtag_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module jtag_wrapper
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  input                       aclk,
  input                       reset, //active low
  output                      or_req_awvalid,
  output oursring_req_if_aw_t or_req_aw,
  input                       or_req_awready,
  output                      or_req_wvalid,
  output oursring_req_if_w_t  or_req_w,
  input                       or_req_wready,
  input                       or_rsp_bvalid,
  input oursring_resp_if_b_t  or_rsp_b,
  output                      or_rsp_bready,
  output                      or_req_arvalid,
  output oursring_req_if_ar_t or_req_ar,
  input                       or_req_arready,
  input                       or_rsp_rvalid,
  input oursring_resp_if_r_t  or_rsp_r,
  output                      or_rsp_rready,
  output                      rstblk_out
);

  wire [39:0]axi2or_araddr;
  wire [1:0]axi2or_arburst;
  wire [3:0]axi2or_arcache;
  wire [7:0]axi2or_arlen;
  wire [0:0]axi2or_arlock;
  wire [2:0]axi2or_arprot;
  wire [3:0]axi2or_arqos;
  wire axi2or_arready;
  wire [2:0]axi2or_arsize;
  wire axi2or_arvalid;
  wire [39:0]axi2or_awaddr;
  wire [1:0]axi2or_awburst;
  wire [3:0]axi2or_awcache;
  wire [7:0]axi2or_awlen;
  wire [0:0]axi2or_awlock;
  wire [2:0]axi2or_awprot;
  wire [3:0]axi2or_awqos;
  wire axi2or_awready;
  wire [2:0]axi2or_awsize;
  wire axi2or_awvalid;
  wire axi2or_bready;
  wire [1:0]axi2or_bresp;
  wire axi2or_bvalid;
  wire [63:0]axi2or_rdata;
  wire axi2or_rlast;
  wire axi2or_rready;
  wire [1:0]axi2or_rresp;
  wire axi2or_rvalid;
  wire [63:0]axi2or_wdata;
  wire axi2or_wlast;
  wire axi2or_wready;
  wire [7:0]axi2or_wstrb;
  wire axi2or_wvalid;
  wire [39:0]axi_reset_araddr;
  wire [1:0]axi_reset_arburst;
  wire [3:0]axi_reset_arcache;
  wire [7:0]axi_reset_arlen;
  wire [0:0]axi_reset_arlock;
  wire [2:0]axi_reset_arprot;
  wire [3:0]axi_reset_arqos;
  wire axi_reset_arready;
  wire [2:0]axi_reset_arsize;
  wire axi_reset_arvalid;
  wire [39:0]axi_reset_awaddr;
  wire [1:0]axi_reset_awburst;
  wire [3:0]axi_reset_awcache;
  wire [7:0]axi_reset_awlen;
  wire [0:0]axi_reset_awlock;
  wire [2:0]axi_reset_awprot;
  wire [3:0]axi_reset_awqos;
  wire axi_reset_awready;
  wire [2:0]axi_reset_awsize;
  wire axi_reset_awvalid;
  wire axi_reset_bready;
  wire [1:0]axi_reset_bresp;
  wire axi_reset_bvalid;
  wire [63:0]axi_reset_rdata;
  wire axi_reset_rlast;
  wire axi_reset_rready;
  wire [1:0]axi_reset_rresp;
  wire axi_reset_rvalid;
  wire [63:0]axi_reset_wdata;
  wire axi_reset_wlast;
  wire axi_reset_wready;
  wire [7:0]axi_reset_wstrb;
  wire axi_reset_wvalid;

  reset_block reset_block_u(
    .rstblk_out      (rstblk_out),
    .S_AXI_ACLK      (aclk),
    .S_AXI_ARESETN   (reset),
    // AXI
    .S_AXI_ARADDR    (axi_reset_araddr),
    .S_AXI_ARBURST   (axi_reset_arburst),
    .S_AXI_ARCACHE   (axi_reset_arcache),
    .S_AXI_ARLEN     (axi_reset_arlen),
    .S_AXI_ARLOCK    (axi_reset_arlock),
    .S_AXI_ARPROT    (axi_reset_arprot),
    .S_AXI_ARQOS     (axi_reset_arqos),
    .S_AXI_ARREADY   (axi_reset_arready),
    .S_AXI_ARREGION  (4'b0),
    .S_AXI_ARSIZE    (axi_reset_arsize),
    .S_AXI_ARVALID   (axi_reset_arvalid),
    .S_AXI_AWADDR    (axi_reset_awaddr),
    .S_AXI_AWBURST   (axi_reset_awburst),
    .S_AXI_AWCACHE   (axi_reset_awcache),
    .S_AXI_AWLEN     (axi_reset_awlen),
    .S_AXI_AWLOCK    (axi_reset_awlock),
    .S_AXI_AWPROT    (axi_reset_awprot),
    .S_AXI_AWQOS     (axi_reset_awqos),
    .S_AXI_AWREADY   (axi_reset_awready),
    .S_AXI_AWREGION  (4'b0),
    .S_AXI_AWSIZE    (axi_reset_awsize),
    .S_AXI_AWVALID   (axi_reset_awvalid),
    .S_AXI_BREADY    (axi_reset_bready),
    .S_AXI_BRESP     (axi_reset_bresp),
    .S_AXI_BVALID    (axi_reset_bvalid),
    .S_AXI_RDATA     (axi_reset_rdata),
    .S_AXI_RLAST     (axi_reset_rlast),
    .S_AXI_RREADY    (axi_reset_rready),
    .S_AXI_RRESP     (axi_reset_rresp),
    .S_AXI_RVALID    (axi_reset_rvalid),
    .S_AXI_WDATA     (axi_reset_wdata),
    .S_AXI_WLAST     (axi_reset_wlast),
    .S_AXI_WREADY    (axi_reset_wready),
    .S_AXI_WSTRB     (axi_reset_wstrb),
    .S_AXI_WVALID    (axi_reset_wvalid),
    .S_AXI_ARID      (16'b0),
    .S_AXI_AWID      (16'b0),
    .S_AXI_BID       (),
    .S_AXI_RID       (),
    .S_AXI_ARUSER    (16'b0),
    .S_AXI_AWUSER    (16'b0),
    .S_AXI_WUSER     (16'b0),
    .S_AXI_RUSER     (),
    .S_AXI_BUSER     ()
  );

  fpga_jtag2or fgpa_jtag2or_u(
    .axi2or_awvalid,
    .axi2or_awaddr,
    .axi2or_awburst,
    .axi2or_awlen,
    .axi2or_awsize,
    .axi2or_awready,
    .axi2or_wvalid,
    .axi2or_wdata,
    .axi2or_wstrb,
    .axi2or_wlast,
    .axi2or_wready,
    .axi2or_bvalid,
    .axi2or_bresp,
    .axi2or_bready,
    .axi2or_arvalid,
    .axi2or_araddr,
    .axi2or_arburst,
    .axi2or_arlen,
    .axi2or_arsize,
    .axi2or_arready,
    .axi2or_rvalid,
    .axi2or_rdata,
    .axi2or_rresp,
    .axi2or_rlast,
    .axi2or_rready,
    .or_req_awvalid,
    .or_req_wvalid,
    .or_req_arvalid,
    .or_req_ar,
    .or_req_aw,
    .or_req_w,
    .or_req_arready,
    .or_req_wready,
    .or_req_awready,
    .or_rsp_b,
    .or_rsp_r,
    .or_rsp_rvalid,
    .or_rsp_rready,
    .or_rsp_bvalid,
    .or_rsp_bready,
    .clk(aclk),
    .rstn(reset)
);

`ifndef TB_USE_AXI2OR_AGT
  jtag jtag_i
       (.aclk(aclk),
        .axi2or_araddr(axi2or_araddr),
        .axi2or_arburst(axi2or_arburst),
        .axi2or_arcache(axi2or_arcache),
        .axi2or_arlen(axi2or_arlen),
        .axi2or_arlock(axi2or_arlock),
        .axi2or_arprot(axi2or_arprot),
        .axi2or_arqos(axi2or_arqos),
        .axi2or_arready(axi2or_arready),
        .axi2or_arsize(axi2or_arsize),
        .axi2or_arvalid(axi2or_arvalid),
        .axi2or_awaddr(axi2or_awaddr),
        .axi2or_awburst(axi2or_awburst),
        .axi2or_awcache(axi2or_awcache),
        .axi2or_awlen(axi2or_awlen),
        .axi2or_awlock(axi2or_awlock),
        .axi2or_awprot(axi2or_awprot),
        .axi2or_awqos(axi2or_awqos),
        .axi2or_awready(axi2or_awready),
        .axi2or_awsize(axi2or_awsize),
        .axi2or_awvalid(axi2or_awvalid),
        .axi2or_bready(axi2or_bready),
        .axi2or_bresp(axi2or_bresp),
        .axi2or_bvalid(axi2or_bvalid),
        .axi2or_rdata(axi2or_rdata),
        .axi2or_rlast(axi2or_rlast),
        .axi2or_rready(axi2or_rready),
        .axi2or_rresp(axi2or_rresp),
        .axi2or_rvalid(axi2or_rvalid),
        .axi2or_wdata(axi2or_wdata),
        .axi2or_wlast(axi2or_wlast),
        .axi2or_wready(axi2or_wready),
        .axi2or_wstrb(axi2or_wstrb),
        .axi2or_wvalid(axi2or_wvalid),
        .axi_reset_araddr(axi_reset_araddr),
        .axi_reset_arburst(axi_reset_arburst),
        .axi_reset_arcache(axi_reset_arcache),
        .axi_reset_arlen(axi_reset_arlen),
        .axi_reset_arlock(axi_reset_arlock),
        .axi_reset_arprot(axi_reset_arprot),
        .axi_reset_arqos(axi_reset_arqos),
        .axi_reset_arready(axi_reset_arready),
        .axi_reset_arsize(axi_reset_arsize),
        .axi_reset_arvalid(axi_reset_arvalid),
        .axi_reset_awaddr(axi_reset_awaddr),
        .axi_reset_awburst(axi_reset_awburst),
        .axi_reset_awcache(axi_reset_awcache),
        .axi_reset_awlen(axi_reset_awlen),
        .axi_reset_awlock(axi_reset_awlock),
        .axi_reset_awprot(axi_reset_awprot),
        .axi_reset_awqos(axi_reset_awqos),
        .axi_reset_awready(axi_reset_awready),
        .axi_reset_awsize(axi_reset_awsize),
        .axi_reset_awvalid(axi_reset_awvalid),
        .axi_reset_bready(axi_reset_bready),
        .axi_reset_bresp(axi_reset_bresp),
        .axi_reset_bvalid(axi_reset_bvalid),
        .axi_reset_rdata(axi_reset_rdata),
        .axi_reset_rlast(axi_reset_rlast),
        .axi_reset_rready(axi_reset_rready),
        .axi_reset_rresp(axi_reset_rresp),
        .axi_reset_rvalid(axi_reset_rvalid),
        .axi_reset_wdata(axi_reset_wdata),
        .axi_reset_wlast(axi_reset_wlast),
        .axi_reset_wready(axi_reset_wready),
        .axi_reset_wstrb(axi_reset_wstrb),
        .axi_reset_wvalid(axi_reset_wvalid),
        .reset(reset)
    );
`endif

endmodule
