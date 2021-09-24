module orv64_clk_gating
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
#(parameter DRIVEN=4) (
  output  clkg,
  input   en, tst_en, rst, clk
);
  `ifdef FPGA
    assign clkg = clk;
  `else
  generate
    if (DRIVEN == 1) begin: d1
      CKLNQD1BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clkg));
    end
    else if (DRIVEN == 2) begin: d2
      CKLNQD2BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clkg));
    end
    else if (DRIVEN == 4) begin: d4
      CKLNQD4BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clkg));
    end
    else if (DRIVEN == 8) begin: d8
      CKLNQD8BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clkg));
    end
    else if (DRIVEN == 12) begin: d12
      CKLNQD12BWP35P140 LNQ(.E(en), .TE(tst_en), .CP(clk), .Q(clkg));
    end
  endgenerate
  `endif
endmodule
