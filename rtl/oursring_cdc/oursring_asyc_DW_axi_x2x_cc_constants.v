/*
------------------------------------------------------------------------
--
//  ------------------------------------------------------------------------
//
//                    (C) COPYRIGHT 2006 - 2016 SYNOPSYS, INC.
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
// Release version :  1.06a
// File Version     :        $Revision: #26 $ 
// Revision: $Id: //dwh/DW_ocb/DW_axi_x2x/amba_dev/src/DW_axi_x2x_cc_constants.v#26 $ 
--
-- File     : DW_axi_x2x_cc_constants.v
-- Abstract : Parameter File for DW_axi_x2x
--
------------------------------------------------------------------------
*/

// Use DesignWare Foundation parts by default for
// optimal Synthesis QoR. May be set to false (0) if you
// have an RTL source licence in which case you may
// use source code for DesignWare Foundation Parts without
// the need for a DesignWare Foundation licence. RTL source
// users, who also have a DesignWare Foundation key, may
// choose to retain the Foundation parts.
//
// For the BCM parts used in this design there is no
// difference between using foundation parts or not so
// we hardcode this value to 0.
//

`define USE_FOUNDATION 0



`define X2X_ENCRYPT

// Defines whether or not X2X will include debug logic.
// Debug logic is mostly generating versions of fifo control logic
// which can be used by the testbench for timing checks and
// functional coverage.

`define X2X_HAS_INC_DEBUG_LOGIC 0


// Define for whether or not to include debug logic.

// `define X2X_INC_DEBUG_LOGIC


// Defines the debug messaging level for the testbench log file.
// Enabling this parameter will result in verbose messaging being
// output to the testbench log file.

`define X2X_TB_DEBUG_LEVEL 0


// Use the initial blocks in each module where the
// module parameters are assigned to integer variables for
// viewing during debug.

`define USE_PARAM_VARS_PROC 1


// Defined if we want to use the param vars proc.

`define PARAM_VARS_PROC

// If this parameter is set to 1 the Verification Environment
// will use the seed specified by the X2X_SEED parameter.

`define X2X_USE_RANDOM_SEED 0

// User defined random seed.

`define X2X_SEED 32'h0


// Defined to disable parameters for unsupported features.

`define X2X_PARAM_LOCKDOWN 1


//Allows user to decide not to implement read channels for a write
//interleave fan-out only mode. Note only applies to *_s1 signals
//i.e. only slave port 1 will ever have read channels.
//
//Unsupported and not visible for this release.
//
//Only enabled if (X2X_HAS_WI_FAN_OUT==True)

`define X2X_CH_SEL 0



// Name:         X2X_MP_DW
// Default:      32
// Values:       8 16 32 64 128 256 512
// 
// Width of DW_axi_x2x Master Port data ports.
`define X2X_MP_DW 64


//The width of the Master Port write strobe bus

`define X2X_MP_SW 8


//Creates a define for when X2X_MP_DW is at it's maximum value.

// `define X2X_MP_DW_MAX


// Name:         X2X_MP_AW
// Default:      32
// Values:       32, ..., 64
// 
// Width of DW_axi_x2x Master Port Addresses.
`define X2X_MP_AW 40



// Name:         X2X_MP_IDW
// Default:      4
// Values:       1, ..., 16
// 
// Width of ID signal on the DW_axi_x2x Master Port.
`define X2X_MP_IDW 12



// Name:         X2X_MP_BLW
// Default:      4
// Values:       4 5 6 7 8
// 
// DW_axi_x2x master port burst length signal width.
`define X2X_MP_BLW 4



// Name:         X2X_SP_DW
// Default:      32
// Values:       8 16 32 64 128 256 512
// 
// Width of DW_axi_x2x Slave Port data ports.
`define X2X_SP_DW 64


//The width of the Slave Port write strobe bus

`define X2X_SP_SW 8



// Name:         X2X_SP_AW
// Default:      32
// Values:       32, ..., 64
// 
// Width of DW_axi_x2x Slave Port addresses.
`define X2X_SP_AW 40



// Name:         X2X_SP_IDW
// Default:      12 (X2X_MP_IDW)
// Values:       1, ..., 16
// 
// Width of ID signal on the DW_axi_x2x Slave Port. The width must be greater than or equal to Master Port ID width 
// (X2X_MP_IDW)
`define X2X_SP_IDW 12



// Name:         X2X_SP_BLW
// Default:      4 (X2X_MP_BLW)
// Values:       4 5 6 7 8
// Enabled:      0
// 
// DW_axi_x2x slave port burst length signal width. This parameter value is controlled by the X2X_MP_BLW parameter.
`define X2X_SP_BLW 4



// Name:         X2X_HAS_ET
// Default:      false
// Values:       false (0), true (1)
// 
// Configures the DW_axi_x2x for a byte-invariant endianness transformation on data and strobe signal contents.
`define X2X_HAS_ET 0



// Name:         X2X_AW_BUF_DEPTH
// Default:      4
// Values:       2, ..., 16
// 
// Depth of Write Address channel buffer.
`define X2X_AW_BUF_DEPTH 4



// Name:         X2X_AR_BUF_DEPTH
// Default:      4
// Values:       2, ..., 16
// 
// Depth of Read Address channel buffer.
`define X2X_AR_BUF_DEPTH 4



// Name:         X2X_W_BUF_DEPTH
// Default:      16
// Values:       2, ..., 32
// 
// Depth of Write Data channel buffer.
`define X2X_W_BUF_DEPTH 4



// Name:         X2X_B_BUF_DEPTH
// Default:      4
// Values:       2, ..., 16
// 
// Depth of Burst Response channel buffer.
`define X2X_B_BUF_DEPTH 4



// Name:         X2X_R_BUF_DEPTH
// Default:      16
// Values:       2, ..., 32
// 
// Depth of Read Data channel buffer.
`define X2X_R_BUF_DEPTH 4



// Name:         X2X_CLK_MODE
// Default:      Synchronous
// Values:       Synchronous (0), Asynchronous (1)
// 
// Selects whether DW_axi_x2x Slave Port clock and DW_axi_x2x Master Port clock are synchronous or asynchronous. This 
// parameter affects the implementation of the channel buffers and the existence of the ports aclk_s and aresetn_s.
`define X2X_CLK_MODE 1



// Name:         X2X_MP_SYNC_DEPTH
// Default:      2
// Values:       0 1 2 3
// Enabled:      X2X_CLK_MODE == 1
// 
// Number of synchronization register stages in the internal channel buffers for signals passing from DW_axi_x2x Slave Port 
// to DW_axi_x2x Master Port. 
//  - 0: No synchronization stages. 
//  - 1: Two-stage synchronization; first stage is negative edge and second stage is positive edge. 
//  - 2: Two-stage synchronization, both stages are positive edges. 
//  - 3: Three-stage synchronization, all stages are positive edges. 
// If one port has a synchronization depth of 0, the other port must also be 0. This parameter is enabled only if 
// (X2X_CLK_MODE==1).
`define X2X_MP_SYNC_DEPTH 2



