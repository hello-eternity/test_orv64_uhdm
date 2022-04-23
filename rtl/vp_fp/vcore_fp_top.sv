module vcore_fp_top
   import pygmy_cfg::*;
   import pygmy_typedef::*;
   import orv64_typedef_pkg::*;
   import pygmy_intf_typedef::*;
   import vcore_cfg::*;
   import vcore_pkg::*;
   #(
      parameter                 num_stages      = vcore_cfg::num_stages,
      parameter                 stall_mode      = vcore_cfg::stall_mode,
      parameter                 rst_mode        = vcore_cfg::rst_mode,
      parameter                 op_iso_mode     = vcore_cfg::op_iso_mode,
      //General Paramerters
      parameter                 XLEN            = vcore_cfg::XLEN, //TODO: create RV64 and RV32 in a package
      parameter                 USEDW           = vcore_cfg::USEDW, //uses Synopsys DesignWare library
      // ISA Mandatory Fixed Parameters
      parameter                 VLEN            = pygmy_cfg::VLEN, //! Vector Element Size
      parameter                 ELEN            = vcore_cfg::ELEN, //! Scalar ELEN, minimum size of an element inside VLEN == VLEN/ELEN
      parameter                 FELEN           = vcore_cfg::FELEN, //! Floating point ELEN
      parameter                 SLEN            = vcore_cfg::SLEN, //!Stripped

      // END ISA
      parameter                 id_width        = vcore_cfg::id_width,
      parameter                 in_reg          = vcore_cfg::in_reg, //Oh Boy
      parameter                 out_reg         = vcore_cfg::out_reg, // Oh Boy ... again Someone is going to be Bananas
      //parameter                 rst_mode        = vcore_cfg::rst_mode,
      parameter                 no_pm           = vcore_cfg::no_pm,
      parameter                 stages          = vcore_cfg::stages,


      parameter                 VLMAX           = vcore_cfg::VLMAX, //! Nmber of Vector Elements of VLEN size in each bank
      parameter                 VECBANKS        = vcore_cfg::VECBANKS, //! Number of Vectorial Banks
      parameter                 sig_width      = vcore_cfg::sig_width, //IEEE Format
      parameter                 exp_width       = vcore_cfg::exp_width, // IEEE FORMAT
      parameter                 ieee_compliance = vcore_cfg::ieee_compliance,
      parameter                 ISFP            = 1 //1-> IFP,
   )
   (
      input [7:0]				core_id,
      input                     external_int,
      input                     software_int,
      input                     timer_int,
      input                     s2b_ext_event,

      output logic              cache_req_if_req_valid,
      output cpu_cache_if_req_t cache_req_if_req,
      input logic               cache_req_if_req_ready,
      input logic               cache_resp_if_resp_valid,
      input cpu_cache_if_resp_t cache_resp_if_resp,
      output logic              cache_resp_if_resp_ready,

      input                     logic       s2b_cfg_pwr_on,
      input                     logic       s2b_cfg_sleep,
      input                     logic [5:0] s2b_cfg_lfsr_seed,
      input                     logic       s2b_cfg_bypass_ic,
      input                     logic       s2b_cfg_bypass_tlb,
      input                     orv64_vaddr_t     s2b_cfg_rst_pc,

      input                     logic     s2b_cfg_en_hpmcounter,


      input                     logic   s2b_debug_stall,
      input                     logic   s2b_debug_resume,
      output                    logic   b2s_debug_stall_out,

      input   orv64_vaddr_t             s2b_bp_if_pc_0,
      input   orv64_vaddr_t             s2b_bp_if_pc_1,
      input   orv64_vaddr_t             s2b_bp_if_pc_2,
      input   orv64_vaddr_t             s2b_bp_if_pc_3,
      input   logic                     s2b_en_bp_if_pc_0,
      input   logic                     s2b_en_bp_if_pc_1,
      input   logic                     s2b_en_bp_if_pc_2,
      input   logic                     s2b_en_bp_if_pc_3,
      input   orv64_vaddr_t             s2b_bp_wb_pc_0,
      input   orv64_vaddr_t             s2b_bp_wb_pc_1,
      input   orv64_vaddr_t             s2b_bp_wb_pc_2,
      input   orv64_vaddr_t             s2b_bp_wb_pc_3,
      input   logic                     s2b_en_bp_wb_pc_0,
      input   logic                     s2b_en_bp_wb_pc_1,
      input   logic                     s2b_en_bp_wb_pc_2,
      input   logic                     s2b_en_bp_wb_pc_3,
      input   orv64_data_t              s2b_bp_instret,
      input   logic                     s2b_en_bp_instret,

      input   orv64_itb_sel_t     s2b_cfg_itb_sel,
      input   logic               s2b_cfg_itb_en,
      input   logic               s2b_cfg_itb_wrap_around,
      output  orv64_itb_addr_t    b2s_itb_last_ptr,

      output                      sysbus_req_if_awvalid,
      output                      sysbus_req_if_wvalid,
      output                      sysbus_req_if_arvalid,
      output oursring_req_if_ar_t sysbus_req_if_ar,
      output oursring_req_if_aw_t sysbus_req_if_aw,
      output oursring_req_if_w_t  sysbus_req_if_w,
      input                       sysbus_req_if_arready,
      input                       sysbus_req_if_wready,
      input                       sysbus_req_if_awready,
      input oursring_resp_if_b_t  sysbus_resp_if_b,
      input oursring_resp_if_r_t  sysbus_resp_if_r,
      input                       sysbus_resp_if_rvalid,
      output                      sysbus_resp_if_rready,
      input                       sysbus_resp_if_bvalid,
      output                      sysbus_resp_if_bready,

      input logic                 ring_req_if_awvalid,
      input logic                 ring_req_if_wvalid,
      input logic                 ring_req_if_arvalid,
      input oursring_req_if_ar_t  ring_req_if_ar,
      input oursring_req_if_aw_t  ring_req_if_aw,
      input oursring_req_if_w_t   ring_req_if_w,
      output                      ring_req_if_arready,
      output                      ring_req_if_wready,
      output                      ring_req_if_awready,
      output oursring_resp_if_b_t ring_resp_if_b,
      output oursring_resp_if_r_t ring_resp_if_r,
      output                      ring_resp_if_rvalid,
      input                       ring_resp_if_rready,
      output                      ring_resp_if_bvalid,
      input                       ring_resp_if_bready,

      output  logic               wfi_stall,
      output  logic               wfe_stall,

      input                     s2b_vcore_en,
      input                     powerline_ctrl_t          s2b_powerline_ctrl,
      input                     powervbank_ctrl_t         s2b_powervbank_ctrl, //supports Standard Limit of 32 Banks Maximum

      output logic b2s_vload_drt_req_vlen_illegal,
      output logic load_vtlb_excp,

      // atomic
      output logic                cpu_amo_store_req_valid,
      output cpu_cache_if_req_t   cpu_amo_store_req,
      input logic                 cpu_amo_store_req_ready,

      // clock gating; pmu enable
      input orv_vcore_icg_disable_t    s2b_vcore_icg_disable,
      input                            s2b_vcore_pmu_en,
      input vcore_pmu_evt_mask_t       s2b_vcore_pmu_evt_mask,

      // Std
      input                     s2b_early_rstn, // early_rstn
      input                     s2b_rstn,
      input                     clk

   );


    assign b2s_vload_drt_req_vlen_illegal = '0;

  orv64
  #(
  ) _uP_core (
    .clk(clk),
    .core_id(core_id),
    .s2b_early_rst(~s2b_early_rstn),
    .s2b_rst(~s2b_rstn),
    .s2b_debug_stall(s2b_debug_stall),
    .s2b_debug_resume(s2b_debug_resume),
    .ext_int(external_int),
    .sw_int(software_int),
    .timer_int(timer_int),
    .s2b_ext_event(s2b_ext_event),
    .s2b_cfg_rst_pc(s2b_cfg_rst_pc),
    .s2b_cfg_pwr_on(s2b_cfg_pwr_on),
    .s2b_cfg_sleep,
    .s2b_cfg_lfsr_seed,
    .s2b_cfg_bypass_ic,
    .s2b_cfg_bypass_tlb,
    .b2s_if_pc(),
    .l2_req(cache_req_if_req),
    .l2_req_valid(cache_req_if_req_valid),
    .l2_req_ready(cache_req_if_req_ready),
    .cpu_amo_store_req_valid,
    .cpu_amo_store_req_ready,
    .cpu_amo_store_req,
    .l2_resp(cache_resp_if_resp),
    .l2_resp_valid(cache_resp_if_resp_valid),
    .l2_resp_ready(cache_resp_if_resp_ready),
    .sysbus_req_if_awvalid,
    .sysbus_req_if_wvalid,
    .sysbus_req_if_arvalid,
    .sysbus_req_if_ar,
    .sysbus_req_if_aw,
    .sysbus_req_if_w,
    .sysbus_req_if_arready,
    .sysbus_req_if_wready,
    .sysbus_req_if_awready,
    .sysbus_resp_if_b,
    .sysbus_resp_if_r,
    .sysbus_resp_if_rvalid,
    .sysbus_resp_if_rready,
    .sysbus_resp_if_bvalid,
    .sysbus_resp_if_bready,
    .ring_req_if_awvalid,
    .ring_req_if_wvalid,
    .ring_req_if_arvalid,
    .ring_req_if_ar,
    .ring_req_if_aw,
    .ring_req_if_w,
    .ring_req_if_arready,
    .ring_req_if_wready,
    .ring_req_if_awready,
    .ring_resp_if_b,
    .ring_resp_if_r,
    .ring_resp_if_rvalid,
    .ring_resp_if_rready,
    .ring_resp_if_bvalid,
    .ring_resp_if_bready,
    .s2b_bp_if_pc_0,
    .s2b_bp_if_pc_1,
    .s2b_bp_if_pc_2,
    .s2b_bp_if_pc_3,
    .s2b_en_bp_if_pc_0,
    .s2b_en_bp_if_pc_1,
    .s2b_en_bp_if_pc_2,
    .s2b_en_bp_if_pc_3,
    .s2b_bp_wb_pc_0,
    .s2b_bp_wb_pc_1,
    .s2b_bp_wb_pc_2,
    .s2b_bp_wb_pc_3,
    .s2b_en_bp_wb_pc_0,
    .s2b_en_bp_wb_pc_1,
    .s2b_en_bp_wb_pc_2,
    .s2b_en_bp_wb_pc_3,
    .s2b_bp_instret,
    .s2b_en_bp_instret,
    .s2b_cfg_itb_sel,
    .s2b_cfg_itb_en,
    .s2b_cfg_itb_wrap_around,
    .b2s_itb_last_ptr,
    .*
  );



endmodule
