
module boot_from_flash
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import station_slow_io_pkg::*;
(
  // Oursring Master
  input  oursring_resp_if_b_t axim_rsp_if_b,
  input  oursring_resp_if_r_t axim_rsp_if_r,
  input  logic                axim_rsp_if_rvalid,
  output logic                axim_rsp_if_rready,
  input  logic                axim_rsp_if_bvalid,
  output logic                axim_rsp_if_bready,
  output logic                axim_req_if_awvalid,
  output logic                axim_req_if_wvalid,
  output logic                axim_req_if_arvalid,
  output oursring_req_if_ar_t axim_req_if_ar,
  output oursring_req_if_aw_t axim_req_if_aw,
  output oursring_req_if_w_t  axim_req_if_w,
  input  logic                axim_req_if_arready,
  input  logic                axim_req_if_wready,
  input  logic                axim_req_if_awready,
  // Oursring Slave
  output oursring_resp_if_b_t axis_rsp_if_b,
  output oursring_resp_if_r_t axis_rsp_if_r,
  output logic                axis_rsp_if_rvalid,
  input  logic                axis_rsp_if_rready,
  output logic                axis_rsp_if_bvalid,
  input  logic                axis_rsp_if_bready,
  input  logic                axis_req_if_awvalid,
  input  logic                axis_req_if_wvalid,
  input  logic                axis_req_if_arvalid,
  input  oursring_req_if_ar_t axis_req_if_ar,
  input  oursring_req_if_aw_t axis_req_if_aw,
  input  oursring_req_if_w_t  axis_req_if_w,
  output logic                axis_req_if_arready,
  output logic                axis_req_if_wready,
  output logic                axis_req_if_awready,
  input  logic                clk,
  input  logic                rstn,
  input  logic                s2b_boot_from_flash_ena
  );

  localparam bit       VALID_WORD = 1'b1;
  localparam bit       INVALID_WORD = 1'b0;

  // Command encoding
  localparam bit [7:0] READ_DATA_BYTES  = 8'h03;
  localparam bit [7:0] PAGE_PROGRAM     = 8'h02;

  // ROM entry depth
  localparam int ROM_DEPTH        = 9;
  //TODO: review address. spi reg address
  localparam bit [39:0] CTRL_REG_ADDR  = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h0;
  localparam bit [39:0] SSI_EN_ADDR    = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h8;
  localparam bit [39:0] SER_ADDR       = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h10;
  localparam bit [39:0] BAUDR_ADDR     = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h14;
  localparam bit [39:0] TX_FTLR_ADDR   = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h18;
  localparam bit [39:0] RX_FTLR_ADDR   = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h1c;
  localparam bit [39:0] TX_FIFO_ADDR   = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h60;
  localparam bit [39:0] RX_FIFO_ADDR   = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h60;
  localparam bit [39:0] STAT_REG_ADDR  = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'h28;
  localparam bit [39:0] SPI_CTRL0_ADDR = STATION_SLOW_IO_SSPIM0_BLOCK_REG_ADDR + 40'hf4;

  // spi ctrl0 setup value
  localparam bit [63:0] SPI_CTRL0_DATA = 64'h0000_0000_0000_021a;
  //localparam bit [63:0] SPI_CTRL0_DATA = 64'h0000_0000_0000_1a0a;
  localparam bit [63:0] FIFO_THRESHOLD = 64'h0000_0000_0000_0004;

  // spi control setup values
  localparam bit [63:0] DFT_32  = 64'h0000_0000_001f_0000;
  localparam bit [63:0] TX_ONLY = 64'h0000_0000_0001_0000;
  localparam bit [63:0] RX_ONLY = 64'h0000_0000_0002_0000;
  localparam bit [63:0] BAUDR   = 64'h0000_0000_0000_0002;

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
    logic           valid;
    logic           aw_valid;
    logic           w_valid;
    logic           ar_valid;
  oursring_req_if_aw_t  aw_req;
  oursring_req_if_w_t    w_req;
  oursring_req_if_ar_t  ar_req;
  } axi_req_type_t;

  axi_req_type_t init_rom[ROM_DEPTH-1:0];
  logic [$clog2(ROM_DEPTH)-1:0] rffce_rom_cnt;
  logic                         rom_cnt_ena;

  // step 1: disable spi
  assign init_rom[0].valid         = 1'b1;
  assign init_rom[0].aw_valid      = 1'b1;
  assign init_rom[0].w_valid       = 1'b1;
  assign init_rom[0].ar_valid      = 1'b0;
  assign init_rom[0].aw_req.awaddr = SSI_EN_ADDR; 
  assign init_rom[0].aw_req.awid   = $bits(ring_tid_t)'(0);
  assign init_rom[0].w_req.wdata   = DISABLE_SPI; 
  assign init_rom[0].w_req.wstrb   = 8'hff; 
  assign init_rom[0].w_req.wlast   = 1'b1;
  assign init_rom[0].ar_req.araddr = SSI_EN_ADDR; 
  assign init_rom[0].ar_req.arid   = $bits(ring_tid_t)'(0); 
  // step 2: program control register 0
  assign init_rom[1].valid         = 1'b1;
  assign init_rom[1].aw_valid      = 1'b1;
  assign init_rom[1].w_valid       = 1'b1;
  assign init_rom[1].ar_valid      = 1'b0;
  assign init_rom[1].aw_req.awaddr = CTRL_REG_ADDR; 
  assign init_rom[1].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[1].w_req.wdata   = DFT_32; 
  assign init_rom[1].w_req.wstrb   = 8'hff; 
  assign init_rom[1].w_req.wlast   = 1'b1;
  assign init_rom[1].ar_req.araddr = CTRL_REG_ADDR; 
  assign init_rom[1].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 2: program control register 0
  assign init_rom[2].valid         = 1'b1;
  assign init_rom[2].aw_valid      = 1'b1;
  assign init_rom[2].w_valid       = 1'b1;
  assign init_rom[2].ar_valid      = 1'b0;
  assign init_rom[2].aw_req.awaddr = BAUDR_ADDR; 
  assign init_rom[2].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[2].w_req.wdata   = BAUDR; 
  assign init_rom[2].w_req.wstrb   = 8'hff; 
  assign init_rom[2].w_req.wlast   = 1'b1;
  assign init_rom[2].ar_req.araddr = CTRL_REG_ADDR; 
  assign init_rom[2].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 3: program control register 0
  assign init_rom[3].valid         = 1'b1;
  assign init_rom[3].aw_valid      = 1'b1;
  assign init_rom[3].w_valid       = 1'b1;
  assign init_rom[3].ar_valid      = 1'b0;
  assign init_rom[3].aw_req.awaddr = TX_FTLR_ADDR; 
  assign init_rom[3].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[3].w_req.wdata   = FIFO_THRESHOLD; 
  assign init_rom[3].w_req.wstrb   = 8'hff; 
  assign init_rom[3].w_req.wlast   = 1'b1;
  assign init_rom[3].ar_req.araddr = TX_FTLR_ADDR; 
  assign init_rom[3].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 2: program control register 0
  assign init_rom[4].valid         = 1'b1;
  assign init_rom[4].aw_valid      = 1'b1;
  assign init_rom[4].w_valid       = 1'b1;
  assign init_rom[4].ar_valid      = 1'b0;
  assign init_rom[4].aw_req.awaddr = RX_FTLR_ADDR; 
  assign init_rom[4].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[4].w_req.wdata   = FIFO_THRESHOLD; 
  assign init_rom[4].w_req.wstrb   = 8'hff; 
  assign init_rom[4].w_req.wlast   = 1'b1;
  assign init_rom[4].ar_req.araddr = RX_FTLR_ADDR; 
  assign init_rom[4].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 3: spi master
  assign init_rom[5].valid         = 1'b1;
  assign init_rom[5].aw_valid      = 1'b1;
  assign init_rom[5].w_valid       = 1'b1;
  assign init_rom[5].ar_valid      = 1'b0;
  assign init_rom[5].aw_req.awaddr = SER_ADDR;
  assign init_rom[5].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[5].w_req.wdata   = 64'h1; 
  assign init_rom[5].w_req.wstrb   = 8'hff; 
  assign init_rom[5].w_req.wlast   = 1'b1;
  assign init_rom[5].ar_req.araddr = SER_ADDR; 
  assign init_rom[5].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 4: spi frame
  assign init_rom[6].valid         = 1'b1;
  assign init_rom[6].aw_valid      = 1'b1;
  assign init_rom[6].w_valid       = 1'b1;
  assign init_rom[6].ar_valid      = 1'b0;
  assign init_rom[6].aw_req.awaddr = SPI_CTRL0_ADDR;
  assign init_rom[6].aw_req.awid   = $bits(ring_tid_t)'(1);
  assign init_rom[6].w_req.wdata   = SPI_CTRL0_DATA; 
  assign init_rom[6].w_req.wstrb   = 8'hff; 
  assign init_rom[6].w_req.wlast   = 1'b1;
  assign init_rom[6].ar_req.araddr = SPI_CTRL0_ADDR; 
  assign init_rom[6].ar_req.arid   = $bits(ring_tid_t)'(1);
  // step 5: enable spi
  assign init_rom[7].valid         = 1'b1;
  assign init_rom[7].aw_valid      = 1'b1;
  assign init_rom[7].w_valid       = 1'b1;
  assign init_rom[7].ar_valid      = 1'b0;
  assign init_rom[7].aw_req.awaddr = SSI_EN_ADDR; 
  assign init_rom[7].aw_req.awid   = $bits(ring_tid_t)'(2);
  assign init_rom[7].w_req.wdata   = ENABLE_SPI; 
  assign init_rom[7].w_req.wstrb   = 8'hff; 
  assign init_rom[7].w_req.wlast   = 1'b1;
  assign init_rom[7].ar_req.araddr = SSI_EN_ADDR; 
  assign init_rom[7].ar_req.arid   = $bits(ring_tid_t)'(2);
  // step 6: end
  assign init_rom[8].valid         = 1'b0;
  assign init_rom[8].aw_valid      = 1'b0;
  assign init_rom[8].w_valid       = 1'b0;
  assign init_rom[8].ar_valid      = 1'b0;
  assign init_rom[8].aw_req.awaddr = '0; 
  assign init_rom[8].aw_req.awid   = '0;
  assign init_rom[8].w_req.wdata   = '0; 
  assign init_rom[8].w_req.wstrb   = '0; 
  assign init_rom[8].w_req.wlast   = '0;
  assign init_rom[8].ar_req.araddr = '0; 
  assign init_rom[8].ar_req.arid   = '0;
 
  //TODO: review sequence. bootup fsm state
  enum logic [9:0] {
    RESET,          // rese state
    ROM_INIT,        // fetch instruction from ROM and forward to axi req channel
    WAIT_FOR_INIT,      // fetch instruction from ROM and forward to axi req channel
    WAIT_FOR_CPU_REQ,     // wait for axi request from cpu
    CHK_TX_FIFO,          // check if tx fifo is full 
    WAIT_TX_STATUS,       // wait for tx status data 
    WRITE_TX_DATA,        // pull data from axi rsp channel and send to tx fifo
    CHK_RX_FIFO,          // check if rx fifo is empty
    WAIT_RX_STATUS,       // wait for rx status data 
    GET_RX_DATA,        // pull data from rx fifo and send to axi req channel
    WAIT_RX_DATA        // pull data from rx fifo and send to axi req channel
  } rff_bootup_state, nxt_bootup_state;

  always_ff @(posedge clk) begin
    if (~rstn)
    rffce_rom_cnt <= '0;
  else if(rom_cnt_ena)
    rffce_rom_cnt <= rffce_rom_cnt + 1'b1;
  end  
  assign rom_cnt_ena = (rff_bootup_state == ROM_INIT) & init_rom[rffce_rom_cnt].aw_valid & axim_req_if_awready; 

