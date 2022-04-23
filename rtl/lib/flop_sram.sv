// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __FLOP_SRAM_SV__
`define __FLOP_SRAM_SV__

module flop_sram_1rw
`ifndef SYNTHESIS
  // import ours_logging::*;
`endif
#(
  parameter WIDTH=64,
  parameter DEPTH=32,
  parameter WITH_MASK=1,  // bit mask
  parameter WITH_SD=1,    // shutdown
  parameter WITH_SLP=1,   // sleep
  parameter SRAM_BEH=0    // try to mimic the real SRAM's behavior
) (
//spyglass disable_block W240 BWEB
//spyglass disable_block W240 SD
//spyglass disable_block W240 SLP
  output  logic [WIDTH-1:0]         Q,
  input   [WIDTH-1:0]         D, BWEB,
  input   [$clog2(DEPTH)-1:0] A,
  input                       CEB, WEB,
                              SD, SLP,
                              CLK
//spyglass enable_block W240 BWEB
//spyglass enable_block W240 SD
//spyglass enable_block W240 SLP
);

  logic   [WIDTH-1:0] MEMORY  [DEPTH-1:0];
  logic               shutdown, sleep;

  logic clkg;

  icg icg_u(
    .en       (~CEB),
    .tst_en   (1'b0),
    .clk      (CLK), //ICG input
    .clkg     (clkg)
  );


  //spyglass disable_block W528
  generate
    if (WITH_SD) begin: with_shutdown
      assign shutdown = SD;
    end else begin: without_shutdown
      assign shutdown = '0;
    end

    if (WITH_SLP) begin: with_sleep
      assign sleep = SLP;
    end else begin: without_sleep
      assign sleep = '0;
    end
  endgenerate
  //spyglass enable_block W528

  generate
    if (WITH_MASK) begin: with_mask
      always @ (posedge clkg) begin
        if (~CEB) begin
          if (~WEB) begin
            // write
            for (int i=0; i<WIDTH; i++) begin
              if (~BWEB[i]) begin
                MEMORY[A][i] <= D[i];
              end
            end
            // `olog_info("FLOP-SRAM", $sformatf("%m: write addr=%h data=%h mask=%h", A, D, ~BWEB));
`ifndef SYNTHESIS
            if (SRAM_BEH) begin
              Q <= 'x;
            end
`endif
          end else begin
            // read
            Q <= MEMORY[A];
            // #1; `olog_info("FLOP-SRAM", $sformatf("%m: read addr=%h data=%h", A, Q));
          end
        end else begin
`ifndef SYNTHESIS
          if (SRAM_BEH) begin
            Q <= 'x;
          end
`endif
        end
    
`ifndef SYNTHESIS
        if (shutdown | sleep) begin
          Q <= 'x;
        end
        if (shutdown) begin
          set_all_x;
        end
`endif
      end
    end else begin: without_mask
      always @ (posedge clkg) begin
        if (~CEB) begin
          if (~WEB) begin
            // write
            MEMORY[A] <= D;
`ifndef SYNTHESIS
            if (SRAM_BEH) begin
              Q <= 'x;
            end
`endif
          end else begin
            // read
            Q <= MEMORY[A];
            // #1; `olog_info("FLOP-SRAM", $sformatf("%m: read addr=%h data=%h", A, Q));
          end
        end else begin
`ifndef SYNTHESIS
          if (SRAM_BEH) begin
            Q <= 'x;
          end
`endif
        end
    
`ifndef SYNTHESIS
        if (shutdown | sleep) begin
          Q <= 'x;
        end
        if (shutdown) begin
          set_all_x;
        end
`endif
      end

    end
  endgenerate

