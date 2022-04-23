// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// pipeline control that instantiated in each pipeline stages

module orv64_pipe_ctrl
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
(
  output  valid, ready,
  input   prev_valid,   // valid from previous stage
          next_ready,   // ready from next stage
          int_valid,    // current stage generated valid signal, to valid itself's output
          stall,        // stall signal, could be from both inside and outside
          kill,         // kill signal
  input   rst, clk
);

  logic   prev_valid_ff;
  always_ff @ (posedge clk)
    if (rst)
      prev_valid_ff <= 'b0;
    // else
    else if (ready)
      prev_valid_ff <= prev_valid;

  assign  valid = ~kill & prev_valid_ff & int_valid;
  // assign  ready = (~valid | next_ready) & ~stall;
  assign  ready = next_ready & ~stall;

  // assign  is_idle_next_cycle = ~prev_valid & ((valid & next_ready) | (~valid & ready));
  assign self_ready = next_ready & ~stall;
  assign self_valid = ~kill & prev_valid_ff & int_valid;

endmodule
