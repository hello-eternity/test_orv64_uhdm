// ---------------------------------------------------------------------
//
//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2005 - 2016 SYNOPSYS, INC.
//                            ALL RIGHTS RESERVED
//
//  This software and the associated documentation are confidential and
//  proprietary to Synopsys, Inc.  Your use or disclosure of this
//  software is subject to the terms and conditions of a written
//  license agreement between you, or your company, and Synopsys, Inc.
//
// The entire notice above must be reproduced on all authorized copies.
//
//  ------------------------------------------------------------------------

// 
// Release version :  2.02a
// File Version     :        $Revision: #24 $ 
// Revision: $Id: //dwh/DW_ocb/DW_axi_x2h/amba_dev/src/DW_axi_x2h_cc_constants.v#24 $ 
//
// -------------------------------------------------------------------------

// ----------------------------------------
// parameters naming convention
// ----------------------------------------
// X2H_AXI_* : design parameters affecting the bridge AXI interface
// X2H_AHB_* : design parameters affection the bridge AHB interface 
// SIM_* : simulation parameters (do not affect HW)
// 
// ----------------------------------------------------
// design configuration parameters available in the cC
// ----------------------------------------------------


// Name:         USE_FOUNDATION
// Default:      true ([<functionof>])
// Values:       false (0), true (1)
// Enabled:      [<functionof> %item]
// 
// The component code utilizes DesignWare Foundation parts for optimal Synthesis QoR. Customers with only a DesignWare 
// license MUST use Foundation parts. Customers with only a Source license, CANNOT use Foundation parts. Customers with both 
// Source and DesignWare licenses have the option of using Foundation parts.
`define USE_FOUNDATION 1

// AXI INTERFACE SETUP


// Name:         X2H_AXI_INTERFACE_TYPE
// Default:      AXI3
// Values:       AXI3 (0), AXI4 (1)
// Enabled:      [<functionof> %item]
// 
// Select AXI Interface Type as AXI3 or AXI4. By default, the DW_axi_x2h supports the AXI3 interface.
`define X2H_AXI_INTERFACE_TYPE 0

//Creates a define for AXI3 Interface.

`define X2H_AXI3_INTERFACE

//Creates a define for AXI4 Interface.

// `define X2H_AXI4_INTERFACE


//Width of the AXI Lock bus.
//2 bits in AXI3 and 1 bit in AXI4

`define X2H_AXI_LTW 2


// Name:         X2H_AXI_ADDR_WIDTH
// Default:      32
// Values:       32, ..., 64
// 
// Read and write address bus width of the AXI system to which the bridge is attached as an AXI slave.
`define X2H_AXI_ADDR_WIDTH 40


// Name:         X2H_AXI_DATA_WIDTH
// Default:      32
// Values:       32 64 128 256
// 
// Read and write data bus width of the AXI system to which the bridge is attached as an AXI slave. 
//  
// Note: The data bus width for the AXI slave interface must be greater than or equal to that of the AHB master interface.
`define X2H_AXI_DATA_WIDTH 32


// Name:         X2H_AXI_ID_WIDTH
// Default:      16
// Values:       1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16
// 
// Width of read and write ID field of the AXI system to which the bridge is attached as an AXI slave. ID field enables a 
// master to issue separate, ordered transactions. For information on how the ID field is used in read and write transfers, 
// refer "Read Transfers from AXI to AHB" and "Write Transfers from AXI to AHB" sections in the DW_axi_x2h Databook.
`define X2H_AXI_ID_WIDTH 12


// Name:         X2H_AXI_BLW
// Default:      4
// Values:       4 5 6 7 8
// Enabled:      X2H_AXI_INTERFACE_TYPE==1
// 
// Select width of the AXI AWLEN and ARLEN burst count fields. If X2H_AXI_INTERFACE_TYPE = AXI3, then the value of the 
// X2H_AXI_BLW parameter is always 4.
`define X2H_AXI_BLW 4


// Name:         X2H_LOWPWR_HS_IF
// Default:      false
// Values:       false (0), true (1)
// 
// If true, the low-power handshaking interface (csysreq, csysack, and cactive signals) and associated control logic is 
// implemented. If false, no support for low-power handshaking interface is provided.
`define X2H_LOWPWR_HS_IF 1


