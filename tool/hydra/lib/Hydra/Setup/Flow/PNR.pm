#------------------------------------------------------
# Module Name: PNR
# Date:        Tue Feb  5 12:07:08 2019
# Author:      kvu
# Type:        pnr
#------------------------------------------------------
package Hydra::Setup::Flow::PNR;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;
use Digest::MD5 qw(md5_hex);

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------


#++
# Tool: icc2
# Flow: PNR
#--
sub icc2_PNR {
  my ($Paramref, $KickoffFile) = @_;

  my @LibFiles = &Hydra::Setup::Flow::HYDRA::PNR_INIT_LIBRARY($Paramref);

  my @script_file_names = ();
  my @ScriptFiles = ();

  push(@ScriptFiles, &icc2_INIT_DESIGN($Paramref, $KickoffFile));
  push(@ScriptFiles, &icc2_FLOORPLAN($Paramref, $KickoffFile));
  push(@ScriptFiles, &icc2_PLACE($Paramref, $KickoffFile));
  push(@ScriptFiles, &icc2_CTS($Paramref, $KickoffFile));
  push(@ScriptFiles, &icc2_ROUTE($Paramref, $KickoffFile));
  push(@ScriptFiles, &icc2_ROUTE_OPT($Paramref, $KickoffFile));
  push(@ScriptFiles, &icc2_EXPORT($Paramref, $KickoffFile));

  return (@LibFiles, @ScriptFiles);
}

