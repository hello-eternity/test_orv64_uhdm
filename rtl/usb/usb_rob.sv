module usb_rob 
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
(
  // usb/sdio's cpu request: 0 => usb; 1 => sdio
  input  logic  		     [1:0]     io_rob_req_if_req_valid,
  output logic  		     [1:0]     io_rob_req_if_req_ready,
  input  cpu_cache_if_req_t  [1:0]     io_rob_req_if_req,
  // cpu request to noc
  output logic  		               rob_noc_req_if_req_valid,
  input  logic  		               rob_noc_req_if_req_ready,
  output cpu_cache_if_req_t            rob_noc_req_if_req,
  // cpu response from noc
  input  logic  		               noc_rob_resp_if_resp_valid,
  output logic  		               noc_rob_resp_if_resp_ready,
  input  cpu_cache_if_resp_t      	   noc_rob_resp_if_resp, 
  // cpu response to usb/sdio
  output logic  		      [1:0]    rob_io_resp_if_resp_valid,
  input  logic  		      [1:0]    rob_io_resp_if_resp_ready,
  output cpu_cache_if_resp_t  [1:0]    rob_io_resp_if_resp, 
  // req age info to cpu noc 
  output logic [N_BANK-1:0] 	       entry_vld_pbank,
  output logic [N_BANK-1:0] 		   is_oldest_pbank,
  input  clk,
  input  rstn
);

  logic     [N_BANK-1:0] [N_BANK-1:0] rff_rob_age_entry;
  logic 	[N_BANK-1:0] rff_rob_vld_entry;
  cpu_tid_t [N_BANK-1:0] rff_rob_tid_entry;
  logic     [N_BANK-1:0] [N_BANK-1:0] nxt_rob_age_entry;
  logic 	[N_BANK-1:0] nxt_rob_vld_entry;
  cpu_tid_t [N_BANK-1:0] nxt_rob_tid_entry;
  logic 	[N_BANK-1:0] vld_entry_en;
  logic 	[N_BANK-1:0] tid_entry_en;
  logic 	[N_BANK-1:0] age_entry_en;
  logic 	[N_BANK-1:0] vld_entry_alloc;
  logic 	[N_BANK-1:0] vld_entry_dealloc;
  logic     [N_BANK-1:0] [N_BANK-1:0] age_match;
  logic     [N_BANK-1:0] [N_BANK-1:0] age_sorting;
  logic  		               l2_req_valid;
  logic  		               l2_req_ready;
  cpu_cache_if_req_t           l2_req;

  usb_rob_arb #(.N_REQ(2)
  ) sdio_usb_arbiter_u (
    .cpu_if_req_valid    (io_rob_req_if_req_valid),
    .cpu_if_req          (io_rob_req_if_req), 
    .cpu_if_req_ready    (io_rob_req_if_req_ready), 
    .cpu_if_resp_valid   (rob_io_resp_if_resp_valid), 
    .cpu_if_resp	     (rob_io_resp_if_resp), 
    .cpu_if_resp_ready   (rob_io_resp_if_resp_ready),
    .cache_if_req_valid  (l2_req_valid), 
    .cache_if_req        (l2_req), 
    .cache_if_req_ready  (l2_req_ready), 
    .cache_if_resp_valid (noc_rob_resp_if_resp_valid), 
    .cache_if_resp		 (noc_rob_resp_if_resp), 
    .cache_if_resp_ready (noc_rob_resp_if_resp_ready),
    .rstn,
    .clk
  );

  //---------------------------------------------------------- 
  // rob for ar request 
  //---------------------------------------------------------- 
  // valid entry
  assign entry_vld_pbank = rff_rob_vld_entry;

  always@(posedge clk) begin
    for(int i=0; i<N_BANK; i++) begin    
      if (~rstn) 
        rff_rob_vld_entry[i] <= '0;
	  else if (vld_entry_en[i])
		rff_rob_vld_entry[i] <= nxt_rob_vld_entry[i];
    end
  end

    // assertion for alloc and de-alloc can't not assert at the same time
    // allocation / de-allocation
