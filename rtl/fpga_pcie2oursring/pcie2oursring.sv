//README
/*
For Single Write Operation :
1. Configure Write operation with AXI AW to CFG_ADDR with WDATA = Dont Care  + Write Address[63:0]. AWLEN = 0
2. D0 AXI AW operation AWADDR=EXEC, WDATA= data that needs to be sent out. WLAST = 1'b1

For Burst of n  Write Operation :
1. Same as single Write
2. D0 AXI AW operation with AWLEN = n-1. And keep sending Wdata bursts compliant with AXI protocol. AWADDR=EXEC. Wdata = data that needs to be sent out.

For Single Read Operation:
1. Configure Read Address with a AXI AW to CFG_ADDR with WDATA = READ address +CMD. AWLEN = 0
2. Do AXI AR to EXE_ADDR. AWLEN = 0

For Burst Read operation:
1. Same as single Read. AWLEN = 0
2. Do AXI AR Burst of n by setting ARLEN to n-1. Expect to get n Rdata with the last Rdata to have RLAST = 1 
*/

module pcie2oursring
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
#( 
  parameter MASTER_DATA_WIDTH = 512,
  parameter MASTER_ADDR_WIDTH = 64,
  parameter MASTER_TID_WIDTH  = 8,
  parameter MASTER_RSP_WIDTH  = 2,
  parameter MASTER_LEN_WIDTH  = 8,
  parameter STATION_ID_WIDTH  = 8,
  parameter STATION_ID        = 8'b10101010
)
(
  // AXI Slave
  // aw
  input  logic                              slave_req_awvalid,
  input  logic [MASTER_ADDR_WIDTH - 1 : 0]  slave_req_awaddr,
  input  logic [MASTER_TID_WIDTH - 1 : 0]   slave_req_awid,
  input  logic [MASTER_LEN_WIDTH - 1 : 0]   slave_req_awlen,
  output logic                              slave_req_awready,
  // w
  input  logic                              slave_req_wvalid,
  input  logic                              slave_req_wlast,
  input  logic [MASTER_DATA_WIDTH - 1 : 0]  slave_req_wdata,
  input  logic [(MASTER_DATA_WIDTH/8)-1:0]  slave_req_wstrb,
  output logic                              slave_req_wready,
  // b
  output logic                              slave_rsp_bvalid,
  output logic [MASTER_TID_WIDTH - 1 : 0]   slave_rsp_bid,
  output logic [MASTER_RSP_WIDTH - 1 : 0]   slave_rsp_bresp,
  input  logic                              slave_rsp_bready,
  // ar
  input  logic                              slave_req_arvalid,
  input  logic [MASTER_ADDR_WIDTH - 1 : 0]  slave_req_araddr,
  input  logic [MASTER_TID_WIDTH - 1 : 0]   slave_req_arid,
  input  logic [MASTER_LEN_WIDTH - 1 : 0]   slave_req_arlen,
  output logic                              slave_req_arready,
  // r
  output logic                              slave_rsp_rvalid,
  output logic                              slave_rsp_rlast,
  output logic [MASTER_TID_WIDTH - 1 : 0]   slave_rsp_rid,
  output logic [MASTER_DATA_WIDTH - 1 : 0]  slave_rsp_rdata,
  output logic [MASTER_RSP_WIDTH - 1 : 0]   slave_rsp_rresp,
  input  logic                              slave_rsp_rready,

  // OURSRING Master
  // aw
  output logic                              or_req_awvalid,
  output oursring_req_if_aw_t               or_req_aw,
  input  logic                              or_req_awready,
  // w
  output logic                              or_req_wvalid,
  output oursring_req_if_w_t                or_req_w,
  input  logic                              or_req_wready,
  // b
  input  logic                              or_rsp_bvalid,
  input  oursring_resp_if_b_t               or_rsp_b,
  output logic                              or_rsp_bready,
  // ar
  output logic                              or_req_arvalid,
  output oursring_req_if_ar_t               or_req_ar,
  input  logic                              or_req_arready,
  // r
  input  logic                              or_rsp_rvalid,
  input  oursring_resp_if_r_t               or_rsp_r,
  output logic                              or_rsp_rready,

  // Misc
  input  logic                              clk,
  input  logic                              rstn,
  input  logic                              or_clk,
  // Output
  output logic                              rst_out
  );

  // OURSRING Master
  // aw
  logic                              awvalid;
  oursring_req_if_aw_t               aw;
  logic                              awready;
  // w
  logic                              wvalid;
  oursring_req_if_w_t                w;
  logic                              wready;
  // b
  logic                              bvalid;
  logic                              dummy_bvalid;
  oursring_resp_if_b_t               b;
  logic                              bready;
  // ar
  logic                              arvalid;
  oursring_req_if_ar_t               ar;
  logic                              arready;
  // r
  logic                              rvalid;
  oursring_resp_if_r_t               r;
  logic                              rready;
  logic                              sw_rstn;

  enum logic [3:0] {IDLE, WRSP, RRSP_CFG, RRSP_EXE, RRSP_DBG, RRSP_DBG2, WREQ, WRDY, RREQ, RRDY} rff_st, next_st;
  struct packed {ring_data_t data; ring_addr_t addr; ring_tid_t tid;} dff_cfg, next_cfg;

  logic rff_rstn,nxt_rstn;
  assign rst_out = ~rff_rstn;
  
  localparam longint CFG_ADDR = 64'h0;
  localparam longint EXE_ADDR = 64'h100;
  localparam longint DBG_ADDR = 64'h200; // RD only
  localparam longint RST_ADDR = 64'h300;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_st <= IDLE;
      rff_rstn <= 1'b0;
    end else begin
      rff_st <= next_st;
      rff_rstn <= nxt_rstn;
    end
    dff_cfg <= next_cfg;
  end

   //! FIFO Depth has to be power of 2
  localparam int MAX_BURST = 32; 
  localparam int AW_ES1Y_DEPTH = (2); 
  localparam int AR_PCIE_DEPTH = (2*MAX_BURST);  
  localparam int AW_PCIE_DEPTH = (2*MAX_BURST);  
  localparam int W_ES1Y_DEPTH = (2); 
  localparam int W_PCIE_DEPTH = (2*MAX_BURST);  

  //! --------------AR-------------------
  logic                              ar_ibuf_arvalid;
  logic [MASTER_ADDR_WIDTH - 1 : 0]  ar_ibuf_araddr;
  logic [MASTER_TID_WIDTH - 1 : 0]   ar_ibuf_arid;
  logic [MASTER_LEN_WIDTH - 1 : 0]   ar_ibuf_arlen;
  logic                              ar_ibuf_arready;
  
  logic                              rep_arvalid;
  logic [MASTER_ADDR_WIDTH - 1 : 0]  rep_araddr;
  logic [MASTER_TID_WIDTH - 1 : 0]   rep_arid;
  logic [MASTER_LEN_WIDTH - 1 : 0]   rep_arlen;
  logic                              rep_arready;
  logic [MASTER_LEN_WIDTH+1:0]       ar_burst_cntr;
  logic [MASTER_LEN_WIDTH+1:0]       rff_ar_burst_cntr; 
  logic [MASTER_LEN_WIDTH+1:0]       r_burst_cntr;
  logic [MASTER_LEN_WIDTH+1:0]       rff_r_burst_cntr; 
  logic [MASTER_LEN_WIDTH - 1 : 0]   rff_arlen;
  logic [MASTER_LEN_WIDTH - 1 : 0]   c_arlen;
  
  ours_vld_rdy_buf #(.WIDTH(MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH), .DEPTH(AR_PCIE_DEPTH)) 
	ar_ibuf (.clk,
			 .rstn,
			 .slave_valid(slave_req_arvalid), 
			 .slave_info({slave_req_arid,slave_req_araddr,slave_req_arlen}), 	
			 .slave_ready(slave_req_arready),
			 .master_valid(ar_ibuf_valid), 
			 .master_info({ar_ibuf_arid,ar_ibuf_araddr,ar_ibuf_arlen}), 	
			 .master_ready(ar_ibuf_arready));
 
  always_ff @(posedge clk) begin
    if(~rstn)begin
      rff_ar_burst_cntr  <= {MASTER_LEN_WIDTH{1'b0}};
      rff_arlen         <= {MASTER_LEN_WIDTH{1'b0}};
    end
    else begin
      rff_arlen         <=  c_arlen;
      rff_ar_burst_cntr  <=  ar_burst_cntr;
    end
  end

  always_comb begin
    c_arlen = rff_arlen;
    ar_burst_cntr = rff_ar_burst_cntr;
    rep_arvalid = 1'b0;
    rep_araddr  = ar_ibuf_araddr;
    rep_arid    = ar_ibuf_arid;
    rep_arlen   = {MASTER_LEN_WIDTH{1'b0}};
    if(ar_ibuf_valid & (ar_burst_cntr=={MASTER_LEN_WIDTH{1'b0}}))begin
      c_arlen = ar_ibuf_arlen;
      ar_burst_cntr = (ar_ibuf_arlen + 1'b1);
    end 
    if((ar_burst_cntr > {MASTER_LEN_WIDTH{1'b0}}) & (rep_arready)) begin
      rep_arvalid = ar_ibuf_valid;
      ar_burst_cntr = (ar_burst_cntr - 1'd1);
    end
    if(ar_burst_cntr=={MASTER_LEN_WIDTH{1'b0}}) begin
      ar_ibuf_arready = 1'b1;
    end
    else begin
      ar_ibuf_arready = 1'b0;
    end
  end

  //! --------------R------------------- 
  always_ff @(posedge clk) begin
    if(~rstn) begin
      rff_r_burst_cntr <= {MASTER_LEN_WIDTH{1'b0}};
    end
    else begin
      rff_r_burst_cntr <= r_burst_cntr;
    end
  end
  always_comb begin
     r_burst_cntr = rff_r_burst_cntr;
     slave_rsp_rlast = 1'b0;
     if((rvalid & rready)) begin
       r_burst_cntr = r_burst_cntr + 1'd1;
     end
     if((slave_rsp_rvalid) & (r_burst_cntr < rff_arlen))begin
       slave_rsp_rlast = 1'b0;
     end
     else if (slave_rsp_rvalid)begin
       slave_rsp_rlast = 1'b1;
       r_burst_cntr = {MASTER_LEN_WIDTH+2{1'b0}};
     end
  end

  //! -------------AW & W-----------------
  logic aw_ibuf_valid_1;
  logic aw_ibuf_ready_1;
  logic [MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1:0] aw_ibuf_info_1;
  logic w_ibuf_valid_1;
  logic w_ibuf_ready_1;
  logic w_ibuf_wlast_1;
  logic [MASTER_DATA_WIDTH-1:0] w_ibuf_info_1;
  logic [(MASTER_DATA_WIDTH/8)-1:0] w_ibuf_wstrb_1;
  logic aw_ibuf_valid_2;
  logic aw_ibuf_ready_2;
  logic [MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1:0] aw_ibuf_info_2;
  logic w_ibuf_valid_2;
  logic w_ibuf_ready_2;
  logic w_ibuf_wlast_2;
  logic [MASTER_DATA_WIDTH-1:0] w_ibuf_info_2;
  logic [(MASTER_DATA_WIDTH/8)-1:0] w_ibuf_wstrb_2;
  logic aw_ibuf_valid, aw_ibuf_ready;
  logic [MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1:0] aw_ibuf_info;
  logic w_ibuf_valid, w_ibuf_ready;
  logic [MASTER_DATA_WIDTH-1:0] w_ibuf_info;
  logic [(MASTER_DATA_WIDTH/8)-1:0] w_ibuf_wstrb;
  logic w_ibuf_wlast;
  logic [MASTER_LEN_WIDTH:0] w_burst_len; 
  logic [MASTER_LEN_WIDTH-1:0] rff_w_burst_len;  //! Store Aw len for Bresp
  logic [MASTER_LEN_WIDTH+1:0] b_burst_cntr;
  logic [MASTER_LEN_WIDTH+1:0] rff_b_burst_cntr; 
  logic [MASTER_TID_WIDTH-1:0] rff_awid;
  logic [MASTER_TID_WIDTH-1:0] c_awid;
  enum logic [1:0] {ST_AW_IDLE,ST_AW_BUSY} cur_aw_st,nxt_aw_st;
  logic [MASTER_LEN_WIDTH+1:0] w_burst_cntr;
  logic [MASTER_LEN_WIDTH+1:0] rff_w_burst_cntr; 
  
  //! AW
  always_ff @(posedge clk) begin
    if(~rstn) begin
      rff_w_burst_len <= {MASTER_LEN_WIDTH+2{1'b0}};
      rff_awid <= {MASTER_TID_WIDTH{1'b0}};
      rff_w_burst_cntr <= {MASTER_LEN_WIDTH+2{1'b0}};
      cur_aw_st <= ST_AW_IDLE;
    end else begin
      rff_w_burst_len <= w_burst_len;
      rff_awid <= c_awid;
      cur_aw_st <= nxt_aw_st;
      rff_w_burst_cntr <= w_burst_cntr;
    end
  end

  function logic [MASTER_LEN_WIDTH+1:0] get_w_cntr;
    input logic [MASTER_LEN_WIDTH:0] len;
    input logic [(MASTER_DATA_WIDTH/8)-1:0] wstrb;
    logic [$clog2(MASTER_DATA_WIDTH/8)-1:0] cntr = {$clog2(MASTER_DATA_WIDTH/8){1'b0}};
    for(int i=0; i< (MASTER_DATA_WIDTH/8); i++) begin
      if(wstrb[i]) begin
        cntr++;
      end
    end
    //! TODO Enable this
    //get_w_cntr = (cntr + len + 1);
    get_w_cntr = (len + 1);
    `ifndef SYNTHESIS
      $display("%t [%m]: get_w_cntr=%0d cntr=%0d len=%0d wstrb=0x%0h",$time,(cntr+len+1),cntr,len,wstrb);
    `endif
  endfunction : get_w_cntr

  //! AW & W
  always_comb begin
    w_burst_len = rff_w_burst_len;
    c_awid = rff_awid;
    w_ibuf_ready_1 = 1'b0; 
    aw_ibuf_valid_2 = 1'b0;
    w_ibuf_valid_2 = 1'b0;
    aw_ibuf_ready_1 = 1'b0;
    nxt_aw_st = cur_aw_st;
    w_burst_cntr  = rff_w_burst_cntr;
    unique case(cur_aw_st)
      ST_AW_IDLE: begin
        if(aw_ibuf_valid_1 & w_ibuf_valid_1) begin
          w_burst_len  = aw_ibuf_info_1[MASTER_LEN_WIDTH-1:0];
          c_awid       = aw_ibuf_info_1[MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_TID_WIDTH];
          w_burst_cntr = get_w_cntr(w_burst_len,w_ibuf_wstrb_1);
          nxt_aw_st = ST_AW_BUSY;
          /*TODO Optimzation
           if(aw_ibuf_ready_2 & w_ibuf_ready_2) begin 
            w_burst_cntr--;
            dispatch_to_fifo2(aw_ibuf_info_1,w_ibuf_info_1,aw_ibuf_info_2,w_ibuf_info_2,w_ibuf_wstrb_2);
            aw_ibuf_valid_2 = 1'b1;
            w_ibuf_valid_2  = 1'b1;
          end
          if(w_burst_cntr == 'd0 )begin
            nxt_aw_st = ST_AW_IDLE;
          end else begin
            nxt_aw_st = ST_AW_BUSY;
          end
          */
        end 
      end
      default: begin
        if( aw_ibuf_ready_2 & w_ibuf_ready_2) begin 
          if(w_burst_cntr > 'd0)begin
            nxt_aw_st = ST_AW_BUSY;
            w_burst_cntr--;
          end
          else begin
            nxt_aw_st = ST_AW_IDLE;
            w_ibuf_ready_1  = 1'b1;
            if(w_ibuf_wlast_1)begin
              aw_ibuf_ready_1 = 1'b1;
            end 
          end
          dispatch_to_fifo2(aw_ibuf_info_1,w_ibuf_info_1,w_ibuf_wstrb_1,w_ibuf_wlast_1,aw_ibuf_info_2,w_ibuf_info_2,w_ibuf_wstrb_2,w_ibuf_wlast_2);
          aw_ibuf_valid_2 = 1'b1;
          w_ibuf_valid_2  = 1'b1;
        end
      end
    endcase    
 end

 always_ff @(posedge clk) begin
    if(~rstn) begin
      rff_b_burst_cntr <= {MASTER_LEN_WIDTH+2{1'b0}};
    end else begin
      rff_b_burst_cntr <= b_burst_cntr;
    end
  end

  //! B
  always_comb begin
     b_burst_cntr = rff_b_burst_cntr;
     slave_rsp_bvalid = 1'b0;
     if((bvalid & bready) | dummy_bvalid) begin
       b_burst_cntr = b_burst_cntr + 1'd1;
     end
     if((rff_st == WRSP) & (b_burst_cntr > rff_w_burst_len))begin
       slave_rsp_bvalid = 1'b1;
       b_burst_cntr = {MASTER_LEN_WIDTH+2{1'b0}};
     end
  end

  //! Push to Fifo 2 & pop from Fifo 1 for W
  //! Convert Burst to single transaction
  task dispatch_to_fifo2;
    input logic [MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1:0] aw_info_in;
    input logic [MASTER_DATA_WIDTH-1:0] w_info_in;
    input logic [(MASTER_DATA_WIDTH/8)-1:0] strb_in;
    input logic last_in;
    output logic [MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1:0] aw_info_out;
    output logic [MASTER_DATA_WIDTH-1:0] w_info_out;
    output logic [(MASTER_DATA_WIDTH/8)-1:0] strb_out;
    output logic last_out;
    logic [MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1:0] mask;
    logic [MASTER_DATA_WIDTH-1:0] dw_mask;
    mask = {MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH{1'b1}};
    mask = (mask << MASTER_LEN_WIDTH);
    aw_info_out = (aw_info_in & mask); //! Convert Burst to single transaction
    w_info_out =  w_info_in;
    strb_out = strb_in;
    last_out = last_in;
    /*TODO 
    1. Increment Addr appropriately and send out aw info
    2. Extract 64bit data based on Wstrb and place it in lower 64bit w info out.
    dw_mask = {MASTER_DATA_WIDTH{1'b0}};
    dw_mask = (dw_mask | 64'hffff_ffff_ffff_ffff);
    w_info_out = ((w_info_in >> (64*wstrb)) & dw_mask);
    */
  endtask : dispatch_to_fifo2

  ours_vld_rdy_buf #(.WIDTH(MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH), .DEPTH(AW_PCIE_DEPTH)) 
	aw_ibuf_1 (.clk,
			 .rstn,
			 .slave_valid(slave_req_awvalid), 
			 .slave_info({slave_req_awid,slave_req_awaddr,slave_req_awlen}), 	
			 .slave_ready(slave_req_awready),
			 .master_valid(aw_ibuf_valid_1), 
			 .master_info(aw_ibuf_info_1), 	
			 .master_ready(aw_ibuf_ready_1));

  ours_vld_rdy_buf #(.WIDTH(MASTER_DATA_WIDTH+(MASTER_DATA_WIDTH/8)+1), .DEPTH(W_PCIE_DEPTH)) 
	 w_ibuf_1 (.clk,
			 .rstn,
			 .slave_valid(slave_req_wvalid), 
			 .slave_info({slave_req_wstrb,slave_req_wdata,slave_req_wlast}), 	
			 .slave_ready(slave_req_wready),
			 .master_valid(w_ibuf_valid_1), 
			 .master_info({w_ibuf_wstrb_1,w_ibuf_info_1,w_ibuf_wlast_1}), 	
			 .master_ready(w_ibuf_ready_1));

  ours_vld_rdy_buf #(.WIDTH(MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH), .DEPTH(AW_ES1Y_DEPTH)) 
	aw_ibuf_2 (.clk,
			 .rstn,
			 .slave_valid(aw_ibuf_valid_2), 
			 .slave_info(aw_ibuf_info_2), 	
			 .slave_ready(aw_ibuf_ready_2),
			 .master_valid(aw_ibuf_valid), 
			 .master_info(aw_ibuf_info), 	
			 .master_ready(aw_ibuf_ready));

  ours_vld_rdy_buf #(.WIDTH(MASTER_DATA_WIDTH+(MASTER_DATA_WIDTH/8)+1), .DEPTH(W_ES1Y_DEPTH)) 
	 w_ibuf_2 (.clk,
			 .rstn,
			 .slave_valid(w_ibuf_valid_2), 
			 .slave_info({w_ibuf_wstrb_2,w_ibuf_info_2,w_ibuf_wlast_2}), 	
			 .slave_ready(w_ibuf_ready_2),
			 .master_valid(w_ibuf_valid), 
			 .master_info({w_ibuf_wstrb,w_ibuf_info,w_ibuf_wlast}), 	
			 .master_ready(w_ibuf_ready));

  assign sw_rstn       = rff_rstn;
  assign aw_ibuf_ready = aw_ibuf_valid & w_ibuf_valid;
  assign w_ibuf_ready  = aw_ibuf_valid & w_ibuf_valid;

  assign slave_rsp_bid      = dff_cfg.tid;
  assign slave_rsp_bresp    = '0;

  assign rep_arready  = 1'b1;
  assign slave_rsp_rvalid   = ((rff_st == RRSP_CFG) | (rff_st == RRSP_DBG) | (rff_st == RRSP_DBG2) | (rff_st == RRSP_EXE));
  assign slave_rsp_rid      = dff_cfg.tid;
  assign slave_rsp_rresp    = '0;

  logic [MASTER_ADDR_WIDTH-1:0] dff_rdata;
  always_ff @(posedge clk) begin
    if (rvalid) begin
      dff_rdata <= r.rdata;
    end
  end

  always_comb begin
    if (rff_st == RRSP_CFG) begin
      slave_rsp_rdata       = dff_cfg;
    end else if (rff_st == RRSP_DBG) begin
      slave_rsp_rdata       = {16{32'hdeadbeef}};
    end else if (rff_st == RRSP_EXE) begin
      //! TODO 64bit data need to be packed to form 512B data
      slave_rsp_rdata       = dff_rdata;
    end
    else begin
      slave_rsp_rdata       = {16{32'hffffaaaa}};
    end
  end

  assign awvalid     = (rff_st == WREQ);
  assign aw.awaddr   = dff_cfg.addr;
  assign aw.awid     = dff_cfg.tid;

  assign wvalid      = (rff_st == WREQ);
  assign w.wdata     = dff_cfg.data;
  assign w.wstrb     = '1;
  assign w.wlast     = 1'b1;

  assign bready      = 1'b1;

  assign arvalid     = (rff_st == RREQ);
  assign ar.araddr   = dff_cfg.addr;
  assign ar.arid     = dff_cfg.tid;

  assign rready      = 1'b1;

  always_comb begin
    next_st   = rff_st;
    next_cfg  = dff_cfg;
    nxt_rstn  = rff_rstn;
    dummy_bvalid = 1'b0;
    case (rff_st)
      IDLE: begin
        if (aw_ibuf_valid & w_ibuf_valid) begin
          unique if (aw_ibuf_info[MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_ADDR_WIDTH] == CFG_ADDR) begin
            next_cfg.addr = w_ibuf_info[63:0];
            next_cfg.data = w_ibuf_info[127:64];
            /* TODO
            Remove next_cfg.data = w_ibuf_info[127:64]; Not used
            */
            next_st = WRSP;
            dummy_bvalid = 1'b1;
            next_cfg.tid  = aw_ibuf_info[MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_TID_WIDTH];
          end else if (aw_ibuf_info[MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_ADDR_WIDTH] == EXE_ADDR) begin
            next_cfg.tid  = aw_ibuf_info[MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_TID_WIDTH];
            /*TODO
            next_cfg.data = w_ibuf_info[63:0];
            */
            next_st = WREQ;
          end else if (aw_ibuf_info[MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_ADDR_WIDTH] == RST_ADDR) begin
            next_st = WRSP;
            dummy_bvalid = 1'b1;
            nxt_rstn = w_ibuf_info[0];       
            next_cfg.tid  = aw_ibuf_info[MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_TID_WIDTH];
          end else begin
            next_st = WRSP;
            dummy_bvalid = 1'b1;
            next_cfg.tid  = aw_ibuf_info[MASTER_TID_WIDTH+MASTER_ADDR_WIDTH+MASTER_LEN_WIDTH-1 -: MASTER_TID_WIDTH];
          end
        end else if (rep_arvalid) begin
          unique if (rep_araddr == CFG_ADDR) begin
            next_st = RRSP_CFG;
            next_cfg.tid = rep_arid;
          end else if (rep_araddr == EXE_ADDR) begin
            next_cfg.tid = rep_arid;
            next_st = RREQ;
          end else if (rep_araddr == DBG_ADDR) begin
            next_st = RRSP_DBG;
            next_cfg.tid = rep_arid;
          end else begin
            next_st = RRSP_DBG2;
            next_cfg.tid = rep_arid;
          end
        end
      end
      WRSP: begin
        if (slave_rsp_bready) begin
          next_st = IDLE;
        end
      end
      WREQ: begin
        if (awready & wready) begin // See README
          next_st = WRDY;
        end
      end
      WRDY: begin
        if (bvalid) begin
          next_st = WRSP;
        end
      end
      RRSP_CFG: begin
        if (slave_rsp_rready) begin
          next_st = IDLE;
        end
      end
      RRSP_DBG: begin
        if (slave_rsp_rready) begin
          next_st = IDLE;
        end
      end
      RRSP_DBG2: begin
        if (slave_rsp_rready) begin
          next_st = IDLE;
        end
      end
      RREQ: begin
        if (arready) begin
          next_st = RRDY;
        end
      end
      RRDY: begin
        if (rvalid) begin
          next_st = RRSP_EXE;
        end
      end
      RRSP_EXE: begin
        if (slave_rsp_rready) begin
          next_st = IDLE;
        end
      end
      default: begin
      end
    endcase
  end

  ila_native_3_probe or_aw_ila_u(
  .clk(or_clk),
  .probe1({{24{1'b0}},or_req_aw.awaddr}),
  .probe0(or_req_awvalid),
  .probe2({{63{1'b0}},or_req_awready})
  );

  ila_native_3_probe or_w_ila_u(
  .clk(or_clk),
  .probe1({{24{1'b0}},or_req_aw.awaddr}),
  .probe0(or_req_wvalid),
  .probe2(or_req_w.wdata)
  );

  ila_native_3_probe or_ar_ila_u(
  .clk(or_clk),
  .probe1({{24{1'b0}},or_req_ar.araddr}),
  .probe0(or_req_arvalid),
  .probe2({{63{1'b0}},or_req_arready})
  );

  ila_native_3_probe or_r_ila_u(
  .clk(or_clk),
  .probe1({{63{1'b0}},or_rsp_rready}),
  .probe0(or_rsp_rvalid),
  .probe2(or_rsp_r.rdata)
  );


  ila_native_3_probe rstn_ila_u(
  .clk(clk),
  .probe1({{60{1'b0}},rff_st}),
  .probe0(rff_rstn),
  .probe2({64{1'b0}})
  );

  logic S00_AXI_ARESET_OUT_N;
  logic [7:0] s_awid;
  logic [7:0] s_bid;
  logic [7:0] s_arid;
  logic [7:0] s_rid;
  
  assign s_awid = aw.awid;
  assign b.bid  = s_bid;
  assign s_arid = ar.arid;
  assign r.rid  = s_rid;
 
  axi_cdc_pcie2oursring axi_u( 
  .INTERCONNECT_ACLK(clk),
  .INTERCONNECT_ARESETN(sw_rstn & rstn),
  .S00_AXI_ARESET_OUT_N(),
  .S00_AXI_ACLK(clk),
  .S00_AXI_AWID(s_awid),
  .S00_AXI_AWADDR(aw.awaddr),
  .S00_AXI_AWLEN(8'd3),
  //.S00_AXI_AWLEN(8'd0),
  .S00_AXI_AWSIZE(3'd3),
  .S00_AXI_AWBURST(2'd1),
  .S00_AXI_AWLOCK(1'b0),
  .S00_AXI_AWCACHE(4'b0),
  .S00_AXI_AWPROT(3'd0),
  .S00_AXI_AWQOS(4'd0),
  .S00_AXI_AWVALID(awvalid),
  .S00_AXI_AWREADY(awready),
  .S00_AXI_WDATA(w.wdata),
  .S00_AXI_WSTRB(w.wstrb),
  .S00_AXI_WLAST(w.wlast),
  .S00_AXI_WVALID(wvalid),
  .S00_AXI_WREADY(wready),
  .S00_AXI_BID(s_bid),
  .S00_AXI_BRESP(b.bresp),
  .S00_AXI_BVALID(bvalid),
  .S00_AXI_BREADY(bready),
  .S00_AXI_ARID(s_arid),
  .S00_AXI_ARADDR(ar.araddr),
  .S00_AXI_ARLEN(8'd3),
  //!TODO
  //.S00_AXI_ARLEN(rff_arburst_len),
  .S00_AXI_ARSIZE(3'd3),
  .S00_AXI_ARBURST(2'd1),
  .S00_AXI_ARLOCK(1'b0),
  .S00_AXI_ARCACHE(4'b0),
  .S00_AXI_ARPROT(3'd0),
  .S00_AXI_ARQOS(4'd0),
  .S00_AXI_ARVALID(arvalid),
  .S00_AXI_ARREADY(arready),
  .S00_AXI_RID(s_rid),
  .S00_AXI_RDATA(r.rdata),
  .S00_AXI_RRESP(r.rresp),
  .S00_AXI_RLAST(r.rlast),
  .S00_AXI_RVALID(rvalid),
  .S00_AXI_RREADY(rready),
  .M00_AXI_ARESET_OUT_N(),
  .M00_AXI_ACLK(or_clk),
  .M00_AXI_AWID(or_req_aw.awid),
  .M00_AXI_AWADDR(or_req_aw.awaddr),
  .M00_AXI_AWLEN(),
  .M00_AXI_AWSIZE(),
  .M00_AXI_AWBURST(),
  .M00_AXI_AWLOCK(),
  .M00_AXI_AWCACHE(),
  .M00_AXI_AWPROT(),
  .M00_AXI_AWQOS(),
  .M00_AXI_AWVALID(or_req_awvalid),
  .M00_AXI_AWREADY(or_req_awready),
  .M00_AXI_WDATA(or_req_w.wdata),
  .M00_AXI_WSTRB(or_req_w.wstrb),
  .M00_AXI_WLAST(or_req_w.wlast),
  .M00_AXI_WVALID(or_req_wvalid),
  .M00_AXI_WREADY(or_req_wready),
  .M00_AXI_BID(or_rsp_b.bid),
  .M00_AXI_BRESP(or_rsp_b.bresp),
  .M00_AXI_BVALID(or_rsp_bvalid),
  .M00_AXI_BREADY(or_rsp_bready),
  .M00_AXI_ARID(or_req_ar.arid),
  .M00_AXI_ARADDR(or_req_ar.araddr),
  .M00_AXI_ARLEN(),
  .M00_AXI_ARSIZE(),
  .M00_AXI_ARBURST(),
  .M00_AXI_ARLOCK(),
  .M00_AXI_ARCACHE(),
  .M00_AXI_ARPROT(),
  .M00_AXI_ARQOS(),
  .M00_AXI_ARVALID(or_req_arvalid),
  .M00_AXI_ARREADY(or_req_arready),
  .M00_AXI_RID(or_rsp_r.rid),
  .M00_AXI_RDATA(or_rsp_r.rdata),
  .M00_AXI_RRESP(or_rsp_r.rresp),
  .M00_AXI_RLAST(or_rsp_r.rlast),
  .M00_AXI_RVALID(or_rsp_rvalid),
  .M00_AXI_RREADY(or_rsp_rready));
endmodule

