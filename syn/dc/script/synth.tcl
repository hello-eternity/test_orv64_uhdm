echo "RUN STARTED AT [date]"
source ../script/synth_init_library.tcl
set_svf ../output/orv64.synth.svf

# Tool settings
set_app_var sh_new_variable_message                     false
set_app_var report_default_significant_digits           3
set_app_var hdlin_infer_multibit                        default_all
set_app_var compile_clock_gating_through_hierarchy      true
set_app_var hdlin_enable_upf_compatible_naming          true
set_app_var compile_timing_high_effort_tns              true
set_app_var compile_clock_gating_through_hierarchy      true
set_app_var hdlin_enable_hier_map                       true


set_host_options -max_cores 8
### Logical Library
set_app_var search_path "."

set_app_var target_library [concat "$DB(ssg0p81v,m40c)"]
set_app_var link_library [concat "*" dw_foundation.sldb $target_library]
set_app_var synthetic_library "dw_foundation.sldb"

### Read in the design
define_design_lib WORK -path ./WORK


source $env(PROJ_ROOT)/hardware/soc/tool/hydra/script/tcl/file_to_list.tcl
analyze -format  sverilog [linsert [concat [expand_file_list "$env(PROJ_ROOT)/hardware/soc/rtl/flist/orv64.syn.f"]] 0 "$env(PROJ_ROOT)/hardware/soc/rtl/common/es1y_define.sv"]

elaborate      orv64
current_design orv64

# DesignWare settinqgs
set_dp_smartgen_options -hierarchy -smart_compare true -tp_oper_sel auto -tp_opt_tree auto  -brent_kung_adder true -adder_radix auto -inv_out_adder_cell auto -mult_radix4 auto -sop2pos_transformation auto  -mult_arch auto -optimize_for area,speed 
analyze_datapath_extraction -no_autoungroup

link
set_verification_top
uniquify
write_file -hierarchy -format verilog -output ../output/orv64.synth.elaborate.v

### Constraints
source /work/asic_backend/projects/es1y/SOURCE/synth/dont_use.synth.tsmc28hpc.tcl
source ../script/vp_fp.03-05-2020_20.30.59.sdc
write_sdc ../output/orv64.synth.elaborate.sdc

report_clock_tree -structure > ../rpt/clock_tree_structure.rpt

# NOTE: Uncertain if this is needed.
# set_preserve_clock_gate [get_cells * -hier -filter "ref_name=~*_clk_gating*"]

define_name_rules preserve_struct_bus_rule -preserve_struct_ports
define_name_rules ours_verilog_name_rule -allowed "a-z A-Z 0-9 _" \
    -check_internal_net_name \
    -case_insensitive 

echo [get_object_name [get_lib_cells */* -filter dont_use==true]] > ../rpt/dont_use_list.rpt

### Compile
check_design > ../rpt/check_design.precompile.rpt

set_dynamic_optimization true

compile_ultra -gate_clock -retime -no_autoungroup -no_boundary_optimization

analyze_datapath > ../rpt/datapath.compile.rpt
report_resources > ../rpt/resources.compile.rpt
write_file -hierarchy -format verilog -output ../output/orv64.synth.compile.v        
write_sdc ../output/orv64.synth.compile.sdc

update_timing
report_timing -nosplit > ../rpt/timing.compile.rpt
report_area -nosplit -hier > ../rpt/area.hier.compile.rpt

### Optimize
check_design > ../rpt/check_design.preopt.rpt
optimize_netlist -area -no_boundary_optimization
check_design > ../rpt/check_design.postopt.rpt

#rename_design -prefix "orv64_" [remove_from_collection [all_designs] [current_design]]
change_names -rules preserve_struct_bus_rule -hierarchy -log_changes ./rpt/struct_name_change.log   
change_names -rules ours_verilog_name_rule   -hierarchy -log_changes ./rpt/legalize_name_change.log 
write -format verilog -hierarchy -output ../output/orv64.synth.final.v
write -format ddc -hierarchy -output ../output/orv64.synth.final.ddc
write_sdc -nosplit ../output/orv64.synth.final.sdc

report_clock_gating > ../rpt/clock_gating.rpt
report_timing -max_paths 500 -significant_digits 3 -nosplit > ../rpt/synth.timing.rpt
report_timing -delay_type min -max_paths 500 -input_pins -nets -transition_time -capacitance -significant_digits 3 > ../rpt/synth.min_delay.rpt
report_timing -delay_type max -max_paths 500 -input_pins -nets -transition_time -capacitance -significant_digits 3 > ../rpt/synth.max_delay.rpt
report_constraint -all_violators -significant_digits 3 > ../rpt/synth.all_viol_constraints.rpt
report_area -nosplit -hier > ../rpt/synth.area.hier.rpt
report_resources -nosplit -hier > ../rpt/synth.resources.rpt

report_compile_options -nosplit > ../rpt/synth.compile_options.rpt

echo "RUN ENDED AT [date]"
#exit


