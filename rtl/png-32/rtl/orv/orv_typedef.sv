

`ifndef __ORV_TYPEDEF__SV__
`define __ORV_TYPEDEF__SV__

package orv_typedef;
  import pygmy_cfg::*;
  import pygmy_typedef::*;
  import orv_cfg::*;

  typedef logic [XLEN-1:0]    data_t; // data
  typedef logic [31:0]        inst_t; // instruction
  typedef logic [REG_ADDR_WIDTH-1:0]         reg_addr_t; // register file address
  typedef logic [XLEN/8-1:0]  data_byte_mask_t;

  typedef logic [55:0]        cntr_t; // 2^56 / 1GHz > 2 years

  //==========================================================
  // enumeration
  typedef enum logic { // {{{
    RD_AVAIL_EX,
    RD_AVAIL_MA
    // }}}
  } rd_avail_t;
  typedef enum logic [4:0] { // {{{
    LOAD      = 5'h00,
    MISC_MEM  = 5'h03,
    OP_IMM    = 5'h04,
    AUIPC     = 5'h05,
    OP_IMM_32 = 5'h06,
    STORE     = 5'h08,
    OP        = 5'h0C,
    LUI       = 5'h0D,
    OP_32     = 5'h0E,
    BRANCH    = 5'h18,
    JALR      = 5'h19,
    JAL       = 5'h1B,
    SYSTEM    = 5'h1C,
    LOAD_FP   = 5'h01,
    STORE_FP  = 5'h09,
    OP_FP     = 5'h14,
    FMADD     = 5'h10,
    FMSUB     = 5'h11,
    FNMADD    = 5'h13,
    FNMSUB    = 5'h12,
    OURS      = 5'h1E,

    // // Vector Opcodes (by Anh)
    // VLOAD     = 5'h07,  // both VLD and VLDX
    // VSTORE    = 5'h0F,  // both VST and VSTX
    // VVCOMP    = 5'h17,  // VMUL, VADD, VSUB, VDOTP
    // VSCOMP    = 5'h1F   // VSUM, VMAX
    VLOAD     = 5'h07,
    VSTORE    = 5'h0F,
    VARITH    = 5'h17,
    VAI       = 5'h1F
    // }}}
  } opcode_t;
  typedef enum logic [3:0] { // {{{
    ALU_OP_ADD  = 4'h0,
    ALU_OP_SLL  = 4'h1,
    ALU_OP_SEQ  = 4'h2,
    ALU_OP_SNE  = 4'h3,
    ALU_OP_XOR  = 4'h4,
    ALU_OP_SRL  = 4'h5,
    ALU_OP_OR   = 4'h6,
    ALU_OP_AND  = 4'h7,
    ALU_OP_SUB  = 4'hA,
    ALU_OP_SRA  = 4'hB,
    ALU_OP_SLT  = 4'hC,
    ALU_OP_SGE  = 4'hD,
    ALU_OP_SLTU = 4'hE,
    ALU_OP_SGEU = 4'hF
    // }}}
  } alu_op_t;
  typedef enum logic [1:0] { // {{{
    OP1_SEL_RS1,
    OP1_SEL_FP_RS1,
    OP1_SEL_FP_RS1_SEXT,
    OP1_SEL_ZERO // }}}
  } op1_sel_t;
  typedef enum logic { // {{{
    OP2_SEL_RS2,
    OP2_SEL_IMM // }}}
  } op2_sel_t;
  typedef enum logic [4:0] { // {{{
    IMM_SEL_I,
    IMM_SEL_S,
    IMM_SEL_B,
    IMM_SEL_U,
    IMM_SEL_J,
    IMM_SEL_Z,
    IMM_SEL_F0,
    IMM_SEL_ZERO // }}}
  } imm_sel_t;
  typedef enum logic { // {{{
    EX_PC_ADDER_SEL_P4,
    EX_PC_ADDER_SEL_IMM // }}}
  } ex_pc_adder_sel_t;
  typedef enum logic [1:0] { // {{{
    EX_NEXT_PC_SEL_PC_ADDER,
    EX_NEXT_PC_SEL_RS1,
    EX_NEXT_PC_SEL_NONE // }}}
  } ex_next_pc_sel_t;
  typedef enum logic [3:0] { // {{{
    EX_OUT_SEL_ALU_OUT,
    EX_OUT_SEL_PC_ADDER,
    EX_OUT_SEL_MUL_L,
    EX_OUT_SEL_MUL_H,
    EX_OUT_SEL_DIV_Q,
    EX_OUT_SEL_DIV_R,
    EX_OUT_SEL_FP,
    EX_OUT_SEL_ACC_LO,
    EX_OUT_SEL_ACC_HI,
    EX_OUT_SEL_NONE // }}}
  } ex_out_sel_t;
  typedef enum logic [2:0] { // {{{
    MA_BYTE_SEL_1   = 3'h0,
    MA_BYTE_SEL_U1  = 3'h1,
    MA_BYTE_SEL_2   = 3'h2,
    MA_BYTE_SEL_U2  = 3'h3,
    MA_BYTE_SEL_4   = 3'h4,
    MA_BYTE_SEL_U4  = 3'h5,
    MA_BYTE_SEL_8   = 3'h6
    // }}}
  } ma_byte_sel_t;
  typedef enum logic [2:0] { // {{{
    MUL_TYPE_L,
    MUL_TYPE_HSS,
    MUL_TYPE_HUU,
    MUL_TYPE_HSU,
    MUL_TYPE_W,
    MUL_TYPE_NONE // }}}
  } mul_type_t;
  typedef enum logic [3:0] { // {{{
    DIV_TYPE_Q,
    DIV_TYPE_R,
    DIV_TYPE_QU,
    DIV_TYPE_RU,
    DIV_TYPE_QW,
    DIV_TYPE_RW,
    DIV_TYPE_QUW,
    DIV_TYPE_RUW,
    DIV_TYPE_NONE // }}}
  } div_type_t;
  typedef enum logic [1:0] { // {{{
    RD_SEL_EX_OUT,
    RD_SEL_MEM_READ,
    RD_SEL_CSR_READ // }}}
  } rd_sel_t;
  typedef enum logic [1:0] { // {{{
    RET_TYPE_U,
    RET_TYPE_S,
    RET_TYPE_M,
    RET_TYPE_NONE // }}}
  } ret_type_t;
  typedef logic [CSR_ADDR_RW_PRV_WIDTH-1:0] csr_addr_rw_prv_field_t;
  typedef enum logic [11:0] { // {{{
    // non-isa defined CSR  {{{
`ifdef ORV_SUPPORT_DMA
    CSR_ADDR_DMA_DONE         = 12'h602,
`endif

`ifdef ORV_SUPPORT_UART
    CSR_ADDR_TO_UART          = 12'h610,
    CSR_ADDR_FROM_UART        = 12'h611,
`endif

    // }}}
    // isa defined CSR {{{
    CSR_ADDR_USTATUS         = 12'h000,
    CSR_ADDR_UIE             = 12'h004,
    CSR_ADDR_UTVEC           = 12'h005,
    CSR_ADDR_USCRATCH        = 12'h040,
    CSR_ADDR_UEPC            = 12'h041,
    CSR_ADDR_UCAUSE          = 12'h042,
    CSR_ADDR_UTVAL           = 12'h043,
    CSR_ADDR_UIP             = 12'h044,
    CSR_ADDR_FFLAGS          = 12'h001,
    CSR_ADDR_FRM             = 12'h002,
    CSR_ADDR_FCSR            = 12'h003,
    CSR_ADDR_CYCLE           = 12'hC00,
    CSR_ADDR_TIME            = 12'hC01,
    CSR_ADDR_INSTRET         = 12'hC02,
    CSR_ADDR_HPMCOUNTER3     = 12'hC03,
    CSR_ADDR_HPMCOUNTER4     = 12'hC04,
    CSR_ADDR_HPMCOUNTER5     = 12'hC05,
    CSR_ADDR_HPMCOUNTER6     = 12'hC06,
    CSR_ADDR_HPMCOUNTER7     = 12'hC07,
    CSR_ADDR_HPMCOUNTER8     = 12'hC08,
    CSR_ADDR_HPMCOUNTER9     = 12'hC09,
    CSR_ADDR_HPMCOUNTER10    = 12'hC0A,
    CSR_ADDR_HPMCOUNTER11    = 12'hC0B,
    CSR_ADDR_HPMCOUNTER12    = 12'hC0C,
    CSR_ADDR_HPMCOUNTER13    = 12'hC0D,
    CSR_ADDR_HPMCOUNTER14    = 12'hC0E,
    CSR_ADDR_HPMCOUNTER15    = 12'hC0F,
    CSR_ADDR_HPMCOUNTER16    = 12'hC10,
    CSR_ADDR_HPMCOUNTER17    = 12'hC11,
    CSR_ADDR_HPMCOUNTER18    = 12'hC12,
    CSR_ADDR_HPMCOUNTER19    = 12'hC13,
    CSR_ADDR_HPMCOUNTER20    = 12'hC14,
    CSR_ADDR_HPMCOUNTER21    = 12'hC15,
    CSR_ADDR_HPMCOUNTER22    = 12'hC16,
    CSR_ADDR_HPMCOUNTER23    = 12'hC17,
    CSR_ADDR_HPMCOUNTER24    = 12'hC18,
    CSR_ADDR_HPMCOUNTER25    = 12'hC19,
    CSR_ADDR_HPMCOUNTER26    = 12'hC1A,
    CSR_ADDR_HPMCOUNTER27    = 12'hC1B,
    CSR_ADDR_HPMCOUNTER28    = 12'hC1C,
    CSR_ADDR_HPMCOUNTER29    = 12'hC1D,
    CSR_ADDR_HPMCOUNTER30    = 12'hC1E,
    CSR_ADDR_HPMCOUNTER31    = 12'hC1F,
    CSR_ADDR_HPMCOUNTER3H    = 12'hC83,
    CSR_ADDR_HPMCOUNTER4H    = 12'hC84,
    CSR_ADDR_HPMCOUNTER5H    = 12'hC85,
    CSR_ADDR_HPMCOUNTER6H    = 12'hC86,
    CSR_ADDR_HPMCOUNTER7H    = 12'hC87,
    CSR_ADDR_HPMCOUNTER8H    = 12'hC88,
    CSR_ADDR_HPMCOUNTER9H    = 12'hC89,
    CSR_ADDR_HPMCOUNTER10H   = 12'hC8A,
    CSR_ADDR_HPMCOUNTER11H   = 12'hC8B,
    CSR_ADDR_HPMCOUNTER12H   = 12'hC8C,
    CSR_ADDR_HPMCOUNTER13H   = 12'hC8D,
    CSR_ADDR_HPMCOUNTER14H   = 12'hC8E,
    CSR_ADDR_HPMCOUNTER15H   = 12'hC8F,
    CSR_ADDR_HPMCOUNTER16H   = 12'hC90,
    CSR_ADDR_HPMCOUNTER17H   = 12'hC91,
    CSR_ADDR_HPMCOUNTER18H   = 12'hC92,
    CSR_ADDR_HPMCOUNTER19H   = 12'hC93,
    CSR_ADDR_HPMCOUNTER20H   = 12'hC94,
    CSR_ADDR_HPMCOUNTER21H   = 12'hC95,
    CSR_ADDR_HPMCOUNTER22H   = 12'hC96,
    CSR_ADDR_HPMCOUNTER23H   = 12'hC97,
    CSR_ADDR_HPMCOUNTER24H   = 12'hC98,
    CSR_ADDR_HPMCOUNTER25H   = 12'hC99,
    CSR_ADDR_HPMCOUNTER26H   = 12'hC9A,
    CSR_ADDR_HPMCOUNTER27H   = 12'hC9B,
    CSR_ADDR_HPMCOUNTER28H   = 12'hC9C,
    CSR_ADDR_HPMCOUNTER29H   = 12'hC9D,
    CSR_ADDR_HPMCOUNTER30H   = 12'hC9E,
    CSR_ADDR_HPMCOUNTER31H   = 12'hC9F,
    CSR_ADDR_SSTATUS         = 12'h100,
    CSR_ADDR_SEDELEG         = 12'h102,
    CSR_ADDR_SIDELEG         = 12'h103,
    CSR_ADDR_SIE             = 12'h104,
    CSR_ADDR_STVEC           = 12'h105,
    CSR_ADDR_SCOUNTEREN      = 12'h106,
    CSR_ADDR_SSCRATCH        = 12'h140,
    CSR_ADDR_SEPC            = 12'h141,
    CSR_ADDR_SCAUSE          = 12'h142,
    CSR_ADDR_STVAL           = 12'h143,
    CSR_ADDR_SIP             = 12'h144,
    CSR_ADDR_SATP            = 12'h180,
    CSR_ADDR_MVENDORID       = 12'hF11,
    CSR_ADDR_MARCHID         = 12'hF12,
    CSR_ADDR_MIMPID          = 12'hF13,
    CSR_ADDR_MHARTID         = 12'hF14,
    CSR_ADDR_MSTATUS         = 12'h300,
    CSR_ADDR_MISA            = 12'h301,
    CSR_ADDR_MEDELEG         = 12'h302,
    CSR_ADDR_MIDELEG         = 12'h303,
    CSR_ADDR_MIE             = 12'h304,
    CSR_ADDR_MTVEC           = 12'h305,
    CSR_ADDR_MCOUNTEREN      = 12'h306,
    CSR_ADDR_MCOUNTINHIBIT   = 12'h320,
    CSR_ADDR_MSCRATCH        = 12'h340,
    CSR_ADDR_MEPC            = 12'h341,
    CSR_ADDR_MCAUSE          = 12'h342,
    CSR_ADDR_MTVAL           = 12'h343,
    CSR_ADDR_MIP             = 12'h344,
    //added by lei 11/22/2019
    CSR_ADDR_MFEPC           = 12'h351,
    CSR_ADDR_MFCAUSE         = 12'h352,
    CSR_ADDR_MFTVAL          = 12'h353,

    CSR_ADDR_PMPCFG0         = 12'h3A0,
    CSR_ADDR_PMPCFG1         = 12'h3A1,
    CSR_ADDR_PMPCFG2         = 12'h3A2,
    CSR_ADDR_PMPCFG3         = 12'h3A3,
    CSR_ADDR_PMPADDR0        = 12'h3B0,
    CSR_ADDR_PMPADDR1        = 12'h3B1,
    CSR_ADDR_PMPADDR2        = 12'h3B2,
    CSR_ADDR_PMPADDR3        = 12'h3B3,
    CSR_ADDR_PMPADDR4        = 12'h3B4,
    CSR_ADDR_PMPADDR5        = 12'h3B5,
    CSR_ADDR_PMPADDR6        = 12'h3B6,
    CSR_ADDR_PMPADDR7        = 12'h3B7,
    CSR_ADDR_PMPADDR8        = 12'h3B8,
    CSR_ADDR_PMPADDR9        = 12'h3B9,
    CSR_ADDR_PMPADDR10       = 12'h3BA,
    CSR_ADDR_PMPADDR11       = 12'h3BB,
    CSR_ADDR_PMPADDR12       = 12'h3BC,
    CSR_ADDR_PMPADDR13       = 12'h3BD,
    CSR_ADDR_PMPADDR14       = 12'h3BE,
    CSR_ADDR_PMPADDR15       = 12'h3BF,
    CSR_ADDR_MCYCLE          = 12'hB00,
    CSR_ADDR_MINSTRET        = 12'hB02,
    CSR_ADDR_MHPMCOUNTER3    = 12'hB03,
    CSR_ADDR_MHPMCOUNTER4    = 12'hB04,
    CSR_ADDR_MHPMCOUNTER5    = 12'hB05,
    CSR_ADDR_MHPMCOUNTER6    = 12'hB06,
    CSR_ADDR_MHPMCOUNTER7    = 12'hB07,
    CSR_ADDR_MHPMCOUNTER8    = 12'hB08,
    CSR_ADDR_MHPMCOUNTER9    = 12'hB09,
    CSR_ADDR_MHPMCOUNTER10   = 12'hB0A,
    CSR_ADDR_MHPMCOUNTER11   = 12'hB0B,
    CSR_ADDR_MHPMCOUNTER12   = 12'hB0C,
    CSR_ADDR_MHPMCOUNTER13   = 12'hB0D,
    CSR_ADDR_MHPMCOUNTER14   = 12'hB0E,
    CSR_ADDR_MHPMCOUNTER15   = 12'hB0F,
    CSR_ADDR_MHPMCOUNTER16   = 12'hB10,
    CSR_ADDR_MHPMCOUNTER17   = 12'hB11,
    CSR_ADDR_MHPMCOUNTER18   = 12'hB12,
    CSR_ADDR_MHPMCOUNTER19   = 12'hB13,
    CSR_ADDR_MHPMCOUNTER20   = 12'hB14,
    CSR_ADDR_MHPMCOUNTER21   = 12'hB15,
    CSR_ADDR_MHPMCOUNTER22   = 12'hB16,
    CSR_ADDR_MHPMCOUNTER23   = 12'hB17,
    CSR_ADDR_MHPMCOUNTER24   = 12'hB18,
    CSR_ADDR_MHPMCOUNTER25   = 12'hB19,
    CSR_ADDR_MHPMCOUNTER26   = 12'hB1A,
    CSR_ADDR_MHPMCOUNTER27   = 12'hB1B,
    CSR_ADDR_MHPMCOUNTER28   = 12'hB1C,
    CSR_ADDR_MHPMCOUNTER29   = 12'hB1D,
    CSR_ADDR_MHPMCOUNTER30   = 12'hB1E,
    CSR_ADDR_MHPMCOUNTER31   = 12'hB1F,

    CSR_ADDR_MCYCLEH         = 12'hB80,
    CSR_ADDR_MINSTRETH       = 12'hB82,
    CSR_ADDR_MHPMCOUNTER3H   = 12'hB83,
    CSR_ADDR_MHPMCOUNTER4H   = 12'hB84,
    CSR_ADDR_MHPMCOUNTER5H   = 12'hB85,
    CSR_ADDR_MHPMCOUNTER6H   = 12'hB86,
    CSR_ADDR_MHPMCOUNTER7H   = 12'hB87,
    CSR_ADDR_MHPMCOUNTER8H   = 12'hB88,
    CSR_ADDR_MHPMCOUNTER9H   = 12'hB89,
    CSR_ADDR_MHPMCOUNTER10H  = 12'hB8A,
    CSR_ADDR_MHPMCOUNTER11H  = 12'hB8B,
    CSR_ADDR_MHPMCOUNTER12H  = 12'hB8C,
    CSR_ADDR_MHPMCOUNTER13H  = 12'hB8D,
    CSR_ADDR_MHPMCOUNTER14H  = 12'hB8E,
    CSR_ADDR_MHPMCOUNTER15H  = 12'hB8F,
    CSR_ADDR_MHPMCOUNTER16H  = 12'hB90,
    CSR_ADDR_MHPMCOUNTER17H  = 12'hB91,
    CSR_ADDR_MHPMCOUNTER18H  = 12'hB92,
    CSR_ADDR_MHPMCOUNTER19H  = 12'hB93,
    CSR_ADDR_MHPMCOUNTER20H  = 12'hB94,
    CSR_ADDR_MHPMCOUNTER21H  = 12'hB95,
    CSR_ADDR_MHPMCOUNTER22H  = 12'hB96,
    CSR_ADDR_MHPMCOUNTER23H  = 12'hB97,
    CSR_ADDR_MHPMCOUNTER24H  = 12'hB98,
    CSR_ADDR_MHPMCOUNTER25H  = 12'hB99,
    CSR_ADDR_MHPMCOUNTER26H  = 12'hB9A,
    CSR_ADDR_MHPMCOUNTER27H  = 12'hB9B,
    CSR_ADDR_MHPMCOUNTER28H  = 12'hB9C,
    CSR_ADDR_MHPMCOUNTER29H  = 12'hB9D,
    CSR_ADDR_MHPMCOUNTER30H  = 12'hB9E,
    CSR_ADDR_MHPMCOUNTER31H  = 12'hB9F,

    CSR_ADDR_CYCLEH          = 12'hC80,
    CSR_ADDR_TIMEH           = 12'hC81,
    CSR_ADDR_INSTRETH        = 12'hC82,

    CSR_ADDR_MHPMEVENT3      = 12'h323,
    CSR_ADDR_MHPMEVENT4      = 12'h324,
    CSR_ADDR_MHPMEVENT5      = 12'h325,
    CSR_ADDR_MHPMEVENT6      = 12'h326,
    CSR_ADDR_MHPMEVENT7      = 12'h327,
    CSR_ADDR_MHPMEVENT8      = 12'h328,
    CSR_ADDR_MHPMEVENT9      = 12'h329,
    CSR_ADDR_MHPMEVENT10     = 12'h32A,
    CSR_ADDR_MHPMEVENT11     = 12'h32B,
    CSR_ADDR_MHPMEVENT12     = 12'h32C,
    CSR_ADDR_MHPMEVENT13     = 12'h32D,
    CSR_ADDR_MHPMEVENT14     = 12'h32E,
    CSR_ADDR_MHPMEVENT15     = 12'h32F,
    CSR_ADDR_MHPMEVENT16     = 12'h330,
    CSR_ADDR_MHPMEVENT17     = 12'h331,
    CSR_ADDR_MHPMEVENT18     = 12'h332,
    CSR_ADDR_MHPMEVENT19     = 12'h333,
    CSR_ADDR_MHPMEVENT20     = 12'h334,
    CSR_ADDR_MHPMEVENT21     = 12'h335,
    CSR_ADDR_MHPMEVENT22     = 12'h336,
    CSR_ADDR_MHPMEVENT23     = 12'h337,
    CSR_ADDR_MHPMEVENT24     = 12'h338,
    CSR_ADDR_MHPMEVENT25     = 12'h339,
    CSR_ADDR_MHPMEVENT26     = 12'h33A,
    CSR_ADDR_MHPMEVENT27     = 12'h33B,
    CSR_ADDR_MHPMEVENT28     = 12'h33C,
    CSR_ADDR_MHPMEVENT29     = 12'h33D,
    CSR_ADDR_MHPMEVENT30     = 12'h33E,
    CSR_ADDR_MHPMEVENT31     = 12'h33F,
    CSR_ADDR_TSELECT         = 12'h7A0,
    CSR_ADDR_TDATA1          = 12'h7A1,
    CSR_ADDR_TDATA2          = 12'h7A2,
    CSR_ADDR_TDATA3          = 12'h7A3,
    CSR_ADDR_TINFO           = 12'h7A4,
    CSR_ADDR_DCSR            = 12'h7B0,
    CSR_ADDR_DPC             = 12'h7B1,
    CSR_ADDR_DSCRATCH        = 12'h7B2,
    CSR_ADDR_CUST_SRA        = 12'h7C0,
    CSR_ADDR_CUST_SRD        = 12'h7C1,
    CSR_ADDR_CUST_ITBA       = 12'h7C2,
    CSR_ADDR_CUST_ITBD       = 12'h7C3
    // }}}
    // }}}
  } csr_addr_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
    CSR_GRP0_USTATUS         = 8'h00,
    CSR_GRP0_UIE             = 8'h04,
    CSR_GRP0_UTVEC           = 8'h05,
    CSR_GRP0_USCRATCH        = 8'h40,
    CSR_GRP0_UEPC            = 8'h41,
    CSR_GRP0_UCAUSE          = 8'h42,
    CSR_GRP0_UTVAL           = 8'h43,
    CSR_GRP0_UIP             = 8'h44,
    CSR_GRP0_FFLAGS          = 8'h01,
    CSR_GRP0_FRM             = 8'h02,
    CSR_GRP0_FCSR            = 8'h03
  } csr_grp0_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
    CSR_GRP1_SSTATUS         = 8'h00,
    CSR_GRP1_SEDELEG         = 8'h02,
    CSR_GRP1_SIDELEG         = 8'h03,
    CSR_GRP1_SIE             = 8'h04,
    CSR_GRP1_STVEC           = 8'h05,
    CSR_GRP1_SCOUNTEREN      = 8'h06,
    CSR_GRP1_SSCRATCH        = 8'h40,
    CSR_GRP1_SEPC            = 8'h41,
    CSR_GRP1_SCAUSE          = 8'h42,
    CSR_GRP1_STVAL           = 8'h43,
    CSR_GRP1_SIP             = 8'h44,
    CSR_GRP1_SATP            = 8'h80
  } csr_grp1_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
    CSR_GRP3_MSTATUS         = 8'h00,
    CSR_GRP3_MISA            = 8'h01,
    CSR_GRP3_MEDELEG         = 8'h02,
    CSR_GRP3_MIDELEG         = 8'h03,
    CSR_GRP3_MIE             = 8'h04,
    CSR_GRP3_MTVEC           = 8'h05,
    CSR_GRP3_MCOUNTEREN      = 8'h06,
    CSR_GRP3_MSCRATCH        = 8'h40,
    CSR_GRP3_MEPC            = 8'h41,
    CSR_GRP3_MCAUSE          = 8'h42,
    CSR_GRP3_MTVAL           = 8'h43,
    CSR_GRP3_MIP             = 8'h44,
    CSR_GRP3_PMPCFG0         = 8'hA0,
    CSR_GRP3_PMPCFG1         = 8'hA1,
    CSR_GRP3_PMPCFG2         = 8'hA2,
    CSR_GRP3_PMPCFG3         = 8'hA3,
    CSR_GRP3_PMPADDR0        = 8'hB0,
    CSR_GRP3_PMPADDR1        = 8'hB1,
    CSR_GRP3_PMPADDR2        = 8'hB2,
    CSR_GRP3_PMPADDR3        = 8'hB3,
    CSR_GRP3_PMPADDR4        = 8'hB4,
    CSR_GRP3_PMPADDR5        = 8'hB5,
    CSR_GRP3_PMPADDR6        = 8'hB6,
    CSR_GRP3_PMPADDR7        = 8'hB7,
    CSR_GRP3_PMPADDR8        = 8'hB8,
    CSR_GRP3_PMPADDR9        = 8'hB9,
    CSR_GRP3_PMPADDR10       = 8'hBA,
    CSR_GRP3_PMPADDR11       = 8'hBB,
    CSR_GRP3_PMPADDR12       = 8'hBC,
    CSR_GRP3_PMPADDR13       = 8'hBD,
    CSR_GRP3_PMPADDR14       = 8'hBE,
    CSR_GRP3_PMPADDR15       = 8'hBF,
    CSR_GRP3_MCOUNTINHIBIT   = 8'h20,
    CSR_GRP3_MHPMEVENT3      = 8'h23,
    CSR_GRP3_MHPMEVENT4      = 8'h24,
    CSR_GRP3_MHPMEVENT5      = 8'h25,
    CSR_GRP3_MHPMEVENT6      = 8'h26,
    CSR_GRP3_MHPMEVENT7      = 8'h27,
    CSR_GRP3_MHPMEVENT8      = 8'h28,
    CSR_GRP3_MHPMEVENT9      = 8'h29,
    CSR_GRP3_MHPMEVENT10     = 8'h2A,
    CSR_GRP3_MHPMEVENT11     = 8'h2B,
    CSR_GRP3_MHPMEVENT12     = 8'h2C,
    CSR_GRP3_MHPMEVENT13     = 8'h2D,
    CSR_GRP3_MHPMEVENT14     = 8'h2E,
    CSR_GRP3_MHPMEVENT15     = 8'h2F,
    CSR_GRP3_MHPMEVENT16     = 8'h30,
    CSR_GRP3_MHPMEVENT17     = 8'h31,
    CSR_GRP3_MHPMEVENT18     = 8'h32,
    CSR_GRP3_MHPMEVENT19     = 8'h33,
    CSR_GRP3_MHPMEVENT20     = 8'h34,
    CSR_GRP3_MHPMEVENT21     = 8'h35,
    CSR_GRP3_MHPMEVENT22     = 8'h36,
    CSR_GRP3_MHPMEVENT23     = 8'h37,
    CSR_GRP3_MHPMEVENT24     = 8'h38,
    CSR_GRP3_MHPMEVENT25     = 8'h39,
    CSR_GRP3_MHPMEVENT26     = 8'h3A,
    CSR_GRP3_MHPMEVENT27     = 8'h3B,
    CSR_GRP3_MHPMEVENT28     = 8'h3C,
    CSR_GRP3_MHPMEVENT29     = 8'h3D,
    CSR_GRP3_MHPMEVENT30     = 8'h3E,
    CSR_GRP3_MHPMEVENT31     = 8'h3F
  } csr_grp3_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
