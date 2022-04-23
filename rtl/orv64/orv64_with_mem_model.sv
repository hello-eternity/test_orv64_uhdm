module orv64_with_mem_model
  import common_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
  import l2cache_vls_cfg::*;
(
  input ext_int,
  input ext_event,
  input debug_stall,
  input [63:0] rst_pc,
  input rst, clk
);

  logic early_rst;
  vaddr_t cfg_rst_pc;

  // oursbus
  logic   ob_req, ob_rwn, ob_resp;
  orv64_typedef_pkg::paddr_t ob_addr, cfg_magic_start_addr, cfg_magic_end_addr, cfg_from_host_addr, cfg_to_host_addr;
  data_t  ob_wdata, ob_rdata;

  cpu_dbg_bus_t debug_bus_in, debug_bus_out;
  assign debug_bus_in = '{default: 0};

  assign ob_rdata = '0;
  assign ob_resp = '0;
  assign cfg_magic_start_addr = '0;
  assign cfg_magic_end_addr = '0;
  assign cfg_from_host_addr = '0;
  assign cfg_to_host_addr = '0;

  assign early_rst = rst;
  assign cfg_rst_pc = rst_pc;

  parameter int L2_PORT_CNT = 8;
  logic       cpu_req_valid [L2_PORT_CNT];
  logic       cpu_req_ready [L2_PORT_CNT];
  cpu_req_t   cpu_req       [L2_PORT_CNT];
  
  logic       cpu_resp_valid [L2_PORT_CNT];
  logic       cpu_resp_ready [L2_PORT_CNT];
  cpu_resp_t  cpu_resp       [L2_PORT_CNT];

  always_comb
    for (int i=1; i<8; i++) begin
      cpu_req_valid[i] = '0;
      cpu_resp_ready[i] = '0;
    end
`ifdef DEMO_ONLY_BENCH
  logic       uart_tx_valid;
  logic       uart_rx_ack;
  logic [7:0] uart_tx_data;

  logic       uart_tx_ready;
  logic       uart_rx_valid;
  logic [7:0] uart_rx_data;

  logic       c2p_uart_tx;
  logic       p2c_uart_rx;

  assign #6.66ns p2c_uart_rx = c2p_uart_tx;

  uart UART(
    .tx_data(uart_tx_data),
    .tx_valid(uart_tx_valid),
    .tx_ready(uart_tx_ready),
    .rx_data(uart_rx_data),
    .rx_valid(uart_rx_valid),
    .rx_ack(uart_rx_ack),
    .tx(c2p_uart_tx),
    .rx(p2c_uart_rx),
    .*);
`endif

  logic dc2ob_req, dc2ob_rwn;
  logic [39:0] dc2ob_addr;
  data_t dc2ob_wdata;
  data_t ob2dc_rdata;
  logic ob2dc_resp;

  logic     ic2ob_req, ic2ob_rwn;
  logic [39:0]   ic2ob_addr;
  data_t    ic2ob_wdata;
  logic [5:0] ic2ob_id;

  data_t    ob2ic_rdata;
  logic     ob2ic_resp;


  logic       uart_tx_valid;
  logic       uart_rx_ack;
  logic [7:0] uart_tx_data;

  logic       uart_tx_ready;
  logic       uart_rx_valid;
  logic [7:0] uart_rx_data;

  assign ob2dc_rdata = '0;
  assign ob2dc_resp = '0;
  assign uart_tx_ready = '0;
  assign uart_rx_valid = '0;
  assign uart_rx_data = '0;
  assign ic2ob_id = '0;

  assign ob2ic_rdata = '0;
  assign ob2ic_resp = '0;

  logic [39:0]   cfg_magicmem_start_addr;
  logic [39:0]   cfg_magicmem_end_addr;

  logic   dma2mp_ch0_done;
  logic   dma2mp_ch1_done;
  logic   dma2mp_ch2_done;
  logic   dma2mp_ch3_done;
  
  assign cfg_magicmem_start_addr = '0;
  assign cfg_magicmem_end_addr = '0;

  assign dma2mp_ch0_done = '0;
  assign dma2mp_ch1_done = '0;
  assign dma2mp_ch2_done = '0;
  assign dma2mp_ch3_done = '0;

  orv ORV(
    .l2_req(cpu_req[0]),
    .l2_req_valid(cpu_req_valid[0]),
    .l2_req_ready(cpu_req_ready[0]),
    .l2_resp(cpu_resp[0]),
    .l2_resp_valid(cpu_resp_valid[0]),
    .l2_resp_ready(cpu_resp_ready[0]),
    .if_pc(),
    .cfg_pwr_on(1'b1),
    .cfg_core_id(5'b11111),
    .cfg_lfsr_seed(6'h1),
    .mp2vc_cfg_wr_en('0),
    .mp2vc_cfg_wr_vcore_id('0),  // 5'hfff --> broacast id
    .mp2vc_cfg_wr_reg_id('0),
    .mp2vc_cfg_wr_data('0),
    .vc2mp_cfg_wr_ack('0),
    .mp2vc_thread_start_en('0),
    .mp2vc_thread_start_mode('0),
    .mp2vc_thread_start_thread_id('0),
    .mp2vc_thread_start_vcore_id('0),    // 5'hfff --> broacast id
    .mp2vc_thread_start_new_pc('0),
    .mp2vc_thread_start_new_sp('0),
    .vc2mp_thread_start_ack('0),
    .vc2mp_thread0_exe_done('0),
    .vc2mp_thread1_exe_done('0),
    .vc2mp_thread2_exe_done('0),
    .vc2mp_thread3_exe_done('0),
   .*);

  ot_perfect_l2_model #(.REQ_LATENCY(4), .RESP_LATENCY(4)) MM(.*);
  
endmodule
