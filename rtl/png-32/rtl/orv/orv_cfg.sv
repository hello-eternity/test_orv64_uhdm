
//==========================================================
// for L2 Cache {{{


















// }}}







// i-cache








// d-cache








// DMA

// `let N_CYCLE_INT_MUL = 33
// `let N_CYCLE_INT_DIV = 33







// TCM


// REGFILE


`ifndef __ORV_CFG__SV__
`define __ORV_CFG__SV__

package orv_cfg;

  parameter int XLEN = 32;

  parameter N_DMA_CHNL = 4;
  parameter N_DMA_SIZE_BIT = 21;

  // Multicycle arithmetic unit completion cycles
  parameter N_CYCLE_INT_MUL = 1;
  parameter N_CYCLE_INT_DIV = 17;

  parameter N_CYCLE_INT_MUL_FPGA = 33;
  parameter N_CYCLE_INT_DIV_FPGA = 70;

  // constant
  parameter CONST_INST_NOP = 64'h00000013;

  // constant for integer
  parameter CONST_INT32_MIN = 32'h80000000;
  parameter CONST_INT32_MAX = 32'h7fffffff;
  parameter CONST_INT32U_MAX = 32'hffffffff;

  // constant for floating-points
  parameter CONST_FP_D_CANON_NAN  = {1'b0, {11{1'b1}}, 1'b1, 51'b0};
  parameter CONST_FP_D_POS_ZERO   = 64'b0;
  parameter CONST_FP_D_NEG_ZERO   = {1'b1, 63'b0};
  parameter CONST_FP_D_POS_INF    = {1'b0, {11{1'b1}}, 52'b0};
  parameter CONST_FP_D_NEG_INF    = {1'b1, {11{1'b1}}, 52'b0};

  parameter CONST_FP_S_CANON_NAN  = {1'b0, {8{1'b1}}, 1'b1, 22'b0};
  parameter CONST_FP_S_POS_ZERO   = 32'b0;
  parameter CONST_FP_S_NEG_ZERO   = {1'b1, 31'b0};
  parameter CONST_FP_S_POS_INF    = {1'b0, {8{1'b1}}, 23'b0};
  parameter CONST_FP_S_NEG_INF    = {1'b1, {8{1'b1}}, 23'b0};

  // parameter MAGICMEM_OURSBUS_ID   = 6'b10_0001;
  parameter MAGICMEM_FROMHOST_ADDR = 32'h0000_0010;
  parameter MAGICMEM_TOHOST_ADDR   = 32'h0000_0011;
  parameter MAGICMEM_START_ADDR    = 32'h0000_0020;
  parameter MAGICMEM_END_ADDR      = 32'h0000_002F;

  // TCM
  parameter N_TCM_BANKS       = 2;
  parameter TCM_DATA_WIDTH    = 256; // Shared tcm
  parameter TCM_MASK_WIDTH    = 32;
  parameter TCM_ADDR_WIDTH    = 8;
  parameter TCM_ADDR_OFFSET   = 5;
  parameter TCM_BANK_ID_WIDTH = 1;
  parameter TCM_BANK_ID_MSB   = 7;
  parameter TCM_BANK_ID_LSB   = 7;

  parameter ITCM_DATA_WIDTH = 256;
  parameter ITCM_ADDR_WIDTH = 13;
  parameter DTCM_DATA_WIDTH = 256;
  parameter DTCM_ADDR_WIDTH = 13;

  // Trace buffer
  parameter ITB_DATA_WIDTH = 32;
  parameter ITB_ADDR_OFFSET_WIDTH = 2;
  parameter ITB_ADDR_WIDTH = 5;

  // REGFILE
  parameter REG_ADDR_WIDTH = 5;

  // PMP
  parameter N_PMP_CFG_PARTS = 4;
  parameter N_PMP_CSR = 16;

  // ICACHE
  parameter N_ICACHE_WAY = 2;
  parameter ICACHE_LINE_WIDTH = 256;
  parameter ICACHE_OFFSET_WIDTH = 5;
  parameter ICACHE_OFFSET_LSB = 0;
  parameter ICACHE_OFFSET_MSB = 4;
  parameter ICACHE_INDEX_WIDTH = 7;
  parameter ICACHE_INDEX_LSB = 5;
  parameter ICACHE_INDEX_MSB = 11;
  parameter ICACHE_TAG_WIDTH = 20;
  parameter ICACHE_TAG_LSB = 12;
  parameter ICACHE_TAG_MSB = 31;

  // CSR
  parameter CSR_ADDR_RW_PRV_WIDTH = 4;
  parameter CSR_ADDR_RW_PRV_MSB = 11;
  parameter CSR_ADDR_RW_PRV_LSB = 8;
  parameter CSR_ADDR_CUT_WIDTH = 8;
  parameter CSR_ADDR_CUT_MSB = 7;
  parameter CSR_ADDR_CUT_LSB = 0;

endpackage

`endif
