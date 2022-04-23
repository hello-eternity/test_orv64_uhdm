create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila_native_3_probe
set_property -dict [list CONFIG.C_NUM_OF_PROBES {3} CONFIG.C_PROBE2_MU_CNT {1} CONFIG.C_PROBE1_MU_CNT {1} CONFIG.C_PROBE0_MU_CNT {1} CONFIG.ALL_PROBE_SAME_MU_CNT {1}] [get_ips ila_native_3_probe]
set_property -dict [list CONFIG.C_PROBE1_WIDTH {64}] [get_ips ila_native_3_probe]
set_property -dict [list CONFIG.C_PROBE2_WIDTH {64}] [get_ips ila_native_3_probe]
