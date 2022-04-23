// ours_ppln_cell use valid/ready protocol for pipeline handshaking  
// 4 types of pipeline cell
// - (0) bypass: direct connection
// - (1) input_ppln: pipeline ready and data
// - (2) output_ppln: pipeline valid and data
// - (3) full_io: pipeline valid, ready, and data

module ours_ppln_cell
#(
  parameter BACKEND_DOMAIN = 0,
  parameter WIDTH = 8,    
  parameter TYPE = 3 			    // 0: bypass; 1: input_ppln; 2: output_ppln; 3: full_io
) (
  input   logic				clk,        // rising edge triggered clock
  input   logic             rstn,       // active low reset
  input   logic             valid_in,   // valid signal from upstream pipeline    
  output  logic             ready_out,  // ready signal to upstream pipeline           
  input   logic [WIDTH-1:0] data_in,    // data from upstream pipeline      
  output  logic             valid_out,  // valid signal to downstream pipeline   
  input   logic             ready_in,   // ready signal from downstream pipeline           
  output  logic [WIDTH-1:0] data_out    // data to downstream pipeline  
);

`ifndef SYNTHESIS
  initial begin
    assert ((TYPE == 0) | (TYPE == 1) | (TYPE == 2) | (TYPE == 3))
    else $fatal("ours_ppln_cell: TYPE=%s is not valid", TYPE);
  end
`endif

  generate
    //==========================================================
    // bypass {{{
    if (TYPE == 0) begin
      assign valid_out  = valid_in;
      assign data_out   = data_in;
      assign ready_out  = ready_in;
    end
    // }}}

    //==========================================================
    // input_ppln {{{
    if (TYPE == 1) begin
      ours_input_ppln #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH))
        input_ppln_u
  	    (
         .clk,
         .rstn,
         .valid_in,  
         .ready_out, 
         .data_in,         
         .valid_out, 
         .ready_in,  
         .data_out        
        );
    end
    // }}}

    //==========================================================
    // output_ppln {{{
    if (TYPE == 2) begin
      ours_output_ppln #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH))
        output_ppln_u
  	    (
         .clk,
         .rstn,
         .valid_in,  
         .ready_out, 
         .data_in,         
         .valid_out, 
         .ready_in,  
         .data_out        
        );
    end 
    // }}}

    //==========================================================
    // full_io {{{
    if (TYPE == 3) begin
      logic valid_temp;
      logic ready_temp;
      logic [WIDTH-1:0] data_temp;

      ours_input_ppln #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH))
        input_ppln_u
  	    (
         .clk,
         .rstn,
         .valid_in,  
         .ready_out, 
         .data_in,         
         .valid_out (valid_temp), 
         .ready_in  (ready_temp),  
         .data_out  (data_temp)      
        );

      ours_output_ppln #(.BACKEND_DOMAIN(BACKEND_DOMAIN), .WIDTH(WIDTH))
        output_ppln_u
  	    (
         .clk,
         .rstn,
         .valid_in  (valid_temp),  
         .ready_out (ready_temp), 
         .data_in   (data_temp),         
         .valid_out, 
         .ready_in,  
         .data_out        
        );
    end
    // }}}

  endgenerate

endmodule

