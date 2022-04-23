// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// this is just a store buffer for now
module orv64_storebuf_bypass
  import common_pkg::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  // orv interface
  input   ex2dc_t   ex2dc,
  output  dc2ma_t   dc2ma,
  input   logic     flush,

  // L2 cpu noc interface
  output  cpu_cache_if_req_t  cpu_req,
  output  logic               cpu_req_valid,
  input   logic               cpu_req_ready,

  input   l2cache_vls_cfg::cpu_resp_t cpu_resp,
  input   logic      cpu_resp_valid,
  output  logic      cpu_resp_ready,

  input             rstn, clk
);

  // TODO: Separate Sequencial and Combinational
  logic rff_req_sent;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_req_sent <= 1'b0;
    end else if (cpu_req_valid & cpu_req_ready) begin
      rff_req_sent <= 1'b1;
    end else if (cpu_resp_valid & cpu_resp_ready) begin
      rff_req_sent <= 1'b0;
    end
  end

  paddr_t     req_addr;
  cache_ofs_t req_ofs;
  assign req_addr = ex2dc.addr & {CACHE_OFFSET_WIDTH{1'b0}};
  assign req_ofs  = ex2dc.addr[CACHE_OFFSET_WIDTH - 1 : 3]; // TODO

  assign cpu_req_valid      = (ex2dc.re | ex2dc.we) & ~rff_req_sent;
  assign cpu_req.req_paddr  = req_addr;
  always_comb begin
    case (req_ofs)
      ($bits(cache_ofs_t))'d0: begin
        cpu_req.req_data    = {64'h0, 64'h0, 64'h0, ex2dc.wdata};
        cpu_req.req_mask    = { 8'h0,  8'h0,  8'h0, ex2dc.mask };
      end
      ($bits(cache_ofs_t))'d1: begin
        cpu_req.req_data    = {64'h0, 64'h0, ex2dc.wdata, 64'h0};
        cpu_req.req_mask    = { 8'h0,  8'h0, ex2dc.mask ,  8'h0};
      end
      ($bits(cache_ofs_t))'d2: begin
        cpu_req.req_data    = {64'h0, ex2dc.wdata, 64'h0, 64'h0};
        cpu_req.req_mask    = { 8'h0, ex2dc.mask ,  8'h0,  8'h0};
      end
      default: begin
        cpu_req.req_data    = {ex2dc.wdata, 64'h0, 64'h0, 64'h0};
        cpu_req.req_mask    = {ex2dc.mask ,  8'h0,  8'h0,  8'h0};
      end
    endcase
  end
  assign cpu_req.req_tid    = '1;
  always_comb begin
    case ({ex2dc.re, ex2dc.we})
      2'b10:    cpu_req.req_type = REQ_READ;
      default:  cpu_req.req_type = REQ_WRITE;
    endcase
  end

  assign cpu_resp_ready = 1'b1;

  assign dc2ma.valid  = cpu_resp_valid;
  assign dc2ma.rdata  = cpu_resp.resp_data[{req_ofs, 6'b0} +: 64]; // TODO

endmodule

