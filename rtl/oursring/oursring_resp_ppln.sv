// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
module oursring_resp_ppln
  import pygmy_intf_typedef::*;
  #(parameter int BACKEND_DMAIN = 0)
(
  input oursring_resp_if_b_t i_resp_if_b, 
  input oursring_resp_if_r_t i_resp_if_r, 
  input logic i_resp_if_rvalid, 
  output logic i_resp_if_rready, 
  input logic i_resp_if_bvalid, 
  output logic i_resp_if_bready,
  output oursring_resp_if_b_t o_resp_if_b, 
  output oursring_resp_if_r_t o_resp_if_r, 
  output logic o_resp_if_rvalid, 
  input logic o_resp_if_rready, 
  output logic o_resp_if_bvalid, 
  input logic o_resp_if_bready,
  input   logic           rstn, clk
);
  oursring_resp_if_t       resp, resp_ppln;
  always_comb begin
  resp.b = i_resp_if_b; 
  resp.r = i_resp_if_r; 
  resp.rvalid = i_resp_if_rvalid; 
  i_resp_if_rready = resp.rready; 
  resp.bvalid = i_resp_if_bvalid; 
  i_resp_if_bready = resp.bready; 
  o_resp_if_b = resp_ppln.b; 
  o_resp_if_r = resp_ppln.r; 
  o_resp_if_rvalid = resp_ppln.rvalid; 
  resp_ppln.rready = o_resp_if_rready; 
  o_resp_if_bvalid = resp_ppln.bvalid; 
  resp_ppln.bready = o_resp_if_bready; 
  end
  sd_ppln #(.WIDTH($bits(oursring_resp_if_r_t))) sd_ppln_r_u (
    .s_valid  (resp.rvalid),
    .s_data   (resp.r),
    .s_ready  (resp.rready),
    .d_valid  (resp_ppln.rvalid),
    .d_data   (resp_ppln.r),
    .d_ready  (resp_ppln.rready),
    .*);
  sd_ppln #(.WIDTH($bits(oursring_resp_if_b_t))) sd_ppln_b_u (
    .s_valid  (resp.bvalid),
    .s_data   (resp.b),
    .s_ready  (resp.bready),
    .d_valid  (resp_ppln.bvalid),
    .d_data   (resp_ppln.b),
    .d_ready  (resp_ppln.bready),
    .*);
endmodule
