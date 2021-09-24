
module bootup_fsm
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_slow_io_pkg::*;
(
  // Oursring Master
  input  oursring_resp_if_b_t or_rsp_if_b,
  input  oursring_resp_if_r_t or_rsp_if_r,
  input  logic                or_rsp_if_rvalid,
  output logic                or_rsp_if_rready,
  input  logic                or_rsp_if_bvalid,
  output logic                or_rsp_if_bready,
  output logic                or_req_if_awvalid,
  output logic                or_req_if_wvalid,
  output logic                or_req_if_arvalid,
  output oursring_req_if_ar_t or_req_if_ar,
  output oursring_req_if_aw_t or_req_if_aw,
  output oursring_req_if_w_t  or_req_if_w,
  input  logic                or_req_if_arready,
  input  logic                or_req_if_wready,
  input  logic                or_req_if_awready,
  input  logic                clk,
  input  logic                rstn,
  input  logic                s2b_bootup_ena
  );

  oursring_resp_if_b_t or_rsp_b;
  oursring_resp_if_r_t or_rsp_r;
  logic                or_rsp_rvalid;
  logic                or_rsp_rready;
  logic                or_rsp_bvalid;
  logic                or_rsp_bready;
  logic                or_req_awvalid;
  logic                or_req_wvalid;
  logic                or_req_arvalid;
  oursring_req_if_ar_t or_req_ar;
  oursring_req_if_aw_t or_req_aw;
  oursring_req_if_w_t  or_req_w;
  logic                or_req_arready;
  logic                or_req_wready;
  logic                or_req_awready;

  // Command encoding
  localparam bit [7:0] NULL    = 8'h00;
  localparam bit [7:0] AR_REQ  = 8'h01;
  localparam bit [7:0] AW_REQ  = 8'h02;
  localparam bit [7:0] R_RSP   = 8'h03;
  localparam bit [7:0] B_RSP   = 8'h04;
  localparam bit [7:0] BYP_REQ = 8'h05;

  // ROM entry depth
  localparam int ROM_DEPTH        = 4;
  // spi reg address
  localparam bit [39:0] CTRL_REG  = STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 40'h0;
  localparam bit [39:0] SSI_EN    = STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 40'h8;
  localparam bit [39:0] RX_FIFO   = STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 40'h60;
  localparam bit [39:0] TX_FIFO   = STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 40'h60;
  localparam bit [39:0] STAT_REG  = STATION_SLOW_IO_SPIS_BLOCK_REG_ADDR + 40'h28;

  // spi control setup values
  localparam bit [63:0] DFT_32  = 'h0000_0000_001f_0000;           
  localparam bit [63:0] TX_ONLY = 'h0000_0000_0001_0000;           
  localparam bit [63:0] RX_ONLY = 'h0000_0000_0002_0000;           

  // spi enable steup value
  localparam bit [63:0] DISABLE_SPI = 'h0; 
  localparam bit [63:0] ENABLE_SPI  = 'h1; 

  // spi status reg fields 
  localparam int SSI_BUSY           = 0;
  localparam int TX_FIFO_NOT_FULL   = 1;
  localparam int TX_FIFO_EMPTY      = 2;
  localparam int RX_FIFO_NOT_EMPTY  = 3;
  localparam int RX_FIFO_FULL       = 4;

  // ROM struct
  typedef struct {
    logic 					valid;
    logic 					aw_valid;
    logic 					w_valid;
    logic 					ar_valid;
	oursring_req_if_aw_t	aw_req;
	oursring_req_if_w_t		w_req;
	oursring_req_if_ar_t	ar_req;
  } axi_req_type_t;

  axi_req_type_t init_rom[ROM_DEPTH-1:0];
  logic [$clog2(ROM_DEPTH)-1:0] rffce_rom_cnt;

  // step 1: disable spi
  assign init_rom[0].valid         = 1'b1;
  assign init_rom[0].aw_valid      = 1'b1;
  assign init_rom[0].w_valid       = 1'b1;
  assign init_rom[0].ar_valid      = 1'b0;
  assign init_rom[0].aw_req.awaddr = SSI_EN; 
  assign init_rom[0].aw_req.awid   = $bits(ring_tid_t)'(0);
  assign init_rom[0].w_req.wdata   = DISABLE_SPI; 
  assign init_rom[0].w_req.wstrb   = 8'hff; 
  assign init_rom[0].w_req.wlast   = 1'b1;
  assign init_rom[0].ar_req.araddr = SSI_EN; 
  assign init_rom[0].ar_req.arid   = $bits(ring_tid_t)'(0); 
  // step 2: program control register 0
  assign init_rom[1].valid         = 1'b1;
  assign init_rom[1].aw_valid      = 1'b1;
  assign init_rom[1].w_valid       = 1'b1;
  assign init_rom[1].ar_valid      = 1'b0;
  assign init_rom[1].aw_req.awaddr = CTRL_REG; 
  assign init_rom[1].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[1].w_req.wdata   = DFT_32; 
  assign init_rom[1].w_req.wstrb   = 8'hff; 
  assign init_rom[1].w_req.wlast   = 1'b1;
  assign init_rom[1].ar_req.araddr = CTRL_REG; 
  assign init_rom[1].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 3: enable spi
  assign init_rom[2].valid         = 1'b1;
  assign init_rom[2].aw_valid      = 1'b1;
  assign init_rom[2].w_valid       = 1'b1;
  assign init_rom[2].ar_valid      = 1'b0;
  assign init_rom[2].aw_req.awaddr = SSI_EN; 
  assign init_rom[2].aw_req.awid   = $bits(ring_tid_t)'(2);
  assign init_rom[2].w_req.wdata   = ENABLE_SPI; 
  assign init_rom[2].w_req.wstrb   = 8'hff; 
  assign init_rom[2].w_req.wlast   = 1'b1;
  assign init_rom[2].ar_req.araddr = SSI_EN; 
  assign init_rom[2].ar_req.arid   = $bits(ring_tid_t)'(2);
  // step 4: end
  assign init_rom[3].valid         = 1'b0;
  assign init_rom[3].aw_valid      = 1'b0;
  assign init_rom[3].w_valid       = 1'b0;
  assign init_rom[3].ar_valid      = 1'b0;
  assign init_rom[3].aw_req.awaddr = '0; 
  assign init_rom[3].aw_req.awid   = '0;
  assign init_rom[3].w_req.wdata   = '0; 
  assign init_rom[3].w_req.wstrb   = '0; 
  assign init_rom[3].w_req.wlast   = '0;
  assign init_rom[3].ar_req.araddr = '0; 
  assign init_rom[3].ar_req.arid   = '0;
 
  oursring_resp_if_b_t axi_rsp_if_b;
  oursring_resp_if_r_t axi_rsp_if_r;
  logic                axi_rsp_if_rvalid;
  logic                axi_rsp_if_rready;
  logic                axi_rsp_if_bvalid;
  logic                axi_rsp_if_bready;
  logic                axi_req_if_awvalid;
  logic                axi_req_if_wvalid;
  logic                axi_req_if_arvalid;
  oursring_req_if_ar_t axi_req_if_ar;
  oursring_req_if_aw_t axi_req_if_aw;
  oursring_req_if_w_t  axi_req_if_w;
  logic                axi_req_if_arready;
  logic                axi_req_if_wready;
  logic                axi_req_if_awready;

  oursring_resp_if_b_t rsp_if_b;
  oursring_resp_if_r_t rsp_if_r;
  logic                rsp_if_rvalid;
  logic                rsp_if_rready;
  logic                rsp_if_bvalid;
  logic                rsp_if_bready;
  logic [31:0]		   rx_data;
  logic [31:0]		   tx_data;
  logic [127:0]		   axi_req_data;
  logic [127:0]		   axi_req_data_new;
  logic [127:0]		   axi_rsp_data;
  logic                axi_req_valid;
  logic				   axi_req_ready;
  logic                axi_rsp_valid;
  logic				   axi_rsp_ready;
  logic 			   ar_req_ready;
  logic                ar_req_valid;
  logic 			   aw_req_ready;
  logic                aw_req_valid;
  logic 			   w_req_ready;
  logic                w_req_valid;
  oursring_req_if_ar_t ar_req;
  oursring_req_if_aw_t aw_req;
  oursring_req_if_w_t  w_req;
  logic                rx_valid;
  logic                rx_ready;
  logic                tx_valid;
  logic                tx_ready;
  logic 			   byp_req_valid; 
  logic 			   byp_req_ready;
  logic 			   byp_rsp_valid; 
  logic 			   byp_rsp_ready;
  logic [31:0]         byp_data;
  logic                rom_cnt_ena;
  ring_tid_t           awid_cnt;
  ring_tid_t           arid_cnt;

   
  // bootup fsm state
  enum logic [9:0] {
	RESET,				  // rese state
    ROM_INIT,			  // fetch instruction from ROM and forward to axi req channel
    WAIT_FOR_INIT,		  // fetch instruction from ROM and forward to axi req channel
	CHK_RX_FIFO,          // check if rx fifo is empty 
	WAIT_RX_STATUS,       // wait for rx status data 
	GET_RX_DATA,	      // pull data from rx fifo and send to axi req channel
	WAIT_RX_DATA,	      // pull data from rx fifo and send to axi req channel
    WAIT_FOR_RESP,        // wait for resp back from axi rsp channel
    CHK_TX_FIFO,          // check if tx fifo is full 
	WAIT_TX_STATUS,       // wait for tx status data 
    WRITE_TX_DATA	      // pull data from axi rsp channel and send to tx fifo
  } rff_bootup_state, nxt_bootup_state;

  always_ff @(posedge clk or negedge rstn) begin
    if (~rstn)
	  rffce_rom_cnt <= '0;
	else if(rom_cnt_ena)
	  rffce_rom_cnt <= rffce_rom_cnt + 1'b1;
  end  
  assign rom_cnt_ena = (rff_bootup_state == ROM_INIT) & init_rom[rffce_rom_cnt].aw_valid & aw_req_ready; 