#++
# Tool: icc2
# Flow: INIT_DESIGN
#--
sub icc2_INIT_DESIGN {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/init_design.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/init_design.tcl", "pnr");
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  my $tech_file = $Paramref->get_param_value("INIT_tech_file", "strict");
  $line .= "create_lib db/${design_name}.init_design.nlib \\\n";
  $line .= "  -tech $tech_file \\\n";
  $line .= "  -ref_libs \$NDM\n";
  $line .= "\n";
  
  my $verilog = $Paramref->get_param_value("INIT_verilog", "strict");
  $verilog = &Hydra::Setup::Param::remove_param_value_linebreak($verilog);
  $verilog =~ s/\s+/ /g;
  my $verilog_string = "{" . $verilog . "}";
  $line .= "read_verilog -top $design_name $verilog_string\n";
  $line .= "open_block $design_name\n";
  $line .= "link_block\n";
  $line .= "\n";

#   my $min_tlu       = $Paramref->get_param_value("INIT_min_tluplus_file", "strict");
#   my $min_layer_map = $Paramref->get_param_value("INIT_min_layer_map_file", "strict");
#   my $max_tlu       = $Paramref->get_param_value("INIT_max_tluplus_file", "strict");
#   my $max_layer_map = $Paramref->get_param_value("INIT_max_layer_map_file", "strict");
#   $line .= sprintf <<EOF;
# read_parasitic_tech -tlup $min_tlu -layermap $min_layer_map -name MIN
# read_parasitic_tech -tlup $max_tlu -layermap $max_layer_map -name MAX

# remove_modes -all; remove_corners -all; remove_scenarios -all

# EOF
  # # Get all keysets for tluplus and layer_map
  # my @all_tlu_keysets = ();
  # if ($Paramref->has_param_keysets("INIT_tluplus_file", 1)) {
  #   push(@all_tlu_keysets, $Paramref->get_param_keysets("INIT_tluplus_file", 1));
  # }
  # if ($Paramref->has_param_keysets("INIT_layer_map_file", 1)) {
  #   push(@all_tlu_keysets, $Paramref->get_param_keysets("INIT_layer_map_file", 1));
  # }

  # # Remove duplicate keysets
  # my %found   = ();
  # my @tlu_keysets = ();
  # foreach my $aref_keys (@all_tlu_keysets) {
  #   if (!defined $found{md5_hex(@$aref_keys)}) {
  #     push(@tlu_keysets, $aref_keys);
  #     $found{md5_hex(@$aref_keys)} = 1;
  #   }
  # }

  # Get all keysets defined by SCENARIO
  my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);

  # Get all possible RC corner keys for PNR
  my %rc_corners = ();
  my @rc_keysets = ();
  foreach my $aref_keys (@keysets) {
    my ($mode, $pv, $temp, $rc) = @$aref_keys;
    my $value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);
    if ($value =~ /pnr_slow|pnr_fast|pnr_cts|pnr_setup|pnr_hold|pnr_both/) {
      $rc_corners{$rc} = 1;
    }
  }
  foreach my $rc (sort keys %rc_corners) {
    push(@rc_keysets, [$rc]);
  }
  
  # Get values for each keyset
  my $layer_map_file = $Paramref->get_param_value("INIT_layer_map_file", "strict");
  foreach my $aref_keys (@rc_keysets) {
    my $rc_corner = $aref_keys->[0];
    my $tlu_file  = $Paramref->get_param_value("INIT_tluplus_file", "strict", @$aref_keys);
    $line .= "read_parasitic_tech -tlup $tlu_file -layermap $layer_map_file -name $rc_corner\n";
  }
  $line .= "\n";
  $line .= "remove_modes -all; remove_corners -all; remove_scenarios -all\n";
  $line .= "\n";
  
  # Create modes
  #my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);
  my %created_modes   = ();
  my %created_corners = ();
  my $num_scenarios = 0;
  $line .= "# Create modes\n";
  foreach my $aref_keys (@keysets) {
    my ($mode, $pv, $temp, $rc) = @$aref_keys;
    my $value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);

    if ($value =~ /pnr_slow|pnr_fast|pnr_cts|pnr_setup|pnr_hold|pnr_both/) {
      $num_scenarios++;
      if (!defined $created_modes{$mode}) {
        $line .= "create_mode $mode\n";
        $created_modes{$mode} = 1;
      }
    }
  }
  $line .= "\n";

  # Error if no scenarios were defined
  if ($num_scenarios <= 0) {
    &Hydra::Setup::Control::register_error_param("PNR", "no_scenario");
  }

  # Create corners
  $line .= "# Create corners\n";
  foreach my $aref_keys (@keysets) {
    my ($mode, $pv, $temp, $rc) = @$aref_keys;
    my $corner = "${pv}.${temp}.${rc}";
    my $value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);

    if ($value =~ /pnr_slow|pnr_fast|pnr_cts|pnr_setup|pnr_hold|pnr_both/) {
      my %scenario_tags = &Hydra::Setup::Flow::parse_scenario_value($value);

      if ($scenario_tags{lib_name} eq "") {
        #&Hydra::Setup::Control::register_error_param("SCENARIO(${mode})(${pv})(${temp})(${rc})", "scenario_lib");
        # Use pv and temp combined as lib name if it is not defined
        $scenario_tags{lib_name} = "${pv}${temp}";
      }

      if (!defined $created_corners{$corner}) {
        $line .= "create_corner $corner\n";
        $created_corners{$corner}{lib_name}     = $scenario_tags{lib_name};
        $created_corners{$corner}{corner_speed} = $scenario_tags{corner_speed};
        $created_corners{$corner}{corner_cts}   = $scenario_tags{corner_cts};
        $created_corners{$corner}{rc}           = $rc;
      }
    }
  }
  $line .= "\n";

  # my %slow_corners = ();
  # my %fast_corners = ();
  # foreach my $corner (sort keys %created_corners) {
  #   my $corner_speed = $created_corners{$corner}{corner_speed};
  #   if ($corner_speed =~ /pnr_slow/) {
  #     $slow_corners{$corner} = 1;
  #   }
  #   elsif ($corner_speed =~ /pnr_fast/) {
  #     $fast_corners{$corner} = 1;
  #   }
  # }
  # my $slow_corner_string = join(" ", sort keys %slow_corners);
  # my $fast_corner_string = join(" ", sort keys %fast_corners);
  # $line .= "# Assign parasitics to corners\n";
  # if ($slow_corner_string !~ /^\s*$/) {
  #   $line .= "set_parasitic_parameters -corners $slow_corner_string -early_spec MAX -late_spec MAX\n";
  # }
  # if ($fast_corner_string !~ /^\s*$/) {
  #   $line .= "set_parasitic_parameters -corners $fast_corner_string -early_spec MIN -late_spec MIN\n";
  # }
  # $line .= "\n";
  my %rc_spec = ();
  foreach my $corner (sort keys %created_corners) {
    my $rc = $created_corners{$corner}{rc};
    push(@{ $rc_spec{$rc} }, $corner);
  }
  foreach my $rc (sort keys %rc_spec) {
    my $corner_string = join(" ", @{ $rc_spec{$rc} });
    $line .= "set_parasitic_parameters -corners $corner_string -early_spec $rc -late_spec $rc\n";
  }
  $line .= "\n";
  
  foreach my $aref_keys (@keysets) {
    my ($mode, $pv, $temp, $rc) = @$aref_keys;
    my $corner   = "${pv}.${temp}.${rc}";
    my $scenario = "${mode}.${corner}";
    my $value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);

    if ($value =~ /pnr_slow|pnr_fast|pnr_cts|pnr_setup|pnr_hold|pnr_both/) {
      $line .= "create_scenario -name \"${scenario}\" -mode $mode -corner $corner\n";
    }
  }
  $line .= "\n";

  $line .= "# Explicitly dive into each corner, mode, scenario, and read appropriate SDC(s)\n";
  foreach my $aref_keys (@keysets) {
    my ($mode, $pv, $temp, $rc) = @$aref_keys;
    my $corner   = "${pv}.${temp}.${rc}";
    my $scenario = "${mode}.${corner}";
    my $value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);

    if ($value =~ /pnr_slow|pnr_fast|pnr_cts|pnr_setup|pnr_hold|pnr_both/) {
      my $sdc = $Paramref->get_param_value("INIT_sdc", "strict", @$aref_keys);
      #my $corner_speed = $created_corners{$corner}{corner_speed};

      $line .= "current_mode     \"${mode}\"\n";
      $line .= "current_corner   \"${corner}\"\n";
      $line .= "current_scenario \"${scenario}\"\n";
      $line .= &Hydra::Setup::Flow::write_repeating_param("source -c -e -v", $sdc);
      #if ($corner_speed eq "pnr_slow" || $corner_speed eq "pnr_setup") {
      if ($value =~ /pnr_slow|pnr_setup/) {
        $line .= "set_scenario_status -setup true -hold false [get_scenario ${scenario}]\n";
      }
      #elsif ($corner_speed eq "pnr_fast" || $corner_speed eq "pnr_hold") {
      elsif ($value =~ /pnr_fast|pnr_hold/) {
        $line .= "set_scenario_status -setup false -hold true [get_scenario ${scenario}]\n";
      }
      #elsif ($corner_speed eq "pnr_both") {
      elsif ($value =~ /pnr_both/) {
        $line .= "set_scenario_status -setup true -hold true [get_scenario ${scenario}]\n";
      }
      $line .= "\n";
    }
  }

  foreach my $corner (sort keys %created_corners) {
    my $lib_name = $created_corners{$corner}{lib_name};
    $line .= "current_corner $corner\n";
    $line .= "set_operating_conditions -max $lib_name -min $lib_name\n";
  }
  $line .= "\n";

  my @cts_corners = ();
  foreach my $corner (sort keys %created_corners) {
    if ($created_corners{$corner}{corner_cts}) {
      push(@cts_corners, $corner);
    }
  }
  if (scalar(@cts_corners) > 1) {
    foreach my $corner (@cts_corners) {
      my @tokens = split(/\./, $corner);
      my $param_name = "SCENARIO(" . join(")(", @tokens) . ")";
      &Hydra::Setup::Control::register_error_param($param_name, "cts_corner");
    }
  }
  elsif (scalar(@cts_corners) <= 0) {
    &Hydra::Setup::Control::register_error_param("SCENARIO", "no_cts_corner");
  }
  else {
    $line .= "set_app_options -name cts.compile.primary_corner -value $cts_corners[0]\n";
    $line .= "\n";
  }
  
  $line .= sprintf <<EOF;