// Name:         X2X_SP_SYNC_DEPTH
// Default:      2
// Values:       0 1 2 3
// Enabled:      X2X_CLK_MODE == 1
// 
// Number of synchronization register stages in the internal channel buffers for signals passing from DW_axi_x2x Master 
// Port to DW_axi_x2x Slave Port. 
//  - 0: No synchronization stages. 
//  - 1: Two-stage synchronization, first stage is negative edge and second stage is positive edge. 
//  - 2: Two-stage synchronization, both stages are positive edges. 
//  - 3: Three-stage synchronization, all stages are positive edges. 
// If one port has a synchronization depth of 0, the other port must also be 0. This parameter is enabled only if 
// (X2X_CLK_MODE==1).
`define X2X_SP_SYNC_DEPTH 2


// Name:         X2X_LOWPWR_HS_IF
// Default:      false
// Values:       false (0), true (1)
// 
// If True, the low-power handshaking interface (csysreq, csysack, and cactive signals) and associated control logic is 
// implemented. If False, no support for low-power handshaking interface is provided.
`define X2X_LOWPWR_HS_IF 0

//Creates a define for whether or not the low power handshaking interface
//exists.

// `define X2X_HAS_LOWPWR_HS_IF


// Name:         X2X_LOWPWR_NOPX_CNT
// Default:      0
// Values:       0, ..., 4294967295
// Enabled:      X2X_LOWPWR_HS_IF==1
// 
// Number of AXI clock cycles to wait before cactive signal de-asserts, when there are no pending transactions. 
// Note that if csysreq de-asserts while waiting this number of cycles, cactive de-asserts immediately. If a new 
// transaction is initiated during the wait period, the counting is halted, cactive does not de-assert, and the counting is 
// re-initiated when there are no pending transactions.
`define X2X_LOWPWR_NOPX_CNT 32'd0


// Log base 2 of X2X_LOWPWR_NOPX_CNT.
//

`define X2X_LOWPWR_NOPX_CNT_LOG2 1


// Log base 2 of X2X_LOWPWR_NOPX_CNT.
//

`define X2X_LOWPWR_NOPX_CNT_P1_LOG2 1



// Name:         X2X_MAX_URIDA
// Default:      4
// Values:       1, ..., 64
// Enabled:      (X2X_MP_DW != X2X_SP_DW) || (X2X_MP_BLW != X2X_SP_BLW) || 
//               X2X_HAS_ET || X2X_LOWPWR_HS_IF
// 
// Maximum number of unique read IDs for which DW_axi_x2x may have outstanding transactions for at any time. This parameter 
// also sets the read interleaving and read reordering depth of the DW_axi_x2x.
`define X2X_MAX_URIDA 4


//Log base 2 of X2X_MAX_URIDA.

`define X2X_LOG2_MAX_URIDA 2



// Name:         X2X_MAX_UWIDA
// Default:      4
// Values:       1, ..., 64
// Enabled:      (X2X_HAS_WI_FAN_OUT == 0) && ( (X2X_MP_DW != X2X_SP_DW) || 
//               (X2X_MP_BLW != X2X_SP_BLW) || X2X_HAS_ET || X2X_LOWPWR_HS_IF)
// 
// Maximum number of unique write IDs that the DW_axi_x2x may have outstanding transactions for at any time.
`define X2X_MAX_UWIDA 4



// Name:         X2X_MAX_RCA_ID
// Default:      4
// Values:       1, ..., 16
// Enabled:      (X2X_MP_DW != X2X_SP_DW) || (X2X_MP_BLW != X2X_SP_BLW) || 
//               X2X_HAS_ET || X2X_LOWPWR_HS_IF
// 
// Maximum number of read transactions that may be active for a particular ID value.
`define X2X_MAX_RCA_ID 4



// Name:         X2X_MAX_WCA_ID
// Default:      4
// Values:       1, ..., 16
// Enabled:      (X2X_MP_DW != X2X_SP_DW) || (X2X_MP_BLW != X2X_SP_BLW) || 
//               X2X_HAS_ET || X2X_HAS_WI_FAN_OUT || X2X_LOWPWR_HS_IF
// 
// Maximum number of write transactions that may be active for a particular ID value.
`define X2X_MAX_WCA_ID 4



// Name:         X2X_WID
// Default:      1
// Values:       1, ..., 8
// Enabled:      (X2X_MP_DW != X2X_SP_DW) || (X2X_MP_BLW != X2X_SP_BLW) || 
//               X2X_HAS_WI_FAN_OUT || X2X_HAS_ET
// 
// Write Interleave Depth. This parameter establishes the number of write data transactions for which an external master 
// can interleave write data. This parameter only applies to configurations with: 
//  - Data width altering 
//  - Burst length width altering 
//  - Endianness transformation 
//  - Write interleaving fan out 
// If none of these exist in the configuration then this parameter is disabled and the DW_axi_x2x supports an infinite 
// write interleaving depth.
`define X2X_WID 1


//Log base 2 of X2X_WID.

`define X2X_LOG2_WID 1


//Creates a define for when X2X_WID is greater than 1 and fan out
//is not enabled.

// `define X2X_WID_GRTR_1


//Creates a define for whether or not Write Interleave 2 exists.

// `define X2X_WI2


//Creates a define for whether or not Write Interleave 3 exists.

// `define X2X_WI3


//Creates a define for whether or not Write Interleave 4 exists.

// `define X2X_WI4


//Creates a define for whether or not Write Interleave 5 exists.

// `define X2X_WI5


//Creates a define for whether or not Write Interleave 6 exists.

// `define X2X_WI6


//Creates a define for whether or not Write Interleave 7 exists.

// `define X2X_WI7


//Creates a define for whether or not Write Interleave 8 exists.

// `define X2X_WI8


//If true and X2X_WID > 1 , X2X_WID write Interleaving channels will be
//created, each with an interleaving depth of 1. Otherwise there will be
//1 write interleaving channel with a write interleaving depth
//of X2X_WID.
//
//Unsupported and not visible for the current release.

`define X2X_HAS_WI_FAN_OUT 0


//Create a define for whether we support write interleaving fan out
//or not.

// `define X2X_WI_FAN_OUT


//Creates a define for whether or not bypass WI process.

`define X2X_WIP_BYPASS



// Name:         X2X_HAS_TX_UPSIZE
// Default:      false
// Values:       false (0), true (1)
// Enabled:      [ <functionof> X2X_MP_DW X2X_SP_DW X2X_MP_BLW ]
// 
// Configures the DW_axi_x2x to generate transactions of a larger X2X_SP_DW asize from a smaller X2X_MP_DW, wherever 
// possible. This parameter is enabled only if X2X_MP_DW is less than X2X_SP_DW and if the maximum number of bytes in a Master Port 
// transaction is greater than or equal to the byte width of the Slave Port data bus.
`define X2X_HAS_TX_UPSIZE 0


//Creates a define for whether we support tx upsizing or not.

