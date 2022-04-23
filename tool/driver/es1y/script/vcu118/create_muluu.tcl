##################################################################
# CREATE IP mult_uu
##################################################################

set mult_gen mult_uu
create_ip -name mult_gen -vendor xilinx.com -library ip -version 12.0 -module_name $mult_gen

set_property -dict { 
  CONFIG.PortAType {Unsigned}
  CONFIG.PortAWidth {64}
  CONFIG.PortBType {Unsigned}
  CONFIG.PortBWidth {64}
  CONFIG.Multiplier_Construction {Use_Mults}
  CONFIG.OutputWidthHigh {127}
  CONFIG.PipeStages {18}
  CONFIG.ClockEnable {true}
} [get_ips $mult_gen]

##################################################################

