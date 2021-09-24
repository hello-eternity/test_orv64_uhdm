# Git Hash: pygmy-es1x.git a65baabfdd0ce805b1d5f05e3ce85e620cef102f
# Git Hash: pygmy-es1x.git cf7bdf6ab822b021c88ca928f504a91770786c84
#**************************************************************
# Create Clock
#**************************************************************
#200MHz
set clk_period 2.0
set clk_uncertainty 0.1 
set latency_input_transition [expr $clk_period * 0.06]
set latency_input_transition_clocks [expr $clk_period * 0.003]
#**************************************************************
# Create Clock
#**************************************************************
create_clock -name CLK0 -period $clk_period [get_ports clk]
#create_clock -name CLK0 -period $clk_period [get_ports bank_u_clk]
#create_clock -name CLK1 -period $clk_period [get_ports cbuf_u_clk]
#create_clock -name CLK2 -period $clk_period [get_ports cpu_noc_u_clk]
#create_clock -name CLK3 -period $clk_period [get_ports debug_router_u_clk]
#create_clock -name CLK4 -period $clk_period [get_ports rugrats_core_u_clk]

set_clock_groups -asynchronous -name REFCLK_group \
    -group [get_clocks "CLK0"]


#**************************************************************
# Create Generated Clock
#**************************************************************
#derive_pll_clocks

#**************************************************************
# ScanEnable to be 0
#**************************************************************
# Please include vcore_fp_top.disable_scan_constraints.v



#**************************************************************
# Power Pin
#**************************************************************
#set ours(iport,cfg_pwr) [get_ports {*/cfg_is_clk_gated */cfg_thread_cnt*} -filter "direction==in"]




#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
#derive_clock_uncertainty
#set_clock_uncertainty 0.125 [all_clocks]
set_clock_uncertainty $clk_uncertainty [all_clocks]


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************
# false path to power switch control ack (use pre-placed and pre-routing in ICC2)
#set_false_path -from [get_ports */cfg_is_clk_gated] -to [get_ports */cfg_is_clk_gated]
#set_false_path -from [get_ports */cfg_thread_cnt* ] -to [get_ports */cfg_thread_cnt*]

# false path from SLP to Q in SRAM (SLP not valid in VCORE yet, only on top level)
#set ours(pin,sram_slp) [get_pins -of [get_cells * -hier -filter "ref_name=~TS*N28HPCP*"] -filter "full_name=~*/SLP"]
#set ours(pin,sram_q) [get_pins -of [get_cells * -hier -filter "ref_name=~TS*N28HPCP*"] -filter "full_name=~*/Q*"]
#set_false_path -th $ours(pin,sram_slp) -th $ours(pin,sram_q)



#**************************************************************
# Set Multicycle Path
#**************************************************************
# ORV 64
##set ours(ff,fp) [get_cells -hier {id2ex_ff_reg*fp_* id2ex_ctrl_ff_reg*fp_* id2fp_add_s_ff_reg* id2fp_add_d_ff_reg* id2fp_mac_s_ff_reg* id2fp_mac_d_ff_reg* id2fp_div_s_ff_reg* id2fp_div_d_ff_reg* id2fp_sqrt_s_ff_reg* id2fp_sqrt_d_ff_reg* id2fp_misc_ff_reg*}]
##set_multicycle_path -setup 30 -from $ours(ff,fp)
##set_multicycle_path -hold 29 -from $ours(ff,fp)