generate
  for (genvar i=0; i<N_BANK; i++) begin
    assign vld_entry_en[i] =  vld_entry_alloc[i] | vld_entry_dealloc[i];
    assign vld_entry_alloc[i] = ~rff_rob_vld_entry[i] & rob_noc_req_if_req_ready & l2_req_valid & ((l2_req.req_type == REQ_READ) || (l2_req.req_type == REQ_BARRIER_SYNC)) &
           				        (l2_req.req_paddr[BANK_ID_MSB:BANK_ID_LSB] == BANK_ID_WIDTH'(i));
    assign vld_entry_dealloc[i] = rff_rob_vld_entry[i] & noc_rob_resp_if_resp_valid & noc_rob_resp_if_resp_ready & 
      				             (noc_rob_resp_if_resp.resp_tid.src == rff_rob_tid_entry[i].src) & 
       					         (noc_rob_resp_if_resp.resp_tid.tid == rff_rob_tid_entry[i].tid);
    assign nxt_rob_vld_entry[i] = vld_entry_alloc[i] & ~vld_entry_dealloc[i];
  end
endgenerate

  assign l2_req_ready = l2_req_valid & ((l2_req.req_type != REQ_READ) && (l2_req.req_type != REQ_BARRIER_SYNC)) & rob_noc_req_if_req_ready |
					   ~l2_req_valid & rob_noc_req_if_req_ready | (|vld_entry_alloc);
  assign rob_noc_req_if_req_valid = |vld_entry_alloc | l2_req_valid & ((l2_req.req_type != REQ_READ) && (l2_req.req_type != REQ_BARRIER_SYNC)) ;  
  assign rob_noc_req_if_req = l2_req;
 
  // tid entry
  always@(posedge clk) begin
    for(int i=0; i<N_BANK; i++) begin    
      if (~rstn) 
        rff_rob_tid_entry[i] <= '0;
      else if (tid_entry_en[i])
        rff_rob_tid_entry[i] <= nxt_rob_tid_entry[i];
    end
  end

  always_comb begin 
	for(int i=0; i<N_BANK; i++) begin
      tid_entry_en[i] = vld_entry_alloc[i] | vld_entry_dealloc[i];
      nxt_rob_tid_entry[i] = vld_entry_alloc[i] ? l2_req.req_tid : '0; 
    end
  end

  // age entry
  always@(posedge clk) begin
    for(int i=0; i<N_BANK; i++) begin  
      if (~rstn) 
        rff_rob_age_entry[i] <= '0;
      else if (age_entry_en[i])
        rff_rob_age_entry[i] <= nxt_rob_age_entry[i];
    end
  end

generate
  for (genvar i=0; i<N_BANK; i++) begin
    assign age_entry_en[i] = vld_entry_alloc[i] | vld_entry_dealloc[i];
    assign nxt_rob_age_entry[i] = vld_entry_dealloc[i] ? '0						              : 
								  vld_entry_alloc[i]   ? {1'b1,{(N_BANK-1){1'b0}}}            :
                                (|vld_entry_alloc)     ? {1'b0,rff_rob_age_entry[N_BANK-1:1]} : rff_rob_age_entry[i];
  end
endgenerate

  always_comb begin
    for (int i=0; i<N_BANK; i++) begin
    // i: 1st oldest, 2nd oldest ..4th oldest
      for (int j=0; j<N_BANK; j++) begin
      // j: bank 0, bank 1 .. bank N-1
        age_sorting[i][j] = rff_rob_vld_entry[j] & rff_rob_age_entry[j][i];
      end
    end
  end

  always_comb begin
    for (int i=0; i<N_BANK; i++) begin
      // indicate if the request is the oldest among all banks
      age_match[i][0] = rff_rob_age_entry[i][0];
      for (int j=1; j<N_BANK; j++) begin
	    age_match[i][j] = rff_rob_age_entry[i][j] & ~|age_sorting[j-1];
      end
      is_oldest_pbank[i] = rff_rob_vld_entry[i] & |age_match[i];
    end
  end


endmodule

