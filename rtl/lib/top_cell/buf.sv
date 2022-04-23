
module buffer #(parameter int WIDTH = 1) (
  input   [WIDTH-1:0] in,
  output  [WIDTH-1:0] out
  );

  `ifndef FPGA
  generate
    for (genvar i = 0; i < WIDTH; i++) begin : BUF_GEN
      CKBD8BWP30P140 buffer (.Z(out[i]), .I(in[i]));
    end
  endgenerate
  `else
  assign out = in;
  `endif

endmodule


