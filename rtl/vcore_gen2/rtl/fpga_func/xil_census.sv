module xil_census #(
parameter pipe_census_w       = 5

)
(
input clk,
input rstn,

//input data
input   vld_i,
input   rdy_o,

//output data
input   vld_o,
input   rdy_i,

output logic [pipe_census_w-1:0] census
);

always @ ( posedge clk )
begin
  if(!rstn)
    census <= 1'b0;
  else
  begin
    if( (vld_i & rdy_o))// && (census < {pipe_census_w{1'b1}}))
      census <= census +1;
    if((vld_o & rdy_i) && (census > '0))
      census <= census -1;
  end
end
endmodule
