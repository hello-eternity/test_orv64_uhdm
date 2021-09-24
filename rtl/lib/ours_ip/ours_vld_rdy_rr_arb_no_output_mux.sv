// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module ours_vld_rdy_rr_arb_no_output_mux #(
  parameter N_INPUT = 2
) (
  input   logic [N_INPUT-1:0] vld,
  input   logic               rdy,
  output  logic [N_INPUT-1:0] grt,
  input   logic               rstn, clk
);

  logic [N_INPUT-1:0] rff_state, nstate;
  logic               rffce_state;
  logic [N_INPUT-1:0] grt_d;

  assign rffce_state = (grt_d != {N_INPUT{1'b0}});

  always @(posedge clk) begin
    if (~rstn) begin
      rff_state <= {1'b1,{(N_INPUT-1){1'b0}}};
    end else begin
      if (rffce_state)
        rff_state <= nstate;
    end
  end

  logic [N_INPUT-1:0] msk_vld;
  logic [N_INPUT-1:0] tmp_grt;
  logic [N_INPUT-1:0] grt_comp;
  always_comb begin
    msk_vld = vld & ~((rff_state - 1'b1) | rff_state);
    tmp_grt = msk_vld & (~msk_vld + 1'b1);
    if (msk_vld != {N_INPUT{1'b0}})
      grt_comp = tmp_grt;
    else
      grt_comp = vld & (~vld + 1'b1);
  end

  assign grt = grt_comp;
  assign grt_d = rdy ? grt_comp : {N_INPUT{1'b0}};
  assign nstate = grt;
  
endmodule

