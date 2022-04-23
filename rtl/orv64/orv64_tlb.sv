// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __ORV_TLB__SV__
`define __ORV_TLB__SV__

module orv64_tlb
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import pygmy_intf_typedef::*;
  import pygmy_func::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import orv64_func_pkg::*;
# (
  parameter is_dtlb = 0,
  parameter is_vtlb = 0
)
(
  input   orv64_csr_satp_t            satp,
  input   orv64_prv_t                 prv,
  input   orv64_csr_mstatus_t         mstatus,

  // L1$ i/f
  input   logic                       cc2tlb_req_valid,
  input   orv64_cache_tlb_if_req_t    cc2tlb_req,
  output  logic                       tlb2cc_req_ready,

  output  logic                       tlb2cc_resp_valid,
  output  orv64_cache_tlb_if_resp_t   tlb2cc_resp,
  input                               cc2tlb_resp_ready,

  // ORV i/f
  input   logic                       orv2tlb_flush_req_valid,
  input   orv64_tlb_flush_if_req_t    orv2tlb_flush_req,

  // PTW i/f
  output  logic                       tlb2ptw_req_valid,
  output  orv64_tlb_ptw_if_req_t      tlb2ptw_req,
  input   logic                       ptw2tlb_req_ready,

  input   logic                       ptw2tlb_resp_valid,
  input   orv64_tlb_ptw_if_resp_t     ptw2tlb_resp,
  output  logic                       tlb2ptw_resp_ready,

  output  logic                       tlb_hit, tlb_miss,

  input   logic                 cfg_bypass_tlb,

  // DA
  input   orv64_da2tlb_t        da2tlb,
  output  orv64_tlb2da_t        tlb2da,

  // rstn & clk
  input   logic                 rstn, clk
);

  localparam NUM_TLB_ENTRIES = is_vtlb ? 2: 8;
  localparam TLB_CNTR_WIDTH = $clog2(NUM_TLB_ENTRIES);
  localparam LRU_WIDTH = is_vtlb ? 2: 7;

  enum logic [2:0] {
    ST_READY        = 3'b000,
    ST_TLB_FETCH    = 3'b001,
    ST_TLB_UPDATE   = 3'b010,
    ST_TLB_RET      = 3'b011,
    ST_SFENCE       = 3'b100,
    ST_SFENCE_DONE  = 3'b101,
    ST_EVICT        = 3'b110
  } rff_state, next_state;

  logic              perm_excp_valid, sum_excp_valid, ad_excp_valid, u_excp_valid, exe_excp_valid, access_excp_valid;
  orv64_excp_cause_t excp_cause, access_excp_cause;
  logic              skip_trans;
  logic              is_tlb_hit;

  // TLB memory
  orv64_tlb_entry_t [NUM_TLB_ENTRIES-1:0]   dff_tlb;
  logic             [NUM_TLB_ENTRIES-1:0]   rff_tlb_valid, next_tlb_valid;

  logic                         rff_cc2tlb_req_valid, next_cc2tlb_valid;
  orv64_cache_tlb_if_req_t      dff_cc2tlb_req;
  logic                         tlb2cc_valid_pre;
  logic                         do_save_tlb2cc, do_use_saved_tlb2cc;

  orv64_tlb_flush_if_req_t      dff_sfence_req;
  orv64_tlb_ptw_if_resp_t       dff_ptw2tlb_resp;

  orv64_vpn_t [ORV64_NUM_PAGE_LEVELS-1:0] vpn_masks;
  orv64_vpn_t                             req_vpn;
  orv64_pte_t                   resp_pte;
  orv64_ptw_lvl_t               resp_lvl;

  logic [TLB_CNTR_WIDTH-1:0]  tlb_match_wyid, tlb_replace_wyid;

  logic [LRU_WIDTH-1:0]                 rff_lru, next_lru;

  logic     do_update_tlb;

  orv64_prv_t                effective_prv;

  logic                      rff_is_pending_sfence;

`ifndef SYNTHESIS
  logic [NUM_TLB_ENTRIES-1:0]   tlb_match; // For assertion. Check that no more than one matching way
