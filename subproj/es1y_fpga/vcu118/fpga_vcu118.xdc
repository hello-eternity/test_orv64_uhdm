######See Custom Constraints EoF
#set_false_path -to [get_pins [list {xilinx_ddr_u/ddr4_0_u/inst/u_ddr4_infrastructure/rst_input_async_reg[0]/D} \
          {xilinx_ddr_u/xddr_cdc_u/inst/axi_interconnect_inst/mi_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.m_axi_aresetn_resync_reg[0]/D} \
          {xilinx_ddr_u/xddr_cdc_u/inst/axi_interconnect_inst/mi_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.s_axi_aresetn_resync_reg[0]/D} \
          {xilinx_ddr_u/xddr_cdc_u/inst/axi_interconnect_inst/mi_converter_bank/gen_conv_slot[0].clock_conv_inst/interconnect_aresetn_resync_reg[0]/D} \
          {xilinx_ddr_u/xddr_cdc_u/inst/axi_interconnect_inst/si_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.m_axi_aresetn_resync_reg[0]/D} \
          {xilinx_ddr_u/xddr_cdc_u/inst/axi_interconnect_inst/si_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.s_axi_aresetn_resync_reg[0]/D} \
          {xilinx_ddr_u/xddr_cdc_u/inst/axi_interconnect_inst/si_converter_bank/gen_conv_slot[0].clock_conv_inst/interconnect_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/pcie2oursring_i/axi_u/inst/axi_interconnect_inst/mi_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.m_axi_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/pcie2oursring_i/axi_u/inst/axi_interconnect_inst/mi_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.s_axi_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/pcie2oursring_i/axi_u/inst/axi_interconnect_inst/mi_converter_bank/gen_conv_slot[0].clock_conv_inst/interconnect_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/pcie2oursring_i/axi_u/inst/axi_interconnect_inst/si_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.m_axi_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/pcie2oursring_i/axi_u/inst/axi_interconnect_inst/si_converter_bank/gen_conv_slot[0].clock_conv_inst/gen_aresetn_sync.s_axi_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/pcie2oursring_i/axi_u/inst/axi_interconnect_inst/si_converter_bank/gen_conv_slot[0].clock_conv_inst/interconnect_aresetn_resync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[0].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[10].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[11].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[12].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[13].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[14].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[15].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[1].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[2].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[3].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[4].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[5].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[6].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[7].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[8].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].cdr_ctrl_on_eidle_i/sync_gen34/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].cdr_ctrl_on_eidle_i/sync_gen34_eios_det/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].cdr_ctrl_on_eidle_i/sync_rxcdrreset_in/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].cdr_ctrl_on_eidle_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_lffs/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_lffs/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_lffs/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_lffs/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_lffs/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_lffs/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txcoeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txcoeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txcoeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txcoeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txcoeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txcoeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txpreset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txpreset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txpreset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_rxeq_i/sync_txpreset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_coeff/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_coeff/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_coeff/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_coeff/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_coeff/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_coeff/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_ctrl/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_ctrl/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_preset/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_preset/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_preset/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].phy_txeq_i/sync_preset/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].receiver_detect_termination_i/sync_mac_in_detect/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].receiver_detect_termination_i/sync_rxelecidle/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_lane[9].sync_cdrhold/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_cplllock/sync_vec[9].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_gtpowergood/sync_vec[9].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_phystatus/sync_vec[9].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll0lock/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll0lock/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll0lock/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll0lock/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll1lock/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll1lock/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll1lock/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_qpll1lock/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_rxresetdone/sync_vec[9].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txprogdivresetdone/sync_vec[9].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txresetdone/sync_vec[9].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[0].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[10].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[11].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[12].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[13].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[14].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[15].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[1].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[2].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[3].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[4].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[5].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[6].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[7].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[8].sync_cell_i/sync_reg[0]/D} \
          {xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_rst_i/sync_txsync_done/sync_vec[9].sync_cell_i/sync_reg[0]/D}]]
