// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_one_hot_rr_arb #(
  parameter BACKEND_DOMAIN = 0,
  parameter N_INPUT = 2
) (
  input   logic               en,
  output  logic [N_INPUT-1:0] grt,
  input   logic               rstn, clk
);

  logic [N_INPUT-1:0] rff_state, nstate;

  always @(posedge clk) begin
    if (~rstn) begin
      rff_state <= {1'b1,{(N_INPUT-1){1'b0}}};
    end else begin
      if (en)
        rff_state <= nstate;
    end
  end

  assign nstate = {rff_state[0],rff_state[N_INPUT-1:1]};
  assign grt = rff_state;
  
endmodule

