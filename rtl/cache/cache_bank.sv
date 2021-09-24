// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

/*
        L2 bank pipeline

        valid | tag/LRU | data/dirty bit

ES1:
        dirty/valid/LRU rams are always on
        one sleep control of tag per way
        one sleep control of data per CPU_DATA_WIDTH per way
TODO:
        add pwr performance counters to track sleep time
*/

/*
L2 cache address, L2 is single port ram use lower address as bank ID to
provide a interleaved read pattern for higher bandwidth.
+-----------------------+-------------+---------+--------+
|         tag           |  bank_index | bank ID | offset |
+-------------+---------+-------------+---------+--------+
*/

module cache_bank
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import cache_func::*;
#(
  parameter int N_MSHR=4,
  parameter int BANK_ID=0
) (
  // cpu request interface
  input   logic                 cpu_l2_req_if_req_valid,
  output  logic                 cpu_l2_req_if_req_ready,
  input   cpu_cache_if_req_t    cpu_l2_req_if_req,   
  // cpu response interface
  output  logic                 cpu_l2_resp_if_resp_valid,
  input   logic                 cpu_l2_resp_if_resp_ready,
  output  cpu_cache_if_resp_t     cpu_l2_resp_if_resp,
  // amo store interface
  input   logic                 l2_amo_store_req_valid,
  output  logic                 l2_amo_store_req_ready,
  input   cpu_cache_if_req_t    l2_amo_store_req,

  // control
  input   ctrl_reg_t  s2b_ctrl_reg,
  
  // idle indication
  output  cache_is_idle,

  // scan
  input  scan_mode,
  input  tst_en,

  // icg disable
  input  s2b_icg_disable,

  // mem interface
  // mem-noc interface
  // AW 
  output logic                l2_req_if_awvalid,
  input     logic                 l2_req_if_awready,
  output cache_mem_if_aw_t    l2_req_if_aw,
  // W 
  output logic                 l2_req_if_wvalid,
  input     logic                 l2_req_if_wready,
  output cache_mem_if_w_t     l2_req_if_w,
  // B
  input  logic                 l2_resp_if_bvalid,
  output logic                 l2_resp_if_bready,
  input  cache_mem_if_b_t     l2_resp_if_b,
  // AR
  output logic                 l2_req_if_arvalid,
  input  logic                 l2_req_if_arready,
  output cache_mem_if_ar_t     l2_req_if_ar,
  // R
  input  logic                 l2_resp_if_rvalid,
  output logic                 l2_resp_if_rready,
  input  cache_mem_if_r_t     l2_resp_if_r,

  // debug interface
  input   logic           debug_en, 
  input   logic           debug_rw,
  input   logic           debug_valid_ram_en,
  input   logic           debug_dirty_ram_en,
  input   logic           debug_lru_ram_en,
  input   bank_index_t    debug_addr,
  input   mem_data_t      debug_wdata,
  input   cpu_byte_mask_t debug_wdata_byte_mask,
  input   [N_WAY-1:0]     debug_valid_dirty_bit_mask,

  input   [N_WAY-1:0]     debug_data_ram_en_pway,
  input   [N_WAY-1:0]     debug_tag_ram_en_pway,
  input                   debug_hpmcounter_en,

  output  cpu_data_t      debug_rdata,
  output  logic           debug_ready,

  // memory barrier bits
  input    mem_barrier_sts_t [N_BANK-2:0] mem_barrier_clr_pbank_in,
  output   mem_barrier_sts_t              mem_barrier_status_out,
  input    mem_barrier_sts_t [N_BANK-2:0] mem_barrier_status_in,
  output   mem_barrier_sts_t [N_BANK-2:0] mem_barrier_clr_pbank_out,
 
  // ~rst & clk
  input   logic       s2b_rstn,
  input   logic       clk
);

  cpu_req_t   cpu_req;
  cpu_resp_t  cpu_resp;
  logic        cpu_req_valid;
  logic       cpu_req_ready; 
  logic       cpu_resp_valid;
  logic        cpu_resp_ready;


 
  assign cpu_req_valid             = cpu_l2_req_if_req_valid;

  generate
    for (genvar i = 0; i < N_BANK-1; i++) begin : TMP_WIRE
      assign mem_barrier_clr_pbank_out[i] = '0;
    end
  endgenerate
 
  assign mem_barrier_status_out = '0;
  
  ctrl_reg_t ctrl_reg;
  logic  rst; //for submodules
  logic  amo_store_select;
 
  assign amo_store_select = cur_lock_fsm.lock_is_active & l2_amo_store_req_valid;
  assign rst = s2b_rstn;
  assign ctrl_reg =  s2b_ctrl_reg;
  assign cpu_l2_req_if_req_ready   = cpu_req_ready;    
  assign cpu_l2_resp_if_resp_valid = cpu_resp_valid;
  assign cpu_resp_ready            = cpu_l2_resp_if_resp_ready;
  assign l2_amo_store_req_ready   = cur_lock_fsm.lock_is_active;   
  // AMO cpu_req = l2_amo_store_req_valid ? l2_amo_store_req : cpu_l2_req_if_req 
  assign cpu_req.paddr.tag           = amo_store_select ? l2_amo_store_req.req_paddr[TAG_MSB:TAG_LSB] : cpu_l2_req_if_req.req_paddr[TAG_MSB:TAG_LSB];
  assign cpu_req.paddr.bank_index = amo_store_select ? l2_amo_store_req.req_paddr[BANK_INDEX_MSB:BANK_INDEX_LSB] : cpu_l2_req_if_req.req_paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];
  assign cpu_req.paddr.bank_id       = amo_store_select ? l2_amo_store_req.req_paddr[BANK_ID_MSB:BANK_ID_LSB] : cpu_l2_req_if_req.req_paddr[BANK_ID_MSB:BANK_ID_LSB];
  assign cpu_req.paddr.offset       = amo_store_select ? l2_amo_store_req.req_paddr[OFFSET_MSB:0] : cpu_l2_req_if_req.req_paddr[OFFSET_MSB:0];
  assign cpu_req.byte_mask        = amo_store_select ? l2_amo_store_req.req_mask : cpu_l2_req_if_req.req_mask;
  assign cpu_req.data              = amo_store_select ? l2_amo_store_req.req_data : cpu_l2_req_if_req.req_data;
  assign cpu_req.tid              = amo_store_select ? l2_amo_store_req.req_tid  : cpu_l2_req_if_req.req_tid;
  assign cpu_req.req_type          = amo_store_select ? l2_amo_store_req.req_type : cpu_l2_req_if_req.req_type;
  assign cpu_l2_resp_if_resp.resp_tid          = cpu_resp.tid;
  assign cpu_l2_resp_if_resp.resp_mask        = cpu_resp.byte_mask;
  assign cpu_l2_resp_if_resp.resp_data          = cpu_resp.data;