// rx buf, collecting data from SPI DR
  vld_rdy_buf_1w4r 
  #(
	.DATA_WIDTH(32), 
	.FIFO_DEPTH(4)
  )
  rx_buf_u 
  (
    .clk			(clk),
	.rstn			(rstn),
	.slave_valid	(rx_valid),  
	.slave_ready	(rx_ready),  
	.data_in		(rx_data), 
 	.master_valid	(axi_req_valid),  
	.master_ready	(axi_req_ready), 
	.data_out		(axi_req_data_new)
  );
  assign axi_req_data = {axi_req_data_new[31:0],axi_req_data_new[63:32],axi_req_data_new[95:64],axi_req_data_new[127:96]};
  assign rx_valid = rsp_if_rvalid & (rff_bootup_state == WAIT_RX_DATA);
  assign rx_data =  rsp_if_r.rdata[31:0];
  // formatted request could be sent to aw, ar, or byp stage
  assign axi_req_ready = axi_req_valid & (axi_req_data[7:0] == AW_REQ)  & (aw_req_ready | w_req_ready) |
						 axi_req_valid & (axi_req_data[7:0] == AR_REQ)  &  ar_req_ready |
						 axi_req_valid & (axi_req_data[7:0] == BYP_REQ) &  byp_req_ready|
						 axi_req_valid & (axi_req_data[7:0] == NULL);

