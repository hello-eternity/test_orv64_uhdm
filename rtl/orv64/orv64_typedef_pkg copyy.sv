// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

package orv64_typedef_pkg;

  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv64_param_pkg::*;

  typedef logic [ORV64_XLEN-1:0]           orv64_data_t; // data
  typedef logic [31:0]                     orv64_data32_t; // 32-bit data
  typedef logic [ORV64_VIR_ADDR_WIDTH-1:0] orv64_vaddr_t; // virtual address
  typedef logic [ORV64_PHY_ADDR_WIDTH-1:0] orv64_paddr_t; // physical address
  typedef logic [31:0]                     orv64_inst_t; // instruction
  typedef logic [4:0]                      orv64_reg_addr_t; // register file address
  typedef logic [7:0]                      orv64_data_byte_mask_t; // data
  typedef logic [ORV64_CNTR_WIDTH-1:0]     orv64_cntr_t;

  typedef enum logic [1:0] {
    ORV64_NPC_AVAIL_IF = 2'h0,
    ORV64_NPC_AVAIL_ID = 2'h1,
    ORV64_NPC_AVAIL_EX = 2'h2,
    ORV64_NPC_AVAIL_MA = 2'h3
  } orv64_npc_avail_t;

  typedef enum logic {
    ORV64_RD_AVAIL_EX,
    ORV64_RD_AVAIL_MA
  } orv64_rd_avail_t;

  typedef enum logic [4:0] { // {{{
    ORV64_LOAD      = 5'h00,
    ORV64_MISC_MEM  = 5'h03,
    ORV64_OP_IMM    = 5'h04,
    ORV64_AUIPC     = 5'h05,
    ORV64_OP_IMM_32 = 5'h06,
    ORV64_STORE     = 5'h08,
    // AMO
    ORV64_AMO		= 5'h0B,   // LR.D, SC.D, AMOSWAP.D, AMOADD.D, AMOXOR.D, AMOAND.D, AMOOR.D, AMOMIN.D, AMOMAX.D, AMOMINU.D, AMOMAXU.D 
    ORV64_OP        = 5'h0C,
    ORV64_LUI       = 5'h0D,
    ORV64_OP_32     = 5'h0E,
    ORV64_BRANCH    = 5'h18,
    ORV64_JALR      = 5'h19,
    ORV64_JAL       = 5'h1B,
    ORV64_SYSTEM    = 5'h1C,
    ORV64_LOAD_FP   = 5'h01,
    ORV64_STORE_FP  = 5'h09,
    ORV64_OP_FP     = 5'h14,
    ORV64_FMADD     = 5'h10,
    ORV64_FMSUB     = 5'h11,
    ORV64_FNMADD    = 5'h13,
    ORV64_FNMSUB    = 5'h12
  } orv64_opcode_t;

  typedef enum logic [4:0] { // {{{
    ORV64_ALU_OP_ADD    = 5'h00,
    ORV64_ALU_OP_SLL    = 5'h01,
    ORV64_ALU_OP_SEQ    = 5'h02,
    ORV64_ALU_OP_SNE    = 5'h03,
    ORV64_ALU_OP_XOR    = 5'h04,
    ORV64_ALU_OP_SRL    = 5'h05,
    ORV64_ALU_OP_OR     = 5'h06,
    ORV64_ALU_OP_AND    = 5'h07,
    ORV64_ALU_OP_SUB    = 5'h0A,
    ORV64_ALU_OP_SRA    = 5'h0B,
    ORV64_ALU_OP_SLT    = 5'h0C,
    ORV64_ALU_OP_SGE    = 5'h0D,
    ORV64_ALU_OP_SLTU   = 5'h0E,
    ORV64_ALU_OP_SGEU   = 5'h0F,
    ORV64_ALU_OP_MIN    = 5'h10,
    ORV64_ALU_OP_MAX    = 5'h11,
    ORV64_ALU_OP_MIN_U  = 5'h12,
    ORV64_ALU_OP_MAX_U  = 5'h13,
    ORV64_ALU_OP_SWAP   = 5'h14
    // }}}
  } orv64_alu_op_t;

  typedef enum logic [1:0] { // {{{
    ORV64_OP1_SEL_RS1,
    ORV64_OP1_SEL_FP_RS1,
    ORV64_OP1_SEL_FP_RS1_SEXT,
    ORV64_OP1_SEL_ZERO // }}}
  } orv64_op1_sel_t;

  typedef enum logic [1:0]{ // {{{
    ORV64_OP2_SEL_0,
    ORV64_OP2_SEL_RS2,
    ORV64_OP2_SEL_IMM // }}}
  } orv64_op2_sel_t;

  typedef enum logic [2:0] { // {{{
    ORV64_IMM_SEL_I,
    ORV64_IMM_SEL_S,
    ORV64_IMM_SEL_B,
    ORV64_IMM_SEL_U,
    ORV64_IMM_SEL_J,
    ORV64_IMM_SEL_Z,
    ORV64_IMM_SEL_F0,
    ORV64_IMM_SEL_ZERO // }}}
  } orv64_imm_sel_t;

  typedef enum logic { // {{{
    ORV64_EX_PC_SEL_P4,
    ORV64_EX_PC_SEL_IMM // }}}
  } orv64_ex_pc_sel_t;

  typedef enum logic [3:0] { // {{{
    ORV64_EX_OUT_SEL_RS1,
    ORV64_EX_OUT_SEL_ALU_OUT,
    ORV64_EX_OUT_SEL_PC_ADDER,
    ORV64_EX_OUT_SEL_MUL_L,
    ORV64_EX_OUT_SEL_MUL_H,
    ORV64_EX_OUT_SEL_DIV_Q,
    ORV64_EX_OUT_SEL_DIV_R,
    ORV64_EX_OUT_SEL_FP,
    ORV64_EX_OUT_SEL_FP_MV,
    ORV64_EX_OUT_SEL_NONE // }}}
  } orv64_ex_out_sel_t;

  typedef enum logic [2:0] { // {{{
    ORV64_MA_BYTE_SEL_1   = 3'h0,
    ORV64_MA_BYTE_SEL_U1  = 3'h1,
    ORV64_MA_BYTE_SEL_2   = 3'h2,
    ORV64_MA_BYTE_SEL_U2  = 3'h3,
    ORV64_MA_BYTE_SEL_4   = 3'h4,
    ORV64_MA_BYTE_SEL_U4  = 3'h5,
    ORV64_MA_BYTE_SEL_8   = 3'h6
    // }}}
  } orv64_ma_byte_sel_t;

  typedef enum logic [2:0] { // {{{
    ORV64_MUL_TYPE_L,
    ORV64_MUL_TYPE_HSS,
    ORV64_MUL_TYPE_HUU,
    ORV64_MUL_TYPE_HSU,
    ORV64_MUL_TYPE_W,
    ORV64_MUL_TYPE_NONE // }}}
  } orv64_mul_type_t;

  typedef enum logic [3:0] { // {{{
    ORV64_DIV_TYPE_Q,
    ORV64_DIV_TYPE_R,
    ORV64_DIV_TYPE_QU,
    ORV64_DIV_TYPE_RU,
    ORV64_DIV_TYPE_QW,
    ORV64_DIV_TYPE_RW,
    ORV64_DIV_TYPE_QUW,
    ORV64_DIV_TYPE_RUW,
    ORV64_DIV_TYPE_NONE // }}}
  } orv64_div_type_t;

  typedef enum logic [1:0] { // {{{
    ORV64_RD_SEL_EX_OUT,
    ORV64_RD_SEL_MEM_READ,
    ORV64_RD_SEL_CSR_READ // }}}
  } orv64_rd_sel_t;

  typedef enum logic [1:0] { // {{{
    ORV64_RET_TYPE_U,
    ORV64_RET_TYPE_S,
    ORV64_RET_TYPE_M,
    ORV64_RET_TYPE_NONE // }}}
  } orv64_ret_type_t;

  typedef logic [ORV64_CSR_ADDR_RW_PRV_WIDTH-1:0] orv64_csr_addr_rw_prv_field_t;

  typedef enum logic [11:0] { // {{{
    // non-isa defined CSR  {{{
    ORV64_CSR_ADDR_CFG              = 12'h600,
    ORV64_CSR_ADDR_TIMER            = 12'h601,

`ifdef ORV64_SUPPORT_DMA
    ORV64_CSR_ADDR_DMA_DONE         = 12'h602,
`endif

`ifdef ORV64_SUPPORT_UART
    ORV64_CSR_ADDR_TO_UART          = 12'h610,
    ORV64_CSR_ADDR_FROM_UART        = 12'h611,
`endif


    // isa defined CSR {{{
    
    // M mode accessible registers
    ORV64_CSR_ADDR_MSTATUS         = 12'h300,
    ORV64_CSR_ADDR_MISA            = 12'h301,
    ORV64_CSR_ADDR_MEDELEG         = 12'h302,
    ORV64_CSR_ADDR_MIDELEG         = 12'h303,
    ORV64_CSR_ADDR_MIE             = 12'h304,
    ORV64_CSR_ADDR_MTVEC           = 12'h305,
    ORV64_CSR_ADDR_MCOUNTEREN      = 12'h306,
    ORV64_CSR_ADDR_MSCRATCH        = 12'h340,
    ORV64_CSR_ADDR_MEPC            = 12'h341,
    ORV64_CSR_ADDR_MCAUSE          = 12'h342,
    ORV64_CSR_ADDR_MTVAL           = 12'h343,
    ORV64_CSR_ADDR_MIP             = 12'h344,
    ORV64_CSR_ADDR_PMPCFG0         = 12'h3A0,
    ORV64_CSR_ADDR_PMPCFG1         = 12'h3A1,
    ORV64_CSR_ADDR_PMPCFG2         = 12'h3A2,
    ORV64_CSR_ADDR_PMPCFG3         = 12'h3A3,
    ORV64_CSR_ADDR_PMPADDR0        = 12'h3B0,
    ORV64_CSR_ADDR_PMPADDR1        = 12'h3B1,
    ORV64_CSR_ADDR_PMPADDR2        = 12'h3B2,
    ORV64_CSR_ADDR_PMPADDR3        = 12'h3B3,
    ORV64_CSR_ADDR_PMPADDR4        = 12'h3B4,
    ORV64_CSR_ADDR_PMPADDR5        = 12'h3B5,
    ORV64_CSR_ADDR_PMPADDR6        = 12'h3B6,
    ORV64_CSR_ADDR_PMPADDR7        = 12'h3B7,
    ORV64_CSR_ADDR_PMPADDR8        = 12'h3B8,
    ORV64_CSR_ADDR_PMPADDR9        = 12'h3B9,
    ORV64_CSR_ADDR_PMPADDR10       = 12'h3BA,
    ORV64_CSR_ADDR_PMPADDR11       = 12'h3BB,
    ORV64_CSR_ADDR_PMPADDR12       = 12'h3BC,
    ORV64_CSR_ADDR_PMPADDR13       = 12'h3BD,
    ORV64_CSR_ADDR_PMPADDR14       = 12'h3BE,
    ORV64_CSR_ADDR_PMPADDR15       = 12'h3BF,
    ORV64_CSR_ADDR_MCOUNTINHIBIT   = 12'h320,
    ORV64_CSR_ADDR_MHPMEVENT3      = 12'h323,
    ORV64_CSR_ADDR_MHPMEVENT4      = 12'h324,
    ORV64_CSR_ADDR_MHPMEVENT5      = 12'h325,
    ORV64_CSR_ADDR_MHPMEVENT6      = 12'h326,
    ORV64_CSR_ADDR_MHPMEVENT7      = 12'h327,
    ORV64_CSR_ADDR_MHPMEVENT8      = 12'h328,
    ORV64_CSR_ADDR_MHPMEVENT9      = 12'h329,
    ORV64_CSR_ADDR_MHPMEVENT10     = 12'h32A,
    ORV64_CSR_ADDR_MHPMEVENT11     = 12'h32B,
    ORV64_CSR_ADDR_MHPMEVENT12     = 12'h32C,
    ORV64_CSR_ADDR_MHPMEVENT13     = 12'h32D,
    ORV64_CSR_ADDR_MHPMEVENT14     = 12'h32E,
    ORV64_CSR_ADDR_MHPMEVENT15     = 12'h32F,
    ORV64_CSR_ADDR_MHPMEVENT16     = 12'h330,
    ORV64_CSR_ADDR_MHPMEVENT17     = 12'h331,
    ORV64_CSR_ADDR_MHPMEVENT18     = 12'h332,
    ORV64_CSR_ADDR_MHPMEVENT19     = 12'h333,
    ORV64_CSR_ADDR_MHPMEVENT20     = 12'h334,
    ORV64_CSR_ADDR_MHPMEVENT21     = 12'h335,
    ORV64_CSR_ADDR_MHPMEVENT22     = 12'h336,
    ORV64_CSR_ADDR_MHPMEVENT23     = 12'h337,
    ORV64_CSR_ADDR_MHPMEVENT24     = 12'h338,
    ORV64_CSR_ADDR_MHPMEVENT25     = 12'h339,
    ORV64_CSR_ADDR_MHPMEVENT26     = 12'h33A,
    ORV64_CSR_ADDR_MHPMEVENT27     = 12'h33B,
    ORV64_CSR_ADDR_MHPMEVENT28     = 12'h33C,
    ORV64_CSR_ADDR_MHPMEVENT29     = 12'h33D,
    ORV64_CSR_ADDR_MHPMEVENT30     = 12'h33E,
    ORV64_CSR_ADDR_MHPMEVENT31     = 12'h33F,
    ORV64_CSR_ADDR_TSELECT         = 12'h7A0,
    ORV64_CSR_ADDR_TDATA1          = 12'h7A1,
    ORV64_CSR_ADDR_TDATA2          = 12'h7A2,
    ORV64_CSR_ADDR_TDATA3          = 12'h7A3,
    ORV64_CSR_ADDR_DCSR            = 12'h7B0,
    ORV64_CSR_ADDR_DPC             = 12'h7B1,
    ORV64_CSR_ADDR_DSCRATCH        = 12'h7B2,
    ORV64_CSR_ADDR_MCYCLE          = 12'hB00,
    ORV64_CSR_ADDR_MINSTRET        = 12'hB02,
    ORV64_CSR_ADDR_MHPMCOUNTER3    = 12'hB03,
    ORV64_CSR_ADDR_MHPMCOUNTER4    = 12'hB04,
    ORV64_CSR_ADDR_MHPMCOUNTER5    = 12'hB05,
    ORV64_CSR_ADDR_MHPMCOUNTER6    = 12'hB06,
    ORV64_CSR_ADDR_MHPMCOUNTER7    = 12'hB07,
    ORV64_CSR_ADDR_MHPMCOUNTER8    = 12'hB08,
    ORV64_CSR_ADDR_MHPMCOUNTER9    = 12'hB09,
    ORV64_CSR_ADDR_MHPMCOUNTER10   = 12'hB0A,
    ORV64_CSR_ADDR_MHPMCOUNTER11   = 12'hB0B,
    ORV64_CSR_ADDR_MHPMCOUNTER12   = 12'hB0C,
    ORV64_CSR_ADDR_MHPMCOUNTER13   = 12'hB0D,
    ORV64_CSR_ADDR_MHPMCOUNTER14   = 12'hB0E,
    ORV64_CSR_ADDR_MHPMCOUNTER15   = 12'hB0F,
    ORV64_CSR_ADDR_MHPMCOUNTER16   = 12'hB10,
    ORV64_CSR_ADDR_MHPMCOUNTER17   = 12'hB11,
    ORV64_CSR_ADDR_MHPMCOUNTER18   = 12'hB12,
    ORV64_CSR_ADDR_MHPMCOUNTER19   = 12'hB13,
    ORV64_CSR_ADDR_MHPMCOUNTER20   = 12'hB14,
    ORV64_CSR_ADDR_MHPMCOUNTER21   = 12'hB15,
    ORV64_CSR_ADDR_MHPMCOUNTER22   = 12'hB16,
    ORV64_CSR_ADDR_MHPMCOUNTER23   = 12'hB17,
    ORV64_CSR_ADDR_MHPMCOUNTER24   = 12'hB18,
    ORV64_CSR_ADDR_MHPMCOUNTER25   = 12'hB19,
    ORV64_CSR_ADDR_MHPMCOUNTER26   = 12'hB1A,
    ORV64_CSR_ADDR_MHPMCOUNTER27   = 12'hB1B,
    ORV64_CSR_ADDR_MHPMCOUNTER28   = 12'hB1C,
    ORV64_CSR_ADDR_MHPMCOUNTER29   = 12'hB1D,
    ORV64_CSR_ADDR_MHPMCOUNTER30   = 12'hB1E,
    ORV64_CSR_ADDR_MHPMCOUNTER31   = 12'hB1F,
    ORV64_CSR_ADDR_MVENDORID       = 12'hF11,
    ORV64_CSR_ADDR_MARCHID         = 12'hF12,
    ORV64_CSR_ADDR_MIMPID          = 12'hF13,
    ORV64_CSR_ADDR_MHARTID         = 12'hF14,

    // S mode accessible csrs
    ORV64_CSR_ADDR_SSTATUS         = 12'h100,
    ORV64_CSR_ADDR_SEDELEG         = 12'h102,
    ORV64_CSR_ADDR_SIDELEG         = 12'h103,
    ORV64_CSR_ADDR_SIE             = 12'h104,
    ORV64_CSR_ADDR_STVEC           = 12'h105,
    ORV64_CSR_ADDR_SCOUNTEREN      = 12'h106,
    ORV64_CSR_ADDR_SSCRATCH        = 12'h140,
    ORV64_CSR_ADDR_SEPC            = 12'h141,
    ORV64_CSR_ADDR_SCAUSE          = 12'h142,
    ORV64_CSR_ADDR_STVAL           = 12'h143,
    ORV64_CSR_ADDR_SIP             = 12'h144,
    ORV64_CSR_ADDR_SATP            = 12'h180,

    // U mode accessible csrs
    ORV64_CSR_ADDR_USTATUS         = 12'h000,
    ORV64_CSR_ADDR_UIE             = 12'h004,
    ORV64_CSR_ADDR_UTVEC           = 12'h005,
    ORV64_CSR_ADDR_USCRATCH        = 12'h040,
    ORV64_CSR_ADDR_UEPC            = 12'h041,
    ORV64_CSR_ADDR_UCAUSE          = 12'h042,
    ORV64_CSR_ADDR_UTVAL           = 12'h043,
    ORV64_CSR_ADDR_UIP             = 12'h044,
    ORV64_CSR_ADDR_FFLAGS          = 12'h001,
    ORV64_CSR_ADDR_FRM             = 12'h002,
    ORV64_CSR_ADDR_FCSR            = 12'h003,
    ORV64_CSR_ADDR_CYCLE           = 12'hC00,
    ORV64_CSR_ADDR_TIME            = 12'hC01,
    ORV64_CSR_ADDR_INSTRET         = 12'hC02,
    ORV64_CSR_ADDR_HPMCOUNTER3     = 12'hC03,
    ORV64_CSR_ADDR_HPMCOUNTER4     = 12'hC04,
    ORV64_CSR_ADDR_HPMCOUNTER5     = 12'hC05,
    ORV64_CSR_ADDR_HPMCOUNTER6     = 12'hC06,
    ORV64_CSR_ADDR_HPMCOUNTER7     = 12'hC07,
    ORV64_CSR_ADDR_HPMCOUNTER8     = 12'hC08,
    ORV64_CSR_ADDR_HPMCOUNTER9     = 12'hC09,
    ORV64_CSR_ADDR_HPMCOUNTER10    = 12'hC0A,
    ORV64_CSR_ADDR_HPMCOUNTER11    = 12'hC0B,
    ORV64_CSR_ADDR_HPMCOUNTER12    = 12'hC0C,
    ORV64_CSR_ADDR_HPMCOUNTER13    = 12'hC0D,
    ORV64_CSR_ADDR_HPMCOUNTER14    = 12'hC0E,
    ORV64_CSR_ADDR_HPMCOUNTER15    = 12'hC0F,
    ORV64_CSR_ADDR_HPMCOUNTER16    = 12'hC10,
    ORV64_CSR_ADDR_HPMCOUNTER17    = 12'hC11,
    ORV64_CSR_ADDR_HPMCOUNTER18    = 12'hC12,
    ORV64_CSR_ADDR_HPMCOUNTER19    = 12'hC13,
    ORV64_CSR_ADDR_HPMCOUNTER20    = 12'hC14,
    ORV64_CSR_ADDR_HPMCOUNTER21    = 12'hC15,
    ORV64_CSR_ADDR_HPMCOUNTER22    = 12'hC16,
    ORV64_CSR_ADDR_HPMCOUNTER23    = 12'hC17,
    ORV64_CSR_ADDR_HPMCOUNTER24    = 12'hC18,
    ORV64_CSR_ADDR_HPMCOUNTER25    = 12'hC19,
    ORV64_CSR_ADDR_HPMCOUNTER26    = 12'hC1A,
    ORV64_CSR_ADDR_HPMCOUNTER27    = 12'hC1B,
    ORV64_CSR_ADDR_HPMCOUNTER28    = 12'hC1C,
    ORV64_CSR_ADDR_HPMCOUNTER29    = 12'hC1D,
    ORV64_CSR_ADDR_HPMCOUNTER30    = 12'hC1E,
    ORV64_CSR_ADDR_HPMCOUNTER31    = 12'hC1F // }}}
  } orv64_csr_addr_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
    ORV64_CSR_GRP0_USTATUS         = 8'h00,
    ORV64_CSR_GRP0_UIE             = 8'h04,
    ORV64_CSR_GRP0_UTVEC           = 8'h05,
    ORV64_CSR_GRP0_USCRATCH        = 8'h40,
    ORV64_CSR_GRP0_UEPC            = 8'h41,
    ORV64_CSR_GRP0_UCAUSE          = 8'h42,
    ORV64_CSR_GRP0_UTVAL           = 8'h43,
    ORV64_CSR_GRP0_UIP             = 8'h44,
    ORV64_CSR_GRP0_FFLAGS          = 8'h01,
    ORV64_CSR_GRP0_FRM             = 8'h02,
    ORV64_CSR_GRP0_FCSR            = 8'h03
  } orv64_csr_grp0_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
    ORV64_CSR_GRP1_SSTATUS         = 8'h00,
    ORV64_CSR_GRP1_SEDELEG         = 8'h02,
    ORV64_CSR_GRP1_SIDELEG         = 8'h03,
    ORV64_CSR_GRP1_SIE             = 8'h04,
    ORV64_CSR_GRP1_STVEC           = 8'h05,
    ORV64_CSR_GRP1_SCOUNTEREN      = 8'h06,
    ORV64_CSR_GRP1_SSCRATCH        = 8'h40,
    ORV64_CSR_GRP1_SEPC            = 8'h41,
    ORV64_CSR_GRP1_SCAUSE          = 8'h42,
    ORV64_CSR_GRP1_STVAL           = 8'h43,
    ORV64_CSR_GRP1_SIP             = 8'h44,
    ORV64_CSR_GRP1_SATP            = 8'h80
  } orv64_csr_grp1_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
    ORV64_CSR_GRP3_MSTATUS         = 8'h00,
    ORV64_CSR_GRP3_MISA            = 8'h01,
    ORV64_CSR_GRP3_MEDELEG         = 8'h02,
    ORV64_CSR_GRP3_MIDELEG         = 8'h03,
    ORV64_CSR_GRP3_MIE             = 8'h04,
    ORV64_CSR_GRP3_MTVEC           = 8'h05,
    ORV64_CSR_GRP3_MCOUNTEREN      = 8'h06,
    ORV64_CSR_GRP3_MSCRATCH        = 8'h40,
    ORV64_CSR_GRP3_MEPC            = 8'h41,
    ORV64_CSR_GRP3_MCAUSE          = 8'h42,
    ORV64_CSR_GRP3_MTVAL           = 8'h43,
    ORV64_CSR_GRP3_MIP             = 8'h44,
    ORV64_CSR_GRP3_PMPCFG0         = 8'hA0,
    ORV64_CSR_GRP3_PMPCFG1         = 8'hA1,
    ORV64_CSR_GRP3_PMPCFG2         = 8'hA2,
    ORV64_CSR_GRP3_PMPCFG3         = 8'hA3,
    ORV64_CSR_GRP3_PMPADDR0        = 8'hB0,
    ORV64_CSR_GRP3_PMPADDR1        = 8'hB1,
    ORV64_CSR_GRP3_PMPADDR2        = 8'hB2,
    ORV64_CSR_GRP3_PMPADDR3        = 8'hB3,
    ORV64_CSR_GRP3_PMPADDR4        = 8'hB4,
    ORV64_CSR_GRP3_PMPADDR5        = 8'hB5,
    ORV64_CSR_GRP3_PMPADDR6        = 8'hB6,
    ORV64_CSR_GRP3_PMPADDR7        = 8'hB7,
    ORV64_CSR_GRP3_PMPADDR8        = 8'hB8,
    ORV64_CSR_GRP3_PMPADDR9        = 8'hB9,
    ORV64_CSR_GRP3_PMPADDR10       = 8'hBA,
    ORV64_CSR_GRP3_PMPADDR11       = 8'hBB,
    ORV64_CSR_GRP3_PMPADDR12       = 8'hBC,
    ORV64_CSR_GRP3_PMPADDR13       = 8'hBD,
    ORV64_CSR_GRP3_PMPADDR14       = 8'hBE,
    ORV64_CSR_GRP3_PMPADDR15       = 8'hBF,
    ORV64_CSR_GRP3_MCOUNTINHIBIT   = 8'h20,
    ORV64_CSR_GRP3_MHPMEVENT3      = 8'h23,
    ORV64_CSR_GRP3_MHPMEVENT4      = 8'h24,
    ORV64_CSR_GRP3_MHPMEVENT5      = 8'h25,
    ORV64_CSR_GRP3_MHPMEVENT6      = 8'h26,
    ORV64_CSR_GRP3_MHPMEVENT7      = 8'h27,
    ORV64_CSR_GRP3_MHPMEVENT8      = 8'h28,
    ORV64_CSR_GRP3_MHPMEVENT9      = 8'h29,
    ORV64_CSR_GRP3_MHPMEVENT10     = 8'h2A,
    ORV64_CSR_GRP3_MHPMEVENT11     = 8'h2B,
    ORV64_CSR_GRP3_MHPMEVENT12     = 8'h2C,
    ORV64_CSR_GRP3_MHPMEVENT13     = 8'h2D,
    ORV64_CSR_GRP3_MHPMEVENT14     = 8'h2E,
    ORV64_CSR_GRP3_MHPMEVENT15     = 8'h2F,
    ORV64_CSR_GRP3_MHPMEVENT16     = 8'h30,
    ORV64_CSR_GRP3_MHPMEVENT17     = 8'h31,
    ORV64_CSR_GRP3_MHPMEVENT18     = 8'h32,
    ORV64_CSR_GRP3_MHPMEVENT19     = 8'h33,
    ORV64_CSR_GRP3_MHPMEVENT20     = 8'h34,
    ORV64_CSR_GRP3_MHPMEVENT21     = 8'h35,
    ORV64_CSR_GRP3_MHPMEVENT22     = 8'h36,
    ORV64_CSR_GRP3_MHPMEVENT23     = 8'h37,
    ORV64_CSR_GRP3_MHPMEVENT24     = 8'h38,
    ORV64_CSR_GRP3_MHPMEVENT25     = 8'h39,
    ORV64_CSR_GRP3_MHPMEVENT26     = 8'h3A,
    ORV64_CSR_GRP3_MHPMEVENT27     = 8'h3B,
    ORV64_CSR_GRP3_MHPMEVENT28     = 8'h3C,
    ORV64_CSR_GRP3_MHPMEVENT29     = 8'h3D,
    ORV64_CSR_GRP3_MHPMEVENT30     = 8'h3E,
    ORV64_CSR_GRP3_MHPMEVENT31     = 8'h3F
  } orv64_csr_grp3_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
