/***************************************************************************************************
* RISC-V International Open Source Laboratory (RIOS Lab)        = Inc CONFIDENTIAL
*
* Copyright (c) $today_year RISC-V International Open Source Laboratory (RIOS Lab)        = Inc
* All Rights Reserved_
*
* NOTICE:  All information contained herein is        = and remains
* the property of RISC-V International Open Source Laboratory (RIOS Lab) Inc and its suppliers =
* if any_  The intellectual and technical concepts contained
* herein are proprietary to RISC-V International Open Source Laboratory (RIOS Lab) Inc
* and its suppliers and may be covered by U_S_ and Foreign Patents =
* patents in process        = and are protected by trade secret or copyright law_
* Dissemination of this information or reproduction of this material
* is strictly forbidden unless prior written permission is obtained
* from RISC-V International Open Source Laboratory (RIOS Lab) Inc.
*
* Author:
* Luis Vitorio Cargnini <lvcargnini@{rivai-ic.com.cn,ours-tech.com}> lvcargnini
***************************************************************************************************/


package vcore_cfg;
   import pygmy_cfg::VLEN;
   import pygmy_typedef::*;
    //General Paramerters
    parameter sig_width                     = 10; //5;
    parameter exp_width                     = 5; //10;
    parameter ieee_compliance               = 1;
    parameter op_iso_mode                   = 0;
//    parameter id_width                      = $bits( vcore_func_unit_launch_id_t );
    parameter id_width                      = 32;
    parameter in_reg                        = 0; // registered inputs
    parameter out_reg                       = 1; // registered outputs
    parameter no_pm                         = 0; // Enable DW power management mode
    parameter rst_mode                      = 1;
    parameter faithful_round                = 0;// only for fp_div

    parameter XLEN                          = 16;//(sig_width+exp_width); //TODO: create RV64 and RV32 in a package
    parameter ISFP                          = 1; //1-> IFP, 0->
`ifndef FPGA
    parameter USEDW                         = 1; //uses Synopsys DesignWare library
`else
    parameter USEDW                         = 2; //uses Synopsys DesignWare library
