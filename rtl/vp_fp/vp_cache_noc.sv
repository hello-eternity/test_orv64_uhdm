// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module vp_cache_noc
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import vcore_cfg::*;
  import vcore_pkg::*;
(
  // ORV64 cache i/f
  input logic                orv64_cpu_if_req_valid, 
  input cpu_cache_if_req_t   orv64_cpu_if_req, 
  output logic               orv64_cpu_if_req_ready, 
  output logic               orv64_cpu_if_resp_valid, 
  output cpu_cache_if_resp_t orv64_cpu_if_resp, 
  input logic                orv64_cpu_if_resp_ready,

  // VLOAD cache i/f
  input logic                tlb_rd_req_valid, 
  input cpu_cache_if_req_t   tlb_rd_req, 
  output logic               tlb_rd_req_ready, 
  output logic               tlb_rd_resp_valid, 
  output cpu_cache_if_resp_t tlb_rd_resp, 
  input logic                tlb_rd_resp_ready,

  // VSTORE cache i/f
  input logic                tlb_wr_req_valid, 
  input cpu_cache_if_req_t   tlb_wr_req, 
  output logic               tlb_wr_req_ready, 
  //output logic               tlb_wr_resp_valid,  //VSTORE receives no wr resp
  //output cpu_cache_if_resp_t tlb_wr_resp, 
  //input logic                tlb_wr_resp_ready,

  // CPU NOC side
  output logic cache_if_req_valid, 
  output cpu_cache_if_req_t cache_if_req, 
  input logic cache_if_req_ready, 
  input logic cache_if_resp_valid, 
  input cpu_cache_if_resp_t cache_if_resp, 
  output logic cache_if_resp_ready,

  input rstn, clk
);

  logic                [2:0] cpu_if_req_valid;
  cpu_cache_if_req_t   [2:0] cpu_if_req;
  logic                [2:0] cpu_if_req_ready;

  logic               cache_if_resp_valid_buf_o;
  cpu_cache_if_resp_t cache_if_resp_info_buf_o;
  logic               cache_if_resp_ready_buf_o;

  assign cpu_if_req_valid[0]      = orv64_cpu_if_req_valid;
  assign cpu_if_req[0]            = orv64_cpu_if_req;
  assign orv64_cpu_if_req_ready   = cpu_if_req_ready[0];

  assign cpu_if_req_valid[1]  = tlb_wr_req_valid;
  assign cpu_if_req[1]        = tlb_wr_req;
  assign tlb_wr_req_ready     = cpu_if_req_ready[1];

  assign cpu_if_req_valid[2]  = tlb_rd_req_valid;
  assign cpu_if_req[2]        = tlb_rd_req;
  assign tlb_rd_req_ready     = cpu_if_req_ready[2];

  ours_vld_rdy_rr_arb_buf #(
    .BACKEND_DOMAIN(VCORE_PD),
    .N_INPUT(3),
    .WIDTH($bits(cpu_cache_if_req_t)),
    .BUF_IN_DEPTH(2),
    .BUF_OUT_DEPTH(0)
  ) req_arb_buf_u (
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

  ours_vld_rdy_buf #(
    .BACKEND_DOMAIN( VCORE_PD ),
    .WIDTH($bits(cpu_cache_if_resp_t)),
    .DEPTH(2)
  ) resp_buf_u (
    .slave_valid  (cache_if_resp_valid),
    .slave_info   (cache_if_resp),
    .slave_ready  (cache_if_resp_ready),
    .master_valid (cache_if_resp_valid_buf_o),
    .master_info  (cache_if_resp_info_buf_o),
    .master_ready (cache_if_resp_ready_buf_o),
    .clk_en       (),
    .rstn         (rstn),
    .clk          (clk)
  );

  assign orv64_cpu_if_resp    = cache_if_resp_info_buf_o;
  assign tlb_rd_resp          = cache_if_resp_info_buf_o;

  always_comb begin
    orv64_cpu_if_resp_valid = '0;
    tlb_rd_resp_valid = '0;
    cache_if_resp_ready_buf_o = '0;
    if (cache_if_resp_valid_buf_o) begin
      if (cache_if_resp_info_buf_o.resp_tid.src == VP_VLOAD_SRC_ID) begin
        tlb_rd_resp_valid = '1;
        cache_if_resp_ready_buf_o = tlb_rd_resp_ready;
      end else begin
        orv64_cpu_if_resp_valid = '1;
        cache_if_resp_ready_buf_o = orv64_cpu_if_resp_ready;
      end
    end
  end

endmodule