// `define X2X_TX_UPSIZE



// Name:         X2X_UPSIZE_ANY_ASIZE
// Default:      true
// Values:       false (0), true (1)
// Enabled:      X2X_HAS_TX_UPSIZE == 1
// 
// Allows the DW_axi_x2x to attempt to upsize transactions of any ARSIZE or AWSIZE value from the primary bus. If this 
// parameter is False, the DW_axi_x2x only attempts to upsize transactions from the primary bus with a maximum ARSIZE or AWSIZE 
// value. This parameter is enabled only if X2X_HAS_TX_UPSIZE is equal to 1.
`define X2X_UPSIZE_ANY_ASIZE 1


//When set to true the X2X will include logic to handle lock sequences for
//data width altering configurations. If set to false the external master
//should not attempt to initiate locked sequences to the X2X.
//
//Unsupported and not visible for the current release.
//
//Disabled if (X2X_MP_DW == X2X_SP_DW)

`define X2X_HAS_LOCKING 0


//Creates a define for whether we support locking or not.

// `define X2X_LOCKING



// Name:         X2X_HAS_WRAP_BURST
// Default:      true
// Values:       false (0), true (1)
// Enabled:      (X2X_SP_DW != X2X_MP_DW) || (X2X_SP_BLW != X2X_MP_BLW)
// 
// When set to true, the DW_axi_x2x includes logic to handle wrapping bursts for data-width-altering configurations. If set 
// to False, the logic is removed and the user must not drive WRAP bursts. Removing this logic significantly improves the 
// operating frequency of DW_axi_x2x. This parameter is disabled if X2X_MP_DW is equal to X2X_SP_DW.
`define X2X_HAS_WRAP_BURST 1


//Creates a define for whether we support wrapping bursts or not.

`define X2X_WRAP_BURST



// Name:         X2X_HAS_PIPELINE
// Default:      false
// Values:       false (0), true (1)
// Enabled:      (X2X_MP_DW != X2X_SP_DW) | (X2X_HAS_ET == 1)
// 
// If set to true, the DW_axi_x2x includes a pipeline stage in the address channels. This allows the DW_axi_x2x to be 
// synthesized to higher clock frequencies at the cost of one extra cycle of latency through the address channels. If set to 
// False, the pipeline stage is removed.
`define X2X_HAS_PIPELINE 0


//Creates a define for whether we support pipeline or not.

// `define X2X_PL




// Name:         X2X_HAS_TZ_SUPPORT
// Default:      false
// Values:       false (0), true (1)
// 
// Controls whether the tx_secure_s signal exists on the Master Port side and the tx_secure_m signal on the Slave Port 
// side.
`define X2X_HAS_TZ_SUPPORT 0


//Creates a define for whether we support the trustzone signals.

// `define X2X_TZ_SUPPORT


//This is the maximum width of any sideband bus.

`define X2X_MAX_SBW 64



// Name:         X2X_HAS_AWSB
// Default:      false
// Values:       false (0), true (1)
// 
// If True, then all master and slave Write Address channels have an associated sideband bus. The Write Address channel 
// sideband bus is routed in the same way as the Write Address channel payload.
`define X2X_HAS_AWSB 0


//Creates a define for whether we support sideband signals.

// `define X2X_AWSB



// Name:         X2X_AW_SBW
// Default:      4
// Values:       1, ..., 64
// Enabled:      X2X_HAS_AWSB == 1
// 
// Defines width of the Write Address sideband bus.
`define X2X_AW_SBW 4



// Name:         X2X_HAS_WSB
// Default:      false
// Values:       false (0), true (1)
// 
// If True, then all master and slave Write Data channels have an associated sideband bus. The Write Data channel sideband 
// bus is routed in the same way as the Write Data channel payload.
`define X2X_HAS_WSB 0


//Creates a define for whether we support sideband signals.

// `define X2X_WSB



// Name:         X2X_W_SBW
// Default:      4
// Values:       1, ..., 64
// Enabled:      X2X_HAS_WSB == 1
// 
// Defines width of the Write Data sideband bus.
`define X2X_W_SBW 4



// Name:         X2X_HAS_BSB
// Default:      false
// Values:       false (0), true (1)
// 
// If True, then all master and slave Write Response channels have an associated sideband bus. The Write Response channel 
// sideband bus is routed in the same way as the Write Response channel payload.
`define X2X_HAS_BSB 0


//Creates a define for whether we support sideband signals.

// `define X2X_BSB



// Name:         X2X_B_SBW
// Default:      4
// Values:       1, ..., 64
// Enabled:      X2X_HAS_BSB == 1
// 
// Defines width of the Burst Response sideband bus.
`define X2X_B_SBW 4



// Name:         X2X_HAS_ARSB
// Default:      false
// Values:       false (0), true (1)
// 
// If set to true, then all master and slave Read Address channels have an associated sideband bus. The Read Address 
// channel sideband bus is routed in the same way as the Read Address channel payload.
`define X2X_HAS_ARSB 0


//Creates a define for whether we support sideband signals.

// `define X2X_ARSB



// Name:         X2X_AR_SBW
// Default:      4
// Values:       1, ..., 64
// Enabled:      X2X_HAS_ARSB == 1
// 
// Defines width of the Read Address sideband bus.
`define X2X_AR_SBW 4



// Name:         X2X_HAS_RSB
// Default:      false
// Values:       false (0), true (1)
// 
// If set to true, then all master and slave Read Data channels have an associated sideband bus. The Read Data channel 
// sideband bus is routed in the same way as the Read Data channel payload.
`define X2X_HAS_RSB 0


//Creates a define for whether we support sideband signals.

// `define X2X_RSB



// Name:         X2X_R_SBW
// Default:      4
// Values:       1, ..., 64
// Enabled:      X2X_HAS_RSB == 1
// 
// Defines width of the Read Data sideband bus.
`define X2X_R_SBW 4


//Creates a define for whether there are read channels in the
//DW_axi_x2x or not.

`define X2X_RD_CHANNELS


//Creates a define for the number of slave ports in the DW_axi_x2x.

`define X2X_NUM_W_PORTS 1


//Log base 2 of X2X_NUM_W_PORTS.

`define X2X_LOG2_NUM_W_PORTS 1


//Internal address width : smaller of X2X_MP_AW and X2X_SP_AW

`define X2X_INTERNAL_AW 40


//Creates a define for whether or not slave port 2 exists.

// `define X2X_SP2


//Creates a define for whether or not slave port 3 exists.

// `define X2X_SP3


//Creates a define for whether or not slave port 4 exists.

// `define X2X_SP4


//Creates a define for whether or not slave port 5 exists.

// `define X2X_SP5


//Creates a define for whether or not slave port 6 exists.

// `define X2X_SP6


//Creates a define for whether or not slave port 7 exists.

// `define X2X_SP7


//Creates a define for whether or not slave port 8 exists.

// `define X2X_SP8


//Creates a define for whether or not the DW_axi_x2x has dual
//clocks.