#set_multicycle_path -setup 8 -through [get_cells {_uP_core/EX/DIV/*}]
#set_multicycle_path -hold 7  -through [get_cells {_uP_core/EX/DIV/*}]
#
#set_multicycle_path -setup 5 -through [get_cells {_uP_core/EX/MUL/*}]
#set_multicycle_path -hold 4  -through [get_cells {_uP_core/EX/MUL/*}]
#set_multicycle_path -setup 8 -through [get_cells {_uP_core/EX/DIV/*}] -to [get_cells { \
#_uP_core/EX/DIV/DW_DIV_SEQ \
#_uP_core/EX/DIV/* \
#_uP_core/EX/ex2ma_ff_reg** \
#_uP_core/ID/id2div_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_fp_rs1* \
#_uP_core/ID/id2fp_add_d_ff_reg* \
#_uP_core/ID/id2fp_add_s_ff_reg* \
#_uP_core/ID/id2fp_div_d_ff_reg* \
#_uP_core/ID/id2fp_div_s_ff_reg* \
#_uP_core/ID/id2fp_mac_d_ff_reg* \
#_uP_core/ID/id2fp_mac_s_ff_reg* \
#_uP_core/ID/id2fp_misc_ff_reg* \
#_uP_core/ID/id2fp_sqrt_d_ff_reg* \
#_uP_core/ID/id2fp_sqrt_s_ff_reg* \
#_uP_core/ID/id2mul_ff_reg* \
#_uP_core/itlb_u/dff_sfence_req_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_SCALAR_DATA/dff_q_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_VLS_COMM_INFO/dff_q_reg* \
#}]
#
#set_multicycle_path -setup 8 -through [get_pins {_uP_core/EX/DIV/*}] -to [get_pins { \
#_uP_core/EX/DIV/DW_DIV_SEQ/* \
#_uP_core/EX/DIV/* \
#}]
#set_multicycle_path -setup 8 -through [get_pins {_uP_core/EX/DIV/*}]
#set_multicycle_path -hold 7 -through [get_pins {_uP_core/EX/DIV/*}]
#set_multicycle_path -setup 5 -through [get_pins {_uP_core/EX/MUL/*}]
#set_multicycle_path -hold 4 -through [get_pins {_uP_core/EX/MUL/*}]
#set_multicycle_path -hold 7  -through [get_cells {_uP_core/EX/DIV/*}] -to [get_cells { \
#_uP_core/EX/DIV/* \
#_uP_core/EX/DIV/DW_DIV_SEQ \
#_uP_core/EX/ex2ma_ff_reg** \
#_uP_core/ID/id2div_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_fp_rs1* \
#_uP_core/ID/id2fp_add_d_ff_reg* \
#_uP_core/ID/id2fp_add_s_ff_reg* \
#_uP_core/ID/id2fp_div_d_ff_reg* \
#_uP_core/ID/id2fp_div_s_ff_reg* \
#_uP_core/ID/id2fp_mac_d_ff_reg* \
#_uP_core/ID/id2fp_mac_s_ff_reg* \
#_uP_core/ID/id2fp_misc_ff_reg* \
#_uP_core/ID/id2fp_sqrt_d_ff_reg* \
#_uP_core/ID/id2fp_sqrt_s_ff_reg* \
#_uP_core/ID/id2mul_ff_reg* \
#_uP_core/itlb_u/dff_sfence_req_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_SCALAR_DATA/dff_q_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_VLS_COMM_INFO/dff_q_reg* \
#}]
#set_multicycle_path -hold 7 -through [get_pins {_uP_core/EX/DIV/*}] -to [get_pins { \
#_uP_core/EX/DIV/DW_DIV_SEQ/* \
#_uP_core/EX/DIV/* \
#}]
#                                   
#set_multicycle_path -setup 5 -through [get_cells {_uP_core/EX/MUL/*}] -to [get_cells { \
#_uP_core/EX/ex2ma_ff_reg* \
#_uP_core/EX/MUL/DW_MULT_SEQ \
#_uP_core/EX/MUL/* \
#_uP_core/ID/id2div_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_fp_rs1_ff_reg* \
#_uP_core/ID/id2fp_add_d_ff_reg* \
#_uP_core/ID/id2fp_add_s_ff_reg* \
#_uP_core/ID/id2fp_div_d_ff_reg* \
#_uP_core/ID/id2fp_div_s_ff_reg* \
#_uP_core/ID/id2fp_mac_d_ff_reg* \
#_uP_core/ID/id2fp_mac_s_ff_reg* \
#_uP_core/ID/id2fp_misc_ff_reg* \
#_uP_core/ID/id2fp_sqrt_d_ff_reg* \
#_uP_core/ID/id2fp_sqrt_s_ff_reg* \
#_uP_core/ID/id2mul_ff_reg* \
#_uP_core/itlb_u/dff_sfence_req_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_SCALAR_DATA/dff_q_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_VLS_COMM_INFO/dff_q_reg* \
#}]
#set_multicycle_path -setup 5 -through [get_pins {_uP_core/EX/MUL/*}] -to [get_pins { \
#_uP_core/EX/MUL/DW_MULT_SEQ/* \
#_uP_core/EX/MUL/* \
#}]
#set_multicycle_path -hold 4  -through [get_cells {_uP_core/EX/MUL/*}] -to [get_cells { \
#_uP_core/EX/ex2ma_ff_reg* \
#_uP_core/EX/MUL/DW_MULT_SEQ \
#_uP_core/EX/MUL/* \
#_uP_core/ID/id2div_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_ff_reg* \
#_uP_core/ID/id2ex_fp_rs1_ff_reg* \
#_uP_core/ID/id2fp_add_d_ff_reg* \
#_uP_core/ID/id2fp_add_s_ff_reg* \
#_uP_core/ID/id2fp_div_d_ff_reg* \
#_uP_core/ID/id2fp_div_s_ff_reg* \
#_uP_core/ID/id2fp_mac_d_ff_reg* \
#_uP_core/ID/id2fp_mac_s_ff_reg* \
#_uP_core/ID/id2fp_misc_ff_reg* \
#_uP_core/ID/id2fp_sqrt_d_ff_reg* \
#_uP_core/ID/id2fp_sqrt_s_ff_reg* \
#_uP_core/ID/id2mul_ff_reg* \
#_uP_core/itlb_u/dff_sfence_req_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_SCALAR_DATA/dff_q_reg* \
#_vector_core/vcore_fp_u/VCORE_DEC_U/VCORE_PPLN_DEC_DISP_U/FF_PPLN_VLS_COMM_INFO/dff_q_reg* \
#}]
#set_multicycle_path -hold 4 -through [get_pins {_uP_core/EX/MUL/*}] -to [get_pins { \
#_uP_core/EX/MUL/DW_MULT_SEQ/* \
#_uP_core/EX/MUL/* \
#}]
#
#                                  
#
#set ours(ff,fp) [get_cells -hier {id2ex_ctrl_ff_reg*fp_* id2fp_add_s_ff_reg* id2fp_add_d_ff_reg* id2fp_mac_s_ff_reg* id2fp_mac_d_ff_reg* id2fp_div_s_ff_reg* id2fp_div_d_ff_reg* id2fp_sqrt_s_ff_reg* id2fp_sqrt_d_ff_reg* id2fp_misc_ff_reg*}]
#set ours(ff,fpsqrt) [get_cells -hier {id2fp_sqrt_s_ff_reg*}]
#
## multicycle for fp units
#set_multicycle_path -setup 32 -from $ours(ff,fp)
#set_multicycle_path -hold 31 -from $ours(ff,fp)
#
#set_multicycle_path -setup 33 -from $ours(ff,fpsqrt)
#set_multicycle_path -hold 32 -from $ours(ff,fpsqrt)
#
#set_multicycle_path -setup 10 -from [get_ports {*_pwr_on* *rst_pc*}]
#set_multicycle_path -hold 9 -from [get_ports {*_pwr_on* *rst_pc*}]
#
### END ORV64
## ORV64 <-> VP
#set vcore(orv,vc) [get_cells -hier { *VCORE_DEC_U* *orv2vc* *vc2orv*}]
### set vcore(orv,vc) [get_pins -hier {*orv2vc* *vc2orv*}]
### set_multicycle_path -setup 6 -from $vcore(orv,vc)
### set_multicycle_path -hold 4 -from $vcore(orv,vc)
## END ORV64 <-> VP

