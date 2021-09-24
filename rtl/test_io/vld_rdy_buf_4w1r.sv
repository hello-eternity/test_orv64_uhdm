module vld_rdy_buf_4w1r 
  #(parameter DATA_WIDTH=32, FIFO_DEPTH=4, CNT_WIDTH=$clog2(FIFO_DEPTH))
(
  input                         	clk,
  input                        	 	rstn,
  input                    			slave_valid,   
  output                  			slave_ready,   
  input  [DATA_WIDTH*4-1:0] data_in,       
  output                        	master_valid,   
  input                         	master_ready,   
  output [DATA_WIDTH-1:0]        	data_out      
);
  
  logic [CNT_WIDTH:0] item_cnt;  
  logic [CNT_WIDTH:0] nxt_item_cnt; 
  logic [CNT_WIDTH-1:0] rd_ptr;
  logic [CNT_WIDTH-1:0] nxt_rd_ptr;
  logic               wr_en;
  logic               rd_en;
  logic               full;
  logic               empty;

  //-------------------------------------------
  // Outputs
  //------------------------------------------- 
  logic [FIFO_DEPTH-1:0] [DATA_WIDTH-1:0] data_array;
  assign full = item_cnt == FIFO_DEPTH[CNT_WIDTH:0];
  assign empty = ~|item_cnt;
  assign slave_ready = empty | master_ready & (item_cnt == CNT_WIDTH'(1));
  assign master_valid = ~empty;  
  assign data_out = data_array[rd_ptr];
  
  //----------------------------
  // Internal states
  //----------------------------
   //----------------------------
  // Next state logic
  //----------------------------  
  logic is_item_cnt_sub0;
  logic is_item_cnt_sub1;
  logic is_item_cnt_set3;
  logic is_item_cnt_set4;
  
   always@(posedge clk)
    if(~rstn)
      item_cnt <= (CNT_WIDTH+1)'(0);
  else if (~is_item_cnt_sub0) 
      item_cnt <= nxt_item_cnt;
  
  always@(posedge clk)
    if(~rstn) 
      rd_ptr <= CNT_WIDTH'(0);
    else if(rd_en)
      rd_ptr <= nxt_rd_ptr;

  //----------------------------
  // Control logic
  //----------------------------
  // push operation
  assign wr_en = slave_valid & slave_ready;         
  // pop operaton    
  assign rd_en = master_valid & master_ready;   

  assign nxt_rd_ptr = rd_en ? rd_ptr + 1'b1 : rd_ptr;
  
  assign nxt_item_cnt = {(CNT_WIDTH+1){is_item_cnt_sub0}} & (item_cnt)        | 
						{(CNT_WIDTH+1){is_item_cnt_sub1}} & (item_cnt - 4'h1) |
                        {(CNT_WIDTH+1){is_item_cnt_set3}} & (3'b011)           |
                        {(CNT_WIDTH+1){is_item_cnt_set4}} & (3'b100);
  
  assign is_item_cnt_sub0 = ~wr_en & ~rd_en;
  assign is_item_cnt_sub1 = ~wr_en &  rd_en;
  assign is_item_cnt_set4 =  wr_en & ~rd_en;
  assign is_item_cnt_set3 =  wr_en &  rd_en;  
  
  //----------------------------
  // Data path
  //----------------------------
  
  generate
    for(genvar i = 0; i < FIFO_DEPTH; i++) begin
      always@(posedge clk)   
        if(wr_en)
          data_array[i] <= data_in[i*DATA_WIDTH +: DATA_WIDTH];
    end
  endgenerate
      
      
endmodule