`endif

  //==========================================================
  // ICG {{{

  logic en_req, en_fence, en_resp;
  logic tlb_clkg, req_clkg, fence_clkg, resp_clkg;

  assign en_req = cc2tlb_req_valid & tlb2cc_req_ready;
  assign en_fence = ~rff_is_pending_sfence & orv2tlb_flush_req_valid;
  assign en_resp = ptw2tlb_resp_valid & tlb2ptw_resp_ready;

  icg tlb_clk_u(
    .en       (do_update_tlb),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (tlb_clkg)
  );

  icg req_clk_u(
    .en       (en_req),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (req_clkg)
  );

  icg fence_clk_u(
    .en       (en_fence),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (fence_clkg)
  );

  icg resp_clk_u(
    .en       (en_resp),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (resp_clkg)
  );

  // }}}

  always_ff @(posedge tlb_clkg) begin
    if (do_update_tlb) begin
      dff_tlb[tlb_replace_wyid].asid <= satp.asid;
      dff_tlb[tlb_replace_wyid].vpn <= req_vpn;
      dff_tlb[tlb_replace_wyid].pte <= ptw2tlb_resp.resp_pte;
      dff_tlb[tlb_replace_wyid].page_lvl <= ptw2tlb_resp.resp_lvl;
    end
  end

  always_ff @(posedge req_clkg) begin
    if (en_req) begin
      dff_cc2tlb_req <= cc2tlb_req;
    end
  end

  always_ff @(posedge fence_clkg) begin
    if (en_fence) begin
      dff_sfence_req <= orv2tlb_flush_req;
    end
  end

  always_ff @(posedge resp_clkg) begin
    if (en_resp) begin
      dff_ptw2tlb_resp <= ptw2tlb_resp;
    end
  end

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_state <= ST_READY;
      rff_lru <= '0;
      rff_tlb_valid <= '0;
      rff_cc2tlb_req_valid <= '0;
    end else begin
      rff_state <= next_state;
      rff_lru <= next_lru;
      rff_tlb_valid <= next_tlb_valid;
      rff_cc2tlb_req_valid <= next_cc2tlb_valid;
    end
  end

  assign effective_prv = ((is_dtlb | is_vtlb) & mstatus.MPRV) ? orv64_prv_t'(mstatus.MPP): prv;
  assign skip_trans = (effective_prv == ORV64_PRV_M) | (satp.mode == ORV64_BARE);

  //==========================================================
  // Next state logic {{{
  always_comb begin
    next_state = rff_state;
    tlb2cc_req_ready = '0;
    case (rff_state)
      ST_READY: begin
        if (rff_cc2tlb_req_valid & ~skip_trans & ~is_tlb_hit) begin // TLB Miss
          next_state = ST_TLB_FETCH;
        end else if (~rff_cc2tlb_req_valid | cc2tlb_resp_ready) begin // No request or hit and immediately accepted
          if (rff_is_pending_sfence) begin
            next_state = ST_SFENCE;
          end else if (cc2tlb_req_valid) begin
            tlb2cc_req_ready = '1;
            next_state = ST_READY;
          end
        end
      end
      ST_TLB_FETCH: begin
        if (ptw2tlb_req_ready) begin
          next_state = ST_TLB_UPDATE;
        end
      end
      ST_TLB_UPDATE: begin
        if (ptw2tlb_resp_valid) begin
          next_state = ST_TLB_RET;
        end
      end
      ST_TLB_RET: begin
        if (cc2tlb_resp_ready) begin
          next_state = ST_READY;
        end
      end
      ST_SFENCE: begin
        next_state = ST_SFENCE_DONE;
      end
      ST_SFENCE_DONE: begin
        next_state = ST_READY;
      end
      default: begin
        next_state = ST_READY;
      end
    endcase
  end

  //==========================================================
  // Saved requests {{{

  always_comb begin
    if (cc2tlb_req_valid & tlb2cc_req_ready) begin
      next_cc2tlb_valid = '1;
    end else if (tlb2cc_resp_valid & cc2tlb_resp_ready) begin
      next_cc2tlb_valid = '0;
    end else begin
      next_cc2tlb_valid = rff_cc2tlb_req_valid;
    end
  end

  always_ff @(posedge clk) begin
    if (~rstn) begin
      rff_is_pending_sfence <= '0;
    end else begin
      if (rff_is_pending_sfence) begin
        rff_is_pending_sfence <= ~(rff_state == ST_SFENCE_DONE);
      end else begin
        rff_is_pending_sfence <= orv2tlb_flush_req_valid;
      end
    end
  end

  // }}}

  //==========================================================
  // TLB memory {{{

  assign do_update_tlb = ptw2tlb_resp_valid & tlb2ptw_resp_ready & ~ptw2tlb_resp.resp_excp_valid;

  always_comb begin
    next_tlb_valid = rff_tlb_valid;
    case (rff_state)
      ST_TLB_UPDATE: begin
        if (do_update_tlb) begin
          next_tlb_valid[tlb_replace_wyid] = 1'b1;
        end
      end
      ST_SFENCE: begin
        for (int i = 0; i < NUM_TLB_ENTRIES; i++) begin 
          case (dff_sfence_req.req_sfence_type)
            ORV64_SFENCE_ALL: begin
              next_tlb_valid[i] = '0;
            end
            ORV64_SFENCE_ASID: begin
              if (dff_tlb[i].asid == dff_sfence_req.req_flush_asid) begin
                next_tlb_valid[i] = '0;
              end
            end
            ORV64_SFENCE_VPN: begin
              if (dff_tlb[i].vpn == dff_sfence_req.req_flush_vpn) begin
                next_tlb_valid[i] = '0;
              end
            end
            ORV64_SFENCE_ASID_VPN: begin
              if ((dff_tlb[i].asid == dff_sfence_req.req_flush_asid) | (dff_tlb[i].vpn == dff_sfence_req.req_flush_vpn)) begin
                next_tlb_valid[i] = '0;
              end
            end
          endcase
        end
      end
    endcase
  end

  // }}}

  //==========================================================
  // PTW signals {{{

  assign tlb2ptw_req_valid = (rff_state == ST_TLB_FETCH);
  assign tlb2ptw_resp_ready = (rff_state == ST_TLB_UPDATE);

  assign tlb2ptw_req.req_vpn = dff_cc2tlb_req.req_vpn;
  assign tlb2ptw_req.req_access_type = dff_cc2tlb_req.req_access_type;

  // }}}

  //==========================================================
  // Hit logic {{{

  generate
    for (genvar i=0; i<ORV64_NUM_PAGE_LEVELS; i++) begin
      always_comb begin
        vpn_masks[i] = '0;
        vpn_masks[i][ORV64_VPN_WIDTH-1:(ORV64_VPN_PART_WIDTH*i)] = '1;
      end
    end
  endgenerate

  assign req_vpn = dff_cc2tlb_req.req_vpn;

  always_comb begin
`ifndef SYNTHESIS
    tlb_match = '0;