`define X2X_DUAL_CLK


//Creates a define for whether or not the DW_axi_x2x has a single
//clock.

// `define X2X_SINGLE_CLK


//Maximum possible A*LEN value on master port , derived from X2X_MP_BLW.

`define X2X_MAX_MP_ALEN 15


//Maximum possible A*LEN value on master port , derived from X2X_SP_BLW.

`define X2X_MAX_SP_ALEN 15


//Maximum possible number of bytes in X2X_MP_DW.

`define X2X_MAX_MP_BYTES 8


//Maximum possible number of bytes in X2X_SP_DW.

`define X2X_MAX_SP_BYTES 8


//Log base 2 of maximum possible number of bytes in X2X_MP_DW.

`define X2X_LOG2_MAX_MP_BYTES 3


//Log base 2 of maximum possible number of bytes in X2X_MP_DW.

`define X2X_0LOG2_MAX_MP_BYTES 3



//Log base 2 of maximum possible number of bytes in X2X_SP_DW.

`define X2X_LOG2_MAX_SP_BYTES 3


//Log base 2 of maximum possible number of bytes in X2X_SP_DW.

`define X2X_0LOG2_MAX_SP_BYTES 3


//Maximum possible value of a*size_m

`define X2X_MAX_MP_ASIZE 3


//Maximum possible value of a*size_m

`define X2X_MAX_SP_ASIZE 3


//Maximum possible total transfer size in bytes on the X2X MP.

`define X2X_MAX_MP_TOTAL_BYTE 128


//Maximum possible total transfer size in bytes on the X2X SP.

`define X2X_MAX_SP_TOTAL_BYTE 128


//This is the log2 of (X2X_MAX_MP_TOTAL_BYTE)

`define X2X_LOG2_MP_BYTE 7


//This is the log2 of (X2X_MAX_SP_TOTAL_BYTE)

`define X2X_LOG2_SP_BYTE 7


//The depth of the WIP FIFO for non fan out write interleaving
//configurations.
//Max value is 64

`define X2X_WIP_FIFO_D 1


//This is the log2 of (X2X_WIP_FIFO_D)

`define X2X_LOG2_WIP_FIFO_D 1



//Internal boundary address width : larger of 12 and X2X_LOG2_MP_BYTE

`define X2X_INTERNAL_BW 12


//This is the log2 of (X2X_MAX_WCA_ID)

`define X2X_LOG2_MAX_WCA_ID 2


//Log base 2 of (X2X_MAX_WCA_ID+1)

`define X2X_MAX_WCA_ID_P1L2 3



//This is the log2 of (X2X_MAX_RCA_ID)

`define X2X_LOG2_MAX_RCA_ID 2


//Log base 2 of (X2X_MAX_RCA_ID+1)

`define X2X_MAX_RCA_ID_P1L2 3


//Log base 2 of X2X_AW_BUF_DEPTH

`define X2X_AW_BUF_DEPTH_L2 2


//Log base 2 of (X2X_AW_BUF_DEPTH+1)

`define X2X_AW_BUF_DEPTH_P1L2 3


//Log base 2 of X2X_W_BUF_DEPTH

`define X2X_W_BUF_DEPTH_L2 2


//Log base 2 of (X2X_W_BUF_DEPTH+1)

`define X2X_W_BUF_DEPTH_P1L2 3


//Log base 2 of X2X_B_BUF_DEPTH

`define X2X_B_BUF_DEPTH_L2 2


//Log base 2 of (X2X_B_BUF_DEPTH+1)

`define X2X_B_BUF_DEPTH_P1L2 3


//Log base 2 of X2X_AR_BUF_DEPTH

`define X2X_AR_BUF_DEPTH_L2 2


//Log base 2 of (X2X_AR_BUF_DEPTH+1)

`define X2X_AR_BUF_DEPTH_P1L2 3


//Log base 2 of X2X_R_BUF_DEPTH

`define X2X_R_BUF_DEPTH_L2 2


//Log base 2 of (X2X_R_BUF_DEPTH+1)

`define X2X_R_BUF_DEPTH_P1L2 3


//Log base 2 of X2X_MP_SW

`define X2X_LOG2_MP_SW 3


//Log base 2 of X2X_SP_SW

`define X2X_LOG2_SP_SW 3


//Log base 2 of the larger of X2X_MP_SW and X2X_SP_SW.
//This defines the number of address bits that the X2X needs to
//store in order to perform t/x resizing.

`define X2X_ADDR_TRK_W 1


//Defines the transaction altering level required of the X2X.
//Used to remove t/x resizing logic when not required.

`define X2X_TX_ALTER 0


//Creates a define for when X2X_TX_ALTER == X2X_TX_NO_ALTER.

`define X2X_HAS_TX_NO_ALTER


//Creates a define for when X2X_TX_ALTER == X2X_MP_LRGR_ALTER.

// `define X2X_HAS_MP_LRGR_ALTER


//Creates a define for when X2X_MP_BLW > X2X_SP_BLW and upsizing is
//enabled.

// `define X2X_HAS_MP_BLW_LRGR_US


//Creates a define for when X2X_TX_ALTER == X2X_SP_LRGR_US_ALTER.

// `define X2X_HAS_SP_LRGR_US_ALTER


//Defines the width of the signal containing the number of data beats
//issued from the SP W block for a single pop from the W channel fifo.

`define X2X_SP_W_BEATS_PER_POP_W 1


//Defines the word width of the resize info. fifo in the SP W channel block.

`define X2X_SP_W_RSFIFO_W 12


//Defines the depth of the resize info. fifo in the SP W channel block.

`define X2X_SP_W_RSFIFO_D 16


//Log base 2 of X2X_SP_W_RSFIFO_D.

`define X2X_SP_W_RSFIFO_D_L2 4


//Log base 2 of (X2X_SP_W_RSFIFO_D+1).

`define X2X_SP_W_RSFIFO_D_P1L2 5


//How many bits of address to use when going from large data bus
//to smaller data bus.

`define X2X_DATA_SEL_W 1


//How many bits of low power reg to use in write transaction

`define X2X_W_LP_REG_DEPTH_L2 4


//How many bits of low power reg to use in read transaction

`define X2X_R_LP_REG_DEPTH_L2 4


//How many bits of low power reg to use in write transaction including buffer depth

`define X2X_W_LP_REG_DEPTH_PDL2 5


//How many bits of low power reg to use in write transaction including buffer depth

`define X2X_R_LP_REG_DEPTH_PDL2 5


//Resizing ratio within the X2X.

`define X2X_RS_RATIO 1


//Creates a define for whether the master port data width is larger than
//the slave port data width.

// `define X2X_MP_DW_LARGER


//Creates a define for whether the slave port data width is larger than
//the master port data width.

// `define X2X_SP_DW_LARGER


//Creates a define for whether the master and slave port data widths
//are the same.

`define X2X_SP_MP_DW_SAME


//Creates a define for MP_DW = 8

// `define X2X_MPDW8


//Creates a define for MP_DW = 16

