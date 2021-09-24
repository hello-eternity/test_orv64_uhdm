// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

// this is just a store buffer for now
module orv64_storebuf
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  // orv64 interface
  input   orv64_ex2dc_t   ex2dc,
  output  orv64_dc2ma_t   dc2ma,
  input   logic     flush,

  // L2 cpu noc interface
  output  cpu_cache_if_req_t  cpu_req,
  output  logic      cpu_req_valid,
  input   logic      cpu_req_ready,

  input   cpu_cache_if_resp_t cpu_resp,
  input   logic      cpu_resp_valid,
  output  logic      cpu_resp_ready,

  // OURSBUS interface
`ifdef ORV_SUPPORT_OURSBUS
  output  logic                     dc2ob_req, dc2ob_rwn,
  output  orv64_paddr_t  dc2ob_addr,
  output  orv64_data_t                    dc2ob_wdata,

  input   orv64_data_t    ob2dc_rdata,
  input   logic     ob2dc_resp,

`ifdef ORV_SUPPORT_MAGICMEM
  input   orv64_paddr_t  cfg_magicmem_start_addr,
                         cfg_magicmem_end_addr,
                         cfg_from_host_addr,
                         cfg_to_host_addr,
`endif // ORV_SUPPORT_MAGICMEM
`endif // ORV_SUPPORT_OURSBUS

  input             rst, clk
);

  logic update_store_buf;
  orv64_store_buf_t store_buf, store_buf_ff;

  orv64_ex2dc_t ex2dc_ff;
  logic   [ORV64_DCACHE_TAG_WIDTH+ORV64_DCACHE_INDEX_WIDTH-1:0] tag, tag_ff;
  logic   [ORV64_DCACHE_DATA_OFFSET_WIDTH-1:0]  data_offset, data_offset_ff;
  logic   [7:0] mask_ff;
  logic   [63:0] store_buf_bit_mask, rdata_ff;

  logic   hold_req_ff, cpu_resp_valid_ff, need_resp;

  logic   ob2dc_resp_ff;
  orv64_data_t  ob2dc_rdata_ff;
  logic   is_oursbus, hold_oursbus, is_magicmem;

`ifndef SYNTHESIS
  logic [63:0] status;
  always @ (posedge clk) begin
    if (!rst && ($test$plusargs("orv_enable_mem_info") == 1'b1)) begin
      if (ex2dc.re)
        `olog_info("ORV_MEM", $sformatf("read addr=%h mask=%h", ex2dc.addr, ex2dc.mask));
      if (ex2dc.we)
        `olog_info("ORV_MEM", $sformatf("write addr=%h data=%h mask=%h", ex2dc.addr, ex2dc.wdata, ex2dc.mask));
      if (dc2ma.valid)
        `olog_info("ORV_MEM", $sformatf("read data=%h", dc2ma.rdata));
      if (flush)
        `olog_info("ORV_MEM", $sformatf("flush"));
    end
  end
`endif

  always_ff @ (posedge clk)
    if (rst) begin
      ex2dc_ff.re <= '0;
      ex2dc_ff.we <= '0;
    end else begin
      ex2dc_ff.re <= ex2dc.re;
      ex2dc_ff.we <= ex2dc.we;
      if (ex2dc.re | ex2dc.we) begin
        ex2dc_ff.addr <= ex2dc.addr;
        ex2dc_ff.mask <= ex2dc.mask;
        ex2dc_ff.wdata <= ex2dc.wdata;
      end
    end

  always_ff @ (posedge clk)
    if (rst) begin
      store_buf_ff.valid <= '0;
      store_buf_ff.dirty <= '0;
      hold_req_ff <= '1;
      cpu_resp_valid_ff <= '0;

    end else begin
      if (update_store_buf)
        store_buf_ff <= store_buf;

      cpu_resp_valid_ff <= cpu_resp_valid;
      if (~hold_req_ff & cpu_resp_valid_ff)
        hold_req_ff <= '1;
      else if (hold_req_ff & cpu_req_valid & cpu_req_ready & ~ex2dc_ff.we & ~flush)
        hold_req_ff <= '0;

      if (cpu_resp_valid)
        case (data_offset)
          2'b00: rdata_ff <= cpu_resp.resp_data[0 +: 64];
          2'b01: rdata_ff <= cpu_resp.resp_data[64 +: 64];
          2'b10: rdata_ff <= cpu_resp.resp_data[64*2 +: 64];
          default: rdata_ff <= cpu_resp.resp_data[64*3 +: 64];
        endcase
    end