`endif
    parameter ELEN                          = 16; //128 bytes == 128 * 8 bits == 1024 bits == 1K worline == 128K / Vector
    parameter FELEN                         = 16; //128 bytes == 128 * 8 bits == 1024 bits == 1K worline == 128K / Vector
    parameter SLEN                          = 16; //128 bytes == 128 * 8 bits == 1024 bits == 1K worline == 128K / Vector

    parameter num_stages                    = 4;
    parameter stall_mode                    = 0;

    parameter VLMAX                         = 32;
    parameter VECBANKS                      = 8;

    parameter stages                        = 1;//$clog2(sig_width+exp_width+1);
    parameter census_width                  = $clog2(in_reg+(stages-1)+out_reg+1);

    parameter POWERLINE_CTRL_WIDTH          = 7;
    parameter POWERVBANK_CTRL_WIDTH         = 5;
    parameter UNIT_DELAY                    = 0.2;    // TSMC SRAM

    parameter CPINT_VECTOR_EXT              = 1;
    parameter CPINT_SUPPORT_MULDIV          = 1;

    parameter CPFP_VECTOR_EXT               = 1;
    parameter CPFP_SUPPORT_MULDIV           = 1;
    parameter CPFP_SUPPORT_FP               = 1;

    parameter L2_PORT_WIDTH                 = 256;
    parameter L2_PORT_BYTE_CNT              = 32;

    parameter MEM_TRANS_DATA_IDX_SZ         = 35;

    parameter VCORE_THREAD_CNT              = 4;   // the number of threads suppported by each Vcore

    parameter VCORE_PREDECODE_INPUT_BUF_DEPTH  = 8;
    parameter DATA_HARZARD_CAM_DEPTH        = 16;

    parameter VCORE_VRF_MEM_TYPE            = 1;   // 0: flop-based; 1: sram-based

    parameter VCORE_MAX_VLEN_16b            = 32;    //
    parameter VCORE_MAX_VLEN_8b             = 64;//VCORE_MAX_VLEN_16b; // the maximum vector length in term of 8-bit elements

    parameter VCORE_VRF_WIDTH                       = 1024;
    parameter VCORE_VRF_DEPTH                       = 32;
    parameter VCORE_VRF_BANK_WIDTH                  = 128;
    parameter VCORE_VRF_BANK_DEPTH                  = 32;
    parameter VCROE_VRF_BANK_ADDR_SZ                = 5;
    parameter VCORE_VRF_BANK_CNT                    = 8;
    parameter VCORE_VRF_BYTE_CNT_PER_BANK_ENTRY     = 16;

    parameter VCORE_VLOAD_REQ_INPUT_BUF_DEPTH       = 8;
    parameter VCORE_MAX_VLOAD_REQ_CNT               = 4;   // maximum vload reqs = thread_cnt (Load Unit is shared by all threads)

    parameter VCORE_LOAD_RSP_WAIT_BUF_DEPTH         = 16;
    parameter VCORE_LOAD_RSP_WAIT_BUF_ADDR_SZ       = 4;

    parameter VCORE_SRF_SCALAR_CNT                  = 32;   // 32 for 1 thread; 16 or 32/thread for 2 threads; 8 or 16/thread for 4 threads
    parameter VCORE_SRF_ENTRY_WD                    = 32;  // reuse the same data width of Master RISV RTL
    parameter VCORE_SRF_ENTRY_BYTE_CNT              = 4;

    parameter VCORE_VEXE_INT_LANE_CNT                     = 16;
    parameter VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE      = 8;
    parameter VCORE_VEXE_INT_ELEMENT_16b_CNT_PER_LANE     = 4;
    parameter VCORE_VEXE_INT_LANE_CNT_PER_VECTOR          = 16;
    parameter VCORE_VEXE_INT_NONLINEAR_LANE_CNT           = 1;

    parameter VCORE_VRF_RD_LATENCY                        = 2;
    parameter VCORE_VEXE_INPUT_BUF_DEPTH                  = 4;
    parameter VCORE_VEXE_INPUT_BUF_NEARFULL_THSHD         = 2;

    parameter VCORE_VEXE_INT_LANE_LATENCY                 = 1;

    parameter VCORE_VEXE_FP_LANE_CNT                      = 16;
    parameter VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE      = 4;
    parameter VCORE_VEXE_FP_LANE_CNT_PER_VECTOR           = 16;
    parameter VCORE_VEXE_FP_NONLINEAR_LANE_CNT            = 1;

    parameter VCORE_VEXE_FP_LANE_DIST_BUF_DEPTH           = 4;
    parameter VCORE_VEXE_FP_LANE_DIST_BUF_NEARFULL_THSHD  = 2;

    parameter VCORE_VEXE_FP_LANE_LATENCY                  = 3;
    //----------------------------------------
    //added by cuiluping
    //----------------------------------------
    parameter VCORE_OPCODE_W        = $bits(vopcode_e);
    parameter VCORE_SCALAR_DATA_W   = 16;
    parameter VCORE_CSR_VLEN_W      = 7;//by now 1~32 is legal configuration
    parameter VCORE_VELE_W          = 16;//vector element width
    parameter VCORE_VELE_MAX_CNT    = 32;//vector element max counter
    parameter VCORE_VDP_W           = VCORE_VELE_W * VCORE_VELE_MAX_CNT;//vector data path width
    parameter VCORE_VRF_ENT_NUM     = 8;
    parameter VCORE_VRF_ID_W        = $clog2(VCORE_VRF_ENT_NUM);
    parameter VCORE_VRF_ENT_DATA_W  = 512;//default is 512. should support more wider range, 1024,2048,4096,etc.
    parameter VCORE_OTS_CTR_W       = 5;//the maximum vcore outstanding instructions is 31, but shoud not be reached.
    parameter VCORE_PMU_EVT_W       = 64;

endpackage
