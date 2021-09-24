// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_pc_breakpoint
  import pygmy_typedef::*;
  import orv64_typedef_pkg::*;
(
  input   orv64_vaddr_t   bp_if_pc_0, bp_if_pc_1, bp_if_pc_2, bp_if_pc_3,
  input   logic           en_bp_if_pc_0, en_bp_if_pc_1, en_bp_if_pc_2, en_bp_if_pc_3,
  input   orv64_vaddr_t   bp_wb_pc_0, bp_wb_pc_1, bp_wb_pc_2, bp_wb_pc_3,
  input   logic           en_bp_wb_pc_0, en_bp_wb_pc_1, en_bp_wb_pc_2, en_bp_wb_pc_3,

  input   logic           instret_bp_en,
  input   orv64_data_t    instret_bp,

  // from ORV
  input   orv64_vaddr_t   if_pc, wb_pc,
  input   logic     if_valid, wb_valid,
  input   orv64_data_t    minstret,

  output  logic     bp_stall,

  // clk & rst
  input   logic     rst, clk
);

  orv64_vaddr_t     dff_if_pc, dff_wb_pc;
  logic       dff_if_valid, dff_wb_valid;
  logic [3:0] if_pc_match, wb_pc_match;
  logic       rff_instret_match;

  logic if_clkg, wg_clkg;

  logic en_if_pc_clk, en_wb_pc_clk;

  assign en_if_pc_clk = if_valid & (en_bp_if_pc_0 | en_bp_if_pc_1 | en_bp_if_pc_2 | en_bp_if_pc_3);
  assign en_wb_pc_clk = wb_valid & (en_bp_wb_pc_0 | en_bp_wb_pc_1 | en_bp_wb_pc_2 | en_bp_wb_pc_3);

  icg if_clk_u(
    .en       (en_if_pc_clk),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (if_clkg)
  );

  icg wb_clk_u(
    .en       (en_wb_pc_clk),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (wb_clkg)
  );

  always_comb begin
    if_pc_match[0] = dff_if_valid & en_bp_if_pc_0 & (bp_if_pc_0 == dff_if_pc);
    if_pc_match[1] = dff_if_valid & en_bp_if_pc_1 & (bp_if_pc_1 == dff_if_pc);
    if_pc_match[2] = dff_if_valid & en_bp_if_pc_2 & (bp_if_pc_2 == dff_if_pc);
    if_pc_match[3] = dff_if_valid & en_bp_if_pc_3 & (bp_if_pc_3 == dff_if_pc);

    wb_pc_match[0] = dff_wb_valid & en_bp_wb_pc_0 & (bp_wb_pc_0 == dff_wb_pc);
    wb_pc_match[1] = dff_wb_valid & en_bp_wb_pc_1 & (bp_wb_pc_1 == dff_wb_pc);
    wb_pc_match[2] = dff_wb_valid & en_bp_wb_pc_2 & (bp_wb_pc_2 == dff_wb_pc);
    wb_pc_match[3] = dff_wb_valid & en_bp_wb_pc_3 & (bp_wb_pc_3 == dff_wb_pc);
  end

  always_ff @(posedge clk) begin
    dff_if_valid <= if_valid;
  end

  always_ff @(posedge if_clkg) begin
    if (en_if_pc_clk) begin
      dff_if_pc <= if_pc;
    end
  end

  always_ff @(posedge clk) begin
    dff_wb_valid <= wb_valid;
  end

  always_ff @(posedge wb_clkg) begin
    if (en_wb_pc_clk) begin
      dff_wb_pc <= wb_pc;
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_instret_match <= '0;
    end else begin
      if (instret_bp_en) begin
        rff_instret_match <= (instret_bp == minstret);
      end else begin
        rff_instret_match <= '0;
      end
    end
  end

  assign bp_stall = (|if_pc_match) | (|wb_pc_match) | rff_instret_match;

endmodule
