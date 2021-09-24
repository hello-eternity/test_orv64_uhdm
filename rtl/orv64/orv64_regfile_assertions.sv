// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.
 program orv64_regfile_assertions
   // sequences, properties, assertions for M go here
  import orv64_typedef_pkg::*;
  import orv64_param_pkg::*;
#(
  parameter WIDTH=64,
  parameter DEPTH=32,
  parameter N_READ_PORT=2,
  parameter N_WRITE_PORT=2,
  parameter ADDR_LSB=0,
  parameter ADDR_MSB=$clog2(DEPTH)-1,
  parameter DEPTH_LSB=0,
  parameter DEPTH_MSB=DEPTH-1
) (
  // read
  input   logic [N_READ_PORT:1]                       re,
  input   logic [N_READ_PORT:1] [ADDR_MSB:ADDR_LSB]   ra,
  output  logic [N_READ_PORT:1] [WIDTH-1:0]           rd,
  // write
  input   logic [N_WRITE_PORT:1]                      we,
  input   logic [N_WRITE_PORT:1] [ADDR_MSB:ADDR_LSB]  wa,
  input   logic [N_WRITE_PORT:1] [WIDTH-1:0]          wd,
  // else
  input               rst, clk
);

  import ours_logging::*;
  initial begin
    if ( (2 ** (ADDR_MSB - ADDR_LSB + 1)) < DEPTH )
      `olog_fatal("ORV_REGFILE", $sformatf("DEPTH=%d ADDR_LSB=%d ADDR_MSB=%d\n", DEPTH, ADDR_LSB, ADDR_MSB));
    if ( (DEPTH_MSB - DEPTH_LSB + 1) != DEPTH )
      `olog_fatal("ORV_REGFILE", $sformatf("DEPTH=%d DEPTH_MSB=%d DEPTH_LSB=%d\n", DEPTH, DEPTH_MSB, DEPTH_LSB));
  end

  generate
    for (genvar i=1; i<=N_READ_PORT; i++) begin: chk_read_port
      re_not_x: assert property (@(posedge clk) disable iff (rst !== '0) !$isunknown(re[i]))
        else `olog_fatal("ORV_REGFILE_RE_X", $sformatf("%m: read enable is x"));
      ra_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (re[i] |-> (!$isunknown(ra[i]))))
        else `olog_fatal("ORV_REGFILE_RA_X", $sformatf("%m: read address (%h) is x", ra[i]));
//       rd_not_x : assert property (@(posedge clk) disable iff (rst != '0) (re[i] |=> (!$isunknown(rd[i]))))
//         else `olog_info("ORV_REGFILE_RD_X", $sformatf("%m: read data (%h) is x (if this instruction is killed later, then it's OK)", rd[i]));
    end

    for (genvar i=1; i<=N_WRITE_PORT; i++) begin: chk_write_port
      we_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(we[i])))
        else `olog_fatal("ORV_REGFILE_WE_X", $sformatf("%m: write enable is x"));
      wa_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (we[i] |-> (!$isunknown(wa[i]))))
        else `olog_fatal("ORV_REGFILE_WA_X", $sformatf("%m: write address (%h) is x", wa[i]));
      wd_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (we[i] |-> (!$isunknown(wd[i]))))
        else `olog_warning("ORV_REGFILE_WD_X", $sformatf("%m: write data (%h) is x", wd[i]));
    end
  endgenerate


endprogram
