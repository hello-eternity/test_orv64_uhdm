// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __SD_HOLD_VALID_SV__
`define __SD_HOLD_VALID_SV__

module sd_hold_valid 
  #(parameter int BACKEND_DOMAIN = 0) 
(
  input   logic s_valid,
  output  logic d_valid,
  input   logic d_ready,
  output  logic do_save, do_use_saved,
  input   logic rstn, clk
);

  logic hold_valid, rff_hold_valid;

  always_ff @ (posedge clk) begin
    if (~rstn) begin
      rff_hold_valid <= '0;
    end else begin
      rff_hold_valid <= hold_valid;
    end
  end

  always_comb begin
    hold_valid = rff_hold_valid ? ~d_ready : s_valid & ~d_ready;
    d_valid = rff_hold_valid ? '1 : s_valid;
  end
  assign do_save = hold_valid & ~rff_hold_valid;
  assign do_use_saved = rff_hold_valid;

endmodule

`endif