save_lib
echo \"RUN ENDED AT [date]\"
exit

EOF

  $ScriptFile->add_line($line);

  return ($ScriptFile);
}

#++
# Tool: icc2
# Flow: FLOORPLAN
#--
sub icc2_FLOORPLAN {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/floorplan.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/floorplan.tcl", "pnr");
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  $line .= "open_lib db/${design_name}.init_design.nlib\n";
  $line .= "open_block $design_name\n";
  $line .= "\n";
  
  my $scan_def = $Paramref->get_param_value("PNR_scan_def", "relaxed");
  if (&Hydra::Setup::Param::has_value($scan_def)) {
    $line .= "read_def $scan_def\n";
    $line .= "\n";
  }

  $line .= sprintf <<EOF;
# infer pg net polarity and assign them based off .lib pin pg_type definitions
# seems to be needed for bump/rdl routing to go through correctly without opens
connect_pg_net -automatic

EOF

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "FLOORPLAN");

  $line .= sprintf <<EOF;
if ![file exists rpt/floorplan] {
  file mkdir rpt/floorplan
}

report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/floorplan/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/floorplan/hold.timing.rpt

report_qor                                 > rpt/floorplan/qor.rpt
report_clock -skew -attribute              > rpt/floorplan/clock.rpt
report_aocvm                               > rpt/floorplan/aocvm.rpt
report_global_timing -significant_digits 3 > rpt/floorplan/global_timing.rpt

save_lib -as db/${design_name}.floorplan.nlib

EOF

  my $frame_view_command = $Paramref->get_param_value("FLOORPLAN_frame_view_command", "relaxed");
  if (&Hydra::Setup::Param::has_value($frame_view_command)) {
    $line .= "$frame_view_command\n";
    $line .= "save_lib -as db/${design_name}.frame.nlib\n";
    $line .= "\n";
  }

  $line .= sprintf <<EOF;
echo \"RUN ENDED AT [date]\"
exit

EOF

  $ScriptFile->add_line($line);
  $ScriptFile->add_dir("rpt/floorplan");

  return ($ScriptFile);
}