// Name:         X2H_LOWPWR_NOPX_CNT
// Default:      0
// Values:       0, ..., 4294967295
// Enabled:      X2H_LOWPWR_HS_IF==1
// 
// Number of AXI clock cycles to wait before cactive signal de-asserts, when there are no pending transactions. Note that 
// if csysreq de-asserts while waiting for X2H_LOWPWR_NOPX_CNT number of cycles, cactive de-asserts immediately. If a new 
// transaction is initiated during the wait period, the counting will be halted, cactive does not de-assert, and the counting is 
// reinitiated when there are no pending transactions. This parameter is available only if X2H_LOWPWR_HS_IF is true.
`define X2H_LOWPWR_NOPX_CNT 32'd0

//Creates a define for enabling legacy low power interface

`define X2H_LOWPWR_NOPX_CNT_W 1

// Legacy low power interface selection

`define X2H_LOWPWR_LEGACY_IF 0

//Creates a define for enabling low power interface

`define X2H_HAS_LOWPWR_HS_IF

//Creates a define for enabling legacy low power interface

// `define X2H_HAS_LOWPWR_LEGACY_IF

//Creates a define for enabling legacy low power interface

`define X2H_AXI_LOW_POWER 0

//Creates a define for calculating the maximum number of pending read transactions

// Name:         X2H_MAX_PENDTRANS_READ
// Default:      4
// Values:       1, ..., 32
// Enabled:      X2H_LOWPWR_HS_IF == 1 ? X2H_LOWPWR_LEGACY_IF == 0 : 0
// 
// Maximum number of outstanding AXI read transactions; higher values allow more transactions to be active simultaneously, 
// but also increase gate count slightly. This parameter is available only if X2H_LOWPWR_HS_IF is true.
`define X2H_MAX_PENDTRANS_READ 4

//Creates a define for calculating the maximum number of pending write transactions

// Name:         X2H_MAX_PENDTRANS_WRITE
// Default:      4
// Values:       1, ..., 32
// Enabled:      X2H_LOWPWR_HS_IF == 1 ? X2H_LOWPWR_LEGACY_IF == 0 : 0
// 
// Maximum number of AXI write transactions that may be outstanding at any time; higher values allow more transactions to 
// be active simultaneously, but also increase gate count slightly. 
// This parameter is available only if X2H_LOWPWR_HS_IF is true.
`define X2H_MAX_PENDTRANS_WRITE 4

//Creates a define for calculating the width of the counter needed to 
//keep track of pending requests

`define X2H_CNT_PENDTRANS_READ_W 3

//Creates a define for calculating the width of the counter needed to 
//keep track of pending requests

`define X2H_CNT_PENDTRANS_WRITE_W 3



// Name:         X2H_WRITE_DATA_INTERLEAVING_DEPTH
// Default:      1
// Values:       1, 2
// Enabled:      0
// 
// Write data Interleaving Depth. Specifies the number of addresses that can be pending on the slave interface. Write 
// interleaving allows the slave interface to accept interleaved write data with different write address ID values. Currently set 
// to 1 and is not user-definable in this release.
`define X2H_WRITE_DATA_INTERLEAVING_DEPTH 1


// Name:         X2H_EXCLUSIVE_ACCESS_DEPTH
// Default:      0
// Values:       0, ..., 4
// Enabled:      0
// 
// Number of exclusive accesses supported. For more information, see "Atomic Accesses" in the DW_axi_x2h Databook. (The 
// current version of the design does not support any Exclusive Accesses).
`define X2H_EXCLUSIVE_ACCESS_DEPTH 0


// Name:         X2H_AXI_ENDIANNESS
// Default:      Little-Endian
// Values:       Little-Endian (0), Big-Endian (1)
// Enabled:      0
// 
// Data bus endianness of the AXI system to which the bridge is attached as an AXI slave. (The current version only 
// supports Little-Endian).
`define X2H_AXI_ENDIANNESS 0


// Clocking and FIFO setup


