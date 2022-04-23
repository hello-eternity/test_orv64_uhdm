// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_mem_model
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
#(
  parameter int DATA_WIDTH=64
) (
  input   [63:0]  pc,
  input           inst_re,
  output  [31:0]  inst,
  output          inst_miss,
  //------------------------------------------------------
  input   [63:0]              data_raddr,
  input                       data_re,
  output                      data_rmiss,
  output  [DATA_WIDTH-1:0]    data_rdata,
  //------------------------------------------------------
  input   [63:0]              data_waddr,
  input   [DATA_WIDTH-1:0]    data_wdata,
  input   [DATA_WIDTH/8-1:0]  data_wmask,
  input                       data_we,
  output                      data_wmiss,
  //------------------------------------------------------
  input   [63:0]  rst_pc,
  input           rst, clk
);

  if (DATA_WIDTH % 32 != 0)
    $error("DATA_WIDTH (%d) must be multiple of 32", DATA_WIDTH);

  localparam N_32 = DATA_WIDTH / 32;

  if2ic_t     if2ic;
  ic2if_t     ic2if;
  ex2dc_t     ex2dc;
  dc2ma_t     dc2ma;
  assign  if2ic.pc = pc;
  assign  if2ic.en = inst_re;
  assign  inst = ic2if.inst;
  assign  inst_miss = ic2if.miss;
  assign  ex2dc.raddr = data_raddr;
  assign  ex2dc.re = data_re;
  assign  data_rdata = dc2ma.rdata;
  assign  data_rmiss = dc2ma.rmiss;
  assign  ex2dc.waddr = data_waddr;
  assign  ex2dc.wdata = data_wdata;
  assign  ex2dc.wmask = data_wmask;
  assign  ex2dc.we = data_we;
  assign  data_wmiss = dc2ma.wmiss;

  import orv64_param_pkg::*;

  mem_pc_not_aligned: assert property (@(posedge clk) if2ic.en |-> (if2ic.pc[1:0] == 2'b00)) else $display("@%t: PC=%h", $time, if2ic.pc);
  mem_waddr_not_aligned: assert property (@(posedge clk) ex2dc.we |-> (ex2dc.waddr[2:0] == 3'b000)) else $display("@%t: waddr=%h", $time, ex2dc.waddr);
  mem_raddr_not_aligned:assert property (@(posedge clk) ex2dc.re |-> (ex2dc.raddr[2:0] == 3'b000)) else $display("@%t: raddr=%h", $time, ex2dc.raddr);

  localparam NUM_ENTRY = 2 ** 16;
  `ifndef SMOKE
  bit [31:0] array_data[bit [39:0]]; // associated array
  `else
  bit [31:0] array_data[NUM_ENTRY];
  `endif

  //==========================================================
  // read inst

  // address
  logic [39:0]  icache_raddr; // addr used to read from icache
  assign icache_raddr = if2ic.pc[63:2];

  // read icache
  inst_t inst_read; // inst read from icache
  always @ (posedge clk) begin
    if (if2ic.en) begin
      inst_read <= array_data[icache_raddr];
    end else begin
      inst_read <= 32'bx;
    end
  end
  assign ic2if.inst = ic2if.miss ? 32'bx : inst_read;

  // icache miss
  bit is_inst_miss;
  int unsigned inst_miss_cycle;

  `ifdef ORV_RANDOM_ICACHE_MISS
  always @ (posedge clk) begin
    if (rst) begin
      is_inst_miss = 1'b1;
      inst_miss_cycle = 3;
    end else if (if2ic.en) begin
      // random generate
      if (~ic2if.miss) begin
        is_inst_miss = 1'($urandom_range(1, 0));
        inst_miss_cycle = $urandom_range(10, 3);
      end else begin
        inst_miss_cycle --;
        if (inst_miss_cycle == 0)
          is_inst_miss = 1'b0;
      end
    end
    ic2if.miss <= is_inst_miss;
  end
  `else // ORV_RANDOM_ICACHE_MISS
  always @ (posedge clk) begin
    if (rst)
      ic2if.miss <= 1'b0;
    else if (if2ic.en) begin
      ic2if.miss <= 1'b0;
    end
  end
  `endif // ORV_RANDOM_ICACHE_MISS

  //==========================================================
  // read data

  // address
  logic [39:0]  dcache_raddr;
  assign dcache_raddr = {ex2dc.raddr[63:3], 1'b0};

  // read dcache
  logic [DATA_WIDTH-1:0] rdata;
  always @ (posedge clk) begin
    if (rst)
      rdata <= '0;
    else if (ex2dc.re) begin
      for (int i=0; i<N_32; i++)
        rdata[(i+1)*32-1 -: 32] <= array_data[dcache_raddr+i];
    end
  end
  assign dc2ma.rdata = dc2ma.rmiss ? 64'bx : rdata;

  // dcache rmiss
  bit is_data_rmiss;
  int unsigned data_rmiss_cycle;

  `ifdef ORV_RANDOM_DCACHE_READ_MISS
  always @ (posedge clk) begin
    if (rst) begin
      is_data_rmiss = 1'b0;
      data_rmiss_cycle = 0;
    end else if (ex2dc.re) begin
      if (~dc2ma.rmiss) begin
        is_data_rmiss = 1'($urandom_range(1, 0));
        data_rmiss_cycle = $urandom_range(10, 3);
      end else begin
        data_rmiss_cycle --;
        if (data_rmiss_cycle == 0)
          is_data_rmiss = 1'b0;
      end
    end
    dc2ma.rmiss <= is_data_rmiss;
  end
  `else // ORV_RANDOM_DCACHE_READ_MISS
  always @ (posedge clk) begin
    if (rst)
      dc2ma.rmiss <= 1'b0;
    else if (ex2dc.re) begin
      dc2ma.rmiss <= 1'b0;
    end
  end
  `endif // ORV_RANDOM_DCACHE_READ_MISS

  //==========================================================
  // write data

  // address
  logic [39:0]  dcache_waddr;
  assign dcache_waddr = {ex2dc.waddr[63:3], 1'b0};

  // write dcache
  bit [DATA_WIDTH-1:0] bit_mask, origin_data, origin_data_mask, write_data_mask, write_data;

  always_comb
    for (int i=0; i<(DATA_WIDTH/8); i++)
      for (int j=0; j<8; j++)
        bit_mask[i*8+j] = ex2dc.wmask[i];

  always @ (posedge clk) begin
    if (~rst & ex2dc.we) begin
      for (int i=0; i<N_32; i++)
        origin_data[(i+1)*32-1 -: 32] = array_data[dcache_waddr+i];
      origin_data_mask = origin_data & ~bit_mask;
      write_data_mask = ex2dc.wdata & bit_mask;
      write_data = write_data_mask | origin_data_mask;
      for (int i=0; i<N_32; i++)
        array_data[dcache_waddr+i] <= write_data[(i+1)*32-1 -: 32];
    end
  end

  // dcache wmiss
  bit is_data_wmiss;
  int unsigned data_wmiss_cycle;

  `ifdef ORV_RANDOM_DCACHE_WRITE_MISS
  always @ (posedge clk) begin
    if (rst) begin
      is_data_wmiss = 1'b0;
      data_wmiss_cycle = 0;
    end else if (ex2dc.we) begin
      if (~dc2ma.wmiss) begin
        is_data_wmiss = 1'($urandom_range(1, 0));
        data_wmiss_cycle = $urandom_range(10, 3);
      end else begin
        data_wmiss_cycle --;
        if (data_wmiss_cycle == 0)
          is_data_wmiss = 1'b0;
      end
    end
    dc2ma.wmiss <= is_data_wmiss;
  end
  `else // ORV_RANDOM_DCACHE_WRITE_MISS
  always @ (posedge clk) begin
    if (rst)
      dc2ma.wmiss <= 1'b0;
    else if (ex2dc.we) begin
      dc2ma.wmiss <= 1'b0;
    end
  end
  `endif // ORV_RANDOM_DCACHE_WRITE_MISS

endmodule