`ifndef SYNTHESIS
  import ours_logging::*;
  chk_req_bank_id: assert property (@(posedge clk) disable iff (~s2b_rstn) cpu_req_valid |-> (cpu_req.paddr[BANK_ID_MSB:BANK_ID_LSB] == BANK_ID))
    else `olog_error("L2_BANK", $sformatf("%m: bank %d gets an request has differet bank_id (paddr = %h)", BANK_ID, cpu_req.paddr));
  chk_paddr_range: assert property (@(posedge clk) disable iff (~s2b_rstn) cpu_req_valid |-> (cpu_req.paddr[TAG_MSB:DRAM_TAG_MSB+1] == '0))
    else `olog_fatal("L2_BANK", "%m: DRAM address range is limited by 32-bit boundary");
  chk_req_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) cpu_req_valid |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees an invalid request during sleep or power down mode", BANK_ID));

  chk_ongoing_req_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) (s1_valid_ff | s2_valid_ff | s3_valid_ff | mshr_bank[0].valid | mshr_bank[1].valid | mshr_bank[2].valid | mshr_bank[3].valid) |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees sleep or power down mode while processing request in pipelines", BANK_ID));

  chk_vld_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) (cc_valid_ram_re | mc_valid_ram_we | debug_valid_ram_en) |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees sleep or power down mode while reading/writing valid ram", BANK_ID));

  chk_dirty_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) (cc_dirty_ram_en | mc_dirty_ram_we | debug_dirty_ram_en) |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees sleep or power down mode while reading/writing dirty ram", BANK_ID));

  chk_lru_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) (lru_ram_re | lru_ram_we | debug_lru_ram_en) |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees sleep or power down mode while reading/writing lru ram", BANK_ID));

  chk_data_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) ((|cc_data_ram_en_pway) | (|mc_data_ram_en_pway) | (|debug_data_ram_en_pway)) |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees sleep or power down mode while reading/writing data ram", BANK_ID));

  chk_tag_pwr_down: assert property (@(posedge clk) disable iff (~s2b_rstn) ((|cc_tag_ram_re_pway) | (|mc_tag_ram_we_pway) | (|debug_tag_ram_en_pway)) |-> (ctrl_reg.pwr.bank_pwr_state == PWR_NORMAL))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees sleep or power down mode while reading/writing tag ram", BANK_ID));

  chk_mem_bar_stall: assert property (@(posedge clk) disable iff (~s2b_rstn) (s2_valid & s3_ready & (nxt.s2.cpu_req.req_type == REQ_BARRIER_SYNC) |-> rffce_no_outstanding_req))
    else `olog_error("L2_BANK", $sformatf("%m: L2 Bank %d sees memory barrier request moving forward while there are still outstanding requests", BANK_ID));
  

  cpu_req_t req_q[$];
  int qi[$];
  int wait_for_req[tid_t];
  bit [63:0] data_tmp[4];
  always @ (posedge clk) begin
    if (s2b_rstn) begin
      assert (!$isunknown(cpu_req_valid))     else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h cpu_req_valid is X after reset", BANK_ID));
      assert (!$isunknown(cpu_req_ready))     else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h cpu_req_ready is X after reset", BANK_ID));
      assert (!$isunknown(l2_req_if_awvalid)) else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_req_if_awvalid is X after reset", BANK_ID));
      assert (!$isunknown(l2_req_if_awready)) else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_req_if_awready is X after reset", BANK_ID));
      assert (!$isunknown(l2_req_if_arvalid)) else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_req_if_arvalid is X after reset", BANK_ID));
      assert (!$isunknown(l2_req_if_arready)) else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_req_if_arready is X after reset", BANK_ID));
      assert (!$isunknown(l2_resp_if_rvalid))  else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_resp_if_rvalid is X after reset", BANK_ID));
      assert (!$isunknown(l2_resp_if_rready))  else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_resp_if_rready is X after reset", BANK_ID));
      assert (!$isunknown(l2_resp_if_bvalid))  else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_resp_if_bvalid is X after reset", BANK_ID));
      assert (!$isunknown(l2_resp_if_bready))  else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_resp_if_bready is X after reset", BANK_ID));
      assert (!$isunknown(l2_req_if_wvalid))  else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_req_if_wvalid is X after reset", BANK_ID));
      assert (!$isunknown(l2_req_if_wready))  else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h l2_req_if_wready is X after reset", BANK_ID));
      if ((cpu_req_valid && cpu_req_ready) === '1) begin
        assert (!$isunknown(cpu_req.paddr)) else `olog_error("L2_BANK", $sformatf("%m: cpu_req.paddr is X"));
        assert (!$isunknown(cpu_req.tid)) else `olog_error("L2_BANK", $sformatf("%m: cpu_req.tid is X"));
        assert (!$isunknown(cpu_req.req_type)) else `olog_error("L2_BANK", $sformatf("%m: cpu_req.req_type is X"));
        if (cpu_req.req_type == REQ_WRITE | cpu_req.req_type == REQ_AMO_SC | cpu_req.req_type == REQ_SC)
          `olog_info("L2_BANK", $sformatf("%m: req type=%s paddr=%h tid=%h data=%h", cpu_req.req_type.name, cpu_req.paddr, cpu_req.tid, cpu_req.data));
        else if (cpu_req.req_type == REQ_FLUSH_ADDR)
          `olog_info("L2_BANK", $sformatf("%m: req type=%s paddr=%h tid=%h", cpu_req.req_type.name, cpu_req.paddr, cpu_req.tid));
        else if (cpu_req.req_type == REQ_FLUSH_IDX)
          `olog_info("L2_BANK", $sformatf("%m: req type=%s paddr=%h tid=%h", cpu_req.req_type.name, cpu_req.paddr, cpu_req.tid));
        else begin
          //$display("%m: req type=%s paddr=%h tid=%h", cpu_req.req_type.name, cpu_req.paddr, cpu_req.tid);
          `olog_info("L2_BANK", $sformatf("%m: req type=%s paddr=%h tid=%h", cpu_req.req_type.name, cpu_req.paddr, cpu_req.tid));
        end
        if ((cpu_req.req_type != REQ_WRITE) & (cpu_req.req_type != REQ_AMO_SC) & (cpu_req.req_type != REQ_BARRIER_SET)) begin
          qi = req_q.find_index with (item.tid == cpu_req.tid);
          assert ($size(qi) == 0) else `olog_error("L2_BANK", $sformatf("%m: req cpu_req.tid=%h has already existed", cpu_req.tid));
          req_q.push_front(cpu_req);
          wait_for_req[cpu_req.tid] = 0;
        end
      end
      if ((cpu_resp_valid & cpu_resp_ready) === '1) begin
        assert (!$isunknown(cpu_resp.tid)) else `olog_error("L2_BANK", $sformatf("%m: cpu_resp.tid is X"));

        {data_tmp[3], data_tmp[2], data_tmp[1], data_tmp[0]} = cpu_resp.data;
        assert (!$isunknown(data_tmp[3]) | !$isunknown(data_tmp[2]) | !$isunknown(data_tmp[1]) | !$isunknown(data_tmp[0])) else `olog_error("L2_BANK", $sformatf("%m: cpu_resp.data is X"));

        qi = req_q.find_index with (item.tid == cpu_resp.tid);
        if ($size(qi) == 1) begin
          `olog_info("L2_BANK", $sformatf("%m: resp type=%s paddr=%h tid=%h data=%h", req_q[qi[0]].req_type.name, req_q[qi[0]].paddr, cpu_resp.tid, cpu_resp.data));
          req_q.delete(qi[0]);
          wait_for_req[cpu_resp.tid] = 0;
        end else begin
          `olog_error("L2_BANK", $sformatf("%m: cpu_resp.tid=%h num_of_matching_req_tid=%d", cpu_resp.tid, $size(qi)));
        end
      end
    end
    if (~s2b_rstn) begin
      assert (!$rose(cpu_req_valid)) else `olog_error("L2_BANK", $sformatf("%m: BANK_ID=%1h cpu request comes before de-asserting reset", BANK_ID));
      req_q.delete();
    end

    foreach (req_q[i]) begin
      wait_for_req[req_q[i].tid]++;
      assert (wait_for_req[req_q[i].tid] < 1000000) else `olog_error("L2_BANK", $sformatf("%m: req tid=%h has waited for more than 1000000 cycles", req_q[i].tid));
    end
  end

  final begin
    foreach (req_q[i])
      `olog_warning("L2_BANK", $sformatf("%m: still-in-q cpu_req.tid=%h paddr=%h", req_q[i].tid, req_q[i].paddr));
  end
`endif

  //==========================================================
  // power configuration
  //==========================================================
  // {{{
  logic             bank_pwr_on, bank_pwr_down;
  logic             bank_slp;
  logic [N_WAY-1:0] way_pwr_down, way_slp, way_pwr_on;

  assign bank_pwr_down = scan_mode ? '1 : ctrl_reg.pwr.bank_pwr_state[BANK_ID] == PWR_DOWN;
  assign bank_pwr_on = ~bank_pwr_down;
  assign bank_slp = scan_mode ? '1 : ctrl_reg.pwr.bank_pwr_state[BANK_ID] == PWR_SLEEP;
  always_comb
    for (int i = 0; i < N_WAY; i++) begin: loop_way_pwr
      way_pwr_down[i] = scan_mode ? '1 : (ctrl_reg.pwr.way_pwr_state[i] == PWR_DOWN);
      way_slp[i] = scan_mode ? '1 : (ctrl_reg.pwr.way_pwr_state[i] == PWR_SLEEP);
      way_pwr_on[i] = ~way_pwr_down[i] & ~way_slp[i] & bank_pwr_on;
    end

  // }}}
  //==========================================================
  // SRAM instances
  // {{{

  logic             debug_valid_ram_ready, debug_dirty_ram_ready, debug_lru_ram_ready;
  cpu_data_t        debug_rdata_valid    , debug_rdata_dirty    , debug_rdata_lru;
  cpu_data_t        debug_rdata_tag_pway  [N_WAY-1:0];
  cpu_data_t        debug_rdata_data_pway [N_WAY-1:0];
  logic               lru_ram_ready, lru_ram_re, lru_ram_we;

  //------------------------------------------------------
  // valid ram & dirty ram
  //------------------------------------------------------
  // sram for valid/dirty bits (valid/dirty bits from all ways in a single RAM). The minium width of TSMC SPRAM is 2 bits. {{{
  bank_index_t      cc_valid_ram_raddr , mc_valid_ram_waddr;
  logic [N_WAY-1:0] cc_valid_ram_dout  , mc_valid_ram_din, mc_valid_ram_bwe;
  logic             cc_valid_ram_rready, cc_valid_ram_re , mc_valid_ram_we;

  bank_index_t      cc_dirty_ram_addr , mc_dirty_ram_waddr;
  logic             cc_dirty_ram_ready, cc_dirty_ram_rw  , cc_dirty_ram_en, cc_dirty_ram_din, mc_dirty_ram_we, mc_dirty_ram_din;
  logic [N_WAY-1:0] cc_dirty_ram_bwe  , cc_dirty_ram_dout, mc_dirty_ram_bwe;
  logic [N_WAY-1:0] debug_tag_ram_ready_pway;

  logic       vld_ram_clkg;
  logic       lru_ram_clkg;
  logic       dirty_ram_clkg;
  logic [N_WAY-1:0] tag_ram_clkg;
  logic [N_WAY-1:0] data_ram_clkg;

  logic             vld_ram_icg_en;
  logic             lru_ram_icg_en;
  logic             dirty_ram_icg_en;
  logic [N_WAY-1:0]    tag_ram_icg_en;
  logic [N_WAY-1:0]    data_ram_icg_en;

  logic             rff_vld_ram_icg_en;
  logic             rff_lru_ram_icg_en;
  logic             rff_dirty_ram_icg_en;
  logic [N_WAY-1:0]    rff_tag_ram_icg_en;
  logic [N_WAY-1:0]    rff_data_ram_icg_en;
 
  logic   s1_valid, s1_valid_ff,
          s2_valid, s2_valid_ff,
          s3_valid, s3_valid_ff;

`ifndef NO_L2
  cache_valid_ram VALID_RAM(
    // CC: read-only
    .cc_raddr(cc_valid_ram_raddr),
    .cc_re(cc_valid_ram_re),
    .cc_dout(cc_valid_ram_dout),
    .cc_rready(cc_valid_ram_rready),
    // MC: write-only
    .mc_waddr(mc_valid_ram_waddr),
    .mc_we(mc_valid_ram_we),
    .mc_bwe(mc_valid_ram_bwe),
    .mc_din(mc_valid_ram_din),
    // DA: read/write
    .debug_en(debug_valid_ram_en),
    .debug_addr,
    .debug_rw,
    .debug_din(debug_wdata[N_WAY-1:0]),
    .debug_bwe(debug_valid_dirty_bit_mask),
    .debug_dout(debug_rdata_valid),
    .debug_ready(debug_valid_ram_ready),
    // cfg
    .pwr_down(bank_pwr_down),
    .slp(bank_slp),
    .clk(vld_ram_clkg),
    .*);
`endif

`ifndef NO_L2
  cache_dirty_ram DIRTY_RAM(
    // CC: read/write
    .cc_addr(cc_dirty_ram_addr),
    .cc_rw(cc_dirty_ram_rw),
    .cc_en(cc_dirty_ram_en),
    .cc_bwe(cc_dirty_ram_bwe),
    .cc_din(cc_dirty_ram_din),
    .cc_dout(cc_dirty_ram_dout),
    .cc_ready(cc_dirty_ram_ready),
    // MC: write-only
    .mc_waddr(mc_dirty_ram_waddr),
    .mc_we(mc_dirty_ram_we),
    .mc_bwe(mc_dirty_ram_bwe),
    .mc_din(mc_dirty_ram_din),
    // DA: read/write
    .debug_en(debug_dirty_ram_en),
    .debug_addr,
    .debug_rw,
    .debug_din(debug_wdata[N_WAY-1:0]),
    .debug_bwe(debug_valid_dirty_bit_mask),
    .debug_dout(debug_rdata_dirty),
    .debug_ready(debug_dirty_ram_ready),
    // cfg
    .pwr_down(bank_pwr_down),
    .slp(bank_slp),
    .clk(dirty_ram_clkg),
    .*);
`endif
  // }}}

  //------------------------------------------------------
  // tag_ram
  //------------------------------------------------------
  // {{{
  logic [N_WAY-1:0] cc_tag_ram_rready_pway;
  logic [N_WAY-1:0] cc_tag_ram_re_pway;

  bank_index_t         cc_tag_ram_raddr;
  tag_t [N_WAY-1:0] cc_tag_pway;

  bank_index_t      mc_tag_ram_waddr;
  tag_t             mc_tag;
  logic [N_WAY-1:0] mc_tag_ram_wready_pway,
                    mc_tag_ram_we_pway;
`ifndef NO_L2
  generate
    for(genvar i=0; i<N_WAY; i++) begin: TAG_RAM
      cache_tag_ram INST(
        // CC: read-only
        .cc_raddr(cc_tag_ram_raddr),
        .cc_re(cc_tag_ram_re_pway[i]),
        .cc_tag_out(cc_tag_pway[i]),
        .cc_rready(cc_tag_ram_rready_pway[i]),
        // MC: write-only
        .mc_waddr(mc_tag_ram_waddr),
        .mc_we(mc_tag_ram_we_pway[i]),
        .mc_tag_in(mc_tag[DRAM_TAG_WIDTH-1:0]),
        .mc_wready(mc_tag_ram_wready_pway[i]),
        // DA: read/write
        .debug_en(debug_tag_ram_en_pway[i]),
        .debug_addr,
        .debug_rw,
        .debug_din(debug_wdata[DRAM_TAG_WIDTH-1:0]),
        .debug_dout(debug_rdata_tag_pway[i]),
        .debug_ready(debug_tag_ram_ready_pway[i]),
        // cfg
        .pwr_down(way_pwr_down[i]),
        .slp(way_slp[i]),
        .clk(tag_ram_clkg[i]),
        .*);
    end
  endgenerate // }}}
`endif

`ifdef NO_L2
  // valid ram
  assign cc_valid_ram_dout = {N_WAY{1'b1}};
  assign cc_valid_ram_rready = 1'b1;
  assign debug_rdata_valid = {$bits(cpu_data_t){1'b1}};
  assign debug_valid_ram_ready = 1'b1;
  assign mc_valid_ram_we = '0;
  // dirty ram
  assign cc_dirty_ram_dout = {N_WAY{1'b0}};
  assign cc_dirty_ram_ready = 1'b1;
  assign debug_dirty_ram_ready = 1'b1;
  assign debug_rdata_dirty = {$bits(cpu_data_t){1'b0}};
  assign mc_dirty_ram_we = '0;
  // tag ram
  assign debug_tag_ram_ready_pway = {N_WAY{1'b1}};
  assign cc_tag_ram_rready_pway = {N_WAY{1'b1}};
  assign mc_tag_ram_we_pway = {N_WAY{1'b0}};
  generate
    for (genvar i = 0; i < N_WAY; i++) begin : TAG_RAM_DBG_GEN
      assign debug_rdata_tag_pway[i] = '0;
      assign cc_tag_pway[i] = '0;
    end
  endgenerate
  // lru ram
  assign debug_rdata_lru = '0;
  assign debug_lru_ram_ready = 1'b1;
  assign lru_ram_ready = 1'b1;
`endif

  //------------------------------------------------------
  // data_ram
  //------------------------------------------------------
  // {{{
  logic        [N_WAY-1:0] cc_data_ram_en_pway;
  logic                    cc_data_ram_rw;
  bank_index_t             cc_data_ram_bank_index;
  cpu_data_t               cc_data_ram_din;
  cpu_byte_mask_t          cc_data_ram_byte_mask;

  logic        [N_WAY-1:0] cc_data_ram_ready_pway;
  cpu_data_t   [N_WAY-1:0] cc_data_ram_dout_pway;

  logic        [N_WAY-1:0] mc_data_ram_en_pway;
  logic        [N_WAY-1:0] mc_data_ram_rw_pway;
  bank_index_t [N_WAY-1:0] mc_data_ram_bank_index_pway;
  cpu_data_t   [N_WAY-1:0] mc_data_ram_din_pway;

  cpu_data_t   [N_WAY-1:0] mc_data_ram_dout_pway;
  logic        [N_WAY-1:0] mc_data_ram_ready_pway;

  logic        [N_WAY-1:0] debug_data_ram_ready_pway;

  generate
    for(genvar i=0; i<N_WAY; i++) begin : DATA_RAM
      cache_data_ram INST(
        // CC: read/write
        .cc_en(cc_data_ram_en_pway[i]),
        .cc_rw(cc_data_ram_rw),
        .cc_bank_index(cc_data_ram_bank_index),
        .cc_din(cc_data_ram_din),
        .cc_byte_mask(cc_data_ram_byte_mask),
        .cc_ready(cc_data_ram_ready_pway[i]),
        .cc_dout(cc_data_ram_dout_pway[i]),
        // MC: read/write
        .mc_en(mc_data_ram_en_pway[i]),
        .mc_rw(mc_data_ram_rw_pway[i]),
        .mc_bank_index(mc_data_ram_bank_index_pway[i]),
        .mc_din(mc_data_ram_din_pway[i]),
        .mc_ready(mc_data_ram_ready_pway[i]),
        .mc_dout(mc_data_ram_dout_pway[i]),
        // DA: read/write
        .debug_en(debug_data_ram_en_pway[i]),
        .debug_addr,
        .debug_rw,
        .debug_din(debug_wdata),
        .debug_byte_mask(debug_wdata_byte_mask),
        .debug_dout(debug_rdata_data_pway[i]),
        .debug_ready(debug_data_ram_ready_pway[i]),
        // common
        .pwr_down(way_pwr_down[i]),
        .slp(way_slp[i]),
          .clk(data_ram_clkg[i]),
        .*);
    end
  endgenerate 

  // }}}
  //------------------------------------------------------
  // lru_ram
  //------------------------------------------------------
  // dual port LRU ram (accessed with tag) {{{
  lru_t          lru_ram_din  , lru_ram_dout;
  bank_index_t lru_ram_raddr, lru_ram_waddr;
`ifdef NO_L2
  assign lru_ram_dout = '0;
`endif
`ifndef NO_L2
  cache_lru_ram LRU_RAM(
    .raddr(lru_ram_raddr),
    .waddr(lru_ram_waddr),
    .re(lru_ram_re),
    .we(lru_ram_we),
    .ready(lru_ram_ready),
    .lru_din(lru_ram_din),
    .lru_dout(lru_ram_dout),
    .debug_en(debug_lru_ram_en),
    .debug_addr,
    .debug_rw,
    .debug_din(debug_wdata[LRU_WIDTH-1:0]),
    .debug_dout(debug_rdata_lru),
    .debug_ready(debug_lru_ram_ready),
    .pwr_down(bank_pwr_down),
    .rstn(s2b_rstn),
    .slp(bank_slp),
    .clk(lru_ram_clkg),
    .*);
`endif
  // }}}

// icg instances
 icg vld_ram_icg_u(
  .clk(clk),
  .clkg(vld_ram_clkg),
  .en(vld_ram_icg_en),
  .tst_en(tst_en)
 );

 icg lru_ram_icg_u(
  .clk(clk),
  .clkg(lru_ram_clkg),
  .en(lru_ram_icg_en),
  .tst_en(tst_en)
 );

 icg dirty_ram_icg_u(
  .clk(clk),
  .clkg(dirty_ram_clkg),
  .en(dirty_ram_icg_en),
  .tst_en(tst_en)
 );

  generate
    for(genvar i=0; i<N_WAY; i++) begin : DATA_RAM_ICG
      icg tag_ram_icg_u(
       .clk(clk),
       .clkg(tag_ram_clkg[i]),
       .en(tag_ram_icg_en[i]),
       .tst_en(tst_en)
      );

      icg data_ram_icg_u(
       .clk(clk),
       .clkg(data_ram_clkg[i]),
       .en(data_ram_icg_en[i]),
       .tst_en(tst_en)
      );
    end
  endgenerate

  assign vld_ram_icg_en = rff_vld_ram_icg_en | cc_valid_ram_re | mc_valid_ram_we | debug_valid_ram_en | s1_valid_ff | s2b_icg_disable | ~cache_is_idle;
  assign lru_ram_icg_en = rff_lru_ram_icg_en | lru_ram_re | lru_ram_we | debug_lru_ram_en | s2_valid_ff | s2b_icg_disable | ~cache_is_idle; 
  assign dirty_ram_icg_en = rff_dirty_ram_icg_en | cc_dirty_ram_en | mc_dirty_ram_we | debug_dirty_ram_en | s3_valid_ff | s2b_icg_disable | ~cache_is_idle; 

  always_comb begin
    for (int i = 0; i < N_WAY; i++) begin
      tag_ram_icg_en[i] = rff_tag_ram_icg_en[i] | cc_tag_ram_re_pway[i] | mc_tag_ram_we_pway[i] | debug_tag_ram_en_pway[i] | s2_valid_ff | s2b_icg_disable | ~cache_is_idle;
      data_ram_icg_en[i] = rff_data_ram_icg_en[i] | cc_data_ram_en_pway[i] | mc_data_ram_en_pway[i] | debug_data_ram_en_pway[i] | s3_valid_ff | s2b_icg_disable | ~cache_is_idle;
    end
  end

  always_ff @ (posedge clk) begin
    if (~s2b_rstn) begin
      rff_vld_ram_icg_en   <= 1'b1;
      rff_lru_ram_icg_en   <= 1'b1;
      rff_dirty_ram_icg_en <= 1'b1;
      for (int i = 0; i < N_WAY; i++) begin
        rff_tag_ram_icg_en[i]  <= 1'b1;
        rff_data_ram_icg_en[i] <= 1'b1;
      end
    end else begin
      rff_vld_ram_icg_en   <= cc_valid_ram_re | mc_valid_ram_we | debug_valid_ram_en | s1_valid_ff | s2b_icg_disable | ~cache_is_idle;
      rff_lru_ram_icg_en   <= lru_ram_re | lru_ram_we | debug_lru_ram_en | s2_valid_ff | s2b_icg_disable | ~cache_is_idle;
      rff_dirty_ram_icg_en <= cc_dirty_ram_en | mc_dirty_ram_we | debug_dirty_ram_en | s3_valid_ff | s2b_icg_disable | ~cache_is_idle;
      for (int i = 0; i < N_WAY; i++) begin
        rff_tag_ram_icg_en[i]  <= cc_tag_ram_re_pway[i] | mc_tag_ram_we_pway[i] | debug_tag_ram_en_pway[i] | s2_valid_ff | s2b_icg_disable | ~cache_is_idle;
        rff_data_ram_icg_en[i] <= cc_data_ram_en_pway[i] | mc_data_ram_en_pway[i] | debug_data_ram_en_pway[i] | s3_valid_ff | s2b_icg_disable | ~cache_is_idle;
      end
    end
  end


  // }}}
`ifndef SYNTHESIS
  chk_vld_redundant_read: assert property (@(posedge clk) disable iff (~s2b_rstn) cc_valid_ram_re |-> (cpu_req_valid | l2_amo_store_req_valid))
    else `olog_warning("L2_BANK", $sformatf("%m: L2 Bank %d sees redundant read on valid ram", BANK_ID));

  chk_lru_redundant_read: assert property (@(posedge clk) disable iff (~s2b_rstn) lru_ram_re |-> s1_valid_ff)
    else `olog_warning("L2_BANK", $sformatf("%m: L2 Bank %d sees redundant read on lru ram", BANK_ID));

generate
    for (genvar i=0; i<N_WAY; i++) begin
      chk_lru_redundant_read: assert property (@(posedge clk) disable iff (~s2b_rstn) cc_tag_ram_re_pway[i] |-> s1_valid_ff & nxt.s2.way_valid[i])
        else `olog_warning("L2_BANK", $sformatf("%m: L2 Bank %d sees redundant read on tag ram", BANK_ID));
 
     chk_data_redundant_read: assert property (@(posedge clk) disable iff (~s2b_rstn) cc_data_ram_en_pway[i] |-> s2_valid_ff)
        else `olog_warning("L2_BANK", $sformatf("%m: L2 Bank %d sees redundant read on data ram", BANK_ID));

    end
endgenerate
`endif

  //==========================================================
  // pipeline
  // {{{

  //------------------------------------------------------
  // pipeline flow control
  //------------------------------------------------------
  // {{{
  logic   s1_ready, s2_ready, s3_ready, s4_ready;
  logic   s1_stall, s2_stall, s3_stall;

  logic   [N_MSHR-1:0] s2_mshr_hit_same_index_for_cache_req, 
                         s2_mshr_hit_same_index_for_flush_req;
  logic   s2_pre_req_hit_same_index_for_cache_req,
          s2_pre_req_hit_same_index_for_flush_req;
  logic   [N_MSHR-1:0] s1_mshr_hit_same_index_for_cache_req,
                         s1_mshr_hit_same_index_for_flush_req;
  logic   s1_pre_req_hit_same_index_for_cache_req,
          s1_pre_req_hit_same_index_for_flush_req;
  mshr_t  mshr_mc_resp, mshr_mc_resp_ff, mshr_mc_resp_d2_ff;
  logic                      new_mshr_valid_ff;
  logic                      new_mshr_replace_way_valid_ff;
  logic                      new_mshr_dirty_forward_ff;
  logic  [WAY_ID_WIDTH-1:0]  new_mshr_replace_way_id_ff;

  // MSHR signals
  mshr_t [N_MSHR-1:0]        mshr_bank;
  mshr_t                     new_mshr;
  mshr_sel_t                 new_mshr_sel;
  mshr_id_t                  new_mshr_id;
  logic                      mshr_dirty_in;

  // mshr read response data path
  cpu_resp_t                 mshr_resp;
  logic                      mshr_resp_valid;
  logic                      cc_read_hit_backpressure;
  logic                      wait_for_lru_ram;
  logic [N_WAY-1:0]          wait_for_tag_ram;
  logic [N_WAY-1:0]            way_tag_hit;
  logic [N_MSHR-1:0]            mshr_hit;
  logic                        has_free_mshr;
  way_id_t                     replace_way_id;
  lru_t                        old_lru;
  logic                        s3_done, mshr_we;
  logic                        s3_mshr_mc_resp_hit;
  cpu_resp_t                   cpu_resp_saved_ff, s4_cpu_resp;
  logic                        cpu_resp_saved_valid;
  logic                         pre_s3_stall;

  // idle indication 
  assign cache_is_idle = ~(cpu_l2_req_if_req_valid | s1_valid_ff        | s2_valid_ff        | s3_valid_ff |
                           mshr_bank[0].valid      | mshr_bank[1].valid | mshr_bank[2].valid | mshr_bank[3].valid); 

  //------------------------------------------------------
  // LR/SC 
  //------------------------------------------------------
  struct packed {
    logic                          valid;
    logic [CPU_PORT_ID_WIDTH-1:0] cpu_port_id;
    paddr_t                          paddr;
  } cur_resv_entry, nxt_resv_entry;
  logic resv_vld_en, new_lr_valid, invalidate;
  logic sc_succeed, sc_fail;

  always_ff @ (posedge clk) begin
    if (~s2b_rstn) 
      cur_resv_entry.valid <= 1'b0;
    else if (resv_vld_en) 
      cur_resv_entry.valid <= nxt_resv_entry.valid;
  end

  always_ff @ (posedge clk) begin
    if (new_lr_valid) begin 
      cur_resv_entry.cpu_port_id <= nxt_resv_entry.cpu_port_id;
      cur_resv_entry.paddr          <= nxt_resv_entry.paddr;
    end
  end
  //assign resv_vld_en                = new_lr_valid | sc_succeed | invalidate;
  assign resv_vld_en                = new_lr_valid | sc_succeed;
  //assign invalidate                 = cur_resv_entry.valid & s1_valid & ((cpu_req.req_type == REQ_READ) | (cpu_req.req_type == REQ_WRITE)) &
  //                                     (cpu_req.paddr[$bits(cache_paddr_t)-1:4] == cur_resv_entry.paddr[$bits(cache_paddr_t)-1:4]);
  assign invalidate                 = cur_resv_entry.valid & s1_valid & (cpu_req.req_type == REQ_WRITE) &
                                     (cpu_req.paddr[$bits(cache_paddr_t)-1:4] == cur_resv_entry.paddr[$bits(cache_paddr_t)-1:4]);  
  assign nxt_resv_entry.valid       = new_lr_valid & ~sc_succeed & ~invalidate;
  assign new_lr_valid                = s1_valid & s2_ready & (cpu_req.req_type == REQ_LR);
  assign nxt_resv_entry.cpu_port_id = cpu_req.tid.cpu_noc_id;
  assign nxt_resv_entry.paddr        = cpu_req.paddr;   
  assign sc_succeed                    = cur_resv_entry.valid & s1_valid & s2_ready & (cpu_req.req_type == REQ_SC) & 
                                     (cpu_req.tid.cpu_noc_id == cur_resv_entry.cpu_port_id) &
                                     (cpu_req.paddr      == cur_resv_entry.paddr);
  assign sc_fail                    = ~cur_resv_entry.valid & s1_valid & s2_ready & (cpu_req.req_type == REQ_SC) | 
                                       cur_resv_entry.valid & s1_valid & s2_ready & (cpu_req.req_type == REQ_SC) & 
                                    ~((cpu_req.tid.cpu_noc_id == cur_resv_entry.cpu_port_id) &
                                      (cpu_req.paddr          == cur_resv_entry.paddr));
    
  //------------------------------------------------------
  // Atomic/barrier handling 
  // 1. set lock bit 
  // 2. backpressure any request from CPU-NOC 
  // 3. lock req in s1 stage 
  // 4. wait until no outstanding request in the pipeline and then let atomic/barrier request go through pipeline  
  // 5. wait until atomic/barrier insrcution is complete and then clear lock bit 
  //------------------------------------------------------
  logic lock, unlock;
  logic rffce_no_outstanding_req;
  logic nxt_no_outstanding_req;

  struct packed {
    logic           lock_is_active;
    cpu_tid_t          tid;
    cpu_req_type_t    req_type;
  } cur_lock_fsm, nxt_lock_fsm;

  always_ff @ (posedge clk) begin
    if (~s2b_rstn) begin
      cur_lock_fsm.lock_is_active         <= 1'b0;
      cur_lock_fsm.tid                      <= {(CPU_PORT_ID_WIDTH+8){1'b0}};
      cur_lock_fsm.req_type              <= REQ_AMO_LR;
    end
    else if (~cur_lock_fsm.lock_is_active & lock | cur_lock_fsm.lock_is_active & unlock) begin 
      cur_lock_fsm <= nxt_lock_fsm; 
    end
  end

  always_ff @ (posedge clk) begin
    if(~s2b_rstn)
      rffce_no_outstanding_req <= 1'b0;
    else 
      rffce_no_outstanding_req <= nxt_no_outstanding_req;
  end
  assign nxt_no_outstanding_req      = ~(s2_valid_ff        | s3_valid_ff        |  
                                            mshr_bank[0].valid | mshr_bank[1].valid | 
                                            mshr_bank[2].valid | mshr_bank[3].valid);

  // treat lr/sc/amo as program order
  assign lock                          = s1_valid & s1_ready & ((cpu_req.req_type == REQ_AMO_LR)       | 
                                                              (cpu_req.req_type == REQ_BARRIER_SYNC));
  // unlock cases
  // 1. amo_store is received
  // 2. pipeline has been drain for barrier instr 
  assign unlock                      = l2_amo_store_req_valid & l2_amo_store_req_ready | 
                                       cpu_resp_valid & cpu_resp_ready & (cpu_resp.tid == cur_lock_fsm.tid) & (cur_lock_fsm.req_type == REQ_BARRIER_SYNC); 
  assign nxt_lock_fsm.lock_is_active = ~(cur_lock_fsm.lock_is_active & unlock);
  assign nxt_lock_fsm.tid                 = lock ? cpu_req.tid : cur_lock_fsm.tid;
  assign nxt_lock_fsm.req_type          = lock ? cpu_req.req_type : cur_lock_fsm.req_type;
  //------------------------------------------------------
  // Ready => pipe is able to accept new data
  // Valid => a valid data coming
  // Stall => hazard occurs
  //------------------------------------------------------
  always_ff @ (posedge clk) begin
    if (~s2b_rstn) begin
      s1_valid_ff <= '0;
      s2_valid_ff <= '0;
      s3_valid_ff <= '0;
    end else begin
      if (s2_ready) s1_valid_ff <= s1_valid;
      if (s3_ready) s2_valid_ff <= s2_valid; // when new_mshr is created, need to clear s2_valid_ff
      if (s4_ready) s3_valid_ff <= s3_valid;
    end
  end

  // Primary output to cpu
  assign cpu_req_ready = s1_ready;
  // stage 1 
  assign s1_ready = (s2_ready | ~cpu_req_valid) & cc_valid_ram_rready & ~s1_stall & ~cur_lock_fsm.lock_is_active; 
  assign s1_valid = cpu_req_valid & cc_valid_ram_rready & ~s1_stall & ~cur_lock_fsm.lock_is_active | 
                    l2_amo_store_req_valid & l2_amo_store_req_ready;
  // stall when cpu req(cache, vld, and flush) hit previous req amoung s1, s2, dff_mshr_mc_resp, and mshr_bank[] stages.
  // stall when mshr_mc_resp hit: corner case (mshr_mc_resp_hit in S1, but evicted while in S2, incorrect hit in S3)
  always_comb begin
    s1_stall = cpu_req_valid & mshr_mc_resp_ff.valid & (nxt.s1.cpu_req.req_type != REQ_BARRIER_SYNC) &
               (cpu_req.paddr.bank_index == mshr_mc_resp_ff.bank_index) & 
               (cpu_req.paddr.tag          == mshr_mc_resp_ff.new_tag)        |
               (|s1_mshr_hit_same_index_for_cache_req)                         | 
               (|s1_mshr_hit_same_index_for_flush_req)                        |                          
                s1_pre_req_hit_same_index_for_cache_req                     | 
                s1_pre_req_hit_same_index_for_flush_req;
  end
  // stage 2
  //assign s2_ready = (s3_ready | ~s1_valid_ff) & ~s2_stall & ~(cur_lock_fsm.lock_is_active & cur_lock_fsm.rel);     // (3) lock req in s1
  assign s2_ready = (s3_ready | ~s1_valid_ff) & ~s2_stall;     
  //assign s2_valid = s1_valid_ff & ~s2_stall & ~(cur_lock_fsm.lock_is_active & cur_lock_fsm.rel);                // (4) release access
  assign s2_valid = s1_valid_ff & ~s2_stall;                
  // stall 1. hit the same line (same bank_index) with previous req or an existing MSHR
  //       2. has forwarded lru  
  //       3. tag ram is being updated by mshr 
  assign s2_stall = s2_pre_req_hit_same_index_for_cache_req | (|s2_mshr_hit_same_index_for_cache_req) | 
                    s2_pre_req_hit_same_index_for_flush_req | (|s2_mshr_hit_same_index_for_flush_req) | 
                    wait_for_lru_ram                        | (|wait_for_tag_ram)                     |
                    cur_lock_fsm.lock_is_active & ~rffce_no_outstanding_req & ~unlock;
  assign s3_ready = (s4_ready | ~s2_valid_ff | s3_done | new_mshr.valid) & ~s3_stall;
  // store condition will initiate a response  
  assign s3_valid = s2_valid_ff & ~s3_done & ~s3_stall | s2_valid_ff & ~s3_stall & (cur.s2.sc_succeed | cur.s2.sc_fail);
  // write hit will be done in s3, no more work in s4
  assign s3_done  = ~s3_stall & nxt.s3.hit & ((cur.s2.cpu_req.req_type == REQ_WRITE)  | 
                                                (cur.s2.cpu_req.req_type == REQ_AMO_SC) |
                                              (cur.s2.cpu_req.req_type == REQ_SC) & cur.s2.sc_succeed);
  assign pre_s3_stall = (|mshr_hit) | cc_read_hit_backpressure & (cur.s2.cpu_req.req_type != REQ_WRITE)  & (cur.s2.cpu_req.req_type != REQ_AMO_SC) |
                        ~s4_ready & (cur.s2.cpu_req.req_type == REQ_SC);
  //----------------s3 hacard check--------------------------------
  // 1. hit under miss   
  // 2. CPU noc network is not ready (e.g. push dram response over the NOC), mshr_resp is coming, and this req is not done in s3
  // 3. hit 
  //    -treat flush address as a write miss 
  //    -write or flush hit: need to access dirty ram except for read hit
  //    -read or write hit: need to access data ram
  // 4. miss
  //    -always read the dirty bit under miss and update when updating the tag
  //     -no free mshr under miss

  assign s3_stall = pre_s3_stall                                                        | 
                                   // treat flush address as a write miss, if hit
    ~pre_s3_stall & nxt.s3.hit & (((cur.s2.cpu_req.req_type == REQ_FLUSH_ADDR) | (cur.s2.cpu_req.req_type == REQ_FLUSH_ADDR)) & 
                                   (has_free_mshr & ~s4_ready & s2_valid_ff | ~has_free_mshr & s2_valid_ff)                                    | 
                                    // write or flush hit: need to access dirty ram except for read hit
                                   (cur.s2.cpu_req.req_type != REQ_READ)   & ~cc_dirty_ram_ready & 
                                  (cur.s2.cpu_req.req_type != REQ_AMO_LR) & (cur.s2.cpu_req.req_type != REQ_LR)    | 
                                     // read or write hit: need to access data ram
                                      (cur.s2.cpu_req.req_type != REQ_FLUSH_ADDR) & (cur.s2.cpu_req.req_type != REQ_FLUSH_IDX) & ~cc_data_ram_ready_pway[nxt.s3.way_id])    |
    ~pre_s3_stall & ~nxt.s3.hit & (~cc_dirty_ram_ready | 
                                   (cur.s2.cpu_req.req_type != REQ_FLUSH_ADDR) & (cur.s2.cpu_req.req_type != REQ_FLUSH_IDX) & 
                                  ~(has_free_mshr & cc_dirty_ram_ready) & s2_valid_ff);

  // primary input from cpu
  assign s4_ready = cpu_resp_ready; 

  // }}}
  //------------------------------------------------------
  // pipeline register
  // {{{
  struct packed {
    struct packed {
      cpu_req_t           cpu_req;
      logic                  sc_succeed;
      logic                  sc_fail;
      logic                  no_write_alloc;
    } s1;

    struct packed {
      cpu_req_t           cpu_req;
      logic                  sc_succeed;
      logic                  sc_fail;
      logic [N_WAY-1:0]   way_valid;       // cache line valid bit per way
      logic               is_lru_forward; // get LRU from forwarding path
      logic                  no_write_alloc;
      // forward mshr_mc_resp
      logic               mshr_mc_resp_hit;
      way_id_t            mshr_mc_resp_way_id;
    } s2;

    struct packed {
      logic                sc_succeed;
      logic                sc_fail;
      logic             hit;     // cache hit
      logic             no_write_alloc;
      logic             is_dirty_forward;
      logic             replace_way_valid;
      cpu_byte_mask_t   byte_mask;
      tid_t             tid;     // transaction id to the cpu side
      way_id_t          way_id; // hit way ID
      lru_t             new_lru;
      cpu_req_type_t    req_type;
    } s3;
  } nxt, cur;

  always_ff @ (posedge clk) begin
    if (~s2b_rstn) begin
      cur.s1.cpu_req.paddr    <= '0;
      cur.s1.cpu_req.req_type <= REQ_READ;
      cur.s1.no_write_alloc   <= '0;
      cur.s2.is_lru_forward   <= '0;
      cur.s2.no_write_alloc   <= '0;
      cur.s2.way_valid        <= '0;
      cur.s2.cpu_req.paddr    <= '0;
      cur.s2.cpu_req.req_type <= REQ_READ;
      cur.s2.mshr_mc_resp_hit <= '0;
      cur.s3.hit               <= '0;
      cur.s3.req_type          <= REQ_READ;
      cur.s3.no_write_alloc   <= '0;
      cur.s3.replace_way_valid<= '0;
      cur.s3.is_dirty_forward <= '0;
      cur.s3.new_lru          <= '0;
      cpu_resp_saved_valid    <= '0;
      cpu_resp_saved_ff          <= '0;
    end else begin
      if (s1_valid & s2_ready) cur.s1 <= nxt.s1;
      if (s2_valid & s3_ready) cur.s2 <= nxt.s2;
      if (s3_valid & s4_ready) cur.s3 <= nxt.s3;
      mshr_mc_resp_ff <= mshr_mc_resp;
      mshr_mc_resp_d2_ff <= mshr_mc_resp_ff;

      new_mshr_valid_ff <= new_mshr.valid;
      if (new_mshr.valid) begin
        new_mshr_replace_way_id_ff <= nxt.s3.way_id;
        new_mshr_replace_way_valid_ff <= nxt.s3.replace_way_valid;
        new_mshr_dirty_forward_ff <= nxt.s3.is_dirty_forward;
      end

      if (cpu_resp_valid) begin
        cpu_resp_saved_valid <= ~cpu_resp_ready;
        if (~cpu_resp_ready & ~cpu_resp_saved_valid) begin
          cpu_resp_saved_ff <= s4_cpu_resp;
        end
      end
    end
  end
  // }}}
  //------------------------------------------------------
  // stage 1: read valid ram
  //------------------------------------------------------
  // {{{
  assign nxt.s1.sc_succeed                  = sc_succeed;
  assign nxt.s1.sc_fail                        = sc_fail;
  assign nxt.s1.cpu_req.paddr               = cpu_req.paddr;
  assign nxt.s1.cpu_req.byte_mask           = cpu_req.byte_mask;
  assign nxt.s1.cpu_req.data               = cpu_req.data;
  assign nxt.s1.cpu_req.tid               = cpu_req.tid;
  assign nxt.s1.cpu_req.req_type           = cpu_req.req_type;
  assign nxt.s1.no_write_alloc = 1'b0;

  //-------hit the same line (same bank_index) with an existing MSHR--------
  always_comb begin
    for (int i=0; i<N_MSHR; i++) begin
      s1_mshr_hit_same_index_for_cache_req[i] = cpu_req_valid & mshr_bank[i].valid & 
                                                (mshr_bank[i].bank_index == nxt.s1.cpu_req.paddr.bank_index);
    end
  end


  always_comb begin
    for (int i=0; i<N_MSHR; i++) begin
        s1_mshr_hit_same_index_for_flush_req[i] = cpu_req_valid      & ((nxt.s1.cpu_req.req_type == REQ_FLUSH_ADDR) |
                                                  (nxt.s1.cpu_req.req_type == REQ_FLUSH_IDX))                         & 
                                                  mshr_bank[i].valid & (mshr_bank[i].bank_index == nxt.s1.cpu_req.paddr.bank_index);  
    end
  end
  // hit the same line (same bank_index) with previous req
  assign s1_pre_req_hit_same_index_for_cache_req = cpu_req_valid & 
                        (s1_valid_ff & (nxt.s1.cpu_req.paddr.bank_index == cur.s1.cpu_req.paddr.bank_index) | 
                         s2_valid_ff & (nxt.s1.cpu_req.paddr.bank_index == cur.s2.cpu_req.paddr.bank_index));

 
  assign s1_pre_req_hit_same_index_for_flush_req = ((nxt.s1.cpu_req.req_type == REQ_FLUSH_ADDR) | (nxt.s1.cpu_req.req_type == REQ_FLUSH_IDX))
                                                     & cpu_req_valid & 
                                                   (s1_valid_ff & (nxt.s1.cpu_req.paddr.bank_index == cur.s1.cpu_req.paddr.bank_index) |
                                                    s2_valid_ff & (nxt.s1.cpu_req.paddr.bank_index == cur.s2.cpu_req.paddr.bank_index));


  // }}}
  //------------------------------------------------------
  // stage 2: read tag/lru ram
  //------------------------------------------------------
  // {{{
  assign nxt.s2.cpu_req         = cur.s1.cpu_req;
  assign nxt.s2.no_write_alloc     = cur.s1.no_write_alloc;
  assign nxt.s2.sc_succeed        = cur.s1.sc_succeed;
  assign nxt.s2.sc_fail            = cur.s1.sc_fail;

  // read from valid_ram or from response data
  always_comb begin
   for (int i=0; i<N_WAY; i++) begin
    nxt.s2.way_valid[i] = cc_valid_ram_dout[i] & ~((cur.s1.cpu_req.req_type == REQ_BARRIER_SYNC) | (cur.s1.cpu_req.req_type == REQ_BARRIER_SET)) | 
                        mshr_mc_resp_ff.valid & (cur.s1.cpu_req.paddr.bank_index == mshr_mc_resp_ff.bank_index) & 
                       (mshr_mc_resp_ff.way_id == WAY_ID_WIDTH'(i));
   end
 end
  // the bank index of s1 match with that of s2 at which lrs is about to be updated  
  assign nxt.s2.is_lru_forward = (nxt.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB] == cur.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB]) & lru_ram_we;
  // MSHR response hit: cpu req at s1 matches with mshr resp  
  assign nxt.s2.mshr_mc_resp_hit = s1_valid_ff                   & mshr_mc_resp_ff.valid           & 
                                (cur.s1.cpu_req.paddr.bank_index == mshr_mc_resp_ff.bank_index) & 
                                (cur.s1.cpu_req.paddr.tag        == mshr_mc_resp_ff.new_tag);
  assign nxt.s2.mshr_mc_resp_way_id = mshr_mc_resp_ff.way_id;

  //----hit the same line (same bank_index) with an existing MSHR----
  always_comb begin
    for (int i=0; i<N_MSHR; i++) begin
        s2_mshr_hit_same_index_for_cache_req[i] = s1_valid_ff & mshr_bank[i].valid & 
                                                  (mshr_bank[i].bank_index == nxt.s2.cpu_req.paddr.bank_index);
    end
  end

  always_comb begin
    for (int i=0; i<N_MSHR; i++) begin
          s2_mshr_hit_same_index_for_flush_req[i] = ((nxt.s2.cpu_req.req_type == REQ_FLUSH_ADDR) | (nxt.s2.cpu_req.req_type == REQ_FLUSH_IDX)) 
                                                   & s1_valid_ff & mshr_bank[i].valid & 
                                                  (mshr_bank[i].bank_index == nxt.s2.cpu_req.paddr.bank_index);
      end
  end
  // hit the same line (same bank_index) with previous req
  assign s2_pre_req_hit_same_index_for_cache_req = s1_valid_ff              &  s2_valid_ff     &  
                                                 (nxt.s2.cpu_req.paddr.bank_index == cur.s2.cpu_req.paddr.bank_index);

  assign s2_pre_req_hit_same_index_for_flush_req = ((nxt.s2.cpu_req.req_type == REQ_FLUSH_ADDR) | (nxt.s2.cpu_req.req_type == REQ_FLUSH_IDX)) 
                                                    & s1_valid_ff & s2_valid_ff & 
                                                   (nxt.s2.cpu_req.paddr.bank_index == cur.s2.cpu_req.paddr.bank_index);

  // check structure hazard on tag ram, stall S2 if required tag ram is not ready
  always_comb begin
    for (int i = 0; i < N_WAY; i++) begin: loop_tag_ram_re
      wait_for_tag_ram[i] = (cc_tag_ram_re_pway[i] & ~cc_tag_ram_rready_pway[i]);
    end
  end
  // }}}
  //------------------------------------------------------
  // stage 3: tag hit/write to mshr/read data ram/write lru 
  //------------------------------------------------------
  // {{{
  assign nxt.s3.sc_succeed       = cur.s2.sc_succeed;
  assign nxt.s3.sc_fail           = cur.s2.sc_fail;
  assign nxt.s3.no_write_alloc = cur.s2.no_write_alloc;
  assign nxt.s3.tid            = cur.s2.cpu_req.tid;
  assign nxt.s3.req_type       = cur.s2.cpu_req.req_type;
  assign nxt.s3.byte_mask      = cur.s2.cpu_req.byte_mask;
  // forwarding dirty & tag from mshr_mc_resp_ff when hiting the same line same way
  assign nxt.s3.is_dirty_forward = s2_valid_ff                     &  mshr_mc_resp_ff.valid        & 
                               (cur.s2.cpu_req.paddr.bank_index == mshr_mc_resp_ff.bank_index) & 
                               (nxt.s3.way_id == mshr_mc_resp_ff.way_id);
  assign nxt.s3.replace_way_valid = cur.s2.way_valid[replace_way_id] | nxt.s3.is_dirty_forward;

  //----------------Tag Hit-------------------------------
  // tag hit for flush index or tag match (tag hit must have one hit at most)
`ifdef NO_L2
  assign way_tag_hit = {N_WAY{1'b1}};
`else
  always_comb begin
    for (int i=0; i<N_WAY; i++) begin: loop_way_tag_hit
      way_tag_hit[i] = way_pwr_on[i] & (cur.s2.cpu_req.req_type == REQ_FLUSH_IDX) ?
                        (cur.s2.way_valid[i] & (cur.s2.cpu_req.paddr[WAY_ID_MSB:WAY_ID_LSB] == (WAY_ID_WIDTH)'(i))) :
                        (cur.s2.way_valid[i] & (cc_tag_pway[i] == cur.s2.cpu_req.paddr[TAG_MSB:TAG_LSB])); 
    end
  end
`endif
  //----------------Final Hit-------------------------------
  logic [N_WAY-1:0] cache_hit_pway;
  logic s2_non_flush_req_hit_mshr_mc_resp;
  logic s1_non_flush_req_hit_mshr_mc_resp;
 
  // case 1. way_tag_hit  
  // case 2. s2 non-flush req matches with mshr in current cycle 
  // case 3. s2 non-flush req matches with mshr in previous cycle
`ifdef NO_L2
  assign nxt.s3.hit = 1'b1;
`else
  assign nxt.s3.hit =  (|cache_hit_pway)                                          |
                       s2_non_flush_req_hit_mshr_mc_resp                          |    
                       s1_non_flush_req_hit_mshr_mc_resp;    
`endif
  always_comb begin
     for (int i=0; i<N_WAY; i++)
        cache_hit_pway[i] = cur.s2.way_valid[i] & way_tag_hit[i] |
                            cur.s2.way_valid[i] & way_tag_hit[i] & (cur.s2.cpu_req.req_type == REQ_FLUSH_IDX);
  end

  assign s2_non_flush_req_hit_mshr_mc_resp = s3_mshr_mc_resp_hit & ~(cur.s2.cpu_req.req_type == REQ_FLUSH_IDX);
  assign s1_non_flush_req_hit_mshr_mc_resp = cur.s2.mshr_mc_resp_hit & ~(cur.s2.cpu_req.req_type == REQ_FLUSH_IDX);
  assign s3_mshr_mc_resp_hit = s2_valid_ff                        &  mshr_mc_resp_ff.valid         & 
                              (cur.s2.cpu_req.paddr.bank_index == mshr_mc_resp_ff.bank_index) & 
                              (cur.s2.cpu_req.paddr.tag        == mshr_mc_resp_ff.new_tag);

  //----------------Final way_id selection for read/write data ram and update dirty ram------------
  way_id_t cache_hit_way_id;
  logic is_flush_index;
  assign is_flush_index = (cur.s2.cpu_req.req_type == REQ_FLUSH_IDX);

  always_comb begin
    nxt.s3.way_id =  ~nxt.s3.hit                        ? replace_way_id                                 :
                      s1_non_flush_req_hit_mshr_mc_resp ? cur.s2.mshr_mc_resp_way_id                     :
                      s2_non_flush_req_hit_mshr_mc_resp ? mshr_mc_resp_ff.way_id                          :
                      is_flush_index    ? cur.s2.cpu_req.paddr[WAY_ID_MSB:WAY_ID_LSB]   :    
                      cache_hit_way_id; 
  end

`ifdef NO_L2
  assign cache_hit_way_id = cur.s2.cpu_req.paddr[WAY_ID_MSB:WAY_ID_LSB];
`else    
  always_comb begin
    cache_hit_way_id = '0;
    for (int i=0; i<N_WAY; i++) begin: loop_cache_hit
      if (way_tag_hit[i]) begin
        cache_hit_way_id = i;
      end
    end
  end
`endif

  //----------------Get replacement way id and update LRU bits---------
  logic flush_index;
  assign old_lru = (cur.s2.is_lru_forward) ? cur.s3.new_lru : lru_ram_dout;
  assign flush_index = (cur.s2.cpu_req.req_type == REQ_FLUSH_IDX);
  // find a way to be evicted based on current lru and way_valid or 
  // calculate the new lru based on the evicted way_id
  assign nxt.s3.new_lru   = flush_index ? old_lru : update_lru_bits(old_lru, replace_way_id);
  assign replace_way_id = flush_index ? cur.s2.cpu_req.paddr[WAY_ID_MSB:WAY_ID_LSB] : get_replace_way_id(old_lru, cur.s2.way_valid, way_pwr_on);

  //----------------s3 hazard check--------------------------------
  // check all MSHR entries
  always_comb begin
    for (int i = 0; i < N_MSHR; i++) begin
      mshr_hit[i] = is_mshr_hit(mshr_bank[i], cur.s2.cpu_req.paddr, nxt.s3.way_id, nxt.s3.hit) & s2_valid_ff;
    end
  end
  // allocate MSHR in case of miss, used in case of miss
  always_comb begin
    has_free_mshr = alloc_free_mshr(mshr_bank, ((cur.s2.cpu_req.req_type == REQ_READ) | (cur.s2.cpu_req.req_type == REQ_AMO_LR) | (cur.s2.cpu_req.req_type == REQ_LR)), new_mshr_sel, new_mshr_id);
  end
 
  //----------------Write to mshr-------------------------
  // treat flush address as a write miss, if hit 
  always_comb begin
        mshr_we = ~s3_stall                             & nxt.s3.hit              & (cur.s2.cpu_req.req_type != REQ_BARRIER_SYNC) &
              ((cur.s2.cpu_req.req_type == REQ_FLUSH_ADDR) | (cur.s2.cpu_req.req_type == REQ_FLUSH_IDX)) & has_free_mshr     &
                   s4_ready & cc_dirty_ram_ready & s2_valid_ff                     | 
                 ~s3_stall & ~nxt.s3.hit & (cur.s2.cpu_req.req_type != REQ_FLUSH_ADDR) & 
                (cur.s2.cpu_req.req_type != REQ_FLUSH_IDX) & (cur.s2.cpu_req.req_type != REQ_BARRIER_SYNC) &
                ~((cur.s2.cpu_req.req_type == REQ_SC) & cur.s2.sc_fail) & has_free_mshr & cc_dirty_ram_ready & s2_valid_ff;
  end
  assign new_mshr.valid          = mshr_we ;
  assign new_mshr.tid              = cur.s2.cpu_req.tid;
  assign new_mshr.rw              = (cur.s2.cpu_req.req_type != REQ_READ) & (cur.s2.cpu_req.req_type != REQ_AMO_LR) & (cur.s2.cpu_req.req_type != REQ_LR);
  assign new_mshr.flush          = (cur.s2.cpu_req.req_type == REQ_FLUSH_ADDR) | (cur.s2.cpu_req.req_type == REQ_FLUSH_IDX);
  assign new_mshr.no_write_alloc = cur.s2.no_write_alloc;
  assign new_mshr.way_id          = replace_way_id;
  assign new_mshr.bank_index      = cur.s2.cpu_req.paddr.bank_index;
  assign new_mshr.data              = cur.s2.cpu_req.data;
  assign new_mshr.byte_mask      = cur.s2.cpu_req.byte_mask;
  // load address to memory (new address for both read and write misses)
  assign new_mshr.new_tag          = cur.s2.cpu_req.paddr.tag; 
  // write back address (i.e. old address from tag ram)
  assign new_mshr.old_tag         = nxt.s3.is_dirty_forward ? mshr_mc_resp_ff.new_tag : cc_tag_pway[replace_way_id];
  // 1. if a clean line then it's not dirty. 
  // 2. forwarding dirty bit
  assign mshr_dirty_in = new_mshr_valid_ff & cc_dirty_ram_dout[new_mshr_replace_way_id_ff] & new_mshr_replace_way_valid_ff |
                           new_mshr_valid_ff & new_mshr_dirty_forward_ff;
  // }}}
  //------------------------------------------------------
  // stage 4: response data to CPU NOC 
  //------------------------------------------------------
  // {{{
  assign cpu_resp_valid = mshr_resp_valid                                         |  // read miss repsonse
                          s3_valid_ff & (cur.s3.sc_fail | cur.s3.sc_succeed)     |  // store condition resp
                          s3_valid_ff & (cur.s3.req_type == REQ_BARRIER_SYNC)   |  // memory barrier resp 
                         (cur.s3.hit & s3_valid_ff)                             |  // flush/read/write hit
                         ~cur.s3.hit & s3_valid_ff & ((cur.s3.req_type == REQ_FLUSH_ADDR) | (cur.s3.req_type == REQ_FLUSH_IDX)); // flush miss
  assign cpu_resp = cpu_resp_saved_valid ? cpu_resp_saved_ff : s4_cpu_resp;

  always_comb begin
    s4_cpu_resp.tid       = mshr_resp_valid   ? mshr_resp.tid                             : cur.s3.tid;
    s4_cpu_resp.byte_mask = mshr_resp_valid   ? mshr_resp.byte_mask                     : cur.s3.byte_mask;
    s4_cpu_resp.data      = mshr_resp_valid   ? mshr_resp.data                             : 
                            cur.s3.sc_fail    ? {{(CACHE_LINE_BYTE*8-1){1'b0}},1'b1} : 
                            cur.s3.sc_succeed ? '0 : cc_data_ram_dout_pway[cur.s3.way_id];
  end

  // }}}
  // }}}
  //==========================================================
  // RAM interface
  // {{{
  //------------------------------------------------------
  // Prepare to read VALID_RAM (stage-1)
  //------------------------------------------------------
  // {{{
  assign cc_valid_ram_raddr = cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];
  assign cc_valid_ram_re    = (cpu_req_valid | l2_amo_store_req_valid) & s2_ready;
  // }}}
  //------------------------------------------------------
  // Prepare to read TAG_RAM (stage-2)
  //------------------------------------------------------
  // {{{
  assign cc_tag_ram_raddr = nxt.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];
  // check structure hazard on tag ram, stall S2 if required tag ram is not ready
  always_comb begin
    for (int i = 0; i < N_WAY; i++) begin: loop_tag_ram_re
           // only read tags from valid way
           cc_tag_ram_re_pway[i] = way_pwr_on[i] & nxt.s2.way_valid[i] & s1_valid_ff & s3_ready;
    end
  end
  // }}}
  //------------------------------------------------------
  // Prepare to read/write data ram (stage-3)
  //------------------------------------------------------
  // {{{
  assign cc_data_ram_rw         = (cur.s2.cpu_req.req_type == REQ_WRITE)  | 
                                  (cur.s2.cpu_req.req_type == REQ_AMO_SC) |
                                  (cur.s2.cpu_req.req_type == REQ_SC) & cur.s2.sc_succeed;
  assign cc_data_ram_bank_index = cur.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];
  assign cc_data_ram_din         = cur.s2.cpu_req.data;
  assign cc_data_ram_byte_mask  = cur.s2.cpu_req.byte_mask;
  always_comb begin
    for (int i=0; i<N_WAY; i++)
           cc_data_ram_en_pway[i] = ~s3_stall & nxt.s3.hit & 
                                  (cur.s2.cpu_req.req_type != REQ_BARRIER_SYNC) &
                                  (cur.s2.cpu_req.req_type != REQ_FLUSH_ADDR)   & 
                                  (cur.s2.cpu_req.req_type != REQ_FLUSH_IDX)    & 
                                   cc_data_ram_ready_pway[i] &
                                  (nxt.s3.way_id == WAY_ID_WIDTH'(i)) & s2_valid_ff & (s4_ready | s3_done);
  end
  // }}}
  //------------------------------------------------------
  // Prepare to write dirty ram (no structure hazard) (stage-3)
  //------------------------------------------------------
  // {{{
  assign cc_dirty_ram_addr = cur.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];
  assign cc_dirty_ram_rw   = cc_data_ram_rw & (|cc_data_ram_en_pway) & (cur.s2.cpu_req.req_type != REQ_FLUSH_ADDR) & (cur.s2.cpu_req.req_type != REQ_FLUSH_IDX);
  assign cc_dirty_ram_en   = new_mshr.valid | (|cc_data_ram_en_pway);
  assign cc_dirty_ram_din  = 1'b1; // write dirty
  always_comb begin
    for (int i=0; i<N_WAY; i++)
          cc_dirty_ram_bwe[i] = nxt.s3.way_id == WAY_ID_WIDTH'(i);
  end
  // }}}
  //------------------------------------------------------
  // Prepare to read LRU_RAM (stage-2)
  //------------------------------------------------------
  // {{{
  assign lru_ram_raddr         = nxt.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];
  assign lru_ram_re         = s1_valid_ff & ~nxt.s2.is_lru_forward;
  assign wait_for_lru_ram     = ~lru_ram_ready & lru_ram_re;
  // }}}
  //------------------------------------------------------
  // LRU ram updates (no structure hazard) (stage-3)
  //------------------------------------------------------
  // {{{
  assign lru_ram_waddr = cur.s2.cpu_req.paddr[BANK_INDEX_MSB:BANK_INDEX_LSB];;
  assign lru_ram_we    = s2_valid_ff & ~s3_stall & s4_ready;
  assign lru_ram_din   = nxt.s3.new_lru;
  // }}}
  // }}}

`ifndef SYNTHESIS
  generate
    for (genvar i=0; i<5; i++) begin: gen_gap_p
      // timing gap
      property cpu_req_gap_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            cpu_req_valid ##i cpu_req_valid;
      endproperty
      cover property (cpu_req_gap_p);

      property new_mshr_to_cpu_req_gap_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            new_mshr.valid ##i cpu_req_valid;
      endproperty
      cover property (new_mshr_to_cpu_req_gap_p);

      property new_mshr_to_new_mshr_gap_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            new_mshr.valid ##i new_mshr.valid;
      endproperty
      cover property (new_mshr_to_new_mshr_gap_p);

      property mshr_resp_to_cpu_req_gap_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            mshr_resp_valid ##i cpu_req_valid;
      endproperty
      cover property (mshr_resp_to_cpu_req_gap_p);

      property mshr_hit_to_cpu_req_gap_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            mshr_hit ##i cpu_req_valid;
      endproperty
      cover property (mshr_hit_to_cpu_req_gap_p);

      for (genvar j=0; j<4; j++) begin
        cover property (@(posedge clk) disable iff (~s2b_rstn !== '0) mshr_bank[j].valid ##i cpu_req_valid);
        for (genvar k=0; k<4; k++) begin
          if (k != j) begin
            cover property (@(posedge clk) disable iff (~s2b_rstn !== '0) ((mshr_bank[j].valid & mshr_bank[k].valid) ##i cpu_req_valid));
          end
        end
      end
      cover property (@(posedge clk) disable iff (~s2b_rstn !== '0) ((mshr_bank[0].valid & mshr_bank[1].valid & mshr_bank[2].valid & mshr_bank[3].valid) ##i cpu_req_valid));

      property hit_under_hit_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            (nxt.s3.hit & s3_valid) ##i (nxt.s3.hit & s3_valid);
      endproperty
      cover property (hit_under_hit_p);

      property hit_under_miss_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            (~nxt.s3.hit & s3_valid) ##i (nxt.s3.hit & s3_valid);
      endproperty
      cover property (hit_under_miss_p);

      property miss_under_hit_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            (nxt.s3.hit & s3_valid) ##i (~nxt.s3.hit & s3_valid);
      endproperty
      cover property (miss_under_hit_p);

      property miss_under_miss_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            (~nxt.s3.hit & s3_valid) ##i (~nxt.s3.hit & s3_valid);
      endproperty
      cover property (miss_under_miss_p);

      // on the same way
      property goto_same_way_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            (s3_valid & (({replace_way_id, s3_valid}) == $past({replace_way_id, s3_valid}, i+1)));
      endproperty
      cover property (goto_same_way_p);

      // on the same bank_index
      property goto_same_bank_index_p;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
          (new_mshr.bank_index & new_mshr.valid) |-> $past(new_mshr.bank_index & new_mshr.valid, i+1);
      endproperty
      cover property (goto_same_bank_index_p);

      property mshr_mc_resp_forwarding_s2;
        @(posedge clk)
          disable iff (~s2b_rstn !== '0)
            (cur.s2.mshr_mc_resp_hit) |-> $past(cur.s2.mshr_mc_resp_hit, i+1);
      endproperty
      cover property (mshr_mc_resp_forwarding_s2);

    end
  endgenerate
  
`endif

  // }}}

  //==========================================================
  // MSHR
  //==========================================================
  // {{{
`ifdef NO_L2
  assign mshr_bank = '0;
  assign mshr_mc_resp = '0;
  // data ram (memory will only load and modify the whole cache line)
  assign mc_data_ram_en_pway = '0;
  assign mc_data_ram_rw_pway = '0;
  assign mc_data_ram_bank_index_pway = '0;
  assign mc_data_ram_din_pway = '0;
  // CPU NOC
  assign mshr_resp_valid = 1'b0;
  assign mshr_resp = '0;
  assign cc_read_hit_backpressure = 1'b0;
  // AXI
  assign l2_req_if_awvalid = 1'b0; 
  assign l2_req_if_wvalid  = 1'b0; 
  assign l2_resp_if_bready = 1'b0; 
  assign l2_req_if_arvalid = 1'b0; 
  assign l2_resp_if_rready = 1'b0; 
`endif

`ifndef NO_L2
  cache_mshr #(.BANK_ID(BANK_ID)) MSHR(
    // mshr req
    .new_mshr(new_mshr),
    .new_mshr_id(new_mshr_id),
    .dirty(mshr_dirty_in), // one cycle late from mshr_in (pipeline delay)
    .mshr_bank(mshr_bank),
    .mshr_resp(mshr_mc_resp),
    // valid ram interface
    .valid_ram_we(mc_valid_ram_we),
    .valid_ram_waddr(mc_valid_ram_waddr),
    .valid_ram_din(mc_valid_ram_din),
    .valid_ram_bwe(mc_valid_ram_bwe),
    // dirty ram interface
    .dirty_ram_we(mc_dirty_ram_we),
    .dirty_ram_waddr(mc_dirty_ram_waddr),
    .dirty_ram_din(mc_dirty_ram_din),
    .dirty_ram_bwe(mc_dirty_ram_bwe),
    // tag ram interface
    .tag_ram_wready_pway(mc_tag_ram_wready_pway),
    .tag_ram_we_pway(mc_tag_ram_we_pway),
    .tag_ram_waddr(mc_tag_ram_waddr),
    .tag_ram_din(mc_tag),

    .data_ram_ready_pway(mc_data_ram_ready_pway),
    .data_ram_dout_pway(mc_data_ram_dout_pway),
    .data_ram_din_pway(mc_data_ram_din_pway),
    .data_ram_en_pway(mc_data_ram_en_pway),
    .data_ram_rw_pway(mc_data_ram_rw_pway),
    .data_ram_bank_index_pway(mc_data_ram_bank_index_pway),
    // output CPU NOC network response path
    .cpu_resp_ready,
    .cpu_resp(mshr_resp),
    .cpu_resp_valid(mshr_resp_valid),
    .cache_read_hit_backpressure(cc_read_hit_backpressure),
    .*);
`endif
  // }}}

  //==========================================================
  // performance counter
  //==========================================================
  //#define STATION_CACHE_DBG_HPM_OFFSET 0x000a0000
  //#define STATION_CACHE_DBG_HPM_ADDR_0 0x00aa0000
  //#define STATION_CACHE_DBG_HPM_ADDR_1 0x00ba0000
  //#define STATION_CACHE_DBG_HPM_ADDR_2 0x00ca0000
  //#define STATION_CACHE_DBG_HPM_ADDR_3 0x00da0000
  //addr | name
  //'d1  | hpmcounter_s1_stall 
  //'d2  | hpmcounter_s2_stall 
  //'d3  | hpmcounter_s3_stall 
  //'d4  | hpmcounter_s4_stall 
  //'d5  | hpmcounter_cache_read_hit[0] 
  //'d6  | hpmcounter_cache_read_miss[0]
  //'d7  | hpmcounter_cache_write_hit[0]
  //'d8  | hpmcounter_cache_write_miss[0]
  //'d9  | hpmcounter_cache_read_hit[1]  
  //'d10 | hpmcounter_cache_read_miss[1] 
  //'d11 | hpmcounter_cache_write_hit[1] 
  //'d12 | hpmcounter_cache_write_miss[1]
  //'d13 | hpmcounter_cache_read_hit[2]  
  //'d14 | hpmcounter_cache_read_miss[2] 
  //'d15 | hpmcounter_cache_write_hit[2] 
  //'d16 | hpmcounter_cache_write_miss[2]
  //'d17 | hpmcounter_cache_read_hit[3]  
  //'d18 | hpmcounter_cache_read_miss[3] 
  //'d19 | hpmcounter_cache_write_hit[3] 
  //'d20 | hpmcounter_cache_write_miss[3]
  //'d21 | hpmcounter_s1_bank_conflict_for_cache_req_stall    
  //'d23 | hpmcounter_s1_bank_conflict_for_flush_req_stall    
  //'d24 | hpmcounter_s2_bank_conflict_for_cache_req_stall 
  //'d26 | hpmcounter_s2_bank_conflict_for_flush_req_stall    
  //'d27 | hpmcounter_s2_lru_ram_not_ready_stall              
  //'d28 | hpmcounter_s2_tag_ram_not_ready_stall                  
  //'d29 | hpmcounter_s3_no_mshr_entry_stall              
  //'d30 | hpmcounter_s3_dirty_ram_not_ready_stall 
  //'d31 | hpmcounter_s3_bank_index_conflict_stall 
  //'d32 | hpmcounter_s3_cc_data_ram_not_ready_stall
  //'d34 | cur_lock_fsm.lock_is_active
  //'d35 | hpmcounter_mshr_valid
  // {{{
  logic [47:0]            hpmcounter_s1_stall,
                          hpmcounter_s1_bank_conflict_for_cache_req_stall,     
                          hpmcounter_s1_bank_conflict_for_flush_req_stall,    
                          hpmcounter_s2_stall,
                          hpmcounter_s2_bank_conflict_for_cache_req_stall,    
                          hpmcounter_s2_bank_conflict_for_flush_req_stall,    
                          hpmcounter_s2_lru_ram_not_ready_stall,
                          hpmcounter_s2_tag_ram_not_ready_stall,    
                          hpmcounter_s3_stall,
                          hpmcounter_s3_no_mshr_entry_stall,
                          hpmcounter_s3_dirty_ram_not_ready_stall,
                          hpmcounter_s3_bank_index_conflict_stall,
                          hpmcounter_s3_cc_data_ram_not_ready_stall,
                          hpmcounter_s4_stall,
                          hpmcounter_mshr_valid;

  logic [47:0]            hpmcounter_cache_read_hit   [3:0];
  logic [47:0]            hpmcounter_cache_read_miss  [3:0];
  logic [47:0]            hpmcounter_cache_write_hit  [3:0];
  logic [47:0]            hpmcounter_cache_write_miss [3:0];


  logic [$clog2(N_MSHR)-1:0]  mshr_util;
  always_comb begin
    mshr_util = 0;
    for (int i=0; i<N_MSHR; i++)
      if (mshr_bank[i].valid)
        mshr_util++;
  end

  always_ff @ (posedge clk) begin
    if (~s2b_rstn) begin
      hpmcounter_s1_stall <= '0;
      hpmcounter_s1_bank_conflict_for_cache_req_stall <= '0;
      hpmcounter_s1_bank_conflict_for_flush_req_stall <= '0;    
      hpmcounter_s2_stall <= '0;
      hpmcounter_s2_bank_conflict_for_cache_req_stall <= '0;
      hpmcounter_s2_bank_conflict_for_flush_req_stall <= '0;    
      hpmcounter_s2_lru_ram_not_ready_stall <= '0;    
      hpmcounter_s2_tag_ram_not_ready_stall <= '0;        
      hpmcounter_s3_stall <= '0;
      hpmcounter_s3_no_mshr_entry_stall <= '0;
      hpmcounter_s3_dirty_ram_not_ready_stall <= '0;
      hpmcounter_s3_bank_index_conflict_stall <= '0;
      hpmcounter_s3_cc_data_ram_not_ready_stall <= '0;
      hpmcounter_s4_stall <= '0;
      hpmcounter_mshr_valid <= '0;
      for (int i=0; i<N_BANK; i++) begin
        hpmcounter_cache_read_hit[i] <= '0;
        hpmcounter_cache_read_miss[i] <= '0;
        hpmcounter_cache_write_hit[i] <= '0;
        hpmcounter_cache_write_miss[i] <= '0;
      end
    end else if (debug_en & debug_rw) begin
      if (debug_addr == 'd1)
        hpmcounter_s1_stall <= '0;
      if (debug_addr == 'd2)
        hpmcounter_s2_stall <= '0;
      if (debug_addr == 'd3)
        hpmcounter_s3_stall <= '0;
      if (debug_addr == 'd4)
        hpmcounter_s4_stall <= '0;
      if (debug_addr == 'd5)
        hpmcounter_cache_read_hit[0] <= '0;
      if (debug_addr == 'd6)
        hpmcounter_cache_read_miss[0] <= '0;
      if (debug_addr == 'd7)
        hpmcounter_cache_write_hit[0] <= '0;
      if (debug_addr == 'd8)
        hpmcounter_cache_write_miss[0] <= '0;
      if (debug_addr == 'd9)
        hpmcounter_cache_read_hit[1] <= '0;
      if (debug_addr == 'd10)
        hpmcounter_cache_read_miss[1] <= '0;
      if (debug_addr == 'd11)
        hpmcounter_cache_write_hit[1] <= '0;
      if (debug_addr == 'd12)
        hpmcounter_cache_write_miss[1] <= '0;
      if (debug_addr == 'd13)
        hpmcounter_cache_read_hit[2] <= '0;
      if (debug_addr == 'd14)
        hpmcounter_cache_read_miss[2] <= '0;
      if (debug_addr == 'd15)
        hpmcounter_cache_write_hit[2] <= '0;
      if (debug_addr == 'd16)
        hpmcounter_cache_write_miss[2] <= '0;
      if (debug_addr == 'd17)
        hpmcounter_cache_read_hit[3] <= '0;
      if (debug_addr == 'd18)
        hpmcounter_cache_read_miss[3] <= '0;
      if (debug_addr == 'd19)
        hpmcounter_cache_write_hit[3] <= '0;
      if (debug_addr == 'd20)
        hpmcounter_cache_write_miss[3] <= '0;
      if (debug_addr == 'd21)
        hpmcounter_s1_bank_conflict_for_cache_req_stall <= '0;
      if (debug_addr == 'd23)
        hpmcounter_s1_bank_conflict_for_flush_req_stall <= '0;    
      if (debug_addr == 'd24)
        hpmcounter_s2_bank_conflict_for_cache_req_stall <= '0;
      if (debug_addr == 'd26)
        hpmcounter_s2_bank_conflict_for_flush_req_stall <= '0;    
      if (debug_addr == 'd27)
        hpmcounter_s2_lru_ram_not_ready_stall <= '0;    
      if (debug_addr == 'd28)
        hpmcounter_s2_tag_ram_not_ready_stall <= '0;        
      if (debug_addr == 'd29)
        hpmcounter_s3_no_mshr_entry_stall <= '0;
      if (debug_addr == 'd30)
        hpmcounter_s3_dirty_ram_not_ready_stall <= '0;
      if (debug_addr == 'd31)
        hpmcounter_s3_bank_index_conflict_stall <= '0;
      if (debug_addr == 'd32)
        hpmcounter_s3_cc_data_ram_not_ready_stall <= '0;
      if (debug_addr == 'd35)
        hpmcounter_mshr_valid <= '0;
     end else if (ctrl_reg.pwr.en_hpmcounter) begin
      if (cpu_req_valid & ~s1_ready)
        hpmcounter_s1_stall <= hpmcounter_s1_stall + 1;
      if (s1_stall & (s1_pre_req_hit_same_index_for_cache_req | (|s1_mshr_hit_same_index_for_cache_req)))
        hpmcounter_s1_bank_conflict_for_cache_req_stall <= hpmcounter_s1_bank_conflict_for_cache_req_stall + 1;
      if (s1_stall & (s1_pre_req_hit_same_index_for_flush_req | (|s1_mshr_hit_same_index_for_flush_req)))    
          hpmcounter_s1_bank_conflict_for_flush_req_stall <= hpmcounter_s1_bank_conflict_for_flush_req_stall + 1;
      if (s1_valid & ~s2_ready)
        hpmcounter_s2_stall <= hpmcounter_s2_stall + 1;
      if (s2_stall & (s2_pre_req_hit_same_index_for_cache_req | (|s2_mshr_hit_same_index_for_cache_req)))
        hpmcounter_s2_bank_conflict_for_cache_req_stall <= hpmcounter_s2_bank_conflict_for_cache_req_stall + 1;
      if (s2_stall & (s2_pre_req_hit_same_index_for_flush_req | (|s2_mshr_hit_same_index_for_flush_req)))    
          hpmcounter_s2_bank_conflict_for_flush_req_stall <= hpmcounter_s2_bank_conflict_for_flush_req_stall + 1;
      if (s2_stall & wait_for_lru_ram)    
          hpmcounter_s2_lru_ram_not_ready_stall <= hpmcounter_s2_lru_ram_not_ready_stall + 1;    
       if (s2_stall & |wait_for_tag_ram)
          hpmcounter_s2_tag_ram_not_ready_stall <= hpmcounter_s2_tag_ram_not_ready_stall + 1;    
      if (s2_valid & ~s3_ready)
        hpmcounter_s3_stall <= hpmcounter_s3_stall + 1;
      if (s3_stall & ~has_free_mshr) 
          hpmcounter_s3_no_mshr_entry_stall <= hpmcounter_s3_no_mshr_entry_stall + 1;
       if (s3_stall & ~cc_dirty_ram_ready) 
          hpmcounter_s3_dirty_ram_not_ready_stall <= hpmcounter_s3_dirty_ram_not_ready_stall + 1;
      if (s3_stall & (|mshr_hit))
          hpmcounter_s3_bank_index_conflict_stall <= hpmcounter_s3_bank_index_conflict_stall + 1;
      if (s3_stall & ~cc_data_ram_ready_pway[nxt.s3.way_id])
          hpmcounter_s3_cc_data_ram_not_ready_stall <= hpmcounter_s3_cc_data_ram_not_ready_stall + 1;
      if (s3_valid & ~s4_ready)
        hpmcounter_s4_stall <= hpmcounter_s4_stall + 1;
      if (s3_valid & s4_ready) begin
        if ((cur.s2.cpu_req.req_type == REQ_READ) | (cur.s2.cpu_req.req_type != REQ_AMO_LR) | (cur.s2.cpu_req.req_type != REQ_LR))
          for (int i=0; i<N_BANK; i++) begin
             if (cur.s2.cpu_req.tid.cpu_noc_id == 3'(i+1)) begin
              if (nxt.s3.hit)
                  hpmcounter_cache_read_hit[i] <= hpmcounter_cache_read_hit[i] + 1;
              else
                hpmcounter_cache_read_miss[i] <= hpmcounter_cache_read_miss[i] + 1;
            end
          end
      end
      if (((cur.s2.cpu_req.req_type == REQ_WRITE) | (cur.s2.cpu_req.req_type == REQ_AMO_SC) | (cur.s2.cpu_req.req_type == REQ_SC) & cur.s2.sc_succeed)) begin
        for (int i=0; i<N_BANK; i++) begin
          if (cur.s2.cpu_req.tid.cpu_noc_id == 3'(i+1)) begin 
            if (nxt.s3.hit & s2_valid_ff)
              hpmcounter_cache_write_hit[i] <= hpmcounter_cache_write_hit[i] + 1;
            if (mshr_we)
              hpmcounter_cache_write_miss[i] <= hpmcounter_cache_write_miss[i] + 1;
          end
        end
      end
      hpmcounter_mshr_valid <= hpmcounter_mshr_valid + mshr_util;
    end
  end // }}}

  //==========================================================
  // debug access
  // {{{
  logic                   debug_valid_ram_en_ff,
                          debug_dirty_ram_en_ff,
                          debug_lru_ram_en_ff,
                          debug_hpmcounter_en_ff;
  logic [N_WAY-1:0]       debug_tag_ram_en_pway_ff,
                          debug_data_ram_en_pway_ff;
  always_ff @ (posedge clk) begin
    if (~s2b_rstn) begin
      debug_valid_ram_en_ff <= '0;
      debug_dirty_ram_en_ff <= '0;
      debug_lru_ram_en_ff <= '0;
      debug_tag_ram_en_pway_ff <= '0;
      debug_data_ram_en_pway_ff <= '0;
      debug_hpmcounter_en_ff <= '0;
    end else if (debug_en) begin
      debug_valid_ram_en_ff <= debug_valid_ram_en;
      debug_dirty_ram_en_ff <= debug_dirty_ram_en;
      debug_lru_ram_en_ff <= debug_lru_ram_en;
      debug_tag_ram_en_pway_ff <= debug_tag_ram_en_pway;
      debug_data_ram_en_pway_ff <= debug_data_ram_en_pway;
      debug_hpmcounter_en_ff <= debug_hpmcounter_en;
    end
  end
  always_comb begin
    debug_ready = debug_valid_ram_ready & debug_dirty_ram_ready & debug_lru_ram_ready &
                 (&debug_tag_ram_ready_pway) & (&debug_data_ram_ready_pway);
    debug_rdata = debug_rdata_valid;
    if (debug_hpmcounter_en_ff) begin
      case (debug_addr)
        'd1: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s1_stall};
        end
        'd2: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s2_stall};
        end
        'd3: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s3_stall};
        end
        'd4: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s4_stall};
        end
        'd5: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_hit[0]};
        end
        'd6: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_miss[0]};
        end
        'd7: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_hit[0]};
        end
        'd8: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_miss[0]};
        end
        'd9: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_hit[1]};
        end
        'd10: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_miss[1]};
        end
        'd11: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_hit[1]};
        end
        'd12: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_miss[1]};
        end
        'd13: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_hit[2]};
        end
        'd14: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_miss[2]};
        end
        'd15: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_hit[2]};
        end
        'd16: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_miss[3]};
        end
        'd17: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_hit[3]};
        end
        'd18: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_read_miss[3]};
        end
        'd19: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_hit[3]};
        end
        'd20: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_cache_write_miss[3]};
        end
        'd21: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s1_bank_conflict_for_cache_req_stall};
        end
        'd23: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s1_bank_conflict_for_flush_req_stall};
        end
        'd24: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s2_bank_conflict_for_cache_req_stall};
        end
        'd26: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s2_bank_conflict_for_flush_req_stall};
        end
        'd27: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s2_lru_ram_not_ready_stall};
        end
        'd28: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s2_tag_ram_not_ready_stall};
        end
        'd29: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s3_no_mshr_entry_stall};
        end
        'd30: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s3_dirty_ram_not_ready_stall};
        end
        'd31: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s3_bank_index_conflict_stall};
        end
        'd32: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_s3_cc_data_ram_not_ready_stall};
        end
        'd33: begin
        end
        'd34: begin
          debug_rdata = {{(CPU_DATA_WIDTH-1){1'b0}},cur_lock_fsm.lock_is_active};
        end
        default: begin
          debug_rdata = {{(CPU_DATA_WIDTH-48){1'b0}},hpmcounter_mshr_valid};
        end
      endcase
    end
    else if (|debug_data_ram_en_pway_ff) begin
      for (int i=0; i<N_WAY; i++) begin
        if (debug_data_ram_en_pway_ff[i])
            debug_rdata = debug_rdata_data_pway[i];
        end
    end
    else if (|debug_tag_ram_en_pway_ff) begin
      for (int i=0; i<N_WAY; i++) begin
        if (debug_tag_ram_en_pway_ff[i])
              debug_rdata = debug_rdata_tag_pway[i];
          end
    end
    else if (debug_lru_ram_en_ff) begin
          debug_rdata = debug_rdata_lru;
    end
    else if (debug_dirty_ram_en_ff) begin
          debug_rdata = debug_rdata_dirty;
    end
    else begin
          debug_rdata = debug_rdata_valid;
    end
  end // }}}


endmodule

