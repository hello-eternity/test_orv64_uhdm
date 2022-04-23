`define SDLIB_CLOCKING          posedge clk     // synchronous reset
`define SDLIB_DELAY             

`define FLOP_MEM_WR_LATENCY     1
`define FLOP_MEM_RD_LATENCY     1

`define SRAM_MEM_WR_LATENCY     1
`define SRAM_MEM_RD_LATENCY     2

//==========================================================
// `define ORV_64
`define PYGMY_ES1Y 
`define STATION_VP_PKG__SV
//`define ORV_SUPPORT_MULDIV
`define ORV_BACKDOOR_INIT_TAG_RAM
//`define ORV_SUPPORT_FP
//`define ORV_SUPPORT_FP_DOUBLE
// `define ORV_VECTOR_EXT_IN_MASTER_CORE
//`define ORV_VECTOR_EXT
//`ifndef FPGA_SIM
 // `define USE_T28HPCP
//`else
`define FPGA
//`endif
`define VECTOR_GEN2
// `define ORV_SUPPORT_OURSBUS
// `define ORV_SUPPORT_MAGICMEM
// `define ORV_SUPPORT_UART
// `define ORV_SUPPORT_DMA
`define ORV_SYSBUS_USE_OURSRING_IF
//`define ORV_PRV_M
// `define ORV_PRV_MSU