##-----------------------------------------------------------------------------
##
## (c) Copyright 2012-2012 Xilinx, Inc. All rights reserved.
##
## This file contains confidential and proprietary information
## of Xilinx, Inc. and is protected under U.S. and
## international copyright and other intellectual property
## laws.
##
## DISCLAIMER
## This disclaimer is not a license and does not grant any
## rights to the materials distributed herewith. Except as
## otherwise provided in a valid license issued to you by
## Xilinx, and to the maximum extent permitted by applicable
## law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
## WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
## AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
## BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
## INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
## (2) Xilinx shall not be liable (whether in contract or tort,
## including negligence, or under any other theory of
## liability) for any loss or damage of any kind or nature
## related to, arising under or in connection with these
## materials, including for any direct, or any indirect,
## special, incidental, or consequential loss or damage
## (including loss of data, profits, goodwill, or any type of
## loss or damage suffered as a result of any action brought
## by a third party) even if such damage or loss was
## reasonably foreseeable or Xilinx had been advised of the
## possibility of the same.
##
## CRITICAL APPLICATIONS
## Xilinx products are not designed or intended to be fail-
## safe, or for use in any application requiring fail-safe
## performance, such as life-support or safety devices or
## systems, Class III medical devices, nuclear facilities,
## applications related to the deployment of airbags, or any
## other applications that could lead to death, personal
## injury, or severe property or environmental damage
## (individually and collectively, "Critical
## Applications"). Customer assumes the sole risk and
## liability of any use of Xilinx products in Critical
## Applications, subject only to applicable laws and
## regulations governing limitations on product liability.
##
## THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
## PART OF THIS FILE AT ALL TIMES.
##
##-----------------------------------------------------------------------------
##
## Project    : The Xilinx PCI Express DMA
## File       : xilinx_pcie_xdma_ref_board.xdc
## Version    : 4.1
##-----------------------------------------------------------------------------
#
# User Configuration
# Link Width   - x16
# Link Speed   - Gen3
# Family       - virtexuplus
# Part         - xcvu9p
# Package      - flga2104
# Speed grade  - -2L
#
# PCIe Block INT - 8
# PCIe Block STR - X1Y2
#
# Xilinx Reference Board is VCU118
###############################################################################
# User Time Names / User Time Groups / Time Specs
###############################################################################
##
## Free Running Clock is Required for IBERT/DRP operations.
##
# Clock for the 300 MHz clock is already created in the Clock Wizard IP.
# 300 MHz clock pin constraints.
#set_property IOSTANDARD DIFF_SSTL12 [get_ports free_run_clock_p_in]
#set_property IOSTANDARD DIFF_SSTL12 [get_ports free_run_clock_n_in]
#set_property PACKAGE_PIN G31 [get_ports free_run_clock_p_in]
#set_property PACKAGE_PIN F31 [get_ports free_run_clock_n_in]
#
#############################################################################################################
#
#############################################################################################################
#
#set_property PACKAGE_PIN AM17 [get_ports sys_rst_n]
#
set_property CONFIG_VOLTAGE 1.8 [current_design]
#
#############################################################################################################
#
#set_property PACKAGE_PIN AL8 [get_ports sys_clk_n]
#set_property PACKAGE_PIN AL9 [get_ports sys_clk_p]
#
#
#############################################################################################################
# LEDs for VCU118
#set_property PACKAGE_PIN AT32 [get_ports led_0]
# user_link_up
#set_property PACKAGE_PIN AV34 [get_ports led_1]
# Clock Up/Heart Beat(HB)
#set_property PACKAGE_PIN AY30 [get_ports led_2]
# cfg_current_speed[0] => 00: Gen1; 01: Gen2; 10:Gen3; 11:Gen4
#set_property PACKAGE_PIN BB32 [get_ports led_3]
# cfg_current_speed[1]
#set_property PACKAGE_PIN BF32 [get_ports led_4]
# cfg_negotiated_width[0] => 000: x1; 001: x2; 010: x4; 011: x8; 100: x16
#set_property PACKAGE_PIN AU37 [get_ports led_5]
# cfg_negotiated_width[1]
#set_property PACKAGE_PIN AV36 [get_ports led_6]
# cfg_negotiated_width[2]
#set_property PACKAGE_PIN BA37 [get_ports led_7]

#############################################################################################################
#set_property IOSTANDARD LVCMOS12 [get_ports led_0]
#set_property IOSTANDARD LVCMOS12 [get_ports led_1]
#set_property IOSTANDARD LVCMOS12 [get_ports led_2]
#set_property IOSTANDARD LVCMOS12 [get_ports led_3]
#set_property DRIVE 8 [get_ports led_0]
#set_property DRIVE 8 [get_ports led_1]
#set_property DRIVE 8 [get_ports led_2]
#set_property DRIVE 8 [get_ports led_3]
#set_false_path -to [get_ports -filter NAME=~led_*]
#############################################################################################################
#


#
# BITFILE/BITSTREAM compress options
#
#set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-1 [current_design]
#set_property BITSTREAM.CONFIG.BPI_SYNC_MODE Type1 [current_design]
#set_property CONFIG_MODE BPI16 [current_design]
#set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
#set_property BITSTREAM.CONFIG.UNUSEDPIN Pulldown [current_design]
#
#
#


