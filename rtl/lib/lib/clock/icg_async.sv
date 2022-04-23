// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __ICG_ASYNC_SV__
`define __ICG_ASYNC_SV__

module icg_async
#(
  parameter BACKEND_DOMAIN=0,
  parameter DRIVEN=4,
  parameter WITH_INPUT_SYNC=0,
  parameter WITH_OUTPUT_SYNC=0
) (
  output logic clkg,
  output logic async_en_out,
  input  logic async_clk,
  input  logic en,
  input  logic tst_en,
  input  logic clk
);
  logic en_sync;
`ifdef FPGA
    assign clkg = clk;
`else
`ifdef USE_T28HPCP
    generate
      if (DRIVEN == 1) begin: d1
        CKLNQD1BWP35P140 LNQ(.E(en_sync), .TE(tst_en), .CP(clk), .Q(clkg));
      end
      else if (DRIVEN == 2) begin: d2
        CKLNQD2BWP35P140 LNQ(.E(en_sync), .TE(tst_en), .CP(clk), .Q(clkg));
      end
      else if (DRIVEN == 4) begin: d4
        CKLNQD4BWP35P140 LNQ(.E(en_sync), .TE(tst_en), .CP(clk), .Q(clkg));
      end
      else if (DRIVEN == 8) begin: d8
        CKLNQD8BWP35P140 LNQ(.E(en_sync), .TE(tst_en), .CP(clk), .Q(clkg));
      end
      else if (DRIVEN == 12) begin: d12
        CKLNQD12BWP35P140 LNQ(.E(en_sync), .TE(tst_en), .CP(clk), .Q(clkg));
      end
      // input sync
      if (WITH_INPUT_SYNC == 1) begin : WITH_INPUT_SYNC_1
        sync IP_SYNC(.q(en_sync), .d(en), .clk(clk));
      end
      else begin : WITH_INPUT_SYNC_0
        assign en_sync = en;
      end
      // output sync
      if (WITH_OUTPUT_SYNC == 1) begin : WITH_OUTPUT_SYNC_1
        sync OP_SYNC(.q(async_en_out), .d(en_sync), .clk(clk));
      end
      else begin : WITH_OUTPUT_SYNC_0
        assign async_en_out = 1'b0;
      end
    endgenerate
`endif
`endif
endmodule

`endif