#++
# Tool: icc2
# Flow: PLACE
#--
sub icc2_PLACE {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/place.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/place.tcl", "pnr");
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  $line .= "open_lib db/${design_name}.floorplan.nlib\n";
  $line .= "open_block $design_name\n";
  $line .= "\n";

  $line .= sprintf <<EOF;
# placement engine settings
set_app_option  -name place_opt.initial_place.buffering_aware   -value true
set_app_option  -name place_opt.flow.clock_aware_placement      -value true
set_app_option  -name place_opt.congestion.effort               -value medium
set_app_option  -name opt.common.user_instance_name_prefix      -value PLC_OPT_
set_app_option  -name refine_opt.hold.effort                    -value none
set_app_option  -name place.coarse.congestion_driven_max_util   -value 0.7
#set_app_option  -name route.common.global_min_layer_mode        -value hard
set_app_option  -name route.common.global_max_layer_mode        -value hard
#set_app_options -name route.common.net_min_layer_mode           -value hard
set_app_options -name route.common.net_max_layer_mode           -value hard
EOF

  # User app options
  if ($Paramref->has_param_keysets("PLACE_app_options", 1)) {
    my @app_opt_keysets = $Paramref->get_param_keysets("PLACE_app_options", 1);
    foreach my $aref_keys (@app_opt_keysets) {
      my ($name) = @$aref_keys;
      my $value = $Paramref->get_param_value("PLACE_app_options", "strict", @$aref_keys);
      $line .= "set_app_option  -name $name -value $value\n";
    }
  }
  $line .= "\n";

  my $min_routing_layer = $Paramref->get_param_value("PNR_min_routing_layer", "strict");
  my $max_routing_layer = $Paramref->get_param_value("PNR_max_routing_layer", "strict");
  $line .= sprintf <<EOF;
set_ignored_layers \\
  -min_routing_layer $min_routing_layer \\
  -max_routing_layer $max_routing_layer

EOF

  #my $enable_ccd = $Paramref->get_param_value("PNR_enable_ccd", "relaxed");
  my $enable_trial = $Paramref->get_param_value("PLACE_enable_trial_cts", "relaxed");
  if (&Hydra::Setup::Param::is_on($enable_trial)) {
    $line .= "set_app_option  -name place_opt.flow.trial_clock_tree -value true\n";
  }

  my $scan_def = $Paramref->get_param_value("PNR_scan_def", "relaxed");
  if (!&Hydra::Setup::Param::has_value($scan_def)) {
    $line .= "set_app_option  -name place.coarse.continue_on_missing_scandef -value true\n";
  }
  $line .= "\n";

  # Copied from CTS flow  #my $enable_ccd = $Paramref->get_param_value("PNR_enable_ccd", "relaxed");

  my $cell_list = $Paramref->get_param_value("CTS_cell_list", "relaxed");
  if (&Hydra::Setup::Param::has_value($cell_list)) {
    $line .= "# Ensure cts_cells are the only cells used in CTS, period (may need to add icgs, etc)\n";
    $line .= "set CTS_CELL_LIST { \\\n";
    $line .= "$cell_list \\\n";
    $line .= "}\n";
    $line .= "set_lib_cell_purpose -exclude cts   [get_lib_cells]\n";
    $line .= "set_lib_cell_purpose -include none  \$CTS_CELL_LIST\n";
    $line .= "set_lib_cell_purpose -include cts   \$CTS_CELL_LIST\n";
    $line .= "\n";
  }

  # $line .= "# Exclude delay cell usage\n";
  # $line .= "set_lib_cell_purpose -exclude \"optimization cts\" [get_lib_cells */DEL*]\n";
  # $line .= "\n";

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "PLACE");

  my $max_trans = $Paramref->get_param_value("PNR_max_trans", "strict");
  $line .= "set_max_transition $max_trans [current_design]\n";
  $line .= "\n";

  my $ndr_script = $Paramref->get_param_value("PNR_ndr_script", "relaxed");
  if (&Hydra::Setup::Param::has_value($ndr_script)) {
    $line .= "# Define and apply NDRs\n";
    $line .= &Hydra::Setup::Flow::write_repeating_param("source", $ndr_script);
    $line .= "\n";
  }

  my $execute_commands = $Paramref->get_param_value("PLACE_execute_commands", "strict");
  $line .= sprintf <<EOF;
# Do placement
reset_placement
$execute_commands

if ![file exists rpt/place] {
  file mkdir rpt/place
}

report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/place/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/place/hold.timing.rpt

report_qor                                 > rpt/place/qor.rpt
report_clock -skew -attribute              > rpt/place/clock.rpt
report_aocvm                               > rpt/place/aocvm.rpt
report_global_timing -significant_digits 3 > rpt/place/global_timing.rpt

save_lib -as db/${design_name}.place.nlib
echo "RUN ENDED AT [date]"
exit

EOF

  $ScriptFile->add_line($line);
  $ScriptFile->add_dir("rpt/place");

  return ($ScriptFile);
}


#++
# Tool: icc2
# Flow: CTS
#--
sub icc2_CTS {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/cts.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/cts.tcl", "pnr");
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  $line .= "open_lib db/${design_name}.place.nlib\n";
  $line .= "open_block $design_name\n";
  $line .= "\n";

  $line .= sprintf <<EOF;
# CTS engine settings
set_app_options -name time.remove_clock_reconvergence_pessimism -value true
set_app_options -name cts.compile.enable_global_route           -value true
set_app_options -name opt.common.user_instance_name_prefix      -value CTS_OPT_
set_app_options -name cts.common.user_instance_name_prefix      -value CTS_
set_app_options -name custom.route.shield_min_signal_seg        -value 1.0
#set_app_options -name clock_opt.hold.effort                     -value none
EOF

  # User app options
  if ($Paramref->has_param_keysets("CTS_app_options", 1)) {
    my @app_opt_keysets = $Paramref->get_param_keysets("CTS_app_options", 1);
    foreach my $aref_keys (@app_opt_keysets) {
      my ($name) = @$aref_keys;
      my $value = $Paramref->get_param_value("CTS_app_options", "strict", @$aref_keys);
      $line .= "set_app_option  -name $name -value $value\n";
    }
  }
  $line .= "\n";

  my $enable_ccd = $Paramref->get_param_value("PNR_enable_ccd", "relaxed");
  if (&Hydra::Setup::Param::is_on($enable_ccd)) {
    $line .= "# CCD\n";
    $line .= "set_app_options -name clock_opt.flow.enable_ccd -value true\n";
    $line .= "\n";
  }

  my $cell_list = $Paramref->get_param_value("CTS_cell_list", "relaxed");
  if (&Hydra::Setup::Param::has_value($cell_list)) {
    $line .= "# Ensure cts_cells are the only cells used in CTS, period (may need to add icgs, etc)\n";
    $line .= "set CTS_CELL_LIST { \\\n";
    $line .= "$cell_list \\\n";
    $line .= "}\n";
    $line .= "set_lib_cell_purpose -exclude cts   [get_lib_cells]\n";
    $line .= "set_lib_cell_purpose -include none  \$CTS_CELL_LIST\n";
    $line .= "set_lib_cell_purpose -include cts   \$CTS_CELL_LIST\n";
    $line .= "\n";
  }

  # $line .= "# Exclude delay cell usage\n";
  # $line .= "set_lib_cell_purpose -exclude \"optimization cts\" [get_lib_cells */DEL*]\n";
  # $line .= "\n";

  # my $ndr_script = $Paramref->get_param_value("PNR_ndr_script", "relaxed");
  # if (&Hydra::Setup::Param::has_value($ndr_script)) {
  #   $line .= "# Define and apply NDRs\n";
  #   $line .= &Hydra::Setup::Flow::write_repeating_param("source", $ndr_script);
  #   $line .= "\n";
  # }

  $line .= "if ![file exists rpt/cts] {\n";
  $line .= "  file mkdir rpt/cts\n";
  $line .= "}\n";

  $line .= "report_clock_routing_rules > rpt/cts/cts_ndr.rpt\n";
  $line .= "\n";

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "CTS");

  # CTS execute
  my $execute_commands = $Paramref->get_param_value("CTS_execute_commands", "strict");
  $line .= sprintf <<EOF;