#Pin LOC constraints for the status signals init_calib_complete and data_compare_error

#LOC constraints provided if the pins are selected for status signals

#set_property PACKAGE_PIN AU29 [ get_ports "c0_data_compare_error" ]
#set_property IOSTANDARD LVCMOS12 [ get_ports "c0_data_compare_error" ]

#set_property DRIVE 8 [ get_ports "c0_data_compare_error" ]

set_property PACKAGE_PIN AV29 [get_ports c0_init_calib_complete]


#set_property PACKAGE_PIN AU34 [ get_ports "sys_rst_ddr" ]
#set_property IOSTANDARD LVCMOS12 [ get_ports "sys_rst_ddr" ]
#
#set_property PACKAGE_PIN AW31 [ get_ports "c0_sys_clk_p" ]
#set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c0_sys_clk_p" ]
#
#set_property PACKAGE_PIN AW32 [ get_ports "c0_sys_clk_n" ]
#set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c0_sys_clk_n" ]
#
#set_property PACKAGE_PIN AL27 [ get_ports "c0_ddr4_dq[38]" ]
#set_property PACKAGE_PIN AM26 [ get_ports "c0_ddr4_dq[32]" ]
#set_property PACKAGE_PIN AM27 [ get_ports "c0_ddr4_dq[39]" ]
#set_property PACKAGE_PIN AM28 [ get_ports "c0_ddr4_dqs_t[4]" ]
#set_property PACKAGE_PIN AN26 [ get_ports "c0_ddr4_dq[33]" ]
#set_property PACKAGE_PIN AN28 [ get_ports "c0_ddr4_dqs_c[4]" ]
#set_property PACKAGE_PIN AN30 [ get_ports "c0_ddr4_dq[6]" ]
#set_property PACKAGE_PIN AN31 [ get_ports "c0_ddr4_dq[7]" ]
#set_property PACKAGE_PIN AP25 [ get_ports "c0_ddr4_dq[36]" ]
#set_property PACKAGE_PIN AP26 [ get_ports "c0_ddr4_dq[37]" ]
#set_property PACKAGE_PIN AP27 [ get_ports "c0_ddr4_dq[34]" ]
#set_property PACKAGE_PIN AP28 [ get_ports "c0_ddr4_dq[35]" ]
#set_property PACKAGE_PIN AP30 [ get_ports "c0_ddr4_dq[4]" ]
#set_property PACKAGE_PIN AP31 [ get_ports "c0_ddr4_dqs_t[0]" ]
#set_property PACKAGE_PIN AP32 [ get_ports "c0_ddr4_dqs_c[0]" ]
#set_property PACKAGE_PIN AR25 [ get_ports "c0_ddr4_dq[30]" ]
#set_property PACKAGE_PIN AR27 [ get_ports "c0_ddr4_dm_dbi_n[4]" ]
#set_property PACKAGE_PIN AR30 [ get_ports "c0_ddr4_dq[5]" ]
#set_property PACKAGE_PIN AR32 [ get_ports "c0_ddr4_dm_dbi_n[0]" ]
#set_property PACKAGE_PIN AR33 [ get_ports "c0_ddr4_dq[0]" ]
#set_property PACKAGE_PIN AT25 [ get_ports "c0_ddr4_dq[31]" ]
#set_property PACKAGE_PIN AT26 [ get_ports "c0_ddr4_dqs_t[3]" ]
#set_property PACKAGE_PIN AT27 [ get_ports "c0_ddr4_dqs_c[3]" ]
#set_property PACKAGE_PIN AT29 [ get_ports "c0_ddr4_dq[2]" ]
#set_property PACKAGE_PIN AT30 [ get_ports "c0_ddr4_dq[3]" ]
#set_property PACKAGE_PIN AT34 [ get_ports "c0_ddr4_dq[1]" ]
#set_property PACKAGE_PIN AU26 [ get_ports "c0_ddr4_dq[24]" ]
#set_property PACKAGE_PIN AU27 [ get_ports "c0_ddr4_dq[28]" ]
#set_property PACKAGE_PIN AU28 [ get_ports "c0_ddr4_dq[29]" ]
#set_property PACKAGE_PIN AU33 [ get_ports "c0_ddr4_reset_n" ]
#set_property PACKAGE_PIN AV26 [ get_ports "c0_ddr4_dq[25]" ]
#set_property PACKAGE_PIN AV28 [ get_ports "c0_ddr4_dq[26]" ]
#set_property PACKAGE_PIN AV30 [ get_ports "c0_ddr4_odt" ]
#set_property PACKAGE_PIN AV33 [ get_ports "c0_ddr4_cs_n" ]
#set_property PACKAGE_PIN AW26 [ get_ports "c0_ddr4_dm_dbi_n[3]" ]
#set_property PACKAGE_PIN AW28 [ get_ports "c0_ddr4_dq[27]" ]
#set_property PACKAGE_PIN AW30 [ get_ports "c0_ddr4_act_n" ]
#set_property PACKAGE_PIN AW33 [ get_ports "c0_ddr4_cke" ]
#set_property PACKAGE_PIN AW40 [ get_ports "c0_ddr4_dq[60]" ]
#set_property PACKAGE_PIN AY27 [ get_ports "c0_ddr4_dq[20]" ]
#set_property PACKAGE_PIN AY28 [ get_ports "c0_ddr4_dq[21]" ]
#set_property PACKAGE_PIN AY30 [ get_ports "c0_ddr4_bg[1]" ]
#set_property PACKAGE_PIN AY32 [ get_ports "c0_ddr4_ba[1]" ]
#set_property PACKAGE_PIN AY33 [ get_ports "c0_ddr4_bg[0]" ]
#set_property PACKAGE_PIN AY34 [ get_ports "c0_ddr4_adr[16]" ]
#set_property PACKAGE_PIN AY37 [ get_ports "c0_ddr4_dm_dbi_n[7]" ]
#set_property PACKAGE_PIN AY38 [ get_ports "c0_ddr4_dq[62]" ]
#set_property PACKAGE_PIN AY39 [ get_ports "c0_ddr4_dq[63]" ]
#set_property PACKAGE_PIN AY40 [ get_ports "c0_ddr4_dq[61]" ]
#set_property PACKAGE_PIN BA26 [ get_ports "c0_ddr4_dqs_t[2]" ]
#set_property PACKAGE_PIN BA27 [ get_ports "c0_ddr4_dq[22]" ]
#set_property PACKAGE_PIN BA29 [ get_ports "c0_ddr4_dm_dbi_n[2]" ]
#set_property PACKAGE_PIN BA30 [ get_ports "c0_ddr4_adr[14]" ]
#set_property PACKAGE_PIN BA31 [ get_ports "c0_ddr4_adr[15]" ]
#set_property PACKAGE_PIN BA32 [ get_ports "c0_ddr4_adr[12]" ]
#set_property PACKAGE_PIN BA34 [ get_ports "c0_ddr4_ba[0]" ]
#set_property PACKAGE_PIN BA35 [ get_ports "c0_ddr4_dqs_t[7]" ]
#set_property PACKAGE_PIN BA36 [ get_ports "c0_ddr4_dqs_c[7]" ]
#set_property PACKAGE_PIN BA39 [ get_ports "c0_ddr4_dq[58]" ]
#set_property PACKAGE_PIN BA40 [ get_ports "c0_ddr4_dq[59]" ]
#set_property PACKAGE_PIN BB26 [ get_ports "c0_ddr4_dqs_c[2]" ]
#set_property PACKAGE_PIN BB27 [ get_ports "c0_ddr4_dq[23]" ]
#set_property PACKAGE_PIN BB28 [ get_ports "c0_ddr4_dq[18]" ]
#set_property PACKAGE_PIN BB31 [ get_ports "c0_ddr4_adr[10]" ]
#set_property PACKAGE_PIN BB32 [ get_ports "c0_ddr4_adr[11]" ]
#set_property PACKAGE_PIN BB33 [ get_ports "c0_ddr4_adr[13]" ]
#set_property PACKAGE_PIN BB36 [ get_ports "c0_ddr4_dq[56]" ]
#set_property PACKAGE_PIN BB37 [ get_ports "c0_ddr4_dq[57]" ]
#set_property PACKAGE_PIN BB38 [ get_ports "c0_ddr4_dq[52]" ]
#set_property PACKAGE_PIN BB39 [ get_ports "c0_ddr4_dq[53]" ]
#set_property PACKAGE_PIN BC25 [ get_ports "c0_ddr4_dq[16]" ]
#set_property PACKAGE_PIN BC26 [ get_ports "c0_ddr4_dq[17]" ]
#set_property PACKAGE_PIN BC28 [ get_ports "c0_ddr4_dq[19]" ]
#set_property PACKAGE_PIN BC31 [ get_ports "c0_ddr4_adr[8]" ]
#set_property PACKAGE_PIN BC33 [ get_ports "c0_ddr4_adr[6]" ]
#set_property PACKAGE_PIN BC34 [ get_ports "c0_ddr4_dm_dbi_n[5]" ]
#set_property PACKAGE_PIN BC35 [ get_ports "c0_ddr4_dq[42]" ]
#set_property PACKAGE_PIN BC36 [ get_ports "c0_ddr4_dq[43]" ]
#set_property PACKAGE_PIN BC38 [ get_ports "c0_ddr4_dq[54]" ]
#set_property PACKAGE_PIN BC39 [ get_ports "c0_ddr4_dq[50]" ]
#set_property PACKAGE_PIN BD25 [ get_ports "c0_ddr4_dq[14]" ]
#set_property PACKAGE_PIN BD26 [ get_ports "c0_ddr4_dq[15]" ]
#set_property PACKAGE_PIN BD27 [ get_ports "c0_ddr4_dq[12]" ]
#set_property PACKAGE_PIN BD28 [ get_ports "c0_ddr4_dq[10]" ]
#set_property PACKAGE_PIN BD30 [ get_ports "c0_ddr4_adr[2]" ]
#set_property PACKAGE_PIN BD31 [ get_ports "c0_ddr4_adr[9]" ]
#set_property PACKAGE_PIN BD32 [ get_ports "c0_ddr4_adr[4]" ]
#set_property PACKAGE_PIN BD33 [ get_ports "c0_ddr4_adr[7]" ]
#set_property PACKAGE_PIN BD36 [ get_ports "c0_ddr4_dq[44]" ]
#set_property PACKAGE_PIN BD37 [ get_ports "c0_ddr4_dq[48]" ]
#set_property PACKAGE_PIN BD38 [ get_ports "c0_ddr4_dq[55]" ]
#set_property PACKAGE_PIN BD40 [ get_ports "c0_ddr4_dq[51]" ]
#set_property PACKAGE_PIN BE25 [ get_ports "c0_ddr4_dqs_t[1]" ]
#set_property PACKAGE_PIN BE27 [ get_ports "c0_ddr4_dq[13]" ]
#set_property PACKAGE_PIN BE28 [ get_ports "c0_ddr4_dq[11]" ]
#set_property PACKAGE_PIN BE29 [ get_ports "c0_ddr4_dm_dbi_n[1]" ]
#set_property PACKAGE_PIN BE30 [ get_ports "c0_ddr4_adr[3]" ]
#set_property PACKAGE_PIN BE32 [ get_ports "c0_ddr4_adr[0]" ]
#set_property PACKAGE_PIN BE33 [ get_ports "c0_ddr4_adr[5]" ]
#set_property PACKAGE_PIN BE34 [ get_ports "c0_ddr4_dq[40]" ]
#set_property PACKAGE_PIN BE35 [ get_ports "c0_ddr4_dqs_t[5]" ]
#set_property PACKAGE_PIN BE37 [ get_ports "c0_ddr4_dq[45]" ]
#set_property PACKAGE_PIN BE38 [ get_ports "c0_ddr4_dq[49]" ]
#set_property PACKAGE_PIN BE39 [ get_ports "c0_ddr4_dqs_t[6]" ]
#set_property PACKAGE_PIN BE40 [ get_ports "c0_ddr4_dm_dbi_n[6]" ]
#set_property PACKAGE_PIN BF25 [ get_ports "c0_ddr4_dqs_c[1]" ]
#set_property PACKAGE_PIN BF26 [ get_ports "c0_ddr4_dq[8]" ]
#set_property PACKAGE_PIN BF27 [ get_ports "c0_ddr4_dq[9]" ]
#set_property PACKAGE_PIN BF30 [ get_ports "c0_ddr4_ck_t" ]
#set_property PACKAGE_PIN BF31 [ get_ports "c0_ddr4_ck_c" ]
#set_property PACKAGE_PIN BF32 [ get_ports "c0_ddr4_adr[1]" ]
#set_property PACKAGE_PIN BF34 [ get_ports "c0_ddr4_dq[41]" ]
#set_property PACKAGE_PIN BF35 [ get_ports "c0_ddr4_dqs_c[5]" ]
#set_property PACKAGE_PIN BF36 [ get_ports "c0_ddr4_dq[46]" ]
#set_property PACKAGE_PIN BF37 [ get_ports "c0_ddr4_dq[47]" ]
#set_property PACKAGE_PIN BF39 [ get_ports "c0_ddr4_dqs_c[6]" ]

