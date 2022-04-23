#------------------------------------------------------
# Module Name: POWER
# Date:        Wed Apr  3 11:51:01 2019
# Author:      kvu
# Type:        power
#------------------------------------------------------
package Hydra::Setup::Flow::POWER;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------

#++
# Tool: ptpx
# Flow: POWER
#--
sub ptpx_POWER {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  my @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "power");
  
  # Get all scenarios from SCENARIO param
  my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);
  my @ScriptFiles = ();
  my @script_file_names = ();
  my @missing_spefs = ();
  my $num_scenarios = 0;
  foreach my $aref_keys (@keysets) {
    my $scenario_value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);
    my %scenario_tags  = &Hydra::Setup::Flow::parse_scenario_value($scenario_value);
    next if (!$scenario_tags{power});
    $num_scenarios++;

    my ($mode, $process, $temp, $rc) = @$aref_keys;
    my $scenario_name = "${mode}.${process}.${temp}.${rc}";

    my $File = new Hydra::Setup::File("script/${scenario_name}.power.tcl", "power");
    push(@ScriptFiles, $File);
    push(@script_file_names, "script/${scenario_name}.power.tcl");
    my $line = "";

    #my $license_file = $Paramref->get_param_value("POWER_license_file", "strict");
    #$line .= "source $license_file\n";

    $line .= "source ./script/power_init_library.tcl\n";
    $line .= "\n";

    my $db_var       = &Hydra::Setup::Flow::HYDRA::get_lib_var($Paramref, "db", $process, $temp);
    my $verilog      = $Paramref->get_param_value("POWER_verilog", "strict", @$aref_keys);
    my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");

    $line .= "# Tool settings\n";
    if (&Hydra::Setup::Param::has_value($host_options)) {
      $line .= "set_host_options $host_options\n";
    }

    $line .= sprintf <<EOF;
set_app_var power_enable_analysis               true
set_app_var power_enable_multi_rail_analysis    true
set_app_var power_analysis_mode                 time_based

# Libraries
set link_path [concat * \$$db_var]

# Read design
read_verilog   $verilog
link_design    $design_name
current_design $design_name

EOF

    # Source catchalls
    $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "POWER", @$aref_keys);
    
    # Spef
    my $regr_mode = $Paramref->get_param_value("POWER_regr_mode", "relaxed");
    unless (&Hydra::Setup::Param::is_on($regr_mode)) {
      $line .= "# Read spef\n";
      my $block_or_top = $Paramref->get_param_value("POWER_enable_fullchip", "relaxed");
      $line .= "read_parasitics -keep_capacitive_coupling -format spef ../rc_extract/output/${design_name}.${rc}.${temp}.spef.gz\n";
      #if ($block_or_top eq "top") {
      if (&Hydra::Setup::Param::is_on($block_or_top)) {
        my $proj_home = $Paramref->get_param_value("HYDRA_proj_home", "strict");
        my @block_dirs = &Hydra::Util::File::get_sub_dirs("${proj_home}/DATA");
        foreach my $block (@block_dirs) {
          my $block_spef = "${proj_home}/DATA/${block}/spef/${block}.${rc}.${temp}.spef.gz";
          if (-f $block_spef) {
            $line .= "read_parasitics -keep_capacitive_coupling -format spef $block_spef\n";
          }
          else {
            push(@missing_spefs, $block_spef);
          }
        }
      }
      $line .= "\n";
    }

    my $fsdb = $Paramref->get_param_value("POWER_fsdb", "strict");

    $line .= sprintf <<EOF;