# Do CTS
$execute_commands

EOF

  my $shield_ground_net = $Paramref->get_param_value("CTS_shield_gnd_net", "relaxed");
  $line .= "create_shields -align_to_shape_end true";
  if (&Hydra::Setup::Param::has_value($shield_ground_net)) {
    $line .= " -with_ground $shield_ground_net";
  }
  $line .= "\n\n";

  $line .= sprintf <<EOF;
report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/cts/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/cts/hold.timing.rpt

report_qor                                 > rpt/cts/qor.rpt
report_clock_qor                           > rpt/cts/clock_qor.rpt
report_clock -skew -attribute              > rpt/cts/clock.rpt
report_aocvm                               > rpt/cts/aocvm.rpt
report_global_timing -significant_digits 3 > rpt/cts/global_timing.rpt

save_lib -as db/${design_name}.cts.nlib
echo \"RUN ENDED AT [date]\"
exit

EOF

  $ScriptFile->add_line($line);
  $ScriptFile->add_dir("rpt/cts");

  return ($ScriptFile);
}

#++
# Tool: icc2
# Flow: ROUTE
#--
sub icc2_ROUTE {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/route.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/route.tcl", "pnr");
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  $line .= "open_lib db/${design_name}.cts.nlib\n";
  $line .= "open_block $design_name\n";
  $line .= "\n";

  $line .= sprintf <<EOF;
# Route engine settings
set_app_options -name opt.common.user_instance_name_prefix      -value ROUTE_
set_app_options -name route.global.timing_driven                -value true
set_app_options -name route.track.timing_driven                 -value true
set_app_options -name route.detail.timing_driven                -value true
set_app_options -name route.global.crosstalk_driven             -value true
set_app_options -name route.track.crosstalk_driven              -value true
set_app_options -name time.si_enable_analysis                   -value true
set_app_options -name route.common.post_incremental_detail_route_fix_soft_violations -value true
set_app_options -name route.detail.insert_diodes_during_routing -value true
#set_app_option  -name route.common.global_min_layer_mode        -value hard
set_app_option  -name route.common.global_max_layer_mode        -value hard
#set_app_options -name route.common.net_min_layer_mode           -value hard
set_app_options -name route.common.net_max_layer_mode           -value hard

EOF

  my $diode_cell_list = $Paramref->get_param_value("ROUTE_diode_cell_list", "relaxed");
  if (&Hydra::Setup::Param::has_value($diode_cell_list)) {
    $line .= "set DIODE_CELL_LIST { \\\n";
    $line .= "$diode_cell_list \\\n";
    $line .= "}\n";
    $line .= "set_app_options -name route.detail.diode_libcell_names          -value \$DIODE_CELL_LIST\n";
    $line .= "\n";
  }

  my $min_routing_layer = $Paramref->get_param_value("PNR_min_routing_layer", "strict");
  my $max_routing_layer = $Paramref->get_param_value("PNR_max_routing_layer", "strict");
  $line .= sprintf <<EOF;
set_ignored_layers \\
  -min_routing_layer $min_routing_layer \\
  -max_routing_layer $max_routing_layer

EOF

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "ROUTE");
  
  my $execute_commands = $Paramref->get_param_value("ROUTE_execute_commands", "strict");
  $line .= sprintf <<EOF;
# Do route
$execute_commands

if ![file exists rpt/route] {
  file mkdir rpt/route
}

report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/route/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/route/hold.timing.rpt

report_qor                                 > rpt/route/qor.rpt
report_clock -skew -attribute              > rpt/route/clock.rpt
report_aocvm                               > rpt/route/aocvm.rpt
report_global_timing -significant_digits 3 > rpt/route/global_timing.rpt


save_lib -as db/${design_name}.route.nlib
echo \"RUN ENDED AT [date]\"
exit

