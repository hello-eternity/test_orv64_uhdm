 // Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module orv64_oursring_if_arbiter
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  // icache
  input oursring_req_if_ar_t ic_req_if_ar, 
  input logic ic_req_if_awvalid, 
  output logic ic_req_if_awready, 
  input logic ic_req_if_wvalid, 
  output logic ic_req_if_wready, 
  input logic ic_req_if_arvalid, 
  output logic ic_req_if_arready, 
  input oursring_req_if_w_t ic_req_if_w, 
  input oursring_req_if_aw_t ic_req_if_aw,
  output oursring_resp_if_b_t ic_resp_ppln_if_b, 
  output oursring_resp_if_r_t ic_resp_ppln_if_r, 
  output logic ic_resp_ppln_if_rvalid, 
  input logic ic_resp_ppln_if_rready, 
  output logic ic_resp_ppln_if_bvalid, 
  input logic ic_resp_ppln_if_bready,
  // dcache
  input oursring_req_if_ar_t dc_req_if_ar, 
  input logic dc_req_if_awvalid, 
  output logic dc_req_if_awready, 
  input logic dc_req_if_wvalid, 
  output logic dc_req_if_wready, 
  input logic dc_req_if_arvalid, 
  output logic dc_req_if_arready, 
  input oursring_req_if_w_t dc_req_if_w, 
  input oursring_req_if_aw_t dc_req_if_aw,
  output oursring_resp_if_b_t dc_resp_ppln_if_b, 
  output oursring_resp_if_r_t dc_resp_ppln_if_r, 
  output logic dc_resp_ppln_if_rvalid, 
  input logic dc_resp_ppln_if_rready, 
  output logic dc_resp_ppln_if_bvalid, 
  input logic dc_resp_ppln_if_bready,
  // to port
  output oursring_req_if_ar_t req_ppln_if_ar, 
  output logic req_ppln_if_awvalid, 
  input logic req_ppln_if_awready, 
  output logic req_ppln_if_wvalid, 
  input logic req_ppln_if_wready, 
  output logic req_ppln_if_arvalid, 
  input logic req_ppln_if_arready, 
  output oursring_req_if_w_t req_ppln_if_w, 
  output oursring_req_if_aw_t req_ppln_if_aw,
  input oursring_resp_if_b_t resp_if_b, 
  input oursring_resp_if_r_t resp_if_r, 
  input logic resp_if_rvalid, 
  output logic resp_if_rready, 
  input logic resp_if_bvalid, 
  output logic resp_if_bready,
  // rst & clk
  input   logic           rstn, clk
);

  oursring_req_if_ar_t  tmp_req_ppln_if_ar; 
  logic                 tmp_req_ppln_if_awvalid; 
  logic                 tmp_req_ppln_if_awready; 
  logic                 tmp_req_ppln_if_wvalid; 
  logic                 tmp_req_ppln_if_wready; 
  logic                 tmp_req_ppln_if_arvalid; 
  logic                 tmp_req_ppln_if_arready; 
  oursring_req_if_w_t   tmp_req_ppln_if_w; 
  oursring_req_if_aw_t  tmp_req_ppln_if_aw;
  oursring_resp_if_b_t  tmp_resp_if_b; 
  oursring_resp_if_r_t  tmp_resp_if_r; 
  logic                 tmp_resp_if_rvalid; 
  logic                 tmp_resp_if_rready; 
  logic                 tmp_resp_if_bvalid; 
  logic                 tmp_resp_if_bready;

  // Buf
  ours_vld_rdy_buf #(
    .BACKEND_DOMAIN (ORV64_PD),
    .WIDTH          ($bits(oursring_req_if_aw_t)),
    .DEPTH          (1))
  aw_buf_u (
    .slave_valid  (tmp_req_ppln_if_awvalid),
    .slave_info   (tmp_req_ppln_if_aw),
    .slave_ready  (tmp_req_ppln_if_awready),
    .master_valid (req_ppln_if_awvalid),
    .master_info  (req_ppln_if_aw),
    .master_ready (req_ppln_if_awready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk));

  ours_vld_rdy_buf #(
    .BACKEND_DOMAIN (ORV64_PD),
    .WIDTH          ($bits(oursring_req_if_w_t)),
    .DEPTH          (1))
  w_buf_u (
    .slave_valid  (tmp_req_ppln_if_wvalid),
    .slave_info   (tmp_req_ppln_if_w),
    .slave_ready  (tmp_req_ppln_if_wready),
    .master_valid (req_ppln_if_wvalid),
    .master_info  (req_ppln_if_w),
    .master_ready (req_ppln_if_wready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk));

  ours_vld_rdy_buf #(
    .BACKEND_DOMAIN (ORV64_PD),
    .WIDTH          ($bits(oursring_req_if_ar_t)),
    .DEPTH          (1))
  ar_buf_u (
    .slave_valid  (tmp_req_ppln_if_arvalid),
    .slave_info   (tmp_req_ppln_if_ar),
    .slave_ready  (tmp_req_ppln_if_arready),
    .master_valid (req_ppln_if_arvalid),
    .master_info  (req_ppln_if_ar),
    .master_ready (req_ppln_if_arready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk));

  ours_vld_rdy_buf #(
    .BACKEND_DOMAIN (ORV64_PD),
    .WIDTH          ($bits(oursring_resp_if_b_t)),
    .DEPTH          (1))
  b_buf_u (
    .slave_valid  (resp_if_bvalid),
    .slave_info   (resp_if_b),
    .slave_ready  (resp_if_bready),
    .master_valid (tmp_resp_if_bvalid),
    .master_info  (tmp_resp_if_b),
    .master_ready (tmp_resp_if_bready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk));

  ours_vld_rdy_buf #(
    .BACKEND_DOMAIN (ORV64_PD),
    .WIDTH          ($bits(oursring_resp_if_r_t)),
    .DEPTH          (1))
  r_buf_u (
    .slave_valid  (resp_if_rvalid),
    .slave_info   (resp_if_r),
    .slave_ready  (resp_if_rready),
    .master_valid (tmp_resp_if_rvalid),
    .master_info  (tmp_resp_if_r),
    .master_ready (tmp_resp_if_rready),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk));

  // AW+W (Icache won't send out writes)
  assign tmp_req_ppln_if_awvalid = dc_req_if_awvalid;
  assign tmp_req_ppln_if_wvalid = dc_req_if_wvalid;
  assign tmp_req_ppln_if_aw = dc_req_if_aw;
  assign tmp_req_ppln_if_w = dc_req_if_w;
  assign dc_req_if_awready = tmp_req_ppln_if_awready;
  assign dc_req_if_wready = tmp_req_ppln_if_wready;

  assign ic_req_if_awready = '0;
  assign ic_req_if_wready = '0;
  assign ic_resp_ppln_if_bvalid = '0;

  // AR
  logic [1:0] arvalid;
  logic [1:0] arready;

  assign arvalid[0] = dc_req_if_arvalid;
  assign arvalid[1] = ic_req_if_arvalid;

  ours_vld_rdy_rr_arb #(
  .N_INPUT(2)
  ) sysbus_ar_arb (
    .vld(arvalid),
    .rdy(tmp_req_ppln_if_arready),
    .grt(arready),
    .rstn, 
    .clk
  );

  always_comb begin
    if (arready[0]) begin
      tmp_req_ppln_if_ar = dc_req_if_ar;
      tmp_req_ppln_if_ar.arid[4] = 1'b0;
    end else begin
      tmp_req_ppln_if_ar = ic_req_if_ar;
      tmp_req_ppln_if_ar.arid[4] = 1'b1;
    end
  end

  assign tmp_req_ppln_if_arvalid = |arvalid;

  assign dc_req_if_arready = arready[0] & tmp_req_ppln_if_arready;
  assign ic_req_if_arready = arready[1] & tmp_req_ppln_if_arready;

  always_comb begin
    // R: use rid[4] to select icache and dcache
    ic_resp_ppln_if_r.rid = tmp_resp_if_r.rid;
    ic_resp_ppln_if_r.rdata = tmp_resp_if_r.rdata;
    ic_resp_ppln_if_r.rresp = tmp_resp_if_r.rresp;
    ic_resp_ppln_if_r.rlast = tmp_resp_if_r.rlast;
    dc_resp_ppln_if_r.rid = tmp_resp_if_r.rid;
    dc_resp_ppln_if_r.rdata = tmp_resp_if_r.rdata;
    dc_resp_ppln_if_r.rresp = tmp_resp_if_r.rresp;
    dc_resp_ppln_if_r.rlast = tmp_resp_if_r.rlast;
    dc_resp_ppln_if_rvalid = tmp_resp_if_rvalid & ~tmp_resp_if_r.rid[4];
    ic_resp_ppln_if_rvalid = tmp_resp_if_rvalid & tmp_resp_if_r.rid[4];
    tmp_resp_if_rready = tmp_resp_if_rvalid ? (tmp_resp_if_r.rid[4] ? ic_resp_ppln_if_rready : dc_resp_ppln_if_rready): '0;
    // B: only dcache
    dc_resp_ppln_if_bvalid = tmp_resp_if_bvalid;
    dc_resp_ppln_if_b.bid = tmp_resp_if_b.bid;
    dc_resp_ppln_if_b.bresp = tmp_resp_if_b.bresp;
    tmp_resp_if_bready = dc_resp_ppln_if_bready;
  end

endmodule
