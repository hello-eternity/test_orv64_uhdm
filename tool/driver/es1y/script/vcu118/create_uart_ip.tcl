set axi_uartlite uart
create_ip -name axi_uartlite -vendor xilinx.com -library ip -version 2.0 -module_name $axi_uartlite

set_property -dict { 
  CONFIG.C_BAUDRATE {128000}
  CONFIG.C_S_AXI_ACLK_FREQ_HZ {25000000}
  CONFIG.C_S_AXI_ACLK_FREQ_HZ_d {25}
  CONFIG.UARTLITE_BOARD_INTERFACE {rs232_uart}
} [get_ips $axi_uartlite]

