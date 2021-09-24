// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module oursring_req_ppln
  import pygmy_intf_typedef::*;
(
  input oursring_req_if_ar_t i_req_if_ar, 
  input logic i_req_if_awvalid, 
  output logic i_req_if_awready, 
  input logic i_req_if_wvalid, 
  output logic i_req_if_wready, 
  input logic i_req_if_arvalid, 
  output logic i_req_if_arready, 
  input oursring_req_if_w_t i_req_if_w, 
  input oursring_req_if_aw_t i_req_if_aw,
  output oursring_req_if_ar_t o_req_if_ar, 
  output logic o_req_if_awvalid, 
  input logic o_req_if_awready, 
  output logic o_req_if_wvalid, 
  input logic o_req_if_wready, 
  output logic o_req_if_arvalid, 
  input logic o_req_if_arready, 
  output oursring_req_if_w_t o_req_if_w, 
  output oursring_req_if_aw_t o_req_if_aw,
  input   logic           rstn, clk
);
  oursring_req_if_t       req, req_ppln;
  always_comb begin
  req.ar = i_req_if_ar; 
  req.awvalid = i_req_if_awvalid; 
  i_req_if_awready = req.awready; 
  req.wvalid = i_req_if_wvalid; 
  i_req_if_wready = req.wready; 
  req.arvalid = i_req_if_arvalid; 
  i_req_if_arready = req.arready; 
  req.w = i_req_if_w; 
  req.aw = i_req_if_aw; 
  o_req_if_ar = req_ppln.ar; 
  o_req_if_awvalid = req_ppln.awvalid; 
  req_ppln.awready = o_req_if_awready; 
  o_req_if_wvalid = req_ppln.wvalid; 
  req_ppln.wready = o_req_if_wready; 
  o_req_if_arvalid = req_ppln.arvalid; 
  req_ppln.arready = o_req_if_arready; 
  o_req_if_w = req_ppln.w; 
  o_req_if_aw = req_ppln.aw; 
  end
  sd_ppln #(.WIDTH($bits(oursring_req_if_aw_t))) sd_ppln_aw_u (
    .s_valid  (req.awvalid),
    .s_data   (req.aw),
    .s_ready  (req.awready),
    .d_valid  (req_ppln.awvalid),
    .d_data   (req_ppln.aw),
    .d_ready  (req_ppln.awready),
    .*);
  sd_ppln #(.WIDTH($bits(oursring_req_if_w_t))) sd_ppln_w_u (
    .s_valid  (req.wvalid),
    .s_data   (req.w),
    .s_ready  (req.wready),
    .d_valid  (req_ppln.wvalid),
    .d_data   (req_ppln.w),
    .d_ready  (req_ppln.wready),
    .*);
  sd_ppln #(.WIDTH($bits(oursring_req_if_ar_t))) sd_ppln_ar_u (
    .s_valid  (req.arvalid),
    .s_data   (req.ar),
    .s_ready  (req.arready),
    .d_valid  (req_ppln.arvalid),
    .d_data   (req_ppln.ar),
    .d_ready  (req_ppln.arready),
    .*);
endmodule
