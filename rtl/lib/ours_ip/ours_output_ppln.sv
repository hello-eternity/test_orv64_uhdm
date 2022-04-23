module ours_output_ppln 
#(parameter BACKEND_DOMAIN = 0,
  parameter WIDTH = 8)
(
  input  logic             clk,
  input  logic             rstn,
  input  logic             valid_in,  // valid signal from upstream pipeline     
  output logic             ready_out, // ready signal to upstream pipeline     
  input  logic [WIDTH-1:0] data_in,   // data from upstream pipeline            
  output logic             valid_out, // valid signal to downstream pipeline   
  input  logic             ready_in,  // ready signal from downstream pipeline  
  output logic [WIDTH-1:0] data_out   // data to downstream pipeline           
);

  logic rffce_valid, nxt_rffce_valid;
  logic load;
  logic [WIDTH-1:0] dffce_data;       
 
  assign valid_out = rffce_valid;
  assign ready_out = ~rffce_valid | ready_in;
  assign data_out  = dffce_data;
   
  always@ (posedge clk) begin
    if (~rstn)
      rffce_valid <= 1'b0;
    else if (~rffce_valid | ready_in)
      rffce_valid <= nxt_rffce_valid;  
  end
 
  assign nxt_rffce_valid = valid_in | rffce_valid & ~ready_in;

  always@(posedge clk) begin 
    if(load)
      dffce_data <= data_in;
  end
        
  assign load = valid_in & ready_out;

endmodule