// tx buf, writing data to SPI DR 
  vld_rdy_buf_4w1r 
  #(
	.DATA_WIDTH(32), 
	.FIFO_DEPTH(4)
  )
  tx_buf_u 
  (
    .clk			(clk),
	.rstn			(rstn),
	.slave_valid	(axi_rsp_valid),  
	.slave_ready	(axi_rsp_ready),  
	.data_in		({axi_rsp_data[31:0],axi_rsp_data[63:32],axi_rsp_data[95:64],axi_rsp_data[127:96]}), 
 	.master_valid	(tx_valid),  
	.master_ready	(tx_ready), 
	.data_out		(tx_data) 
  );
  // resp data written into SPI DR could come from r, b, or byp.
  assign axi_rsp_valid = rsp_if_rvalid & (rff_bootup_state == WAIT_FOR_RESP) | 
                         rsp_if_bvalid | byp_rsp_valid; 
  assign axi_rsp_data = rsp_if_rvalid ? {R_RSP,rsp_if_r.rdata[63:0],56'h0} :
						byp_rsp_valid ? {BYP_REQ,byp_data,88'b0}           : {B_RSP,120'h0}; 
 
 assign tx_ready = aw_req_ready & (rff_bootup_state == WRITE_TX_DATA);

// aw channel, talking to oursring directly
  vcore_ppln 
  #(
      .CTRL_WIDTH ( 1 ),
      .DATA_WIDTH ($bits(oursring_req_if_aw_t))
  )
  aw_req_u 
  (
      .clk                (clk),
      .rstn               (rstn),
      .valid_in           (aw_req_valid),
      .ready_out          (aw_req_ready),
      .data_in            (aw_req),
      .ctrl_in            (1'b0),
      .valid_out          (or_req_if_awvalid),
      .ready_in           (or_req_if_awready),
      .data_out           (or_req_if_aw),
      .ctrl_out           ( ) // no use
  );

  always_ff @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) 
       awid_cnt <= '0;
    else if (aw_req_valid & aw_req_ready) 
       awid_cnt <= awid_cnt + 1'b1;
  end

  // request is initiated by either ROM, RX buffer(stored data from DR, req trans), or TX buffer(write data to DR, rsp trans)
  assign aw_req_valid  = axi_req_if_awvalid                            | 
						 axi_req_valid & (axi_req_data[7:0] == AW_REQ) | 
					     tx_valid & (rff_bootup_state == WRITE_TX_DATA);
  assign aw_req.awaddr = axi_req_if_awvalid ? axi_req_if_aw.awaddr : 
						 tx_valid           ? TX_FIFO              : axi_req_data[47:8];
  assign aw_req.awid   = axi_req_if_awvalid ? axi_req_if_aw.awid : awid_cnt;