set_user_attribute [get_lib *] default_threshold_voltage_group SVT -class lib
set_user_attribute [get_lib -filter \"full_name=~*tcb*hvt*\"] default_threshold_voltage_group HVT -class lib
set_user_attribute [get_lib -filter \"full_name=~*tcb*lvt*\"] default_threshold_voltage_group LVT -class lib
set_user_attribute [get_lib -filter \"full_name=~*ts*\"]      default_threshold_voltage_group SVT_SRAM -class lib
set_user_attribute [get_lib -filter \"full_name=~*ts*hvt*\"]  default_threshold_voltage_group HVT_SRAM -class lib
set_user_attribute [get_lib -filter \"full_name=~*ts*lvt*\"]  default_threshold_voltage_group LVT_SRAM -class lib

# Read fsdb
set_power_analysis_options \\
        -waveform_format fsdb \\
        -waveform_output ./output/power.fsdb \\
        -separate_dyn_and_leak_power_waveform \\
        -include all_with_leaf

read_fsdb -zero_delay -time {0 -1} -strip_path \"top/dut\" $fsdb
check_activity [get_pins *]

EOF

    $line .= "# Read sdc\n";
    my $sdc = $Paramref->get_param_value("POWER_sdc", "strict", ($mode));
    $line .= &Hydra::Setup::Flow::write_repeating_param("source", $sdc);
    $line .= "\n";

    $line .= sprintf <<EOF;
set_propagated_clock [all_clocks]

# Punch it
update_timing -full
update_power

save_session db/${scenario_name}.power.session

# Reports
if ![file exists rpt/${scenario_name}] {
  file mkdir rpt/${scenario_name}
}

check_power                            > ./rpt/${scenario_name}/check_power.rpt

report_power                           > ./rpt/${scenario_name}/power.rpt
report_power -threshold_voltage_group  > ./rpt/${scenario_name}/power.vt_grp.rpt
report_power -hier -levels 10 -nosplit > ./rpt/${scenario_name}/power.hier.rpt
report_threshold_voltage_group         > ./rpt/${scenario_name}/vt_grp.rpt

report_clock_gate_savings              > ./rpt/${scenario_name}/clock_gating.rpt

exit

EOF

    $File->add_line($line);
  }

  # Warn if block spefs are missing
  my %dup = map {$_ => 1} @missing_spefs;
  @missing_spefs = sort keys %dup;
  if (scalar(@missing_spefs) > 0) {
    warn "WARN: Could not find the following block spefs for POWER:\n";
    foreach my $block_spef (@missing_spefs) {
      warn "  $block_spef\n";
    }
  }

  # Error if no scenarios were defined
  if ($num_scenarios <= 0) {
    &Hydra::Setup::Control::register_error_param("POWER", "no_scenario");
  }

  # Run scripts
  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "power");
  &Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, @script_file_names);

  return (@LibFiles, @ScriptFiles, $KickoffFile);
}

#++
# Tool: powerartist
# Flow: POWER
#--
sub powerartist_POWER {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  my @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "power");
  
  my @ScriptFiles = ();
  my @script_file_names = ();
  my $ScriptFile = new Hydra::Setup::File("script/power.tcl", "power");
  push(@script_file_names, "script/power.tcl");
  my $line = "";

  my $lib_var = &Hydra::Setup::Flow::get_scenario_lib_var($Paramref, "POWER", "lib");

  my $scan_ins = $Paramref->get_param_value("POWER_enable_scan_ins", "relaxed");
  my $scan_string = "pa_set use_non_scan_flops true";
  if (&Hydra::Setup::Param::is_on($scan_ins)) {
    $scan_string = "pa_set use_non_scan_flops false";
  }

  $line .= sprintf <<EOF;
source script/power_init_library.tcl

$scan_string

ReadLibrary -name [concat \"\$$lib_var\"]

EOF

  my $verilog = $Paramref->get_param_value("POWER_verilog", "strict");
  $line .= &Hydra::Setup::Flow::write_repeating_param("CompileFile -type verilog -file", $verilog);
  $line .= "\n";

  $line .= sprintf <<EOF;
Elaborate \\
  -gate_level_netlist           true \\
  -top                          $design_name \\
  -scenario_file                db/power.scn \\
  -elaborate_relax_syntax_check true \\
  -elaborate_auto_black_box     true \\
  -elaborate_write_power_db     true \\
  -power_db_name                db/elab.pdb \\
  -elaborate_log                log/elab.log

EOF


  my $sdc  = &Hydra::Util::File::resolve_env($Paramref->get_param_value("POWER_sdc", "strict"));
  $line .= sprintf <<EOF;
ReadSDC \\
  -top              $design_name \\
  -sdc_files        $sdc \\
  -power_db_name    db/elab.pdb \\
  -sdc_clocks_mode  infer \\
  -sdc_clocks_gated true \\
  -sdc_out_file     output/sdc.scr \\
  -log              log/read_sdc.log

source output/sdc.scr

EOF

  my $cts_buf = &Hydra::Setup::Param::remove_param_value_linebreak($Paramref->get_param_value("POWER_cts_buf", "strict"));
  my $fanout  = $Paramref->get_param_value("POWER_cts_max_fanout", "strict");
  my @bufs = split(/\s+/, &Hydra::Setup::Param::remove_param_value_linebreak($cts_buf));
  foreach my $buf (@bufs) {
    $line .= "SetClockBuffer -type leaf -fanout $fanout -name $buf\n";
  }
  $line .= "SetClockGatingStyle -clock_cell_attribute latch_posedge_precontrol\n";
  $line .= "\n";

  my $spef = $Paramref->get_param_value("POWER_spef", "relaxed");
  if (&Hydra::Setup::Param::has_value($spef)) {
    $line .= "ReadParasitics -path $design_name -file $spef\n\n";
  }

  my $fsdb      = &Hydra::Util::File::resolve_env($Paramref->get_param_value("POWER_fsdb", "strict"));
  my $starttime = $Paramref->get_param_value("POWER_fsdb_starttime", "relaxed");
  my $endtime   = $Paramref->get_param_value("POWER_fsdb_endtime", "relaxed");
  my $top_name = $Paramref->get_param_value("POWER_testbench_top", "strict");
  $line .= sprintf <<EOF;
# Comment this command out to re-run without re-reading the fsdb
GenerateGAF \\
  -activity_file $fsdb \\
  -top_instance  $top_name \\
EOF

  if (&Hydra::Setup::Param::has_value($starttime)) {
    $line .= "  -start_time    $starttime \\\n";
  }
  if (&Hydra::Setup::Param::has_value($endtime)) {
    $line .= "  -end_time      $endtime \\\n";
  }

$line .= sprintf <<EOF;
  -scenario_file db/power.scn \\
  -gaf_file      db/power.gaf \\
  -gaf_enable_reduction_data true

EOF

  if (&Hydra::Setup::Param::has_value($spef)) {
    $line .= sprintf <<EOF;
CalculatePower \\
EOF
  }
  else {
    my $wireload_lib = $Paramref->get_param_value("POWER_wireload_lib", "strict");
    $line .= sprintf <<EOF;
CalculatePower \\
  -wireload_library          $wireload_lib \\
EOF
  }

  $line .= sprintf <<EOF;
  -analysis_type             average \\
  -use_existing_gaf          true \\
  -gaf_file                  db/power.gaf \\
  -scenario_file             db/power.scn \\
  -average_report_options    agipmV \\
  -average_report_file       rpt/avg_power.rpt \\
  -average_write_power_db    true \\
  -detailed_vertical_report  true \\
  -vertical_report_instances $design_name \\
  -power_db_name             db/avg_power.pdb \\
  -calculate_log             log/calc.log

openPDB db/avg_power.pdb
reportPower -show_ibp -levels 10 -unit mW -out rpt/power.rpt
reportSummary -out rpt/summary.rpt
reportCGEfficiency -sort_by clock_power -out rpt/cg_efficiency.rpt -cols {cg_inst cg_type clock_power enable_cum_eff enable_eff enable_duty_cycle clock_freq gated_clock_freq data_freq_out flop_bits direct_flop_bits enable_net enable_sense clock_net file line }
closePDB

EOF

  if (&Hydra::Setup::Param::has_value($spef)) {
    $line .= sprintf <<EOF;
ReducePower \\
EOF
  }
  else {
    my $wireload_lib = $Paramref->get_param_value("POWER_wireload_lib", "strict");
    $line .= sprintf <<EOF;
ReducePower \\
  -wireload_library          $wireload_lib \\
EOF
  }

  $line .= sprintf <<EOF;
  -top_instance              $design_name \\
  -use_existing_gaf          true \\
  -gaf_file                  db/rtl_power.gaf \\
  -scenario_file             db/rtl_power.scn \\
  -logic_optimization_report rpt/logic_opt.rpt \\
  -reduction_report_file     rpt/reduce_power.rpt \\
  -power_db_name             db/reduce_power.pdb

exit

EOF

  $ScriptFile->add_line($line);
  push(@ScriptFiles, $ScriptFile);

  # Run scripts
  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "power");
  &Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, @script_file_names);

  return (@LibFiles, @ScriptFiles, $KickoffFile);
}