// Name:         X2H_CLK_MODE
// Default:      Two Asynchronous Clocks
// Values:       Two Asynchronous Clocks (0), Two Synchronous Clocks (1), Single 
//               Clock (2)
// 
// The bridge AXI slave interface is clocked by aclk. The bridge AHB master interface is clocked by mhclk. This parameter 
// specifies the relationship between aclk and mhclk, and also determines what the bridge does to sychronize between the two 
// domains. 
//  - 0: aclk and mhclk are different, and completely asynchronous 
//  - 1: aclk and mhclk are different, one is the multiple of the other 
//  - 2: aclk and mhclk will both be driven by the same clock signal 
// For more information on clocking modes, see the "Clock Adaptation" section in the DW_axi_x2h Databook.
`define X2H_CLK_MODE 0

// Internal define for simulation.

// `define X2H_CLK_MODE_2


// Name:         X2H_CMD_QUEUE_DEPTH
// Default:      4
// Values:       1 2 4 8 16 32
// 
// Number of locations in the Common Command (CMD) queue, which transfers AXI commands from the bridge AXI slave to the 
// bridge AHB master. For more information on the Write Data buffer, see the "AXI to AHB Common Command (CMD) Queue" and 
// "Configuring Buffer Depths" sections in the DW_axi_x2h Databook. Set only to 1 if the Clocking mode is set to Single clock.
`define X2H_CMD_QUEUE_DEPTH 4


// Name:         X2H_WRITE_BUFFER_DEPTH
// Default:      16
// Values:       1 2 4 8 16 32 64
// 
// Number of locations in the write data buffer, which transfers write data from the bridge AXI slave to the bridge AHB 
// master. For more information on the write data buffer, see the "Write Transfers from AXI to AHB" and "Configuring Buffer 
// Depths" sections in the DW_axi_x2h Databook. Set only to 1 if the Clocking mode is set to Single clock.
`define X2H_WRITE_BUFFER_DEPTH 64


// Name:         X2H_WRITE_RESP_BUFFER_DEPTH
// Default:      2
// Values:       1 2 4 8 16
// 
// Number of locations in the write response buffer which contain responses from the AHB Master indicating the AHB 
// completion of the AXI write transfer. For more information on the write response buffer, see the "Write Transfers from AXI to AHB" 
// and "Configuring Buffer Depths" sections in the DW_axi_x2h Databook. Set only to 1 if the Clocking mode is set to Single 
// clock.
`define X2H_WRITE_RESP_BUFFER_DEPTH 2


// Name:         X2H_READ_BUFFER_DEPTH
// Default:      8
// Values:       1 2 4 8 16 32
// 
// Number of locations in the read data buffer which transfers read data from the bridge AHB master to the bridge AXI 
// slave. For more information on the read data buffer, see the "Read Transfers from AXI to AHB" and "Configuring Buffer Depths" 
// sections in the DW_axi_x2h Databook.
`define X2H_READ_BUFFER_DEPTH 8




// AHB INTERFACE SETUP


// Name:         X2H_AHB_ADDR_WIDTH
// Default:      32
// Values:       32 64
// 
// Address bus width of the AHB system to which the bridge is attached as an AHB master.
`define X2H_AHB_ADDR_WIDTH 32


// Name:         X2H_AHB_DATA_WIDTH
// Default:      32
// Values:       32 64 128 256
// 
// Read and write data bus width of the AHB system to which the bridge is attached as an AHB master. For more information 
// on data bus widths, see the "Data Width Adaptation" section in the DW_axi_x2h Databook. 
//  
// NOTE: Data bus width for the AHB master interface must be less than or equal to that of the AXI slave interface.
`define X2H_AHB_DATA_WIDTH 32


// Name:         X2H_AHB_LITE
// Default:      false
// Values:       false (0), true (1)
// 
// Configure the bridge for AHB or AHB-Lite operation. 
//  - 0: AHB 
//  - 1: AHB-Lite 
// For more information, see the "AHB Lite" section in the DW_axi_x2h Databook.
`define X2H_AHB_LITE 0



// Name:         X2H_PASS_LOCK
// Default:      DO NOT Pass AXI Lock to AHB
// Values:       DO NOT Pass AXI Lock to AHB (0), Pass AXI Lock to AHB (1)
// Enabled:      X2H_AXI_INTERFACE_TYPE==0
// 
// Configures the bridge to lock the AHB when performing AXI locked access transfers; that is, to pass the LOCK signal from 
// the AXI to the AHB. 
//  
// For more information, see the "Locked AXI-to-AHB Transactions" section in the DW_axi_x2h Databook.
`define X2H_PASS_LOCK 0



