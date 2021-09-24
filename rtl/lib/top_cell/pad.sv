
module pad (
  inout PAD,
  output reg  C,
  input   REN,
  input   I,
  input   OEN
);
  // C
  always_comb begin
    C = PAD;
    if ((PAD === 1'bZ) && (REN === 1'b0)) begin
      C = 1'b0;
    end
  end

  // PAD
  assign PAD = OEN ? 'bz : I;

endmodule

