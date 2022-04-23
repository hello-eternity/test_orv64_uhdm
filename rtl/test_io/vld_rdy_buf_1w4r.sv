module vld_rdy_buf_1w4r 
  #(parameter DATA_WIDTH=32, FIFO_DEPTH=4, CNT_WIDTH=$clog2(FIFO_DEPTH))
(
  input                                  clk,
  input                                  rstn,
  input                                  slave_valid,     
  output                                 slave_ready,   
  input  [DATA_WIDTH-1:0]                 data_in,       
  output                                 master_valid,   
  input                                  master_ready,   
  output logic [FIFO_DEPTH*DATA_WIDTH-1:0]   data_out      
);
  
  logic [CNT_WIDTH:0]   item_cnt;  
  logic [CNT_WIDTH:0]   nxt_item_cnt;  
  logic [CNT_WIDTH-1:0] wr_ptr;
  logic [CNT_WIDTH-1:0] nxt_wr_ptr;
  logic                 wr_en;
  logic                 rd_en;
  logic                 full;
  logic                 empty;

  //----------------------------
  // Outputs
  //----------------------------
  logic [FIFO_DEPTH-1:0] [DATA_WIDTH-1:0] data_array;
    assign full = item_cnt == FIFO_DEPTH[CNT_WIDTH:0];
  assign empty = ~|item_cnt;
  assign slave_ready = ~full | master_ready;
  assign master_valid = item_cnt > CNT_WIDTH'(3);  
  
  always_comb begin
    for (int i=0; i<FIFO_DEPTH; i++) begin
      data_out[i*DATA_WIDTH +: DATA_WIDTH] = data_array[i];
    end
  end   
  
  //----------------------------
  // Internal states
  //----------------------------
  logic item_cnt_plus0;
  logic item_cnt_plus1;
  logic item_cnt_set0;
  logic item_cnt_set1;

  always@(posedge clk)
    if(~rstn)
      item_cnt <= (CNT_WIDTH+1)'(0);
  else if (~item_cnt_plus0) 
      item_cnt <= nxt_item_cnt;
  
  always@(posedge clk)
    if(~rstn)
      wr_ptr <= CNT_WIDTH'(0);
    else if(wr_en) 
      wr_ptr <= nxt_wr_ptr; 

  //----------------------------
  // Control logic
  //----------------------------
  assign wr_en = slave_valid & slave_ready; 
  assign rd_en = master_valid & master_ready;    
  
  assign nxt_wr_ptr = wr_en ? wr_ptr + 1'b1 : wr_ptr;
  
  assign nxt_item_cnt = {(CNT_WIDTH+1){item_cnt_plus0}} & (item_cnt)        |  
						{(CNT_WIDTH+1){item_cnt_plus1}} & (item_cnt + 4'h1) |
						{(CNT_WIDTH+1){item_cnt_set0}}  & (CNT_WIDTH'(0))    |
                        {(CNT_WIDTH+1){item_cnt_set1}}  & (CNT_WIDTH'(1));
  
  assign item_cnt_plus0 = ~rd_en & ~wr_en;
  assign item_cnt_plus1 = ~rd_en &  wr_en;
  assign item_cnt_set0  =  rd_en & ~wr_en;
  assign item_cnt_set1  =  rd_en &  wr_en;
  
  generate
    for(genvar i = 0; i < FIFO_DEPTH; i++) begin
      always@(posedge clk)   
        if((wr_ptr == CNT_WIDTH'(i)) & wr_en)
          data_array[i] <= data_in;
    end
  endgenerate
      
endmodule