`ifdef ORV_SUPPORT_OURSBUS
    always_ff @ (posedge clk) begin
      if (rst)
        ob2dc_resp_ff <= '0;
      else begin
        ob2dc_resp_ff <= ob2dc_resp;
        if (ob2dc_resp)
          ob2dc_rdata_ff <= ob2dc_rdata;
      end
    end
`endif

  //==========================================================

  always_comb begin
    is_oursbus = '0;
    is_magicmem = '0;
`ifdef ORV_SUPPORT_OURSBUS
    is_oursbus = ex2dc_ff.addr[ORV64_PHY_ADDR_WIDTH-1];
`ifdef ORV_SUPPORT_MAGICMEM
    if ((ex2dc_ff.addr >= cfg_magicmem_start_addr) & (ex2dc_ff.addr < cfg_magicmem_end_addr)) begin
      is_oursbus = '1;
      is_magicmem = '1;
    end
    if ((ex2dc_ff.addr == cfg_from_host_addr) | (ex2dc_ff.addr == cfg_to_host_addr)) begin
      is_oursbus = '1;
      is_magicmem = '1;
    end
`endif // ORV_SUPPORT_MAGICMEM
`endif // ORV_SUPPORT_OURSBUS

    tag = ex2dc_ff.addr[ORV64_DCACHE_TAG_MSB:ORV64_DCACHE_INDEX_LSB];;
    data_offset = ex2dc_ff.addr[ORV64_DCACHE_DATA_OFFSET_MSB-:ORV64_DCACHE_DATA_OFFSET_WIDTH];
  
    store_buf = store_buf_ff;
    update_store_buf = '0;

    store_buf_bit_mask = '0;
    for (int i=0; i<8; i++)
      for (int j=0; j<8; j++)
        store_buf_bit_mask[i*8+j] = store_buf_ff.dirty[data_offset][i];

    dc2ma.valid = '0;

    cpu_req_valid = '0;
    cpu_req = '0;
    cpu_resp_ready = '1;

    cpu_req.req_paddr = (ex2dc_ff.we | flush) ? {store_buf_ff.tag, {$clog2(CACHE_LINE_BYTE){1'b0}} } : {ex2dc_ff.addr & { {(64-$clog2(CACHE_LINE_BYTE)){1'b1}}, {$clog2(CACHE_LINE_BYTE){1'b0}} }};
    cpu_req.req_data = store_buf_ff.data;

`ifdef ORV_SUPPORT_OURSBUS
    dc2ob_req = '0;
    dc2ob_rwn = '0;
    dc2ob_wdata = ex2dc_ff.wdata;
`ifdef ORV_SUPPORT_MAGICMEM
    dc2ob_addr = ex2dc_ff.addr[ORV64_PHY_ADDR_WIDTH-1:0];
    if (is_magicmem)
      dc2ob_addr[ORV64_PHY_ADDR_WIDTH-1:ORV64_PHY_ADDR_WIDTH-6] = ORV64_MAGICMEM_OURSBUS_ID;
`else
    dc2ob_addr = ex2dc_ff.addr[ORV64_PHY_ADDR_WIDTH-1:0];
`endif // ORV_SUPPORT_MAGICMEM
`endif // ORV_SUPPORT_OURSBUS

    `ifndef SYNTHESIS
      status = "idle";
    `endif

    for (int i=0; i<8; i++)
      if (ex2dc_ff.mask[i])
        store_buf.data[data_offset][i*8 +: 8] = ex2dc_ff.wdata[i*8 +: 8];
    store_buf.tag = tag;

    // write {{{
    if (ex2dc_ff.we) begin
      cpu_req.req_mask = store_buf_ff.dirty;
      cpu_req.req_tid.cpu_noc_id = '0;
      cpu_req.req_tid.src = 4'h1;
      cpu_req.req_tid.tid = 4'h1;
      cpu_req.req_type = REQ_WRITE;

      if (is_oursbus) begin
`ifdef ORV_SUPPORT_OURSBUS
        dc2ob_req = '1;
        dc2ob_rwn = '0; // write oursbus
        if (ob2dc_resp_ff) begin
          dc2ob_req = '0;
          dc2ma.valid = '1;
        end
`endif // ORV_SUPPORT_OURSBUS
      end else
        if (((tag == store_buf_ff.tag) & store_buf_ff.valid) | ~store_buf_ff.valid) begin
          // write hit or store buf is empty
          dc2ma.valid = '1;
          cpu_req_valid = '0;

          // write store buf
          update_store_buf = '1;
          store_buf.dirty[data_offset] |= ex2dc_ff.mask; // don't reset dirty bits
          store_buf.valid = '1;

        `ifndef SYNTHESIS
          status = "whit";
        `endif
        end else begin
          // write miss and store buf is not empty, kick it out to L2
          dc2ma.valid = cpu_req_ready;
          cpu_req_valid = '1;

          if (cpu_req_ready) begin
            // cpu_req is accepted, write store buffer
            update_store_buf = '1;
            store_buf.valid = '1;
            store_buf.dirty = '0; // reset all dirty bits first for new entry
            store_buf.dirty[data_offset] |= ex2dc_ff.mask; // don't reset dirty bits
          end
        `ifndef SYNTHESIS
          status = "wmiss";
        `endif
        end
    end // }}}

    // read {{{
`ifdef ORV_SUPPORT_OURSBUS
    dc2ma.rdata = is_oursbus ? ob2dc_rdata_ff : store_buf_ff.data[data_offset];
`else
    dc2ma.rdata = store_buf_ff.data[data_offset];
`endif
    if (ex2dc_ff.re) begin
      cpu_req.req_mask = '0;
      cpu_req.req_mask[data_offset*8 +: 8] = ex2dc_ff.mask;
      cpu_req.req_tid.cpu_noc_id = '0;
      cpu_req.req_tid.src = 4'h1;
      cpu_req.req_tid.tid = 4'h2;
      cpu_req.req_type = REQ_READ;

      if (is_oursbus) begin
`ifdef ORV_SUPPORT_OURSBUS
        dc2ob_req = '1;
        dc2ob_rwn = '1; // read oursbus
        if (ob2dc_resp_ff) begin
          dc2ob_req = '0;
          dc2ma.valid = '1;
        end
`endif
      end else
        // check store buffer, dirty bit indicates it's been written (newest version)
        if (store_buf_ff.valid & (tag == store_buf_ff.tag) & ((ex2dc_ff.mask & store_buf_ff.dirty[data_offset]) == ex2dc_ff.mask)) begin
          // hit
          dc2ma.valid = '1;
          cpu_req_valid = '0;

        `ifndef SYNTHESIS
          status = "rhit";
        `endif
        end else begin
          // miss
          dc2ma.valid = '0;
          cpu_req_valid = hold_req_ff;

        `ifndef SYNTHESIS
          status = "rmiss";
        `endif
        end
    end

    if (cpu_resp_valid_ff) begin
      dc2ma.valid = '1;

      if (store_buf_ff.valid & (tag == store_buf_ff.tag)) begin
        // store_buf match read address
        for (int i=0; i<64; i++)
          if (~store_buf_bit_mask[i])
            dc2ma.rdata[i] = rdata_ff[i];
      end else begin
        // not in store_buf
        dc2ma.rdata = rdata_ff;
      end
    end
    // }}}

    // flush {{{
    if (flush) begin
      cpu_req.req_mask = store_buf_ff.dirty;
      cpu_req.req_tid.cpu_noc_id = '0;
      cpu_req.req_tid.src = 4'h1;
      cpu_req.req_tid.tid = 4'h1;
      cpu_req.req_type = REQ_WRITE;

      dc2ma.valid = cpu_req_ready;
      cpu_req_valid = store_buf_ff.valid;
      update_store_buf = store_buf_ff.valid;
      store_buf.valid = '0;
      store_buf.dirty = '0;
    `ifndef SYNTHESIS
      status = "flush";
    `endif
    end
    // }}}
  end
  `ifndef SYNTHESIS
  chk_resp_with_re: assert property (@(posedge clk) disable iff (rst !== '0) (cpu_resp_valid |-> ex2dc_ff.re)) else `olog_error("ORV_STOREBUF", $sformatf("%m: resp when re is not asserted"));
  chk_paddr_non_x: assert property (@(posedge clk) disable iff (rst !== '0) (cpu_req_valid |-> !$isunknown(cpu_req.req_paddr)) ) else `olog_error("ORV_STOREBUF", $sformatf("%m: cpu_req.req_paddr is x"));
  chk_flush: assert property (@(posedge clk) disable iff (rst !== '0) (flush |-> (~ex2dc_ff.we & ~ex2dc_ff.re))) else `olog_error("ORV_STOREBUF", $sformatf("%m"));
  `endif
endmodule
