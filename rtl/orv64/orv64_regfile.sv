// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

module orv64_regfile
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
  //input               da2rf,
  //output              rf2da,
  input               rst, clk
);

`ifndef SYNTHESIS
  // import ours_logging::*;

  initial begin
    if ( (2 ** (ADDR_MSB - ADDR_LSB + 1)) < DEPTH )
      `olog_fatal("ORV_REGFILE", $sformatf("DEPTH=%d ADDR_LSB=%d ADDR_MSB=%d\n", DEPTH, ADDR_LSB, ADDR_MSB));
    if ( (DEPTH_MSB - DEPTH_LSB + 1) != DEPTH )
      `olog_fatal("ORV_REGFILE", $sformatf("DEPTH=%d DEPTH_MSB=%d DEPTH_LSB=%d\n", DEPTH, DEPTH_MSB, DEPTH_LSB));
  end

  generate
    for (genvar i=1; i<=N_READ_PORT; i++) begin: chk_read_port
      re_not_x: assert property (@(posedge clk) disable iff (rst !== '0) !$isunknown(re[i]))
        else `olog_fatal("ORV_REGFILE_RE_X", $sformatf("%m: read enable (%d) is x", i));
      ra_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (re[i] |-> (!$isunknown(ra[i]))))
        else `olog_fatal("ORV_REGFILE_RA_X", $sformatf("%m: read address (%h) is x", ra[i]));
    end

    for (genvar i=1; i<=N_WRITE_PORT; i++) begin: chk_write_port
      we_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (!$isunknown(we[i])))
        else `olog_fatal("ORV_REGFILE_WE_X", $sformatf("%m: write enable (%d) is x", i));
      wa_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (we[i] |-> (!$isunknown(wa[i]))))
        else `olog_fatal("ORV_REGFILE_WA_X", $sformatf("%m: write address (%h) is x", wa[i]));
      wd_not_x: assert property (@(posedge clk) disable iff (rst !== '0) (we[i] |-> (!$isunknown(wd[i]))))
        else `olog_warning("ORV_REGFILE_WD_X", $sformatf("%m: write data (%h) is x", wd[i]));
    end

    for (genvar i=1; i<=N_WRITE_PORT-1; i++) begin: chk_write_addr_0
      for (genvar j=i+1; j<=N_WRITE_PORT; j++) begin: chk_write_addr_1
        wa_conflict: assert property (@(posedge clk) disable iff (rst !== '0) ((((we[i] === '1) & (we[j] === '1))) |-> (wa[i] !== wa[j])))
          else `olog_info("ORV_REGFILE_WA_CONFLICT", $sformatf("%m: concurrent writes to same reg addr, addr%h: %h, addr%h: %h", i, wa[i], j, wa[j]));
      end
    end
  endgenerate
`endif // SYNTHESIS

  logic [DEPTH_MSB:DEPTH_LSB] [WIDTH-1:0] regfile;

  //==========================================================
  // ICG {{{

  logic rclkg;
  logic [DEPTH_MSB:DEPTH_LSB] wclkg;
  logic [DEPTH_MSB:DEPTH_LSB] en_wclkg;
  logic [DEPTH_MSB:DEPTH_LSB] [WIDTH-1:0] reg_wdata;

  assign rclkg = clk;

  always_comb begin
    en_wclkg = '0;
    reg_wdata = regfile;
    for (int i=1; i<=N_WRITE_PORT; i++) begin
      if (we[i]) begin
        en_wclkg[wa[i]] = 1'b1;
        reg_wdata[wa[i]] = wd[i];
      end
    end
  end

  generate
    for (genvar ii=DEPTH_LSB;ii<=DEPTH_MSB;ii++) begin
      icg wr_rf_clk_u(
        .en       (en_wclkg[ii]),
        .tst_en   (1'b0),
        .clk      (clk), //ICG input
        .clkg     (wclkg[ii])
      );
    end
  endgenerate

  // }}}

  // write
  generate
    for (genvar ii=DEPTH_LSB; ii<=DEPTH_MSB; ii++) begin
      always @ (posedge wclkg[ii]) // not using always_ff so that TB can initialize regfile for some special testcases
        for (int i = 1; i <= N_WRITE_PORT; i++) begin
          if (en_wclkg[ii]) begin
            regfile[ii] <= reg_wdata[ii];
          end
        end
    end
  endgenerate

  // read
  logic [N_READ_PORT:1][ADDR_MSB:ADDR_LSB] ra_ff;
  always @ (posedge rclkg)
    for (int i = 1; i <= N_READ_PORT; i++) begin
      if (re[i]) begin
        ra_ff[i] <= ra[i];
      end
    end

  always_comb
    for (int i = 1; i <= N_READ_PORT; i++) begin
      rd[i] = regfile[ra_ff[i]];
    end

//  assign rf2da.reg_data = regfile[da2rf.reg_addr];

//   // It's OK to read the port that's been written. In ID it will get forwarding data anyway.
//   generate
//     for (genvar irp = 1; irp <= N_READ_PORT; irp++) begin
//       for (genvar iwp = 1; iwp <= N_WRITE_PORT; iwp++) begin
//         regfile_same_port_read_write: assert property (@(posedge clk) disable iff (rst != '0) ( (re[irp] & we[iwp]) |-> (ra_ff[irp] != wa[iwp]) ) ) else $warning("read_port=%d write_port=%d\n", irp, iwp);
//       end
//     end
//   endgenerate

endmodule