// `define X2X_MPDW16


//Creates a define for MP_DW = 32

// `define X2X_MPDW32


//Creates a define for MP_DW = 64

`define X2X_MPDW64


//Creates a define for MP_DW = 128

// `define X2X_MPDW128


//Creates a define for MP_DW = 256

// `define X2X_MPDW256


//Creates a define for MP_DW = 512

// `define X2X_MPDW512


//Creates a define for SP_DW = 8

// `define X2X_SPDW8


//Creates a define for SP_DW = 16

// `define X2X_SPDW16


//Creates a define for SP_DW = 32

// `define X2X_SPDW32


//Creates a define for SP_DW = 64

`define X2X_SPDW64


//Creates a define for SP_DW = 128

// `define X2X_SPDW128


//Creates a define for SP_DW = 256

// `define X2X_SPDW256


//Creates a define for SP_DW = 512

// `define X2X_SPDW512



`define X2X_MPDW_GRTR_OR_EQ_16


`define X2X_MPDW_GRTR_OR_EQ_32


`define X2X_MPDW_GRTR_OR_EQ_64


// `define X2X_MPDW_GRTR_OR_EQ_128


// `define X2X_MPDW_GRTR_OR_EQ_256


// `define X2X_MPDW_GRTR_OR_EQ_512



//Creates a define for whether the slave port address width is
//larger.

// `define X2X_AW_SP_LRGR


//Creates a define for whether the master port address width is
//larger or the mp and sp address widths are the same.

`define X2X_AW_MP_LRGR_OR_SAME


//Creates a define for whether the slave port id width is
//larger.

// `define X2X_IDW_SP_LRGR


//Creates a define for whether the master port id width is
//larger or the mp and sp id widths are the same.

`define X2X_IDW_MP_LRGR_OR_SAME


//----------------------------------------------------------------------
// MASTER PORT Payload Macros.
//----------------------------------------------------------------------

// Read address channel payload vector.
// Bit Position Macros.
`define X2X_ARPYLD_PROT_RHS_MP 0
`define X2X_ARPYLD_PROT_LHS_MP ((`X2X_PTW-1) + `X2X_ARPYLD_PROT_RHS_MP)
`define X2X_ARPYLD_PROT_MP     `X2X_ARPYLD_PROT_LHS_MP:`X2X_ARPYLD_PROT_RHS_MP

`define X2X_ARPYLD_CACHE_RHS_MP (`X2X_ARPYLD_PROT_LHS_MP + 1)
`define X2X_ARPYLD_CACHE_LHS_MP ((`X2X_CTW-1) + `X2X_ARPYLD_CACHE_RHS_MP)
`define X2X_ARPYLD_CACHE_MP     `X2X_ARPYLD_CACHE_LHS_MP:`X2X_ARPYLD_CACHE_RHS_MP

`define X2X_ARPYLD_LOCK_RHS_MP (`X2X_ARPYLD_CACHE_LHS_MP + 1)
`define X2X_ARPYLD_LOCK_LHS_MP ((`X2X_LTW-1) + `X2X_ARPYLD_LOCK_RHS_MP)
`define X2X_ARPYLD_LOCK_MP     `X2X_ARPYLD_LOCK_LHS_MP:`X2X_ARPYLD_LOCK_RHS_MP

`define X2X_ARPYLD_BURST_RHS_MP (`X2X_ARPYLD_LOCK_LHS_MP + 1)
`define X2X_ARPYLD_BURST_LHS_MP ((`X2X_BTW-1) + `X2X_ARPYLD_BURST_RHS_MP)
`define X2X_ARPYLD_BURST_MP     `X2X_ARPYLD_BURST_LHS_MP:`X2X_ARPYLD_BURST_RHS_MP

`define X2X_ARPYLD_SIZE_RHS_MP (`X2X_ARPYLD_BURST_LHS_MP + 1)
`define X2X_ARPYLD_SIZE_LHS_MP ((`X2X_BSW-1) + `X2X_ARPYLD_SIZE_RHS_MP)
`define X2X_ARPYLD_SIZE_MP     `X2X_ARPYLD_SIZE_LHS_MP:`X2X_ARPYLD_SIZE_RHS_MP

`define X2X_ARPYLD_LEN_RHS_MP (`X2X_ARPYLD_SIZE_LHS_MP + 1)
`define X2X_ARPYLD_LEN_LHS_MP ((`X2X_MP_BLW-1) + `X2X_ARPYLD_LEN_RHS_MP)
`define X2X_ARPYLD_LEN_MP     `X2X_ARPYLD_LEN_LHS_MP:`X2X_ARPYLD_LEN_RHS_MP

`define X2X_ARPYLD_ADDR_RHS_MP (`X2X_ARPYLD_LEN_LHS_MP + 1)
`define X2X_ARPYLD_ADDR_LHS_MP ((`X2X_INTERNAL_AW-1) + `X2X_ARPYLD_ADDR_RHS_MP)
`define X2X_ARPYLD_ADDR_MP     `X2X_ARPYLD_ADDR_LHS_MP:`X2X_ARPYLD_ADDR_RHS_MP

`define X2X_ARPYLD_ID_RHS_MP (`X2X_ARPYLD_ADDR_LHS_MP + 1)
`define X2X_ARPYLD_ID_LHS_MP ((`X2X_MP_IDW-1) + `X2X_ARPYLD_ID_RHS_MP)
`define X2X_ARPYLD_ID_MP     `X2X_ARPYLD_ID_LHS_MP:`X2X_ARPYLD_ID_RHS_MP

// AR payload width.
`define X2X_ARPYLD_W_MP (`X2X_HAS_ARSB ? (`X2X_PTW + `X2X_CTW + `X2X_LTW + `X2X_BTW + `X2X_BSW + `X2X_MP_BLW + `X2X_INTERNAL_AW + `X2X_MP_IDW + `X2X_AR_SBW) : (`X2X_PTW + `X2X_CTW + `X2X_LTW + `X2X_BTW + `X2X_BSW + `X2X_MP_BLW + `X2X_INTERNAL_AW + `X2X_MP_IDW))


// Read data channel payload vector.
// Bit Position Macros.
`define X2X_RPYLD_LAST_LHS_MP 0
`define X2X_RPYLD_LAST_MP     `X2X_RPYLD_LAST_LHS_MP

`define X2X_RPYLD_RESP_RHS_MP (`X2X_RPYLD_LAST_LHS_MP + 1)
`define X2X_RPYLD_RESP_LHS_MP ((`X2X_RRW-1) + `X2X_RPYLD_RESP_RHS_MP)
`define X2X_RPYLD_RESP_MP     `X2X_RPYLD_RESP_LHS_MP:`X2X_RPYLD_RESP_RHS_MP

`define X2X_RPYLD_DATA_RHS_MP (`X2X_RPYLD_RESP_LHS_MP + 1)
`define X2X_RPYLD_DATA_LHS_MP ((`X2X_MP_DW-1) + `X2X_RPYLD_DATA_RHS_MP)
`define X2X_RPYLD_DATA_MP     `X2X_RPYLD_DATA_LHS_MP:`X2X_RPYLD_DATA_RHS_MP

