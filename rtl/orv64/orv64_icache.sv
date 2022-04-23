// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
/*module sram_256_128_sky130A(clk0,vccd1,vssd1,csb0,web0,addr0,din0,dout0);
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [6:0]  addr0;
  input [255:0]  din0;
  output [255:0] dout0;
  inout vccd1;
  inout vssd1;
endmodule

module sram_24_128_sky130A(clk0,vccd1,vssd1,csb0,web0,addr0,din0,dout0);
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [6:0]  addr0;
  input [23:0]  din0;
  output [23:0] dout0;
  inout vccd1;
  inout vssd1;
endmodule*/
module sram_24_128_sky130A(
`ifdef USE_POWER_PINS
    vccd1,
    vssd1,
`endif
// Port 0: RW
    clk0,csb0,web0,addr0,din0,dout0
  );

  parameter DATA_WIDTH = 24 ;
  parameter ADDR_WIDTH = 7 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  // FIXME: This delay is arbitrary.
  parameter DELAY = 3 ;
  parameter VERBOSE = 1 ; //Set to 0 to only display warnings
  parameter T_HOLD = 1 ; //Delay to hold dout value after posedge. Value is arbitrary

`ifdef USE_POWER_PINS
    inout vccd1;
    inout vssd1;
`endif
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [ADDR_WIDTH-1:0]  addr0;
  input [DATA_WIDTH-1:0]  din0;
  output [DATA_WIDTH-1:0] dout0;

  reg  csb0_reg;
  reg  web0_reg;
  reg [ADDR_WIDTH-1:0]  addr0_reg;
  reg [DATA_WIDTH-1:0]  din0_reg;
  reg [DATA_WIDTH-1:0]  dout0;

  // All inputs are registers
  always @(posedge clk0)
  begin
    csb0_reg = csb0;
    web0_reg = web0;
    addr0_reg = addr0;
    din0_reg = din0;
    #(T_HOLD) dout0 = 24'bx;
    if ( !csb0_reg && web0_reg && VERBOSE ) 
      $display($time," Reading %m addr0=%b dout0=%b",addr0_reg,mem[addr0_reg]);
    if ( !csb0_reg && !web0_reg && VERBOSE )
      $display($time," Writing %m addr0=%b din0=%b",addr0_reg,din0_reg);
  end

reg [DATA_WIDTH-1:0]    mem [0:RAM_DEPTH-1];

  // Memory Write Block Port 0
  // Write Operation : When web0 = 0, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_WRITE0
    if ( !csb0_reg && !web0_reg ) begin
        mem[addr0_reg][23:0] = din0_reg[23:0];
    end
  end

  // Memory Read Block Port 0
  // Read Operation : When web0 = 1, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_READ0
    if (!csb0_reg && web0_reg)
       dout0 <= #(DELAY) mem[addr0_reg];
  end

endmodule

module sram_256_128_sky130A(
`ifdef USE_POWER_PINS
    vdd,
    gnd,
`endif
// Port 0: RW
    clk0,csb0,web0,addr0,din0,dout0
  );

  parameter DATA_WIDTH = 256 ;
  parameter ADDR_WIDTH = 7 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  // FIXME: This delay is arbitrary.
  parameter DELAY = 3 ;
  parameter VERBOSE = 1 ; //Set to 0 to only display warnings
  parameter T_HOLD = 1 ; //Delay to hold dout value after posedge. Value is arbitrary

`ifdef USE_POWER_PINS
    inout vdd;
    inout gnd;
`endif
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [ADDR_WIDTH-1:0]  addr0;
  input [DATA_WIDTH-1:0]  din0;
  output [DATA_WIDTH-1:0] dout0;

  reg  csb0_reg;
  reg  web0_reg;
  reg [ADDR_WIDTH-1:0]  addr0_reg;
  reg [DATA_WIDTH-1:0]  din0_reg;
  reg [DATA_WIDTH-1:0]  dout0;

  // All inputs are registers
  always @(posedge clk0)
  begin
    csb0_reg = csb0;
    web0_reg = web0;
    addr0_reg = addr0;
    din0_reg = din0;
    #(T_HOLD) dout0 = 256'bx;
    if ( !csb0_reg && web0_reg && VERBOSE ) 
      $display($time," Reading %m addr0=%b dout0=%b",addr0_reg,mem[addr0_reg]);
    if ( !csb0_reg && !web0_reg && VERBOSE )
      $display($time," Writing %m addr0=%b din0=%b",addr0_reg,din0_reg);
  end

