#------------------------------------------------------
# Module Name: SCAN_INSERT
# Date:        Fri Feb 15 13:01:28 2019
# Author:      kvu
# Type:        scan_insert
#------------------------------------------------------
package Hydra::Setup::Flow::SCAN_INSERT;

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
# Tool: dc
# Flow: SCAN_INSERT
#--
sub dc_SCAN_INSERT {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  my @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "scan_insert");

  # Run scripts
  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "scan_insert");
  &Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, ("script/scan_insert.tcl"));

  # Tool scripts
  my $ScriptFile = new Hydra::Setup::File("script/scan_insert.tcl", "scan_insert");
  my $line = "";

  $line .= "source script/scan_insert_init_library.tcl\n";
  $line .= "\n";

  $line .= sprintf <<EOF;
# App vars
set_app_var sh_new_variable_message                     false
set_app_var report_default_significant_digits           3
set_app_var hdlin_infer_multibit                        default_all
set_app_var compile_clock_gating_through_hierarchy      true
set_app_var hdlin_enable_upf_compatible_naming          true
set_app_var compile_timing_high_effort_tns              true
set_app_var compile_clock_gating_through_hierarchy      true

echo \"RUN STARTED AT [date]\"

EOF

  my $db_var = &Hydra::Setup::Flow::get_scenario_lib_var($Paramref, "SCAN_INSERT", "db");
  $line .= sprintf <<EOF;
# Read libraries
set_app_var target_library    [concat "\$$db_var"]
set_app_var link_library      [concat "*" dw_foundation.sldb \$target_library]
set_app_var synthetic_library "dw_foundation.sldb"
  
EOF

  my $verilog = $Paramref->get_param_value("SCAN_INSERT_verilog", "relaxed");
  if (&Hydra::Setup::Param::has_value($verilog)) {
    $line .= &Hydra::Setup::Flow::write_repeating_param("read_verilog", $verilog);
    $line .= "\n";
  }

  my $ddc = $Paramref->get_param_value("SCAN_INSERT_ddc", "relaxed");
  if (&Hydra::Setup::Param::has_value($ddc)) {
    $line .= "# Read ddc file\n";
    $line .= &Hydra::Setup::Flow::write_repeating_param("read_ddc", $ddc);
    $line .= "\n";
  }

  if ($Paramref->has_param_keysets("SCAN_INSERT_test_model", 1)) {
    my @keysets = $Paramref->get_param_keysets("SCAN_INSERT_test_model", 1);
    foreach my $aref_keys (@keysets) {
      my ($ctl_design) = @$aref_keys;
      next if (&Hydra::Setup::Param::is_default_key($ctl_design));
      my $ctl_file = $Paramref->get_param_value("SCAN_INSERT_test_model", "strict", @$aref_keys);
      $line .= "read_test_model $ctl_file -format ctl -design $ctl_design\n";
    }
    $line .= "\n";
  }

  my $bb_script = $Paramref->get_param_value("SCAN_INSERT_read_black_box_script", "relaxed");
  $line .= &Hydra::Setup::Flow::write_repeating_param("source", $bb_script);
  $line .= "\n";

  $line .= "current_design ${design_name}\n";
  $line .= "link\n";
  $line .= "write -format ddc -hierarchy -output ./rpt/${design_name}.beforescan.ddc\n";
  $line .= "\n";

  my $period = $Paramref->get_param_value("SCAN_INSERT_period", "relaxed");
  my $strobe = $Paramref->get_param_value("SCAN_INSERT_strobe", "relaxed");
  my $delay  = $Paramref->get_param_value("SCAN_INSERT_delay", "relaxed");
  my $bidir  = $Paramref->get_param_value("SCAN_INSERT_bidir_delay", "relaxed");
  $line .= "# Clock variables\n";
  if (&Hydra::Setup::Param::has_value($period)) {
    $line .= "set test_default_period      $period\n";
  }
  if (&Hydra::Setup::Param::has_value($strobe)) {
    $line .= "set test_default_strobe      $strobe\n";
  }
  if (&Hydra::Setup::Param::has_value($delay)) {
    $line .= "set test_default_delay       $delay\n";
  }
  if (&Hydra::Setup::Param::has_value($bidir)) {
    $line .= "set test_default_bidir_delay $bidir\n";
  }
  $line .= "\n";

  my $dft_signal_script = $Paramref->get_param_value("SCAN_INSERT_dft_signal_script", "strict");
  $line .= "# DFT signal script\n";
  $line .= &Hydra::Setup::Flow::write_repeating_param("source", $dft_signal_script);
  $line .= "\n";

  $line .= sprintf <<EOF;
# Scan config
set_scan_configuration -create_test_clocks_by_system_clock_domain false
set_scan_configuration -style                           multiplexed_flip_flop
set_scan_configuration -replace                         true
set_scan_configuration -clock_mixing                    no_mix
set_scan_configuration -add_lockup                      true
set_scan_configuration -insert_terminal_lockup          true
set_scan_configuration -create_dedicated_scan_out_ports false
set_scan_configuration -hierarchical_isolation          false
set_scan_configuration -reuse_mv_cells                  true
set_scan_configuration -power_domain_mixing             false
set_scan_configuration -voltage_mixing                  false