# for use with flash in x8 mode, makes for faster bootup configuration
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 [current_design]
# emcclk has a max of 90MHz, spi flash has a max of 108MHz, so we don't want to divide emmcclk for fastest operation
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-1 [current_design]
# makes bitstream smaller? not sure if it's necessary
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
# also uses falling clock edge to configure from flash faster
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]


################################################################









#create_clock -period 10.000 -name sys_clk [get_ports sys_clk_p]
#set_false_path -from [get_ports sys_rst_n]
#set_property PULLUP true [get_ports sys_rst_n]
#set_property IOSTANDARD LVCMOS18 [get_ports sys_rst_n]
#set_false_path -to [get_pins -hier {*sync_reg[0]/D}]
set_property IOSTANDARD LVCMOS12 [get_ports c0_init_calib_complete]
set_property DRIVE 8 [get_ports c0_init_calib_complete]
#set_clock_groups -asynchronous -group [get_clocks -include_generated_clocks c0_sys_clk_p] -group [get_clocks -include_generated_clocks sys_clk]

####################################################################################
# Constraints from file : 'axi_cdc_pcie2oursring_impl_clocks.xdc'
####################################################################################

#set_false_path -from [get_clocks -of_objects [get_pins xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks -of_objects [get_pins xilinx_ddr_u/ddr4_0_u/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT1]]
#set_false_path -from [get_clocks -of_objects [get_pins xilinx_dma_pcie_ep_u/xdma_0_i/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]] -to [get_clocks -of_objects [get_pins xilinx_ddr_u/ddr4_0_u/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT1]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets dbg_hub_user_clk]

