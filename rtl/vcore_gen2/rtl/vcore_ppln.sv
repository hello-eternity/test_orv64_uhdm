module vcore_ppln 
#(parameter CTRL_WIDTH, DATA_WIDTH)
(
  input                  clk,
  input                  rstn,
  input                  valid_in,       
  output                 ready_out,    
  input  [DATA_WIDTH-1:0]data_in,       
  input  [CTRL_WIDTH-1:0]ctrl_in,       
  output                 valid_out,    
  input                  ready_in,      
  output [DATA_WIDTH-1:0]data_out,     
  output [CTRL_WIDTH-1:0]ctrl_out     
);

  logic rffce_valid;
  logic toggle;
  logic load;
  logic  [DATA_WIDTH-1:0] dffce_data_reg;       
  logic  [CTRL_WIDTH-1:0] rffce_ctrl_reg;
 
  // output logic
  assign valid_out = rffce_valid;
  assign data_out  = dffce_data_reg;
  assign ctrl_out  = rffce_ctrl_reg;
  assign ready_out = ~rffce_valid | ready_in;
   
  // rffce_valid bit
  assign toggle = ~rffce_valid & valid_in | rffce_valid & ~valid_in & ready_in;
   
  always@ (posedge clk)
    if (~rstn)
      rffce_valid <= 1'b0;
    else if (toggle)
      rffce_valid <= ~rffce_valid;  

  // stage flops    
  assign load = valid_in & ready_out;
  
  always@(posedge clk)  
    if(load)
      dffce_data_reg <= data_in;
     
  always@ (posedge clk)
    if (~rstn)
      rffce_ctrl_reg <= {CTRL_WIDTH{1'b0}};
    else if (load)
      rffce_ctrl_reg <= ctrl_in;
          
endmodule