`define X2X_RPYLD_ID_RHS_MP   (`X2X_RPYLD_DATA_LHS_MP + 1)
`define X2X_RPYLD_ID_LHS_MP   ((`X2X_MP_IDW-1) + `X2X_RPYLD_ID_RHS_MP)
`define X2X_RPYLD_ID_MP       `X2X_RPYLD_ID_LHS_MP:`X2X_RPYLD_ID_RHS_MP

// R payload width.
`define X2X_RPYLD_W_MP (`X2X_HAS_RSB ? (1 + `X2X_RRW + `X2X_MP_DW + `X2X_MP_IDW + `X2X_R_SBW) : (1 + `X2X_RRW + `X2X_MP_DW + `X2X_MP_IDW))


// Write address channel payload vector.
// Bit Position Macros.
`define X2X_AWPYLD_PROT_RHS_MP 0
`define X2X_AWPYLD_PROT_LHS_MP ((`X2X_PTW-1) + `X2X_AWPYLD_PROT_RHS_MP)
`define X2X_AWPYLD_PROT_MP     `X2X_AWPYLD_PROT_LHS_MP:`X2X_AWPYLD_PROT_RHS_MP

`define X2X_AWPYLD_CACHE_RHS_MP (`X2X_AWPYLD_PROT_LHS_MP + 1)
`define X2X_AWPYLD_CACHE_LHS_MP ((`X2X_CTW-1) + `X2X_AWPYLD_CACHE_RHS_MP)
`define X2X_AWPYLD_CACHE_MP     `X2X_AWPYLD_CACHE_LHS_MP:`X2X_AWPYLD_CACHE_RHS_MP

`define X2X_AWPYLD_LOCK_RHS_MP (`X2X_AWPYLD_CACHE_LHS_MP + 1)
`define X2X_AWPYLD_LOCK_LHS_MP ((`X2X_LTW-1) + `X2X_AWPYLD_LOCK_RHS_MP)
`define X2X_AWPYLD_LOCK_MP     `X2X_AWPYLD_LOCK_LHS_MP:`X2X_AWPYLD_LOCK_RHS_MP

`define X2X_AWPYLD_BURST_RHS_MP (`X2X_AWPYLD_LOCK_LHS_MP + 1)
`define X2X_AWPYLD_BURST_LHS_MP ((`X2X_BTW-1) + `X2X_AWPYLD_BURST_RHS_MP)
`define X2X_AWPYLD_BURST_MP     `X2X_AWPYLD_BURST_LHS_MP:`X2X_AWPYLD_BURST_RHS_MP

`define X2X_AWPYLD_SIZE_RHS_MP (`X2X_AWPYLD_BURST_LHS_MP + 1)
`define X2X_AWPYLD_SIZE_LHS_MP ((`X2X_BSW-1) + `X2X_AWPYLD_SIZE_RHS_MP)
`define X2X_AWPYLD_SIZE_MP     `X2X_AWPYLD_SIZE_LHS_MP:`X2X_AWPYLD_SIZE_RHS_MP

`define X2X_AWPYLD_LEN_RHS_MP (`X2X_AWPYLD_SIZE_LHS_MP + 1)
`define X2X_AWPYLD_LEN_LHS_MP ((`X2X_MP_BLW-1) + `X2X_AWPYLD_LEN_RHS_MP)
`define X2X_AWPYLD_LEN_MP     `X2X_AWPYLD_LEN_LHS_MP:`X2X_AWPYLD_LEN_RHS_MP

`define X2X_AWPYLD_ADDR_RHS_MP (`X2X_AWPYLD_LEN_LHS_MP + 1)
`define X2X_AWPYLD_ADDR_LHS_MP ((`X2X_INTERNAL_AW-1) + `X2X_AWPYLD_ADDR_RHS_MP)
`define X2X_AWPYLD_ADDR_MP     `X2X_AWPYLD_ADDR_LHS_MP:`X2X_AWPYLD_ADDR_RHS_MP

`define X2X_AWPYLD_ID_RHS_MP (`X2X_AWPYLD_ADDR_LHS_MP + 1)
`define X2X_AWPYLD_ID_LHS_MP ((`X2X_MP_IDW-1) + `X2X_AWPYLD_ID_RHS_MP)
`define X2X_AWPYLD_ID_MP     `X2X_AWPYLD_ID_LHS_MP:`X2X_AWPYLD_ID_RHS_MP

//AW payload width.

`define X2X_AWPYLD_W_MP 70


// Write data channel payload vector.
// Bit Position Macros.
`define X2X_WPYLD_LAST_LHS_MP 0
`define X2X_WPYLD_LAST_MP     `X2X_WPYLD_LAST_LHS_MP

`define X2X_WPYLD_STRB_RHS_MP (`X2X_WPYLD_LAST_LHS_MP + 1)
`define X2X_WPYLD_STRB_LHS_MP ((`X2X_MP_SW-1) + `X2X_WPYLD_STRB_RHS_MP)
`define X2X_WPYLD_STRB_MP     `X2X_WPYLD_STRB_LHS_MP:`X2X_WPYLD_STRB_RHS_MP

`define X2X_WPYLD_DATA_RHS_MP (`X2X_WPYLD_STRB_LHS_MP + 1)
`define X2X_WPYLD_DATA_LHS_MP ((`X2X_MP_DW-1) + `X2X_WPYLD_DATA_RHS_MP)
`define X2X_WPYLD_DATA_MP     `X2X_WPYLD_DATA_LHS_MP:`X2X_WPYLD_DATA_RHS_MP

`define X2X_WPYLD_ID_RHS_MP (`X2X_WPYLD_DATA_LHS_MP + 1)
`define X2X_WPYLD_ID_LHS_MP ((`X2X_MP_IDW-1) + `X2X_WPYLD_ID_RHS_MP)
`define X2X_WPYLD_ID_MP     `X2X_WPYLD_ID_LHS_MP:`X2X_WPYLD_ID_RHS_MP

// W payload width.
`define X2X_WPYLD_W_MP (`X2X_HAS_WSB ? (1 + `X2X_MP_SW + `X2X_MP_DW + `X2X_MP_IDW + `X2X_W_SBW) : (1 + `X2X_MP_SW + `X2X_MP_DW + `X2X_MP_IDW))


// Burst response channel payload vector.
// Bit Position Macros.
`define X2X_BPYLD_RESP_RHS_MP 0
`define X2X_BPYLD_RESP_LHS_MP ((`X2X_BRW-1) + `X2X_BPYLD_RESP_RHS_MP)
`define X2X_BPYLD_RESP_MP     `X2X_BPYLD_RESP_LHS_MP:`X2X_BPYLD_RESP_RHS_MP