########Custom Constraints########
#set_clock_groups -asynchronous \
#  -group [get_clocks -include_generated_clocks c0_sys_clk_p] \
#  -group [get_clocks -include_generated_clocks tbp_sd_clk]


#SDIO
set_property PACKAGE_PIN AY14 [ get_ports t2p_sd_card_detect_n]
set_property IOSTANDARD LVCMOS18 [ get_ports t2p_sd_card_detect_n]
set_property PULLUP true [get_ports t2p_sd_card_detect_n]

set_property PACKAGE_PIN AY15 [ get_ports t2p_sd_card_write_prot]
set_property IOSTANDARD LVCMOS18 [ get_ports t2p_sd_card_write_prot]
set_property PULLDOWN true [get_ports t2p_sd_card_write_prot]

set_property PACKAGE_PIN AW15 [ get_ports tbp_sd_clk]
set_property IOSTANDARD LVCMOS18 [ get_ports tbp_sd_clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets sd_clk_pad_0/O]

set_property PACKAGE_PIN AV15 [ get_ports tbp_sd_cmd_in_out]
set_property IOSTANDARD LVCMOS18 [ get_ports tbp_sd_cmd_in_out]

set_property PACKAGE_PIN AV16 [ get_ports tbp_sd_dat_in_out_0]
set_property IOSTANDARD LVCMOS18 [ get_ports tbp_sd_dat_in_out_0]

