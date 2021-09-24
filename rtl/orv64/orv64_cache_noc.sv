// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_cache_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter N_REQ = 5
)
(
  // Requester side
  input logic                [N_REQ-1:0] cpu_if_req_valid, 
  input cpu_cache_if_req_t   [N_REQ-1:0] cpu_if_req, 
  output logic               [N_REQ-1:0] cpu_if_req_ready, 
  output logic               [N_REQ-1:0] cpu_if_resp_valid, 
  output cpu_cache_if_resp_t [N_REQ-1:0] cpu_if_resp, 
  input logic                [N_REQ-1:0] cpu_if_resp_ready,

  // CPU NOC side
  output logic cache_if_req_valid, 
  output cpu_cache_if_req_t cache_if_req, 
  input logic cache_if_req_ready, 
  input logic cache_if_resp_valid, 
  input cpu_cache_if_resp_t cache_if_resp, 
  output logic cache_if_resp_ready,

  input rstn, clk
);

  ours_vld_rdy_rr_arb_buf #(
    .BACKEND_DOMAIN(ORV64_PD),
    .N_INPUT(N_REQ),
    .WIDTH($bits(cpu_cache_if_req_t)),
    .BUF_IN_DEPTH(0),
    .BUF_OUT_DEPTH(0)
  ) rr_arb_u (
    .slave_valid(cpu_if_req_valid),
    .slave_info(cpu_if_req),
    .slave_ready(cpu_if_req_ready),
    .master_valid(cache_if_req_valid),
    .master_info(cache_if_req),
    .master_ready(cache_if_req_ready),
    .clk_en(),
    .rstn, 
    .clk
  );

  generate
    for (genvar i=0; i<N_REQ; i++) begin
      assign cpu_if_resp_valid[i] = cache_if_resp_valid ? (cache_if_resp.resp_tid.src == CPUNOC_TID_SRCID_SIZE'(i)): '0;
      assign cpu_if_resp[i]       = cache_if_resp;
    end
  endgenerate

  assign cache_if_resp_ready = cache_if_resp_valid ? cpu_if_resp_ready[cache_if_resp.resp_tid.src]: '0;

endmodule