`define X2X_BPYLD_ID_RHS_MP (`X2X_BPYLD_RESP_LHS_MP + 1)
`define X2X_BPYLD_ID_LHS_MP ((`X2X_MP_IDW-1) + `X2X_BPYLD_ID_RHS_MP)
`define X2X_BPYLD_ID_MP     `X2X_BPYLD_ID_LHS_MP:`X2X_BPYLD_ID_RHS_MP

// B payload width.
`define X2X_BPYLD_W_MP (`X2X_HAS_BSB ? (`X2X_BRW + `X2X_MP_IDW + `X2X_B_SBW) : (`X2X_BRW + `X2X_MP_IDW))


//----------------------------------------------------------------------
// SLAVE PORT Payload Macros.
//
// Note : master port id width is always used here as internally the
//        ID width will always be the master port ID width.
//----------------------------------------------------------------------

// Read address channel payload vector.
// Bit Position Macros.
`define X2X_ARPYLD_PROT_RHS_SP 0
`define X2X_ARPYLD_PROT_LHS_SP ((`X2X_PTW-1) + `X2X_ARPYLD_PROT_RHS_SP)
`define X2X_ARPYLD_PROT_SP     `X2X_ARPYLD_PROT_LHS_SP:`X2X_ARPYLD_PROT_RHS_SP

`define X2X_ARPYLD_CACHE_RHS_SP (`X2X_ARPYLD_PROT_LHS_SP + 1)
`define X2X_ARPYLD_CACHE_LHS_SP ((`X2X_CTW-1) + `X2X_ARPYLD_CACHE_RHS_SP)
`define X2X_ARPYLD_CACHE_SP     `X2X_ARPYLD_CACHE_LHS_SP:`X2X_ARPYLD_CACHE_RHS_SP

`define X2X_ARPYLD_LOCK_RHS_SP (`X2X_ARPYLD_CACHE_LHS_SP + 1)
`define X2X_ARPYLD_LOCK_LHS_SP ((`X2X_LTW-1) + `X2X_ARPYLD_LOCK_RHS_SP)
`define X2X_ARPYLD_LOCK_SP     `X2X_ARPYLD_LOCK_LHS_SP:`X2X_ARPYLD_LOCK_RHS_SP

`define X2X_ARPYLD_BURST_RHS_SP (`X2X_ARPYLD_LOCK_LHS_SP + 1)
`define X2X_ARPYLD_BURST_LHS_SP ((`X2X_BTW-1) + `X2X_ARPYLD_BURST_RHS_SP)
`define X2X_ARPYLD_BURST_SP     `X2X_ARPYLD_BURST_LHS_SP:`X2X_ARPYLD_BURST_RHS_SP

`define X2X_ARPYLD_SIZE_RHS_SP (`X2X_ARPYLD_BURST_LHS_SP + 1)
`define X2X_ARPYLD_SIZE_LHS_SP ((`X2X_BSW-1) + `X2X_ARPYLD_SIZE_RHS_SP)
`define X2X_ARPYLD_SIZE_SP     `X2X_ARPYLD_SIZE_LHS_SP:`X2X_ARPYLD_SIZE_RHS_SP

`define X2X_ARPYLD_LEN_RHS_SP (`X2X_ARPYLD_SIZE_LHS_SP + 1)
`define X2X_ARPYLD_LEN_LHS_SP ((`X2X_SP_BLW-1) + `X2X_ARPYLD_LEN_RHS_SP)
`define X2X_ARPYLD_LEN_SP     `X2X_ARPYLD_LEN_LHS_SP:`X2X_ARPYLD_LEN_RHS_SP

`define X2X_ARPYLD_ADDR_RHS_SP (`X2X_ARPYLD_LEN_LHS_SP + 1)
`define X2X_ARPYLD_ADDR_LHS_SP ((`X2X_INTERNAL_AW-1) + `X2X_ARPYLD_ADDR_RHS_SP)
`define X2X_ARPYLD_ADDR_SP     `X2X_ARPYLD_ADDR_LHS_SP:`X2X_ARPYLD_ADDR_RHS_SP

`define X2X_ARPYLD_ID_RHS_SP (`X2X_ARPYLD_ADDR_LHS_SP + 1)
`define X2X_ARPYLD_ID_LHS_SP ((`X2X_MP_IDW-1) + `X2X_ARPYLD_ID_RHS_SP)
`define X2X_ARPYLD_ID_SP     `X2X_ARPYLD_ID_LHS_SP:`X2X_ARPYLD_ID_RHS_SP

// AR payload width.
`define X2X_ARPYLD_W_SP (`X2X_HAS_ARSB ? (`X2X_PTW + `X2X_CTW + `X2X_LTW + `X2X_BTW + `X2X_BSW + `X2X_SP_BLW + `X2X_INTERNAL_AW + `X2X_MP_IDW + `X2X_AR_SBW) : (`X2X_PTW + `X2X_CTW + `X2X_LTW + `X2X_BTW + `X2X_BSW + `X2X_SP_BLW + `X2X_INTERNAL_AW + `X2X_MP_IDW))


// Read data channel payload vector.
// Bit Position Macros.
`define X2X_RPYLD_LAST_LHS_SP 0
`define X2X_RPYLD_LAST_SP     `X2X_RPYLD_LAST_LHS_SP

`define X2X_RPYLD_RESP_RHS_SP (`X2X_RPYLD_LAST_LHS_SP + 1)
`define X2X_RPYLD_RESP_LHS_SP ((`X2X_RRW-1) + `X2X_RPYLD_RESP_RHS_SP)
`define X2X_RPYLD_RESP_SP     `X2X_RPYLD_RESP_LHS_SP:`X2X_RPYLD_RESP_RHS_SP

`define X2X_RPYLD_DATA_RHS_SP (`X2X_RPYLD_RESP_LHS_SP + 1)
`define X2X_RPYLD_DATA_LHS_SP ((`X2X_SP_DW-1) + `X2X_RPYLD_DATA_RHS_SP)
`define X2X_RPYLD_DATA_SP     `X2X_RPYLD_DATA_LHS_SP:`X2X_RPYLD_DATA_RHS_SP

`define X2X_RPYLD_ID_RHS_SP   (`X2X_RPYLD_DATA_LHS_SP + 1)
`define X2X_RPYLD_ID_LHS_SP   ((`X2X_MP_IDW-1) + `X2X_RPYLD_ID_RHS_SP)
`define X2X_RPYLD_ID_SP       `X2X_RPYLD_ID_LHS_SP:`X2X_RPYLD_ID_RHS_SP

// R payload width.
`define X2X_RPYLD_W_SP (`X2X_HAS_RSB ? (1 + `X2X_RRW + `X2X_SP_DW + `X2X_MP_IDW + `X2X_R_SBW) : (1 + `X2X_RRW + `X2X_SP_DW + `X2X_MP_IDW))


// Write address channel payload vector.
// Bit Position Macros.
`define X2X_AWPYLD_PROT_RHS_SP 0
`define X2X_AWPYLD_PROT_LHS_SP ((`X2X_PTW-1) + `X2X_AWPYLD_PROT_RHS_SP)
`define X2X_AWPYLD_PROT_SP     `X2X_AWPYLD_PROT_LHS_SP:`X2X_AWPYLD_PROT_RHS_SP

