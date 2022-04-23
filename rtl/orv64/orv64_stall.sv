// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_stall (
  input   logic     bp_stall,
  input   logic     int_stall,
  input   logic     crb_stall,

  input   logic     crb_resume,

  output  logic     debug_stall_to_orv,

  output  logic     stalled_for_int,

  // clk & rst
  input   logic     rst, clk
);

  logic     rff_bp_stall;
  logic     rff_int_stall;
  logic     rff_crb_stall;

  assign debug_stall_to_orv = rff_int_stall | rff_crb_stall | rff_bp_stall;
  assign stalled_for_int = rff_int_stall;

  always_ff @ (posedge clk) begin
    if (rst) begin
      rff_int_stall <= '0;
    end else begin
      rff_int_stall <= int_stall;
    end
  end

  always_ff @ (posedge clk) begin
    if (rst) begin
      rff_bp_stall <= '0;
    end else begin
      if (rff_bp_stall) begin
        rff_bp_stall <= ~crb_resume;
      end else begin
        rff_bp_stall <= bp_stall;
      end
    end
  end

  always_ff @ (posedge clk) begin
    if (rst) begin
      rff_crb_stall <= '0;
    end else begin
      if (rff_crb_stall) begin
        rff_crb_stall <= ~crb_resume;
      end else begin
        rff_crb_stall <= crb_stall;
      end
    end
  end

endmodule
