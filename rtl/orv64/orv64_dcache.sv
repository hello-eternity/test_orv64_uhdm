// `define UNCACHED
`undef UNCACHED
module orv64_dcache
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
  #(
  parameter ADDR_SIZE      = PHY_ADDR_WIDTH, 
  parameter LINE_BYTE      = CACHE_LINE_BYTE,
  parameter BYTE_LEN       = 8,
  parameter DATA_WIDTH     = LINE_BYTE*BYTE_LEN, // line = 256

//ORV64_PHY_ADDR_WIDTH==56

  // parameter UNCACHED_ADDR_S           = 56'h80001000,
  // parameter UNCACHED_ADDR_E           = 56'h80001048,
  // parameter UNCACHED_ADDR_STRUCT_1_S  = 56'h80024cc0,
  // parameter UNCACHED_ADDR_STRUCT_2_S  = 56'h80024fc0,
  // parameter UNCACHED_ADDR_TARGET_1_S  = 56'h800050c0,
  // parameter UNCACHED_ADDR_TARGET_2_S  = 56'h80025040,

  // parameter UNCACHED_ADDR_STRUCT_1_E  = 56'h80024d00,
  // parameter UNCACHED_ADDR_STRUCT_2_E  = 56'h80025000,
  // parameter UNCACHED_ADDR_TARGET_1_E  = 56'h80005100,
  // parameter UNCACHED_ADDR_TARGET_2_E  = 56'h80025080




  parameter UNCACHED_ADDR_S           = 56'h80001000,
  parameter UNCACHED_ADDR_E           = 56'h80001048,
  parameter UNCACHED_ADDR_TARGET_1_S  = 56'h81000000,
  parameter UNCACHED_ADDR_STRUCT_1_S  = UNCACHED_ADDR_TARGET_1_S+56'h1fc00,
  parameter UNCACHED_ADDR_STRUCT_2_S  = UNCACHED_ADDR_TARGET_1_S+56'h1ff00,
  // parameter UNCACHED_ADDR_TARGET_2_S  = 56'h80025040,

  parameter UNCACHED_ADDR_STRUCT_1_E  = 56'h80024d00,
  parameter UNCACHED_ADDR_STRUCT_2_E  = 56'h80025000,
  parameter UNCACHED_ADDR_TARGET_1_E  = 56'h80005100,
  parameter UNCACHED_ADDR_TARGET_2_E  = 56'h80025080

  // parameter UNCACHED_ADDR_X1        = 56'h80024fc0,
  // parameter UNCACHED_ADDR_X2        = 56'h80025000
  )
  (
  input   [7:0]                 core_id,
  input logic                   clk,
  input logic                   rst, 
  input logic                   minstret_lsb,

    //   typedef struct packed { // {{{
    //     logic       re, we;
    //     logic		lr, sc, amo_store, amo_load, aq_rl;
    //     orv64_vaddr_t     addr;          // 39bits logic
    //     orv64_data_byte_mask_t mask;     // 8 bits logic
    //     orv64_data_t      wdata;         // 64bits logic
    //     cpu_byte_mask_t   width; // }}}  // 32bits logic, 256-bit
    //   } orv64_ex2dc_t;
  input   orv64_ex2dc_t         ex2dc,

    //   typedef struct packed { // {{{
    //     orv64_data_t      rdata;         // 64bits logic
    //     logic              excp_valid;
    //     orv64_excp_cause_t excp_cause;   // 4 bits macro
    //     logic       valid; // }}}
    //   } orv64_dc2ma_t;
  output  orv64_dc2ma_t         dc2ma,

// FENCE
  input   logic                 ex2dc_fence_req_valid,

    //   typedef struct packed {
    //     logic req_is_fence;
    //   } cache_fence_if_req_t;
  input   cache_fence_if_req_t  ex2dc_fence_req,
  output  logic                 dc2ex_fence_req_ready,


  output  logic                 dc2ma_fence_resp_valid,

    //   typedef struct packed {
    //     logic resp_fence_is_done;
    //   } cache_fence_if_resp_t;
  output  cache_fence_if_resp_t dc2ma_fence_resp,
  input   logic                 ma2dc_fence_resp_ready,

// TLB
  output logic                      dc2tlb_valid,
  output orv64_cache_tlb_if_req_t   dc2tlb,
  input  logic                      tlb2dc_ready,



  input  logic                      tlb2dc_valid,

    // typedef struct packed {
    //   logic resp_excp_valid;
    //   orv64_excp_cause_t resp_excp_cause;  // 4 bits macro
    //   orv64_ppn_t resp_ppn;                // 44bits logic
    // } orv64_cache_tlb_if_resp_t;
  input  orv64_cache_tlb_if_resp_t  tlb2dc,
  output logic                      dc2tlb_ready,

// L2
  output logic                cpu_if_req_valid, 

  // typedef struct packed {
  //   paddr_t req_paddr;              // 40 bits logic //data_addr_i
  //   cpu_data_t req_data;            // 256bits logic
  //   cpu_byte_mask_t req_mask;       // 32 bits logic
  //   cpu_tid_t req_tid;              // 3-element structure, about cpu noc
  //   cpu_req_type_t req_type;        // 4  bits macro
  // } cpu_cache_if_req_t;
  output cpu_cache_if_req_t   cpu_if_req, 
  input logic                 cpu_if_req_ready, 
  output logic                cpu_amo_store_req_valid, 
  output cpu_cache_if_req_t   cpu_amo_store_req, 
  input logic                 cpu_amo_store_req_ready, 
  input logic                 cpu_if_resp_valid, 
  input cpu_cache_if_resp_t   cpu_if_resp, 
  output logic                cpu_if_resp_ready, 

  output logic  			  dc2if_amo_store_sent,

// SYSBUS
  output logic                sysbus_req_if_awvalid,
  output logic                sysbus_req_if_wvalid,
  output logic                sysbus_req_if_arvalid,
  output oursring_req_if_ar_t sysbus_req_if_ar,
  output oursring_req_if_aw_t sysbus_req_if_aw,
  output oursring_req_if_w_t  sysbus_req_if_w,
  input                       sysbus_req_if_arready,
  input                       sysbus_req_if_wready,
  input                       sysbus_req_if_awready,

  input oursring_resp_if_b_t  sysbus_resp_if_b,
  input oursring_resp_if_r_t  sysbus_resp_if_r,
  input                       sysbus_resp_if_rvalid,
  output                      sysbus_resp_if_rready,
  input                       sysbus_resp_if_bvalid,
  output                      sysbus_resp_if_bready,

  input   orv64_prv_t           prv,
  input   orv64_csr_mstatus_t   mstatus,

//PMP/PMA
  input   orv64_csr_pmpcfg_part_t [ORV64_N_PMP_CSR-1:0] pmpcfg,
  input   orv64_csr_pmpaddr_t [15:0] pmpaddr

  );

  logic                  rff_ex2dc_re, rff_ex2dc_we;
  logic                  rff_ex2dc_lr, rff_ex2dc_sc, rff_ex2dc_amo_store, rff_ex2dc_amo_load, rff_ex2dc_aq_rl;
  orv64_vaddr_t          dff_ex2dc_addr;
  orv64_data_byte_mask_t dff_ex2dc_mask;
  orv64_data_t           dff_ex2dc_wdata;
  cpu_byte_mask_t        dff_ex2dc_width;

  logic is_sys_req;
  logic is_bar_req, is_amo_store_req;
  logic is_excp, is_l1_req, is_l2_req, is_sys_wr_req, is_sys_rd_req;
  logic rff_is_sys_rd_resp, rff_is_sys_wr_resp, rff_is_l1_resp, rff_is_l2_resp;

  logic                       l1_common_rd_en;
  logic                       l1_common_wt_en;
  logic                       l2_l1_valid_en;
  logic [ADDR_SIZE-1:0]       l2_l1_addr;
  logic [DATA_WIDTH-1:0]      l2_l1_data;
  logic [LINE_BYTE-1:0]       l2_l1_mask;
  logic                       l2_wb_en_o;
  logic [ADDR_SIZE-1:0]       l2_wb_addr_o;
  logic [DATA_WIDTH-1:0]      l2_wb_data_o;
  logic                       l2_rm_en_o;
  logic                       l1_en;
  logic                       l1_is_working;
  logic [ADDR_SIZE-1:0]       l2_rm_addr_o;


  logic                       cpu_l1_req_valid;
  cpu_cache_if_req_t          cpu_l1_req;
  cpu_data_t                  l1_write_data;
  cpu_byte_mask_t             l1_write_mask;
  
  logic  l1_rd_miss_en;
  logic  l1_wt_miss_en;
  logic [ORV64_XLEN-1:0]          cpu_l1_resp;
  logic                           cpu_l1_resp_valid;
  logic                           l1_hit_en;
  

  cpu_data_t                      l2_write_data;
  cpu_byte_mask_t                 l2_write_mask;
  logic [CPUNOC_TID_TID_SIZE-1:0] rff_tid;
  cache_paddr_t                   barrier_paddr;
  orv64_paddr_t                   req_paddr;

  logic rff_has_req;
  
  logic minstret_lsb_last;
  logic first_cycle_en;

  assign first_cycle_en = (minstret_lsb_last != minstret_lsb);
  always_ff @(posedge clk) begin
    minstret_lsb_last <= minstret_lsb;
  end

  //==========================================================
  // ICG {{{
  
  logic aw_clkg;
  logic ex2dc_clkg;
  logic en_ex2dc_clk;
  logic do_save_aw;
  logic en_ex2dc;
  assign en_ex2dc_clk = (~rff_has_req | dc2ma.valid) & (ex2dc.we | ex2dc.re | ex2dc.lr | ex2dc.sc | ex2dc.amo_store | ex2dc.amo_load | ex2dc.aq_rl);

  icg aw_clk_u(
    .en       (do_save_aw),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (aw_clkg)
  );

  icg ex2dc_pckt_clk_u(
    .en       (en_ex2dc_clk),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (ex2dc_pckt_clkg)
  );

  // }}}

  //==========================================================
  // TLB Handshake {{{

  logic accept_no_trans_req;

  assign accept_no_trans_req = ex2dc.aq_rl;

  // Only send 1 tlb request per ex2dc request
  always_ff @(posedge clk) begin
    if (rst) begin
      rff_has_req <= '0;
    end else begin
      if (rff_has_req) begin
        rff_has_req <= dc2ma.valid ? ((dc2tlb_valid & tlb2dc_ready) | (accept_no_trans_req)): '1;
      end else begin
        rff_has_req <= (dc2tlb_valid & tlb2dc_ready) | (accept_no_trans_req);
      end
    end
  end

  assign dc2tlb_valid = (~rff_has_req | dc2ma.valid) & (ex2dc.re | ex2dc.we); 
  assign dc2tlb.req_vpn = ex2dc.addr >> ORV64_PAGE_OFFSET_WIDTH;
  assign dc2tlb.req_access_type = (ex2dc.amo_load | ex2dc.amo_store) ? ORV64_ACCESS_AMO : (ex2dc.we ? ORV64_ACCESS_STORE: ORV64_ACCESS_LOAD);

  assign is_sys_req        = ~tlb2dc.resp_ppn[31-12];
  assign is_l1_req         = tlb2dc_valid & ~is_sys_req & (l1_common_wt_en | l1_common_rd_en);
  // assign is_l2_req         = tlb2dc_valid & ~is_sys_req;
  assign is_l2_req         = ((l2_wb_en_o | l2_rm_en_o) | (~is_l1_req & tlb2dc_valid & ~is_sys_req)) & en_ex2dc;
  assign l1_is_working     = is_l1_req | l2_wb_en_o | l2_rm_en_o | /*rff_is_l1_resp;*/(rff_is_l1_resp & (l1_common_wt_en | l1_common_rd_en) );

  assign is_wr_req         = tlb2dc_valid & rff_ex2dc_we;
  assign is_rd_req         = tlb2dc_valid & rff_ex2dc_re;
  assign is_sys_wr_req     = is_wr_req & is_sys_req;
  assign is_sys_rd_req     = is_rd_req & is_sys_req;
  assign is_l2_no_resp_req = is_l2_req & (rff_ex2dc_we & ~rff_ex2dc_sc & ~l2_rm_en_o);

  always_comb begin
    if (is_bar_req) begin
      dc2tlb_ready = '0;
    end else if (is_excp) begin
      dc2tlb_ready = '1;
    end else if (is_l1_req | is_l2_req) begin
      dc2tlb_ready = is_amo_store_req ? '1: /*cpu_if_req_ready*/ l1_hit_en;
    end else if (is_sys_wr_req) begin
      dc2tlb_ready = '1;
    end else if (is_sys_rd_req) begin
      dc2tlb_ready = sysbus_req_if_arready;
    end else begin
      dc2tlb_ready = '0;
    end
  end

  // }}}



  //==========================================================
  // Flop valid requests {{{

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_ex2dc_re <= '0;
      rff_ex2dc_we <= '0;
      rff_ex2dc_lr <= '0;
      rff_ex2dc_sc <= '0;
      rff_ex2dc_amo_store <= '0;
      rff_ex2dc_amo_load <= '0;
      rff_ex2dc_aq_rl <= '0;
    end else begin
      rff_ex2dc_re <= ex2dc.re;
      rff_ex2dc_we <= ex2dc.we;
      rff_ex2dc_lr <= ex2dc.lr;
      rff_ex2dc_sc <= ex2dc.sc;
      rff_ex2dc_amo_store <= ex2dc.amo_store;
      rff_ex2dc_amo_load <= ex2dc.amo_load;
      rff_ex2dc_aq_rl <= ex2dc.aq_rl;
    end
  end

  always_ff @(posedge ex2dc_pckt_clkg) begin
    if (en_ex2dc_clk) begin
      dff_ex2dc_addr <= ex2dc.addr;
      dff_ex2dc_wdata <= ex2dc.wdata;
      dff_ex2dc_mask <= ex2dc.mask;
      dff_ex2dc_width <= ex2dc.width;
    end
  end
    
  assign en_ex2dc = rff_ex2dc_re | rff_ex2dc_we | rff_ex2dc_lr | rff_ex2dc_sc | rff_ex2dc_amo_store | rff_ex2dc_amo_load |rff_ex2dc_aq_rl;
  // }}}

  //==========================================================
  // Resp path {{{

  logic sysbus_req_if_awvalid_pre, sysbus_req_if_wvalid_pre;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_sys_rd_resp <= '0;
    end else begin
      if (sysbus_req_if_arvalid & sysbus_req_if_arready) begin
        rff_is_sys_rd_resp <= '1;
      end else if (sysbus_resp_if_rvalid & sysbus_resp_if_rready) begin
        rff_is_sys_rd_resp <= '0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_l1_resp <= '0;
    end else begin
      if (cpu_l1_req_valid & (l1_common_rd_en | l1_common_wt_en)) begin
        rff_is_l1_resp <= '1;
      end else /*if (cpu_l1_resp_valid)*/ begin
        rff_is_l1_resp <= '0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_l2_resp <= '0;
    end else begin
      if (~dc2ma.valid & cpu_if_req_valid & cpu_if_req_ready & (l2_rm_en_o | rff_ex2dc_aq_rl | rff_ex2dc_sc)) begin
        rff_is_l2_resp <= '1;
      end else if (cpu_if_resp_valid & cpu_if_resp_ready) begin
        rff_is_l2_resp <= '0;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_sys_wr_resp <= '0;
    end else begin
      if (sysbus_req_if_awvalid_pre) begin
        rff_is_sys_wr_resp <= '1;
      end else if (sysbus_resp_if_bvalid & sysbus_resp_if_bready) begin
        rff_is_sys_wr_resp <= '0;
      end
    end
  end

  // }}}

  //==========================================================
  // AMO store {{{


  assign is_amo_store_req = rff_ex2dc_amo_store;

  assign cpu_amo_store_req_valid = tlb2dc_valid & is_l2_req & ~is_excp & is_amo_store_req;

  assign cpu_amo_store_req.req_paddr = req_paddr;
  assign cpu_amo_store_req.req_data = l2_write_data;
  assign cpu_amo_store_req.req_mask = l2_write_mask;
  assign cpu_amo_store_req.req_tid.src = ORV64_DC_SRC_ID;
  assign cpu_amo_store_req.req_tid.tid = rff_tid;
  assign cpu_amo_store_req.req_tid.cpu_noc_id = 3'h0;
  assign cpu_amo_store_req.req_type = REQ_AMO_SC;

  // }}}

  //==========================================================
  // Barrier {{{

  logic [BANK_ID_WIDTH:0] rff_bar_bank_id;
  bank_id_t               rff_bar_resp_cnt;
  logic                   last_bar_resp;

  assign is_bar_req = rff_ex2dc_aq_rl;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_bar_bank_id <= '0;
    end else begin
      if (last_bar_resp) begin
        rff_bar_bank_id <= '0;
      end else if (cpu_if_req_valid & cpu_if_req_ready & (cpu_if_req.req_type == REQ_BARRIER_SYNC)) begin
        rff_bar_bank_id <= rff_bar_bank_id + BANK_ID_WIDTH'('h1);
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_bar_resp_cnt <= '0;
    end else begin
      if (last_bar_resp) begin
        rff_bar_resp_cnt <= '0;
      end else if (is_bar_req & cpu_if_resp_valid & cpu_if_resp_ready) begin
        rff_bar_resp_cnt <= rff_bar_resp_cnt + BANK_ID_WIDTH'('h1);
      end
    end
  end

  assign last_bar_resp = is_bar_req & (rff_bar_resp_cnt == '1) & cpu_if_resp_valid & cpu_if_resp_ready;

  assign barrier_paddr.tag = '0;
  assign barrier_paddr.bank_index = '0;
  assign barrier_paddr.bank_id = rff_bar_bank_id[BANK_ID_WIDTH-1:0];
  assign barrier_paddr.offset = '0;

  // }}}

  //==========================================================
  // L1 {{{

  // uncached
  logic uncached_addr_range_en;
`ifndef UNCACHED
  // assign uncached_addr_range_en = (req_paddr >= UNCACHED_ADDR_S && req_paddr < UNCACHED_ADDR_E) 
  //                               | (req_paddr >= UNCACHED_ADDR_STRUCT_1_S && req_paddr <= (UNCACHED_ADDR_STRUCT_1_E))
  //                               | (req_paddr >= UNCACHED_ADDR_STRUCT_2_S && req_paddr <= (UNCACHED_ADDR_STRUCT_2_E))
  //                               | (req_paddr >= UNCACHED_ADDR_TARGET_1_S && req_paddr <= (UNCACHED_ADDR_TARGET_1_E))
  //                               | (req_paddr >= UNCACHED_ADDR_TARGET_2_S && req_paddr <= (UNCACHED_ADDR_TARGET_2_E));
                               // | (req_paddr >= UNCACHED_ADDR_X1 && req_paddr <= UNCACHED_ADDR_X2);

  assign uncached_addr_range_en = (req_paddr >= UNCACHED_ADDR_S && req_paddr < UNCACHED_ADDR_E) 
                                | (req_paddr >= UNCACHED_ADDR_STRUCT_1_S && req_paddr <= (UNCACHED_ADDR_STRUCT_1_S+56'd64))
                                | (req_paddr >= UNCACHED_ADDR_STRUCT_2_S && req_paddr <= (UNCACHED_ADDR_STRUCT_2_S+56'd64))
                                | (req_paddr >= UNCACHED_ADDR_TARGET_1_S && req_paddr <= (UNCACHED_ADDR_TARGET_1_S+56'd64));
                                // | (req_paddr >= UNCACHED_ADDR_TARGET_2_S && req_paddr <= (UNCACHED_ADDR_TARGET_2_S+56'd64));
`else  
  assign uncached_addr_range_en = 1;
`endif

  // assign uncached_addr_range_en = 0;


  logic [ORV64_PAGE_OFFSET_WIDTH-1:0] page_ofs;

  assign page_ofs = dff_ex2dc_addr[ORV64_PAGE_OFFSET_WIDTH-1:0];

  assign cpu_l1_req_valid              = (is_bar_req & ~rff_bar_bank_id[BANK_ID_WIDTH]) | (l1_is_working & ~is_excp & ~is_amo_store_req);
  assign cpu_l1_req.req_paddr          = is_bar_req ? barrier_paddr: req_paddr;
  assign cpu_l1_req.req_data           = l1_write_data;
  assign cpu_l1_req.req_mask           = l1_write_mask;
  assign cpu_l1_req.req_tid.src        = ORV64_DC_SRC_ID;
  assign cpu_l1_req.req_tid.tid        = rff_tid;
  assign cpu_l1_req.req_tid.cpu_noc_id = 4'h0;


  always_comb begin
    if (rff_ex2dc_aq_rl) begin
      cpu_l1_req.req_type = REQ_BARRIER_SYNC;
    end else if (rff_ex2dc_we) begin
      cpu_l1_req.req_type = rff_ex2dc_amo_store ? REQ_AMO_SC : (rff_ex2dc_sc ? REQ_SC : REQ_WRITE);
    end else begin
      cpu_l1_req.req_type = rff_ex2dc_amo_load ? REQ_AMO_LR : (rff_ex2dc_lr ? REQ_LR: REQ_READ);
    end
  end
  

  assign l1_common_rd_en = (cpu_l1_req.req_type == REQ_READ ) & rff_ex2dc_re;
  assign l1_common_wt_en = (cpu_l1_req.req_type == REQ_WRITE) & rff_ex2dc_we;
  assign l2_l1_valid_en  = cpu_if_resp_valid; 
  assign l2_l1_addr      = l2_rm_addr_o;
  assign l2_l1_data      = cpu_if_resp.resp_data;
  assign l2_l1_mask      = cpu_if_resp.resp_mask;
  assign l1_en           = cpu_l1_req_valid & (l1_common_rd_en | l1_common_wt_en) | rff_is_l2_resp; // only deal with common rw temporarily

  always_comb begin
    case (dff_ex2dc_addr[4:3])
      2'b00: begin
        l1_write_data = {192'h0, dff_ex2dc_wdata};
        l1_write_mask = {24'h0, dff_ex2dc_mask};
      end
      2'b01: begin
        l1_write_data = {128'h0, dff_ex2dc_wdata, 64'h0};
        l1_write_mask = {16'h0, dff_ex2dc_mask, 8'h0};
      end
      2'b10: begin
        l1_write_data = {64'h0, dff_ex2dc_wdata, 128'h0};
        l1_write_mask = {8'h0, dff_ex2dc_mask, 16'h0};
      end
      2'b11: begin
        l1_write_data = {dff_ex2dc_wdata, 192'h0};
        l1_write_mask = {dff_ex2dc_mask, 24'h0};
      end
      default: begin
        l1_write_data = '0;
        l1_write_mask = '0;
      end
    endcase
  end

  logic l1_hit_en_last;
  assign l1_hit_en         = ((l1_common_rd_en & ~l1_rd_miss_en) | (l1_common_wt_en & ~l1_wt_miss_en)) & (uncached_addr_range_en ? ~l1_hit_en_last : '1);
  always_ff @(posedge clk) begin
    if(rst)
      l1_hit_en_last <= '0;
    else
      l1_hit_en_last <= l1_hit_en;
  end
  
  logic dc_inst_finish_en;
  assign dc_inst_finish_en = (l1_common_rd_en | l1_common_wt_en) ? dc2ma.valid : '1;


  data_cache_mesi #(
    .ADDR_SIZE(PHY_ADDR_WIDTH), 
    .LINE_BYTE(CACHE_LINE_BYTE)
    // .MEM_DEPTH(1024)
    ) dcache(
    .clk                            ( clk                    ),
    .rst                            ( rst                    ),
    .dc_inst_finish_en              ( dc_inst_finish_en      ),
    .data_addr_i                    ( cpu_l1_req.req_paddr   ), 
    .store_data_i                   ( cpu_l1_req.req_data    ), 
    .load_data_o                    ( cpu_l1_resp            ),
    .CS                             ( '1/*l1_en*/                  ),
    .MemR_en_i                      ( l1_common_rd_en        ), 
    .MemW_en_i                      ( l1_common_wt_en        ),
    .byte_enable_i                  ( cpu_l1_req.req_mask    ),
    .readMiss_o                     ( l1_rd_miss_en          ),    // read miss
    .writeMiss_o                    ( l1_wt_miss_en          ),     // write miss
    .resp_valid_o                   ( cpu_l1_resp_valid      ),

    // L2
    // L2 signals
    .l2_ready_i                     ( cpu_if_req_ready       ),
    .first_cycle_en,
    // write back
    .l2_wb_en_o,
    .l2_wb_addr_o,
    .l2_wb_data_o,
    // read miss
    .l2_rm_en_o,
    .l2_rm_addr_o,
    .l2_valid_en_i                  ( l2_l1_valid_en         ),
    .l2_addr_i                      ( l2_l1_addr             ),
    .l2_data_i                      ( l2_l1_data             ),
    // uncached
    .uncached_addr_range_en         ( uncached_addr_range_en ),
    .l2_mask_i                      ( l2_l1_mask             )
  );


  // }}}


  //==========================================================
  // L2 {{{
  assign cpu_if_req_valid = (is_bar_req & ~rff_bar_bank_id[BANK_ID_WIDTH]) | (is_l2_req & ~is_excp & ~is_amo_store_req);
  assign cpu_if_req.req_paddr = is_bar_req ? barrier_paddr
                              :(l2_wb_en_o ? l2_wb_addr_o 
                              :(l2_rm_en_o ? l2_rm_addr_o
                              : req_paddr));
  assign cpu_if_req.req_data = l2_wb_en_o ? l2_wb_data_o : l2_write_data;
  assign cpu_if_req.req_mask = (l2_wb_en_o & ~uncached_addr_range_en) ? {CACHE_LINE_BYTE{1'b1}} : l2_write_mask;
  assign cpu_if_req.req_tid.src = ORV64_DC_SRC_ID;
  assign cpu_if_req.req_tid.tid = rff_tid;
  assign cpu_if_req.req_tid.cpu_noc_id = 4'h0;

  always_comb begin
    if (l2_wb_en_o) begin // l1 write back to l2(rd/wt modified && taghit)
      cpu_if_req.req_type = REQ_WRITE;
    end else if (l2_rm_en_o) begin // l1 read miss(rd/wt invalid || wt shared)
      cpu_if_req.req_type = REQ_READ;
    end else if (rff_ex2dc_aq_rl) begin
      cpu_if_req.req_type = REQ_BARRIER_SYNC;
    end else if (rff_ex2dc_we) begin
      cpu_if_req.req_type = rff_ex2dc_amo_store ? REQ_AMO_SC : (rff_ex2dc_sc ? REQ_SC : REQ_WRITE);
    end else begin
      cpu_if_req.req_type = rff_ex2dc_amo_load ? REQ_AMO_LR : (rff_ex2dc_lr ? REQ_LR: REQ_READ);
    end
  end

  logic cpu_if_resp_ready_last;
  assign cpu_if_resp_ready = rff_is_l2_resp | is_bar_req | (uncached_addr_range_en & cpu_if_resp_ready_last);
  always_comb begin
    case (dff_ex2dc_addr[4:3])
      2'b00: begin
        l2_write_data = {192'h0, dff_ex2dc_wdata};
        l2_write_mask = {24'h0, dff_ex2dc_mask};
      end
      2'b01: begin
        l2_write_data = {128'h0, dff_ex2dc_wdata, 64'h0};
        l2_write_mask = {16'h0, dff_ex2dc_mask, 8'h0};
      end
      2'b10: begin
        l2_write_data = {64'h0, dff_ex2dc_wdata, 128'h0};
        l2_write_mask = {8'h0, dff_ex2dc_mask, 16'h0};
      end
      2'b11: begin
        l2_write_data = {dff_ex2dc_wdata, 192'h0};
        l2_write_mask = {dff_ex2dc_mask, 24'h0};
      end
      default: begin
        l2_write_data = '0;
        l2_write_mask = '0;
      end
    endcase
  end

  // }}}

  //==========================================================
  // TID {{{

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_tid <= '0;
    end else begin
      if (dc2ma.valid) begin
        rff_tid <= rff_tid + CPUNOC_TID_TID_SIZE'('h1);
      end
    end
  end

  // }}}

  //==========================================================
  // MA resp {{{

  logic                      pmp_excp_valid;
  orv64_excp_cause_t         pmp_excp_cause;
  orv64_excp_cause_t         excp_cause;

  logic l1_done_en;
  assign l1_done_en = l1_hit_en; // & ( uncached_addr_range_en ? ( (~cpu_if_resp_ready) | (cpu_if_resp_ready  & cpu_if_resp_valid) ) : '1); // cpu_if_resp_ready has to be hold for 2 cycles to down cpu_if_resp_valid

  logic cpu_if_resp_ready_last_next;
  assign cpu_if_resp_ready_last_next = cpu_if_resp_valid ? cpu_if_resp_ready : '0;
  always_ff @ (posedge clk) begin
    if(rst)
      cpu_if_resp_ready_last <= '0;
    else
      cpu_if_resp_ready_last <= cpu_if_resp_ready_last_next;
  end

  always_comb begin
    if (is_bar_req) begin
      dc2ma.valid = last_bar_resp;
    end else if (is_amo_store_req & is_l2_req) begin
      dc2ma.valid = cpu_amo_store_req_ready;
    end else if (is_excp) begin
      dc2ma.valid = '1;
    end else if (~l1_is_working & is_l2_no_resp_req) begin
      dc2ma.valid = cpu_if_req_ready;
    end else if (~l1_is_working & rff_is_l2_resp) begin
      dc2ma.valid = cpu_if_resp_valid;
    end else if (/*rff_is_l1_resp*/l1_is_working)begin     // here has to be a bug
      dc2ma.valid = l1_done_en;
    end else if (rff_is_sys_wr_resp) begin
      dc2ma.valid = sysbus_resp_if_bvalid;
    end else if (rff_is_sys_rd_resp) begin
      dc2ma.valid = sysbus_resp_if_rvalid;
    end else begin
      dc2ma.valid = '0;
    end
  end

  always_comb begin
    if (tlb2dc_valid & tlb2dc.resp_excp_valid) begin
      is_excp = '1;
      excp_cause = tlb2dc.resp_excp_cause;
    //end else if (tlb2dc_valid & is_sys_req & (rff_ex2dc_aq_rl | rff_ex2dc_amo_store | rff_ex2dc_amo_load | rff_ex2dc_lr | rff_ex2dc_sc)) begin
    //  is_excp = '1;
    //  excp_cause = rff_ex2dc_we ? ORV64_EXCP_CAUSE_STORE_ACCESS_FAULT: ORV64_EXCP_CAUSE_LOAD_ACCESS_FAULT;
    end else if (pmp_excp_valid) begin
      is_excp = '1;
      excp_cause = pmp_excp_cause;
    end else begin
      is_excp = '0;
      excp_cause = ORV64_EXCP_CAUSE_NONE;
    end
  end

  assign dc2ma.excp_valid = is_excp;
  assign dc2ma.excp_cause = excp_cause;
  assign dc2ma.rdata =   /*rff_is_l1_resp*/l1_is_working ? cpu_l1_resp
                       : rff_is_l2_resp ? (rff_ex2dc_sc ? cpu_if_resp.resp_data[63:0] : cpu_if_resp.resp_data[64*dff_ex2dc_addr[4:3]+:64]): sysbus_resp_if_r.rdata;;

  // }}}

  //==========================================================
  // Sysbus {{{

  logic                do_use_saved_aw;
  oursring_req_if_aw_t dff_saved_aw;

  assign sysbus_req_if_arvalid = is_sys_rd_req & ~is_excp;
  assign sysbus_req_if_ar.arid = {{($bits(ring_tid_t)-CPUNOC_TID_TID_SIZE){1'b0}}, rff_tid};
  assign sysbus_req_if_ar.araddr = req_paddr[RING_ADDR_WIDTH-1:0];
  assign sysbus_resp_if_rready = rff_is_sys_rd_resp;

  assign sysbus_req_if_awvalid_pre = is_sys_wr_req & ~is_excp;
  assign sysbus_req_if_wvalid_pre  = sysbus_req_if_awvalid_pre;

  sd_hold_valid #(.BACKEND_DOMAIN(ORV64_PD)) sd_hold_awvalid_u (.s_valid(sysbus_req_if_awvalid_pre), .d_valid(sysbus_req_if_awvalid), .d_ready(sysbus_req_if_awready), .do_save(do_save_aw), .do_use_saved(do_use_saved_aw), .rstn(~rst), .*);
  sd_hold_valid #(.BACKEND_DOMAIN(ORV64_PD)) sd_hold_wvalid_u (.s_valid(sysbus_req_if_wvalid_pre), .d_valid(sysbus_req_if_wvalid), .d_ready(sysbus_req_if_wready), .do_save(), .do_use_saved(), .rstn(~rst), .*);

  assign sysbus_req_if_aw.awid = do_use_saved_aw ? dff_saved_aw.awid: {{($bits(ring_tid_t)-CPUNOC_TID_TID_SIZE){1'b0}}, rff_tid};
  assign sysbus_req_if_aw.awaddr = do_use_saved_aw ? dff_saved_aw.awaddr: req_paddr[RING_ADDR_WIDTH-1:0];

  assign sysbus_req_if_w.wdata = dff_ex2dc_wdata;
  assign sysbus_req_if_w.wstrb = dff_ex2dc_mask;
  assign sysbus_req_if_w.wlast = '1;

  assign sysbus_resp_if_bready = rff_is_sys_wr_resp;

  always_ff @(posedge aw_clkg) begin
    if (do_save_aw) begin
      dff_saved_aw <= sysbus_req_if_aw;
    end
  end

  // }}}

  //==========================================================
  // Fence {{{

  logic rff_has_fence_resp;

  assign dc2ex_fence_req_ready = ~(rff_has_fence_resp | (dc2ma_fence_resp_valid & ma2dc_fence_resp_ready));
  assign dc2ma_fence_resp_valid = rff_has_fence_resp;
  assign dc2ma_fence_resp.resp_fence_is_done = '1;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_has_fence_resp <= '0;
    end else begin
      if (dc2ma_fence_resp_valid & ma2dc_fence_resp_ready) begin
        if (ex2dc_fence_req_valid & dc2ex_fence_req_ready) begin
          rff_has_fence_resp <= '1;
        end else begin
          rff_has_fence_resp <= '0;
        end
      end
    end
  end

  // }}}

  //==========================================================
  // PMP check {{{

  orv64_access_type_t        access_type;
  cpu_byte_mask_t            access_byte_width;

  assign req_paddr = {tlb2dc.resp_ppn, page_ofs};
  assign access_byte_width = dff_ex2dc_width;

  always_comb begin
    if (rff_ex2dc_we) begin
      access_type = rff_ex2dc_amo_store ? ORV64_ACCESS_AMO: ORV64_ACCESS_STORE;
    end else begin
      access_type = rff_ex2dc_amo_load ? ORV64_ACCESS_AMO: ORV64_ACCESS_LOAD;
    end
  end

  orv64_pmp_checker pmp_checker_u
  (
    .prv,
    .mstatus,
    .pmpcfg,
    .pmpaddr,
    .paddr_valid(tlb2dc_valid),
    .paddr(req_paddr),
    .access_type,
    .access_byte_width,
    .excp_valid(pmp_excp_valid),
    .excp_cause(pmp_excp_cause)
  );

  // }}}

  //==========================================================
  // Debug prints {{{
`ifndef SYNTHESIS
`ifndef VERILATOR
  cpu_if_req_valid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(cpu_if_req_valid))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: cpu_if_req_valid is x"));
  cpu_if_resp_valid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(cpu_if_resp_valid))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: cpu_if_resp_valid is x"));
  awvalid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(sysbus_req_if_awvalid))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: sysbus_req_if_awvalid is x"));
  wvalid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(sysbus_req_if_wvalid))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: sysbus_req_if_wvalid is x"));
  arvalid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(sysbus_req_if_arvalid))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: sysbus_req_if_arvalid is x"));
  bready_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(sysbus_resp_if_bready))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: sysbus_resp_if_bready is x"));
  rready_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(sysbus_resp_if_rready))) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: sysbus_resp_if_rready is x"));
  unexpected_l2_resp: assert property (@(posedge clk) disable iff (rst !== '0) (cpu_if_resp_valid |-> cpu_if_resp_ready)) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: received l2 resp with no request"));
  unexpected_bresp: assert property (@(posedge clk) disable iff (rst !== '0) (sysbus_resp_if_bvalid |-> rff_is_sys_wr_resp)) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: received bresp with no request"));
  unexpected_rresp: assert property (@(posedge clk) disable iff (rst !== '0) (sysbus_resp_if_rvalid |-> rff_is_sys_rd_resp)) else `olog_fatal("ORV_DCACHE_BYPASS", $sformatf("%m: received rresp with no request"));
  wrong_l2_tid: assert property (@(posedge clk) disable iff (rst !== '0) ((cpu_if_resp_valid & cpu_if_resp_ready) |-> ((cpu_if_resp.resp_tid.tid === rff_tid) & (cpu_if_resp.resp_tid.src === ORV64_DC_SRC_ID)))) else `olog_error("ORV_DCACHE_BYPASS", $sformatf("%m: tid=%h src=%h, exp_tid=%h exp_src=%h", cpu_if_resp.resp_tid.tid, cpu_if_resp.resp_tid.src, rff_tid, ORV64_DC_SRC_ID));
  wrong_bresp_tid: assert property (@(posedge clk) disable iff (rst !== '0) ((sysbus_resp_if_bvalid & sysbus_resp_if_bready) |-> (sysbus_resp_if_b.bid[CPUNOC_TID_TID_SIZE-1:0] === rff_tid))) else `olog_error("ORV_DCACHE_BYPASS", $sformatf("%m: bid=%h, exp_bid=%h", sysbus_resp_if_b.bid[CPUNOC_TID_TID_SIZE-1:0], rff_tid));
  wrong_rresp_tid: assert property (@(posedge clk) disable iff (rst !== '0) ((sysbus_resp_if_rvalid & sysbus_resp_if_rready) |-> (sysbus_resp_if_r.rid[CPUNOC_TID_TID_SIZE-1:0] === rff_tid))) else `olog_error("ORV_DCACHE_BYPASS", $sformatf("%m: rid=%h, exp_rid=%h", sysbus_resp_if_r.rid[CPUNOC_TID_TID_SIZE-1:0], rff_tid));
`endif
`endif
  // }}}

  //==========================================================
  // Debug prints {{{

`ifndef SYNTHESIS
`ifndef VERILATOR
  string req_filename;
  string req_filename;
  string resp_filename;
  int dc_req_file;
  int dc_resp_file;
  logic mem_print_flag;

  initial begin
    if ($test$plusargs("print_core_mem_access")) begin
      #1;
      req_filename = $sformatf("dc_req%0d.log", core_id);
      dc_req_file = $fopen(req_filename, "w");
      resp_filename = $sformatf("dc_resp%0d.log", core_id);
      dc_resp_file = $fopen(resp_filename, "w");
      mem_print_flag = 1'b1;
    end else begin
      mem_print_flag = 1'b0;
    end
  end

  always_ff @ (posedge clk) begin
    if (mem_print_flag) begin
      if (~rst) begin
        if (cpu_if_req_valid & cpu_if_req_ready) begin
          $fdisplay(dc_req_file, "time=%t", $time);
          $fdisplay(dc_req_file, "\tpaddr=%h", cpu_if_req.req_paddr);
          $fdisplay(dc_req_file, "\tdata=%h", cpu_if_req.req_data);
          $fdisplay(dc_req_file, "\tmask=%h", cpu_if_req.req_mask);
          $fdisplay(dc_req_file, "\treq_tid=%h", cpu_if_req.req_tid);
          $fdisplay(dc_req_file, "\treq_type=%s", cpu_if_req.req_type.name());
        end
        if (cpu_amo_store_req_valid & cpu_amo_store_req_ready) begin
          $fdisplay(dc_req_file, "time=%t", $time);
          $fdisplay(dc_req_file, "\tpaddr=%h", cpu_amo_store_req.req_paddr);
          $fdisplay(dc_req_file, "\tdata=%h", cpu_amo_store_req.req_data);
          $fdisplay(dc_req_file, "\tmask=%h", cpu_amo_store_req.req_mask);
          $fdisplay(dc_req_file, "\treq_tid=%h", cpu_amo_store_req.req_tid);
          $fdisplay(dc_req_file, "\treq_type=%s", cpu_amo_store_req.req_type.name());
        end
      end
    end
  end
  always_ff @ (posedge clk) begin
    if (mem_print_flag) begin
      if (~rst) begin
        if (cpu_if_resp_valid & cpu_if_resp_ready) begin
          $fdisplay(dc_resp_file, "time=%t", $time);
          $fdisplay(dc_resp_file, "\tdata=%h", cpu_if_resp.resp_data);
          $fdisplay(dc_resp_file, "\tmask=%h", cpu_if_resp.resp_mask);
          $fdisplay(dc_resp_file, "\tresp_tid=%h", cpu_if_resp.resp_tid);
        end
      end
    end
  end
`endif
`endif
 // }}}

logic a_the_addr;
assign a_the_addr = req_paddr == 56'h800020ac;
endmodule



