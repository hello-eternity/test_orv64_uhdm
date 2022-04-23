// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __ICG_SV__
`define __ICG_SV__

module icg
#(
  parameter int BACKEND_DOMAIN = 0,
  parameter DRIVEN=4
) (
  output logic clkg,
  input  logic en,
  input  logic tst_en,
  input  logic clk
);
`ifdef FPGA
    assign clkg = clk;
`else
`ifdef USE_T28HPCP
    logic clk_temp;
    generate
      if (DRIVEN == 1) begin: d1
        CKLNQD1BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if (DRIVEN == 2) begin: d2
        CKLNQD2BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if (DRIVEN == 4) begin: d4
        CKLNQD4BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if (DRIVEN == 8) begin: d8
        CKLNQD8BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if (DRIVEN == 12) begin: d12
        CKLNQD12BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if(DRIVEN == 16) begin: d16
        CKLNQD16BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if(DRIVEN == 20) begin: d20
        CKLNQD20BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end
      else if(DRIVEN == 24) begin: d24
        CKLNQD24BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clk_temp));
      end

    endgenerate
    CKBD8BWP30P140 clk_buf (.Z(clkg), .I(clk_temp));
`endif
`endif
endmodule

`endif
