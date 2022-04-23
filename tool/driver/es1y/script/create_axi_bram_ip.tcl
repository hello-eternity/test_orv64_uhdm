set module axi_bram_ctrl_1
create_ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 -module $module
# removed these properties
# SELECTED_SIM_MODEL            string   false      rtl
# USER_LOCKED                   bool     false      0

set_property -dict [list \
                    CONFIG.BMG_INSTANCE           {INTERNAL} \
                    CONFIG.CLKIF.FREQ_HZ          {100000000} \
                    CONFIG.CLKIF.INSERT_VIP       {0} \
                    CONFIG.C_SELECT_XPM           {1} \
                    CONFIG.DATA_WIDTH             {512} \
                    CONFIG.ECC_ONOFF_RESET_VALUE  {0} \
                    CONFIG.ECC_TYPE               {0} \
                    CONFIG.FAULT_INJECT           {0} \
                    CONFIG.ID_WIDTH               {4} \
                    CONFIG.MEM_DEPTH              {8192} \
                    CONFIG.PROTOCOL               {AXI4} \
                    CONFIG.RD_CMD_OPTIMIZATION    {0} \
                    CONFIG.READ_LATENCY           {1} \
                    CONFIG.RSTIF.INSERT_VIP       {0} \
                    CONFIG.SINGLE_PORT_BRAM       {0} \
                    CONFIG.SUPPORTS_NARROW_BURST  {1} \
                    CONFIG.S_AXI.INSERT_VIP       {0} \
                    CONFIG.S_AXI_CTRL.INSERT_VIP  {0} \
                    CONFIG.USE_ECC                {0} \
                   ]  [get_ips $module]
