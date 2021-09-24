open_hw
connect_hw_server -url ours-fpga:3121
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/210308A6643E]
set_property PARAM.FREQUENCY 15000000 [get_hw_targets */xilinx_tcf/Digilent/210308A6643E]
open_hw_target
current_hw_device [get_hw_devices xcvu9p_0]
refresh_hw_device [lindex [get_hw_devices xcvu9p_0] 0]
reset_hw_axi [get_hw_axis hw_axi_1]
