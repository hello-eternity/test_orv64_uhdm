// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


module cache_mshr
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#(
  parameter int BANK_ID=0
)
(
  //------------------------------------------------------
  // cache control logic
  input   mshr_t              new_mshr,
  input   mshr_id_t           new_mshr_id,
  input   logic               dirty, // one cycle late from new_mshr (pipeline delay)
  output  mshr_t [N_MSHR-1:0] mshr_bank,
  output  mshr_t              mshr_resp,

  //------------------------------------------------------
  // cache ram
  // tag ram
  output  logic               valid_ram_we,
  output  bank_index_t        valid_ram_waddr,
  output  logic [N_WAY-1:0]   valid_ram_din,
  output  logic [N_WAY-1:0]   valid_ram_bwe,

  // dirty ram
  output  logic               dirty_ram_we,
  output  bank_index_t        dirty_ram_waddr,
  output  logic               dirty_ram_din,
  output  logic [N_WAY-1:0]   dirty_ram_bwe,

  // tag ram
  input   logic [N_WAY-1:0]   tag_ram_wready_pway,
  output  logic [N_WAY-1:0]   tag_ram_we_pway,
  output  bank_index_t        tag_ram_waddr,
  output  tag_t               tag_ram_din,

  // data ram (memory will only load and modify the whole cache line)
  input   logic         [N_WAY-1:0] data_ram_ready_pway,
  input   cpu_data_t    [N_WAY-1:0] data_ram_dout_pway,
  output  logic         [N_WAY-1:0] data_ram_en_pway,
  output  logic         [N_WAY-1:0] data_ram_rw_pway,
  output  cpu_data_t    [N_WAY-1:0] data_ram_din_pway,
  output  bank_index_t  [N_WAY-1:0] data_ram_bank_index_pway,
//   output  cpu_offset_t  [N_WAY-1:0] data_ram_offset_pway,

  //------------------------------------------------------
  // CPU NOC
  input   logic       cpu_resp_ready,
  output  cpu_resp_t  cpu_resp,
  output  logic       cpu_resp_valid,
  output  logic       cache_read_hit_backpressure,

  //------------------------------------------------------
  // MEM NOC
  // AW 
  output logic				l2_req_if_awvalid,
  input	 logic 				l2_req_if_awready,
  output cache_mem_if_aw_t	l2_req_if_aw,
  // W 
  output logic 				l2_req_if_wvalid,
  input	 logic 				l2_req_if_wready,
  output cache_mem_if_w_t 	l2_req_if_w,
  // B
  input  logic 				l2_resp_if_bvalid,
  output logic 				l2_resp_if_bready,
  input  cache_mem_if_b_t 	l2_resp_if_b,
  // AR
  output logic 				l2_req_if_arvalid,
  input  logic 				l2_req_if_arready,
  output cache_mem_if_ar_t 	l2_req_if_ar,
  // R
  input  logic 				l2_resp_if_rvalid,
  output logic 				l2_resp_if_rready,
  input  cache_mem_if_r_t 	l2_resp_if_r,

  // else
  input	 logic       		rst, clk
);

  mshr_req_t          req_ff;
  logic [N_MSHR-1:0]  new_mshr_bank_valid;

  mem_fsm_reg_t       mem_req_ff, mem_req_nxt;

  logic   resp_ram_ready, req_ram_ready, is_mshr_word;
  //==========================================================
  // command fifo
  // {{{
  logic ar_fifo_re, ar_fifo_empty, aw_fifo_re, aw_fifo_we, aw_fifo_empty, w_fifo_re, w_fifo_we, w_fifo_empty;
  logic ar_fifo_re_ff, aw_fifo_re_ff, w_fifo_re_ff;
  logic [1:0]                     ar_fifo_we;
  mshr_id_t                        ar_fifo_din[0:1], ar_fifo_dout, aw_fifo_din, aw_fifo_dout, w_fifo_din, w_fifo_dout;

  // write address command fifo{{{
  l2_cmd_fifo #(.WIDTH($clog2(N_MSHR)), .DEPTH(N_MSHR))  AW_FIFO(.*,
    .din(aw_fifo_din),
    .we(aw_fifo_we),
    .re(aw_fifo_re),
    .empty(aw_fifo_empty),
    .dout(aw_fifo_dout)); // }}}

  // write data command fifo{{{
  l2_cmd_fifo #(.WIDTH($clog2(N_MSHR)), .DEPTH(N_MSHR))  W_FIFO(.*,
    .din(w_fifo_din),
    .we(w_fifo_we),
    .re(w_fifo_re),
    .empty(w_fifo_empty),
    .dout(w_fifo_dout)); // }}}

  // read address command fifo{{{
  l2_cmd_fifo_2w #(.WIDTH($clog2(N_MSHR)), .DEPTH(N_MSHR)) AR_FIFO(.*,
    .din0(ar_fifo_din[0]),
    .din1(ar_fifo_din[1]),
    .we0(ar_fifo_we[0]),
    .we1(ar_fifo_we[1]),
    .re(ar_fifo_re),
    .empty(ar_fifo_empty),
    .dout(ar_fifo_dout)); // }}}
  // }}}

  //==========================================================
  // FIFO interface
  // {{{

  //==========================================================
  // ar fifo interface
  //==========================================================
  logic  write_miss_no_write_alloc;
  mshr_t mshr_req;

  // Initiate a mem read for three cases.
  // Port0:
  // 1. read/write miss and the allocated $line is clean
  // 2. write miss in no write allocate mode  
  // Port1:
  // 3. finished write back
  assign ar_fifo_we[0]  = req_ff.valid & ~dirty & (req_ff.no_write_alloc & req_ff.rw | ~req_ff.flush);
  assign ar_fifo_we[1]  = l2_resp_if_bvalid;
  // req_ff.id is allocated mshr entry ID
  assign ar_fifo_din[0] = req_ff.id;
  // l2_resp_if_b.bid should match with l2_req_if_w.wid[1:0], which is originated from w_fifo_dout 
  // which is the allocated mshr entry ID
  assign ar_fifo_din[1] = l2_resp_if_b.bid[MSHR_ID_WIDTH-1:0]; 
  // Proceed to next mem read for following cases
  // 1. ar channel handshake completed
  // 2. the initiated mem read is originated from a flush request(flush miss dirty?) 
  //    which means the corresponding mshr_bank[ar_fifo_dout] is a flush
  // 3. the inititated mem read is originated from a write miss in no write allocate mode
  //     and the data/tag ram is ready for the corresponding way_id, which is the replace_way_id at s2 
  always_comb begin
    ar_fifo_re = l2_req_if_arvalid  & l2_req_if_arready 				  | 
				 mshr_req.valid & mshr_req.flush & ~ar_fifo_empty |
			     write_miss_no_write_alloc & req_ram_ready & tag_ram_wready_pway[mshr_req.way_id];
  end
  // mshr_req  => mshr_bank[ar_fifo_dout] 
  assign write_miss_no_write_alloc = mshr_req.valid & mshr_req.rw & mshr_req.no_write_alloc & ~ar_fifo_empty;
 
  //==========================================================
  // aw fifo interface
  //==========================================================
  // Initiate a write back when a miss request occurs and the allocated $line is dirty, 
  // the allocated way_id is flop version of v.s3.way_id 
  assign aw_fifo_we  = req_ff.valid & dirty;
  // Allocated mshr entry ID for the req initiated the mem write 
  assign aw_fifo_din = req_ff.id;
  // Proceed to next mem write when aw channel handshake completed
  assign aw_fifo_re  = l2_req_if_awvalid & l2_req_if_awready;

  //==========================================================
  // w fifo interface
  //==========================================================
  // Initiate a write back data when a miss request occurs and the allocated $line is dirty, 
  // the allocated way_id is flop version of v.s3.way_id 
  assign w_fifo_we  = req_ff.valid & dirty; 
  // allocated mshr entry ID for the req initiated the mem write 
  assign w_fifo_din = req_ff.id;
  // Proceed to next mem write when w channel handsake completed for either first or last burst
  assign w_fifo_re  = (~mem_req_ff.wdata_pipe.wvalid | l2_req_if_w.wlast) & l2_req_if_wvalid & l2_req_if_wready; 

  // }}}
  //==========================================================
  // Data collision from Mem NOC
  //==========================================================
  // {{{

  // data collision: mem_data -> cpu_data
  cpu_data_t rdata_coll;
  logic      rdata_coll_valid;

  localparam OFFSET_DELTA_WIDTH = MEM_OFFSET_WIDTH;
  logic 	 [OFFSET_DELTA_WIDTH-1:0] 	 coll_cntr_ff;
  mem_data_t [2**OFFSET_DELTA_WIDTH-1:0] rdata_ff;

  always_ff @ (posedge clk) begin
    if (~rst) begin
      coll_cntr_ff <= '0;
    end else if (l2_resp_if_rvalid & l2_resp_if_rready) begin
      coll_cntr_ff <= coll_cntr_ff + 1;
      rdata_ff[coll_cntr_ff] <= l2_resp_if_r.rdata;
    end
  end

  always_comb begin
    rdata_coll[CPU_DATA_WIDTH-1 -: MEM_DATA_WIDTH] = l2_resp_if_r.rdata;
    for (int i=0; i<2**OFFSET_DELTA_WIDTH-1; i++)
      rdata_coll[i*MEM_DATA_WIDTH +: MEM_DATA_WIDTH] = rdata_ff[i];
    rdata_coll_valid = (coll_cntr_ff == '1);
  end
  // }}}
  //==========================================================
  // Mem-NOC interface
  // {{{

  //==========================================================
  // AR channel
  //==========================================================
  always_comb begin
  // req to MEM NOC, addressed by output from read_address_fifo
    mshr_req = mshr_bank[ar_fifo_dout]; 
    mshr_req.valid &= ~ar_fifo_empty;
  end
  // As long as there is mem read req in ar_fifo and it's not a flush in mshr_bank[ar_fifo_dout]  
  // Basically drive ar channel for read or standard write allocate case. 
  // 1-cycle gap between consecutive l2_req_if_arvalid due to dff_ar_fifo_re 
  assign l2_req_if_arvalid = ~ar_fifo_empty & ~mshr_req.no_write_alloc & ~mshr_req.flush & ~ar_fifo_re_ff; 
  // new_tag[16:15], the tag coming with req at the very first beginning + allocated mshr entry ID
  assign l2_req_if_ar.arid = {mshr_req.new_tag[DRAM_TAG_WIDTH-1 -: 2], ar_fifo_dout};
  // tag + index that coming with req at the very first beginning 
  assign l2_req_if_ar.araddr  = {mshr_req.new_tag, mshr_req.bank_index, BANK_ID_WIDTH'(BANK_ID), {CACHE_OFFSET_WIDTH{1'b0}}};
  // read a full burst from memory(2'b11)
  assign l2_req_if_ar.arlen   = 4'h3;

  //==========================================================
  // R channel  
  //==========================================================
  always_comb begin
    // resp from MEM NOC, addressed by rid
    mshr_resp = mshr_bank[l2_resp_if_r.rid[MSHR_ID_WIDTH-1:0]]; 
    mshr_resp.valid &= l2_resp_if_rvalid;
  end
  // write some assertions to check rready, can't refill cacheline while retiring no_write_alloc and flush transactions
  // 1. If no write allocate, use the MSHR data path (the MC port) to write the cache data ram. Similar things happen with flush.
  //    If we don't do non write allocate optimization and flush, we know the cache data ram MC port is free to receive read response 
  //	data from DRAM.
  // 2. If read response hit another way (not the same way non-write-allocate/flush is working on), we don't have a structure hazard 
  //	on the MC port as it's in a different way. rlast is to make sure there is not structure hazard on the tag ram. The last 
  //	read burst will update the cache tag (new tags, valid, dirty bit and etc.).  'empty' means if mshr_req.way is not valid, i.e. 
  //	there is no valid transaction in front of the ar_fifo (mshr_req) that is requesting cache data ram access (no MC port hazard at all).
  // 3. Not sure this is redundant, but safe to keep here. If the mshr_req side is requesting a busy ram (e.g. servicing request on the 
  //	CC port or transactions from OURS bus), bypass all aforementioned checks (req/resp structure hazard check on the MC port). 
  //	If the resp side request the same ram, it will be captured by " &  resp_data_ram_ready" following this clause.
  // 4. if there is no mshr_req, then don't bother
  // 	Still proceed if write no allocate hit a differet way but not the final burst (update tag rams)
  // primary output to Mem NOC
  always_comb begin
	l2_resp_if_rready = resp_ram_ready & (mshr_resp.valid & mshr_resp.rw | cpu_resp_ready) & 
			       ((~mshr_req.no_write_alloc & ~mshr_req.flush) 									                | // case 1 
					((mshr_req.way_id != mshr_resp.way_id) & mshr_resp.valid & (~rdata_coll_valid | ar_fifo_empty))	| // case 2
					  ~req_ram_ready																                | // case 3
					   ar_fifo_empty);																                  // case 4
					
  end

  // Check if the data ram is available for the victim way
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]]
  // rid	   => l2_req_if_ar.arid
  // l2_req_if_ar.arid   => tag[19:18] coming with req at the very first beginning + allocated mshr entry ID(ar_fifo_dout)
  // way_id    => replace_way_id at s2
  // TODO: it seems tag/mc_data_ram_ready_pway is tied to all 1s. No need to check?
  assign resp_ram_ready = data_ram_ready_pway[mshr_resp.way_id] & tag_ram_wready_pway[mshr_resp.way_id] | ~mshr_resp.valid;
  // mshr_req  => mshr_bank[ar_fifo_dout]
  // way_id    => replace_way_id at s2
  assign req_ram_ready  = data_ram_ready_pway[mshr_req.way_id] | ~mshr_req.valid;   // for no_write_allocate


  //==========================================================
  // AW channel
  //==========================================================
  mshr_t  mshr_aw;
  assign  mshr_aw		= mshr_bank[aw_fifo_dout];
  assign  l2_req_if_awvalid 	= ~aw_fifo_empty & ~aw_fifo_re_ff; // remove dependency from w channel
  // cc_tag_pway[replace_way_id][16:15] + allocated mshr entry ID(ar_fifo_dout)
  assign  l2_req_if_aw.awid  		= {mshr_aw.old_tag[DRAM_TAG_WIDTH-1 -: 2], aw_fifo_dout};
  // mshr_bank[aw_fifo_dout]'s old tag, which is cc_tag_pway[replace_way_id] + bank_index
  assign  l2_req_if_aw.awaddr 	= {mshr_aw.old_tag, mshr_aw.bank_index, BANK_ID_WIDTH'(BANK_ID), {CACHE_OFFSET_WIDTH{1'b0}}};
  // write a full burst to memory
  assign  l2_req_if_aw.awlen 		= 4'h3;

  //==========================================================
  // W channel
  //==========================================================
  logic 	 data_ram_re, 	   data_ram_re_ff;
  cpu_data_t data_ram_dout_ff, data_ram_dout;
  mshr_t  	 mshr_w;
  assign  mshr_w 		= mshr_bank[w_fifo_dout];
  //?? v.wdata_pipe.wvalid ?? 
  assign  l2_req_if_wvalid = mem_req_ff.wdata_pipe.wvalid & mem_req_nxt.wdata_pipe.wvalid & ~w_fifo_re_ff;
  // mshr_bank[w_fifo_dout]'s old tag[16:15], which is cc_tag_pway[replace_way_id][19:18] + allocated mshr entry ID
  assign  l2_req_if_w.wid   = {mshr_bank[w_fifo_dout].old_tag[DRAM_TAG_WIDTH-1 -:2], w_fifo_dout};  
  // send 256-bit data over 4 cycles  
  assign  l2_req_if_w.wdata = data_ram_re_ff ? data_ram_dout[MEM_DATA_WIDTH*mem_req_ff.wdata_offset +: MEM_DATA_WIDTH] : 
										   data_ram_dout_ff[MEM_DATA_WIDTH*mem_req_ff.wdata_offset +: MEM_DATA_WIDTH];
  assign  l2_req_if_w.wlast = &mem_req_ff.wdata_offset; 
  // victim way's data: mshr_bank[w_fifo_dout]'s way ID, which is replace_way_id at s2
  assign data_ram_dout  = data_ram_dout_pway[mshr_w.way_id];

  //==========================================================
  // B channel
  //==========================================================
  assign l2_resp_if_bready = '1;

  // }}}
  //==========================================================
  // SRAM interface
  // {{{

  //==========================================================
  // valid ram interface
  //==========================================================
  logic last_burst_accepted;

  assign last_burst_accepted  	   = l2_resp_if_rvalid  & rdata_coll_valid & l2_resp_if_rready;
  // Udpate valid ram for either last burst accepted or write miss initiated mem read in no wirte alloc mode
  assign valid_ram_we    = last_burst_accepted | write_miss_no_write_alloc & ar_fifo_re;
  // For no write allocate mode: use mshr_bank[ar_fifo_dout]'s index 
  // Otherwise: use mshr_bank[rid[MSHR_ID_WIDTH-1:0]], rid is 
  // allocated mshr entry ID for the req which initiated the mem read 
  assign valid_ram_waddr = write_miss_no_write_alloc ? mshr_req.bank_index : mshr_resp.bank_index;
  always_comb begin
  // mshr_req  => mshr_bank[ar_fifo_dout] 
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]]
  // way_id    => replace_way_id at s2 
	for (int i=0; i<N_WAY; i++) begin
   		valid_ram_bwe[i] = write_miss_no_write_alloc ? (mshr_req.way_id  == WAY_ID_WIDTH'(i)) : 
						   last_burst_accepted 		 ? (mshr_resp.way_id == WAY_ID_WIDTH'(i)) : 1'b0;
							
   	end
  end
  assign valid_ram_din = {N_WAY{1'b1}};

  //==========================================================
  // tag ram interface
  //==========================================================
  // do tag write 1. write miss in no_write_alloc
  //			  2. response data last burst accepted
  always_comb begin	
  // mshr_req  => mshr_bank[ar_fifo_dout] 
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]]
  // rid	   => l2_req_if_ar.arid
  // way_id    => replace_way_id at s2 
  // new_tag   => the tag coming with req at the very first beginning
	for (int i=0; i<N_WAY; i++) begin
		tag_ram_we_pway[i] = write_miss_no_write_alloc ? (mshr_req.way_id  == WAY_ID_WIDTH'(i)) :
							 last_burst_accepted       ? (mshr_resp.way_id == WAY_ID_WIDTH'(i)) : 1'b0;
	end
  end
  assign tag_ram_din   = write_miss_no_write_alloc ? mshr_req.new_tag    : mshr_resp.new_tag; 
  assign tag_ram_waddr = write_miss_no_write_alloc ? mshr_req.bank_index : mshr_resp.bank_index;

  //==========================================================
  // dirty ram interface
  //==========================================================
  logic flush_req;
  // mshr_req  => mshr_bank[ar_fifo_dout]
  assign flush_req    = mshr_req.valid & mshr_req.flush & ~ar_fifo_empty;
  // updates dirty ram for three cases.
  // 1. the req which initiated mem read is a flush
  // 2. write miss in no write alloc mode and proceed to next mem read in next cycle
  // 3. last burst data accepted 
  assign dirty_ram_we = flush_req 				  ? 1'b1  	   :  
						write_miss_no_write_alloc ? ar_fifo_re :
						last_burst_accepted		  ? 1'b1	   : 1'b0;
  // mshr_req  => mshr_bank[ar_fifo_dout] 
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]] 
  // rid	   => l2_req_if_ar.arid
  // l2_req_if_ar.arid   => tag[19:18] coming with req at the very first beginning + allocated mshr entry ID(ar_fifo_dout)
  // way_id    => replace_way_id at s2 
  assign dirty_ram_waddr = (write_miss_no_write_alloc | flush_req) ?  mshr_req.bank_index : mshr_resp.bank_index;
  assign dirty_ram_din   = flush_req ? 1'b0 : mshr_resp.rw;
  always_comb begin
	for (int i=0; i<N_WAY; i++) begin
  	 	dirty_ram_bwe[i] = (write_miss_no_write_alloc | flush_req) ? (mshr_req.way_id  == WAY_ID_WIDTH'(i)) :
							last_burst_accepted		 			   ? (mshr_resp.way_id == WAY_ID_WIDTH'(i)) : 1'b0;
    end
  end

  //==========================================================
  // data ram interface
  //==========================================================
  logic 		[N_WAY-1:0] data_ram_we_pway, data_ram_re_pway;
  logic 					wlast_ff;
  bank_index_t  [N_WAY-1:0] data_ram_bank_index_pway_w;
  bank_index_t 				data_ram_bank_index_r;
 
  // Both read and write enable can't be asserted at same time 
  assign data_ram_en_pway = data_ram_we_pway | data_ram_re_pway;
  assign data_ram_rw_pway = data_ram_we_pway;

  // Read data ram when either first or after last burst received 
  always_comb begin
  // mshr_w => mshr_bank[w_fifo_dout] 
  // way_id => replace_way_id at s2 
	for (int i=0; i<N_WAY; i++) begin
 		data_ram_re_pway[i] = (~mem_req_ff.wdata_pipe.wvalid | wlast_ff) & ~w_fifo_empty & (mshr_w.way_id == WAY_ID_WIDTH'(i)) & mem_req_nxt.wdata_pipe.wvalid;
    end
  end
  // Write data ram when either write miss in no write alloc mode or last burst asserted 
  // mshr_req  => mshr_bank[ar_fifo_dout] 
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]] 
  // rid	   => arid
  // arid	   => tag[19:18] coming with req at the very first beginning + allocated mshr entry ID(ar_fifo_dout)
  // way_id    => replace_way_id at s2
  // write_miss_no_write_alloc => mshr_req.valid & mshr_req.rw & mshr_req.no_write_alloc & ~ar_fifo_empty 
  always_comb begin
	for (int i=0; i<N_WAY; i++) begin
		data_ram_we_pway[i] = write_miss_no_write_alloc          ? (mshr_req.way_id  == WAY_ID_WIDTH'(i)) : 
							 (l2_resp_if_rvalid  & rdata_coll_valid) ? (mshr_resp.way_id == WAY_ID_WIDTH'(i)) : 1'b0;
    end
  end
  // Data to data_ram
  // mshr_req  => mshr_bank[ar_fifo_dout] 
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]] 
  // rid	   => arid
  // arid	   => tag[19:18] coming with req at the very first beginning + allocated mshr entry ID(ar_fifo_dout)
  // way_id    => replace_way_id at s2
  always_comb begin
 	for (int i=0; i<N_WAY; i++) begin
	  if (write_miss_no_write_alloc & (mshr_req.way_id == WAY_ID_WIDTH'(i))) begin
		data_ram_din_pway[i] = {mshr_req.data, mshr_req.data};
	  end
 	  else if (mshr_resp.rw & rdata_coll_valid) begin
		for (int j=0; j<CPU_DATA_WIDTH/8; j++) begin
		  if (mshr_resp.byte_mask[j])
			// gets data from the req(write miss) which initiated the mem read
			data_ram_din_pway[i][j*8 +: 8] = mshr_resp.data[j*8 +: 8];	
		  else
    		// gets data from Mem NOC (write allocate??) 
			data_ram_din_pway[i][j*8 +: 8] = rdata_coll[j*8 +: 8];	
		end
   	  end
	  else
		data_ram_din_pway[i] = rdata_coll;
  	end
  end
  // Index to data ram
  always_comb begin
    for (int i=0; i<N_WAY; i++) begin
      data_ram_bank_index_pway[i] = (data_ram_we_pway[i]) ? data_ram_bank_index_pway_w[i] : data_ram_bank_index_r;
    end
  end
  // Read index to data ram
  // mshr_w => mshr_bank[w_fifo_dout] 
  assign data_ram_bank_index_r = (~mem_req_ff.wdata_pipe.wvalid | wlast_ff) ? mshr_w.bank_index : mem_req_ff.wdata_pipe.waddr; 

  // Write index to data ram
  always_comb begin
	for (int i=0; i<N_WAY; i++) begin
		data_ram_bank_index_pway_w[i] = (write_miss_no_write_alloc & (mshr_req.way_id == WAY_ID_WIDTH'(i))) ? 
										 mshr_req.bank_index : mshr_resp.bank_index;
    end
  end

  // }}}
  //==========================================================
  // Primary output to CPU NOC
  //==========================================================
  // {{{
  assign cpu_resp 		= mem_req_nxt.rdata_pipe;
  assign cpu_resp_valid = mem_req_nxt.rdata_pipe_valid;
  // has to be one cycle earlier to stop cc side data-ram read??
  assign cache_read_hit_backpressure = (coll_cntr_ff == 'd2) | ((coll_cntr_ff == 'd3) & ~mem_req_nxt.rdata_pipe_valid);

  // }}}
  //==========================================================
  // Internal FSM 
  //==========================================================
  // {{{
  logic  read_done;
  assign read_done = mshr_req.valid & mshr_req.flush & ~ar_fifo_empty |
					 write_miss_no_write_alloc & ar_fifo_re			  |
					~write_miss_no_write_alloc & last_burst_accepted;

  // }}}
  //==========================================================
  // Response data pipe for CPU NOC 
  //==========================================================
  // {{{
  // Create read miss resp data bus for CPU NOC
  // mshr_resp => mshr_bank[rid[MSHR_ID_WIDTH-1:0]] 
  // rid	   => arid
  // arid	   => tag[19:18] coming with req at the very first beginning + allocated mshr entry ID(ar_fifo_dout)
  assign mem_req_nxt.rdata_pipe.data		= rdata_coll;
  assign mem_req_nxt.rdata_pipe.byte_mask = mshr_resp.byte_mask;
  assign mem_req_nxt.rdata_pipe.tid 		= mshr_resp.tid;
  // Response data pipe is valid when last burst received and the req which 
  // initiated this meme read is not a write(so it can be read)
  assign mem_req_nxt.rdata_pipe_valid     = last_burst_accepted & ~mshr_resp.rw;

  // }}}
  //==========================================================
  // Write back data pipe 
  //==========================================================
  // {{{
  // Pipe valid for write back data pipe. Valid asserted for following cases.
  // first or after last burst 
  // no new transactions, w_fifo_empty happends after w_fifo_re which is the last l2_req_if_wready
  // mshr_w => mshr_bank[w_fifo_dout]
  // way_id    => replace_way_id at s2
  always_comb begin
    mem_req_nxt.wdata_pipe.wvalid = w_fifo_empty 					  ? 1'b0 																  : 
		(~mem_req_ff.wdata_pipe.wvalid | wlast_ff) & ~w_fifo_empty ? data_ram_ready_pway[mshr_w.way_id] & ~data_ram_we_pway[mshr_w.way_id] :
														    mem_req_ff.wdata_pipe.wvalid;
  end
  // Counter to indicate how many chunk of write back data is accepted. Updates it for
  // 1. W channel handshake completed, reset the offset
  // 2. Handshake completed and write data pipe is valid and not prceed to next mem write, increment offset  
  always_comb begin
    mem_req_nxt.wdata_offset = ((~mem_req_ff.wdata_pipe.wvalid | l2_req_if_w.wlast) & l2_req_if_wready) ? {MEM_OFFSET_WIDTH{1'b0}} :
					 (l2_req_if_wready & mem_req_ff.wdata_pipe.wvalid & ~w_fifo_re_ff)  ?  mem_req_ff.wdata_offset + 1      : mem_req_ff.wdata_offset;
  end
  // w_fifo_dout only changes when last transaction is over
  assign mem_req_nxt.wdata_pipe.wid = w_fifo_dout;
  // Read index to data ram to get the write back data updates index for following cases.
  // mshr_w     => mshr_bank[w_fifo_dout]
  // bank_index => l2_resp_if_r.s2.cpu_req.paddr.bank_index
  always_comb begin
    mem_req_nxt.wdata_pipe.waddr = (~mem_req_ff.wdata_pipe.wvalid | l2_req_if_w.wlast) 		& 		mem_req_nxt.wdata_pipe.wvalid 	&
	  				     (~w_fifo_empty & (~mem_req_ff.wdata_pipe.wvalid | (mem_req_ff.wdata_pipe.wvalid & l2_req_if_wready))) ?
						   data_ram_bank_index_pway[mshr_w.bank_index] : mem_req_ff.wdata_pipe.waddr;
  end
  // }}}
  //==========================================================
  // FSM for mshr bank valid (de-allocation) 
  //==========================================================
  logic case1, case2, case3;
  // De-allocate MSHR entry for thress cases 
  assign case1 = req_ff.valid & ~dirty & ~(req_ff.no_write_alloc & req_ff.rw) & req_ff.flush;
  assign case2 = read_done &  (~ar_fifo_empty & (mshr_bank[ar_fifo_dout].no_write_alloc | mshr_bank[ar_fifo_dout].flush));
  assign case3 = read_done & ~(~ar_fifo_empty & (mshr_bank[ar_fifo_dout].no_write_alloc | mshr_bank[ar_fifo_dout].flush));
  always_comb begin
	for (int i=0; i<N_MSHR; i++) begin
		new_mshr_bank_valid[i] = (mshr_bank[i].valid | new_mshr.valid & (new_mshr_id == $clog2(N_MSHR)'(i))) &
								  ~(case1 & (req_ff.id == $clog2(N_MSHR)'(i))) 								 &  // flush hit clean
								  ~(case2 & (ar_fifo_dout == $clog2(N_MSHR)'(i)))							 &  // flush hit dirty
							      ~(case3 & (l2_resp_if_r.rid[MSHR_ID_WIDTH-1:0] == $clog2(N_MSHR)'(i)));					// read/write miss with clean/dirty
    end
  end

  // }}}
  // checks
`ifndef SYNTHESIS
  chk_read_rid: assert property (@(posedge clk) disable iff (~rst) l2_resp_if_rvalid |-> mshr_bank[l2_resp_if_r.rid[MSHR_ID_WIDTH-1:0]].valid) else `olog_error("L2_MSHR", $sformatf("%m: MSHR sees a read response not recognized from DRAM"));
`endif
  // }}}


  //==========================================================
  // write data state machine

  assign data_ram_re = (|data_ram_re_pway);
  always_ff @ (posedge clk) begin
    data_ram_re_ff <= data_ram_re;
    if (data_ram_re_ff)
      data_ram_dout_ff <= data_ram_dout;
  end

  always_ff @ (posedge clk) begin
    wlast_ff <= l2_req_if_wvalid & l2_req_if_w.wlast & l2_req_if_wready;
  end

  //==========================================================
`ifndef SYNTHESIS
  chk_new_mshr_valid: assert property (@(posedge clk) disable iff (~rst !== '0) (new_mshr.valid |-> (mshr_bank[new_mshr_id].valid == '0)))
    else `olog_fatal("MSHR", $sformatf("%m: new_mshr to a already valid mshr entry"));
`endif

  always_ff @ (posedge clk) begin
    if (~rst) begin
      req_ff.valid <= '0;
      mem_req_ff.wdata_pipe.wvalid <= '0;
      mem_req_ff.wdata_pipe.waddr <= '0;
      mem_req_ff.wdata_offset <= '0;
      mem_req_ff.rdata_pipe_valid <='0;

      for (int i=0;i<N_MSHR;i++) begin
        mshr_bank[i] <= '0;
        //mshr_bank[i].valid <= '0;
        //mshr_bank[i].rw <= '0;
        //mshr_bank[i].flush <= '0;
        //mshr_bank[i].no_write_alloc <= '0;
        //mshr_bank[i].bank_index <= '0;
        //mshr_bank[i].way_id <= '0;
      end
    end else begin
      req_ff.valid <= new_mshr.valid;
      mem_req_ff   <= mem_req_nxt;

      if (new_mshr.valid) begin
        req_ff.id <= new_mshr_id;
        req_ff.rw <= new_mshr.rw;
        req_ff.flush <= new_mshr.flush;
        req_ff.no_write_alloc <= new_mshr.no_write_alloc;
      end

      for (int i=0; i<N_MSHR; i++)
        mshr_bank[i].valid <= new_mshr_bank_valid[i];

      if (new_mshr.valid)
        mshr_bank[new_mshr_id] <= new_mshr;
    end

      ar_fifo_re_ff <= ar_fifo_re;
      aw_fifo_re_ff <= aw_fifo_re;
      w_fifo_re_ff  <= w_fifo_re;
  end

`ifndef SYNTHESIS
  import ours_logging::*;
  chk_mshr_valid: assert property (@(posedge clk) disable iff (~rst) new_mshr.valid |-> ~mshr_bank[new_mshr_id].valid) else `olog_error("L2_MSHR", $sformatf("%m: MSHR allocation error entry %d is not clean", new_mshr_id));

  generate
    for (genvar i=0; i<N_MSHR; i++) begin
      for (genvar j=i+1; j<N_MSHR; j++) begin
        property chk_mshr_not_the_same;
          @(posedge clk) disable iff (~rst)
            (mshr_bank[i].valid & mshr_bank[j].valid) |-> (
              ((mshr_bank[i].tid != mshr_bank[j].tid) | mshr_bank[i].rw | mshr_bank[j].rw) // tid can overlap if it's a write request (tid is only used for distinguish response back in cpu, write don't response)
              & ~((mshr_bank[i].way_id == mshr_bank[j].way_id) & (mshr_bank[i].bank_index == mshr_bank[j].bank_index)) // way_id & bank_index cannot be the same
            );
        endproperty
        assert property (chk_mshr_not_the_same) else `olog_error("L2_MSHR", $sformatf("%m: same mshr entry found"));
      end
    end
  endgenerate

  generate
    for (genvar i=0; i<N_MSHR; i++) begin
      int mshr_waiting_cycle = 0;
      always @ (posedge clk) begin
        if (mshr_bank[i].valid === '1) begin
          mshr_waiting_cycle++;
          assert (mshr_waiting_cycle < 100000) else `olog_fatal("L2_MSHR", $sformatf("%m: mshr %d has waited for 100000 cycles", i));
        end else
          mshr_waiting_cycle = 0;
      end
    end
  endgenerate
// ES1Y-141
//  chk_arvalid_gap: assert property (@(posedge clk) disable iff (~rst !== '0) ((l2_req_if_arvalid & l2_req_if_arready) |=> ~l2_req_if_arvalid)) else `olog_error("L2_MSHR", $sformatf("%m: to meet mem noc's requirement, need 1 cycle gap between consecutive requests on AR"));
//  chk_awvalid_gap: assert property (@(posedge clk) disable iff (~rst !== '0) ((awvalid & l2_req_if_awready) |=> ~awvalid)) else `olog_error("L2_MSHR", $sformatf("%m: to meet mem noc's requirement, need 1 cycle gap between consecutive requests on AW"));
//  chk_wvalid_gap: assert property (@(posedge clk) disable iff (~rst !== '0) ((wvalid & l2_req_if_wready & l2_req_if_w.wlast) |=> ~wvalid)) else `olog_error("L2_MSHR", $sformatf("%m: to meet mem noc's requirement, need 1 cycle gap between consecutive requests on W"));
//
  bit [$clog2(N_MSHR)+1:0]  bid, rid;
  bit [$clog2(N_MSHR)+1:0]  awid_q[$];
  bit [$clog2(N_MSHR)+1:0]  wid_q[$];
  bit [$clog2(N_MSHR)+1:0]  arid_q[$];
  bit [PHY_ADDR_WIDTH-1:0]  awaddr_array[int];
  bit [PHY_ADDR_WIDTH-1:0]  araddr_array[int];
  int qi[$];
  always @ (posedge clk) begin
    if ((l2_req_if_awvalid & l2_req_if_awready) === '1) begin
      assert (!$isunknown(l2_req_if_aw.awid)) else `olog_error("L2_MSHR", $sformatf("%m: awid is X"));
      awid_q.push_front(l2_req_if_aw.awid);
      awaddr_array[l2_req_if_aw.awid] = {l2_req_if_aw.awaddr, 3'(BANK_ID), 5'h00};
      `olog_info("L2_MSHR", $sformatf("%m: awid=%h%h awaddr=%h", 3'(BANK_ID), l2_req_if_aw.awid, {l2_req_if_aw.awaddr, 3'(BANK_ID), 5'h00}));
    end

    if ((l2_req_if_wvalid & l2_req_if_wready) === '1) begin
      assert (!$isunknown(l2_req_if_w.wid)) else `olog_error("L2_MSHR", $sformatf("%m: wid is X"));
      wid_q.push_front(l2_req_if_w.wid);
      `olog_info("L2_MSHR", $sformatf("%m: wid=%h%h awaddr=%h wdata=%h", 3'(BANK_ID), l2_req_if_w.wid, awaddr_array[l2_req_if_w.wid], l2_req_if_w.wdata));
    end

    if ((l2_req_if_arvalid & l2_req_if_arready) === '1) begin
      assert (!$isunknown(l2_req_if_ar.arid)) else `olog_error("L2_MSHR", $sformatf("%m: arid is X"));
      for (int i=0; i<4; i++) begin
        arid_q.push_front(l2_req_if_ar.arid);
        araddr_array[l2_req_if_ar.arid] = {l2_req_if_ar.araddr, 3'(BANK_ID), 5'h00};
      end
      `olog_info("L2_MSHR", $sformatf("%m: arid=%h%h araddr=%h", 3'(BANK_ID), l2_req_if_ar.arid, {l2_req_if_ar.araddr, 3'(BANK_ID), 5'h00}));
    end

    if ((l2_resp_if_bvalid & l2_resp_if_bready) === '1) begin
      assert (!$isunknown(l2_resp_if_b.bid)) else `olog_error("L2_MSHR", $sformatf("%m: bid is X"));
      bid = l2_resp_if_b.bid;
      `olog_info("L2_MSHR", $sformatf("%m: bid=%h%h awaddr=%h", 3'(BANK_ID), l2_resp_if_b.bid, awaddr_array[l2_resp_if_b.bid]));

      qi = awid_q.find_index with (item == bid);
      assert ($size(qi) == 1) 
        awid_q.delete(qi[0]);
      else
        `olog_error("L2_MSHR", $sformatf("%m: bid-vs-awid bid=%h%h num_of_matching_awid=%d", 3'(BANK_ID), bid, $size(qi)));

      for (int i=4; i>0; i--) begin
        qi = wid_q.find_index with (item == bid);
        assert ($size(qi) == i)
          wid_q.delete(qi[0]);
        else
          `olog_error("L2_MSHR", $sformatf("%m: bid-vs-wid bid=%h%h num_of_matching_wid=%d", 3'(BANK_ID), bid, $size(qi)));
      end
    end

    if ((l2_resp_if_rvalid & l2_resp_if_rready) === '1) begin
      assert (!$isunknown(l2_resp_if_r.rid)) else `olog_error("L2_MSHR", $sformatf("%m: rid is X"));
      rid = l2_resp_if_r.rid;
      `olog_info("L2_MSHR", $sformatf("%m: rid=%h%h araddr=%h rdata=%h", 3'(BANK_ID), l2_resp_if_r.rid, araddr_array[l2_resp_if_r.rid], l2_resp_if_r.rdata));

      qi = arid_q.find_index with (item == rid);
      assert ($size(qi) >= 1)
        arid_q.delete(qi[0]);
      else
        `olog_error("L2_MSHR", $sformatf("%m: rid-vs-arid rid=%h%h num_of_matching_rid=%d", 3'(BANK_ID), rid, $size(qi)));
    end
  end

  final begin
    foreach (awid_q[i])
      `olog_warning("L2_MSHR", $sformatf("%m: still-in-q awid=%h%h", 3'(BANK_ID), awid_q[i]));
    foreach (wid_q[i])
      `olog_warning("L2_MSHR", $sformatf("%m: still-in-q wid=%h%h", 3'(BANK_ID), wid_q[i]));
    foreach (arid_q[i])
      `olog_warning("L2_MSHR", $sformatf("%m: still-in-q arid=%h%h", 3'(BANK_ID), arid_q[i]));
    for (int i=0; i<N_MSHR; i++)
      if (mshr_bank[i].valid)
        `olog_warning("L2_MSHR", $sformatf("%m: still-in-q mshr_bank[%d] is valid", i));
  end

`endif

endmodule
