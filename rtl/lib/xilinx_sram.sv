// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

`ifndef __XILINX_SRAM_SV__
`define __XILINX_SRAM_SV__

`ifdef FPGA

//`include "/work/tools/Xilinx/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv"

module xilinx_spsram #( // {{{
  parameter WIDTH=4,
  parameter DEPTH=64,
  parameter BYTE_WIDTH=8
) (
  input                         SLP, SD,
                                CLK, CEB, WEB,
  input   [WIDTH-1:0]           BWEB, D,
  input   [$clog2(DEPTH)-1:0]   A,
  output  [WIDTH-1:0]           Q
);

  localparam int N_BYTE = WIDTH / BYTE_WIDTH;

  logic [N_BYTE-1:0] write_byte_mask;

  always_comb begin
    for (int i=0; i<N_BYTE; i++) begin
      write_byte_mask[i] = ~BWEB[i*BYTE_WIDTH] & ~WEB;
    end
  end

`ifndef SYNTHESIS
//  import ours_logging::*;
//  generate
//    for (genvar i=0; i<N_BYTE; i++) begin: CHK
//      chk_bit_mask_0: assert property (@(posedge CLK) disable iff ((CEB | WEB) !== 0) (BWEB[i*BYTE_WIDTH] |-> &(BWEB[(i+1)*BYTE_WIDTH-1:i*BYTE_WIDTH]))) else `olog_fatal("XILINX_SRAM", $sformatf("BWEB=%b", BWEB));
//      chk_bit_mask_1: assert property (@(posedge CLK) disable iff ((CEB | WEB) !== 0) (~BWEB[i*BYTE_WIDTH] |-> ~(|(BWEB[(i+1)*BYTE_WIDTH-1:i*BYTE_WIDTH])))) else `olog_fatal("XILINX_SRAM", $sformatf("BWEB=%b", BWEB));
//    end
//  endgenerate

  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction
`endif // SYNTHESIS

  // xpm_memory_spram: Single Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_spram # (
    // Common module parameters
    .MEMORY_SIZE (WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (0), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (WIDTH), //positive integer
    .READ_DATA_WIDTH_A (WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (BYTE_WIDTH), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_A ("0"), //string
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .READ_LATENCY_A (1), //non-negative integer
    .WRITE_MODE_A ("read_first") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLK),
    .rsta (1'b0),
    .ena (~CEB),
    .regcea (1'b1),
    .wea (write_byte_mask),
    .addra (A),
    .dina (D),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    .douta (Q),
    .sbiterra (),
    .dbiterra ()
  );
  // End of xpm_memory_spram instance declaration
endmodule // }}}

module xilinx_spsram_bitmask #( // {{{
  parameter WIDTH=4,
  parameter DEPTH=64
) (
  input   logic                       SLP, SD,
                                      CLK, CEB, WEB,
  input   logic [WIDTH-1:0]           BWEB, D,
  input   logic [$clog2(DEPTH)-1:0]   A,
  output  logic [WIDTH-1:0]           Q
);

  localparam int REAL_WIDTH = WIDTH * 8;

  logic [WIDTH-1:0] write_byte_mask;
  assign write_byte_mask = ~BWEB & {(WIDTH){~WEB}};

  logic [REAL_WIDTH-1:0]  din, dout;
  always_comb begin
    for (int i=0; i<WIDTH; i++) begin
      for (int j=0; j<8; j++) begin
        din[i*8+j] = D[i];
      end
      Q[i] = dout[i*8];
    end
  end

`ifndef SYNTHESIS
//  import ours_logging::*;

  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction
`endif // SYNTHESIS

  // xpm_memory_spram: Single Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_spram # (
    // Common module parameters
    .MEMORY_SIZE (REAL_WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (0), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (REAL_WIDTH), //positive integer
    .READ_DATA_WIDTH_A (REAL_WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (8), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_A ("0"), //string
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .READ_LATENCY_A (1), //non-negative integer
    .WRITE_MODE_A ("read_first") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLK),
    .rsta (1'b0),
    .ena (~CEB),
    .regcea (1'b1),
    .wea (write_byte_mask),
    .addra (A),
    .dina (din),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    .douta (dout),
    .sbiterra (),
    .dbiterra ()
  );
  // End of xpm_memory_spram instance declaration
endmodule // }}}

module xilinx_2prf #( // {{{
  parameter WIDTH=32,
  parameter DEPTH=64,
  parameter BYTE_WIDTH=8
) (
  input                         SLP, SD,
                                CLKR, CLKW, WEB, REB,
  input   [WIDTH-1:0]           BWEB, D,
  input   [$clog2(DEPTH)-1:0]   AA, AB,
  output  [WIDTH-1:0]           Q
);

  localparam int N_BYTE = WIDTH / BYTE_WIDTH;

  logic [N_BYTE-1:0] write_byte_mask;

  always_comb begin
    for (int i=0; i<N_BYTE; i++) begin
      write_byte_mask[i] = ~BWEB[i*BYTE_WIDTH] & ~WEB;
    end
  end

  logic CEB;
  assign CEB = WEB & REB;

`ifndef SYNTHESIS
//  import ours_logging::*;
//  generate
//    for (genvar i=0; i<N_BYTE; i++) begin: CHK
//      chk_bit_mask_0: assert property (@(posedge CLKW) disable iff ((CEB | WEB) !== 0) (BWEB[i*BYTE_WIDTH] |-> &(BWEB[(i+1)*BYTE_WIDTH-1:i*BYTE_WIDTH]))) else `olog_fatal("XILINX_SRAM", $sformatf("BWEB=%b", BWEB));
//      chk_bit_mask_1: assert property (@(posedge CLKW) disable iff ((CEB | WEB) !== 0) (~BWEB[i*BYTE_WIDTH] |-> ~(|(BWEB[(i+1)*BYTE_WIDTH-1:i*BYTE_WIDTH])))) else `olog_fatal("XILINX_SRAM", $sformatf("BWEB=%b", BWEB));
//    end
//  endgenerate
`endif // SYNTHESIS

  // xpm_memory_sdpram: Simple Dual Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_sdpram # (
    // Common module parameters
    .MEMORY_SIZE (WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .CLOCKING_MODE ("common_clock"), //string; "common_clock", "independent_clock"
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (1), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .USE_EMBEDDED_CONSTRAINT (0), //integer: 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (BYTE_WIDTH), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    // Port B module parameters
    .READ_DATA_WIDTH_B (WIDTH), //positive integer
    .ADDR_WIDTH_B ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_B ("0"), //string
    .READ_LATENCY_B (1), //non-negative integer
    .WRITE_MODE_B ("no_change") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLKW),
    .ena (~CEB),
    .wea (write_byte_mask),
    .addra (AA),
    .dina (D),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    // Port B module ports
    .clkb (CLKR),
    .rstb (1'b0),
    .enb (~CEB),
    .regceb (1'b1),
    .addrb (AB),
    .doutb (Q),
    .sbiterrb (),
    .dbiterrb ()
  );
  // End of xpm_memory_sdpram instance declaration
endmodule // }}}

module xsram_1rw #( // {{{
  parameter WIDTH=4,
  parameter DEPTH=64
) (
  input                         SLP, SD,
                                CLK, CEB, WEB,
  input   [WIDTH-1:0]           BWEB, D,
  input   [$clog2(DEPTH)-1:0]   A,
  output  [WIDTH-1:0]           Q
);

`ifndef SYNTHESIS
  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction
`endif // ifndef SYNTHESIS

  // xpm_memory_spram: Single Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_spram # (
    // Common module parameters
    .MEMORY_SIZE (WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (0), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (WIDTH), //positive integer
    .READ_DATA_WIDTH_A (WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (WIDTH), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_A ("0"), //string
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .READ_LATENCY_A (1), //non-negative integer
    .WRITE_MODE_A ("read_first") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLK),
    .rsta (1'b0),
    .ena (~CEB),
    .regcea (1'b1),
    .wea ('1),
    .addra (A),
    .dina (D),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    .douta (Q),
    .sbiterra (),
    .dbiterra ()
  );
  // End of xpm_memory_spram instance declaration
endmodule // }}}

module xsram_1rw_bytemask #( // {{{
  parameter WIDTH=4,
  parameter DEPTH=64,
  parameter BYTE_WIDTH=8
) (
  input                         SLP, SD,
                                CLK, CEB, WEB,
  input   [WIDTH-1:0]           BWEB, D,
  input   [$clog2(DEPTH)-1:0]   A,
  output  [WIDTH-1:0]           Q
);

  localparam int N_BYTE = WIDTH / BYTE_WIDTH;

  logic [N_BYTE-1:0] write_byte_mask;

  always_comb begin
    for (int i=0; i<N_BYTE; i++) begin
      write_byte_mask[i] = ~BWEB[i*BYTE_WIDTH] & ~WEB;
    end
  end

`ifndef SYNTHESIS
  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction
`endif // ifndef SYNTHESIS

  // xpm_memory_spram: Single Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_spram # (
    // Common module parameters
    .MEMORY_SIZE (WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (0), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (WIDTH), //positive integer
    .READ_DATA_WIDTH_A (WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (BYTE_WIDTH), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_A ("0"), //string
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .READ_LATENCY_A (1), //non-negative integer
    .WRITE_MODE_A ("read_first") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLK),
    .rsta (1'b0),
    .ena (~CEB),
    .regcea (1'b1),
    .wea (write_byte_mask),
    .addra (A),
    .dina (D),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    .douta (Q),
    .sbiterra (),
    .dbiterra ()
  );
  // End of xpm_memory_spram instance declaration
endmodule // }}}

module xsram_1rw_bitmask #( // {{{
  parameter WIDTH=4,
  parameter DEPTH=64
) (
  input   logic                       SLP, SD,
                                      CLK, CEB, WEB,
  input   logic [WIDTH-1:0]           BWEB, D,
  input   logic [$clog2(DEPTH)-1:0]   A,
  output  logic [WIDTH-1:0]           Q
);

  localparam int REAL_WIDTH = WIDTH * 8;

  logic [WIDTH-1:0] write_byte_mask;
  assign write_byte_mask = ~BWEB & {(WIDTH){~WEB}};

  logic [REAL_WIDTH-1:0]  din, dout;
  always_comb begin
    for (int i=0; i<WIDTH; i++) begin
      for (int j=0; j<8; j++) begin
        din[i*8+j] = D[i];
      end
      Q[i] = dout[i*8];
    end
  end

`ifndef SYNTHESIS

  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction

`endif // ifndef SYNTHESIS

  // xpm_memory_spram: Single Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_spram # (
    // Common module parameters
    .MEMORY_SIZE (REAL_WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (0), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (REAL_WIDTH), //positive integer
    .READ_DATA_WIDTH_A (REAL_WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (8), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_A ("0"), //string
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .READ_LATENCY_A (1), //non-negative integer
    .WRITE_MODE_A ("read_first") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLK),
    .rsta (1'b0),
    .ena (~CEB),
    .regcea (1'b1),
    .wea (write_byte_mask),
    .addra (A),
    .dina (din),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    .douta (dout),
    .sbiterra (),
    .dbiterra ()
  );
  // End of xpm_memory_spram instance declaration
endmodule // }}}

module xsram_1r1w #( // {{{
  parameter WIDTH=32,
  parameter DEPTH=64
) (
  input                         SLP, SD,
                                CLKR, CLKW, WEB, REB,
  input   [WIDTH-1:0]           BWEB, D,
  input   [$clog2(DEPTH)-1:0]   AA, AB,
  output  [WIDTH-1:0]           Q
);

  logic CEB;
  assign CEB = WEB & REB;

`ifndef SYNTHESIS

  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction

`endif // SYNTHESIS

  // xpm_memory_sdpram: Simple Dual Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_sdpram # (
    // Common module parameters
    .MEMORY_SIZE (WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .CLOCKING_MODE ("common_clock"), //string; "common_clock", "independent_clock"
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (1), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .USE_EMBEDDED_CONSTRAINT (0), //integer: 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (WIDTH), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    // Port B module parameters
    .READ_DATA_WIDTH_B (WIDTH), //positive integer
    .ADDR_WIDTH_B ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_B ("0"), //string
    .READ_LATENCY_B (1), //non-negative integer
    .WRITE_MODE_B ("no_change") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLKW),
    .ena (~CEB),
    .wea ('1),
    .addra (AA),
    .dina (D),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    // Port B module ports
    .clkb (CLKR),
    .rstb (1'b0),
    .enb (~CEB),
    .regceb (1'b1),
    .addrb (AB),
    .doutb (Q),
    .sbiterrb (),
    .dbiterrb ()
  );
  // End of xpm_memory_sdpram instance declaration
endmodule // }}}

module xsram_1r1w_bytemask #( // {{{
  parameter WIDTH=32,
  parameter DEPTH=64,
  parameter BYTE_WIDTH=8
) (
  input                         SLP, SD,
                                CLKR, CLKW, WEB, REB,
  input   [WIDTH-1:0]           BWEB, D,
  input   [$clog2(DEPTH)-1:0]   AA, AB,
  output  [WIDTH-1:0]           Q
);

  localparam int N_BYTE = WIDTH / BYTE_WIDTH;

  logic [N_BYTE-1:0] write_byte_mask;

  always_comb begin
    for (int i=0; i<N_BYTE; i++) begin
      write_byte_mask[i] = ~BWEB[i*BYTE_WIDTH] & ~WEB;
    end
  end

  logic CEB;
  assign CEB = WEB & REB;

`ifndef SYNTHESIS

  function set_one();
    for (int i=0; i<DEPTH; i++)
      XPM.xpm_memory_base_inst.mem[i] = '1;
  endfunction

  function print;
    $display("%m");
    for (int i=0; i<DEPTH; i++)
      $display("%h", XPM.xpm_memory_base_inst.mem[i]);
  endfunction

`endif // SYNTHESIS

  // xpm_memory_sdpram: Simple Dual Port RAM
  // Xilinx Parameterized Macro, Version 2017.4
  xpm_memory_sdpram # (
    // Common module parameters
    .MEMORY_SIZE (WIDTH*DEPTH), //positive integer
    .MEMORY_PRIMITIVE ("auto"), //string; "auto", "distributed", "block" or "ultra";
    .CLOCKING_MODE ("common_clock"), //string; "common_clock", "independent_clock"
    .MEMORY_INIT_FILE ("none"), //string; "none" or "<filename>.mem"
    .MEMORY_INIT_PARAM ("" ), //string;
    .USE_MEM_INIT (1), //integer; 0,1
    .WAKEUP_TIME ("disable_sleep"), //string; "disable_sleep" or "use_sleep_pin"
    .MESSAGE_CONTROL (0), //integer; 0,1
    .ECC_MODE ("no_ecc"), //string; "no_ecc", "encode_only", "decode_only" or "both_encode_and_decode"
    .AUTO_SLEEP_TIME (0), //Do not Change
    .USE_EMBEDDED_CONSTRAINT (0), //integer: 0,1
    .MEMORY_OPTIMIZATION ("true"), //string; "true", "false"
    // Port A module parameters
    .WRITE_DATA_WIDTH_A (WIDTH), //positive integer
    .BYTE_WRITE_WIDTH_A (BYTE_WIDTH), //integer; 8, 9, or WRITE_DATA_WIDTH_A value
    .ADDR_WIDTH_A ($clog2(DEPTH)), //positive integer
    // Port B module parameters
    .READ_DATA_WIDTH_B (WIDTH), //positive integer
    .ADDR_WIDTH_B ($clog2(DEPTH)), //positive integer
    .READ_RESET_VALUE_B ("0"), //string
    .READ_LATENCY_B (1), //non-negative integer
    .WRITE_MODE_B ("no_change") //string; "write_first", "read_first", "no_change"
  ) XPM (
    // Common module ports
    .sleep (1'b0),
    // Port A module ports
    .clka (CLKW),
    .ena (~CEB),
    .wea (write_byte_mask),
    .addra (AA),
    .dina (D),
    .injectsbiterra (1'b0),
    .injectdbiterra (1'b0),
    // Port B module ports
    .clkb (CLKR),
    .rstb (1'b0),
    .enb (~CEB),
    .regceb (1'b1),
    .addrb (AB),
    .doutb (Q),
    .sbiterrb (),
    .dbiterrb ()
  );
  // End of xpm_memory_sdpram instance declaration
endmodule // }}}

`endif // ifdef FPGA

`endif