// w channel, talking to oursring directly
  vcore_ppln 
  #(
      .CTRL_WIDTH ( 1 ),
      .DATA_WIDTH ($bits(oursring_req_if_w_t))
  )
  w_req_u 
  (
      .clk                (clk),
      .rstn               (rstn),
      .valid_in           (w_req_valid),
      .ready_out          (w_req_ready),
      .data_in            (w_req),
      .ctrl_in            (1'b0),
      .valid_out          (or_req_if_wvalid),
      .ready_in           (or_req_if_wready),
      .data_out           (or_req_if_w),
      .ctrl_out           ( ) // no use   
  );
  // request is initiated by either ROM, RX, or TX buffer
  assign w_req_valid   = axi_req_if_wvalid 							   | 
						 axi_req_valid & (axi_req_data[7:0] == AW_REQ) | 
						 tx_valid & (rff_bootup_state == WRITE_TX_DATA);
  assign w_req.wdata   = axi_req_if_wvalid ? axi_req_if_w.wdata : 
			  	         tx_valid          ? {32'b0,tx_data}     : axi_req_data[111:48];
  assign w_req.wlast   = 1'b1;
  assign w_req.wstrb   = 8'hff;
  // ready signals back to FSM 
  assign axi_req_if_wready = w_req_ready & axi_req_if_wvalid;

// ar channel
  vcore_ppln 
  #(
      .CTRL_WIDTH ( 1 ),
      .DATA_WIDTH ($bits(oursring_req_if_ar_t))
  )
  ar_req_u 
  (
      .clk                (clk),
      .rstn               (rstn),
      .valid_in           (ar_req_valid),
      .ready_out          (ar_req_ready),
      .data_in            (ar_req),
      .ctrl_in            (1'b0),
      .valid_out          (or_req_if_arvalid),
      .ready_in           (or_req_if_arready),
      .data_out           (or_req_if_ar),
      .ctrl_out           ( ) // no use    
  );
  // request is initiated by either FSM, RX 
  assign ar_req_valid = axi_req_if_arvalid | axi_req_valid & (axi_req_data[7:0] == AR_REQ);
  assign ar_req.araddr = axi_req_if_arvalid ? axi_req_if_ar.araddr : axi_req_data[47:8];
  assign ar_req.arid = arid_cnt;

  always_ff @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) 
       arid_cnt <= '0;
    else if (ar_req_valid & ar_req_ready) 
       arid_cnt <= arid_cnt + 1'b1;
  end

// r channel, talking to oursring directly
  vcore_ppln 
  #(
      .CTRL_WIDTH ( 1 ),
      .DATA_WIDTH ($bits(oursring_resp_if_r_t))
  )
  r_rsp_u 
  (
      .clk                (clk),
      .rstn               (rstn),
      .valid_in           (or_rsp_if_rvalid),
      .ready_out          (or_rsp_if_rready),
      .data_in            (or_rsp_if_r),
      .ctrl_in            (1'b0),
      .valid_out          (rsp_if_rvalid),
      .ready_in           (rsp_if_rready),
      .data_out           (rsp_if_r),
      .ctrl_out           ( ) // no use    
  );
  // ready singal comes from either FSM, RX, or TX buffer
  assign rsp_if_rready = axi_rsp_if_rready                                  | 
                        (rff_bootup_state == WAIT_FOR_RESP) & axi_rsp_ready |  
					    (rff_bootup_state == GET_RX_DATA)   & rx_ready;
 
// b channel
  logic new_rsp_if_bvalid;
  vcore_ppln 
  #(
      .CTRL_WIDTH ( 1 ),
      .DATA_WIDTH ($bits(oursring_resp_if_b_t))
  )
  b_rsp_u 
  (
      .clk                (clk),
      .rstn               (rstn),
      .valid_in           (new_rsp_if_bvalid),
      .ready_out          (or_rsp_if_bready),
      .data_in            (or_rsp_if_b),
      .ctrl_in            (1'b0),
      .valid_out          (rsp_if_bvalid),
      .ready_in           (rsp_if_bready),
      .data_out           (rsp_if_b),
      .ctrl_out           ( ) // no use     
  );
  assign rsp_if_bready = axi_rsp_ready & ~rsp_if_rvalid & ~byp_rsp_valid;
  assign new_rsp_if_bvalid = or_rsp_if_bvalid & (rff_bootup_state == WAIT_FOR_RESP);

// byp channel
  vcore_ppln 
  #(
      .CTRL_WIDTH (1),
      .DATA_WIDTH (32)
  )
  byp_rsp_u 
  (
      .clk                (clk),
      .rstn               (rstn),
      .valid_in           (byp_req_valid),
      .ready_out          (byp_req_ready),
      .data_in            (32'hdead_beef),
      .ctrl_in            (1'b0),
      .valid_out          (byp_rsp_valid),
      .ready_in           (byp_rsp_ready),
      .data_out           (byp_data),
      .ctrl_out           ( ) // no use     
  );
  assign byp_req_valid = axi_req_valid & (axi_req_data[7:0] == BYP_REQ);
  assign byp_rsp_ready = axi_rsp_ready & ~rsp_if_rvalid;

  logic rx_data_rdy;
  logic rx_data_not_rdy;
  logic data_collect_done;
  logic tx_is_not_full;
  logic [1:0] rffce_coll_cnt; 
  logic cnt_enable;
  logic is_rd_req, is_wr_req;
  logic null_req;

  assign null_req = axi_req_valid & (axi_req_data[7:0] == NULL);
  
  always_ff @(posedge clk or negedge rstn) begin
    if (rstn == 1'b0) 
      rff_bootup_state <= RESET;
    else 
      rff_bootup_state <= s2b_bootup_ena ? nxt_bootup_state : RESET;
  end

  assign nxt_bootup_state = (rff_bootup_state == RESET)        		  					          ? ROM_INIT       :
					        (rff_bootup_state == ROM_INIT)	     & ~init_rom[rffce_rom_cnt].valid ? CHK_RX_FIFO    :
					        (rff_bootup_state == ROM_INIT)	     &  aw_req_ready 				  ? WAIT_FOR_INIT  :
					        (rff_bootup_state == WAIT_FOR_INIT)	 &  or_rsp_if_bvalid  			  ? ROM_INIT       :
                            (rff_bootup_state == CHK_RX_FIFO)	 &  ar_req_ready                  ? WAIT_RX_STATUS :
                            (rff_bootup_state == WAIT_RX_STATUS) &  rx_data_rdy                   ? GET_RX_DATA    :
                            (rff_bootup_state == WAIT_RX_STATUS) &  rx_data_not_rdy               ? CHK_RX_FIFO    :
							(rff_bootup_state == GET_RX_DATA)    &  axi_req_if_arready            ? WAIT_RX_DATA   :
							(rff_bootup_state == WAIT_RX_DATA)   &  data_collect_done             ? WAIT_FOR_RESP  :	 
							(rff_bootup_state == WAIT_RX_DATA)   &  axi_rsp_if_rvalid             ? CHK_RX_FIFO    :
                            (rff_bootup_state == WAIT_FOR_RESP)  &  null_req                      ? CHK_RX_FIFO    :
                            (rff_bootup_state == WAIT_FOR_RESP)  &  tx_valid                      ? CHK_TX_FIFO    :
                            (rff_bootup_state == CHK_TX_FIFO)    &  ar_req_ready                  ? WAIT_TX_STATUS : 
                            (rff_bootup_state == WAIT_TX_STATUS) &  tx_is_not_full                ? WRITE_TX_DATA  : 
							(rff_bootup_state == WRITE_TX_DATA)  & ~tx_valid		              ? CHK_RX_FIFO    : 
							(rff_bootup_state == WRITE_TX_DATA)  &  tx_valid		              ? CHK_TX_FIFO    : rff_bootup_state;
  assign axi_req_if_arready = ar_req_ready;
  assign axi_rsp_if_rvalid = rsp_if_rvalid;
  assign axi_rsp_if_r = rsp_if_r; 
  assign rx_data_rdy = axi_rsp_if_rvalid & axi_rsp_if_r.rdata[RX_FIFO_NOT_EMPTY];
  assign rx_data_not_rdy = axi_rsp_if_rvalid & ~axi_rsp_if_r.rdata[RX_FIFO_NOT_EMPTY];
  assign is_wr_req = axi_rsp_if_rvalid & ((axi_rsp_if_r.rdata[25:24] == 2'b01) | (axi_rsp_if_r.rdata[25:24] == 2'b10));
  assign is_rd_req = axi_rsp_if_rvalid & (axi_rsp_if_r.rdata[25:24] == 2'b0);
  assign data_collect_done = axi_rsp_if_rvalid & rx_ready & (rffce_coll_cnt == 2'b11);
  assign tx_is_not_full = axi_rsp_if_rvalid & axi_rsp_if_r.rdata[TX_FIFO_NOT_FULL];

  // count number of bytes reeived from rx fifo
  always_ff @(posedge clk or negedge rstn) begin
    if(~rstn)
      rffce_coll_cnt <= '0;
    else if(cnt_enable)
      rffce_coll_cnt <= rffce_coll_cnt + 1'b1;
  end
 
  assign cnt_enable = axi_rsp_if_rvalid & rx_ready & (rff_bootup_state == WAIT_RX_DATA);

  assign axi_rsp_if_rready         = (rff_bootup_state == WAIT_RX_DATA)   |
									 (rff_bootup_state == WAIT_RX_STATUS) | 
									 (rff_bootup_state == WAIT_TX_STATUS);

  assign axi_req_if_arvalid        = (rff_bootup_state == CHK_RX_FIFO)        | 
									 (rff_bootup_state == CHK_TX_FIFO)        |
									 (rff_bootup_state == GET_RX_DATA)& ~data_collect_done;

  assign axi_req_if_ar.araddr = ((rff_bootup_state == CHK_RX_FIFO)        |
							     (rff_bootup_state == CHK_TX_FIFO)) ? STAT_REG : RX_FIFO;

  assign axi_req_if_ar.arid        = '0;

  // axi req from ROM
  assign axi_req_if_awvalid       = init_rom[rffce_rom_cnt].aw_valid & (rff_bootup_state == ROM_INIT) & aw_req_ready;
  assign axi_req_if_wvalid        = axi_req_if_awvalid;
  assign axi_req_if_aw            = init_rom[rffce_rom_cnt].aw_req;
  assign axi_req_if_w             = init_rom[rffce_rom_cnt].w_req; 

  assign axi_rsp_if_bready    = 1'b1;

 endmodule 

  
