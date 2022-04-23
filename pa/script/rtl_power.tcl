puts "INFO: start @ [exec date]"
source script/synth_init_library.tcl
source $env(PROJ_ROOT)/hardware/soc/tool/hydra/script/tcl/file_to_list.tcl

pa_set use_non_scan_flops false
pa_set activity_streaming_mode veloce_live
ConfigureParallelAnalysis -processes 16

ReadLibrary -name [concat "$LIB(tt0p65v,25c)"]

puts "INFO: ReadLib done @ [exec date]"
SetIncDirPath 
SetMacros SYNTHESIS
CompileFile -type verilog -sv yes -file [linsert [concat [expand_file_list "$env(PROJ_ROOT)/hardware/soc/rtl/flist/orv64.syn.f"]] 0 "$env(PROJ_ROOT)/hardware/soc/rtl/common/es1y_define.sv"]
Elaborate \
  -top                          orv64 \
  -dblib                        [concat "$DB(tt0p65v,25c)"] \
  -system_verilog               true \
  -scenario_file                db/rtl_power.scn \
  -enable_dw_synthesis          true \
  -elaborate_relax_syntax_check true \
  -elaborate_auto_black_box     true \
  -elaborate_write_power_db     true \
  -power_db_name                db/elab.pdb \
  -elaborate_log                log/elab.log
puts "INFO: Elaborate done @ [exec date]"

ReadSDC \
  -top              orv64 \
  -sdc_files        script/orv64.sdc \
  -power_db_name    db/elab.pdb \
  -sdc_clocks_mode  infer \
  -sdc_clocks_gated true \
  -sdc_out_file     output/sdc.scr \
  -log              log/read_sdc.log
puts "INFO: ReadSDC done @ [exec date]"

source output/sdc.scr

SetClockBuffer -type leaf -fanout 16 -name UDBLVT24_INV_S_12
SetClockGatingStyle -clock_cell_attribute latch_posedge_precontrol -max_bit_width 512

# Comment this command out to re-run without re-reading the fsdb
# -activity_file /work/asic_backend/projects/rugrats/DATA/RTL/rugrats_subsys_super__08-25-2021_20.16.44/conv_3x3_64x64.fsdb \
#
GenerateGAF \
  -activity_file power.fsdb \
  -top_instance  testbench.top0.dut.orv64_u \
  -scenario_file db/rtl_power.scn \
  -gaf_file      db/rtl_power.gaf \
  -gaf_enable_reduction_data true
puts "INFO: GenerateGAF done @ [exec date]"

CalculatePower \
  -wireload_library          gf22nsdllogl24edl116a_TT_0P65V_0P00V_0P00V_M0P20V_25C \
  -analysis_type             average \
  -use_existing_gaf          true \
  -gaf_file                  db/rtl_power.gaf \
  -scenario_file             db/rtl_power.scn \
  -average_report_options    agipmV \
  -average_report_file       rpt/avg_power.rpt \
  -average_write_power_db    true \
  -detailed_vertical_report  true \
  -vertical_report_instances orv64 \
  -power_db_name             db/avg_power.pdb \
  -calculate_log             log/calc.log

puts "INFO: CalculatePower done @ [exec date]"

openPDB db/avg_power.pdb
reportPower -show_ibp -levels 10 -unit mW -out rpt/power.rpt
reportSummary -out rpt/summary.rpt
reportCGEfficiency -sort_by clock_power -out rpt/cg_efficiency.rpt -cols {cg_inst cg_type clock_power enable_cum_eff enable_eff enable_duty_cycle clock_freq gated_clock_freq data_freq_out flop_bits direct_flop_bits enable_net enable_sense clock_net file line }
closePDB
puts "INFO: reportSummary done @ [exec date]"

ReducePower \
  -top_instance              orv64 \
  -wireload_library          gf22nsdllogl24edl116a_TT_0P65V_0P00V_0P00V_M0P20V_25C \
  -use_existing_gaf          true \
  -gaf_file                  db/rtl_power.gaf \
  -scenario_file             db/rtl_power.scn \
  -logic_optimization_report rpt/logic_opt.rpt \
  -reduction_report_file     rpt/reduce_power.rpt \
  -reduction_max_bit_width 512  -max_bit_width 512 \
  -power_db_name             db/reduce_power.pdb

puts "finish @ [exec date]"
exit