set_property PACKAGE_PIN AU16 [ get_ports tbp_sd_dat_in_out_1]
set_property IOSTANDARD LVCMOS18 [ get_ports tbp_sd_dat_in_out_1]

set_property PACKAGE_PIN AT15 [ get_ports tbp_sd_dat_in_out_2]
set_property IOSTANDARD LVCMOS18 [ get_ports tbp_sd_dat_in_out_2]

set_property PACKAGE_PIN AT16 [ get_ports tbp_sd_dat_in_out_3]
set_property IOSTANDARD LVCMOS18 [ get_ports tbp_sd_dat_in_out_3]

#SSP
set_property PACKAGE_PIN BD13 [get_ports p2t_SSP_SHARED_1]
set_property PACKAGE_PIN BE13 [get_ports p2t_SSP_SHARED_12]
set_property PACKAGE_PIN BB13 [get_ports p2t_SSP_SHARED_2]
set_property PACKAGE_PIN BB12 [get_ports p2t_SSP_SHARED_6]
set_property PACKAGE_PIN AW8  [get_ports p2t_qspim_sclk_out]
set_property PACKAGE_PIN AW7  [get_ports p2t_qspim_ss]
set_property PACKAGE_PIN AP12 [get_ports p2t_sspim0_sclk_out]
set_property PACKAGE_PIN AR12 [get_ports p2t_sspim0_ss]
set_property PACKAGE_PIN AL14 [get_ports p2t_sspim0_txd]
set_property PACKAGE_PIN AM14 [get_ports p2t_uart1_sout]
set_property PACKAGE_PIN BF10 [get_ports p2t_uart2_sout]
set_property PACKAGE_PIN BF9  [get_ports t2p_SSP_SHARED_10]
set_property PACKAGE_PIN BE14 [get_ports t2p_SSP_SHARED_11]
set_property PACKAGE_PIN BF14 [get_ports t2p_SSP_SHARED_14]
set_property PACKAGE_PIN BA14 [get_ports t2p_sspim0_rxd]
set_property PACKAGE_PIN BB14 [get_ports t2p_uart1_sin]
set_property PACKAGE_PIN AY8  [get_ports t2p_uart2_sin]
set_property PACKAGE_PIN AY7  [get_ports tbp_SSP_SHARED_0]
set_property PACKAGE_PIN AR14 [get_ports tbp_SSP_SHARED_13]
set_property PACKAGE_PIN AT14 [get_ports tbp_SSP_SHARED_15]
set_property PACKAGE_PIN AN16 [get_ports tbp_SSP_SHARED_16]
set_property PACKAGE_PIN AP16 [get_ports tbp_SSP_SHARED_17]
set_property PACKAGE_PIN AK15 [get_ports tbp_SSP_SHARED_18]
set_property PACKAGE_PIN AL15 [get_ports tbp_SSP_SHARED_19]
set_property PACKAGE_PIN AY9  [get_ports tbp_SSP_SHARED_20]
set_property PACKAGE_PIN BA9  [get_ports tbp_SSP_SHARED_21]
set_property PACKAGE_PIN BD12 [get_ports tbp_SSP_SHARED_22]
set_property PACKAGE_PIN BE12 [get_ports tbp_SSP_SHARED_23]
set_property PACKAGE_PIN BE15 [get_ports tbp_SSP_SHARED_24]
set_property PACKAGE_PIN BF15 [get_ports tbp_SSP_SHARED_25]
set_property PACKAGE_PIN BC14 [get_ports tbp_SSP_SHARED_26]
set_property PACKAGE_PIN BC13 [get_ports tbp_SSP_SHARED_27]
set_property PACKAGE_PIN AV9  [get_ports tbp_SSP_SHARED_28]
set_property PACKAGE_PIN AV8  [get_ports tbp_SSP_SHARED_29]
set_property PACKAGE_PIN AW11 [get_ports tbp_SSP_SHARED_3]
set_property PACKAGE_PIN AY10 [get_ports tbp_SSP_SHARED_30]
set_property PACKAGE_PIN AW13 [get_ports tbp_SSP_SHARED_31]
set_property PACKAGE_PIN AY13 [get_ports tbp_SSP_SHARED_32]
set_property PACKAGE_PIN AT12 [get_ports tbp_SSP_SHARED_33]
set_property PACKAGE_PIN AU12 [get_ports tbp_SSP_SHARED_34]
set_property PACKAGE_PIN AN15 [get_ports tbp_SSP_SHARED_35]
set_property PACKAGE_PIN AP15 [get_ports tbp_SSP_SHARED_36]
set_property PACKAGE_PIN AM13 [get_ports tbp_SSP_SHARED_37]
set_property PACKAGE_PIN AM12 [get_ports tbp_SSP_SHARED_38]
set_property PACKAGE_PIN AK14 [get_ports tbp_SSP_SHARED_39]
set_property PACKAGE_PIN AK13 [get_ports tbp_SSP_SHARED_4]
set_property PACKAGE_PIN BC11 [get_ports tbp_SSP_SHARED_40]
set_property PACKAGE_PIN BD11 [get_ports tbp_SSP_SHARED_41]
set_property PACKAGE_PIN BF12 [get_ports tbp_SSP_SHARED_42]
set_property PACKAGE_PIN BF11 [get_ports tbp_SSP_SHARED_43]
set_property PACKAGE_PIN BC15 [get_ports tbp_SSP_SHARED_44]
set_property PACKAGE_PIN BD15 [get_ports tbp_SSP_SHARED_45]
set_property PACKAGE_PIN BA16 [get_ports tbp_SSP_SHARED_46]
set_property PACKAGE_PIN BA15 [get_ports tbp_SSP_SHARED_47]
set_property PACKAGE_PIN BB16 [get_ports tbp_SSP_SHARED_5]
set_property PACKAGE_PIN BC16 [get_ports tbp_SSP_SHARED_7]
set_property PACKAGE_PIN AW12 [get_ports tbp_SSP_SHARED_8]
set_property PACKAGE_PIN AY12 [get_ports tbp_SSP_SHARED_9]
set_property PACKAGE_PIN AU11 [get_ports tbp_i2c0_ic_clk]
set_property PACKAGE_PIN AV11 [get_ports tbp_i2c0_ic_data]
set_property PACKAGE_PIN AP13 [get_ports tbp_qspim_trxd_0]
set_property PACKAGE_PIN AR13 [get_ports tbp_qspim_trxd_1]
set_property PACKAGE_PIN AV10 [get_ports tbp_qspim_trxd_2]
set_property PACKAGE_PIN AW10 [get_ports tbp_qspim_trxd_3]

