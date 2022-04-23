// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module cache_data_ram
  import pygmy_cfg::*;
  import pygmy_typedef::*;
(
  // cache controller side interface
  input   logic           cc_en,
  input   logic           cc_rw,
  input   bank_index_t    cc_bank_index,
//   input   cpu_offset_t    cc_offset,
  input   cpu_data_t      cc_din,
  input   cpu_byte_mask_t cc_byte_mask,

  output  logic           cc_ready,
  output  cpu_data_t      cc_dout,

  // memory controller side interface, no byte mask
  input   logic           mc_en,
  input   logic           mc_rw,
  input   bank_index_t    mc_bank_index,
//   input   cpu_offset_t    mc_offset,
  input   cpu_data_t      mc_din,

  output  logic           mc_ready,
  output  cpu_data_t      mc_dout,

  // debug access
  input   logic            debug_en, debug_rw,
  input   bank_index_t     debug_addr,
  input   mem_data_t       debug_din,
  input   cpu_byte_mask_t  debug_byte_mask,
  output  cpu_data_t       debug_dout,
  output  logic            debug_ready,

  // cfg
  input   logic           pwr_down, slp,
  input   logic           rst, clk
);
//   localparam int N_DATA_RAM_SPLIT = 8; // split vertically
  localparam int DATA_RAM_WIDTH = 256; // split horizontally

  logic [N_DATA_RAM_SPLIT-1:0]                        ram_split_en;
  logic [N_DATA_RAM_SPLIT-1:0]                        ram_split_rw;
  logic [N_DATA_RAM_SPLIT-1:0] [DATA_RAM_WIDTH-1:0]   ram_split_dout;

  logic [DATA_RAM_WIDTH-1:0]                          ram_split_din;
  logic [DATA_RAM_WIDTH/8-1:0]                        ram_split_byte_mask;
  logic [DATA_RAM_WIDTH-1:0]                          ram_split_bit_mask;

`ifndef FPGA
  logic [BANK_INDEX_WIDTH-$clog2(N_DATA_RAM_SPLIT)-1:0] ram_split_addr;
`else
  logic [BANK_INDEX_WIDTH-1:0]                          ram_split_addr;
`endif

`ifndef SYNTHESIS
  chk_debug_en: assert property (@ (posedge clk) disable iff (~rst !== 0) (debug_en |-> ((mc_en == '0) && (cc_en == '0)))) else $fatal("%m: debug_en is asserted when mc_en or cc_en is not 0");
`endif

  //==========================================================
  // SRAM
  always_comb begin
    mc_ready = '1;
    cc_ready = ~mc_en;
    debug_ready = ~mc_en & ~cc_en;

    // select input to each split
    for (int n=0; n<N_DATA_RAM_SPLIT; n++) begin
      ram_split_en[n] = ((mc_en & (mc_bank_index[$clog2(N_DATA_RAM_SPLIT)-1:0] == n))
        | (cc_en & (cc_bank_index[$clog2(N_DATA_RAM_SPLIT)-1:0] == n))
        | (debug_en & (debug_addr[$clog2(N_DATA_RAM_SPLIT)-1:0] == n)));

      ram_split_rw[n] = debug_en ? debug_rw : (mc_en ? mc_rw : cc_rw);
    end

    ram_split_din = debug_en ? {(DATA_RAM_WIDTH/MEM_DATA_WIDTH){debug_din}} : (mc_en ? mc_din : cc_din);

    ram_split_byte_mask = debug_en ? debug_byte_mask : (mc_en ? '1 : cc_byte_mask);
    // byte mask to bit mask
    for (int i=0; i<(DATA_RAM_WIDTH/8); i++)
      for (int j=0; j<8; j++)
        ram_split_bit_mask[i*8+j] = ram_split_byte_mask[i];

`ifndef FPGA
    ram_split_addr = ($bits(ram_split_addr))'((debug_en ? debug_addr : (mc_en ? mc_bank_index : cc_bank_index)) >> $clog2(N_DATA_RAM_SPLIT));
`else
    ram_split_addr = ($bits(ram_split_addr))'(debug_en ? debug_addr : (mc_en ? mc_bank_index : cc_bank_index));
`endif
  end

`ifndef SRAM_BEH
`ifndef FPGA
  generate
    for (genvar n=0; n<N_DATA_RAM_SPLIT; n++) begin: DATA_RAM_SPLIT
      TS1N28HPCPUHDHVTB128X256M1SWSO SRAM( // uhdspsram
      //TS1N28HPCPUHDSVTB128X256M1SWSO SRAM( // uhdspsram
        .SLP(slp),
        .SD(pwr_down),
        .RTSEL(2'b10),
        .WTSEL(2'b00),
        .CLK(clk),
        .CEB(~ram_split_en[n]),
        .WEB(~ram_split_rw[n]),
        .A(ram_split_addr),
        .D(ram_split_din),
        .BWEB(~ram_split_bit_mask),
        .Q(ram_split_dout[n])
      );
    end
  endgenerate
`else // FPGA {{{
  xilinx_spsram #(.BYTE_WIDTH(8), .WIDTH(256), .DEPTH(512)) SRAM(
    .SLP(slp),
    .SD(pwr_down),
//     .RTSEL(2'b10),
//     .WTSEL(2'b00),
    .CLK(clk),
    .CEB(~(|ram_split_en)),
    .WEB(~(|(ram_split_rw & ram_split_en))),
    .A(ram_split_addr),
    .D(ram_split_din),
    .BWEB(~ram_split_bit_mask),
    .Q(ram_split_dout[0])
  );
`endif // FPGA }}}
`else // SRAM_BEH
  generate
    for (genvar n=0; n<N_DATA_RAM_SPLIT; n++) begin: DATA_RAM_SPLIT
      sram_beh_spsram #(.DATA_WIDTH(DATA_RAM_WIDTH), .ADDR_WIDTH(BANK_INDEX_WIDTH-$clog2(N_DATA_RAM_SPLIT))) SRAM(
        .CLK(clk),
        .CEB(~ram_split_en[n]),
        .WEB(~ram_split_rw[n]),
        .A(ram_split_addr),
        .D(ram_split_din),
        .BWEB(~ram_split_bit_mask),
        .Q(ram_split_dout[n])
      );
    end
  endgenerate
`endif

  logic [N_DATA_RAM_SPLIT-1:0]  ram_split_en_ff;
  logic                         mc_en_ff;
  logic [DATA_RAM_WIDTH-1:0]    mc_dout_ff;
  cpu_data_t temp_out;
  always_ff @ (posedge clk) begin
    if (cc_en | mc_en | debug_en)
      ram_split_en_ff <= ram_split_en;

    mc_en_ff <= mc_en;
    if (mc_en_ff)
      mc_dout_ff <= mc_dout;
  end

`ifndef FPGA
  always_comb begin
    temp_out = ram_split_dout[0];
    for (int n=1; n<N_DATA_RAM_SPLIT; n++) begin
      if (ram_split_en_ff[n])
        temp_out = ram_split_dout[n];
    end
  end
`else
  assign temp_out = ram_split_dout[0];
`endif
  assign cc_dout = temp_out;
  assign mc_dout = mc_en_ff ? temp_out : mc_dout_ff;
  assign debug_dout = temp_out;

endmodule