`endif
    is_tlb_hit = '0;
    tlb_match_wyid = '0;
    if (~cfg_bypass_tlb) begin
      for (int i=0; i<NUM_TLB_ENTRIES; i++) begin
        if (rff_cc2tlb_req_valid & ((satp.asid == dff_tlb[i].asid) | (dff_tlb[i].pte.global_map)) & rff_tlb_valid[i]) begin
          if ((req_vpn & vpn_masks[dff_tlb[i].page_lvl]) == (dff_tlb[i].vpn & vpn_masks[dff_tlb[i].page_lvl])) begin
`ifndef SYNTHESIS
            tlb_match[i] = 1'b1;
`endif
            is_tlb_hit = '1;
            tlb_match_wyid = TLB_CNTR_WIDTH'(i);
          end
        end
      end
    end else begin
      if (rff_cc2tlb_req_valid & ((satp.asid == dff_tlb[0].asid) | (dff_tlb[0].pte.global_map)) & rff_tlb_valid[0]) begin
        if ((req_vpn & vpn_masks[dff_tlb[0].page_lvl]) == (dff_tlb[0].vpn & vpn_masks[dff_tlb[0].page_lvl])) begin
`ifndef SYNTHESIS
          tlb_match[0] = 1'b1;
`endif
          is_tlb_hit = '1;
          tlb_match_wyid = TLB_CNTR_WIDTH'('0);
        end
      end
    end
  end
  // }}}

  //==========================================================
  // Cache response {{{

  assign resp_pte = (rff_state == ST_TLB_RET) ? dff_ptw2tlb_resp.resp_pte: dff_tlb[tlb_match_wyid].pte;
  assign resp_lvl = (rff_state == ST_TLB_RET) ? dff_ptw2tlb_resp.resp_lvl: dff_tlb[tlb_match_wyid].page_lvl;

  always_comb begin
    if (skip_trans) begin
      tlb2cc_resp.resp_ppn = dff_cc2tlb_req.req_vpn;
    end else begin
      tlb2cc_resp.resp_ppn = resp_pte.ppn;
      for (int i=0; i<resp_lvl; i++) begin // superpage
        tlb2cc_resp.resp_ppn[(ORV64_PPN_PART_WIDTH*i)+:ORV64_PPN_PART_WIDTH] = dff_cc2tlb_req.req_vpn[(ORV64_PPN_PART_WIDTH*i)+:ORV64_PPN_PART_WIDTH];
      end
    end
  end

  always_comb begin
    tlb2cc_resp_valid = '0;
    tlb_hit = '0;
    tlb_miss = '0;
    case (rff_state)
      ST_READY: begin
        tlb2cc_resp_valid = skip_trans ? rff_cc2tlb_req_valid : is_tlb_hit;
        tlb_hit = is_tlb_hit;
      end
      ST_TLB_RET: begin
        tlb2cc_resp_valid = '1;
        tlb_miss = '1;
      end
    endcase
  end

  // }}}

  //==========================================================
  // LRU {{{

  generate
    if (is_vtlb) begin
      always_comb begin
        tlb_replace_wyid = '0;
        if (do_update_tlb & ~cfg_bypass_tlb) begin
          lru2_get_replace_way_id(.replace_way_id(tlb_replace_wyid), .lru(rff_lru), .way_valid(rff_tlb_valid), .way_enable('1));
        end
      end

      always_comb begin
        next_lru = rff_lru;
        if (rff_state == ST_SFENCE) begin
          next_lru = '0;
        end else if (~cfg_bypass_tlb) begin
          if (is_tlb_hit) begin
            lru2_update_lru(.new_lru(next_lru), .old_lru(rff_lru), .way_id(tlb_match_wyid));
          end else if (do_update_tlb) begin
            lru2_update_lru(.new_lru(next_lru), .old_lru(rff_lru), .way_id(tlb_replace_wyid));
          end
        end
      end
    end else begin
      always_comb begin
        tlb_replace_wyid = '0;
        if (do_update_tlb & ~cfg_bypass_tlb) begin
          lru8_get_replace_way_id(.replace_way_id(tlb_replace_wyid), .lru(rff_lru), .way_valid(rff_tlb_valid), .way_enable('1));
        end
      end

      always_comb begin
        next_lru = rff_lru;
        if (rff_state == ST_SFENCE) begin
        end else if (~cfg_bypass_tlb) begin
          if (is_tlb_hit & ~cfg_bypass_tlb) begin
            lru8_update_lru(.new_lru(next_lru), .old_lru(rff_lru), .way_id(tlb_match_wyid));
          end else if (do_update_tlb & ~cfg_bypass_tlb) begin
            lru8_update_lru(.new_lru(next_lru), .old_lru(rff_lru), .way_id(tlb_replace_wyid));
          end
        end
      end
    end
  endgenerate

  // }}}

  //==========================================================
  // Exception checking {{{

  // SUM exceptions
  assign sum_excp_valid = ((effective_prv == ORV64_PRV_S) & ~mstatus.SUM) & resp_pte.user;

  // Access and dirty bit exceptions
  assign ad_excp_valid = ~resp_pte.accessed | (~resp_pte.dirty & ((dff_cc2tlb_req.req_access_type == ORV64_ACCESS_STORE) | (dff_cc2tlb_req.req_access_type == ORV64_ACCESS_AMO)));

  // U mode accessing non u pages
  assign u_excp_valid = (effective_prv == ORV64_PRV_U) & ~resp_pte.user;

  // S mode executing u page
  assign exe_excp_valid = (prv == ORV64_PRV_S) & (dff_cc2tlb_req.req_access_type == ORV64_ACCESS_FETCH) & resp_pte.user;

  // Outside of valid address range (
  assign access_excp_valid = (|tlb2cc_resp.resp_ppn[(38-12):(32-12)]);

  always_comb begin
    if ((rff_state == ST_TLB_RET) & (dff_ptw2tlb_resp.resp_excp_valid)) begin
      tlb2cc_resp.resp_excp_valid = '1;
      tlb2cc_resp.resp_excp_cause = dff_ptw2tlb_resp.resp_excp_cause;
    end else if (~skip_trans & (sum_excp_valid | ad_excp_valid | u_excp_valid | exe_excp_valid | perm_excp_valid)) begin
      tlb2cc_resp.resp_excp_valid = '1;
      tlb2cc_resp.resp_excp_cause = excp_cause;
    end else if (access_excp_valid) begin
      tlb2cc_resp.resp_excp_valid = '1;
      tlb2cc_resp.resp_excp_cause = access_excp_cause;
    end else begin
      tlb2cc_resp.resp_excp_valid = '0;
      tlb2cc_resp.resp_excp_cause = ORV64_EXCP_CAUSE_NONE;
    end
  end

  // Permission exceptions
  orv64_perm_checker perm_checker_u (
    .perm_x(resp_pte.perm_x),
    .perm_r(resp_pte.perm_r),
    .perm_w(resp_pte.perm_w),
    .access_type(dff_cc2tlb_req.req_access_type),
    .mstatus(mstatus),
    .excp_valid(perm_excp_valid)
  );

  always_comb begin
    orv64_get_fault_type (
      .access_type(dff_cc2tlb_req.req_access_type),
      .excp_cause(excp_cause)
    );
  end

  always_comb begin
    orv64_get_excp_perm_type (
      .access_type(dff_cc2tlb_req.req_access_type),
      .excp_cause(access_excp_cause)
    );
  end

  // DA

  always_comb begin
    if (da2tlb.en) begin
      tlb2da.tlb_valid = rff_tlb_valid[da2tlb.idx[TLB_CNTR_WIDTH-1:0]];
      tlb2da.tlb_asid = dff_tlb[da2tlb.idx[TLB_CNTR_WIDTH-1:0]].asid;
      tlb2da.tlb_vpn = dff_tlb[da2tlb.idx[TLB_CNTR_WIDTH-1:0]].vpn;
      tlb2da.tlb_pte = dff_tlb[da2tlb.idx[TLB_CNTR_WIDTH-1:0]].pte;
    end else begin
      tlb2da = '0;
    end
  end

`ifndef SYNTHESIS
  chk_tlb_match_one_hot: assert property (@(posedge clk) disable iff (rstn !== '1) ((is_tlb_hit) |-> $onehot(tlb_match))) else `olog_error("ORV_TLB", $sformatf("%m: tlb_match=%b is not one-hot", tlb_match));
`endif

endmodule

`endif

