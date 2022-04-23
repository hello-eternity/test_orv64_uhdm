// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __TIMER_INTERRUPT__SV__
`define __TIMER_INTERRUPT__SV__

module timer_interrupt
  import pygmy_cfg::*;
  import pygmy_typedef::*;
# (
  parameter int NUM_PROCS = 4
)
(
  input   timer_t                  mtime_in,
  output  timer_t                  mtime_out,
  input   timer_t [NUM_PROCS-1:0]  mtimecmp,
  output  logic   [NUM_PROCS-1:0]  timer_int
);

  assign mtime_out = mtime_in + {{(TIMER_WIDTH-1){1'b0}}, 1'b1};

  generate
    for (genvar i=0; i<NUM_PROCS; i++) begin: TIMER_INTS
      assign timer_int[i] = (unsigned'(mtime_in) >= unsigned'(mtimecmp[i]));
    end
  endgenerate

endmodule

`endif
