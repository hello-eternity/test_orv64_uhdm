// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_sram_model
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
#(
  parameter WIDTH=64,
  parameter DEPTH=64,
  parameter N_RW_PORT=1,
  parameter WAKE_UP_CYCLE=2,
  parameter START_CYCLE=10
) (
  input   logic [N_RW_PORT:1]                     ce, // chip enable
  input   logic [N_RW_PORT:1]                     we, // write enable
  input   logic [N_RW_PORT:1] [$clog2(DEPTH)-1:0] a,  // read/write address
  input   logic [N_RW_PORT:1] [WIDTH-1:0]         wd,  // write data
  input   logic [N_RW_PORT:1] [WIDTH-1:0]         wm,  // write mask
  output  logic [N_RW_PORT:1] [WIDTH-1:0]         rd,  // read data
  input                                           slp,  // sleep
                                                  sd,   // shut-down
                                                  clk
);

  logic [DEPTH-1:0] [WIDTH-1:0] bitcell;
  logic [WAKE_UP_CYCLE:1] slp_ff;
  logic [START_CYCLE:1]   sd_ff;

  always @ (posedge clk) begin
    slp_ff <= {slp_ff[WAKE_UP_CYCLE-1:1], slp};
    sd_ff <= {sd_ff[START_CYCLE-1:1], sd};
  end

  always @ (posedge clk)
    if (~slp_ff[WAKE_UP_CYCLE] & ~sd_ff[START_CYCLE]) begin
      for (int i = 1; i <= N_RW_PORT; i++) begin
        if (ce[i]) begin
          if (we[i]) begin
            for (int j = 0; j < WIDTH; j++)
              if (wm[i][j])
                bitcell[a[i]][j] <= wd[i][j];
            rd[i] <= 'bx;
          end else begin
            rd[i] <= bitcell[a[i]];
          end
        end else begin
          rd[i] <= 'bx;
        end
      end
    end else begin
      rd <= 'bx;
      if (sd) bitcell <= 'bx;
    end

endmodule
