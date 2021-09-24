// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// TODO: add tvm

program orv64_fetch_assertions
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
(
  // IF -> ID
  output  orv64_if2id_t       if2id_ff,
  output  orv64_if2id_ctrl_t  if2id_ctrl_ff,
  output  orv64_excp_t        if2id_excp_ff,
  // IF -> Regfile
  output  orv64_if2irf_t      if2irf,
  `ifdef ORV64_SUPPORT_FP
  output  orv64_if2fprf_t     if2fprf,
  `endif
  // IF -> L1I$
  output  orv64_if2ic_t       if2ic,
  input   orv64_ic2if_t       ic2if,
  // next PC
  input   orv64_npc_t         ex2if_npc, cs2if_npc,
  input   logic         ma2if_npc_valid,
  input   logic         branch_solved,
  // pipeline ctrl
  input   logic         if_stall, if_kill,
  input   logic         id_ready,
  output  logic         if_ready, if_valid, if_valid_ff,
  output  logic         is_wfe,
  // performance counter
  output  logic         wait_for_npc,
  output  logic         wait_for_icr,
  // reset PC
  input   orv64_vaddr_t       cfg_rst_pc,
  output  orv64_vaddr_t       if_pc,

  // To VCore ID (by Anh)
`ifdef ORV_VECTOR_EXT
    output logic        if2vid_vld_ff,
    output orv64_if2vid_t     if2vid_ff,
//     input               vid2if_rdy,
    input               vid2if_thrd0_rdy,
    input               vid2if_thrd1_rdy,
    input               vid2if_thrd2_rdy,
    input               vid2if_thrd3_rdy,

`endif

  // rst & clk
  input   logic         rst, rst_ff, clk

);


  logic [63:0] if_status;
  always_comb
    case ({if_valid, if_ready})
      2'b00: if_status = "BUSY";
      2'b01: if_status = "IDLE";
      2'b10: if_status = "BLOCK";
      2'b11: if_status = "DONE";
      default: if_status = 64'bx;
    endcase


  chk_npc_valid_not_unknown: assert property (@ (posedge clk) disable iff (rst !== '0) (!$isunknown(if2if_npc.valid) && !$isunknown(ex2if_npc.valid) && !$isunknown(cs2if_npc.valid) && !$isunknown(ma2if_npc_valid))) else `olog_warning("ORV_FETCH", "one of the npc.valid is unknown, it will stall the creation of NPC");
  chk_if_valid_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(if_valid))) else `olog_fatal("ORV_FETCH", $sformatf("%m: if_vald is X after being reset"));
  chk_pc_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (if2ic.en |-> (!$isunknown(if2ic.pc)))) else `olog_error("ORV_FETCH", $sformatf("%m: PC is unknown"));
  chk_inst_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (if_valid |-> (!$isunknown(if2id.inst)))) else `olog_warning("ORV_FETCH", $sformatf("%m: inst is unknown, it's only OK when it's been killed later"));

  // }}}

endprogram
