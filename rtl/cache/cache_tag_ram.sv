// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

//==========================================================
// valid_ram
// consolidate all valids bits from all ways in a single valid bit ram (use write bit mask) {{{
// cc is a read only port, while mc is a write only port
// priority given to mc
module cache_valid_ram
  import pygmy_cfg::*;
  import pygmy_typedef::*;
(
  // cache controller side: read-only
  input   bank_index_t      cc_raddr,
  input   logic             cc_re,
  output  logic [N_WAY-1:0] cc_dout,
  output  logic             cc_rready,
  // memory controller side: write-only
  input   bank_index_t      mc_waddr,
  input   logic             mc_we,
  input   logic [N_WAY-1:0] mc_bwe, // write bit mask
  input   logic [N_WAY-1:0] mc_din, // can clear valid bits in a single write
  // debug access
  input   logic             debug_en, debug_rw,
  input   bank_index_t      debug_addr,
  input   logic [N_WAY-1:0] debug_din, debug_bwe,
  output  cpu_data_t        debug_dout,
  output  logic             debug_ready,
  // cfg
  input   logic             pwr_down, slp, rst, clk
);
  logic   en;  // chip enable
  logic   rw;  // 0 - read, 1 - write
  bank_index_t addr;

  logic [N_WAY-1:0] bwe, din;
  logic [N_WAY-1:0] temp_dout;
  assign  en = mc_we | cc_re | debug_en;
  assign  rw = mc_we | (debug_en & debug_rw);
  assign  addr = (debug_en) ? debug_addr : ((mc_we) ? mc_waddr : cc_raddr);

