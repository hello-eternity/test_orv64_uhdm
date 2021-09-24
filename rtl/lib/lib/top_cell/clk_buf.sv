
module clk_buffer (
  input  logic  in,
  output logic  out
  );

  `ifndef FPGA
  CKBD8BWP30P140 buffer (.Z(out), .I(in));
  `else
  assign out = in;
  `endif

endmodule