// axi slave aw/w/ar
  logic        axis_req_valid;
  logic        axis_req_ready;
  logic [131:0] axis_req;
  logic        tx_valid;
  logic        tx_ready;
  logic [32:0] tx_data;
  ring_tid_t   rffce_arid;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) 
       rffce_arid <= '0;
    else if (axis_req_valid & axis_req_ready & axis_req_if_arvalid) 
       rffce_arid <= axis_req_if_ar.arid;
  end
  assign axis_req_valid = (axis_req_if_arvalid | axis_req_if_awvalid & axis_rsp_if_bready) & (rff_bootup_state == WAIT_FOR_CPU_REQ);
  assign axis_req_if_arready = axis_req_if_arvalid & axis_req_ready & (rff_bootup_state == WAIT_FOR_CPU_REQ);
  assign axis_req_if_awready = ~axis_req_if_arvalid & axis_req_ready & axis_rsp_if_bready & (rff_bootup_state == WAIT_FOR_CPU_REQ);
  assign axis_req_if_wready = axis_req_if_awready;
  assign axis_req = axis_req_if_arvalid ? {VALID_WORD,READ_DATA_BYTES,4'b0,axis_req_if_ar.araddr[19:0],
                                           VALID_WORD,32'b0,
                                           VALID_WORD,32'b0,
                                           INVALID_WORD,32'b0}                                : 
                                          {VALID_WORD,PAGE_PROGRAM,4'b0,axis_req_if_aw.awaddr[19:0],
                                           VALID_WORD,axis_req_if_w.wdata[63:32],
                                           VALID_WORD,axis_req_if_w.wdata[31:0],
                                           INVALID_WORD,32'b0}; 

// axi slave b 
  assign axis_rsp_if_bvalid = axis_req_if_awvalid & (rff_bootup_state == WAIT_FOR_CPU_REQ) & axis_rsp_if_bready;
  assign axis_rsp_if_b.bid = axis_req_if_aw.awid;
  assign axis_rsp_if_b.bresp = AXI_RESP_OKAY;

  vld_rdy_buf_4w1r  
  #(
  .DATA_WIDTH(33), 
  .FIFO_DEPTH(4)
  )
  tx_buf_u 
  (
    .clk          (clk),
    .rstn         (rstn),
    .slave_valid  (axis_req_valid),  
    .slave_ready  (axis_req_ready),  
    .data_in      ({axis_req[32:0], axis_req[65:33], axis_req[98:66], axis_req[131:99]}), 
    .master_valid (tx_valid),  
    .master_ready (tx_ready), 
    .data_out     (tx_data)
  );

// axi master aw/w
  ring_tid_t rffce_awid_cnt;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) 
       rffce_awid_cnt <= '0;
    else if (axim_req_if_awvalid & axim_req_if_awready) 
       rffce_awid_cnt <= rffce_awid_cnt + 1'b1;
  end

  //assign tx_ready = axim_req_if_awready & ((rff_bootup_state == ROM_INIT) | (rff_bootup_state == WRITE_TX_DATA)); 
  assign tx_ready = axim_req_if_awready & (rff_bootup_state == WRITE_TX_DATA); 
  assign axim_req_if_awvalid = init_rom[rffce_rom_cnt].valid & (rff_bootup_state == ROM_INIT) | 
                               tx_valid & tx_data[32] & (rff_bootup_state == WRITE_TX_DATA); 
  assign axim_req_if_wvalid =  axim_req_if_awvalid;
  assign axim_req_if_aw.awaddr = (rff_bootup_state == ROM_INIT) ? init_rom[rffce_rom_cnt].aw_req.awaddr : TX_FIFO_ADDR;
  assign axim_req_if_aw.awid = rffce_awid_cnt;
  assign axim_req_if_w.wdata = (rff_bootup_state == ROM_INIT) ? init_rom[rffce_rom_cnt].w_req.wdata : {32'b0,tx_data[31:0]};
  assign axim_req_if_w.wstrb = 8'hff;
  assign axim_req_if_w.wlast = 1'b1;

// axi master r and axi slave r
  logic rx_valid;
  logic rx_ready;
  logic [31:0] rx_data;
  logic [63:0] rsp_data;

  vld_rdy_buf_1w2r 
  #(
  .DATA_WIDTH(32), 
  .FIFO_DEPTH(2)
  )
  rx_buf_u 
  (
    .clk          (clk),
    .rstn         (rstn),
    .slave_valid  (rx_valid),  
    .slave_ready  (rx_ready),  
    .data_in      (rx_data), 
    .master_valid (axis_rsp_if_rvalid),  
    .master_ready (axis_rsp_if_rready), 
    .data_out     (rsp_data)
  );

  logic [1:0] rff_rdata_cnt;

  assign rx_valid = (axim_rsp_if_rvalid & (rff_bootup_state == WAIT_RX_DATA) & (rff_rdata_cnt != 2'b0));
  assign rx_data =  {axim_rsp_if_r.rdata[7:0], axim_rsp_if_r.rdata[15:8], axim_rsp_if_r.rdata[23:16], axim_rsp_if_r.rdata[31:24]};
  assign axim_rsp_if_rready = rx_ready & (rff_bootup_state == WAIT_RX_DATA) | (rff_bootup_state == WAIT_RX_STATUS) | (rff_bootup_state == WAIT_TX_STATUS);
  assign axis_rsp_if_r.rdata = rsp_data;
  assign axis_rsp_if_r.rid = rffce_arid; 
  assign axis_rsp_if_r.rresp = AXI_RESP_OKAY;
  assign axis_rsp_if_r.rlast = 1'b1;

//TODO axi master ar
  ring_tid_t rffce_arid_cnt;

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) 
       rffce_arid_cnt <= '0;
    else if (axim_req_if_arvalid & axim_req_if_arready) 
       rffce_arid_cnt <= rffce_awid_cnt + 1'b1;
  end

  assign axim_req_if_arvalid = (rff_bootup_state == CHK_RX_FIFO)        | 
                               (rff_bootup_state == CHK_TX_FIFO)        |
                               (rff_bootup_state == GET_RX_DATA);
  assign axim_req_if_ar.arid = rffce_arid_cnt;
  assign axim_req_if_ar.araddr = ((rff_bootup_state == CHK_RX_FIFO)        |
                                 (rff_bootup_state == CHK_TX_FIFO)) ? STAT_REG_ADDR : RX_FIFO_ADDR;

// status bits
  logic tx_is_not_full;
  logic rx_data_rdy;
  logic rx_data_not_rdy;

  assign tx_is_not_full  = axim_rsp_if_rvalid &  axim_rsp_if_r.rdata[TX_FIFO_NOT_FULL];
  assign rx_data_rdy     = axim_rsp_if_rvalid &  axim_rsp_if_r.rdata[RX_FIFO_NOT_EMPTY];
  assign rx_data_not_rdy = axim_rsp_if_rvalid & ~axim_rsp_if_r.rdata[RX_FIFO_NOT_EMPTY];

  logic pending_read;
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      pending_read <= 1'b0;
    end else if (axis_req_if_arvalid) begin
      pending_read <= 1'b1;
    end else if (axis_rsp_if_rvalid) begin
      pending_read <= 1'b0;
    end
  end

// axi master b
  assign axim_rsp_if_bready = 1'b1; 
 
// boot fsm
  always_ff @(posedge clk) begin
    if (rstn == 1'b0) 
      rff_bootup_state <= RESET;
    else 
      rff_bootup_state <= s2b_boot_from_flash_ena ? nxt_bootup_state : RESET;
  end

  always_ff @(posedge clk) begin
    if (rstn == 1'b0) begin
      rff_rdata_cnt <= 2'b0;
    end else if ((rff_bootup_state == WAIT_RX_DATA) & axim_rsp_if_rvalid & axim_rsp_if_rready) begin
      rff_rdata_cnt <= rff_rdata_cnt + 1'b1;
    end else if (rff_bootup_state == WAIT_FOR_CPU_REQ) begin
      rff_rdata_cnt <= 2'b0;
    end
  end

  assign nxt_bootup_state = (rff_bootup_state == RESET)                                                         ? ROM_INIT         :
                            (rff_bootup_state == ROM_INIT)         & ~init_rom[rffce_rom_cnt].valid             ? WAIT_FOR_CPU_REQ :
                            (rff_bootup_state == ROM_INIT)         &  axim_req_if_awready                       ? WAIT_FOR_INIT    :
                            (rff_bootup_state == WAIT_FOR_INIT)    &  axim_rsp_if_bvalid                        ? ROM_INIT         :
                            (rff_bootup_state == WAIT_FOR_CPU_REQ) &  tx_valid                                  ? CHK_TX_FIFO      : 
                            (rff_bootup_state == CHK_TX_FIFO)      &  axim_req_if_arready                       ? WAIT_TX_STATUS   : 
                            (rff_bootup_state == WAIT_TX_STATUS)   &  tx_is_not_full                            ? WRITE_TX_DATA    :
                            (rff_bootup_state == WRITE_TX_DATA)    & ~tx_valid &  pending_read                  ? CHK_RX_FIFO      : 
                            (rff_bootup_state == WRITE_TX_DATA)    & ~tx_valid & ~pending_read                  ? WAIT_FOR_CPU_REQ : 
                            (rff_bootup_state == WRITE_TX_DATA)    &  tx_valid                                  ? CHK_TX_FIFO      :
                            (rff_bootup_state == CHK_RX_FIFO)      &  axim_req_if_arready                       ? WAIT_RX_STATUS   :
                            (rff_bootup_state == WAIT_RX_STATUS)   &  rx_data_rdy                               ? GET_RX_DATA      :
                            (rff_bootup_state == WAIT_RX_STATUS)   &  rx_data_not_rdy                           ? CHK_RX_FIFO      :
                            (rff_bootup_state == GET_RX_DATA)      &  axim_req_if_arready                       ? WAIT_RX_DATA     :
                            (rff_bootup_state == WAIT_RX_DATA)     &  axim_rsp_if_rvalid & (rff_rdata_cnt < 2)  ? CHK_RX_FIFO      :
                            (rff_bootup_state == WAIT_RX_DATA)     &  axim_rsp_if_rvalid & (rff_rdata_cnt == 2) ? WAIT_FOR_CPU_REQ : rff_bootup_state;

 endmodule 

  