`define X2X_AWPYLD_CACHE_RHS_SP (`X2X_AWPYLD_PROT_LHS_SP + 1)
`define X2X_AWPYLD_CACHE_LHS_SP ((`X2X_CTW-1) + `X2X_AWPYLD_CACHE_RHS_SP)
`define X2X_AWPYLD_CACHE_SP     `X2X_AWPYLD_CACHE_LHS_SP:`X2X_AWPYLD_CACHE_RHS_SP

`define X2X_AWPYLD_LOCK_RHS_SP (`X2X_AWPYLD_CACHE_LHS_SP + 1)
`define X2X_AWPYLD_LOCK_LHS_SP ((`X2X_LTW-1) + `X2X_AWPYLD_LOCK_RHS_SP)
`define X2X_AWPYLD_LOCK_SP     `X2X_AWPYLD_LOCK_LHS_SP:`X2X_AWPYLD_LOCK_RHS_SP

`define X2X_AWPYLD_BURST_RHS_SP (`X2X_AWPYLD_LOCK_LHS_SP + 1)
`define X2X_AWPYLD_BURST_LHS_SP ((`X2X_BTW-1) + `X2X_AWPYLD_BURST_RHS_SP)
`define X2X_AWPYLD_BURST_SP     `X2X_AWPYLD_BURST_LHS_SP:`X2X_AWPYLD_BURST_RHS_SP

`define X2X_AWPYLD_SIZE_RHS_SP (`X2X_AWPYLD_BURST_LHS_SP + 1)
`define X2X_AWPYLD_SIZE_LHS_SP ((`X2X_BSW-1) + `X2X_AWPYLD_SIZE_RHS_SP)
`define X2X_AWPYLD_SIZE_SP     `X2X_AWPYLD_SIZE_LHS_SP:`X2X_AWPYLD_SIZE_RHS_SP

`define X2X_AWPYLD_LEN_RHS_SP (`X2X_AWPYLD_SIZE_LHS_SP + 1)
`define X2X_AWPYLD_LEN_LHS_SP ((`X2X_SP_BLW-1) + `X2X_AWPYLD_LEN_RHS_SP)
`define X2X_AWPYLD_LEN_SP     `X2X_AWPYLD_LEN_LHS_SP:`X2X_AWPYLD_LEN_RHS_SP

`define X2X_AWPYLD_ADDR_RHS_SP (`X2X_AWPYLD_LEN_LHS_SP + 1)
`define X2X_AWPYLD_ADDR_LHS_SP ((`X2X_INTERNAL_AW-1) + `X2X_AWPYLD_ADDR_RHS_SP)
`define X2X_AWPYLD_ADDR_SP     `X2X_AWPYLD_ADDR_LHS_SP:`X2X_AWPYLD_ADDR_RHS_SP

`define X2X_AWPYLD_ID_RHS_SP (`X2X_AWPYLD_ADDR_LHS_SP + 1)
`define X2X_AWPYLD_ID_LHS_SP ((`X2X_MP_IDW-1) + `X2X_AWPYLD_ID_RHS_SP)
`define X2X_AWPYLD_ID_SP     `X2X_AWPYLD_ID_LHS_SP:`X2X_AWPYLD_ID_RHS_SP

// AW payload width.
`define X2X_AWPYLD_W_SP (`X2X_HAS_AWSB ? (`X2X_PTW + `X2X_CTW + `X2X_LTW + `X2X_BTW + `X2X_BSW + `X2X_SP_BLW + `X2X_INTERNAL_AW + `X2X_MP_IDW + `X2X_AW_SBW) : (`X2X_PTW + `X2X_CTW + `X2X_LTW + `X2X_BTW + `X2X_BSW + `X2X_SP_BLW + `X2X_INTERNAL_AW + `X2X_MP_IDW))


// Write data channel payload vector.
// Bit Position Macros.
`define X2X_WPYLD_LAST_LHS_SP 0
`define X2X_WPYLD_LAST_SP     `X2X_WPYLD_LAST_LHS_SP

`define X2X_WPYLD_STRB_RHS_SP (`X2X_WPYLD_LAST_LHS_SP + 1)
`define X2X_WPYLD_STRB_LHS_SP ((`X2X_SP_SW-1) + `X2X_WPYLD_STRB_RHS_SP)
`define X2X_WPYLD_STRB_SP     `X2X_WPYLD_STRB_LHS_SP:`X2X_WPYLD_STRB_RHS_SP

`define X2X_WPYLD_DATA_RHS_SP (`X2X_WPYLD_STRB_LHS_SP + 1)
`define X2X_WPYLD_DATA_LHS_SP ((`X2X_SP_DW-1) + `X2X_WPYLD_DATA_RHS_SP)
`define X2X_WPYLD_DATA_SP     `X2X_WPYLD_DATA_LHS_SP:`X2X_WPYLD_DATA_RHS_SP

`define X2X_WPYLD_ID_RHS_SP (`X2X_WPYLD_DATA_LHS_SP + 1)
`define X2X_WPYLD_ID_LHS_SP ((`X2X_MP_IDW-1) + `X2X_WPYLD_ID_RHS_SP)
`define X2X_WPYLD_ID_SP     `X2X_WPYLD_ID_LHS_SP:`X2X_WPYLD_ID_RHS_SP

// W payload width.
`define X2X_WPYLD_W_SP (`X2X_HAS_WSB ? (1 + `X2X_SP_SW + `X2X_SP_DW + `X2X_MP_IDW + `X2X_W_SBW) : (1 + `X2X_SP_SW + `X2X_SP_DW + `X2X_MP_IDW))


// Burst response channel payload vector.
// Bit Position Macros.
`define X2X_BPYLD_RESP_RHS_SP 0
`define X2X_BPYLD_RESP_LHS_SP ((`X2X_BRW-1) + `X2X_BPYLD_RESP_RHS_SP)
`define X2X_BPYLD_RESP_SP     `X2X_BPYLD_RESP_LHS_SP:`X2X_BPYLD_RESP_RHS_SP

`define X2X_BPYLD_ID_RHS_SP (`X2X_BPYLD_RESP_LHS_SP + 1)
`define X2X_BPYLD_ID_LHS_SP ((`X2X_SP_IDW-1) + `X2X_BPYLD_ID_RHS_SP)
`define X2X_BPYLD_ID_SP     `X2X_BPYLD_ID_LHS_SP:`X2X_BPYLD_ID_RHS_SP

// B payload width.
`define X2X_BPYLD_W_SP (`X2X_HAS_BSB ? (`X2X_BRW + `X2X_MP_IDW + `X2X_B_SBW) : (`X2X_BRW + `X2X_MP_IDW))


//Macro for width of AW channel fifo.

`define X2X_AW_CH_FIFO_W 70

//Number of times to duplicate the random testcase by

`define X2X_N_TESTCASE_DUPLICATION 0
