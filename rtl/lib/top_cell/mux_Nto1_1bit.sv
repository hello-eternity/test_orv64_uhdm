
module mux_Nto1_1bit #(parameter int N_PORT = 2) (
  input   logic [N_PORT-1:0]          in,
  input   logic [$clog2(N_PORT)-1:0]  sel,
  output  logic                       out
  );

  assign out = in[sel];

endmodule

