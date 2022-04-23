
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
* Author(s):
* Luis Vitorio Cargnini <lvcargnini@{rivai-ic.com.cn,ours-tech.com}> lvcargnini
***************************************************************************************************/

package vcore_pkg;
   import pygmy_cfg::*;
   import pygmy_typedef::*;
   import vcore_cfg::*;
  //===================================================================
  //old version typedef
  //===================================================================
  //{{{
   typedef logic [POWERLINE_CTRL_WIDTH-1:0] powerline_ctrl_t;
   typedef logic [POWERVBANK_CTRL_WIDTH-1:0] powervbank_ctrl_t;
   typedef enum logic [2:0] { IDLE='h0,
                              SEND_REQUEST,
                              WAIT_ACK,
                              SEND_STEPS_PING_ACK_ORV,
                              SEND_STEPS_PONG_ACK_ORV,
                              SEND_FINAL_ACK_ORV
    } vload_fsm_e;
   typedef vopcode_e vcore_vfunc_enum_t;
   //------- predicate setup from scalar proc
   typedef struct packed {
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]            vpredreg_vlen;      // how many elements of the loaded vector
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]            vpredreg_vls_grpdepth; // number of elements in the depth demension of a 'pixel'
      logic                     [$clog2(VCORE_DNN_MAX_LAYER_DEPTH):0]     vpredreg_vls_grpstride; // stride between 2 groups; normally = layer_width
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                vpredreg_vls_vlen_grpdepth_ratio;

      logic                     [16-1:0]          dnn_kernel_bias; // for vdotai


      union                     packed {
         logic                     [MEM_SPACE_BYTE_IDX_SZ-1:0]      scalar_val;
         logic                     [MEM_SPACE_BYTE_IDX_SZ-1:0]      mem_byte_idx_start;
      } scalar_reg;
   } vcore_s2v_setup_info_t;

   //------- instruction decode
   typedef struct packed {
      logic                     [2:0]                 thread_id;
      logic                     [31:0]                instr;
   } vcore_instr_info_t;

   typedef struct packed {
      vcore_instr_info_t        instr_info;
      vcore_s2v_setup_info_t    s2v_setup_info;
   } vcore_vpredecode_info_t;



   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     is_fp;   // 0: integer; 1: float-point
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;

      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]            vlen;      // how many elements of the loaded vector
      //     logic [VCORE_MAX_VLEN_8B-1:0]                  vmask;   // which elements in the entry is enabled. For 16-bit element; enabled mask bit = 11

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               src0_idx;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               src1_idx;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]                   dst_idx;    // need this for write-back

      union                     packed {
         logic                     [16-1:0]       src_scalar; // for VMULS, VADDS, etc
         logic                     [16-1:0]       dnn_kernel_bias; // for vdotai
      } src_scalar_or_bias;

      vcore_vls_ctrl_info_t               vls_ctrl_info;
   } vcore_vdecode_to_vrf_info_t;

  typedef enum logic [CPUNOC_TID_SRCID_SIZE-1:0] {
    VP_VLOAD_SRC_ID  = CPUNOC_TID_SRCID_SIZE'(4'b1000),
    VP_VSTORE_SRC_ID = CPUNOC_TID_SRCID_SIZE'(4'b1001)
  } vp_src_id_t;

   //------- memory load request
   typedef struct packed {
      //     vcore_load_dstreg_info_t                                      rf_thread_info;

      logic                     is_scalar;  // 0: this transaction is for vector; 1: is for scalar

      logic                     [VCORE_LOAD_RSP_WAIT_BUF_ADDR_SZ-1:0]        reqid;
   } vcore_load_req_tran_id_t;


   typedef struct packed {
      //     vcore_load_dstreg_info_t                                  rf_thread_info;
      logic                     [2:0]                                     thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
      logic                     [$clog2(VCORE_MAX_VLEN_8B)-1:0]                    dst_byte_start_posn;  // for writing to VRF

      logic                     [MEM_TRANS_DATA_IDX_SZ-1:0]                      tran_addr;
      logic                     [L2_PORT_BYTE_CNT-1:0]                           tran_byte_bmp;
      //     logic                                                   is_last_tran;   // the last mem transaction req of current vector
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                load_byte_cnt;  // = vlen_8b
   } vcore_load_req_tran_info_t;

   typedef struct packed {
      logic                     [2:0]                                                 thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]                   dst_idx;
      logic                     [$clog2(VCORE_MAX_VLEN_8B)-1:0]                    dst_byte_start_posn;  // for writing to VRF

      logic                     [L2_PORT_BYTE_CNT-1:0]                               tran_byte_bmp;
      //     logic                                                       is_last_tran;   // the last mem transaction req of current vector
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                load_byte_cnt;  // = vlen_8b

   } vcore_load_req_tran_info_no_addr_t;

   typedef struct packed {
      vcore_load_req_tran_id_t  tran_id;    // transaction request id

      logic                     [MEM_TRANS_DATA_IDX_SZ-1:0]                  tran_addr;   // memory data index, each read data width = L2 port width
      logic                     [L2_PORT_BYTE_CNT-1:0]                       tran_byte_bmp;
   } vcore_load_mem_req_info_t;

   typedef struct packed {
      vcore_load_req_tran_id_t                  tran_id;
      vcore_load_req_tran_info_no_addr_t        load_req_tran_info_no_addr;
   } vcore_load_wait_buf_info_t;


   //------- memory load response
   typedef struct packed {
      vcore_load_req_tran_id_t  tran_id;
      logic                     [L2_PORT_WIDTH-1:0]                  tran_mem_data;       // memory data index, each read data width = L2 port width
   } vcore_load_mem_rsp_info_t;

   typedef struct packed {
      vcore_load_req_tran_info_no_addr_t load_req_tran_info_no_addr;
      logic                     [L2_PORT_WIDTH-1:0]                      tran_mem_data;
   } vcore_load_collected_info_t;

   //-------- Memory store request
   typedef struct packed {
      logic                     elmnt_prcsn;   // element precision, 0: 8-bit; 1: 16-bit

      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                elmnt_cnt;      // how many valid elements in this entry
      logic                     [VCORE_VRF_WIDTH-1:0]                         src_data;

      //     logic           is_last_entry;

      vcore_vls_ctrl_info_t     vls_ctrl_info;
   } vcore_vstore_drt_req_info_t;

   typedef struct packed {
      logic                     elmnt_prcsn;   // element precision, 0: 8-bit; 1: 16-bit

      logic                     [MEM_SPACE_BYTE_IDX_SZ-1:0]         mem_byte_idx_start;    // the byte-idx to start loading data from the memory
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]            vlen;      // how many elements of the loaded vector

      logic                     [VCORE_VRF_WIDTH-1:0]                         src0_data;
      logic                     [VCORE_VRF_WIDTH-1:0]                         src1_data;    // serve as byte offsets
   } vcore_vstore_indrt_req_info_t;

   typedef struct packed {
      vcore_load_req_tran_id_t  tran_id;    // transaction request id

      logic                     [MEM_TRANS_DATA_IDX_SZ-1:0]                  tran_addr;   // memory data index, each read data width = L2 port width
      logic                     [L2_PORT_WIDTH-1:0]                          tran_mem_data;
      logic                     [L2_PORT_BYTE_CNT-1:0]                       tran_byte_bmp;
   } vcore_store_mem_req_info_t;

   //-------- SRF
   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [2:0]                                     dst_idx;
      logic                     [VCORE_SRF_ENTRY_WD-1:0]                 dst_scalar_data;
      logic                     intr_en;
   } vcore_srf_wr_info_t;

   //--------- VRF
   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
      logic                     [VCORE_VRF_WIDTH-1:0]                dst_data;
      //     logic [$clog2(VCORE_MAX_VLEN_8B):0]        dst_byte_cnt;
      logic                     [VCORE_VRF_WIDTH/8-1:0]              dst_byte_mask;
      logic                     is_last_wr;
   } vcore_vrf_wr_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     is_fp;   // 0: integer; 1: float-point
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;   // element precision, 0: 8-bit; 1: 16-bit
      //     logic [VCORE_MAX_VLEN_8B:0]        elmnt_mask;   // which elements in the entry is enabled. For 16-bit element; enabled mask bit = 11

      //     logic [16-1:0]       src_scalar;
      //     logic [16-1:0]          dnn_kernel_bias; // for vdotai
      logic                     [16-1:0]  src_scalar_or_bias;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               dst_idx;    // need this for write-back
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    dst_byte_cnt;



      vcore_vls_ctrl_info_t     vls_ctrl_info;
   } vcore_vrf_rd_passthru_info_t;


   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     is_fp;   // 0: integer; 1: float-point
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;
      //     logic [VCORE_MAX_VLEN_8B-1:0]          elmnt_mask;   // which elements in the entry is enabled. For 16-bit element; enabled mask bit = 11

      logic                     src0_en;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               src0_idx;
      logic                     src1_en;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               src1_idx;

      //     logic [16-1:0]                  src_scalar;
      //     logic [16-1:0]          dnn_kernel_bias; // for vdotai
      logic                     [16-1:0]  src_scalar_or_bias;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]                   dst_idx;    // need this for write-back
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;

      vcore_vls_ctrl_info_t     vls_ctrl_info;
   } vcore_vrf_rd_in_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     is_fp;   // 0: integer; 1: float-point
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;
      //     logic [VCORE_MAX_VLEN_8B-1:0]              elmnt_mask;   // which elements in the entry is enabled. For 16-bit element; enabled mask bit = 11

      logic                     [VCORE_VRF_WIDTH-1:0]            src0_data;
      logic                     [VCORE_VRF_WIDTH-1:0]            src1_data;

      //     logic [16-1:0]                  src_scalar;
      //     logic [16-1:0]          dnn_kernel_bias; // for vdotai
      logic                     [16-1:0]  src_scalar_or_bias;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]                   dst_idx;    // need this for write-back
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;

      vcore_vls_ctrl_info_t     vls_ctrl_info;
   } vcore_vrf_rd_out_info_t;

   //--------- VEXE_Int ALU
   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     is_fp;   // 0: integer; 1: float-point
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;    // element precision, 0: 8-bit; 1: 16-bit
      logic                     [VCORE_VRF_WIDTH-1:0]            src0_data;
      logic                     [VCORE_VRF_WIDTH-1:0]            src1_data;
      logic                     [16-1:0]  src_scalar_or_bias;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]                   dst_idx;    // need this for write-back
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;


   } vcore_vexe_in_info_t;

   typedef vcore_vexe_in_info_t    vcore_vexe_int_in_info_t;
   typedef vcore_vexe_in_info_t    vcore_vexe_fp_in_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;    // element precision, 0: 8-bit; 1: 16-bit
      logic                     [16-1:0]  src_scalar_or_bias;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]                   dst_idx;    // need this for write-back
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;

      logic                     [4:0]  valid_lane_cnt;    // for vector_concat later
   } vcore_vexe_lane_dist_passthru_info_t;

   typedef vcore_vexe_lane_dist_passthru_info_t    vcore_vexe_int_lane_dist_passthru_info_t;
   typedef vcore_vexe_lane_dist_passthru_info_t    vcore_vexe_fp_lane_dist_passthru_info_t;

   typedef struct packed {
      logic                     [2:0]                                             thread_id;

      vcore_vfunc_enum_t        vfunc;

      logic                     [8-1:0]  src_scalar_or_bias;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               dst_idx;
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;

      logic                     elmnt_prcsn;

      logic                     is_last_lane_group;

      logic                     [VCORE_VEXE_INT_LANE_CNT-1:0] [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE-1:0]       lane_elmnt_vld_bmp;

      logic                     [4:0]  valid_lane_cnt;    // for vector_concat later
   } vcore_vexe_int_lane_complex_in_ctrl_t;

   typedef struct packed {
      logic                     [VCORE_VEXE_INT_LANE_CNT-1:0] [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE*8-1:0]     src0_elmnt_array;
      logic                     [VCORE_VEXE_INT_LANE_CNT-1:0] [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE*8-1:0]     src1_elmnt_array;
   } vcore_vexe_int_lane_complex_in_info_t;

   typedef struct packed {
      vcore_vfunc_enum_t        vfunc;
      logic                     elmnt_prcsn;

      logic                     [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE*8-1:0]     src0_lane_elmnt_array;
      logic                     [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE*8-1:0]     src1_lane_elmnt_array;

      logic                     [8-1:0]       src_scalar;
   } vcore_vexe_int_lane_in_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;

      logic                     elmnt_prcsn;    // element precision, 0: 8-bit; 1: 16-bit

      logic                     is_last_lane_group;

      logic                     [4:0]  valid_lane_cnt;
   } vcore_vexe_int_lane_complex_out_to_vector_concat_ctrl_t;

   typedef struct packed {
      logic                     [VCORE_VEXE_INT_LANE_CNT-1:0] [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE*8-1:0]     rslt_elmnt_array; // support only 8-bit Int for now
   } vcore_vexe_int_lane_complex_out_to_vector_concat_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
      vopcode_e                 comp_op;
      logic                     elmnt_prcsn;    // element precision, 0: 8-bit; 1: 16-bit

      logic                     is_last_lane_group;
      logic                     [VCORE_VEXE_INT_LANE_CNT-1:0] [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE-1:0]  lane_elmnt_vld_bmp;

      logic                     [8-1:0]          dnn_kernel_bias; // for vdotai
   } vcore_vexe_int_lane_complex_out_to_scalar_comp_ctrl_t;

   typedef struct packed {
      logic                     [VCORE_VEXE_INT_LANE_CNT-1:0] [VCORE_VEXE_INT_ELEMENT_8b_CNT_PER_LANE*16-1:0]    rslt_elmnt_array;   // support the rslt of 8-bit Int elements for now
   } vcore_vexe_int_lane_complex_out_to_scalar_comp_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [2:0]                                     dst_idx;

      vopcode_e                 comp_op;

      logic                     [8-1:0]          dnn_kernel_bias; // for vdotai
   } vcore_vexe_int_scalar_comp_passthru_info_t;


   //---------- VEXE_FP ALU
   typedef struct packed {
      logic                     [2:0]                                             thread_id;

      vcore_vfunc_enum_t        vfunc;

      logic                     [16-1:0]  src_scalar_or_bias;

      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]               dst_idx;
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;

      logic                     is_last_lane_group;
      logic                     [VCORE_VEXE_FP_LANE_CNT-1:0] [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE-1:0]       lane_elmnt_vld_bmp;

      logic                     [4:0]  valid_lane_cnt;   // for vector_concat later
   } vcore_vexe_fp_lane_complex_in_ctrl_t;

   typedef struct packed {
      logic                     [VCORE_VEXE_FP_LANE_CNT-1:0] [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE*16-1:0]     src0_elmnt_array;
      logic                     [VCORE_VEXE_FP_LANE_CNT-1:0] [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE*16-1:0]     src1_elmnt_array;
   } vcore_vexe_fp_lane_complex_in_info_t;

   typedef struct packed {
      vcore_vfunc_enum_t        vfunc;
      logic                     [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE*16-1:0]     src0_lane_elmnt_array;
      logic                     [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE*16-1:0]     src1_lane_elmnt_array;

      logic                     [16-1:0]     src_scalar;
   } vcore_vexe_fp_lane_in_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
      logic                     [$clog2(VCORE_MAX_VLEN_8B):0]                    byte_cnt;
      logic                     is_last_lane_group;
      logic                     [4:0]  valid_lane_cnt;
   } vcore_vexe_fp_lane_complex_out_to_vector_concat_ctrl_t;

   typedef struct packed {
      logic                     [VCORE_VEXE_FP_LANE_CNT-1:0] [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE*16-1:0]     rslt_elmnt_array;
   } vcore_vexe_fp_lane_complex_out_to_vector_concat_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [$clog2(VCORE_VRF_VECTOR_CNT)-1:0]       dst_idx;
      vopcode_e                 comp_op;

      logic                     is_last_lane_group;
      logic                     [VCORE_VEXE_FP_LANE_CNT-1:0] [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE-1:0]   lane_elmnt_vld_bmp;
      logic                     [16-1:0]          dnn_kernel_bias; // for vdotai
   } vcore_vexe_fp_lane_complex_out_to_scalar_comp_ctrl_t;

   typedef struct packed {
      logic                     [VCORE_VEXE_FP_LANE_CNT-1:0] [VCORE_VEXE_FP_ELEMENT_16b_CNT_PER_LANE*16-1:0]     rslt_elmnt_array;
   } vcore_vexe_fp_lane_complex_out_to_scalar_comp_info_t;

   typedef struct packed {
      logic                     [2:0]                                     thread_id;
      logic                     [2:0]                                     dst_idx;

      //vcore_vexe_scalar_comp_op_enum_t
      vopcode_e                 comp_op;

      logic                     [16-1:0]          dnn_kernel_bias; // for vdotai
   } vcore_vexe_fp_scalar_comp_passthru_info_t;
