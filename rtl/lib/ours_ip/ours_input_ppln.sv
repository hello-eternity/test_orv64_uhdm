module ours_input_ppln
  #(parameter int BACKEND_DOMAIN = 0,
	parameter int WIDTH = 8)
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
  
  logic rffce_ready, nxt_rffce_ready;
  logic [WIDTH-1:0] dffce_data;
  logic load;
 
  assign valid_out = ~rffce_ready | valid_in;  
  assign ready_out = rffce_ready;
  assign data_out  = ~rffce_ready ? dffce_data : data_in;
 
  always@ (posedge clk) begin
    if (~rstn)
	  rffce_ready <= '0;
    else if (rffce_ready | ready_in)
      rffce_ready <= nxt_rffce_ready;
  end

  assign nxt_rffce_ready = ~valid_in & rffce_ready | ready_in; 

  always@ (posedge clk) begin
    if (load)
	  dffce_data <= data_in;
  end
                
  assign load = valid_in & ready_out & ~ready_in;

endmodule