EOF

  $ScriptFile->add_line($line);
  $ScriptFile->add_dir("rpt/route");

  return ($ScriptFile);
}

#++
# Tool: icc2
# Flow: ROUTE_OPT
#--
sub icc2_ROUTE_OPT {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/route_opt.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/route_opt.tcl", "pnr");
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  $line .= "open_lib db/${design_name}.route.nlib\n";
  $line .= "open_block $design_name\n";
  $line .= "\n";

  $line .= sprintf <<EOF;
# Route engine settings
set_app_options -name opt.common.user_instance_name_prefix      -value ROUTE_OPT_
set_app_options -name route_opt.flow.xtalk_reduction            -value true
set_app_options -name time.si_enable_analysis                   -value true

EOF

  my $enable_ccd = $Paramref->get_param_value("PNR_enable_ccd", "relaxed");
  if (&Hydra::Setup::Param::is_on($enable_ccd)) {
    $line .= "# CCD\n";
    $line .= "set_app_options -name route_opt.flow.enable_ccd   -value true\n";
    $line .= "set_app_options -name route_opt.flow.enable_cto   -value true\n";
    $line .= "\n";
  }

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "ROUTE_OPT");

  my $execute_commands = $Paramref->get_param_value("ROUTE_OPT_execute_commands", "strict");
  $line .= sprintf <<EOF;
# Do route opt
$execute_commands
add_redundant_vias

check_routes
check_lvs -max_errors 0

if ![file exists rpt/route_opt] {
  file mkdir rpt/route_opt
}

report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/route_opt/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/route_opt/hold.timing.rpt

report_qor                                 > rpt/route_opt/qor.rpt
report_clock -skew -attribute              > rpt/route_opt/clock.rpt
report_aocvm                               > rpt/route_opt/aocvm.rpt
report_global_timing -significant_digits 3 > rpt/route_opt/global_timing.rpt

report_constraints -all_violators -nosplit > rpt/all_violators.rpt
report_design -netlist                     > rpt/design.netlist.rpt
report_qor                                 > rpt/qor.rpt
report_clock_qor                           > rpt/clock_qor.rpt
report_congestion                          > rpt/congestion.rpt

save_lib -as db/${design_name}.route_opt.nlib
echo \"RUN ENDED AT [date]\"
exit

EOF

  $ScriptFile->add_line($line);
  $ScriptFile->add_dir("rpt/route_opt");

  return ($ScriptFile);
}

#++
# Tool: icc2
# Flow: EXPORT
#--
sub icc2_EXPORT {
  my ($Paramref, $KickoffFile, $sub_type) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Add command to kickoff
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/export.tcl");
  
  my $ScriptFile = new Hydra::Setup::File("script/export.tcl", "pnr", $sub_type);
  my $line = "";

  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  $line .= "source script/pnr_init_library.tcl\n";

  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  $line .= "\n";

  if (defined $sub_type && $sub_type eq "eco") {
    $line .= "# Search db/ folder for latest eco nlib by name\n";
    $line .= "#   assuming convention of \"eco01a_description\"\n";
    $line .= "source $ENV{HYDRA_HOME}/script/tcl/get_latest_nlib.tcl\n";
    $line .= "open_lib [get_latest_nlib]\n";
  }
  else {
    $line .= "open_lib db/${design_name}.route_opt.nlib\n";
  }
  $line .= "open_block $design_name\n";
  $line .= "\n";

  $ScriptFile->add_line($line);

  $line = &do_icc2_EXPORT($Paramref);
  $ScriptFile->add_line($line);

  return ($ScriptFile);
}