set_property IOSTANDARD LVCMOS18 [get_ports p2t_SSP_SHARED_1]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_SSP_SHARED_12]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_SSP_SHARED_2]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_SSP_SHARED_6]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_qspim_sclk_out]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_qspim_ss]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_sspim0_sclk_out]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_sspim0_ss]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_sspim0_txd]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_uart1_sout]
set_property IOSTANDARD LVCMOS18 [get_ports p2t_uart2_sout]
set_property IOSTANDARD LVCMOS18 [get_ports t2p_SSP_SHARED_10]
set_property IOSTANDARD LVCMOS18 [get_ports t2p_SSP_SHARED_11]
set_property IOSTANDARD LVCMOS18 [get_ports t2p_SSP_SHARED_14]
set_property IOSTANDARD LVCMOS18 [get_ports t2p_sspim0_rxd]
set_property IOSTANDARD LVCMOS18 [get_ports t2p_uart1_sin]
set_property IOSTANDARD LVCMOS18 [get_ports t2p_uart2_sin]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_0]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_13]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_15]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_16]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_17]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_18]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_19]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_20]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_21]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_22]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_23]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_24]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_25]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_26]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_27]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_28]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_29]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_3]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_30]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_31]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_32]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_33]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_34]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_35]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_36]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_37]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_38]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_39]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_4]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_40]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_41]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_42]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_43]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_44]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_45]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_46]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_47]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_5]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_7]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_8]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_SSP_SHARED_9]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_i2c0_ic_clk]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_i2c0_ic_data]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_qspim_trxd_0]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_qspim_trxd_1]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_qspim_trxd_2]
set_property IOSTANDARD LVCMOS18 [get_ports tbp_qspim_trxd_3]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets qspim_sclk_out_pad_0/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets sspim0_sclk_out_pad_0/O]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets i2c0_ic_clk_pad_0/O]