=pod

=head1 ptpx POWER

=over

=item SCENARIO

Specify the scenarios that will be run. Use param keys for mode, process, temperature, and RC corner. The param key order matters. The value is a space-delimited list indicating what flow types the scenario is valid for. Use "power" for POWER.
 SCENARIO(<mode>)(<process>)(<temp>)(<rc>) = <value>
 SCENARIO(func)(ff_0p99)(125c)(cbest) = power

=item POWER_enable_fullchip

Enable fullchip power. If this is enabled, then block spefs will be automatically read in.

=item POWER_verilog

The verilog netlist.

=item POWER_fsdb

The fsdb generated based on the given verilog netlist.

=item POWER_sdc

One or more timing constraint files.

=item POWER_source_catchall_global

A space-delimited list of misc source scripts.

=item POWER_source_catchall_local

A space-delimited list of misc source scripts.

=item POWER_regr_mode

Regression mode. If set to "on", then no spef will be read in.

=back

=head1 powerartist POWER

=over

=item POWER_verilog

The verilog netlist.

=item POWER_fsdb

An fsdb file containing waveform data.

=item POWER_fsdb_starttime

The start time of the waveform in the fsdb. Optional. If not specified, the tool will use the start time embedded in the fsdb.

=item POWER_fsdb_endtime

The end time of the waveform in the fsdb. Optional. If not specified, the tool will use the end time embedded in the fsdb.

=item POWER_testbench_top

The top module name of the fsdb.

=item POWER_sdc

The timing constraint file.

=item POWER_cts_buf

The clock buffer cell used when estimating the clock tree.

=item POWER_cts_max_fanout

The max fanout of the clock buffer cell.

=item POWER_spef

Spef file containing parasitics data. Optional. If this file is not specified, POWER_wireload_lib must be defined.

=item POWER_wireload_lib

Specify the library containing the wireload specifications that will be used. Due to a bug in the tool, this must be manually defined. This is required if POWER_spef is not defined.

=item POWER_enable_scan_ins

Enables usage of scan flops when mapping flops in the design. Optional.

=item POWER_define

A space-delimited list of `define macros.

=cut

1;