`ifndef SYNTHESIS
  chk_debug_en: assert property (@ (posedge clk) disable iff (~rst !== 0) (debug_en |-> ((mc_we == '0) && (cc_re == '0)))) else $fatal("%m: debug_en is asserted when mc_we or cc_re is not 0");
  chk_read_x: assert property (@ (posedge clk) disable iff (~rst !== 0) ((en & ~rw) |=> !$isunknown(cc_dout))) else $fatal("%m: read x");
`endif

  assign  cc_rready = ~mc_we;
  assign  debug_ready = ~mc_we & ~cc_re; // lowest priority

  assign  bwe = (debug_en) ? debug_bwe : mc_bwe;
  assign  din = (debug_en) ? debug_din : mc_din;
  assign  debug_dout = {{(CACHE_LINE_BYTE*8-N_WAY){1'b0}}, temp_dout};
  assign  cc_dout = temp_dout;
  logic [N_WAY-1:0] ram_dout, ram_dout_ff;
  logic             re_ff;

`ifndef FPGA
//   TS1N28HPCPHVTB512X8M8SWSO SRAM(
  TS1N28HPCPSVTB512X8M8SWSO SRAM(
    .SLP(slp), .SD(pwr_down),
    .CLK(clk), .CEB(~en), .WEB(~rw),
    .A(addr), .D(din),
    .BWEB(~bwe),
    .Q(ram_dout)
  );
`else // FPGA
  xilinx_spsram_bitmask #(.WIDTH(8), .DEPTH(512)) SRAM(
    .SLP(slp), .SD(pwr_down),
    .CLK(clk), .CEB(~en), .WEB(~rw),
    .A(addr), .D(din),
    .BWEB(~bwe),
    .Q(ram_dout)
  );
`endif // FPGA

  always_ff @ (posedge clk) begin
    re_ff <= (en & ~rw);
    if (re_ff)
      ram_dout_ff <= ram_dout;
  end
  assign temp_dout = re_ff ? ram_dout : ram_dout_ff;

endmodule // }}}

//==========================================================
// dirty ram
// consolidate all dirty bits from all ways in a single dirty bit ram (use write bit mask) {{{
module cache_dirty_ram
  import pygmy_cfg::*;
  import pygmy_typedef::*;
(
  // cache controller side: read/write
  input   bank_index_t      cc_addr,
  input   logic             cc_rw,    // 0 - read, 1 - write
  input   logic             cc_en,    // chip enable
  input   logic [N_WAY-1:0] cc_bwe,   // write bit mask
  input   logic             cc_din,   // dirty bit enable
  output  logic [N_WAY-1:0] cc_dout,
  output  logic             cc_ready,
  // memory controller side: write only
  input   bank_index_t      mc_waddr,
  input   logic             mc_we,    // chip enable
  input   logic [N_WAY-1:0] mc_bwe,   // write bit mask
  input   logic             mc_din,   // dirty bit enable
  // debug access
  input   logic             debug_en, debug_rw,
  input   bank_index_t      debug_addr,
  input   logic [N_WAY-1:0] debug_din, debug_bwe,
  output  cpu_data_t        debug_dout,
  output  logic             debug_ready,
  // cfg
  input   logic             pwr_down, slp, clk
);
  bank_index_t      addr;
  logic             rw;
  logic             en;
  logic [N_WAY-1:0] bwe;
  logic [N_WAY-1:0] din;
  logic [N_WAY-1:0] dout;
  logic [N_WAY-1:0] temp_out;

  assign cc_ready = ~mc_we;
  assign debug_ready = ~mc_we & ~cc_en;

  assign cc_dout = dout;
  assign debug_dout = {{(CACHE_LINE_BYTE*8-N_WAY){1'b0}}, dout};

  assign addr = (debug_en) ? debug_addr : ((mc_we) ? mc_waddr : cc_addr);
  assign bwe = (debug_en) ? debug_bwe : ((mc_we) ? mc_bwe : cc_bwe);
  assign rw = (debug_en) ? debug_rw : ((mc_we) ? 1'b1 : cc_rw);
  assign en = mc_we | cc_en | debug_en;
  assign din = (debug_en) ? debug_din : {N_WAY{(mc_we) ? mc_din: cc_din}};

  logic [N_WAY-1:0] ram_dout, ram_dout_ff;
  logic             re_ff;

`ifndef FPGA
//   TS1N28HPCPHVTB512X8M8SWSO SRAM(
  TS1N28HPCPSVTB512X8M8SWSO SRAM(
    .SLP(slp), .SD(pwr_down),
    .CLK(clk), .CEB(~en), .WEB(~rw),
    .A(addr), .D(din),
    .BWEB(~bwe),
    .Q(ram_dout)
  );
`else // FPGA
  xilinx_spsram_bitmask #(.WIDTH(8), .DEPTH(512)) SRAM(
    .SLP(slp), .SD(pwr_down),
    .CLK(clk), .CEB(~en), .WEB(~rw),
    .A(addr), .D(din),
    .BWEB(~bwe),
    .Q(ram_dout)
  );
`endif

  always_ff @ (posedge clk) begin
    re_ff <= (en & ~rw);
    if (re_ff)
      ram_dout_ff <= ram_dout;
  end
  assign dout = re_ff ? ram_dout : ram_dout_ff;

endmodule // }}}

//==========================================================
// tag ram
// every bank has one tag ram {{{
// write: from memory
// read: to l2cache
// tag bits are mapped to single port rams
// can further bank the ram to reduce structure hazard
module cache_tag_ram
  import pygmy_cfg::*;
  import pygmy_typedef::*;
(
  // cache controller side: read-only
  input   bank_index_t      cc_raddr,
  input   logic             cc_re,
  output  tag_t             cc_tag_out,
  output  logic             cc_rready,
  // memory controller side: write-only
  input   bank_index_t      mc_waddr,
  input   logic             mc_we,
  input   [DRAM_TAG_WIDTH-1:0] mc_tag_in,
  output  logic             mc_wready,
  // debug access
  input   logic             debug_en, debug_rw,
  input   bank_index_t      debug_addr,
  input   [DRAM_TAG_WIDTH-1:0] debug_din,
  output  cpu_data_t        debug_dout,
  output  logic             debug_ready,
  // cfg
  input   logic             pwr_down, slp, rst, clk
);

  logic   rw;  // 0 - read, 1 - write
  logic   en;  // chip enable
  bank_index_t addr;
  tag_t   temp_out;

  assign  en = cc_re | mc_we | debug_en;
  assign  rw = debug_en ? debug_rw : mc_we;
  assign  addr = debug_en ? debug_addr : ((mc_we) ? mc_waddr : cc_raddr);

  assign  mc_wready = '1; // mc port always has the highest priority
  assign  cc_rready = ~mc_we;
  assign  debug_ready = ~mc_we & ~ cc_re;
  assign  debug_dout = {{(CACHE_LINE_BYTE*8-TAG_WIDTH){1'b0}}, temp_out};
  assign  cc_tag_out = temp_out;
  dram_tag_t mc_short_tag_in, cc_short_tag_out, debug_short_din, short_tag_in;
  assign  mc_short_tag_in = mc_tag_in[DRAM_TAG_WIDTH-1:0];
  assign  debug_short_din = debug_din[DRAM_TAG_WIDTH-1:0];
  assign  temp_out = {{(TAG_WIDTH-DRAM_TAG_WIDTH){1'b0}}, cc_short_tag_out};
  assign  short_tag_in = debug_en ? debug_short_din : mc_short_tag_in;

`ifndef SYNTHESIS
  chk_debug_en: assert property (@ (posedge clk) disable iff (~rst !== 0) (debug_en |-> ((mc_we == '0) && (cc_re == '0)))) else $fatal("%m: debug_en is asserted when mc_we or cc_re is not 0");
  // disabled per Jim's advice, Yu 3/18/2018. chk_read_x: assert property (@ (posedge clk) disable iff (rst !== 0) ((en & ~rw) |=> !$isunknown(cc_short_tag_out))) else $fatal("%m: read x");
`endif

  dram_tag_t  ram_dout, ram_dout_ff;
  logic       re_ff;
  logic [19:0] tag_temp_out;  
 
  assign ram_dout = tag_temp_out[DRAM_TAG_WIDTH-1:0];

`ifndef FPGA
//   TS1N28HPCPHVTB512X18M8SSO SRAM (
  TS1N28HPCPUHDLVTB512X20M4SSO SRAM (
    .SLP(slp), .SD(pwr_down),
    .CLK(clk), .CEB(~en), .WEB(~rw),
    .A(addr), .D({{(20-DRAM_TAG_WIDTH){1'b0}},short_tag_in}),
    .RTSEL(2'b01),
    .WTSEL(2'b00),
    .Q(tag_temp_out)
  );
`else // FPGA
  xilinx_spsram #(.BYTE_WIDTH(20), .WIDTH(20), .DEPTH(512)) SRAM(
    .SLP(slp), .SD(pwr_down),
    .CLK(clk), .CEB(~en), .WEB(~rw),
    .A(addr), .D({{(20-DRAM_TAG_WIDTH){1'b0}},short_tag_in}), .BWEB('0),
    .Q(tag_temp_out)
  );
`endif

  always_ff @ (posedge clk) begin
    re_ff <= (en & ~rw);
    if (re_ff)
      ram_dout_ff <= ram_dout;
  end
  assign cc_short_tag_out = re_ff ? ram_dout : ram_dout_ff;

endmodule // }}}

//==========================================================
// lru_ram
// Dual-port LRU rams (read and write LRU bits in a single cycle) {{{
module cache_lru_ram
  import pygmy_cfg::*;
  import pygmy_typedef::*;
(
  input  bank_index_t raddr, waddr,
  input  logic        re, we,
  output logic        ready,
  input  lru_t        lru_din,
  output lru_t        lru_dout,
  // debug access
  input   logic             debug_en, debug_rw,
  input   bank_index_t      debug_addr,
  input   lru_t             debug_din,
  output  cpu_data_t        debug_dout,
  output  logic             debug_ready,

  input  logic        pwr_down, slp, rstn, clk
);
  assign ready = '1; // LRU bits is always on for now (never sleep)

  assign debug_dout = {{($bits(cpu_data_t)-$bits(lru_t)){1'b0}}, lru_dout};
  assign debug_ready = '1;

  logic         ram_re, ram_we;
  bank_index_t  ram_raddr, ram_waddr;
  lru_t         ram_din;

  assign  ram_re = debug_en ? (debug_en & ~debug_rw) : re;
  assign  ram_raddr = debug_en ? debug_addr : raddr;
  assign  ram_we = debug_en ? (debug_en & debug_rw) : we;
  assign  ram_waddr = debug_en ? debug_addr : waddr;
  assign  ram_din = debug_en ? debug_din : lru_din;

  lru_t ram_dout, ram_dout_ff;
  logic ram_re_ff;
  logic [9:0] ram_dout_temp;

`ifndef FPGA
//   TS6N28HPCPHVTA512X7M8FSO SRAM(
// This mem type has two clock ports which is confusing
//  TS6N28HPCPLVTA512X7M8FSO SRAM(
// This mem type has only one clock port
TSDN28HPCPUHDB512X10M4MW SRAM(
    // port A (read only)
    .AA(ram_raddr),
	.DA('0),
	.BWEBA('1),
    .WEBA('1),
	.CEBA(~ram_re),
    .QA(ram_dout_temp),
    // port B (write only)
    .AB(ram_waddr),
    .DB({{(10-$bits(ram_din)){1'b0}},ram_din}),
	.BWEBB('0),
    .WEBB('0),
	.CEBB(~ram_we),
	.QB(),			// unused
    .CLK(clk),
    // common
   	.RTSEL(2'b0),
    .WTSEL(2'b0),
    .PTSEL(2'b0)
    //.SLP(slp),
    //.SD(pwr_down)
  );
  assign ram_dout = ram_dout_temp[$bits(ram_dout)-1:0];
`else
  xilinx_2prf #(.BYTE_WIDTH(7), .WIDTH(7), .DEPTH(512)) SRAM(
    // write port
    .AA(ram_waddr),
    .D(ram_din),
    .BWEB('0),
    .WEB(~ram_we),
    .CLKW(clk),
    // read port
    .AB(ram_raddr),
    .REB(~ram_re),
    .CLKR(clk),
    .Q(ram_dout),
    // common
    .SLP(slp),
    .SD(pwr_down)
  );
`endif
  always_ff @ (posedge clk) begin
    ram_re_ff <= ram_re;
  end

  always_ff @ (posedge clk) begin
	if(~rstn)
	  ram_dout_ff <= '0;
    else if (ram_re_ff)
      ram_dout_ff <= ram_dout;
  end

  assign lru_dout = ram_re_ff ? ram_dout : ram_dout_ff;

endmodule // }}}
