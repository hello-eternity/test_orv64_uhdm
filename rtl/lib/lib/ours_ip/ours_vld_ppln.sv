module ours_vld_ppln 
  #(parameter BACKEND_DOMAIN = 0) 
(
  input   logic valid_in,		// valid signal from upstream pipeline
  output  logic valid_out,      // valid signal to downstream pipeline 
  input   logic ready_in,		// ready signal from downstream pipepline
  output  logic do_save, 		// serve as data eanble signal to load new data into pipeline 
  output  logic do_use_saved,   // indicate pipeline is occupied and do use the data that has been loaded into pipeline  
  input   logic rstn, clk
);

  logic rff_hold_valid, nxt_hold_valid;

  always_ff @ (posedge clk) begin
    if (~rstn) 
      rff_hold_valid <= '0;
    else  
      rff_hold_valid <= nxt_hold_valid;
  end

  assign nxt_hold_valid = ~ready_in & (rff_hold_valid | valid_in);

  assign valid_out = rff_hold_valid | valid_in;
  
  assign do_save = ~ready_in & valid_in & ~rff_hold_valid;
    
  assign do_use_saved = rff_hold_valid;

endmodule

