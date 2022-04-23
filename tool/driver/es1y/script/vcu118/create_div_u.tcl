##################################################################
# CREATE IP div_u
##################################################################

set div_gen div_u
create_ip -name div_gen -vendor xilinx.com -library ip -version 5.1 -module_name $div_gen

set_property -dict { 
  CONFIG.dividend_and_quotient_width {64}
  CONFIG.divisor_width {64}
  CONFIG.fractional_width {64}
  CONFIG.operand_sign {Unsigned}
  CONFIG.clocks_per_division {8}
  CONFIG.FlowControl {Blocking}
  CONFIG.OptimizeGoal {Resources}
  CONFIG.latency {68}
  CONFIG.ACLKEN {true}
} [get_ips $div_gen]

##################################################################