sub do_icc2_EXPORT {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  my $line = "";
  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "EXPORT");

  # Save nlib after source catchall
  $line .= "save_lib -as db/${design_name}.export.nlib\n";
  $line .= "\n";

  my $exclude_cell_list = $Paramref->get_param_value("EXPORT_exclude_cell_list", "relaxed");
  $exclude_cell_list = &Hydra::Setup::Param::remove_param_value_indent($exclude_cell_list);
  $line .= "set EXCLUDE_CELL_LIST { \\\n";
  if (&Hydra::Setup::Param::has_value($exclude_cell_list)) {
    $line .= "$exclude_cell_list \\\n";
  }
  $line .= "}\n";
  $line .= "\n";

  my $views = $Paramref->get_param_value("EXPORT_views", "strict");
  $views = &Hydra::Setup::Param::remove_param_value_linebreak($views);
  my %views = map {$_ => 1} split(/\s+/, $views);

  if (defined $views{sta}) {
    $line .= sprintf <<EOF;
write_verilog \\
  -include {pad_cells scalar_wire_declarations} \\
  ./output/${design_name}.v

write_verilog \\
  -include {pg_objects pad_cells} \\
  ./output/${design_name}.pwr.v

EOF
  }

  if (defined $views{def}) {
    $line .= sprintf <<EOF;
write_def \\
  ./output/${design_name}.def

EOF
  }

  if (defined $views{fullchip_gds}) {
        my $gds_tech_map = $Paramref->get_param_value("EXPORT_gds_tech_map", "strict");
    $line .= sprintf <<EOF;
write_gds \\
  -compress \\
  -long_names  \\
  -layer_map $gds_tech_map \\
  -merge_files \$GDS_FULLCHIP \\
  -merge_gds_top_cell  ${design_name} \\
  ./output/${design_name}.fullchip.gds.gz

EOF
  }

  if (defined $views{rc}) {
    $line .= sprintf <<EOF;
write_parasitics -compress -output output/${design_name}

EOF
  }

  my $abs_view_command = $Paramref->get_param_value("EXPORT_abstract_view_command", "relaxed");
  if (&Hydra::Setup::Param::has_value($abs_view_command)) {
    $line .= "$abs_view_command\n";
    $line .= "save_lib -as db/${design_name}.abstract.nlib\n";
    $line .= "\n";
  }

  if (defined $views{lvs}) {
    my $gds_tech_map = $Paramref->get_param_value("EXPORT_gds_tech_map", "strict");
    $line .= sprintf <<EOF;
write_gds \\
  -compress \\
  -long_names  \\
  -layer_map $gds_tech_map \\
  -merge_files \$GDS \\
  -merge_gds_top_cell  ${design_name} \\
  ./output/${design_name}.gds.gz

write_verilog \\
  -force_no_reference \$EXCLUDE_CELL_LIST \\
   -exclude {empty_modules leaf_module_declarations scalar_wire_declarations supply_statements} \\
  ./output/${design_name}.lvs.v

EOF
  }


  my $remove_cells = $Paramref->get_param_value("EXPORT_lvs_remove_cells", "relaxed");
  if (&Hydra::Setup::Param::has_value($remove_cells)) {
    $remove_cells = &Hydra::Setup::Param::remove_param_value_linebreak($remove_cells);
    $remove_cells =~ s/\s+/ /g;

    my $gds_tech_map = $Paramref->get_param_value("EXPORT_gds_tech_map", "strict");
    $line .= sprintf <<EOF;
remove_cells \"$remove_cells\"

write_gds \\
  -compress \\
  -long_names  \\
  -layer_map $gds_tech_map \\
  -merge_files \$GDS \\
  -merge_gds_top_cell  ${design_name} \\
  ./output/${design_name}.remove_cells.gds.gz

write_verilog \\
  -force_no_reference \$EXCLUDE_CELL_LIST \\
   -exclude {empty_modules leaf_module_declarations scalar_wire_declarations supply_statements} \\
  ./output/${design_name}.remove_cells.lvs.v

EOF
  }

  $line .= sprintf <<EOF;
echo \"RUN ENDED AT [date]\"
exit

EOF

  return $line;
}


#++
# Tool: icc2
# Flow: ECO
# Subtype: eco
#--
sub icc2_ECO {
  my ($Paramref, $KickoffFile) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");
  my $eco_name    = $Paramref->get_name;
  my @Files = ();

  # Add command for this script to kickoff file
  my $tool_command = &Hydra::Setup::Tool::get_tool_command($Paramref, "pnr", "script/eco.${eco_name}.tcl");
  $KickoffFile->add_line($tool_command);

  my $File = new Hydra::Setup::File("script/eco.${eco_name}.tcl", "pnr", "eco");
  push(@Files, $File);
  my $line = "";
  $line .= "echo \"RUN STARTED AT [date]\"\n";
  
  my $host_options = $Paramref->get_param_value("PNR_host_options", "relaxed");
  if (&Hydra::Setup::Param::has_value($host_options)) {
    $line .= "set_host_options $host_options\n";
  }

  my $db = $Paramref->get_param_value("ECO_db", "strict");
  $line .= "open_lib   ${db}\n";
  $line .= "open_block ${design_name}\n";
  $line .= "\n";

  my $eco_script = $Paramref->get_param_value("ECO_script", "strict");
  $line .= &Hydra::Setup::Flow::write_repeating_param("source", $eco_script);
  $line .= "\n";

  $line .= sprintf <<EOF;
place_eco_cells -unplaced_cells
legalize_placement -incremental
route_eco 

connect_pg_net -auto
check_routes
check_lvs -max_errors 0

save_lib -as db/${design_name}.${eco_name}.nlib

if ![file exists rpt/eco] {
  file mkdir rpt/eco
}

report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/eco/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/eco/hold.timing.rpt

report_qor                                 > rpt/eco/qor.rpt
report_clock -skew -attribute              > rpt/eco/clock.rpt
report_aocvm                               > rpt/eco/aocvm.rpt
report_global_timing -significant_digits 3 > rpt/eco/global_timing.rpt

report_constraints -all_violators -nosplit > rpt/eco/all_violators.rpt
report_design -netlist                     > rpt/eco/design.netlist.rpt
report_clock_qor                           > rpt/eco/clock_qor.rpt
report_congestion                          > rpt/eco/congestion.rpt

exit

EOF

  $File->add_line($line);
  $File->add_dir("rpt/eco");

  # INIT LIB
  push(@Files, &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "pnr", "eco"));

  # EXPORT
  push(@Files, &icc2_EXPORT($Paramref, $KickoffFile, "eco"));

  return @Files;
}


=pod



=head1 icc2 PNR

=over

=item SCENARIO

