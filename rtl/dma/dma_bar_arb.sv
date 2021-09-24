// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module dma_bar_arb 
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
# (
  parameter DMA_THREAD_CNT      = 4
) (
  input  logic  [DMA_THREAD_CNT-1:0]  req,
  output logic  [DMA_THREAD_CNT-1:0]  gnt,

  input  logic  [DMA_THREAD_CNT-1:0]  done,

  output logic                        is_outstanding_barrier,

  input       clk, rstn
);

  logic rff_is_outstanding_barrier;

  assign is_outstanding_barrier = rff_is_outstanding_barrier;

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_is_outstanding_barrier <= '0;
    end else begin
      if (rff_is_outstanding_barrier) begin
        rff_is_outstanding_barrier <= ~(|done);
      end else if (|gnt) begin
        rff_is_outstanding_barrier <= '1;
      end
    end
  end

  always_comb begin
    gnt = '0;
    if (~rff_is_outstanding_barrier) begin
      for (int i=0; i<DMA_THREAD_CNT; i++) begin
        if (req[i]) begin
          gnt[i] = 1'b1;
          break;
        end
      end
    end
  end


`ifndef SYNTHESIS
  gnt_is_x: assert property (@(posedge clk) disable iff (rstn == '0) (!$isunknown(gnt)))
    else `olog_fatal("DMA_BAR_ARB", $sformatf("%m: gnt is x"));
  gnt_not_one_hot: assert property (@(posedge clk) disable iff (rstn == '0) ((gnt !== '0) |-> $onehot(gnt)))
    else `olog_fatal("DMA_BAR_ARB", $sformatf("%m: Gnt is not one hot"));
  sending_multiple_mem_barriers: assert property (@(posedge clk) disable iff (rstn === '0) (rff_is_outstanding_barrier |-> (gnt === '0)))
    else `olog_fatal("DMA", $sformatf("%m: Granting when outstanding mem barriers"));
`endif


endmodule
