// Copyright 2021 RISC-V International Open Source Laboratory (RIOS Lab). All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


`define __PYGMY_TYPEDEF__SV__

package pygmy_typedef;
  import pygmy_cfg::*;

  `define ZERO(n) {(n){1'b0}}
  `define ONE(n) {(n){1'b1}}
  `define ZERO_BITS(t) {($bits(t)){1'b0}}
  `define ONE_BITS(t) {($bits(t)){1'b1}}

  typedef logic [VIR_ADDR_WIDTH-1:0]      vaddr_t; // virtual address
  typedef logic [PHY_ADDR_WIDTH-1:0]      paddr_t; // physical address
  typedef logic [CACHE_LINE_BYTE*8-1:0]   cache_line_t; // cache line data
  typedef logic [CACHE_OFFSET_WIDTH-1:0]  cache_ofs_t; // byte offset inside a cache line

  //==========================================================
  // time
  
  typedef logic [TIMER_WIDTH-1:0]             timer_t;

  //==========================================================
  // virtual memory
  typedef logic [PAGE_OFFSET_WIDTH-1:0]       page_ofs_t; // byte offset inside a page
  typedef logic [VIR_PAGE_NUM_WIDTH-1:0]      vpn_t;
  typedef logic [VIR_PAGE_NUM_PART_WIDTH-1:0] vpn_part_t;

  typedef logic [PHY_PAGE_NUM_WIDTH-1:0]      ppn_t;
  typedef logic [PHY_PAGE_PART_WIDTH-1:0]     ppn_part_t;
  typedef logic [ADDR_SPACE_ID_WIDTH-1:0]     asid_t;

  //==========================================================
  // AXI4
  typedef enum logic[1:0] {
    AXI_RESP_OKAY = 2'b00,
    AXI_RESP_EXOKAY = 2'b01,
    AXI_RESP_SLVERR = 2'b10,
    AXI_RESP_DECERR = 2'b11
  } axi4_resp_t;

  //==========================================================
  // CPU to Cache interface
  typedef cache_line_t                  cpu_data_t;
  typedef logic [CACHE_LINE_BYTE-1:0]   cpu_byte_mask_t;

  typedef enum logic [3:0] {
    REQ_LR              = 4'b1000,
    REQ_SC              = 4'b1001,
    REQ_BARRIER_SET     = 4'b1010,
    REQ_BARRIER_SYNC    = 4'b1011,
    REQ_READ            = 4'b0000,
    REQ_WRITE           = 4'b0010,
    REQ_WRITE_NO_ALLOC  = 4'b0011, // no-allocate write
    REQ_AMO_LR          = 4'b0100, // load-reserved
    REQ_AMO_SC          = 4'b0101, // store-conditional
    REQ_FLUSH_IDX       = 4'b0110,
    REQ_FLUSH_ADDR      = 4'b0111
  } cpu_req_type_t;

  typedef struct packed {
    logic [CPUNOC_TID_MASTERID_SIZE-1:0] cpu_noc_id;
    logic [CPUNOC_TID_SRCID_SIZE-1:0]  src;
    logic [CPUNOC_TID_TID_SIZE-1:0]  tid;
  } cpu_tid_t;

  //==========================================================
  // Cache to mem interface
  `ifndef FPGA_ES1X
  typedef logic [MEM_DATA_WIDTH-1:0]    mem_data_t;
  `endif
  typedef logic [MEM_ADDR_WIDTH-1:0]    mem_addr_t;
  typedef struct packed {
    logic [MEMNOC_TID_MASTERID_SIZE-1:0] bid;
    logic [MEMNOC_TID_TID_SIZE-1:0] tid;
  } mem_tid_t;

  //==========================================================
  // OURSRING interface
  typedef logic [RING_ADDR_WIDTH-1:0]       ring_addr_t;
  typedef logic [RING_DATA_WIDTH-1:0]       ring_data_t;
  typedef logic [RING_STRB_WIDTH-1:0]       ring_strb_t;
  typedef logic [RING_MAX_ID_WIDTH+4-1:0]   ring_tid_t; // MSB is the station ID, which is different from station to station

  //==========================================================
  // DMA internal interface
  typedef struct packed {
    logic [6:0] tid; // [6]:~dma_thread, [5:4]:thread_id, [3:0]:tid
    logic [1:0] chk;
    cpu_req_type_t req_type;
    ring_addr_t addr;
    ring_data_t wdata;
    ring_strb_t mask;
  } dma_req_t;

  typedef struct packed {
    logic [6:0] tid;
    ring_data_t rdata;
    logic       is_wr_rsp;
  } dma_rsp_t;

  typedef logic dma_thread_align_t;
  parameter int DMA_RPT_CNT_WIDTH = 5;
  typedef logic [DMA_RPT_CNT_WIDTH-1:0] dma_thread_rpt_cnt_t;

  //! DMA
  typedef enum logic {READ, WRITE} rw_t;
  typedef enum logic [3:0] {DMA_IN_IDLE, DMA_AWRDY, DMA_BRSP, DMA_DBG_AWRDY, DMA_DBG_WR, DMA_ERR_AWRDY, DMA_ERR_BRSP, DMA_DBG_ARRDY, DMA_DBG_RD, DMA_DBG_RRSP, DMA_ERR_ARRDY, DMA_ERR_RRSP} dma_in_state_t;
  // end_addr is next line of last line
  typedef struct packed {logic [RING_ADDR_WIDTH-1 : 0] end_addr; logic [CACHE_LINE_BYTE*8-1:0] data; rw_t rw; logic [RING_MAX_ID_WIDTH+4-1:0] tid;} dma_cmd_t;
  typedef logic dma_thread_cmd_vld_t;
  typedef enum {DMA_OUT_IDLE, DMA_OUT_REQ} dma_out_state_t;
  typedef enum {DMA_PF_ADDR, DMA_DBG_ADDR, DMA_DBG_WDATA, DMA_DBG_RDATA} dma_addr_t;
  typedef enum logic [1:0] {
    DMA_FLUSH_ADDR = 2'b00,
    DMA_FLUSH_IDX  = 2'b01,
    DMA_FLUSH_ALL  = 2'b10
  } dma_flush_type_t;
  typedef enum logic [2:0] {
    DMA_DEBUG_RD_8B   = 3'b000,
    DMA_DEBUG_RD_4B   = 3'b001,
    DMA_DEBUG_WR_8B   = 3'b010,
    DMA_DEBUG_WR_4B   = 3'b011,
    DMA_DEBUG_BARRIER = 3'b100
  } dma_dbg_req_type_t;

  //==========================================================
  // AHB interface
  typedef logic [AHB_ADDR_WIDTH-1:0]      ahb_addr_t;
  typedef logic [AHB_DATA_WIDTH-1:0]      ahb_data_t;
  typedef enum logic [2:0] {
    AHB_SIZE_BYTE     = 3'b000,
    AHB_SIZE_HWORD    = 3'b001,
    AHB_SIZE_WORD     = 3'b010,
    AHB_SIZE_DWORD    = 3'b011,
    AHB_SIZE_4WORD    = 3'b100,
    AHB_SIZE_8WORD    = 3'b101
  } ahb_size_t;
  typedef enum logic [1:0] {
    AHB_TRANS_IDLE    = 2'b00,
    AHB_TRANS_BUSY    = 2'b01,
    AHB_TRANS_NONSEQ  = 2'b10,
    AHB_TRANS_SEQ     = 2'b11
  } ahb_trans_t;

  parameter N_DMA_CHNL = 4;

  //==========================================================
  // MEM-NOC interface
  //typedef logic [MEM_NOC_ADDR_WIDTH-1:0]		mem_noc_addr_t;
  //typedef logic [MEM_NOC_ID_WIDTH-1:0] 		mem_noc_id_t;
  //typedef logic [MEM_NOC_DATA_WIDTH-1:0]		mem_noc_data_t;
  //typedef logic [MEM_NOC_DATA_MASK_WIDTH-1:0]		mem_noc_data_mask_t;
  //typedef logic [MEM_NOC_RESP_STATUS_WIDTH-1:0]	mem_noc_resp_status_t;

  //==========================================================
  // L2 Cache typedef

  // physical address and its break-down
  typedef logic [OFFSET_WIDTH-1:0]        offset_t;
  typedef logic [BANK_ID_WIDTH-1:0]       bank_id_t;
  typedef logic [BANK_INDEX_WIDTH-1:0]    bank_index_t;
  typedef logic [TAG_WIDTH-1:0]           tag_t;
  typedef logic [DRAM_TAG_WIDTH-1:0]      dram_tag_t;
  typedef logic [WAY_ID_WIDTH-1:0]        way_id_t;
  typedef struct packed {
    tag_t         tag;
    bank_index_t  bank_index;
    bank_id_t     bank_id;
    offset_t      offset;
  } cache_paddr_t;

  typedef struct packed {
    logic [4:0] cpu_id;
    logic       is_scalar;   // the transaction is from scalar pipeline in the vcore
    logic       is_dcache;  // the transaction is from L1I$ or L1D$
    logic [4:0] tran_id;
  } tid_t;

  typedef logic [MEM_DATA_WIDTH/8-1:0]      mem_byte_mask_t;
  typedef logic [MEM_OFFSET_WIDTH-1:0]      mem_offset_t;

  typedef logic [N_MSHR-1:0]                mshr_sel_t;
  typedef logic [$clog2(N_MSHR)-1:0]        mshr_id_t;

  typedef logic [LRU_WIDTH-1:0]             lru_t;

  typedef enum logic [1:0] {
    VLS_CFG_2WAY = 2'b01,
    VLS_CFG_4WAY = 2'b10,
    VLS_CFG_6WAY = 2'b11,
    VLS_CFG_8WAY = 2'b00
  } vls_cfg_t;

  typedef struct packed {
    vls_cfg_t cfg; // VLS config state, reset to 0 = VLS_CFG_8WAY
    logic     en; // VLS enable, reset to 1
    tag_t     pbase;
  } vls_ctrl_t;

  typedef enum logic [1:0] {
    PWR_NORMAL  = 2'b00,
    PWR_SLEEP   = 2'b01,
    PWR_DOWN    = 2'b11
  } pwr_state_t;

  typedef struct packed {
    logic en_hpmcounter;
    pwr_state_t [N_BANK-1:0] bank_pwr_state; // reset to 0 = PWR_NORMAL
    pwr_state_t [N_WAY-1:0] way_pwr_state; // reset to 0 = PWR_NORMAL
  } pwr_ctrl_t;

  typedef struct packed {
    pwr_ctrl_t  pwr;
    vls_ctrl_t  vls;
  } ctrl_reg_t;

  //------------------------------------------------------
  // VLS <-> CPU
  //typedef enum logic [1:0] {
  //  REQ_READ  = 2'b00,
  //  REQ_WRITE = 2'b01,
  //  REQ_AMO   = 2'b10,
  //  REQ_FLUSH = 2'b11
  //} req_type_t; // request type,

  typedef struct packed {
    cache_paddr_t         paddr;
    cpu_byte_mask_t       byte_mask; // for both read and write
    cpu_data_t            data;
    cpu_tid_t             tid; 		 // request transaction ID
    cpu_req_type_t        req_type;  // request type
  } cpu_req_t;

  typedef struct packed {
    cpu_tid_t               tid;
    cpu_byte_mask_t         byte_mask;  // read byte mask to disable partial registers to save energy
    cpu_data_t              data;       // read data
  } cpu_resp_t;

  //------------------------------------------------------
  // MSHR definition
  typedef enum logic [2:0] {
    MSHR_WAIT_WRITE_BACK,
    MSHR_WRITE_BACK,
    MSHR_WAIT_ALLOCATE
  } mshr_state_t;

  typedef struct packed {
    logic                 valid;

    tid_t                 tid; // transaction id to the cpu side
    logic                 rw; // read or write miss
    logic                 flush;
    logic                 no_write_alloc;
    tag_t                 old_tag, // WB addr
                          new_tag; // read addr
    bank_index_t          bank_index; // bank index (index - bank_id)
    way_id_t              way_id; // way id
    cpu_data_t            data; // data to write (for write miss)
    cpu_byte_mask_t       byte_mask; // data read/write mask
  } mshr_t;

  typedef struct packed {
    // axi bus status
    logic                   waddr;
    logic                   wdata;
  } mshr_mem_state_t;

  // wdata pipeline registers
  typedef struct packed {
    bank_index_t                            waddr;
    mshr_id_t                               wid;
    //logic                                   flush;
    logic                                   wvalid;
    //logic                                   wlast;
    //logic [$clog2(N_WAY)-1:0]               way_id;
  } wdata_pipe_t;

  typedef struct packed {
    // cache data write pipeline
    wdata_pipe_t                            wdata_pipe;
    mem_offset_t                            wdata_offset;
    //mshr_mem_state_t [N_MSHR-1:0]           mem_state;
    //mem_offset_t rdata_offset;

    // data output pipeline
    cpu_resp_t  rdata_pipe;
    logic       rdata_pipe_valid;
  } mem_fsm_reg_t;

  typedef struct packed {
    mshr_id_t id;
    logic     rw;
    logic     no_write_alloc;
    logic     flush;
    logic     valid;
  } mshr_req_t; // request interface pipeline registers

  //==========================================================
  // VCORE Gen2 interface

  typedef enum logic [16:0] {
     VLD                       = 'b000_0000_000_0011111,
     VFLD                      = 'b100_0000_000_0011111,
     VFSLD                     = 'b100_0001_000_0011111,
     VST                       = 'b000_0000_000_0111111,
     VFST                      = 'b100_0000_000_0111111,
     VMUL                      = 'b000_0000_000_1011111,
     VFMUL                     = 'b100_0000_000_1011111,
     VADD                      = 'b000_0001_000_1011111,
     VADDS                     = 'b000_0001_011_1011111,
     VFADD                     = 'b100_0001_000_1011111,
     VFADDS                    = 'b100_0001_011_1011111,
     VSUB                      = 'b000_0010_000_1011111,
     VFSUB                     = 'b100_0010_000_1011111,
     VMAX                      = 'b000_0011_000_1011111,
     VFMAX                     = 'b100_0011_000_1011111,
     VMIN                      = 'b000_0100_000_1011111,
     VFMIN                     = 'b100_0100_000_1011111,
     VAVG                      = 'b000_0101_000_1011111,
     VFAVG                     = 'b100_0101_000_1011111,
     VMULS                     = 'b000_0000_011_1011111,
     VFMULS                    = 'b100_0000_011_1011111,
     VSUBS                     = 'b000_0010_011_1011111,
     VFSUBS                    = 'b100_0010_011_1011111,
     VMAXS                     = 'b000_0011_011_1011111,
     VFMAXS                    = 'b100_0011_011_1011111,
     VMINS                     = 'b000_0100_011_1011111,
     VFMINS                    = 'b100_0100_011_1011111,
     VAVGS                     = 'b000_0101_011_1011111,
     VFAVGS                    = 'b100_0101_011_1011111,
     VDOT                      = 'b000_0000_001_1011111, // scalar out
     VFDOT                     = 'b100_0000_001_1011111, // scalar out
     VXOR                      = 'b000_0000_010_1011111,
     VAND                      = 'b000_0001_010_1011111,
     VOR                       = 'b000_0010_010_1011111,
     VXORS                     = 'b000_0000_100_1011111,
     VANDS                     = 'b000_0001_100_1011111,
     VORS                      = 'b000_0010_100_1011111,
     VCMPS_EQ                  = 'b000_0011_100_1011111,
     VCMPS_NE                  = 'b000_0100_100_1011111,
     VCMPS_LT                  = 'b000_0101_100_1011111,
     VCMPS_GT                  = 'b000_0110_100_1011111,
     VCMPS_LE                  = 'b000_0111_100_1011111,
     VCMPS_GE                  = 'b000_1000_100_1011111,
     VXOR_H                    = 'b100_0000_010_1011111,
     VAND_H                    = 'b100_0001_010_1011111,
     VOR_H                     = 'b100_0010_010_1011111,
     VXORS_H                   = 'b100_0000_100_1011111,
     VANDS_H                   = 'b100_0001_100_1011111,
     VORS_H                    = 'b100_0010_100_1011111,
     VFCMPS_EQ                 = 'b100_0011_100_1011111,
     VFCMPS_NE                 = 'b100_0100_100_1011111,
     VFCMPS_LT                 = 'b100_0101_100_1011111,
     VFCMPS_GT                 = 'b100_0110_100_1011111,
     VFCMPS_LE                 = 'b100_0111_100_1011111,
     VFCMPS_GE                 = 'b100_1000_100_1011111,
     VMOV                      = 'b000_0000_000_1111111,
     VFMOV                     = 'b100_0000_000_1111111,
     VRELU                     = 'b000_0001_000_1111111,
     VFRELU                    = 'b100_0001_000_1111111,
     VPRELU                    = 'b000_0010_000_1111111,
     VFPRELU                   = 'b100_0010_000_1111111,
     VCVT_FP32_FP16            = 'b100_0101_000_1111111,
     VCVT_FP16_FP32            = 'b100_0110_000_1111111,
     VMOVS                     = 'b000_0000_001_1111111,
     VFMOVS                    = 'b100_0000_001_1111111,
     VSSUM                     = 'b000_0000_010_1111111, // scalar out
     VFSSUM                    = 'b100_0000_010_1111111, // scalar out
     VSMAX                     = 'b000_0001_010_1111111, // scalar out
     VSREGINC                  = 'b000_0000_011_1111111,
     VFSMAX                    = 'b100_0001_010_1111111, // scalar out
     VFSREGINC                 = 'b100_0000_011_1111111,
     VDIV                      = 'b000_0110_000_1011111,
     VFDIV                     = 'b100_0110_000_1011111,
     VCMP                      = 'b000_1111_010_1011111,//FIXME,should be removed
     VCMP_EQ                   = 'b000_0011_010_1011111,
     VCMP_NE                   = 'b000_0100_010_1011111,
     VCMP_LT                   = 'b000_0101_010_1011111,
     VCMP_GT                   = 'b000_0110_010_1011111,
     VCMP_LE                   = 'b000_0111_010_1011111,
     VCMP_GE                   = 'b000_1000_010_1011111,
//     VFCMP                     = 'b100_1111_010_1011111,//FIXME
     VFCMP_EQ                  = 'b100_0011_010_1011111,
     VFCMP_NE                  = 'b100_0100_010_1011111,
     VFCMP_LT                  = 'b100_0101_010_1011111,
     VFCMP_GT                  = 'b100_0110_010_1011111,
     VFCMP_LE                  = 'b100_0111_010_1011111,
     VFCMP_GE                  = 'b100_1000_010_1011111,
     VNOT_H                    = 'b100_1001_010_1011111,
     VNOOP                     = 'b000_0000_000_0000000
  } vopcode_e;

  typedef struct packed {
     logic                     [2:0]                                     thread_id;
     logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]        dst_idx;
  } vcore_vload_indrt_req_info_t;

  typedef struct packed {
     logic 			           [16*VCORE_VRF_VECTOR_CNT:0]         scatter_ld_src;
     logic 														   scatter_load;
     logic                     [MEM_SPACE_BYTE_IDX_SZ-1:0]         mem_byte_idx_start;    // the byte-idx to start loading data from the memory
     logic                     [$clog2(VCORE_MAX_VLEN_8B):0]            vlen;      // how many elements of the loaded vector
     logic                     [$clog2(VCORE_MAX_VLEN_8B):0]            group_depth; // number of elements in the depth demension of a 'pixel'
     logic                     [$clog2(VCORE_DNN_MAX_LAYER_DEPTH):0]     group_stride; // stride between 2 groups; normally = layer_width
     logic                     [$clog2(VCORE_MAX_VLEN_8B):0]    vlen_grpdepth_ratio;
     logic                     [4:0]                             combo_vector_cnt;   // how many vectors for combo load/store
  } vcore_vls_ctrl_info_t;

  typedef struct packed {
     logic                     [2:0]                                     thread_id;
     logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
     logic                     elmnt_prcsn;   // element precision, 0: 8-bit; 1: 16-bit
     vcore_vls_ctrl_info_t     vls_ctrl_info;
  } vcore_vload_drt_req_info_t;

  typedef struct packed {
     vopcode_e opcode;
     logic                     [2:0] vsew;
     logic                     [4:0] opA_addr; //
     logic                     [4:0] opB_addr; //
     logic                     [4:0] opR_addr; //

     logic                     [4:0] opADOT_addr; //
     logic                     [4:0] opBDOT_addr; //
     logic                     [4:0] opRDOT_addr; // it is a register scalar for opDOTout

     logic                     [2:0] rounding;
     logic                     [VLEN-1:0] opScalar;

     // VLOAD
     vcore_vload_drt_req_info_t orv_to_vload_drt_req_info;
     vcore_vload_indrt_req_info_t orv_to_vload_indrt_req_info_t;
  } orv2vc_t;

  typedef struct packed {
     logic                     [4:0]       rd_addr;
     logic                     write_en_rd;
     logic                     [VLEN-1:0]  rd_data;
  } vc2orv_t;

//==========================================================
// CPU Noc to Cache memory barrier interface
  typedef struct packed {
     logic [MEM_BARRIER_STATUS_WIDTH-1:0] status;
  } mem_barrier_sts_t;

  typedef struct packed {
    mem_barrier_sts_t status;
  } mem_barrier_sts_banks_t;

endpackage


