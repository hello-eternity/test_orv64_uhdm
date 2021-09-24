
module SELECT_OP (
  input  logic DATA1,
  input  logic DATA2,
  input  logic DATA3,
  input  logic DATA4,
  input  logic CONTROL1,
  input  logic CONTROL2,
  input  logic CONTROL3,
  input  logic CONTROL4,
  output logic Z
  );

  assign Z = (DATA1 & CONTROL1) | (DATA2 & CONTROL2) | (DATA3 & CONTROL3) | (DATA4 & CONTROL4);

endmodule
  