`ifndef SYNTHESIS
  initial begin
    //`olog_info("FLOP-SRAM", $sformatf("%m: WIDTH=%0d DEPTH=%0d WITH_MASK=%0d WITH_SD=%0d WITH_SLP=%0d", WIDTH, DEPTH, WITH_MASK, WITH_SD, WITH_SLP));
  end
  task set_value;
    input bit_value;
    for (int i=0; i<$size(MEMORY,1); i++)
      for (int j=0; j<$size(MEMORY,2); j++)
        MEMORY[i][j] = bit_value;
  endtask

  task set_all_zero;
    // `olog_info("FLOP-SRAM", $sformatf("%m: set_all_zero"));
    MEMORY = '{default:'0};
  endtask

  task set_all_one;
    // `olog_info("FLOP-SRAM", $sformatf("%m: set_all_one"));
    MEMORY = '{default:'1};
  endtask

  task set_all_x;
    // `olog_info("FLOP-SRAM", $sformatf("%m: set_all_x"));
    MEMORY = '{default:'x};
  endtask

  task random_all;
    // `olog_info("FLOP-SRAM", $sformatf("%m: random_all"));
    for (int i=0; i<$size(MEMORY,1); i++)
      for (int j=0; j<$size(MEMORY,2); j++)
        MEMORY[i][j] = $urandom();
  endtask
`endif

endmodule

module flop_sram_1r1w
#(
  parameter WIDTH=64,
  parameter DEPTH=32,
  parameter WITH_MASK=1,  // bit mask
  parameter WITH_SD=1,    // shutdown
  parameter WITH_SLP=1    // sleep
) (
  output  logic [WIDTH-1:0]   Q,
  input   [WIDTH-1:0]         D, BWEB, //spyglass disable W240
  input   [$clog2(DEPTH)-1:0] AA, AB,
  //spyglass disable_block W240
  input                       REB, WEB,
                              SD, SLP,
                              CLKW, CLKR
  //spyglass enable_block W240
);

  logic   [WIDTH-1:0] MEMORY  [DEPTH-1:0];
  logic               shutdown, sleep;

  generate
    if (WITH_SD) begin: with_shutdown
      assign shutdown = SD;
    end else begin: without_shutdown
      assign shutdown = '0; //spyglass disable W528
    end

    if (WITH_SLP) begin: with_sleep
      assign sleep = SLP;
    end else begin: without_sleep
      assign sleep = '0; //spyglass disable W528
    end
  endgenerate

  generate 
    if (WITH_MASK) begin: with_mask
      always @ (posedge CLKW) begin
        if (~WEB) begin
          // write
          for (int i=0; i<WIDTH; i++) begin
            if (~BWEB[i]) begin
              MEMORY[AA][i] <= D[i];
            end
          end
        end
    
`ifndef SYNTHESIS
        if (shutdown) begin
          set_all_x;
        end
`endif
      end
    end else begin: without_mask
      always @ (posedge CLKW) begin
        if (~WEB) begin
          MEMORY[AA] <= D;
        end
    
`ifndef SYNTHESIS
        if (shutdown) begin
          set_all_x;
        end
`endif
      end
    end
  endgenerate

  always @ (posedge CLKR) begin
    if (~REB) begin
      // read
      Q <= MEMORY[AB];
    end

`ifndef SYNTHESIS
    if (shutdown | sleep) begin
      Q <= 'x;
    end
`endif
  end

`ifndef SYNTHESIS
  task set_value;
    input bit_value;
    for (int i=0; i<$size(MEMORY,1); i++)
      for (int j=0; j<$size(MEMORY,2); j++)
        MEMORY[i][j] = bit_value;
  endtask

  task set_all_zero;
    MEMORY = '{default:'0};
  endtask

  task set_all_one;
    MEMORY = '{default:'1};
  endtask

  task set_all_x;
    MEMORY = '{default:'x};
  endtask

  task random_all;
    for (int i=0; i<$size(MEMORY,1); i++)
      for (int j=0; j<$size(MEMORY,2); j++)
        MEMORY[i][j] = $urandom();
  endtask
`endif
endmodule

`endif