set_property PULLDOWN true [get_ports p2t_SSP_SHARED_1]
set_property PULLDOWN true [get_ports p2t_SSP_SHARED_12]
set_property PULLDOWN true [get_ports p2t_SSP_SHARED_2]
set_property PULLDOWN true [get_ports p2t_SSP_SHARED_6]
set_property PULLDOWN true [get_ports p2t_qspim_sclk_out]
set_property PULLUP true [get_ports p2t_qspim_ss]
set_property PULLDOWN true [get_ports p2t_sspim0_sclk_out]
set_property PULLUP true [get_ports p2t_sspim0_ss]
set_property PULLDOWN true [get_ports p2t_sspim0_txd]
set_property PULLDOWN true [get_ports p2t_uart1_sout]
set_property PULLDOWN true [get_ports p2t_uart2_sout]
set_property PULLDOWN true [get_ports t2p_SSP_SHARED_10]
set_property PULLDOWN true [get_ports t2p_SSP_SHARED_11]
set_property PULLDOWN true [get_ports t2p_SSP_SHARED_14]
set_property PULLDOWN true [get_ports t2p_sspim0_rxd]
set_property PULLDOWN true [get_ports t2p_uart1_sin]
set_property PULLDOWN true [get_ports t2p_uart2_sin]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_0]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_13]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_15]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_16]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_17]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_18]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_19]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_20]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_21]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_22]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_23]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_24]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_25]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_26]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_27]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_28]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_29]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_3]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_30]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_31]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_32]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_33]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_34]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_35]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_36]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_37]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_38]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_39]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_4]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_40]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_41]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_42]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_43]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_44]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_45]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_46]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_47]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_5]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_7]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_8]
set_property PULLDOWN true [get_ports tbp_SSP_SHARED_9]
set_property PULLUP true [get_ports tbp_i2c0_ic_clk]
set_property PULLUP true [get_ports tbp_i2c0_ic_data]
set_property PULLDOWN true [get_ports tbp_qspim_trxd_0]
set_property PULLDOWN true [get_ports tbp_qspim_trxd_1]
set_property PULLDOWN true [get_ports tbp_qspim_trxd_2]
set_property PULLDOWN true [get_ports tbp_qspim_trxd_3]

