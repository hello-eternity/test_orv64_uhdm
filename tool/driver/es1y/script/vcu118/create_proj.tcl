source ./script/file_to_list.tcl

# need to create a project targetting the correct SoC 
create_project -part xcvu9p-flga2104-2L-e fpga_es1y_vcu118

set_property source_mgmt_mode None [current_project]
# target the correct board as well, or when creating the Xilinx IPs errors will occur
set_property BOARD_PART xilinx.com:vcu118:2.0  [current_project]

source ./script/vcu118/create_mulss.tcl
source ./script/vcu118/create_muluu.tcl
source ./script/vcu118/create_mulsu.tcl
source ./script/vcu118/create_div_s.tcl
source ./script/vcu118/create_div_u.tcl
source ./script/vcu118/create_xddr_cdc.tcl
source ./script/vcu118/create_ddr_ip.tcl
source ./script/vcu118/create_jtag_bd.tcl

set git_root $env(PROJ_ROOT)/hardware/soc

# read in an flist
set flist ${git_root}/rtl/flist/fpga_es1y.syn.f

# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
   create_fileset -srcset sources_1
}
 # Set 'sources_1' fileset object
set obj [get_filesets sources_1]
set_property -name "verilog_define" -value "SYNTHESIS VECTOR_GEN2 FPGA FPGA_SIM EMULATION NO_USB NO_DDR EXT_OR_BRIDGE EXT_MEM_NOC_BRIDGE PYGMY_ES1Y NO_ORV32 NO_SSP_TOP NO_DT NO_SDIO ORV64_SUPPORT_MULDIV ORV64_SUPPORT_FP ORV64_SUPPORT_FP_DOUBLE" -objects $obj

foreach f [expand_file_list  $flist] {
  puts "Reading $f"
  read_verilog -library ours -sv $f
  add_files  -verbose -norecurse -scan_for_includes -fileset $obj $f
}

# import files will create a copy of the imported file and place it by default under directory
read_xdc  ${git_root}/subproj/es1y_fpga/vcu118/fpga_vcu118.xdc

set_property top pygmy_es1y_fpga_vcu118 [current_fileset]


update_compile_order -fileset sources_1