`ifdef ORV64_SUPPORT_DMA
    ORV64_CSR_GRP6_DMA_DONE         = 8'h02,
`endif

`ifdef ORV64_SUPPORT_UART
    ORV64_CSR_GRP6_TO_UART          = 8'h10,
    ORV64_CSR_GRP6_FROM_UART        = 8'h11,
`endif

`ifdef VECTOR_GEN2
    ORV64_CSR_GRP6_SP2VP_VPREDREG_VLEN          = 8'hF0,
    ORV64_CSR_GRP6_SP2VP_VPREDREG_VLS_VLEN_GRPDEPTH_RATIO  = 8'hF1,
    ORV64_CSR_GRP6_SP2VP_VPREDREG_VLS_GRPDEPTH  = 8'hF3,
    ORV64_CSR_GRP6_SP2VP_VPREDREG_VLS_GRPSTRIDE = 8'hF5,
`endif
    ORV64_CSR_GRP6_CFG              = 8'h00,
    ORV64_CSR_GRP6_TIMER            = 8'h01
  } orv64_csr_grp6_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
    ORV64_CSR_GRPB_MCYCLE          = 8'h00,
    ORV64_CSR_GRPB_MINSTRET        = 8'h02,
    ORV64_CSR_GRPB_MHPMCOUNTER3    = 8'h03,
    ORV64_CSR_GRPB_MHPMCOUNTER4    = 8'h04,
    ORV64_CSR_GRPB_MHPMCOUNTER5    = 8'h05,
    ORV64_CSR_GRPB_MHPMCOUNTER6    = 8'h06,
    ORV64_CSR_GRPB_MHPMCOUNTER7    = 8'h07,
    ORV64_CSR_GRPB_MHPMCOUNTER8    = 8'h08,
    ORV64_CSR_GRPB_MHPMCOUNTER9    = 8'h09,
    ORV64_CSR_GRPB_MHPMCOUNTER10   = 8'h0A,
    ORV64_CSR_GRPB_MHPMCOUNTER11   = 8'h0B,
    ORV64_CSR_GRPB_MHPMCOUNTER12   = 8'h0C,
    ORV64_CSR_GRPB_MHPMCOUNTER13   = 8'h0D,
    ORV64_CSR_GRPB_MHPMCOUNTER14   = 8'h0E,
    ORV64_CSR_GRPB_MHPMCOUNTER15   = 8'h0F,
    ORV64_CSR_GRPB_MHPMCOUNTER16   = 8'h10,
    ORV64_CSR_GRPB_MHPMCOUNTER17   = 8'h11,
    ORV64_CSR_GRPB_MHPMCOUNTER18   = 8'h12,
    ORV64_CSR_GRPB_MHPMCOUNTER19   = 8'h13,
    ORV64_CSR_GRPB_MHPMCOUNTER20   = 8'h14,
    ORV64_CSR_GRPB_MHPMCOUNTER21   = 8'h15,
    ORV64_CSR_GRPB_MHPMCOUNTER22   = 8'h16,
    ORV64_CSR_GRPB_MHPMCOUNTER23   = 8'h17,
    ORV64_CSR_GRPB_MHPMCOUNTER24   = 8'h18,
    ORV64_CSR_GRPB_MHPMCOUNTER25   = 8'h19,
    ORV64_CSR_GRPB_MHPMCOUNTER26   = 8'h1A,
    ORV64_CSR_GRPB_MHPMCOUNTER27   = 8'h1B,
    ORV64_CSR_GRPB_MHPMCOUNTER28   = 8'h1C,
    ORV64_CSR_GRPB_MHPMCOUNTER29   = 8'h1D,
    ORV64_CSR_GRPB_MHPMCOUNTER30   = 8'h1E,
    ORV64_CSR_GRPB_MHPMCOUNTER31   = 8'h1F
  } orv64_csr_grpb_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
    ORV64_CSR_GRPC_CYCLE           = 8'h00,
    ORV64_CSR_GRPC_TIME            = 8'h01,
    ORV64_CSR_GRPC_INSTRET         = 8'h02,
    ORV64_CSR_GRPC_HPMCOUNTER3     = 8'h03,
    ORV64_CSR_GRPC_HPMCOUNTER4     = 8'h04,
    ORV64_CSR_GRPC_HPMCOUNTER5     = 8'h05,
    ORV64_CSR_GRPC_HPMCOUNTER6     = 8'h06,
    ORV64_CSR_GRPC_HPMCOUNTER7     = 8'h07,
    ORV64_CSR_GRPC_HPMCOUNTER8     = 8'h08,
    ORV64_CSR_GRPC_HPMCOUNTER9     = 8'h09,
    ORV64_CSR_GRPC_HPMCOUNTER10    = 8'h0A,
    ORV64_CSR_GRPC_HPMCOUNTER11    = 8'h0B,
    ORV64_CSR_GRPC_HPMCOUNTER12    = 8'h0C,
    ORV64_CSR_GRPC_HPMCOUNTER13    = 8'h0D,
    ORV64_CSR_GRPC_HPMCOUNTER14    = 8'h0E,
    ORV64_CSR_GRPC_HPMCOUNTER15    = 8'h0F,
    ORV64_CSR_GRPC_HPMCOUNTER16    = 8'h10,
    ORV64_CSR_GRPC_HPMCOUNTER17    = 8'h11,
    ORV64_CSR_GRPC_HPMCOUNTER18    = 8'h12,
    ORV64_CSR_GRPC_HPMCOUNTER19    = 8'h13,
    ORV64_CSR_GRPC_HPMCOUNTER20    = 8'h14,
    ORV64_CSR_GRPC_HPMCOUNTER21    = 8'h15,
    ORV64_CSR_GRPC_HPMCOUNTER22    = 8'h16,
    ORV64_CSR_GRPC_HPMCOUNTER23    = 8'h17,
    ORV64_CSR_GRPC_HPMCOUNTER24    = 8'h18,
    ORV64_CSR_GRPC_HPMCOUNTER25    = 8'h19,
    ORV64_CSR_GRPC_HPMCOUNTER26    = 8'h1A,
    ORV64_CSR_GRPC_HPMCOUNTER27    = 8'h1B,
    ORV64_CSR_GRPC_HPMCOUNTER28    = 8'h1C,
    ORV64_CSR_GRPC_HPMCOUNTER29    = 8'h1D,
    ORV64_CSR_GRPC_HPMCOUNTER30    = 8'h1E,
    ORV64_CSR_GRPC_HPMCOUNTER31    = 8'h1F // }}}
  } orv64_csr_grpc_t;
  typedef enum logic [ORV64_CSR_ADDR_CUT_WIDTH-1:0] {
    ORV64_CSR_GRPF_MVENDORID       = 8'h11,
    ORV64_CSR_GRPF_MARCHID         = 8'h12,
    ORV64_CSR_GRPF_MIMPID          = 8'h13,
    ORV64_CSR_GRPF_MHARTID         = 8'h14
  } orv64_csr_grpf_t;
  typedef enum logic [1:0] { // {{{
    ORV64_PRV_U = 2'b00,
    ORV64_PRV_S = 2'b01,
    ORV64_PRV_M = 2'b11 // }}}
  } orv64_prv_t;
  typedef enum logic [1:0] { // {{{
    ORV64_CSR_OP_RW = 2'b01,
    ORV64_CSR_OP_RS = 2'b10,
    ORV64_CSR_OP_RC = 2'b11,
    ORV64_CSR_OP_NONE = 2'b00 // }}}
  } orv64_csr_op_t;
  typedef struct packed { // {{{
    logic Z;
    logic Y;
    logic X;
    logic W;
    logic V;
    logic U;
    logic T;
    logic S;
    logic R;
    logic Q;
    logic P;
    logic O;
    logic N;
    logic M;
    logic L;
    logic K;
    logic J;
    logic I;
    logic H;
    logic G;
    logic F;
    logic E;
    logic D;
    logic C;
    logic B;
    logic A;// }}}
  } orv64_misa_ext_t;
  typedef struct packed { // {{{
    logic [ 1:0]  MXL; // [63:62]
    // logic [35:0]  reserved_61_to_26;
    orv64_misa_ext_t  EXTENSIONS; // [25:0] }}}
  } orv64_csr_misa_t;
  typedef struct packed { // {{{
    logic         SD;
    logic         BYPASS_IC;
    logic [25:0]  reserved_61_to_36;
    logic [ 1:0]  SXL;
    logic [ 1:0]  UXL;
    logic [ 8:0]  reserved_31_to_23;
    logic         TSR;
    logic         TW;
    logic         TVM;
    logic         MXR;
    logic         SUM;
    logic         MPRV;
    logic [ 1:0]  XS;
    logic [ 1:0]  FS;
    orv64_prv_t   MPP;
    logic [ 1:0]  reserved_10_to_9;
    logic         SPP;
    logic         MPIE;
    logic         reserved_6;
    logic         SPIE;
    logic         UPIE;
    logic         MIE;
    logic         reserved_2;
    logic         SIE;
    logic         UIE; // }}}
  } orv64_csr_mstatus_t;
  typedef enum logic [1:0] { // {{{
    ORV64_CSR_TVEC_DIRECT = 2'b00,
    ORV64_CSR_TVEC_VECTORED = 2'b01,
    ORV64_CSR_TVEC_RSVD0 = 2'b10,
    ORV64_CSR_TVEC_RSVD1 = 2'b11 // }}}
  } orv64_csr_tvec_mode_t;
  typedef struct packed { // {{{
    logic [61:0]  base;
    orv64_csr_tvec_mode_t mode; // }}}
  } orv64_csr_tvec_t;
  typedef enum logic [63:0] { // {{{
    ORV64_TRAP_CAUSE_U_SW_INT = {1'b1, 63'('d0)},
    ORV64_TRAP_CAUSE_S_SW_INT = {1'b1, 63'('d1)},
    ORV64_TRAP_CAUSE_M_SW_INT = {1'b1, 63'('d3)},
    ORV64_TRAP_CAUSE_U_TIME_INT = {1'b1, 63'('d4)},
    ORV64_TRAP_CAUSE_S_TIME_INT = {1'b1, 63'('d5)},
    ORV64_TRAP_CAUSE_M_TIME_INT = {1'b1, 63'('d7)},
    ORV64_TRAP_CAUSE_U_EXT_INT = {1'b1, 63'('d8)},
    ORV64_TRAP_CAUSE_S_EXT_INT = {1'b1, 63'('d9)},
    ORV64_TRAP_CAUSE_M_EXT_INT = {1'b1, 63'('d11)},
    ORV64_TRAP_CAUSE_INST_ADDR_MISALIGNED = {1'b0, 63'('d0)},
    ORV64_TRAP_CAUSE_INST_ACCESS_FAULT = {1'b0, 63'('d1)},
    ORV64_TRAP_CAUSE_ILLEGAL_INST = {1'b0, 63'('d2)},
    ORV64_TRAP_CAUSE_BREAKPOINT = {1'b0, 63'('d3)},
    ORV64_TRAP_CAUSE_LOAD_ADDR_MISALIGNED = {1'b0, 63'('d4)},
    ORV64_TRAP_CAUSE_LOAD_ACCESS_FAULT = {1'b0, 63'('d5)},
    ORV64_TRAP_CAUSE_STORE_ADDR_MISALIGNED = {1'b0, 63'('d6)},
    ORV64_TRAP_CAUSE_STORE_ACCESS_FAULT = {1'b0, 63'('d7)},
    ORV64_TRAP_CAUSE_ECALL_FROM_U = {1'b0, 63'('d8)},
    ORV64_TRAP_CAUSE_ECALL_FROM_S = {1'b0, 63'('d9)},
    ORV64_TRAP_CAUSE_ECALL_FROM_M = {1'b0, 63'('d11)},
    ORV64_TRAP_CAUSE_INST_PAGE_FAULT = {1'b0, 63'('d12)},
    ORV64_TRAP_CAUSE_LOAD_PAGE_FAULT = {1'b0, 63'('d13)},
    ORV64_TRAP_CAUSE_STORE_PAGE_FAULT = {1'b0, 63'('d15)}
    // }}}
  } orv64_csr_trap_cause_t;
  typedef enum logic [3:0] {
    ORV64_INT_U_SW    = 'd0,
    ORV64_INT_S_SW    = 'd1,
    ORV64_INT_M_SW    = 'd3,
    ORV64_INT_U_TIME  = 'd4,
    ORV64_INT_S_TIME  = 'd5,
    ORV64_INT_M_TIME  = 'd7,
    ORV64_INT_U_EXT   = 'd8,
    ORV64_INT_S_EXT   = 'd9,
    ORV64_INT_M_EXT   = 'd11
  } orv64_int_cause_t;
  typedef struct packed { // {{{
    logic                   valid;
    orv64_csr_trap_cause_t  cause; // }}}
  } orv64_trap_t;
  typedef struct packed {
    logic en_hpmcounter;
  } orv64_csr_cfg_t;
  // next virtual PC
  typedef struct packed { // {{{
    logic         valid;
    orv64_vaddr_t       pc; // }}}
  } orv64_npc_t;
  typedef struct packed { // {{{
    logic         HPM31;
    logic         HPM30;
    logic         HPM29;
    logic         HPM28;
    logic         HPM27;
    logic         HPM26;
    logic         HPM25;
    logic         HPM24;
    logic         HPM23;
    logic         HPM22;
    logic         HPM21;
    logic         HPM20;
    logic         HPM19;
    logic         HPM18;
    logic         HPM17;
    logic         HPM16;
    logic         HPM15;
    logic         HPM14;
    logic         HPM13;
    logic         HPM12;
    logic         HPM11;
    logic         HPM10;
    logic         HPM9;
    logic         HPM8;
    logic         HPM7;
    logic         HPM6;
    logic         HPM5;
    logic         HPM4;
    logic         HPM3;
    logic         IR;
    logic         TM;
    logic         CY; // }}}
  } orv64_csr_counteren_t;
  typedef struct packed { // {{{
    logic         HPM31;
    logic         HPM30;
    logic         HPM29;
    logic         HPM28;
    logic         HPM27;
    logic         HPM26;
    logic         HPM25;
    logic         HPM24;
    logic         HPM23;
    logic         HPM22;
    logic         HPM21;
    logic         HPM20;
    logic         HPM19;
    logic         HPM18;
    logic         HPM17;
    logic         HPM16;
    logic         HPM15;
    logic         HPM14;
    logic         HPM13;
    logic         HPM12;
    logic         HPM11;
    logic         HPM10;
    logic         HPM9;
    logic         HPM8;
    logic         HPM7;
    logic         HPM6;
    logic         HPM5;
    logic         HPM4;
    logic         HPM3;
    logic         IR;
    logic         O;
    logic         CY; // }}}
  } orv64_csr_counter_inhibit_t;
  typedef struct packed { // {{{
    logic [51:0]  reserved_63_to_12;
    logic         MEIP;
    logic         reserved_10;
    logic         SEIP;
    logic         UEIP;
    logic         MTIP;
    logic         reserved_6;
    logic         STIP;
    logic         UTIP;
    logic         MSIP;
    logic         reserved_2;
    logic         SSIP;
    logic         USIP; // }}}
  } orv64_csr_ip_t;
  typedef struct packed { // {{{
    logic [51:0]  reserved_63_to_12;
    logic         MEIE;
    logic         reserved_10;
    logic         SEIE;
    logic         UEIE;
    logic         MTIE;
    logic         reserved_6;
    logic         STIE;
    logic         UTIE;
    logic         MSIE;
    logic         reserved_2;
    logic         SSIE;
    logic         USIE; // }}}
  } orv64_csr_ie_t;
  typedef struct packed { // {{{
    logic [47:0] reserved_63_to_16;
    logic        store_page_fault;
    logic        reserved_14;
    logic        load_page_fault;
    logic        inst_page_fault;
    logic        ecall_from_m;
    logic        reserved_10;
    logic        ecall_from_s;
    logic        ecall_from_u;
    logic        store_access_fault;
    logic        store_addr_misaligned;
    logic        load_access_fault;
    logic        load_addr_misaligned;
    logic        breakpoint;
    logic        illegal_inst;
    logic        inst_access_fault;
    logic        inst_addr_misaligned; // }}}
  } orv64_csr_edeleg_t;
  typedef struct packed {
    logic [51:0]  reserved_63_to_12;
    logic         meip;
    logic         reserved_10;
    logic         seip;
    logic         ueip;
    logic         mtip;
    logic         reserved_6;
    logic         stip;
    logic         utip;
    logic         msip;
    logic         reserved_2;
    logic         ssip;
    logic         usip;
  } orv64_csr_ideleg_t;
  // bypass
  typedef struct packed { // {{{
    logic             valid_data;
    logic       is_rd_fp;
    orv64_reg_addr_t  rd_addr;
    logic             valid_addr;
    orv64_data_t      rd; // }}}
  } orv64_bps_t;

  // Supervisor csrs
  typedef struct packed { // {{{
    logic           SD;
    logic [28:0]    reserved_62_to_34;
    logic [1:0]     UXL;
    logic [11:0]    reserved_31_to_20;
    logic           MXR;
    logic           SUM;
    logic           reserved_17;
    logic [1:0]     XS;
    logic [1:0]     FS;
    logic [3:0]     reserved_12_to_9;
    logic           SPP;
    logic [1:0]     reserved_7_to_6;
    logic           SPIE;
    logic           UPIE;
    logic [1:0]     reserved_3_to_2;
    logic           SIE;
    logic           UIE; // }}}
  } orv64_csr_sstatus_t;

  // User csrs
  typedef struct packed { // {{{
    logic [58:0]    reserved_63_to_5;
    logic           UPIE;
    logic [2:0]     reserved_3_to_1;
    logic           UIE; // }}}
  } orv64_csr_ustatus_t;

  //------------------------------------------------------
  // floating point
  typedef enum logic [2:0] { // {{{
    ORV64_FRM_RNE   = 3'b000,
    ORV64_FRM_RTZ   = 3'b001,
    ORV64_FRM_RDN   = 3'b010,
    ORV64_FRM_RUP   = 3'b011,
    ORV64_FRM_RMM   = 3'b100,
    ORV64_FRM_RSVD0 = 3'b101,
    ORV64_FRM_RSVD1 = 3'b110,
    ORV64_FRM_DYN   = 3'b111 // }}}
  } orv64_frm_t; // rounding mode for floating-point
  typedef enum logic [2:0] { // {{{
    ORV64_FRM_DW_RNE   = 3'b000,
    ORV64_FRM_DW_RTZ   = 3'b001,
    ORV64_FRM_DW_RDN   = 3'b011,
    ORV64_FRM_DW_RUP   = 3'b010,
    ORV64_FRM_DW_RMM   = 3'b100,
    ORV64_FRM_DW_RSVD0 = 3'b101,
    ORV64_FRM_DW_RSVD1 = 3'b110,
    ORV64_FRM_DW_DYN   = 3'b111 // }}}
  } orv64_frm_dw_t; // rounding mode for floating-point
  typedef struct packed { // {{{
    logic nv;
    logic dz;
    logic of;
    logic uf;
    logic nx; // }}}
  } orv64_fflags_t; // floating-point flags
  typedef struct packed { // {{{
    logic compspecific;
    logic hugeint;
    logic inexact;
    logic huge;
    logic tiny;
    logic invalid;
    logic infinity;
    logic zero; // }}}
  } orv64_fstatus_dw_t; // status output from DW
  typedef enum logic [3:0] { // {{{
    ORV64_FP_OP_ADD_S,
    ORV64_FP_OP_MAC_S,
    ORV64_FP_OP_DIV_S,
    ORV64_FP_OP_SQRT_S,
    ORV64_FP_OP_ADD_D,
    ORV64_FP_OP_MAC_D,
    ORV64_FP_OP_DIV_D,
    ORV64_FP_OP_SQRT_D,
    ORV64_FP_OP_MISC,
    ORV64_FP_OP_NONE // }}}
  } orv64_fp_op_t;
  typedef enum logic { // {{{
    ORV64_FP_RS1_SEL_RS1,
    ORV64_FP_RS1_SEL_RS1_INV // }}}
  } orv64_fp_rs1_sel_t;
  typedef enum logic { // {{{
    ORV64_FP_RS2_SEL_RS2,
    ORV64_FP_RS2_SEL_RS2_INV // }}}
  } orv64_fp_rs2_sel_t;
  typedef enum logic [1:0] { // {{{
    ORV64_FP_RS3_SEL_ZERO,
    ORV64_FP_RS3_SEL_RS3,
    ORV64_FP_RS3_SEL_RS3_INV // }}}
  } orv64_fp_rs3_sel_t;
  typedef enum logic [1:0] { // {{{
    ORV64_FP_SGNJ_SEL_J,
    ORV64_FP_SGNJ_SEL_JN,
    ORV64_FP_SGNJ_SEL_JX // }}}
  } orv64_fp_sgnj_sel_t;
  typedef enum logic [2:0] { // {{{
    ORV64_FP_CMP_SEL_MAX,
    ORV64_FP_CMP_SEL_MIN,
    ORV64_FP_CMP_SEL_EQ,
    ORV64_FP_CMP_SEL_LT,
    ORV64_FP_CMP_SEL_LE,
    ORV64_FP_CMP_SEL_NONE // }}}
  } orv64_fp_cmp_sel_t;
  typedef enum logic [1:0] { // {{{
    ORV64_FP_CVT_SEL_W,
    ORV64_FP_CVT_SEL_WU,
    ORV64_FP_CVT_SEL_L,
    ORV64_FP_CVT_SEL_LU // }}}
  } orv64_fp_cvt_sel_t;
  typedef struct packed { // {{{
    logic q_nan;      // quiet NaN
    logic s_nan;      // signaling NaN
    logic pos_inf;    // +infinity
    logic pos;        // +normal
    logic pos_sub;    // +subnormal
    logic pos_zero;   // +0
    logic neg_zero;   // -0
    logic neg_sub;    // -subnormal
    logic neg;        // -normal
    logic neg_inf;    // -infinity }}}
  } orv64_fp_cls_t;
  typedef enum logic [4:0] { // {{{
    ORV64_FP_OUT_SEL_ADD_S,
    ORV64_FP_OUT_SEL_CMP_S,
    ORV64_FP_OUT_SEL_MAC_S,
    ORV64_FP_OUT_SEL_DIV_S,
    ORV64_FP_OUT_SEL_SQRT_S,
    ORV64_FP_OUT_SEL_ADD_D,
    ORV64_FP_OUT_SEL_CMP_D,
    ORV64_FP_OUT_SEL_MAC_D,
    ORV64_FP_OUT_SEL_DIV_D,
    ORV64_FP_OUT_SEL_SQRT_D,
    ORV64_FP_OUT_SEL_SGNJ,
    ORV64_FP_OUT_SEL_CVT_I2S,
    ORV64_FP_OUT_SEL_CVT_I2D,
    ORV64_FP_OUT_SEL_CVT_S2I,
    ORV64_FP_OUT_SEL_CVT_D2I,
    ORV64_FP_OUT_SEL_CVT_S2D,
    ORV64_FP_OUT_SEL_CVT_D2S,
    ORV64_FP_OUT_SEL_CLS,
    ORV64_FP_OUT_SEL_NONE // }}}
  } orv64_fp_out_sel_t;

  //------------------------------------------------------
  // exception
  typedef enum logic [3:0] { // {{{
    ORV64_EXCP_CAUSE_INST_ADDR_MISALIGNED = 4'('d0),
    ORV64_EXCP_CAUSE_INST_ACCESS_FAULT = 4'('d1),
    ORV64_EXCP_CAUSE_ILLEGAL_INST = 4'('d2),
    ORV64_EXCP_CAUSE_BREAKPOINT = 4'('d3),
    ORV64_EXCP_CAUSE_LOAD_ADDR_MISALIGNED = 4'('d4),
    ORV64_EXCP_CAUSE_LOAD_ACCESS_FAULT = 4'('d5),
    ORV64_EXCP_CAUSE_STORE_ADDR_MISALIGNED = 4'('d6),
    ORV64_EXCP_CAUSE_STORE_ACCESS_FAULT = 4'('d7),
    ORV64_EXCP_CAUSE_ECALL_FROM_U = 4'('d8),
    ORV64_EXCP_CAUSE_ECALL_FROM_S = 4'('d9),
    ORV64_EXCP_CAUSE_ECALL_FROM_M = 4'('d11),
    ORV64_EXCP_CAUSE_INST_PAGE_FAULT = 4'('d12),
    ORV64_EXCP_CAUSE_LOAD_PAGE_FAULT = 4'('d13),
    ORV64_EXCP_CAUSE_STORE_PAGE_FAULT = 4'('d15),
    ORV64_EXCP_CAUSE_NONE = 4'('d10)
    // }}}
  } orv64_excp_cause_t;

  typedef struct packed { // {{{
    logic         valid;
    orv64_inst_t  inst;
    orv64_excp_cause_t  cause; // }}}
    logic         is_half1;
  } orv64_excp_t;

  typedef enum logic [1:0] { // {{{
    ORV64_FENCE_TYPE_FENCE,
    ORV64_FENCE_TYPE_FENCE_I,
    ORV64_FENCE_TYPE_SFENCE,
    ORV64_FENCE_TYPE_NONE // }}}
  } orv64_fence_type_t;

  //==========================================================
  // RVC
  typedef enum logic [1:0] {
    RVC_C0  = 2'b00,
    RVC_C1  = 2'b01,
    RVC_C2  = 2'b10
  } orv64_rvc_opcode_t;

  //==========================================================
  // pipeline registers
  //------------------------------------------------------
  // data
  typedef struct packed { // {{{
    orv64_vaddr_t       pc;
    orv64_inst_t        inst; 
    logic               is_csr_op_on_mmu;
    logic               is_rvc; // }}}
  } orv64_if2id_t;

  typedef struct packed { // (by Anh)
    logic [2:0]                 thread_id;
    logic [31:0]                instr;
  } orv64_if2vid_t;

  typedef struct packed { // {{{
    orv64_vaddr_t       pc;
    orv64_inst_t        inst;
    orv64_data_t        rs1, rs2;
    orv64_reg_addr_t    rd_addr;
    logic               is_rs1_final;
    logic               is_rs2_final;
    logic               is_rvc; // }}}
  } orv64_id2ex_t;
  typedef struct packed { // {{{
    logic         en;
    orv64_data_t        rs1, rs2;
    logic         is_same; // }}}
  } orv64_id2muldiv_t;
  typedef struct packed { // {{{
    orv64_vaddr_t     pc;
    orv64_inst_t        inst;
    // orv64_data_t      rs1, rs2;
    orv64_data_t      ex_out;
    orv64_reg_addr_t  rd_addr;
    orv64_csr_addr_t  csr_addr;
    orv64_fflags_t    fflags;
    logic             is_rvc;
    // }}}
  } orv64_ex2ma_t;
  typedef struct packed { // {{{
    orv64_vaddr_t     pc;
    orv64_inst_t      inst;
    orv64_vaddr_t     mem_addr;
    orv64_csr_addr_t  csr_addr;
    orv64_reg_addr_t  rs1_addr;
    orv64_data_t      csr_wdata;
    orv64_fflags_t    fflags;
    logic             is_rvc;
    // }}}
  } orv64_ma2cs_t;
  typedef struct packed { // {{{
    orv64_data_t      csr; // }}}
  } orv64_cs2ma_t;
  typedef struct packed { // {{{
    orv64_data_t rd;
    orv64_reg_addr_t rd_addr; // }}}
  } orv64_ma2wb_t;
  //------------------------------------------------------
  // ctrl
  typedef struct packed { // {{{
    logic         is_rs1_fp, is_rs2_fp,
                  rs1_re, rs2_re, rs3_re,
                  is_rs1_x0, is_rs2_x0; // }}}
    logic is_aq_rl, is_amo_load, is_amo_op, is_amo_store, is_amo, is_amo_mv, is_amo_done;
  } orv64_if2id_ctrl_t;
  typedef struct packed { // {{{
    // copy from IF
    logic         is_rs1_fp, is_rs2_fp;
    // new in ID
    orv64_alu_op_t      alu_op;
    logic         alu_en;
    logic         is_32;
    orv64_op1_sel_t     op1_sel;
    orv64_op2_sel_t     op2_sel;
    orv64_imm_sel_t     imm_sel;
    orv64_rd_avail_t    rd_avail;
    logic         rd_we;
    logic         is_rd_fp;
    orv64_ex_pc_sel_t   ex_pc_sel;
    orv64_ex_out_sel_t  ex_out_sel;
    // new in ID for MULDIV
    orv64_mul_type_t    mul_type;
    orv64_div_type_t    div_type;
    // new in ID for FP
    orv64_fp_op_t       fp_op;
    orv64_fp_rs1_sel_t  fp_rs1_sel;
    orv64_fp_rs2_sel_t  fp_rs2_sel;
    orv64_fp_rs3_sel_t  fp_rs3_sel;
    orv64_fp_sgnj_sel_t fp_sgnj_sel;
    orv64_fp_cmp_sel_t  fp_cmp_sel;
    orv64_fp_cvt_sel_t  fp_cvt_sel;
    orv64_fp_out_sel_t  fp_out_sel;
    // atomic
    logic is_aq_rl;
    logic is_amo;
    logic is_amo_mv;
    logic is_amo_load;
    logic is_amo_op;
    logic is_amo_store;
    logic is_amo_done;
    logic is_lr;
    logic is_sc;
    logic is_fp_32;
    `ifndef SYNTHESIS
    logic [63:0]  inst_code;
    `endif // }}}
  } orv64_id2ex_ctrl_t;
  typedef struct packed { // {{{
    // copy from ID
    logic         is_rd_fp,
                  rd_we;
    orv64_rd_avail_t    rd_avail;
    // new in EX to MA
    logic         is_load, is_store;
    orv64_fence_type_t  fence_type;
    orv64_rd_sel_t      rd_sel;
    orv64_ma_byte_sel_t ma_byte_sel;
    // new in EX to CS
    orv64_csr_op_t      csr_op;
    orv64_ret_type_t    ret_type;
    logic         is_wfi;
    logic         is_wfe;
    logic is_amo_load;
    logic is_amo_op;
    logic is_amo_store;
    logic is_lr;
    logic is_sc;
    logic is_amo;
    logic is_amo_done;
    logic is_aq_rl;
    logic is_fp_32;
    `ifndef SYNTHESIS
    logic [63:0]  inst_code;
    `endif // }}}
  } orv64_ex2ma_ctrl_t;
  typedef struct packed { // {{{
    orv64_csr_op_t    csr_op;
    orv64_ret_type_t  ret_type;
    logic       is_wfi; // }}}
  } orv64_ma2cs_ctrl_t;
  typedef struct packed { // {{{
    logic rd_we, is_rd_fp; // }}}
  } orv64_ma2wb_ctrl_t;

  //------------------------------------------------------
  // AMO
  typedef enum logic [3:0] {
    AMO_IDLE	 = 4'b0000,
    AMO_LOAD	 = 4'b0001,
    AMO_OP       = 4'b0010,
    AMO_STORE    = 4'b0011,
    AMO_MEM_BAR  = 4'b0100,
    AMO_DONE     = 4'b0101,
    AMO_MV       = 4'b0110,
    AMO_LRSC     = 4'b0111,
    AMO_GAP      = 4'b1000
  } amo_fsm_t;

  //------------------------------------------------------
  // regfile
  typedef struct packed { // {{{
    orv64_reg_addr_t  rs1_addr, rs2_addr;
    logic       rs1_re, rs2_re; // }}}
  } orv64_if2irf_t;
  typedef struct packed { // {{{
    orv64_reg_addr_t  rs1_addr, rs2_addr, rs3_addr;
    logic       rs1_re, rs2_re, rs3_re; // }}}
  } orv64_if2fprf_t;
  typedef struct packed { // {{{
    orv64_data_t  rs1, rs2; // }}}
  } orv64_irf2id_t;
  typedef struct packed { // {{{
    orv64_data_t  rs1, rs2, rs3; // }}}
  } orv64_fprf2id_t;
  typedef struct packed { // {{{
    orv64_data_t      rd;
    orv64_reg_addr_t  rd_addr;
    logic       rd_we; // }}}
  } orv64_ma2rf_t;
  //------------------------------------------------------
  // cpunoc i/f

  typedef enum logic [CPUNOC_TID_SRCID_SIZE-1:0] {
    ORV64_IPTW_SRC_ID = CPUNOC_TID_SRCID_SIZE'(4'h0),
    ORV64_DPTW_SRC_ID = CPUNOC_TID_SRCID_SIZE'(4'h1),
    ORV64_VPTW_SRC_ID = CPUNOC_TID_SRCID_SIZE'(4'h2),
    ORV64_IC_SRC_ID   = CPUNOC_TID_SRCID_SIZE'(4'h3),
    ORV64_DC_SRC_ID   = CPUNOC_TID_SRCID_SIZE'(4'h4)
  } orv64_src_id_t;
  
  //------------------------------------------------------
  // icache
  typedef logic [ORV64_ICACHE_TAG_WIDTH-1:0]    orv64_ic_tag_t;
  typedef logic [ORV64_ICACHE_INDEX_WIDTH-1:0]  orv64_ic_idx_t;
  typedef logic [ORV64_ICACHE_WYID_WIDTH-1:0]   orv64_ic_wyid_t;
  typedef struct packed { // {{{
    orv64_vaddr_t     pc;
    logic             en; // }}}
  } orv64_ib2icmem_t;
  typedef struct packed { // {{{
    cache_line_t       rdata;
    orv64_paddr_t      pc_paddr;
    logic              excp_valid;
    orv64_excp_cause_t excp_cause;
    logic              valid; // }}}
  } orv64_icmem2ib_t;
  typedef struct packed { // {{{
    orv64_vaddr_t     pc;
    logic       en; // }}}
  } orv64_if2ic_t;
  typedef struct packed { // {{{
    orv64_paddr_t     pc;
    logic       en; // }}}
  } orv64_if2ic_phys_t;
  typedef struct packed { // {{{
    orv64_paddr_t     pc;
    logic       en; // }}}
  } orv64_ic2sys_t;
  typedef struct packed { // {{{
    cache_line_t       rdata;
    logic              valid; // }}}
  } orv64_sys2ic_t;
  typedef struct packed { // {{{
    orv64_inst_t       inst;
    orv64_inst_t       rvc_inst;
    logic              excp_valid;
    orv64_excp_cause_t excp_cause;
    logic              is_half1_excp;
    logic       is_rvc;
    logic       valid; // }}}
  } orv64_ic2if_t;
  typedef struct packed {
    logic                             valid;
    logic [ORV64_ICACHE_RAM_TAG_WIDTH-1:0] tag;
  } orv64_ic_tag_entry_t;
  typedef struct packed { // {{{
    logic       line_idx;
    logic       en; // }}}
  } orv64_da2ib_t;
  typedef struct packed { // {{{
    cache_line_t       line_data;
    orv64_paddr_t      line_paddr;
    logic              line_excp_valid;
    orv64_excp_cause_t line_excp_cause;
    logic [4:0]        buf_cnt; // TODO: parameterize
    logic [4:0]        rd_ptr; // }}}
  } orv64_ib2da_t;
  //------------------------------------------------------
  // dcache
  typedef struct packed { // {{{
    logic       re, we;
    logic		lr, sc, amo_store, amo_load, aq_rl;
    orv64_vaddr_t     addr;
    orv64_data_byte_mask_t mask;
    orv64_data_t      wdata;
    cpu_byte_mask_t   width; // }}}
  } orv64_ex2dc_t;
  typedef struct packed { // {{{
    logic       re, we;
    orv64_paddr_t     addr;
    orv64_data_byte_mask_t mask;
    orv64_data_t      wdata; // }}}
  } orv64_ex2dc_phys_t;
  typedef struct packed { // {{{
    orv64_data_t      rdata;
    logic              excp_valid;
    orv64_excp_cause_t excp_cause;
    logic       valid; // }}}
  } orv64_dc2ma_t;
  typedef struct packed {
    logic                                     valid;
    orv64_data_t  [CACHE_LINE_BYTE*8/64-1:0]        data;
    logic   [CACHE_LINE_BYTE*8/64-1:0] [7:0]  dirty; // every byte has 1 dirty bit to indicate that it's been written
    logic   [ORV64_DCACHE_TAG_WIDTH+ORV64_DCACHE_INDEX_WIDTH-1:0] tag;
  } orv64_store_buf_t;
  //------------------------------------------------------
  // magic mem
  typedef struct packed {
    logic         re, we;
    logic [ 3:0]  ra, wa;
    logic [ 7:0]  wm;
    orv64_data_t        wd;
  } orv64_mgc_i_t;
  typedef struct packed {
    orv64_data_t        rd;
    logic         rmiss, wmiss;
  } orv64_mgc_o_t;
  //------------------------------------------------------
  // floating point
  typedef struct packed { // {{{
    orv64_data_t        rs1, rs2;
    orv64_frm_dw_t      frm_dw; // }}}
  } orv64_id2fp_add_t;
  typedef struct packed { // {{{
    orv64_data_t        rs1, rs2, rs3;
    logic               is_mul;
    orv64_frm_dw_t      frm_dw; // }}}
  } orv64_id2fp_mac_t;
  typedef struct packed { // {{{
    orv64_data_t        rs1, rs2;
    orv64_frm_dw_t      frm_dw; // }}}
  } orv64_id2fp_div_t;
  typedef struct packed { // {{{
    orv64_data_t        rs1;
    orv64_frm_dw_t      frm_dw; // }}}
  } orv64_id2fp_sqrt_t;
  typedef struct packed { // {{{
    orv64_data_t        rs1, rs2;
    orv64_frm_dw_t      frm_dw; // }}}
  } orv64_id2fp_misc_t;
  typedef struct packed { // {{{
    orv64_frm_t     frm;
    orv64_fflags_t  fflags; // }}}
  } orv64_csr_fcsr_t;
  typedef struct packed { // {{{
    logic ovl_32;
    logic ovl_32u;
    logic ovl_64;
    logic ovl_64u; // }}}
  } orv64_fp2i_ovl_t;
  //------------------------------------------------------
  // to DMA
  typedef struct packed { // {{{
    // logic [$clog2(ORV64_N_DMA_CHNL) - 1 : 0] dma_chnl;
    logic dma_rw;
    logic [39:0] start_addr;
    // logic [ORV64_N_DMA_SIZE_BIT - 1 : 0] dma_size; // }}}
  } orv64_mp2dma_cmd_t;

  //------------------------------------------------------
  // Debug access

  typedef struct packed {
    logic is_l1da;
    logic is_batch;
    logic [1:0] reserved;
    logic is_tag;
    logic way_id;
    logic [ORV64_ICACHE_DATA_BANK_ID_WIDTH-1:0] data_bank_id; // 3-bit
    logic [ORV64_ICACHE_INDEX_WIDTH-1:0] index; // 7-bit
  } orv64_l1da_addr_t;

  typedef struct packed {
    orv64_data_t              mcycle;
    orv64_data_t              minstret;
    orv64_csr_mstatus_t       mstatus;
    orv64_vaddr_t             mepc;
    orv64_csr_trap_cause_t    mcause;
    orv64_csr_misa_t          misa;
    orv64_csr_ip_t            mip;
    orv64_csr_ie_t            mie;
    orv64_csr_edeleg_t        medeleg;
    orv64_csr_ideleg_t        mideleg;
    orv64_csr_tvec_t          mtvec;
    orv64_data_t              mtval;
    orv64_vaddr_t             satp;
    orv64_vaddr_t             sepc;
    orv64_csr_trap_cause_t    scause;
    orv64_csr_edeleg_t        sedeleg;
    orv64_csr_ideleg_t        sideleg;
    orv64_csr_tvec_t          stvec;
    orv64_data_t              stval;
    orv64_vaddr_t             uepc;
    orv64_csr_trap_cause_t    ucause;
    orv64_csr_edeleg_t        uedeleg;
    orv64_csr_ideleg_t        uideleg;
    orv64_csr_tvec_t          utvec;
    orv64_data_t              utval;
    orv64_cntr_t    hpmcounter3,
                    hpmcounter4,
                    hpmcounter5,
                    hpmcounter6,
                    hpmcounter7,
                    hpmcounter8,
                    hpmcounter9,
                    hpmcounter10,
                    hpmcounter11,
                    hpmcounter12,
                    hpmcounter13,
                    hpmcounter14,
                    hpmcounter15,
                    hpmcounter16;
  } orv64_cs2da_t;

  typedef struct packed {
    amo_fsm_t if_amo_st;
    logic wait_for_branch;
  } orv64_if2da_t;
  typedef struct packed {
    logic id_wait_for_reg;
    logic wait_for_fence;
  } orv64_id2da_t;
  typedef struct packed {
    logic wait_for_reg;
    logic wait_for_mul;
    logic wait_for_div;
    logic wait_for_fp;
    logic hold_ex2if_kill;
  } orv64_ex2da_t;
  typedef struct packed {
    logic cs2ma_stall;
    logic wait_for_dc;
  } orv64_ma2da_t;
  typedef struct packed {
    orv64_reg_addr_t    reg_addr;
  } orv64_da2rf_t;
  typedef struct packed {
    orv64_data_t        reg_data;
  } orv64_rf2da_t;

  //------------------------------------------------------
  // MMU

  typedef logic [ORV64_ASID_WIDTH-1:0] orv64_asid_t;
  typedef logic [ORV64_VPN_WIDTH-1:0] orv64_vpn_t;
  typedef logic [ORV64_PPN_WIDTH-1:0] orv64_ppn_t;
  typedef logic [ORV64_PPN_PART_WIDTH-1:0] orv64_ppn_part_t;
  typedef logic [ORV64_PAGE_OFFSET_WIDTH-1:0] orv64_page_ofs_t;
  typedef logic [ORV64_PTE_IDX_WIDTH-1:0] orv64_pte_idx_t;
  typedef logic [ORV64_PTW_LVL_CNT_WIDTH-1:0] orv64_ptw_lvl_t;

  typedef enum logic [1:0] {
    ORV64_SFENCE_ASID       = 2'b00,
    ORV64_SFENCE_VPN        = 2'b01,
    ORV64_SFENCE_ASID_VPN   = 2'b10,
    ORV64_SFENCE_ALL        = 2'b11
  } orv64_sfence_type_t;

  // typedef enum logic [1:0] {
  //   ORV64_ACCESS_FETCH = 2'b00,
  //   ORV64_ACCESS_LOAD  = 2'b01,
  //   ORV64_ACCESS_STORE = 2'b10,
  //   ORV64_ACCESS_AMO   = 2'b11
  // } orv64_access_type_t;

  logic [1:0] orv64_access_type_t;
  localparam ORV64_ACCESS_FETCH = 0;
  localparam ORV64_ACCESS_LOAD  = 1;
  localparam ORV64_ACCESS_STORE = 2;
  localparam ORV64_ACCESS_AMO   = 3;


  typedef struct packed {
    logic       [9:0] reserved1;
    orv64_ppn_t       ppn;
    logic       [1:0] reserved0;
    logic             dirty;
    logic             accessed;
    logic             global_map;
    logic             user;
    logic             perm_x;
    logic             perm_w;
    logic             perm_r;
    logic             valid;
  } orv64_pte_t; // page table entry

  typedef struct packed {
    orv64_asid_t    asid;
    orv64_vpn_t     vpn;
    orv64_pte_t     pte;
    orv64_ptw_lvl_t page_lvl;
  } orv64_tlb_entry_t;

  typedef struct packed {
    logic       en;
    logic [2:0] idx;
  } orv64_da2tlb_t;

  typedef struct packed {
    logic         tlb_valid;
    orv64_vpn_t   tlb_vpn;
    orv64_pte_t   tlb_pte;
    orv64_asid_t  tlb_asid;
  } orv64_tlb2da_t;

  typedef enum logic [3:0] {
    ORV64_BARE = 4'd0,
    ORV64_SV39 = 4'd8,
    ORV64_SV48 = 4'd9,
    ORV64_SV57 = 4'd10,
    ORV64_SV64 = 4'd11
  } orv64_satp_mode_t;

  typedef struct packed { // {{{
    orv64_satp_mode_t   mode;
    orv64_asid_t        asid;
    orv64_ppn_t         ppn;  // }}}
  } orv64_csr_satp_t;

  typedef struct packed {
//    logic [9:0]     reserved;
    logic [53:0]    addr;
  } orv64_csr_pmpaddr_t; // for RV64

  typedef enum logic [1:0] { // {{{
    ORV64_OFF   = 2'b00,
    ORV64_TOR   = 2'b01,
    ORV64_NA4   = 2'b10,
    ORV64_NAPOT = 2'b11 // }}}
  } orv64_pmp_access_type;

  typedef struct packed {
    logic           l;
    logic [1:0]     reserved;
    orv64_pmp_access_type a;
    logic           x;
    logic           w;
    logic           r;
  } orv64_csr_pmpcfg_part_t;

  typedef struct packed {
    orv64_csr_pmpcfg_part_t [ORV64_N_FIELDS_PMPCFG-1:0] pmpcfg;
  } orv64_csr_pmpcfg_t; // for RV64

  typedef struct packed {
    logic                 valid;
    logic                 is_mp;
    logic                 is_broadcast;
    logic [3:0]           vcore_id;
    logic                 rw;
    logic                 bus_type; // 0: req; 1: resp
    logic [16-1:0]        addr;
//     orv64_dbg_addr_t              addr;
    logic [32-1:0]        data;
  } orv64_cpu_dbg_bus_t;

  typedef struct packed {
    logic is_l1da;      // if not l1, then is local proc registers
    logic is_local_sp; // if is not a local Scalar Proc reg, then is local Vector Proc reg
    logic is_msb;   // access the MSB part of a register in case its width is more than 32-bit
    logic       reserved;
    logic [11:0] reg_addr;  // 12-bit register addr
  } orv64_dbg_addr_t;

  //==========================================================
  // instruction trace buffer

  typedef logic [ORV64_ITB_ADDR_WIDTH-1:0]  orv64_itb_addr_t;
  typedef struct packed {
    orv64_vaddr_t   vpc;
  } orv64_itb_data_t;
  typedef enum logic [2:0] {
    ORV64_ITB_SEL_IF = 3'h0,
    ORV64_ITB_SEL_ID = 3'h1,
    ORV64_ITB_SEL_EX = 3'h2,
    ORV64_ITB_SEL_MA = 3'h3,
    ORV64_ITB_SEL_WB = 3'h4
  } orv64_itb_sel_t;

  typedef struct packed {
    logic             en, rw;
    orv64_itb_addr_t  addr;
    orv64_itb_data_t  din;
  } orv64_da2itb_t;

  typedef struct packed {
    orv64_itb_data_t  dout;
  } orv64_itb2da_t;

endpackage