EOF

  my $chain_count = $Paramref->get_param_value("SCAN_INSERT_chain_count");
  my $max_length  = $Paramref->get_param_value("SCAN_INSERT_max_length");
  if (&Hydra::Setup::Param::has_value($chain_count)) {
    $line .= "set_scan_configuration -chain_count                     $chain_count\n";
  }
  if (&Hydra::Setup::Param::has_value($max_length)) {
    $line .= "set_scan_configuration -max_length                      $max_length\n";
  }
  $line .= "\n";

  $line .= sprintf <<EOF;
set_dft_insertion_configuration -synthesis_optimization none
set_dft_insertion_configuration -preserve_design_name   true
set_dft_insertion_configuration -map_effort             high

set_dft_configuration -fix_bus                disable
set_dft_configuration -fix_bidirectional      disable
set_dft_configuration -scan                   enable
set_dft_configuration -connect_clock_gating   enable
report_dft_configuration

report_autofix_configuration
set_autofix_configuration -type internal_bus  -method no_disabling
set_autofix_configuration -type external_bus  -method no_disabling
set_autofix_configuration -type bidirectional -method no_disabling
report_autofix_configuration

set_svf ./output/${design_name}.scan.svf

EOF

  $line .= sprintf <<EOF;
# Read UPF
set auto_insert_level_shifters  false
set test_insert_isolation_cells false
EOF

  my $upf = $Paramref->get_param_value("SCAN_INSERT_upf", "relaxed");
  if (&Hydra::Setup::Param::has_value($upf)) {
    $line .= "load_upf $upf\n";
  }
  $line .= "\n";

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "SCAN_INSERT");
  
  $line .= sprintf <<EOF;
# Create test protocol
create_test_protocol

set test_disable_enhanced_dft_drc_reporting false
report_multibit_banking -hierarchical > ./rpt/multibit_banking.rpt

dft_drc -verbose                     > ./rpt/pre.drc.rpt
preview_dft -show all                > ./rpt/preview.rpt
insert_dft                           > ./rpt/insert.rpt

change_names -rules verilog -hier -log_changes ./rpt/change_names.log

EOF

  my $test_modes = $Paramref->get_param_value("SCAN_INSERT_test_modes", "strict");
  $test_modes = &Hydra::Setup::Param::remove_param_value_linebreak($test_modes);
  foreach my $test_mode (split(/\s+/, $test_modes)) {
    $line .= sprintf <<EOF;
current_test_mode $test_mode
dft_drc -verbose > ./rpt/post.drc.${test_mode}.rpt
report_scan_path -test_mode $test_mode  > ./rpt/scanpath.${test_mode}.rpt
report_dft_signal -test_mode $test_mode > ./rpt/signal.${test_mode}.rpt

EOF
  }

  $line .= sprintf <<EOF;
report_dft_signal -test_mode all > ./rpt/signal.rpt

# Disable internal pin flow (if applicable) for final post dft drc
set_dft_drc_configuration -internal_pins disable
dft_drc -verbose > ./rpt/post.drc.rpt

EOF

  my $source_post = $Paramref->get_param_value("SCAN_INSERT_source_catchall_post", "relaxed");
  if (&Hydra::Setup::Param::has_value($source_post)) {
    $line .= "# Source catchall post\n";
    $line .= &Hydra::Setup::Flow::write_repeating_param("source", $source_post);
    $line .= "\n";
  }

  $line .= "# Write and close SVF\n";
  $line .= "set_svf -off\n";
  $line .= "\n";

  
  $line .= "# Write test protocol\n";
  foreach my $test_mode (split(/\s+/, $test_modes)) {
    $line .= "write_test_protocol -test_mode $test_mode -o ./output/${design_name}.scan.${test_mode}.spf\n";
  }
  $line .= "\n";

  $line .= sprintf <<EOF;
# Write output files
write -format verilog -hier -output  ./output/${design_name}.scan.v
write_scan_def -output               ./output/${design_name}.scan.def
write_test_model -format ctl -output ./output/${design_name}.scan.ctl
write_test_model -format ddc -output ./output/${design_name}.scan.ctlddc
write -format ddc -output            ./output/${design_name}.scan.ddc
write_sdc                            ./output/${design_name}.scan.sdc

# Report area
report_area -nosplit -hier         > ./rpt/post.area.hier.rpt

# Write black box
remove_design [get_designs -hier *]
remove_cell   [get_cells   -hier *]
remove_net    [get_nets    -hier *]
write -format verilog -hier -output  ./output/${design_name}.black_box.v

echo \"RUN ENDED AT [date]\"

exit

EOF

  $ScriptFile->add_line($line);

  return (@LibFiles, $KickoffFile, $ScriptFile);
}

1;