`ifdef SUPPORT_DMA
    CSR_GRP6_DMA_DONE         = 8'h02,
`endif

`ifdef SUPPORT_UART
    CSR_GRP6_TO_UART          = 8'h10,
    CSR_GRP6_FROM_UART        = 8'h11,
`endif

`ifdef VECTOR_GEN2
    CSR_GRP6_SP2VP_VPREDREG_VLEN          = 8'hF0,
    CSR_GRP6_SP2VP_VPREDREG_VLS_VLEN_GRPDEPTH_RATIO  = 8'hF1,
    CSR_GRP6_SP2VP_VPREDREG_VLS_GRPDEPTH  = 8'hF3,
    CSR_GRP6_SP2VP_VPREDREG_VLS_GRPSTRIDE = 8'hF5,
`endif
    CSR_GRP6_CFG              = 8'h00,
    CSR_GRP6_TIMER            = 8'h01
  } csr_grp6_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
    CSR_GRPB_MCYCLE          = 8'h00,
    CSR_GRPB_MINSTRET        = 8'h02,
    CSR_GRPB_MHPMCOUNTER3    = 8'h03,
    CSR_GRPB_MHPMCOUNTER4    = 8'h04,
    CSR_GRPB_MHPMCOUNTER5    = 8'h05,
    CSR_GRPB_MHPMCOUNTER6    = 8'h06,
    CSR_GRPB_MHPMCOUNTER7    = 8'h07,
    CSR_GRPB_MHPMCOUNTER8    = 8'h08,
    CSR_GRPB_MHPMCOUNTER9    = 8'h09,
    CSR_GRPB_MHPMCOUNTER10   = 8'h0A,
    CSR_GRPB_MHPMCOUNTER11   = 8'h0B,
    CSR_GRPB_MHPMCOUNTER12   = 8'h0C,
    CSR_GRPB_MHPMCOUNTER13   = 8'h0D,
    CSR_GRPB_MHPMCOUNTER14   = 8'h0E,
    CSR_GRPB_MHPMCOUNTER15   = 8'h0F,
    CSR_GRPB_MHPMCOUNTER16   = 8'h10,
    CSR_GRPB_MHPMCOUNTER17   = 8'h11,
    CSR_GRPB_MHPMCOUNTER18   = 8'h12,
    CSR_GRPB_MHPMCOUNTER19   = 8'h13,
    CSR_GRPB_MHPMCOUNTER20   = 8'h14,
    CSR_GRPB_MHPMCOUNTER21   = 8'h15,
    CSR_GRPB_MHPMCOUNTER22   = 8'h16,
    CSR_GRPB_MHPMCOUNTER23   = 8'h17,
    CSR_GRPB_MHPMCOUNTER24   = 8'h18,
    CSR_GRPB_MHPMCOUNTER25   = 8'h19,
    CSR_GRPB_MHPMCOUNTER26   = 8'h1A,
    CSR_GRPB_MHPMCOUNTER27   = 8'h1B,
    CSR_GRPB_MHPMCOUNTER28   = 8'h1C,
    CSR_GRPB_MHPMCOUNTER29   = 8'h1D,
    CSR_GRPB_MHPMCOUNTER30   = 8'h1E,
    CSR_GRPB_MHPMCOUNTER31   = 8'h1F,
    CSR_GRPB_MCYCLEH         = 8'h80,
    CSR_GRPB_MINSTRETH       = 8'h82,
    CSR_GRPB_MHPMCOUNTER3H   = 8'h83,
    CSR_GRPB_MHPMCOUNTER4H   = 8'h84,
    CSR_GRPB_MHPMCOUNTER5H   = 8'h85,
    CSR_GRPB_MHPMCOUNTER6H   = 8'h86,
    CSR_GRPB_MHPMCOUNTER7H   = 8'h87,
    CSR_GRPB_MHPMCOUNTER8H   = 8'h88,
    CSR_GRPB_MHPMCOUNTER9H   = 8'h89,
    CSR_GRPB_MHPMCOUNTER10H  = 8'h8A,
    CSR_GRPB_MHPMCOUNTER11H  = 8'h8B,
    CSR_GRPB_MHPMCOUNTER12H  = 8'h8C,
    CSR_GRPB_MHPMCOUNTER13H  = 8'h8D,
    CSR_GRPB_MHPMCOUNTER14H  = 8'h8E,
    CSR_GRPB_MHPMCOUNTER15H  = 8'h8F,
    CSR_GRPB_MHPMCOUNTER16H  = 8'h90,
    CSR_GRPB_MHPMCOUNTER17H  = 8'h91,
    CSR_GRPB_MHPMCOUNTER18H  = 8'h92,
    CSR_GRPB_MHPMCOUNTER19H  = 8'h93,
    CSR_GRPB_MHPMCOUNTER20H  = 8'h94,
    CSR_GRPB_MHPMCOUNTER21H  = 8'h95,
    CSR_GRPB_MHPMCOUNTER22H  = 8'h96,
    CSR_GRPB_MHPMCOUNTER23H  = 8'h97,
    CSR_GRPB_MHPMCOUNTER24H  = 8'h98,
    CSR_GRPB_MHPMCOUNTER25H  = 8'h99,
    CSR_GRPB_MHPMCOUNTER26H  = 8'h9A,
    CSR_GRPB_MHPMCOUNTER27H  = 8'h9B,
    CSR_GRPB_MHPMCOUNTER28H  = 8'h9C,
    CSR_GRPB_MHPMCOUNTER29H  = 8'h9D,
    CSR_GRPB_MHPMCOUNTER30H  = 8'h9E,
    CSR_GRPB_MHPMCOUNTER31H  = 8'h9F
  } csr_grpb_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
    CSR_GRPC_CYCLE           = 8'h00,
    CSR_GRPC_TIME            = 8'h01,
    CSR_GRPC_INSTRET         = 8'h02,
    CSR_GRPC_HPMCOUNTER3     = 8'h03,
    CSR_GRPC_HPMCOUNTER4     = 8'h04,
    CSR_GRPC_HPMCOUNTER5     = 8'h05,
    CSR_GRPC_HPMCOUNTER6     = 8'h06,
    CSR_GRPC_HPMCOUNTER7     = 8'h07,
    CSR_GRPC_HPMCOUNTER8     = 8'h08,
    CSR_GRPC_HPMCOUNTER9     = 8'h09,
    CSR_GRPC_HPMCOUNTER10    = 8'h0A,
    CSR_GRPC_HPMCOUNTER11    = 8'h0B,
    CSR_GRPC_HPMCOUNTER12    = 8'h0C,
    CSR_GRPC_HPMCOUNTER13    = 8'h0D,
    CSR_GRPC_HPMCOUNTER14    = 8'h0E,
    CSR_GRPC_HPMCOUNTER15    = 8'h0F,
    CSR_GRPC_HPMCOUNTER16    = 8'h10,
    CSR_GRPC_HPMCOUNTER17    = 8'h11,
    CSR_GRPC_HPMCOUNTER18    = 8'h12,
    CSR_GRPC_HPMCOUNTER19    = 8'h13,
    CSR_GRPC_HPMCOUNTER20    = 8'h14,
    CSR_GRPC_HPMCOUNTER21    = 8'h15,
    CSR_GRPC_HPMCOUNTER22    = 8'h16,
    CSR_GRPC_HPMCOUNTER23    = 8'h17,
    CSR_GRPC_HPMCOUNTER24    = 8'h18,
    CSR_GRPC_HPMCOUNTER25    = 8'h19,
    CSR_GRPC_HPMCOUNTER26    = 8'h1A,
    CSR_GRPC_HPMCOUNTER27    = 8'h1B,
    CSR_GRPC_HPMCOUNTER28    = 8'h1C,
    CSR_GRPC_HPMCOUNTER29    = 8'h1D,
    CSR_GRPC_HPMCOUNTER30    = 8'h1E,
    CSR_GRPC_HPMCOUNTER31    = 8'h1F,
    CSR_GRPC_CYCLEH          = 8'h80,
    CSR_GRPC_TIMEH           = 8'h81,
    CSR_GRPC_INSTRETH        = 8'h82,
    CSR_GRPC_HPMCOUNTER3H    = 8'h83,
    CSR_GRPC_HPMCOUNTER4H    = 8'h84,
    CSR_GRPC_HPMCOUNTER5H    = 8'h85,
    CSR_GRPC_HPMCOUNTER6H    = 8'h86,
    CSR_GRPC_HPMCOUNTER7H    = 8'h87,
    CSR_GRPC_HPMCOUNTER8H    = 8'h88,
    CSR_GRPC_HPMCOUNTER9H    = 8'h89,
    CSR_GRPC_HPMCOUNTER10H   = 8'h8A,
    CSR_GRPC_HPMCOUNTER11H   = 8'h8B,
    CSR_GRPC_HPMCOUNTER12H   = 8'h8C,
    CSR_GRPC_HPMCOUNTER13H   = 8'h8D,
    CSR_GRPC_HPMCOUNTER14H   = 8'h8E,
    CSR_GRPC_HPMCOUNTER15H   = 8'h8F,
    CSR_GRPC_HPMCOUNTER16H   = 8'h90,
    CSR_GRPC_HPMCOUNTER17H   = 8'h91,
    CSR_GRPC_HPMCOUNTER18H   = 8'h92,
    CSR_GRPC_HPMCOUNTER19H   = 8'h93,
    CSR_GRPC_HPMCOUNTER20H   = 8'h94,
    CSR_GRPC_HPMCOUNTER21H   = 8'h95,
    CSR_GRPC_HPMCOUNTER22H   = 8'h96,
    CSR_GRPC_HPMCOUNTER23H   = 8'h97,
    CSR_GRPC_HPMCOUNTER24H   = 8'h98,
    CSR_GRPC_HPMCOUNTER25H   = 8'h99,
    CSR_GRPC_HPMCOUNTER26H   = 8'h9A,
    CSR_GRPC_HPMCOUNTER27H   = 8'h9B,
    CSR_GRPC_HPMCOUNTER28H   = 8'h9C,
    CSR_GRPC_HPMCOUNTER29H   = 8'h9D,
    CSR_GRPC_HPMCOUNTER30H   = 8'h9E,
    CSR_GRPC_HPMCOUNTER31H   = 8'h9F
  } csr_grpc_t;
  typedef enum logic [CSR_ADDR_CUT_WIDTH-1:0] {
    CSR_GRPF_MVENDORID       = 8'h11,
    CSR_GRPF_MARCHID         = 8'h12,
    CSR_GRPF_MIMPID          = 8'h13,
    CSR_GRPF_MHARTID         = 8'h14
  } csr_grpf_t;
  typedef enum logic [1:0] { // {{{
    OFF   = 2'b00,
    TOR   = 2'b01,
    NA4   = 2'b10,
    NAPOT = 2'b11 // }}}
  } pmp_access_type;
  typedef enum logic [1:0] { // {{{
    PRV_U = 2'b00,
    PRV_S = 2'b01,
    PRV_M = 2'b11 // }}}
  } prv_t;
  typedef enum logic [1:0] { // {{{
    CSR_OP_RW = 2'b01,
    CSR_OP_RS = 2'b10,
    CSR_OP_RC = 2'b11,
    CSR_OP_NONE = 2'b00 // }}}
  } csr_op_t;
  typedef enum logic [1:0] { // {{{
    CSR_MTVEC_DIRECT = 2'b00,
    CSR_MTVEC_VECTORED = 2'b01,
    CSR_MTVEC_RSVD0 = 2'b10,
    CSR_MTVEC_RSVD1 = 2'b11 // }}}
  } csr_mtvec_mode_t;
  typedef enum logic [31:0] { // {{{// modified by lei 11/28/2019
    CSR_MCAUSE_U_SW_INT = {1'b1, 31'('d0)},
    CSR_MCAUSE_S_SW_INT = {1'b1, 31'('d1)},
    CSR_MCAUSE_M_SW_INT = {1'b1, 31'('d3)},
    CSR_MCAUSE_U_TIME_INT = {1'b1, 31'('d4)},
    CSR_MCAUSE_S_TIME_INT = {1'b1, 31'('d5)},
    CSR_MCAUSE_M_TIME_INT = {1'b1, 31'('d7)},
    CSR_MCAUSE_U_EXT_INT = {1'b1, 31'('d8)},
    CSR_MCAUSE_S_EXT_INT = {1'b1, 31'('d9)},
    CSR_MCAUSE_M_EXT_INT = {1'b1, 31'('d11)},
    //added by lei 11/28/2019
    CSR_MCAUSE_U_FINT = {1'b1, 31'('d12)},//user fast interrupt
    CSR_MCAUSE_S_FINT = {1'b1, 31'('d13)},//supervisor fast interrupt
    CSR_MCAUSE_M_FINT = {1'b1, 31'('d15)},//machine fast interrupt

    CSR_MCAUSE_INST_ADDR_MISALIGNED = {1'b0, 31'('d0)},
    CSR_MCAUSE_INST_ACCESS_FAULT = {1'b0, 31'('d1)},
    CSR_MCAUSE_ILLEGAL_INST = {1'b0, 31'('d2)},
    CSR_MCAUSE_BREAKPOINT = {1'b0, 31'('d3)},
    CSR_MCAUSE_LOAD_ADDR_MISALIGNED = {1'b0, 31'('d4)},
    CSR_MCAUSE_LOAD_ACCESS_FAULT = {1'b0, 31'('d5)},
    CSR_MCAUSE_STORE_ADDR_MISALIGNED = {1'b0, 31'('d6)},
    CSR_MCAUSE_STORE_ACCESS_FAULT = {1'b0, 31'('d7)},
    CSR_MCAUSE_ECALL_FROM_U = {1'b0, 31'('d8)},
    CSR_MCAUSE_ECALL_FROM_S = {1'b0, 31'('d9)},
    CSR_MCAUSE_ECALL_FROM_M = {1'b0, 31'('d11)},
    CSR_MCAUSE_INST_PAGE_FAULT = {1'b0, 31'('d12)},
    CSR_MCAUSE_LOAD_PAGE_FAULT = {1'b0, 31'('d13)},
    CSR_MCAUSE_STORE_PAGE_FAULT = {1'b0, 31'('d15)}
    // }}}
  } csr_mcause_t;
  typedef enum logic [3:0] { // {{{
    INT_U_SW    = 'd0,
    INT_S_SW    = 'd1,
    INT_M_SW    = 'd3,
    INT_U_TIME  = 'd4,
    INT_S_TIME  = 'd5,
    INT_M_TIME  = 'd7,
    INT_U_EXT   = 'd8,
    INT_S_EXT   = 'd9,
    INT_M_EXT   = 'd11,
       //added by lei 11/28/2019
    INT_U_FINT   = 'd12,//user fast interrupt
    INT_S_FINT   = 'd13,//supervisor fast interrupt
    INT_M_FINT   = 'd15 //machine fast interrupt // }}}
  } int_cause_t;
  typedef enum logic [3:0] { // {{{
    EXCP_CAUSE_INST_ADDR_MISALIGNED = 4'('d0),
    EXCP_CAUSE_INST_ACCESS_FAULT = 4'('d1),
    EXCP_CAUSE_ILLEGAL_INST = 4'('d2),
    EXCP_CAUSE_BREAKPOINT = 4'('d3),
    EXCP_CAUSE_LOAD_ADDR_MISALIGNED = 4'('d4),
    EXCP_CAUSE_LOAD_ACCESS_FAULT = 4'('d5),
    EXCP_CAUSE_STORE_ADDR_MISALIGNED = 4'('d6),
    EXCP_CAUSE_STORE_ACCESS_FAULT = 4'('d7),
    EXCP_CAUSE_ECALL_FROM_U = 4'('d8),
    EXCP_CAUSE_ECALL_FROM_S = 4'('d9),
    EXCP_CAUSE_ECALL_FROM_M = 4'('d11),
    EXCP_CAUSE_INST_PAGE_FAULT = 4'('d12),
    EXCP_CAUSE_LOAD_PAGE_FAULT = 4'('d13),
    EXCP_CAUSE_STORE_PAGE_FAULT = 4'('d15),
    EXCP_CAUSE_NONE = 4'('d10)
    // }}}
  } excp_cause_t;
  typedef enum logic [1:0] { // {{{
    FENCE_TYPE_FENCE,
    FENCE_TYPE_FENCE_I,
    FENCE_TYPE_NONE // }}}
  } fence_type_t;
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
  } csr_counteren_t;
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
  } csr_countinhibit_t;

  //==========================================================
  // struct

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
  } csr_misa_ext_t;
  typedef struct packed { // {{{
    logic [ 1:0]  MXL; // [63:62]
    csr_misa_ext_t EXTENSIONS;
  } csr_misa_t;
`ifdef ORV_32
  typedef struct packed { // {{{
    logic         SD;
    //modified by lei 11/25/2019
    logic [ 6:0]  reserved_30_to_24;
    logic         MFPIE;

    logic         TSR;
    logic         TW;
    logic         TVM;
    logic         MXR;
    logic         SUM;
    logic         MPRV;
    logic [ 1:0]  XS;
    logic [ 1:0]  FS;
    prv_t         MPP;
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
  } csr_mstatus_t;
`else
  typedef struct packed { // {{{
    logic         SD;
    logic [26:0]  reserved_62_to_36;
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
    logic [ 1:0]  MPP;
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
  } csr_mstatus_t;
`endif
  typedef struct packed { // {{{
    logic [(XLEN-2)-1:0]  base;
    csr_mtvec_mode_t mode; // }}}
  } csr_mtvec_t;
  typedef struct packed { // {{{
    logic en_hpmcounter; // }}}
  } csr_cfg_t;
  typedef struct packed { // {{{
    //added by lei 11/25/2019
    logic MFIP;//for fast interrupt
    logic HFIP;//for fast interrupt
    logic SFIP;//for fast interrupt
    logic UFIP;//for fast interrupt

    logic MEIP;
    logic HEIP;
    logic SEIP;
    logic UEIP;
    logic MTIP;
    logic HTIP;
    logic STIP;
    logic UTIP;
    logic MSIP;
    logic HSIP;
    logic SSIP;
    logic USIP; // }}}
  } csr_mip_t;
  typedef struct packed {
    //added by lei 11/25/2019
    logic MFIE;//for fast interrupt
    logic HFIE;//for fast interrupt
    logic SFIE;//for fast interrupt
    logic UFIE;//for fast interrupt

    logic MEIE;
    logic HEIE;
    logic SEIE;
    logic UEIE;
    logic MTIE;
    logic HTIE;
    logic STIE;
    logic UTIE;
    logic MSIE;
    logic HSIE;
    logic SSIE;
    logic USIE;
  } csr_mie_t;
  typedef struct packed {
    logic           l;
    logic [1:0]     reserved;
    pmp_access_type a;
    logic           x;
    logic           w;
    logic           r;
  } csr_pmpcfg_part_t;
  typedef struct packed {
    csr_pmpcfg_part_t [N_PMP_CFG_PARTS-1:0] pmpcfg;
  } csr_pmpcfg_t;

  //------------------------------------------------------
  // exception
  typedef struct packed { // {{{
    logic         valid;
    excp_cause_t  cause;
    vaddr_t       vpc;
    // }}}
  } excp_t;

  //==========================================================
  // pipeline registers

  //------------------------------------------------------
  // if2id {{{
  typedef struct packed {
    inst_t        inst;
    vaddr_t       vpc;
    reg_addr_t    rs1_addr, rs2_addr, rd_addr;
    logic         is_rvc;
  } if2id_t;

  typedef struct packed {
    logic         rs1_re, rs2_re,
                  is_rs1_x0, is_rs2_x0;
`ifndef SYNTHESIS
    logic [63:0]  inst_code;
`endif
  } if2id_ctrl_t;

  typedef struct packed { // (by Anh)
      logic [2:0]                 thread_id;
      logic [31:0]                instr;
  } if2vid_t;
  // }}}

  //------------------------------------------------------
  // id2ex {{{
  typedef struct packed {
    vaddr_t       vpc;
    inst_t        inst;
    data_t        rs1, rs2;
    reg_addr_t    rd_addr;
    logic         is_rvc;
    logic         is_rs1_final, is_rs2_final;
  } id2ex_t;

  typedef struct packed {
    // new in ID
    alu_op_t      alu_op;
    logic         alu_en;
    logic         is_32;
    op1_sel_t     op1_sel;
    op2_sel_t     op2_sel;
    imm_sel_t     imm_sel;
    rd_avail_t    rd_avail;
    logic         rd_we;
    ex_pc_adder_sel_t ex_pc_adder_sel;
    ex_next_pc_sel_t  ex_next_pc_sel;
    ex_out_sel_t      ex_out_sel;
    // new in ID for MULDIV
    mul_type_t    mul_type;
    div_type_t    div_type;
`ifndef SYNTHESIS
    logic [63:0]  inst_code;
`endif
  } id2ex_ctrl_t;

  typedef struct packed {
    data_t        rs1, rs2;
  } id2muldiv_t;

  typedef struct packed {
    logic         valid;
    logic         is_same;
  } id2muldiv_ctrl_t;
  // }}}

  //------------------------------------------------------
  // forwarding {{{
  typedef struct packed {
    reg_addr_t  rd_addr;
    data_t      rd;
  } forward_t;
  // }}}

  //------------------------------------------------------
  // ex2ma {{{
  typedef struct packed {
    vaddr_t       vpc;
    inst_t        inst;
    data_t        ex_out;
    reg_addr_t    rd_addr;
    csr_addr_t    csr_addr;
  } ex2ma_t;

  typedef struct packed {
    // copy from ID
    logic         rd_we;
    rd_avail_t    rd_avail;
    // new in EX to MA
    logic         is_load, is_store;
    fence_type_t  fence_type;
    rd_sel_t      rd_sel;
    ma_byte_sel_t ma_byte_sel;
    // new in EX to CS
    csr_op_t      csr_op;
    ret_type_t    ret_type;
    logic         is_wfi;
    logic         is_wfe;

`ifndef SYNTHESIS
    logic [63:0]  inst_code;
`endif
  } ex2ma_ctrl_t;
  // }}}

  //------------------------------------------------------
  // ma2cs {{{
  typedef struct packed {
    vaddr_t     vpc;
    inst_t      inst;
    csr_addr_t  csr_addr;
    data_t      rs1;
    vaddr_t     mem_addr;
  } ma2cs_t;

  typedef struct packed {
    csr_op_t    csr_op;
    ret_type_t  ret_type;
    logic       is_wfi;
  } ma2cs_ctrl_t;

  typedef struct packed {
    data_t      csr;
  } cs2ma_t;
  // }}}

  //------------------------------------------------------
  // regfile {{{
  typedef struct packed {
    reg_addr_t  rs1_addr, rs2_addr;
    logic       rs1_re, rs2_re;
  } id2irf_t;

  typedef struct packed {
    data_t  rs1, rs2;
  } irf2id_t;
  typedef struct packed {
    data_t      rd;
    reg_addr_t  rd_addr;
    logic       rd_we;
  } ma2rf_t;
  // }}}

  //------------------------------------------------------
  // cpunoc i/f {{{

  typedef enum logic [CPUNOC_TID_SRCID_SIZE-1:0] {
    ORV_DC_SRC_ID   = CPUNOC_TID_SRCID_SIZE'(4'h0),
    ORV_IC_SRC_ID   = CPUNOC_TID_SRCID_SIZE'(4'h1)
  } orv_src_id_t;
 
  // }}}

  //------------------------------------------------------
  // inst buffer {{{

  typedef struct packed { // {{{
    vaddr_t     vpc;
    logic       en; // }}}
  } pc2ib_t;

  typedef struct packed { // {{{
    inst_t       inst;
    logic        is_rvc;
    vaddr_t      vpc;
    logic        valid; // }}}
  } ib2if_t;

  typedef struct packed { // {{{
    vaddr_t     vpc;
    logic       en; // }}}
  } ib2icmem_t;

  typedef struct packed { // {{{
    cache_line_t       rdata;
    logic              valid; // }}}
  } icmem2ib_t;

  typedef struct packed { // {{{
    vaddr_t     vpc; // }}}
  } ib2icmem_req_t;

  typedef struct packed { // {{{
    cache_line_t       rdata; // }}}
  } icmem2ib_resp_t;

  // }}}

  //------------------------------------------------------
  // L1 path enum {{{

  typedef enum logic [1:0] {
    BYPASS_PATH = 2'b00,
    L1_PATH     = 2'b01,
    SYS_PATH    = 2'b10,
    TCM_PATH    = 2'b11
  } l1_path_t;


  // }}}
  //------------------------------------------------------
  // icache {{{
  typedef struct packed {
    vaddr_t   vpc;
  } pc2ic_t;

  typedef struct packed {
    logic         excp_valid;
    excp_cause_t  excp_cause;
    logic         is_rvc;
    vaddr_t       vpc;
    inst_t        inst;
  } ic2id_t;

  typedef struct packed {
    logic           is_excp;
    cache_line_t    rdata;
  } ic2ib_t;
  typedef logic [ICACHE_TAG_WIDTH-1:0]  ic_tag_t;
  typedef struct packed {
    logic       valid;
    logic [2:0] reserved; // Uses same tag RAM as ORV64, but ORV64 has a wider tag
    ic_tag_t    tag;
  } ic_tag_entry_t;
  typedef logic [ICACHE_INDEX_WIDTH-1:0]        ic_idx_t;
  // }}}
  //------------------------------------------------------
  // dcache {{{
  typedef struct packed {
    logic             rw;
    vaddr_t           vaddr;
    data_t            wdata;
    data_byte_mask_t  mask;
  } ex2dc_t;

  typedef struct packed {
    // logic             is_page_fault;
    logic             is_excp;
    data_t            rdata;
  } dc2ma_t;

  typedef enum logic [1:0] {
    ACCESS_FETCH = 2'b00,
    ACCESS_LOAD  = 2'b01,
    ACCESS_STORE = 2'b10,
    ACCESS_NONE  = 2'b11
  } mem_access_type_t;
  // }}}

  typedef struct packed {
    cntr_t          mcycle;
    cntr_t          minstret;
    csr_mstatus_t   mstatus;
    csr_misa_t      misa;
    vaddr_t         mepc;
    data_t          mscratch;
    csr_mtvec_t     mtvec;
    csr_mcause_t    mcause;
        //added by lei 11/22/2019
    data_t          mtval;
    vaddr_t         mfepc;
    csr_mcause_t    mfcause;
    data_t          mftval;

    csr_mie_t       mie; //added by jiang zhiqiang
    csr_mip_t       mip; //added by jiang zhiqiang
    data_t          mcounteren; //added by jiang zhiqiang
    logic [7:0]     mhartid; //added by jiang zhiqiang

    cntr_t          hpmcounter3,
                    hpmcounter4,
                    hpmcounter5,
                    hpmcounter6,
                    hpmcounter7,
                    hpmcounter8,
                    hpmcounter9,
                    hpmcounter10;
  } cs2da_t;

  //------------------------------------------------------
  // L1 debug access
  typedef struct packed {
    vaddr_t   if_pc, wb_pc;
    logic     if_stall, if_kill, if_valid, if_ready,
              id_stall, id_kill, id_valid, id_ready,
              ex_stall, ex_kill, ex_valid, ex_ready,
              ma_stall, ma_kill, ma_valid, ma_ready,
              wb_valid, wb_ready,
              cs2if_kill, cs2id_kill, cs2ex_kill, cs2ma_kill,
              l2_req_valid, l2_req_ready, l2_resp_valid, l2_resp_ready,
              is_wfe, ma2if_npc_valid, ex2if_kill, ex2id_kill, branch_solved;
    logic     is_ebreak; //added by jiang zhiqiang
    pc2ic_t         pc2ic;
    ic2id_t         ic2id;
    excp_t          id2ex_excp_ff;
    excp_t          ex2ma_excp_ff;
    excp_t          ma2cs_excp;
    id2ex_ctrl_t    id2ex_ctrl_ff;
    ex2ma_ctrl_t    ex2ma_ctrl_ff;
    ma2cs_ctrl_t    ma2cs_ctrl;
    cs2da_t         cs2da;
  } orv2da_t;

  //==========================================================
  // RVC
  typedef enum logic [1:0] {
    RVC_C0  = 2'b00,
    RVC_C1  = 2'b01,
    RVC_C2  = 2'b10
  } rvc_opcode_t;

  //==========================================================
  // TCM

  typedef logic [TCM_ADDR_WIDTH-1:0] tcm_addr_t;
  typedef logic [TCM_DATA_WIDTH-1:0] tcm_data_t;
  typedef logic [TCM_MASK_WIDTH-1:0] tcm_bytemask_t;
  typedef logic [TCM_BANK_ID_WIDTH-1:0] tcm_bank_id_t;
  typedef struct packed {
    logic          rw;
    tcm_data_t     wdata;
    tcm_bytemask_t mask;
    tcm_addr_t     addr;
  } tcm_req_t;
  typedef struct packed {
    tcm_data_t rdata;
  } tcm_resp_t;
  typedef struct packed {
    logic       dbg_en;
    logic       dbg_rw;
    tcm_addr_t  dbg_addr;
    tcm_data_t  dbg_din;
    tcm_bytemask_t dbg_mask;
  } da2tcm_t;
  typedef struct packed {
    tcm_data_t dbg_dout;
  } tcm2da_t;

  //==========================================================
  // instruction trace buffer

  typedef logic [ITB_ADDR_WIDTH-1:0]  itb_addr_t;
  typedef struct packed {
    vaddr_t   vpc;
  } itb_data_t;
  typedef enum logic [2:0] {
    ITB_SEL_IF = 3'h0,
    ITB_SEL_ID = 3'h1,
    ITB_SEL_EX = 3'h2,
    ITB_SEL_MA = 3'h3,
    ITB_SEL_WB = 3'h4
  } itb_sel_t;

  typedef struct packed {
    logic       en, rw;
    itb_addr_t  addr;
    itb_data_t  din;
  } da2itb_t;

  typedef struct packed {
    itb_data_t  dout;
  } itb2da_t;

endpackage

`endif