// Name:         X2H_USE_DEFINED_ONLY
// Default:      Allow INCR
// Values:       Allow INCR (0), Prohibit INCR (1)
// 
// As an AHB Master, allows bridge to or prohibit its use of the undefined-length INCR burst (defined-length bursts INCR4, 
// INCR8, INCR16 are allowed in either case). 
//  
// For information on reads and writes of undefined length, see "Read Command Usage" and "Write Command Usage" sections in 
// the DW_axi_x2h Databook.
`define X2H_USE_DEFINED_ONLY 1



// Name:         X2H_AHB_BUFFER_POP_MODE
// Default:      Pipeline Both
// Values:       No Pipelining (0), Pipeline Interface AHB Paths (1), Pipeline 
//               Internal AHB Paths (2), Pipeline Both (3)
// 
// Puts in or leaves out pipeline stages, which ease critical timing paths in the AHB clock domain. 
//  - 0: No pipelining - Omits pipelining and decreases area but increases difficulty of meeting synthesis timing 
//  constraints.  
//  - 1: Pipeline Interface AHB Paths - Adds pipelining to ease timing constraints between the AHB bus signals and 
//  internal FIFOs.  
//  - 2: Pipeline Internal AHB Paths - Adds pipelining to ease timing constraints between internal register-to-register 
//  paths.  
//  - 3: Pipeline both - Adds pipelining for both interface and internal AHB constraints.
`define X2H_AHB_BUFFER_POP_MODE 3



// Name:         X2H_AHB_ENDIANNESS
// Default:      Little-Endian
// Values:       Little-Endian (0), Big-Endian (1)
// Enabled:      0
// 
// Data bus endian mode of the AHB system to which the bridge is attached as an AHB master. 
// (The current version only supports Little-Endian)
`define X2H_AHB_ENDIANNESS 0





// -------------------------------------
// simulation parameters available in cC
// -------------------------------------

//This is a testbench parameter. The design does not depend on this
//parameter. This parameter specifies the clock period of the primary 
//AXI system (also called AXI system "A") used in the testbench to drive
//the Bridge slave interface. 

`define SIM_A_CLK_PERIOD 100

//This is a testbench parameter. The design does not depend from this
//parameter. This parameter specifies the clock period of the secondary 
//AHB system (also called AHB system "B") used in the testbench to drive
//the Bridge master interface. 

`define SIM_B_CLK_PERIOD 100

// --------------------------------------------------------
// simulation parameters available in cC but not in the GUI
// (used for regressions)
// do not change !
// --------------------------------------------------------

// the number of random sequences for each master to be generated in random test.
// This is a parameter for regressions. Set to 10 for short simulations. 50 is for
// medium simulations (2-3 min). 500 for long simulations (~30 min). 5000 for extra long.

`define SIM_NUM_SEQUENCES 50

// this enables tests to produce additional dump files with information about the 
// random transfers generated, the addresses values observed on the bus etc.

`define SIM_DEBUG_LEVEL 0

// this enables tests to use a variable seed (related with the OS time) to 
// initialize random generators.

`define SIM_USE_VARIABLE_SEED 0

// bus default master

`define SIM_B_DEF_MASTER 0

// ------------------------------------------
// simulation constants used in the testbench
// do not change !
// ------------------------------------------

// clock cycles in a time tick
`define SIM_A_TTICK_CLK_CYCLES 100000
`define SIM_B_TTICK_CLK_CYCLES 51

// primary bus memory map
`define SIM_A_START_ADDR_S1 32'h10000000  /* slave A1 */
`define SIM_A_END_ADDR_S1   32'h1fffffff
`define SIM_A_START_ADDR_S2 32'h20000000  /* bridge A->B */
`define SIM_A_END_ADDR_S2   32'h2fffffff
`define SIM_A_START_ADDR_S3 32'h30000000  /* slave A3 */
`define SIM_A_END_ADDR_S3   32'h3fffffff

// secondary bus memory map
`define SIM_B_START_ADDR_S1 32'h20000000  /* slave B1 */
`define SIM_B_END_ADDR_S1   32'h27ffffff
`define SIM_B_START_ADDR_S3 32'h28000000  /* slave B3 */
`define SIM_B_END_ADDR_S3   32'h2fffffff
`define SIM_B_START_ADDR_S2 32'h30000000  /* bridge A->B */
`define SIM_B_END_ADDR_S2   32'h3fffffff


//----------------------------------------------
// used for the axi to ahb bridge
//----------------------------------------------


`define X2H_SYNC_MODE 2
                        // used only when async clks are used


