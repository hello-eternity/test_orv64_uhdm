#include <stdio.h>
#include <stdlib.h>
#include <vector>
#include <string>
#include <string.h>
#include <iostream>
#include <unistd.h>

#include "socket_client.h"
#include "common.h"
#include "common-socket.h"
#include "pygmy_es1y_addr_translater.h"

static void process_reset(struct sockaddr_in *serverAddr, int *clientSock)
{
      do_write(serverAddr, clientSock, 0x7ffff000, 0); // set reset
      printf("Set RESET\n");
      do_write(serverAddr, clientSock, 0x7ffff000, 1); // release reset
      printf("Release RESET\n");
}

int main (int argc, char const *argv[])
{
  std::map<std::string, uint64_t> debug_map;

  debug_map.insert(std::pair<std::string, uint64_t>("ic_data_way_0", STATION_VP_IC_DATA_WAY_0_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic_data_way_1", STATION_VP_IC_DATA_WAY_1_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic_tag_way_0", STATION_VP_IC_TAG_WAY_0_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic_tag_way_1", STATION_VP_IC_TAG_WAY_1_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itb_data", STATION_VP_ITB_DATA_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_data__depth_0", STATION_VP_IBUF_LINE_DATA_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_data__depth_1", STATION_VP_IBUF_LINE_DATA_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("rst_pc", STATION_VP_S2B_CFG_RST_PC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itb_sel", STATION_VP_S2B_CFG_ITB_SEL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("b2s_itb_last_ptr", STATION_VP_B2S_ITB_LAST_PTR_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_if_pc_0", STATION_VP_S2B_BP_IF_PC_0_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_if_pc_1", STATION_VP_S2B_BP_IF_PC_1_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_if_pc_2", STATION_VP_S2B_BP_IF_PC_2_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_if_pc_3", STATION_VP_S2B_BP_IF_PC_3_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_wb_pc_0", STATION_VP_S2B_BP_WB_PC_0_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_wb_pc_1", STATION_VP_S2B_BP_WB_PC_1_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_wb_pc_2", STATION_VP_S2B_BP_WB_PC_2_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_wb_pc_3", STATION_VP_S2B_BP_WB_PC_3_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bp_instret", STATION_VP_S2B_BP_INSTRET_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_paddr__depth_0", STATION_VP_IBUF_LINE_PADDR_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_paddr__depth_1", STATION_VP_IBUF_LINE_PADDR_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_excp_cause__depth_0", STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_excp_cause__depth_1", STATION_VP_IBUF_LINE_EXCP_CAUSE_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_0", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_1", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_2", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_3", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_4", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_5", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_6", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_asid__depth_7", STATION_VP_ITLB_ASID_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_0", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_1", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_2", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_3", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_4", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_5", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_6", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_vpn__depth_7", STATION_VP_ITLB_VPN_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_0", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_1", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_2", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_3", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_4", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_5", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_6", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_pte__depth_7", STATION_VP_ITLB_PTE_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_0", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_1", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_2", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_3", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_4", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_5", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_6", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_asid__depth_7", STATION_VP_DTLB_ASID_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_0", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_1", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_2", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_3", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_4", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_5", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_6", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_vpn__depth_7", STATION_VP_DTLB_VPN_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_0", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_1", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_2", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_3", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_4", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_5", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_6", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_pte__depth_7", STATION_VP_DTLB_PTE_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_asid__depth_0", STATION_VP_VTLB_ASID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_asid__depth_1", STATION_VP_VTLB_ASID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_vpn__depth_0", STATION_VP_VTLB_VPN_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_vpn__depth_1", STATION_VP_VTLB_VPN_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_pte__depth_0", STATION_VP_VTLB_PTE_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_pte__depth_1", STATION_VP_VTLB_PTE_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("vcore_mem_exception", STATION_VP_VCORE_MEM_EXCEPTION_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if_pc", STATION_VP_IF_PC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("wb_pc", STATION_VP_WB_PC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if2ic_vpc", STATION_VP_IF2IC_VPC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic2if_inst", STATION_VP_IC2IF_INST_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic2if_excp_cause", STATION_VP_IC2IF_EXCP_CAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if2id_excp_cause", STATION_VP_IF2ID_EXCP_CAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("id2ex_excp_cause", STATION_VP_ID2EX_EXCP_CAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex2ma_excp_cause", STATION_VP_EX2MA_EXCP_CAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma2cs_excp_cause", STATION_VP_MA2CS_EXCP_CAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("cs2ma_excp", STATION_VP_CS2MA_EXCP_ADDR_0));
  //debug_map.insert(std::pair<std::string, uint64_t>("if2ic_pc", STATION_VP_IF2IC_PC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mcycle", STATION_VP_MCYCLE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("minstret", STATION_VP_MINSTRET_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mstatus", STATION_VP_MSTATUS_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mcause", STATION_VP_MCAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mepc", STATION_VP_MEPC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("misa", STATION_VP_MISA_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mip", STATION_VP_MIP_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mie", STATION_VP_MIE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("medeleg", STATION_VP_MEDELEG_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mideleg", STATION_VP_MIDELEG_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mtvec", STATION_VP_MTVEC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("mtval", STATION_VP_MTVAL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("satp", STATION_VP_SATP_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("sepc", STATION_VP_SEPC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("scause", STATION_VP_SCAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("sedeleg", STATION_VP_SEDELEG_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("sideleg", STATION_VP_SIDELEG_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("stvec", STATION_VP_STVEC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("stval", STATION_VP_STVAL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("uepc", STATION_VP_UEPC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ucause", STATION_VP_UCAUSE_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("utvec", STATION_VP_UTVEC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("utval", STATION_VP_UTVAL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_3", STATION_VP_HPMCOUNTER_3_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_4", STATION_VP_HPMCOUNTER_4_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_5", STATION_VP_HPMCOUNTER_5_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_6", STATION_VP_HPMCOUNTER_6_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_7", STATION_VP_HPMCOUNTER_7_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_8", STATION_VP_HPMCOUNTER_8_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_9", STATION_VP_HPMCOUNTER_9_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_10", STATION_VP_HPMCOUNTER_10_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_11", STATION_VP_HPMCOUNTER_11_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_12", STATION_VP_HPMCOUNTER_12_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_13", STATION_VP_HPMCOUNTER_13_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_14", STATION_VP_HPMCOUNTER_14_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_15", STATION_VP_HPMCOUNTER_15_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("hpmcounter_16", STATION_VP_HPMCOUNTER_16_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("powerline_ctrl", STATION_VP_S2B_POWERLINE_CTRL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("lfsr_seed", STATION_VP_S2B_CFG_LFSR_SEED_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("powervbank_ctrl", STATION_VP_S2B_POWERVBANK_CTRL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_cnt", STATION_VP_IBUF_CNT_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_rptr", STATION_VP_IBUF_RPTR_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("early_rstn", STATION_VP_S2B_EARLY_RSTN_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("rstn", STATION_VP_S2B_RSTN_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ext_event", STATION_VP_S2B_EXT_EVENT_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("debug_stall", STATION_VP_S2B_DEBUG_STALL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("b2s_debug_stall_out", STATION_VP_B2S_DEBUG_STALL_OUT_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("debug_resume", STATION_VP_S2B_DEBUG_RESUME_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("b2s_vload_drt_req_vlen_illegal", STATION_VP_B2S_VLOAD_DRT_REQ_VLEN_ILLEGAL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_hpmcounter", STATION_VP_S2B_CFG_EN_HPMCOUNTER_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("pwr_on", STATION_VP_S2B_CFG_PWR_ON_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("sleep", STATION_VP_S2B_CFG_SLEEP_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bypass_ic", STATION_VP_S2B_CFG_BYPASS_IC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("bypass_tlb", STATION_VP_S2B_CFG_BYPASS_TLB_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("s2icg_clk_en", STATION_VP_S2ICG_CLK_EN_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itb_en", STATION_VP_S2B_CFG_ITB_EN_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itb_wrap_around", STATION_VP_S2B_CFG_ITB_WRAP_AROUND_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_if_pc_0", STATION_VP_S2B_EN_BP_IF_PC_0_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_if_pc_1", STATION_VP_S2B_EN_BP_IF_PC_1_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_if_pc_2", STATION_VP_S2B_EN_BP_IF_PC_2_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_if_pc_3", STATION_VP_S2B_EN_BP_IF_PC_3_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_wb_pc_0", STATION_VP_S2B_EN_BP_WB_PC_0_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_wb_pc_1", STATION_VP_S2B_EN_BP_WB_PC_1_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_wb_pc_2", STATION_VP_S2B_EN_BP_WB_PC_2_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_wb_pc_3", STATION_VP_S2B_EN_BP_WB_PC_3_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("en_bp_instret", STATION_VP_S2B_EN_BP_INSTRET_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("vcore_en", STATION_VP_S2B_VCORE_EN_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_excp_valid__depth_0", STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ibuf_line_excp_valid__depth_1", STATION_VP_IBUF_LINE_EXCP_VALID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_0", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_1", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_2", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_3", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_4", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_5", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_6", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("itlb_valid__depth_7", STATION_VP_ITLB_VALID_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_0", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_1", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_2", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_2));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_3", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_3));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_4", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_4));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_5", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_5));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_6", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_6));
  debug_map.insert(std::pair<std::string, uint64_t>("dtlb_valid__depth_7", STATION_VP_DTLB_VALID_ADDR_0__DEPTH_7));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_valid__depth_0", STATION_VP_VTLB_VALID_ADDR_0__DEPTH_0));
  debug_map.insert(std::pair<std::string, uint64_t>("vtlb_valid__depth_1", STATION_VP_VTLB_VALID_ADDR_0__DEPTH_1));
  debug_map.insert(std::pair<std::string, uint64_t>("if_stall", STATION_VP_IF_STALL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if_kill", STATION_VP_IF_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if_valid", STATION_VP_IF_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if_ready", STATION_VP_IF_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("id_stall", STATION_VP_ID_STALL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("id_kill", STATION_VP_ID_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("id_valid", STATION_VP_ID_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("id_ready", STATION_VP_ID_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex_stall", STATION_VP_EX_STALL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex_kill", STATION_VP_EX_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex_valid", STATION_VP_EX_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex_ready", STATION_VP_EX_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma_stall", STATION_VP_MA_STALL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma_kill", STATION_VP_MA_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma_valid", STATION_VP_MA_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma_ready", STATION_VP_MA_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("wb_valid", STATION_VP_WB_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("wb_ready", STATION_VP_WB_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("cs2if_kill", STATION_VP_CS2IF_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("cs2id_kill", STATION_VP_CS2ID_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("cs2ex_kill", STATION_VP_CS2EX_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("cs2ma_kill", STATION_VP_CS2MA_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("l2_req_valid", STATION_VP_L2_REQ_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("l2_req_ready", STATION_VP_L2_REQ_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("l2_resp_valid", STATION_VP_L2_RESP_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("l2_resp_ready", STATION_VP_L2_RESP_READY_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("is_wfe", STATION_VP_WFE_STALL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma2if_npc_valid", STATION_VP_MA2IF_NPC_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex2if_kill", STATION_VP_EX2IF_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex2id_kill", STATION_VP_EX2ID_KILL_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("branch_solved", STATION_VP_BRANCH_SOLVED_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if2ic_en", STATION_VP_IF2IC_EN_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic2if_excp_valid", STATION_VP_IC2IF_EXCP_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic2if_is_rvc", STATION_VP_IC2IF_IS_RVC_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ic2if_valid", STATION_VP_IC2IF_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("if2id_excp_valid", STATION_VP_IF2ID_EXCP_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("id2ex_excp_valid", STATION_VP_ID2EX_EXCP_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ex2ma_excp_valid", STATION_VP_EX2MA_EXCP_VALID_ADDR_0));
  debug_map.insert(std::pair<std::string, uint64_t>("ma2cs_excp_valid", STATION_VP_MA2CS_EXCP_VALID_ADDR_0));

  unsigned short serverPort = 0;
  struct sockaddr_in serverAddr;
  int reset = 0;
  int clientSock;
  for (int i = 1; i < argc; i++) {
    if (strncmp(argv[i], "serverPort=", 11) == 0) {
      serverPort = atoi(argv[i] + 11);
    }
  }
  if (serverPort == 0) {
    serverPort = 9900; // Default
    serverPort = 8900; // Default
  }
  printf ("serverPort = %0d\n", serverPort);
  setup(serverPort, &serverAddr, &clientSock);
  if (reset) {
        process_reset(&serverAddr, &clientSock);
        return 0;
  }

  while (1) {
    std::string cmd;
    std::cout << "Please enter command: (All Data in HEX no matter 0x is added or not)\n: ";
    std::getline(std::cin, cmd);
    std::string delimiter = " ";
    size_t pos = 0;
    std::vector <std::string> tokenQ;
    int dma_cmd_vld = 0;
  
    while ((pos = cmd.find(delimiter)) != std::string::npos) {
      tokenQ.push_back(cmd.substr(0, pos));
      cmd.erase(0, pos + delimiter.length());
    }
    if (!cmd.empty())
      tokenQ.push_back(cmd);
  
    if ((tokenQ.size() == 1) && (tokenQ[0] == "status")) {
      //do_status_check(mode, ftHandle);
    } else if ((tokenQ.size() == 1) && (tokenQ[0] == "setpc")) {
      do_write(&serverAddr, &clientSock, STATION_VP_S2B_CFG_RST_PC_ADDR_0, 0x80000000);
    } else if ((tokenQ.size() == 1) && (tokenQ[0] == "list_debug")) {
      for (std::map<std::string, uint64_t>::iterator it = debug_map.begin(); it != debug_map.end(); ++it) {
        printf("\t%s\n", it->first.c_str());
      }
    } else if ((tokenQ.size() == 1) && (tokenQ[0] == "reset")) {
      process_reset(&serverAddr, &clientSock);
    } else if ((tokenQ.size() == 1) && (debug_map.count(tokenQ[0]) > 0)) {
      uint64_t addr = debug_map[tokenQ[0]];
      uint64_t data = do_read(&serverAddr, &clientSock, addr);
      printf("Do Read to Addr 0x%llx (%s), Got Data 0x%llx\n", addr, tokenQ[0].c_str(), data);
    } else if ((tokenQ.size() == 1) && (tokenQ[0] == "test_ddr")) {
    } else if ((tokenQ.size() == 1) && (tokenQ[0] == "release_vp0_reset")) {
      do_write(&serverAddr, &clientSock, STATION_VP_S2B_RSTN_ADDR_0, 1);
    } else if ((tokenQ.size() == 2) && (tokenQ[0] == "step")) {
      char * p;
      uint32_t cnt = strtoul(tokenQ[1].c_str(), & p, 10);
      uint64_t pc;
      for (int i = 0; i < cnt; i ++) {
        do_write(&serverAddr, &clientSock, STATION_VP_S2B_DEBUG_RESUME_ADDR_0, 1);
        pc = do_read(&serverAddr, &clientSock, STATION_VP_WB_PC_ADDR_0);
        fprintf(stderr, "pc = 0x%llx\n", pc);
      }
    } else if ((tokenQ.size() == 0) || (tokenQ[0] == "help") || (tokenQ[0] == "h")) {
      std::cout << "This is Help Info\n";
    } else if ((tokenQ[0] == "quit") || (tokenQ[0] == "q") || (tokenQ[0] == "exit")) {
      break;
    } else if ((tokenQ.size() == 3) && (tokenQ[0] == "read")) {
      char * p;
      uint64_t data = 0;
      uint64_t addr = strtoul(tokenQ[1].c_str(), & p, 16);
      std::string target = tokenQ[2];
      if (*p == 0) {
        if (target == "rb") {
          data = do_read(&serverAddr, &clientSock, addr);
        } else if (target == "dma") {
          do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr);
          do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 0);
          data = do_read(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_RD_DATA_ADDR);
        } else if (target == "dt") {
          do_write(&serverAddr, &clientSock, STATION_DT_DBG_ADDR_ADDR, addr);
          data = do_read(&serverAddr, &clientSock, STATION_DT_DBG_DATA_ADDR);
        } else {
          data = do_read(&serverAddr, &clientSock, addr2oraddr(target, addr));
        }
        printf("Do Read to Addr 0x%llx, Got Data 0x%llx\n", addr, data);
      }
    } else if ((tokenQ.size() == 4) && (tokenQ[0] == "write")) {
      char * p;
      uint64_t addr = strtoul(tokenQ[1].c_str(), & p, 16);
      uint64_t data = strtoul(tokenQ[2].c_str(), & p, 16);
      std::string target = tokenQ[3];
      if (*p == 0) {
        if (target == "rb") {
          do_write(&serverAddr, &clientSock, addr, data);
        } else if (target == "dma") {
          do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr);
          do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 2);
          do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_WR_DATA_ADDR, data);
        } else if (target == "dt") {
          do_write(&serverAddr, &clientSock, STATION_DT_DBG_ADDR_ADDR, addr);
          do_write(&serverAddr, &clientSock, STATION_DT_DBG_DATA_ADDR, data);
        } else {
          do_write(&serverAddr, &clientSock, addr2oraddr(target, addr), data);
        }
        printf("Do Write to Addr 0x%llx with Data 0x%llx\n", addr, data);
      }
    } else if ((tokenQ.size() == 4) && (tokenQ[0] == "dump")) {
      char * p;
      uint64_t data = 0;
      uint64_t addr_lo = strtoul(tokenQ[1].c_str(), & p, 16);
      uint64_t addr_hi = strtoul(tokenQ[2].c_str(), & p, 16);
      std::string target = tokenQ[3];
      if (*p == 0) {
        for (uint64_t addr = addr_lo; addr <= addr_hi; addr += 8) {
          if (target == "rb") {
            data = do_read(&serverAddr, &clientSock, addr);
          } else if (target == "dma") {
            do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_ADDR_ADDR, addr);
            do_write(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_REQ_TYPE_ADDR, 0);
            data = do_read(&serverAddr, &clientSock, STATION_DMA_DMA_DEBUG_RD_DATA_ADDR);
          } else if (target == "dt") {
            do_write(&serverAddr, &clientSock, STATION_DT_DBG_ADDR_ADDR, addr);
            data = do_read(&serverAddr, &clientSock, STATION_DT_DBG_DATA_ADDR);
          } else {
            data = do_read(&serverAddr, &clientSock, addr2oraddr(target, addr));
          }
          printf("0x%llx: 0x%08llx\n", addr + 0, (data >>  0) & 0xffffffff);
          printf("0x%llx: 0x%08llx\n", addr + 4, (data >> 32) & 0xffffffff);
        }
      }
    } else {
      std::cout << "Unrecognized Command; Please use help or h to see supported command list.\n";
    }
  }
  return 0;
}