//}}}

    //====================================
    //added by cuiluping
    //====================================
//{{{
    //----------------------------
    //vcore top level interface
    //----------------------------
    typedef struct packed{
        logic   vcore_icg_disable;
        logic   vfdot_icg_disable;
        logic   vfssum_icg_disable;
        logic   vfsmax_icg_disable;
        logic   vfdiv_icg_disable;
        logic   vfadd_icg_disable;
        logic   vfmul_icg_disable;
        logic   vfcmp_icg_disable;
        logic   vlogic_icg_disable;
        logic   vcvt_icg_disable;
        logic   vload_icg_disable;
        logic   vstore_icg_disable;
        logic   vrf_icg_disable;
        logic   pmu_icg_disable;

    }orv_vcore_icg_disable_t;
    typedef struct packed{
		logic											scatter_load;
        logic   [MEM_SPACE_BYTE_IDX_SZ-1:0]             mem_byte_idx_start;//vload/vstore base address, granule is byte.
        logic   [$clog2(VCORE_MAX_VLEN_8B):0]           group_depth;//how many continuous element boundle into a group
        logic   [$clog2(VCORE_DNN_MAX_LAYER_DEPTH):0]   group_stride;//stride between adjacent 2 groups;
        logic   [$clog2(VCORE_MAX_VLEN_8B):0]           vlen_grp_depth_ratio;// = (vlen/group_depth) pre calculated by user
        logic   [4:0]                                   combo_vector_cnt;//FIXME,no used by now
    }vcore_vls_comm_ctrl_info_t;
    
    typedef struct packed {
        vopcode_e                       opcode;
        logic   [VCORE_CSR_VLEN_W-1:0]  vlen;
        logic   [2:0]                   rounding;//rounding mode??
        logic   [VCORE_VELE_W-1:0]      scalar_data;
        logic   [VCORE_VRF_ID_W-1:0]    vsrc0_id;
        logic   [VCORE_VRF_ID_W-1:0]    vsrc1_id;
        logic   [4:0]                   vdst_addr;//for vfdot/vfssum/vfmax/vfcmp is scalar destination id
    
        //vload/vstore
        vcore_vls_comm_ctrl_info_t      vls_comm_ctrl_info;
    } orv_vcore_t;

    typedef struct packed {
        logic   [4:0]                   sc_dst_id;
        logic   [VCORE_VELE_W-1:0]      sc_rslt;
    }vcore_orv_t;
    typedef struct packed {
        logic[VCORE_PMU_EVT_W-1:17]     rsvd_fld;
        logic                           hzd_stall_counter;           
        logic                           vstore_req_num_counter;
        logic                           vload_req_num_counter;
        logic                           vstore_busy_counter;
        logic                           vload_busy_counter;
        logic                           vlogic_instr_num_counter;
        logic                           vfssum_instr_num_counter;
        logic                           vfsmax_instr_num_counter;
        logic                           vfmul_instr_num_counter;
        logic                           vfdot_instr_num_counter;
        logic                           vfdiv_instr_num_counter;
        logic                           vfcmp_instr_num_counter;
        logic                           vfadd_instr_num_counter;
        logic                           vcvt_instr_num_counter;
        logic                           vstore_instr_num_counter;
        logic                           vload_instr_num_counter;
        logic                           busy_counter;
    }vcore_pmu_evt_mask_t;
    //---------------------------------
    //vcore internal interface struct
    //---------------------------------
    
    typedef struct packed {
        vopcode_e                                   opcode;
        logic   [VCORE_CSR_VLEN_W-1:0]              vlen;
        logic   [2:0]                               rounding;
        logic   [VCORE_VELE_W-1:0]                  scalar_data;
        logic   [VCORE_VRF_ID_W-1:0]                vsrc0_id;
        logic   [VCORE_VRF_ID_W-1:0]                vsrc1_id;
        logic   [4:0]                               vdst0_addr;
        logic   [VCORE_VRF_ID_W-1:0]                vdst1_id;
    
        vcore_vls_comm_ctrl_info_t                  vls_comm_ctrl_info;
    
        logic                                       vsrc0_vld;
        logic                                       vsrc1_vld;
        logic                                       vdst0_vld;
        logic                                       vdst1_vld;//for vcvt f16_f32
    
        //by now , scalar source data will always be source 1,not source 0
        logic                                       src0_scalar_vld;//not used by now
        logic                                       src1_scalar_vld;
        
    } vcore_dec_disp_t;
    
    typedef struct packed {
        vopcode_e                               opcode;
        logic   [2:0]                           rounding;
        logic   [VCORE_CSR_VLEN_W-1:0]          vlen;
        logic   [4:0]                           vdst0_addr;//vector/scalar shared dst_id
        logic   [VCORE_VRF_ID_W-1:0]            vdst1_id;
        logic   [VCORE_VDP_W-1:0]               vsrc0_data;
        logic   [VCORE_VDP_W-1:0]               vsrc1_data;
    } vcore_disp_exe_t;
    typedef struct packed {
        vopcode_e                               opcode;
        logic   [VCORE_CSR_VLEN_W-1:0]          vlen;
        logic   [VCORE_VRF_ID_W-1:0]            vdst1_id;
        logic   [4:0]                           vdst0_addr;//vector/scalar shared dst_id
    } vcore_func_unit_launch_id_t;
    
    typedef struct packed {
        logic                                   scatter_ld;
        logic   [VCORE_CSR_VLEN_W-1:0]          vlen;
        logic   [VCORE_VRF_ID_W-1:0]            vdst_id;
        logic   [VCORE_VDP_W-1:0]               vsrc_data;
        vcore_vls_comm_ctrl_info_t              vls_comm_ctrl_info;
    
    } vcore_disp_vload_t;
    
    typedef struct packed {
        logic   [VCORE_CSR_VLEN_W-1:0]          vlen;
        logic   [VCORE_VDP_W-1:0]               vsrc_data;
        vcore_vls_comm_ctrl_info_t              vls_comm_ctrl_info;
    } vcore_disp_vstore_t;
    
    typedef struct packed {
        logic                                   vdst0_rslt_vld;
        logic   [VCORE_VRF_ID_W-1:0]            vdst0_id;
        logic                                   vdst1_rslt_vld;
        logic   [VCORE_VRF_ID_W-1:0]            vdst1_id;
    } vcore_varb_disp_t;
    
    //i2_i3 register data structure
    typedef struct packed {
        vopcode_e                               opcode;
        logic   [VCORE_CSR_VLEN_W-1:0]          vlen;
        logic   [2:0]                           rounding;
        logic   [4:0]                           vdst0_addr;//vector/scalar shared dst_id
        logic   [VCORE_VRF_ID_W-1:0]            vdst1_id;
        logic                                   vsrc0_vld;
        logic                                   vsrc1_vld;
        logic   [VCORE_VDP_W-1:0]               vsrc0_data;
        logic   [VCORE_VDP_W-1:0]               vsrc1_data;
        vcore_vls_comm_ctrl_info_t              vls_comm_ctrl_info;
    } vcore_i2_i3_ppln_t;
    //to indicate the funciton unit type
    //multiple instructions can share the same functional unit
    typedef struct packed {
        logic                       vfcmp_type; //1) vfcmp
                                                //2) vfcmps
                                                //3) vfmax
                                                //4) vfmin
                                                //5) vfmaxs
                                                //6) vfmins
        logic                       vfadd_type; //1) vfadd
                                                //2) vfadds
                                                //3) vfsub
                                                //4) vfsubs
        logic                       vfmul_type; //1) vfmul
                                                //2) vfmuls
        logic                       vfdiv_type; //1) vfdiv
        logic                       vfdot_type; //1) vfdot
        logic                       vfsmax_type;//1) vfsmax
        logic                       vfssum_type;//1) vfssum
        logic                       vload_type; //1)vfld
        logic                       vstore_type;//1)vfst
    
        logic                       vlogic_type;//1) VAND
                                                //2) VOR
                                                //3) VXOR
                                                //4) VNOT
                                                //5) VANDS
                                                //6) VORS
                                                //7) VXORS
        logic                       vcvt_type;  //1) VCVT_FP32_FP16
                                                //2) VCVT_FP16_FP32
    } vcore_func_unit_type_t;
//}}}
endpackage