//----------------------------------------------
// used for the axi to ahb bridge
//----------------------------------------------

// This sets the number of transactions the random test will run

`define AXI_TEST_RAND_XACTNS 200

//----------------------------------------------
// used for the axi to ahb bridge
//----------------------------------------------

// used to allow random generation of default signal levels
// in the regression tests 
// bit 0 for default for RREADY
// bit 1                 BREADY
// 3:2   WSTRB inactive
//   0   low
//   1   prev
//   2   hign

`define AXI_TEST_INACTIVE_SIGNALS 2

/*****************************************/
/*                                       */
/*          BUS DEFINES                  */
/*                                       */
/*****************************************/

`define  X2H_AHB_HTRANS_IDLE    2'b00
`define  X2H_AHB_HTRANS_BUSY    2'b01
`define  X2H_AHB_HTRANS_NONSEQ  2'b10
`define  X2H_AHB_HTRANS_SEQ     2'b11

`define  X2H_AHB_HBURST_SINGLE  3'b000
`define  X2H_AHB_HBURST_INCR    3'b001
`define  X2H_AHB_HBURST_WRAP4   3'b010
`define  X2H_AHB_HBURST_INCR4   3'b011
`define  X2H_AHB_HBURST_WRAP8   3'b100
`define  X2H_AHB_HBURST_INCR8   3'b101
`define  X2H_AHB_HBURST_WRAP16  3'b110
`define  X2H_AHB_HBURST_INCR16  3'b111

`define  X2H_AMBA_SIZE_1BYTE    3'b000
`define  X2H_AMBA_SIZE_2BYTE    3'b001
`define  X2H_AMBA_SIZE_4BYTE    3'b010
`define  X2H_AMBA_SIZE_8BYTE    3'b011
`define  X2H_AMBA_SIZE_16BYTE   3'b100
`define  X2H_AMBA_SIZE_32BYTE   3'b101
`define  X2H_AMBA_SIZE_64BYTE   3'b110

`define  X2H_AXI_BURST_FIXED     2'b00
`define  X2H_AXI_BURST_INCR      2'b01
`define  X2H_AXI_BURST_WRAP      2'b10
`define  X2H_AXI_BURST_RESERVED  2'b11

`define  X2H_AXI_RESP_OKAY       2'b00
`define  X2H_AXI_RESP_EXOKAY     2'b01
`define  X2H_AXI_RESP_SLVERR     2'b10
`define  X2H_AXI_RESP_DECERR     2'b11

`define  X2H_AHB_RESP_OKAY       2'b00
`define  X2H_AHB_RESP_ERROR      2'b01
`define  X2H_AHB_RESP_RETRY      2'b10
`define  X2H_AHB_RESP_SPLIT      2'b11

/*****************************************/
/*                                       */
/*          Derived Values               */
/*                                       */
/*****************************************/
// the following are "derived defines"
// the following will be derived from the X2H_CLK_MODE


`define X2H_AXI_WSTRB_WIDTH  `X2H_AXI_DATA_WIDTH/8
`define X2H_AHB_WSTRB_WIDTH  `X2H_AHB_DATA_WIDTH/8

`define X2H_AXI_WDFIFO_WIDTH  `X2H_AXI_DATA_WIDTH + `X2H_AXI_WSTRB_WIDTH + 1

// Supposed to be lesser of AXI, AHB ADDR widths

`define X2H_CMD_ADDR_WIDTH 32

`define X2H_CMD_QUEUE_WIDTH  `X2H_CMD_ADDR_WIDTH + `X2H_AXI_ID_WIDTH + `X2H_AXI_BLW + 12


`define X2H_ENCRYPT



`define RM_BCM05 0


`define RM_BCM06 0


`define RM_BCM07 0


`define RM_BCM21 0


`define RM_BCM57 0


`define X2H_PUSH_POP_SYNC_VAL 2


`define CMDQ_CW 3



`define CMDQ_EFF_DEPTH_S2 4


`define CMDQ_EFF_DEPTH 4

//Component has Clock Mode 2

// `define X2H_HAS_CLK_MODE_2


