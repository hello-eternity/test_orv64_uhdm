// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_mem_breakpoint
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_typedef_pkg::*;
(
  input   orv64_vaddr_t   bp_mem_addr_0, bp_mem_addr_1, bp_mem_addr_2, bp_mem_addr_3,
  input   orv64_bp_mem_cfg_t  bp_mem_cfg_0,
  input   orv64_bp_mem_cfg_t  bp_mem_cfg_1,
  input   orv64_bp_mem_cfg_t  bp_mem_cfg_2,
  input   orv64_bp_mem_cfg_t  bp_mem_cfg_3,

  input   orv64_ex2dc_t   ex_in,
  output  orv64_ex2dc_t   dc_out,
  
  input   logic           debug_resume,
  output  logic           mem_bp_stall_out
);

  orv64_vaddr_t ex_in_addr;
  logic         is_req_valid;
  logic [3:0]   mem_addr_match;
  logic         is_bp_match;
  logic         mem_bp_stall;

  orv64_bp_mem_cfg_t  [3:0] bp_cfg;
  logic               [3:0] cfg_match;

  assign is_req_valid = ex_in.we | ex_in.re;

  assign ex_in_addr = ex_in.addr;

  assign bp_cfg[0] = bp_mem_cfg_0;
  assign bp_cfg[1] = bp_mem_cfg_1;
  assign bp_cfg[2] = bp_mem_cfg_2;
  assign bp_cfg[3] = bp_mem_cfg_3;

  generate
    for (genvar i=0; i<4; i++) begin
      always_comb begin
        case (bp_cfg[i])
          ORV64_BP_READ : cfg_match[i] = ex_in.re;
          ORV64_BP_WRITE: cfg_match[i] = ex_in.we;
          ORV64_BP_RW   : cfg_match[i] = ex_in.we | ex_in.re;
          default:        cfg_match[i] = 1'b0;
        endcase
      end
    end
  endgenerate

  assign mem_addr_match[0] = cfg_match[0] & (bp_mem_addr_0 == ex_in_addr);
  assign mem_addr_match[1] = cfg_match[1] & (bp_mem_addr_1 == ex_in_addr);
  assign mem_addr_match[2] = cfg_match[2] & (bp_mem_addr_2 == ex_in_addr);
  assign mem_addr_match[3] = cfg_match[3] & (bp_mem_addr_3 == ex_in_addr);

  assign is_bp_match = (|mem_addr_match);

  assign mem_bp_stall_out  = is_req_valid & is_bp_match;
  assign bp_stall          = mem_bp_stall_out & ~debug_resume;

  assign dc_out.we = ex_in.we & ~bp_stall;
  assign dc_out.re = ex_in.re & ~bp_stall;
  assign dc_out.lr = ex_in.lr;
  assign dc_out.sc = ex_in.sc;
  assign dc_out.amo_store = ex_in.amo_store;
  assign dc_out.amo_load = ex_in.amo_load;
  assign dc_out.aq_rl = ex_in.aq_rl;
  assign dc_out.addr = ex_in.addr;
  assign dc_out.mask = ex_in.mask;
  assign dc_out.wdata = ex_in.wdata;
  assign dc_out.width = ex_in.width;

endmodule
