// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef ORV64_WITH_PERFECT_MODEL__SV
`define ORV64_WITH_PERFECT_MODEL__SV

module orv64_with_perfect_model
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
`ifdef VCS
    input int                         report_fd,
`endif
    input                             ext_intr_to_orv64,
    input                             ext_event_to_orv64,
    //------------------------------------------------------
    // configure from/to RB
    input   orv64_vaddr_t             cfg_orv64_rst_pc,
    input                             cfg_orv64_pwr_on,
    input                             cfg_orv64_sleep,
    input   [ 5:0]                    cfg_orv64_lfsr_seed,
    input                             cfg_orv64_bypass_ic,
    input                             cfg_orv64_bypass_tlb,
    input                             cfg_orv64_en_hpmcounter,
    //------------------------------------------------------
    // `ifdef ORV_SUPPORT_OURSBUS
    // // storebuf <-> oursbus
    // output  logic                     dc2ob_req, dc2ob_rwn,
    // output  orv64_paddr_t             dc2ob_addr,
    // output  orv64_data_t              dc2ob_wdata,
    // input   orv64_data_t              ob2dc_rdata,
    // input   logic                     ob2dc_resp,
    // // icache <-> oursbus
    // output  logic                     ic2ob_req, ic2ob_rwn,
    // output  orv64_paddr_t             ic2ob_addr,
    // output  orv64_data_t              ic2ob_wdata,
    // input   logic [5:0]               ic2ob_id,

    // input   orv64_data_t              ob2ic_rdata,
    // input   logic                     ob2ic_resp,
    // `ifdef ORV_SUPPORT_MAGICMEM
    // input   orv64_paddr_t             cfg_magicmem_start_addr,
    //                                   cfg_magicmem_end_addr,
    //                                   cfg_from_host_addr,
    //                                   cfg_to_host_addr,
    // `endif // ORV_SUPPORT_MAGICMEM
    // `endif // ORV_SUPPORT_OURSBUS

    // `ifdef ORV_SUPPORT_DMA
    // input                             dma2mp_ch0_done,
    // input                             dma2mp_ch1_done,
    // input                             dma2mp_ch2_done,
    // input                             dma2mp_ch3_done,
    // `endif

    //------------------------------------------------------
    // Breakpoint
    input   orv64_vaddr_t   s2b_bp_if_pc_0, s2b_bp_if_pc_1, s2b_bp_if_pc_2, s2b_bp_if_pc_3,
    input   logic           s2b_en_bp_if_pc_0, s2b_en_bp_if_pc_1, s2b_en_bp_if_pc_2, s2b_en_bp_if_pc_3,
    input   orv64_vaddr_t   s2b_bp_wb_pc_0, s2b_bp_wb_pc_1, s2b_bp_wb_pc_2, s2b_bp_wb_pc_3,
    input   logic           s2b_en_bp_wb_pc_0, s2b_en_bp_wb_pc_1, s2b_en_bp_wb_pc_2, s2b_en_bp_wb_pc_3,
    input   orv64_data_t    s2b_bp_instret,
    input   logic           s2b_en_bp_instret,

    //------------------------------------------------------
    // trace buffer
    input   orv64_itb_sel_t  s2b_cfg_itb_sel,
    input   logic            s2b_cfg_itb_en,
    input   logic            s2b_cfg_itb_wrap_around,
    output  orv64_itb_addr_t b2s_itb_last_ptr,
    
    //------------------------------------------------------
    // debug
    input                             dbg_orv64_debug_stall,
    input                             dbg_orv64_debug_resume,
    output                            dbg_orv64_debug_stall_out,

    output  orv64_vaddr_t             orv64_rb_if_pc,
    input                             early_rst_to_orv64, // early_rst_to_orv64 is used to release reset on debug_access for initializing L1 cache before releasing main reset
    input                             rst_to_orv64, 
    input                             rstn_to_mm, 
    input                             clk
  );

  logic  [63:0]                     mtimecmp, rff_mtime, mtime;
  logic                             sw_int;
  logic                             timer_int;
  
  logic                             wfi_stall, wfe_stall;

  //! Local Vars for ot_perfect_model
  logic                cc_req_if_req_valid;
  logic                cc_req_if_req_ready;
  cpu_cache_if_req_t   cc_req_if_req;
  logic                cc_resp_if_resp_valid;
  logic                cc_resp_if_resp_ready;
  cpu_cache_if_resp_t  cc_resp_if_resp;
  logic                cpu_amo_store_req_valid; 
  cpu_cache_if_req_t   cpu_amo_store_req;
  logic                cpu_amo_store_req_ready; 

  logic                sysbus_req_if_awvalid;
  logic                sysbus_req_if_wvalid;
  logic                sysbus_req_if_arvalid;
  oursring_req_if_ar_t sysbus_req_if_ar;
  oursring_req_if_aw_t sysbus_req_if_aw;
  oursring_req_if_w_t  sysbus_req_if_w;
  logic                sysbus_req_if_arready;
  logic                sysbus_req_if_wready;
  logic                sysbus_req_if_awready;

  oursring_resp_if_b_t  sysbus_resp_if_b;
  oursring_resp_if_r_t  sysbus_resp_if_r;
  logic                 sysbus_resp_if_rvalid;
  logic                 sysbus_resp_if_rready;
  logic                 sysbus_resp_if_bvalid;
  logic                 sysbus_resp_if_bready;

  logic                  ring_req_if_awvalid;
  logic                  ring_req_if_wvalid;
  logic                  ring_req_if_arvalid;
  oursring_req_if_ar_t   ring_req_if_ar;
  oursring_req_if_aw_t   ring_req_if_aw;
  oursring_req_if_w_t    ring_req_if_w;
  logic                  ring_req_if_arready;
  logic                  ring_req_if_wready;
  logic                  ring_req_if_awready;

  oursring_resp_if_b_t   ring_resp_if_b;
  oursring_resp_if_r_t   ring_resp_if_r;
  logic                  ring_resp_if_rvalid;
  logic                  ring_resp_if_rready;
  logic                  ring_resp_if_bvalid;
  logic                  ring_resp_if_bready;

  logic                  rff_sysbus_brsp_vld, rff_sysbus_rrsp_vld;
  ring_tid_t             rff_bid, rff_rid;

  always_ff @(posedge clk) begin
    if (rst_to_orv64) begin
      rff_sysbus_brsp_vld <= '0;
      rff_bid <= '0;
    end else begin
      if (sysbus_req_if_awvalid & sysbus_req_if_wvalid & sysbus_req_if_awready & sysbus_req_if_wready) begin
        rff_sysbus_brsp_vld <= '1;
        rff_bid <= sysbus_req_if_aw.awid;
      end 
      if (sysbus_resp_if_bvalid & sysbus_resp_if_bready) begin
        rff_sysbus_brsp_vld <= '0;
        rff_bid <= '0;
      end
    end
  end

  ring_addr_t req_addr;
  logic is_mtime, is_mtimecmp, is_upper;
  logic [63:0] rff_rdata;
  logic is_write, is_read;
  assign is_write = (sysbus_req_if_awvalid & sysbus_req_if_awready & sysbus_req_if_awvalid & sysbus_req_if_awready);
  assign is_read = (sysbus_req_if_arvalid & sysbus_req_if_arready);

  always_ff @(posedge clk) begin
    if (rst_to_orv64) begin
      rff_sysbus_rrsp_vld <= '0;
      rff_rid <= '0;
    end else begin
      if (sysbus_req_if_arvalid & sysbus_req_if_arready) begin
        rff_sysbus_rrsp_vld <= '1;
        rff_rid <= sysbus_req_if_ar.arid;
      end 
      if (sysbus_resp_if_rvalid & sysbus_resp_if_rready) begin
        rff_sysbus_rrsp_vld <= '0;
        rff_rid <= '0;
      end
    end
  end

  assign sysbus_req_if_arready = ~rff_sysbus_rrsp_vld;
  assign sysbus_req_if_wready = ~rff_sysbus_brsp_vld;
  assign sysbus_req_if_awready = ~rff_sysbus_brsp_vld;

  always_ff @(posedge clk) begin
    if (rst_to_orv64) begin
      rff_rdata <= '0;
    end else begin
      if (is_read) begin
        if (sysbus_req_if_ar.araddr == 40'h800000) begin
          rff_rdata <= sw_int;
        end else if (sysbus_req_if_ar.araddr == 40'h804000) begin
          rff_rdata <= mtimecmp;
        end else if (sysbus_req_if_ar.araddr == 40'h80bff8) begin
          rff_rdata <= mtime;
        end else if (sysbus_req_if_ar.araddr == 40'h80bffc) begin
          rff_rdata <= {32'h0, mtime[63:32]};
        end else begin
          rff_rdata <= '0;
        end
      end
    end
  end

  assign mtime = rff_mtime;
  //assign mtime = orv64_u.CS.minstret;

  always_ff @(posedge clk) begin
    if (rst_to_orv64) begin
      mtimecmp <= '1;
      rff_mtime <= '0;
    end else begin
      if (is_write & (sysbus_req_if_aw.awaddr == 40'h804000)) begin
        mtimecmp <= sysbus_req_if_w.wdata;
      end
      rff_mtime <= rff_mtime + 64'h1;
    end
  end

  assign timer_int = (unsigned'(mtime) >= unsigned'(mtimecmp));

  always_ff @(posedge clk) begin
    if (rst_to_orv64) begin
      sw_int <= '0;
    end else begin
      if (is_write & (sysbus_req_if_aw.awaddr == 40'h800000)) begin
        sw_int <= sysbus_req_if_w.wdata;
      end
    end
  end

  always_comb begin
    sysbus_resp_if_b = '0;
    sysbus_resp_if_r = '0;
    sysbus_resp_if_b.bid = rff_bid;
    sysbus_resp_if_r.rid = rff_rid;
    sysbus_resp_if_r.rdata = rff_rdata;
  end

  assign sysbus_resp_if_rvalid = rff_sysbus_rrsp_vld;
  assign sysbus_resp_if_bvalid = rff_sysbus_brsp_vld;

  assign ring_req_if_awvalid = '0;
  assign ring_req_if_wvalid = '0;
  assign ring_req_if_arvalid = '0;
  assign ring_resp_if_rready = '0;
  assign ring_resp_if_bready = '0;


  orv64 orv64_u
  (
    .core_id(8'h00),
    .clk(clk),
    .s2b_early_rst(early_rst_to_orv64),
    .s2b_rst(rst_to_orv64),
    .s2b_debug_stall(dbg_orv64_debug_stall),
    .s2b_debug_resume(dbg_orv64_debug_resume),
    .b2s_debug_stall_out(dbg_orv64_debug_stall_out),
    .ext_int(ext_intr_to_orv64),
    .sw_int(sw_int),
    .timer_int(timer_int),
    .s2b_ext_event(ext_event_to_orv64),
    .s2b_cfg_rst_pc(cfg_orv64_rst_pc),
    .s2b_cfg_pwr_on(cfg_orv64_pwr_on),
    .s2b_cfg_sleep(cfg_orv64_sleep),
    .s2b_cfg_lfsr_seed(cfg_orv64_lfsr_seed),
    .s2b_cfg_bypass_ic(cfg_orv64_bypass_ic),
    .s2b_cfg_bypass_tlb(cfg_orv64_bypass_tlb),
    .s2b_cfg_en_hpmcounter(cfg_orv64_en_hpmcounter),
    .b2s_if_pc(orv64_rb_if_pc),
    .l2_req(cc_req_if_req),
    .l2_req_valid(cc_req_if_req_valid),
    .l2_req_ready(cc_req_if_req_ready),
    .l2_resp(cc_resp_if_resp),
    .l2_resp_valid(cc_resp_if_resp_valid),
    .l2_resp_ready(cc_resp_if_resp_ready),
    .cpu_amo_store_req_valid(cpu_amo_store_req_valid), 
    .cpu_amo_store_req(cpu_amo_store_req), 
    .cpu_amo_store_req_ready(cpu_amo_store_req_ready),
    .sysbus_req_if_awvalid,
    .sysbus_req_if_wvalid,
    .sysbus_req_if_arvalid,
    .sysbus_req_if_ar,
    .sysbus_req_if_aw,
    .sysbus_req_if_w,
    .sysbus_req_if_arready,
    .sysbus_req_if_wready,
    .sysbus_req_if_awready,
    .sysbus_resp_if_b,
    .sysbus_resp_if_r,
    .sysbus_resp_if_rvalid,
    .sysbus_resp_if_rready,
    .sysbus_resp_if_bvalid,
    .sysbus_resp_if_bready,
    .ring_req_if_awvalid,
    .ring_req_if_wvalid,
    .ring_req_if_arvalid,
    .ring_req_if_ar,
    .ring_req_if_aw,
    .ring_req_if_w,
    .ring_req_if_arready,
    .ring_req_if_wready,
    .ring_req_if_awready,
    .ring_resp_if_b,
    .ring_resp_if_r,
    .ring_resp_if_rvalid,
    .ring_resp_if_rready,
    .ring_resp_if_bvalid,
    .ring_resp_if_bready,
    .s2b_bp_if_pc_0,
    .s2b_bp_if_pc_1,
    .s2b_bp_if_pc_2,
    .s2b_bp_if_pc_3,
    .s2b_en_bp_if_pc_0,
    .s2b_en_bp_if_pc_1,
    .s2b_en_bp_if_pc_2,
    .s2b_en_bp_if_pc_3,
    .s2b_bp_wb_pc_0,
    .s2b_bp_wb_pc_1,
    .s2b_bp_wb_pc_2,
    .s2b_bp_wb_pc_3,
    .s2b_en_bp_wb_pc_0,
    .s2b_en_bp_wb_pc_1,
    .s2b_en_bp_wb_pc_2,
    .s2b_en_bp_wb_pc_3,
    .s2b_bp_instret,
    .s2b_en_bp_instret,
    .s2b_cfg_itb_sel,
    .s2b_cfg_itb_en,
    .s2b_cfg_itb_wrap_around,
    .b2s_itb_last_ptr,
    .*
  );
          
  ot_perfect_l2_model #( 
      .L2_PORT_CNT(1),
      .REQ_LATENCY(1),
      .RESP_LATENCY(0)
    ) mm_u 
    (
      .clk(clk),
      .rstn(rstn_to_mm),
      .cpu_req_valid(cc_req_if_req_valid),
      .cpu_req_ready(cc_req_if_req_ready),
      .cpu_req(cc_req_if_req),
      .cpu_amo_store_req_valid(cpu_amo_store_req_valid), 
      .cpu_amo_store_req(cpu_amo_store_req), 
      .cpu_amo_store_req_ready(cpu_amo_store_req_ready),
      .cpu_resp_valid(cc_resp_if_resp_valid),
      .cpu_resp_ready(cc_resp_if_resp_ready),
      .cpu_resp(cc_resp_if_resp)
    );
 
  always @(posedge clk)  begin
    if(cc_req_if_req_valid === 1'b1 && cc_req_if_req_ready===1'b1) begin 
      //$display("%t %m CACHE_REQ tid=0x%0h addr=0x%0h",$time,cc_req_if_req.req_tid,cc_req_if_req.req_paddr);
    end
    if(cc_resp_if_resp_valid===1'b1 && cc_resp_if_resp_ready===1'b1) begin
      //$display("%t %m CACHE_RESP tid=%0h data=0x%0h",$time,cc_resp_if_resp.resp_tid,cc_resp_if_resp.resp_data);
    end
  end

endmodule : orv64_with_perfect_model
`endif