reg [DATA_WIDTH-1:0]    mem [0:RAM_DEPTH-1];

  // Memory Write Block Port 0
  // Write Operation : When web0 = 0, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_WRITE0
    if ( !csb0_reg && !web0_reg ) begin
        mem[addr0_reg][255:0] = din0_reg[255:0];
    end
  end

  // Memory Read Block Port 0
  // Read Operation : When web0 = 1, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_READ0
    if (!csb0_reg && web0_reg)
       dout0 <= #(DELAY) mem[addr0_reg];
  end

endmodule




module orv64_icache
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;
  import orv64_typedef_pkg::*;
  import pygmy_intf_typedef::*;
(
  input   orv64_ib2icmem_t          ib2ic,
  output  orv64_icmem2ib_t          ic2ib,
  output  logic                     ic_hit, ic_miss,

  output orv64_ic2sys_t       ic2isys,
  input  orv64_sys2ic_t       isys2ic,

  input   logic                     id2ic_fence_req_valid,
  input   cache_fence_if_req_t      id2ic_fence_req,
  output  logic                     ic2id_fence_req_ready,

  output  logic                     ic2id_fence_resp_valid,
  output  cache_fence_if_resp_t     ic2id_fence_resp,
  input   logic                     id2ic_fence_resp_ready,

  // TLB
  output logic                      ic2tlb_valid,
  output orv64_cache_tlb_if_req_t   ic2tlb,
  input  logic                      tlb2ic_ready,

  input  logic                      tlb2ic_valid,
  input  orv64_cache_tlb_if_resp_t  tlb2ic,
  output logic                      ic2tlb_ready,

  // L2
  output logic                      cpu_if_req_valid, 
  output cpu_cache_if_req_t         cpu_if_req, 
  input logic                       cpu_if_req_ready, 

  input logic                       cpu_if_resp_valid, 
  input cpu_cache_if_resp_t         cpu_if_resp, 
  output logic                      cpu_if_resp_ready, 

  input  logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_en_pway,
  input  logic    [ORV64_N_ICACHE_WAY-1:0]        debug_ic_tag_ram_rw_pway,
  input  orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_addr_pway,
  input  orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_din_pway,
  output orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_tag_ram_dout_pway,

  input  logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_en_pway,
  input  logic   [ORV64_N_ICACHE_WAY-1:0]         debug_ic_data_ram_rw_pway,
  input  orv64_ic_idx_t [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_addr_pway,
  input  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_bitmask_pway,
  input  cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_din_pway,
  output cache_line_t   [ORV64_N_ICACHE_WAY-1:0]  debug_ic_data_ram_dout_pway,

  input   logic       cfg_pwr_on,
  input   logic       cfg_bypass_ic,
  input   logic [5:0] cfg_lfsr_seed,
  input   logic       rst, clk
);

  logic [ORV64_PAGE_OFFSET_WIDTH-1:0] page_ofs;
  orv64_vaddr_t                       rff_ib2ic_pc;
  orv64_paddr_t                       req_paddr, dff_req_paddr;
  logic [CPUNOC_TID_TID_SIZE-1:0]     rff_tid;
  logic                               do_fence;

  orv64_ic_tag_entry_t  [ORV64_N_ICACHE_WAY-1:0] tag_ram_dout;
  orv64_ic_tag_entry_t  [ORV64_N_ICACHE_WAY-1:0] tag_ram_din;
  cache_line_t [ORV64_N_ICACHE_WAY-1:0] data_ram_dout;
  cache_line_t [ORV64_N_ICACHE_WAY-1:0] data_ram_din;
  cache_line_t [ORV64_N_ICACHE_WAY-1:0] data_ram_bitmask;

  logic     [ORV64_N_ICACHE_WAY-1:0] tag_ram_en;
  logic     [ORV64_N_ICACHE_WAY-1:0] tag_ram_rw;
  logic     [ORV64_N_ICACHE_WAY-1:0] data_ram_en;
  logic     [ORV64_N_ICACHE_WAY-1:0] data_ram_rw;

  orv64_ic_idx_t  [ORV64_N_ICACHE_WAY-1:0] tag_index, data_index;

  //==========================================================
  // ICG {{{

  logic en_req_paddr, en_req_tag;
  logic sram_out_clkg;
  logic req_paddr_clkg;

  assign en_req_paddr = cpu_if_req_valid & cpu_if_req_ready;
  assign en_req_tag = cpu_if_req_valid & cpu_if_req_ready;

  icg req_paddr_clk_u (
    .en       (en_req_paddr),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (req_paddr_clkg)
  );

  icg sram_out_clk_u(
    .en       (do_save_tag_and_data),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (sram_out_clkg)
  );

  icg req_tag_clk_u(
    .en       (en_req_tag),
    .tst_en   (1'b0),
    .clk      (clk), //ICG input
    .clkg     (req_tag_clkg)
  );

  // }}}

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_ib2ic_pc <= '0;
    end else begin
      if (ib2ic.en) begin
        rff_ib2ic_pc <= ib2ic.pc;
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_tid <= '0;
    end else begin
      if (cpu_if_resp_valid & cpu_if_resp_ready) begin
        rff_tid <= rff_tid + CPUNOC_TID_TID_SIZE'('h1);
      end
    end
  end


  //==========================================================
  // TLB Handshake {{{

  logic rff_has_req;
  logic is_sys_req, is_l2_req;
  logic is_hit;

  // Only send 1 tlb request per ib2if request
  always_ff @(posedge clk) begin
    if (rst) begin
      rff_has_req <= '0;
    end else begin
      if (rff_has_req) begin
        rff_has_req <= ic2ib.valid ? (ic2tlb_valid & tlb2ic_ready): '1;
      end else begin
        rff_has_req <= (ic2tlb_valid & tlb2ic_ready);
      end
    end
  end

  assign ic2tlb_valid           = (~rff_has_req | ic2ib.valid) & ib2ic.en & ~do_fence; 
  assign ic2tlb.req_vpn         = ib2ic.pc >> ORV64_PAGE_OFFSET_WIDTH;
  assign ic2tlb.req_access_type = ORV64_ACCESS_FETCH;

  assign is_excp           = tlb2ic_valid & tlb2ic.resp_excp_valid;
  assign is_sys_req        = tlb2ic_valid & ~tlb2ic.resp_ppn[31-12];
  assign is_l2_req         = tlb2ic_valid & ~is_sys_req;

  always_comb begin
    if (is_excp) begin
      ic2tlb_ready = '1;
    end else if (is_sys_req) begin
      ic2tlb_ready = isys2ic.valid;
    end else if (is_l2_req) begin
      ic2tlb_ready = is_hit ? '1: cpu_if_req_ready;
    end else begin
      ic2tlb_ready = '0;
    end
  end

  // }}}

  //==========================================================
  // L2 req {{{

  logic rff_is_l2_resp;

  assign page_ofs = {rff_ib2ic_pc[ORV64_PAGE_OFFSET_WIDTH-1:OFFSET_WIDTH], {OFFSET_WIDTH{1'b0}}};
  assign req_paddr = {tlb2ic.resp_ppn, page_ofs};

  assign cpu_if_req_valid = is_l2_req & ~is_hit & ~is_excp;
  assign cpu_if_req.req_paddr = req_paddr;
  assign cpu_if_req.req_data = '0;
  assign cpu_if_req.req_mask = '0;
  assign cpu_if_req.req_tid.src = ORV64_IC_SRC_ID;
  assign cpu_if_req.req_tid.tid = rff_tid;
  assign cpu_if_req.req_tid.cpu_noc_id = 4'h0;
  assign cpu_if_req.req_type = REQ_READ;

  assign cpu_if_resp_ready = rff_is_l2_resp;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_is_l2_resp <= '0;
    end else begin
      if (cpu_if_req_valid & cpu_if_req_ready) begin
        rff_is_l2_resp <= '1;
      end else if (cpu_if_resp_valid & cpu_if_resp_ready) begin
        rff_is_l2_resp <= '0;
      end
    end
  end

  // }}}

  //==========================================================
  // Sysbus {{{

  assign ic2isys.en = is_sys_req & ~isys2ic.valid & ~is_excp;
  assign ic2isys.pc = req_paddr;

  // }}}

  //==========================================================
  // Fence {{{

  logic [ORV64_ICACHE_INDEX_WIDTH:0]  rff_fence_idx;
  logic                               rff_pending_fence;
  logic                               is_fence_done;
  orv64_ic_idx_t                      fence_idx;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_fence_idx <= '0;
    end else begin
      if (ic2id_fence_resp_valid) begin
        if (id2ic_fence_resp_ready) begin
          rff_fence_idx <= '0;
        end
      end else if (do_fence) begin
        rff_fence_idx <= rff_fence_idx + (ORV64_ICACHE_INDEX_WIDTH+1)'('h1);
      end
    end
  end

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_pending_fence <= '0;
    end else begin
      if (id2ic_fence_req_valid & ic2id_fence_req_ready) begin
        rff_pending_fence <= '1;
      end else if (ic2id_fence_resp_valid & id2ic_fence_resp_ready) begin
        rff_pending_fence <= '0;
      end
    end
  end

  assign is_fence_done = rff_fence_idx[ORV64_ICACHE_INDEX_WIDTH];

  assign ic2id_fence_req_ready = ~rff_pending_fence;
  assign ic2id_fence_resp_valid = is_fence_done;
  assign ic2id_fence_resp.resp_fence_is_done = '1;

  assign do_fence = rff_pending_fence & ~is_fence_done;

  assign fence_idx = rff_fence_idx[ORV64_ICACHE_INDEX_WIDTH-1:0];

  // }}}

  //==========================================================
  // IB resp {{{

  cache_line_t                           match_data;

  assign ic2ib.excp_valid = is_excp;
  assign ic2ib.excp_cause = tlb2ic.resp_excp_cause;

  always_comb begin
    if (is_excp) begin
      ic2ib.valid = '1;
      ic2ib.pc_paddr = '0;
      ic2ib.rdata = '0;
      ic_hit = '0;
      ic_miss = '0;
    end else if (is_hit) begin
      ic2ib.valid = '1;
      ic2ib.pc_paddr = req_paddr;
      ic2ib.rdata = match_data;
      ic_hit = '1;
      ic_miss = '0;
    end else if (is_sys_req) begin
      ic2ib.valid = isys2ic.valid;
      ic2ib.pc_paddr = req_paddr;
      ic2ib.rdata = isys2ic.rdata;
      ic_hit = '0;
      ic_miss = isys2ic.valid;
    end else if (rff_is_l2_resp) begin
      ic2ib.valid = cpu_if_resp_valid;
      ic2ib.pc_paddr = dff_req_paddr;
      ic2ib.rdata = cpu_if_resp.resp_data;
      ic_hit = '0;
      ic_miss = cpu_if_resp_valid;
    end else begin
      ic2ib.valid = '0;
      ic2ib.pc_paddr = '0;
      ic2ib.rdata = '0;
      ic_hit = '0;
      ic_miss = '0;
    end
  end

  always_ff @(posedge req_paddr_clkg) begin
    if (en_req_paddr) begin
      dff_req_paddr <= cpu_if_req.req_paddr;
    end
  end

  // }}}

`ifndef SYNTHESIS
  cpu_if_req_valid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(cpu_if_req_valid))) else `olog_fatal("ORV_ICACHE_BYPASS", $sformatf("%m: cpu_if_req_valid is x"));
  cpu_if_resp_valid_is_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(cpu_if_resp_valid))) else `olog_fatal("ORV_ICACHE_BYPASS", $sformatf("%m: cpu_if_resp_valid is x"));
  unexpected_l2_resp: assert property (@(posedge clk) disable iff (rst !== '0) (cpu_if_resp_valid |-> rff_is_l2_resp)) else `olog_fatal("ORV_ICACHE_BYPASS", $sformatf("%m: received l2 resp with no request"));
  wrong_l2_tid: assert property (@(posedge clk) disable iff (rst !== '0) ((cpu_if_resp_valid & cpu_if_resp_ready) |-> ((cpu_if_resp.resp_tid.tid === rff_tid) & (cpu_if_resp.resp_tid.src === ORV64_IC_SRC_ID)))) else `olog_error("ORV_ICACHE_BYPASS", $sformatf("%m: tid=%h src=%h, exp_tid=%h exp_src=%h", cpu_if_resp.resp_tid.tid, cpu_if_resp.resp_tid.src, rff_tid, ORV64_IC_SRC_ID));
`endif

  //==========================================================
  // Tag check
  logic [ORV64_N_ICACHE_WAY-1:0] [ORV64_N_ICACHE_WAY-1:0]         tag_valid;
  logic [ORV64_N_ICACHE_WAY-1:0] [ORV64_ICACHE_RAM_TAG_WIDTH-1:0] tag;
  logic                          [ORV64_ICACHE_RAM_TAG_WIDTH-1:0] req_tag, dff_req_tag;
  cache_line_t [ORV64_N_ICACHE_WAY-1:0]  inst_data;

  orv64_ic_tag_entry_t [ORV64_N_ICACHE_WAY-1:0] dff_tag_entry;
  cache_line_t         [ORV64_N_ICACHE_WAY-1:0] dff_inst_data;
  cache_line_t         [ORV64_N_ICACHE_WAY-1:0] temp_match_data;


  logic [ORV64_N_ICACHE_WAY-1:0] tag_match;

  assign is_hit = (tlb2ic_valid & (|tag_match)) & ~cfg_bypass_ic;
  assign is_miss = tlb2ic_valid & ~(|tag_match);

  always_comb begin
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      tag_match[i] = tag_valid[i] & (tag[i] == req_tag);
    end
  end

  always_comb begin
    match_data = '0;
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      match_data |= temp_match_data[i];
    end
  end

  always_comb begin
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      temp_match_data[i] = inst_data[i] & {$bits(cache_line_t){tag_match[i]}};
    end
  end

`ifndef SYNTHESIS
  ic_hit_not_x: assert property (@(posedge clk) disable iff (rst !== '0) !$isunknown(ic_hit))
    else `olog_fatal("ORV64_ICACHE", $sformatf("%m: ic hit is x"));
  ic_miss_not_x: assert property (@(posedge clk) disable iff (rst !== '0) !$isunknown(ic_miss))
    else `olog_fatal("ORV64_ICACHE", $sformatf("%m: ic miss is x"));
`endif


  //==========================================================
  // PRBS (for random replacement)
  logic       lfsr_en, lfsr_fb;
  logic [6:0] lfsr_ff;
  logic [$clog2(ORV64_N_ICACHE_WAY)-1:0] replace_wyid, replace_wyid_ff;

  assign lfsr_en = cpu_if_resp_valid & cpu_if_resp_ready;

  assign lfsr_fb = lfsr_ff[6] ^ lfsr_ff[5];

  always_ff @ (posedge clk) begin
    if (rst) begin
      lfsr_ff[0] <= 'b1;
      lfsr_ff[6:1] <= cfg_lfsr_seed;
      replace_wyid_ff <= '0;
    end else if (lfsr_en) begin
      lfsr_ff <= {lfsr_ff[5:0], lfsr_fb};
      replace_wyid_ff <= replace_wyid;
    end
  end

  always_comb begin
    replace_wyid = lfsr_ff[$clog2(ORV64_N_ICACHE_WAY)-1:0];
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      if (~tag_valid[i]) begin
        replace_wyid = i;
      end
    end
  end

  //==========================================================
  // SRAM

  //-----------------------------------------------------------
  // Control signals
  logic  write_l2_resp_data;
  logic  dff_tag_chk_en;

  assign write_l2_resp_data = (cpu_if_resp_valid & cpu_if_resp_ready) & ~cfg_bypass_ic;

  generate
    for(genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign tag_ram_en[i] = debug_ic_tag_ram_en_pway[i] | ((ic2tlb_valid & tlb2ic_ready) & ~cfg_bypass_ic) | (write_l2_resp_data & (i == replace_wyid_ff)) | do_fence;
      assign tag_ram_rw[i] = debug_ic_tag_ram_rw_pway[i] | write_l2_resp_data | do_fence;
    end
  endgenerate

  generate
    for(genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign data_ram_en[i] = debug_ic_data_ram_en_pway[i] | ((ic2tlb_valid & tlb2ic_ready) & ~cfg_bypass_ic) | (write_l2_resp_data & (i == replace_wyid_ff));
      assign data_ram_rw[i] = debug_ic_data_ram_rw_pway[i] | write_l2_resp_data;
    end
  endgenerate

  generate
    for(genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign data_ram_bitmask[i] = debug_ic_data_ram_en_pway[i] ? debug_ic_data_ram_bitmask_pway[i]: '1;
    end
  endgenerate

  always_ff @(posedge clk) begin
    dff_tag_chk_en <= ic2tlb_valid & tlb2ic_ready;
  end

  assign do_save_tag_and_data = dff_tag_chk_en & ~(tlb2ic_valid & ic2tlb_ready) & ~cfg_bypass_ic;

  always_ff @(posedge sram_out_clkg) begin
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      if (do_save_tag_and_data) begin
        dff_tag_entry[i] <= tag_ram_dout[i];
        dff_inst_data[i] <= data_ram_dout[i];
      end
    end
  end

  logic rff_do_use_saved_data;

  always_ff @(posedge clk) begin
    if (rst) begin
      rff_do_use_saved_data <= '0;
    end else begin
      if (rff_do_use_saved_data) begin
        rff_do_use_saved_data <= ~(tlb2ic_valid & ic2tlb_ready);
      end else begin
        rff_do_use_saved_data <= dff_tag_chk_en & ~(tlb2ic_valid & ic2tlb_ready);
      end
    end
  end

  generate
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign tag_valid[i] = rff_do_use_saved_data ? dff_tag_entry[i].valid: tag_ram_dout[i].valid;
      assign tag[i]       = rff_do_use_saved_data ? dff_tag_entry[i].tag: tag_ram_dout[i].tag;
      assign inst_data[i] = rff_do_use_saved_data ? dff_inst_data[i]: data_ram_dout[i];
    end
  endgenerate

  //-----------------------------------------------------------
  // Data signals

  assign req_tag = req_paddr[ORV64_ICACHE_TAG_MSB:ORV64_ICACHE_TAG_LSB]; // TODO

  generate
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      always_comb begin
        if (debug_ic_tag_ram_en_pway[i]) begin
          tag_index[i] = debug_ic_tag_ram_addr_pway[i];
        end else if (do_fence) begin
          tag_index[i] = fence_idx;
        end else if (write_l2_resp_data) begin
          tag_index[i] = req_paddr[ORV64_ICACHE_INDEX_MSB: ORV64_ICACHE_INDEX_LSB];
        end else begin
          tag_index[i] = ib2ic.pc[ORV64_ICACHE_INDEX_MSB: ORV64_ICACHE_INDEX_LSB];
        end
      end
    end
  endgenerate

  generate
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      always_comb begin
        if (debug_ic_data_ram_en_pway[i]) begin
          data_index[i] = debug_ic_data_ram_addr_pway[i];
        end else if (write_l2_resp_data) begin
          data_index[i] = req_paddr[ORV64_ICACHE_INDEX_MSB: ORV64_ICACHE_INDEX_LSB];
        end else begin
          data_index[i] = ib2ic.pc[ORV64_ICACHE_INDEX_MSB: ORV64_ICACHE_INDEX_LSB];
        end
      end
    end
  endgenerate

  always_comb begin
    for (int i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      if (debug_ic_tag_ram_en_pway[i]) begin
        tag_ram_din[i] = debug_ic_tag_ram_din_pway[i];
      end else begin
        if (do_fence) begin
          tag_ram_din[i].valid = '0;
          tag_ram_din[i].tag = '0;
        end else begin
          tag_ram_din[i].valid = '1;
          tag_ram_din[i].tag = dff_req_tag;
        end
      end
    end
  end

  always_ff @(posedge req_tag_clkg) begin
    if (en_req_tag) begin
      dff_req_tag <= cpu_if_req.req_paddr[ORV64_ICACHE_TAG_MSB:ORV64_ICACHE_TAG_LSB];
    end
  end

  generate
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign data_ram_din[i] = debug_ic_data_ram_en_pway[i] ? debug_ic_data_ram_din_pway[i]: cpu_if_resp.resp_data;
    end
  endgenerate

  generate 
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign debug_ic_tag_ram_dout_pway[i] = tag_ram_dout[i];
    end
  endgenerate

  generate 
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin
      assign debug_ic_data_ram_dout_pway[i] = data_ram_dout[i];
    end
  endgenerate

  generate
    for (genvar i=0; i<ORV64_N_ICACHE_WAY; i++) begin : PER_WAY
      sram_24_128_sky130A TAG_RAM(
        .clk0(clk),
        .csb0(~tag_ram_en[i] & ~cfg_pwr_on),
        .web0(~tag_ram_rw[i]),
        .addr0(tag_index[i]),
        .din0(tag_ram_din[i]),
        .dout0(tag_ram_dout[i])
      );

      sram_256_128_sky130A DATA_RAM (
        .clk0(clk),
        .csb0(~data_ram_en[i] & ~cfg_pwr_on),
        .web0(~data_ram_rw[i]),
        .addr0(data_index[i]),
        .din0(data_ram_din[i]),
        .dout0(data_ram_dout[i])
      );
    end
  endgenerate

endmodule