Specify the scenarios that will be run. Use param keys for mode, process, temperature, and RC corner. The param key order matters. The value is a space-delimited list indicating what flow types the scenario is valid for. Use "pnr_slow", "pnr_fast", "pnr_setup", "pnr_hold", or "pnr_both" for PNR to indicate whether the scenario is a setup or hold corner. The values "pnr_slow" and "pnr_setup" are equivalent, as are "pnr_fast" and "pnr_hold". The value "pnr_hold" is both setup and hold. Use "pnr_cts" to indicate that the scenario should be used for CTS. The process and temperature name should be selected such that they match the actual library name when appended together.
 SCENARIO(<mode>)(<process>)(<temp>)(<rc>) = <value>
 SCENARIO(func)(ff_0p99)(125c)(cbest) = pnr_fast pnr_cts

=item PNR_host_options

Used for setting host options.

=item PNR_scan_def

The scan def file, if the design is scan inserted.

=item PNR_max_trans

Set the max transition.

=item PNR_enable_ccd

Enables the concurrent clock and data optimization flow.

=item PNR_min_routing_layer

The minimum layer number used for routing.

=item PNR_max_routing_layer

The maximum layer number used for routing.

=item PNR_ndr_script

A script containing commands (create_routing_rule, set_clock_routing_rules) for non-default rule creation.

=back



=head1 icc2 INIT_DESIGN

=over

=item INIT_sdc

One or more timing constraint files.

=item INIT_tluplus_file

The tluplus file containing RC parasitics. This MUST be defined with a param key that matches the RC corner.

 INIT_tluplus_file(cworst_T) = 6x2z_cworst_T.tluplus
 INIT_tluplus_file(cbest)    = 6x2z_cbest.tluplus

=item INIT_verilog

The synthesized netlist.

=item INIT_tech_file

The technology file.

=item INIT_layer_map_file

The layer map file. Maps technology file layer names to the ITF layer name. 

=back



=head1 icc2 FLOORPLAN

=over

=item FLOORPLAN_source_catchall_global

A space-delimited list of misc source scripts.

=item FLOORPLAN_source_catchall_local

A space-delimited list of misc source scripts.

=item FLOORPLAN_frame_view_command

Command to create frame view. Optional.

=back



=head1 icc2 PLACE

=over

=item PLACE_execute_commands

The primary placement execution command(s). Default=place_opt.

=item PLACE_app_options

Define extra app options. Use param keys.
 PLACE_app_options(<opt_name>) = <value>

=item PLACE_source_catchall_local

A space-delimited list of misc source scripts.

=item PLACE_source_catchall_global

A space-delimited list of misc source scripts.

=item PLACE_enable_trial_cts

Turns on the clock tree synthesis trial flow.

=item CTS_cell_list 

A space-delimited list of library cells that are allowed to be used during clock tree synthesis. Used for trial CTS during PLACE (place_opt.flow.clock_aware_placement).

=back



=head1 icc2 CTS

=over

=item CTS_app_options

Define extra app options. Use param keys.
 CTS_app_options(<opt_name>) = <value>

=item CTS_execute_commands

The primary clock tree synthesis execution command(s). Default=clock_opt.

=item CTS_source_catchall_global

A space-delimited list of misc source scripts.

=item CTS_source_catchall_local 

A space-delimited list of misc source scripts.

=item CTS_cell_list 

A space-delimited list of library cells that are allowed to be used during clock tree synthesis.

=item CTS_shield_gnd_net

Specify the ground net that shielding wires are tied to. You should only need to specify this if you have multiple ground nets; otherwise, the connection is done by default.

=back



=head1 icc2 ROUTE

=over

=item ROUTE_diode_cell_list

A space-delimited list of diode library cells to be used for antenna fixing.

=item ROUTE_source_catchall_local

A space-delimited list of misc source scripts.

=item ROUTE_source_catchall_global

A space-delimited list of misc source scripts.

=item ROUTE_execute_commands

The primary route execution command(s). Default=route_auto.

=back



=head1 icc2 ROUTE_OPT

=over

=item ROUTE_OPT_execute_commands

The primary route opt execution command(s). Default=route_opt.

=item ROUTE_OPT_source_catchall_global

A space-delimited list of misc source scripts.

=item ROUTE_OPT_source_catchall_local

A space-delimited list of misc source scripts.

=back



=head1 icc2 EXPORT

=over

=item EXPORT_source_catchall_local

A space-delimited list of misc source scripts.

=item EXPORT_source_catchall_global

A space-delimited list of misc source scripts.

=item EXPORT_exclude_cell_list

A space-delimited list of library cells to exclude from the final output netlist.

=item EXPORT_gds_tech_map

The GDS layer map file. Maps layer data between the tool and GDS.

=item EXPORT_abstract_view_command

Command to create abstract view. Optional.

=item EXPORT_lvs_remove_cells

A space-delimited list of instances to remove from the lvs verilog and GDS. A separate verilog and GDS (with no blocks merged) are written in addition to those written by the "lvs" view in EXPORT_views.

=item EXPORT_views

Control the output files that are generated. The valid options are:

 sta          - verilog and power verilog
 def          - def file
 lvs          - gds and lvs verilog
 rc           - spef file
 fullchip_gds - gds with block gds merged

=back



=head1 icc2 ECO

=over

=item ECO_db

The icc2 nlib that will have the eco applied.

=item ECO_script

The eco script that will be applied.

=back

=cut


1;