#
#set_max_delay 1.0 -to  _vector_core/u_FP__floatpoint/v_*___vector/regs__*__regs/regs_*__r/wq_reg/D
#set_max_delay 1.0 -from _vector_core/u_FP__floatpoint/clk  -to  _vector_core/u_FP__floatpoint/v_*___vector/regs__*__regs/regs_*__r/wq_reg/D


#**************************************************************
# Set Maximum Delay
#**************************************************************
# assuming 14%
#set_input_delay [expr $clk_period * 0.3] -clock CLK0 [all_inputs]
#set_output_delay [expr $clk_period * 0.3] -clock CLK0 [all_outputs]

#set_input_delay [expr $clk_period * 0.3] -clock CLK1 [all_inputs]
#set_output_delay [expr $clk_period * 0.3] -clock CLK1 [all_outputs]
#
#set_input_delay [expr $clk_period * 0.3] -clock CLK2 [all_inputs]
#set_output_delay [expr $clk_period * 0.3] -clock CLK2 [all_outputs]
#
#set_input_delay [expr $clk_period * 0.3] -clock CLK3 [all_inputs]
#set_output_delay [expr $clk_period * 0.3] -clock CLK3 [all_outputs]
#
#set_input_delay [expr $clk_period * 0.3] -clock CLK4 [all_inputs]
#set_output_delay [expr $clk_period * 0.3] -clock CLK4 [all_outputs]
#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************
#set_driving_cell -lib_cell  BUFFD12BWP35P140HVT [all_inputs]
#set_load [get_attr [get_lib_pin tcbn28hpcplusbwp35p140hvtssg0p81vm40c_ccs/BUFFD12BWP35P140HVT/I] pin_capacitance] [all_outputs]


#set_input_transition $latency_input_transition [all_inputs]
#set_input_transition $latency_input_transition_clocks [get_ports clk]


#**************************************************************
# Set Load
#**************************************************************
#set_load [expr $clk_period * 0.01] [all_outputs]
