#------------------------------------------------------
# Module Name: STA
# Date:        Mon Feb  4 11:28:00 2019
# Author:      kvu
# Type:        sta
#------------------------------------------------------
package Hydra::Setup::Flow::STA;

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
# Tool: pt
# Flow: STA
#--
sub pt_STA {
  my ($Paramref, $KickoffFile, $subtype) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  my @LibFiles;
  if (defined $subtype && $subtype =~ /fullchip/) {
    # Full STA runs use block spef/netlist
    @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "sta", $subtype);
  }
  else {
    # Non-fullchip STA runs get the block lib/db list
    @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY_BLOCK($Paramref, "sta", $subtype);
  }

  # Interface timing margin flow
  my $enable_margin = "";
  if (defined $subtype && $subtype =~ /fullchip/) {
    $enable_margin = $Paramref->get_param_value("STA_FULLCHIP_enable_margin_report", "relaxed");
  }
  my %scenario_sets = ();

  # Get all scenarios from SCENARIO param
  my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);
  my @ScriptFiles = ();
  my @script_file_names = ();
  my @missing_spefs = ();
  my $num_scenarios = 0;
  my @scenarios = ();
  my $sta_lib = 0;
  foreach my $aref_keys (sort { "$a->[0].$a->[1].$a->[2].$a->[3]" cmp "$b->[0].$b->[1].$b->[2].$b->[3]" } @keysets) {
    my $scenario_value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);
    my %scenario_tags  = &Hydra::Setup::Flow::parse_scenario_value($scenario_value);
    my $sta_tag = "sta";
    if (defined $subtype && $subtype =~ /fullchip/) {
      $sta_tag = "sta_fullchip";
    }
    next if (!$scenario_tags{$sta_tag});
    $num_scenarios++;

    my ($mode, $process, $temp, $rc) = @$aref_keys;
    my $scenario_name = "${mode}.${process}.${temp}.${rc}";
    push(@scenarios, $scenario_name);

    my $File = new Hydra::Setup::File("script/${scenario_name}.sta.tcl", "sta", $subtype);
    push(@ScriptFiles, $File);
    push(@script_file_names, "script/${scenario_name}.sta.tcl");
    my $line = "";

    my $db_var  = &Hydra::Setup::Flow::HYDRA::get_lib_var($Paramref, "db", $process, $temp);

    $line .= sprintf <<EOF;
set MODE $mode
set PV   $process
set TEMP $temp
set RC   $rc

source script/sta_init_library.tcl
set link_path [concat * \$$db_var]

EOF

    $line .= "# Read Verilog\n";
    if (defined $subtype && $subtype eq "fullchip") {
      my $verilog = $Paramref->get_param_value("STA_FULLCHIP_verilog", "strict", @$aref_keys);
      $line .= &Hydra::Setup::Flow::write_repeating_param("read_verilog", $verilog);
    }
    else {
      my $verilog = $Paramref->get_param_value("STA_verilog", "strict", @$aref_keys);
      $line .= &Hydra::Setup::Flow::write_repeating_param("read_verilog", $verilog);
    }
    $line .= "current_design $design_name\n";
    $line .= "link_design    $design_name\n";
    $line .= "\n";

    # Block-level spefs
    # Default spef location can be overridden by STA_spef_commands
    my $block_spef_commands = $Paramref->get_param_value("STA_spef_commands", "relaxed", ($temp, $rc));
    $line .= "# Read spef\n";
    if (&Hydra::Setup::Param::has_value($block_spef_commands)) {
      $line .= "$block_spef_commands\n";
    }
    else {
      $line .= "read_parasitics -keep_capacitive_coupling -format spef ../rc_extract/output/${design_name}.${rc}.${temp}.spef.gz\n";
    }
    if (defined $subtype && $subtype eq "fullchip") {
      # Top-level spefs
      # Default spef location can be overriden by STA_FULLCHIP_spef_commands
      my $top_spef_commands = $Paramref->get_param_value("STA_FULLCHIP_spef_commands", "relaxed", ($temp, $rc));
      if (&Hydra::Setup::Param::has_value($top_spef_commands)) {
        $line .= "$top_spef_commands\n";
      }
      else {
        my $proj_home = $Paramref->get_param_value("HYDRA_proj_home", "strict");
        my @keysets = $Paramref->get_param_keysets("STA_FULLCHIP_spef_blocks", 1);
        foreach my $aref_keys (@keysets) {
          my $block_name = $aref_keys->[0];
          my $block_path = $Paramref->get_param_value("STA_FULLCHIP_spef_blocks", "relaxed", @$aref_keys);
          if (&Hydra::Setup::Param::has_value($block_path)) {
            if ($block_path =~ /\S\s+\S/) {
              $block_path = "{${block_path}}";
            }
            my $block_spef = "${proj_home}/DATA/${block_name}/spef/${block_name}.${rc}.${temp}.spef.gz";
            $line .= "read_parasitics -keep_capacitive_coupling -pin_cap_included -format spef -path ${block_path} ${block_spef}\n";
          }
        }
      }
      $line .= "\n";
    }
    $line .= "\n";

    # AOCV
    my $aocv = $Paramref->get_param_value("STA_aocv", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($aocv)) {
      $line .= &Hydra::Setup::Flow::write_repeating_param("read_ocvm", $aocv);
      $line .= "set timing_aocvm_enable_analysis true\n";
      $line .= "\n";
    }

    # Sdc
    $line .= "# Read sdc\n";
    if (defined $subtype && $subtype eq "fullchip") {
      my $sdc = $Paramref->get_param_value("STA_FULLCHIP_sdc", "strict", ($mode));
      $line .= &Hydra::Setup::Flow::write_repeating_param("source", $sdc);
    }
    else {
      my $sdc = $Paramref->get_param_value("STA_sdc", "strict", ($mode));
      $line .= &Hydra::Setup::Flow::write_repeating_param("source", $sdc);
    }
    $line .= "\n";

    $line .= sprintf <<EOF;
set_app_var si_enable_analysis true
set_app_var si_xtalk_double_switching_mode full_design

# Propagate all clocks
set_propagated_clock [all_clocks]

EOF

    # Source catchalls
    $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "STA", @$aref_keys);
    
    # my $source_post = $Paramref->get_param_value("STA_source_catchall_post", "relaxed", @$aref_keys);
    # if (&Hydra::Setup::Param::has_value($source_post)) {
    #   $line .= "\# post source catchalls, useful for things like reading in latency files from innovus or things that require actual clocks\n";
    #   $line .= "\# source catchall post design readin\n";
    # }
    # $line .= &Hydra::Setup::Flow::write_repeating_param("source", $source_post);
    # $line .= "\n";

    $line .= "update_timing\n";
    $line .= "\n";

    $line .= sprintf <<EOF;
if ![file exists rpt/$scenario_name] {
  file mkdir rpt/$scenario_name
}

EOF

    if (defined $subtype && $subtype =~ /fullchip/ &&
        &Hydra::Setup::Param::is_on($enable_margin)) {
      # Group all interface timing paths
      $line .= "# Group block interfacing timing paths\n";
      my $block_list = $Paramref->get_param_value("STA_FULLCHIP_margin_blocks", "strict");
      $block_list = &Hydra::Setup::Param::remove_param_value_linebreak($block_list);
      foreach my $block (split(/\s+/, $block_list)) {
        my $group_name = $block;
        $group_name =~ s/\//__/g;
        $group_name .= "_INTERFACE";
        $line .= "group_path -name ${group_name} -through [get_pins -of ${block}]\n";
      }
      $line .= "\n";
    }

    $line .= sprintf <<EOF;
save_session db/${scenario_name}.timing.session

# Reports
report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/${scenario_name}/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/${scenario_name}/hold.timing.rpt
report_timing -delay_type min_max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/${scenario_name}/dmsa.timing.rpt

#report_timing -delay_type max -max_paths 1000 -nworst 1 -crosstalk_delta                          > rpt/${scenario_name}/setup.timing.rpt
#report_timing -delay_type min -max_paths 1000 -nworst 1 -crosstalk_delta                          > rpt/${scenario_name}/hold.timing.rpt
#report_timing -crosstalk_delta -slack_lesser_than 0.0 -delay min_max -nosplit -input -net -sign 4 > rpt/${scenario_name}/dmsa.timing.rpt
report_qor                                                                                        > rpt/${scenario_name}/qor.rpt
report_clock -skew -attribute                                                                     > rpt/${scenario_name}/clock.rpt
report_aocvm                                                                                      > rpt/${scenario_name}/aocvm.rpt
#report_cell_usage -pattern_priority \$leakage_pattern_priority_list                                > rpt/${scenario_name}/pre_leakage_eco_cell_usage.rpt
report_noise -nosplit -all_violators -above -low                                                  > rpt/${scenario_name}/noise.all_above_low.rpt
report_noise -nosplit -all_violators -below -high                                                 > rpt/${scenario_name}/noise.all_below_high.rpt
report_global_timing -delay_type max -significant_digits 3                                        > rpt/${scenario_name}/setup.global_timing.rpt
report_global_timing -delay_type min -significant_digits 3                                        > rpt/${scenario_name}/hold.global_timing.rpt
report_constraint -nosplit -all_violators -significant_digits 3                                   > rpt/${scenario_name}/all_constraint_violators.rpt
report_constraint -nosplit -all_violators -max_transition -significant_digits 3                   > rpt/${scenario_name}/max_trans.rpt
report_constraint -nosplit -all_violators -max_capacitance -significant_digits 3                  > rpt/${scenario_name}/max_cap.rpt
report_constraint -nosplit -all_violators -min_pulse_width -significant_digits 3                  > rpt/${scenario_name}/min_pulse.rpt
report_si_double_switching -nosplit                                                               > rpt/${scenario_name}/double_switching.rpt
report_annotated_parasitics                                                                       > rpt/${scenario_name}/annotated_parasitics.rpt
report_analysis_coverage                                                                          > rpt/${scenario_name}/analysis_coverage.rpt

report_global_timing -format {narrow} -significant_digits 3                                       > rpt/${scenario_name}/global_timing.narrow.rpt
report_global_timing -format {wide csv} -significant_digits 3                                     > rpt/${scenario_name}/global_timing.csv

check_timing -verbose -significant_digits 3                                                       > rpt/${scenario_name}/check_timing.rpt

EOF

    if ($scenario_tags{sta_sdf}) {
      $line .= "write_sdf -input_port_nets -output_port_nets -context verilog -significant_digit 4 -version 3.0 -include {SETUPHOLD RECREM} -compress gzip output/${design_name}.${process}.${temp}.${rc}.sdf\n";
      $line .= "\n";
    }

    if ($scenario_tags{sta_lib}) {
      $line .= "extract_model -format lib -output output/${design_name}.${process}.${temp}.${rc}\n";
      $line .= "\n";
      $sta_lib = 1;
    }

    # Interface timing margin flow
    if (defined $subtype && $subtype =~ /fullchip/ &&
        &Hydra::Setup::Param::is_on($enable_margin)) {
      # Report timing through all blocks
      my $block_list = $Paramref->get_param_value("STA_FULLCHIP_margin_blocks", "strict");
      $block_list = &Hydra::Setup::Param::remove_param_value_linebreak($block_list);
      
      # Global timing for each block group
      $line .= "# Block interface global timing reports\n";
      foreach my $block (split(/\s+/, $block_list)) {
        my $group_name = $block;
        $group_name =~ s/\//__/g;
        $group_name .= "_INTERFACE";
        $line .= "report_global_timing -group ${group_name} -significant_digits 3  > rpt/${scenario_name}/${group_name}.global_timing.rpt\n";
      }
      $line .= "\n";
      
      # Report timing for each block pin
      foreach my $block (split(/\s+/, $block_list)) {
        my $block_nickname = $block;
        $block_nickname =~ s/\//__/g;
### START new margin flow
        $line .= sprintf <<EOF;
# ${block} interface timing
set fh_setup [open "rpt/${scenario_name}/${block_nickname}.setup.margin.rpt" w]
set fh_hold  [open "rpt/${scenario_name}/${block_nickname}.hold.margin.rpt" w]
foreach_in_collection block_pin_obj [get_pins -of ${block}] {
  set block_pin      [get_object_name \$block_pin_obj]
  set ref_setup_path [get_timing_paths -delay_type max -max_paths 1 -nworst 1 -slack_lesser_than 1.000 -through \$block_pin]
  set ref_hold_path  [get_timing_paths -delay_type min -max_paths 1 -nworst 1 -slack_lesser_than 1.000 -through \$block_pin]

  set ref_setup_slack      [get_attribute \$ref_setup_path slack]
  set ref_setup_startpoint [get_attribute \$ref_setup_path startpoint.full_name]
  set ref_setup_endpoint   [get_attribute \$ref_setup_path endpoint.full_name]
  puts \$fh_setup "\$block_pin \$ref_setup_slack \$ref_setup_startpoint \$ref_setup_endpoint"

  set ref_hold_slack       [get_attribute \$ref_hold_path slack]
  set ref_hold_startpoint  [get_attribute \$ref_hold_path startpoint.full_name]
  set ref_hold_endpoint    [get_attribute \$ref_hold_path endpoint.full_name]
  puts \$fh_hold "\$block_pin \$ref_hold_slack \$ref_hold_startpoint \$ref_hold_endpoint"
}
close \$fh_setup
close \$fh_hold

EOF
### END new margin flow

        ### DEBUG for new margin flow
        # use Cwd;
        # my $dir = cwd;
        # &Hydra::Util::File::make_dir("${dir}/fullchip_sta_no_vcore/sta_fullchip/rpt/${scenario_name}");
        # my $fh_setup = &Hydra::Util::File::open_file_for_write("${dir}/fullchip_sta_no_vcore/sta_fullchip/rpt/${scenario_name}/${block_nickname}.setup.margin.rpt");
        # my $fh_hold = &Hydra::Util::File::open_file_for_write("${dir}/fullchip_sta_no_vcore/sta_fullchip/rpt/${scenario_name}/${block_nickname}.hold.margin.rpt");
        # foreach my $index (0..50) {
        #   my $setup_slack = sprintf "%.3f", rand(2) - 1;
        #   my $hold_slack  = sprintf "%.3f", rand(2) - 1;
        #   print $fh_setup "PIN${index} $setup_slack START${index} END${index}\n";
        #   print $fh_hold  "PIN${index} $hold_slack START${index} END${index}\n";
        # }
        # &Hydra::Util::File::close_file($fh_setup);
        # &Hydra::Util::File::close_file($fh_hold);
        ###

### START old margin flow
#         $line .= sprintf <<EOF;
# # ${block} interface timing
# report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
#   -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 -through [get_pins -of ${block}] > rpt/${scenario_name}/${block_nickname}.setup.timing.rpt
# report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
#   -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 -through [get_pins -of ${block}] > rpt/${scenario_name}/${block_nickname}.hold.timing.rpt

# EOF
### END old margin flow
      }
    }

    $line .= "exit\n";
    $File->add_line($line);

    # Interface timing margin flow
    if (defined $subtype && $subtype =~ /fullchip/ &&
        &Hydra::Setup::Param::is_on($enable_margin)) {
      my $set_name = "all";
      if (defined $scenario_tags{sta_margin} && $scenario_tags{sta_margin} ne "") {
        $set_name = $scenario_tags{sta_margin};
      }
      $scenario_sets{$set_name}{$scenario_name} = 1;
    }
  }

  # Warn if block spefs are missing
  my %dup = map {$_ => 1} @missing_spefs;
  @missing_spefs = sort keys %dup;
  if (scalar(@missing_spefs) > 0) {
    warn "WARN: Could not find the following block spefs for STA:\n";
    foreach my $block_spef (@missing_spefs) {
      warn "  $block_spef\n";
    }
  }

  # Error if no scenarios were defined
  if ($num_scenarios <= 0) {
    my $err_flow_name = "STA";
    if (defined $subtype && $subtype =~ /fullchip/) {
      $err_flow_name = "STA_FULLCHIP";
    }
    &Hydra::Setup::Control::register_error_param($err_flow_name, "no_scenario");
  }

  # Run scripts
  foreach my $script_name (@script_file_names) {
    &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, $script_name);
  }

  # Interface timing margin flow
  if (defined $subtype && $subtype =~ /fullchip/ &&
      &Hydra::Setup::Param::is_on($enable_margin)) {
    ### START new margin flow
    my $block_list      = $Paramref->get_param_value("STA_FULLCHIP_margin_blocks", "strict");
    my $skip_pins       = $Paramref->get_param_value("STA_FULLCHIP_margin_skip_pins", "relaxed");
    my $pt_shell        = $Paramref->get_param_value("HYDRA_sta_bin", "strict");
    $block_list = &Hydra::Setup::Param::remove_param_value_linebreak($block_list);
    $block_list =~ s/\//__/g;

    # Dont use "all" set if user sets are defined
    if (scalar(keys %scenario_sets) > 1) {
      delete $scenario_sets{all};
    }

    foreach my $set_name (sort keys %scenario_sets) {
      # Report margin timing
      my $kickoff_command = "$ENV{HYDRA_HOME}/hydra.pl report_interface_margin -set $set_name -rpt_dir ./rpt -blocks $block_list -pt_shell $pt_shell";
      if (&Hydra::Setup::Param::has_value($skip_pins)) {
        $skip_pins  = &Hydra::Setup::Param::remove_param_value_linebreak($skip_pins);
        $skip_pins  =~ s/\s+/ /g;
        $kickoff_command .= " -skip $skip_pins";
      }

      $kickoff_command .= " -scenarios \\\n";
      foreach my $scenario (sort keys %{ $scenario_sets{$set_name} }) {
        $kickoff_command .= "  $scenario \\\n";
      }

      $kickoff_command .= " |& tee log/${set_name}.report_margin.log";
      $KickoffFile->add_line("");
      $KickoffFile->add_line($kickoff_command);
    }
    ### END new margin flow
    
    ### START old margin flow
    # my $block_list      = $Paramref->get_param_value("STA_FULLCHIP_margin_blocks", "strict");
    # my $slack_threshold = $Paramref->get_param_value("STA_FULLCHIP_margin_slack_threshold", "relaxed");
    # my $mode            = $Paramref->get_param_value("STA_FULLCHIP_margin_mode", "relaxed");
    # my $skip_pins       = $Paramref->get_param_value("STA_FULLCHIP_margin_skip_pins", "relaxed");
    # my $pt_shell        = $Paramref->get_param_value("HYDRA_sta_bin", "strict");
    # $block_list = &Hydra::Setup::Param::remove_param_value_linebreak($block_list);
    # $block_list =~ s/\//__/g;

    # # Dont use "all" set if user sets are defined
    # if (scalar(keys %scenario_sets) > 1) {
    #   delete $scenario_sets{all};
    # }

    # foreach my $set_name (sort keys %scenario_sets) {
    #   # Report margin timing
    #   my $kickoff_command = "$ENV{HYDRA_HOME}/hydra.pl report_interface_timing_margin -set $set_name -rpt_dir ./rpt -blocks $block_list -pt_shell $pt_shell";
    #   if (&Hydra::Setup::Param::has_value($mode)) {
    #     $kickoff_command .= " -mode $mode";
    #   }
    #   if (&Hydra::Setup::Param::has_value($slack_threshold)) {
    #     $kickoff_command .= " -slack_threshold $slack_threshold";
    #   }
    #   if (&Hydra::Setup::Param::has_value($skip_pins)) {
    #     $skip_pins  = &Hydra::Setup::Param::remove_param_value_linebreak($skip_pins);
    #     $skip_pins  =~ s/\s+/ /g;
    #     $kickoff_command .= " -skip $skip_pins";
    #   }

    #   $kickoff_command .= " -scenarios \\\n";
    #   foreach my $scenario (sort keys %{ $scenario_sets{$set_name} }) {
    #     $kickoff_command .= "  $scenario \\\n";
    #   }

    #   $kickoff_command .= " |& tee log/report_margin.log";
    #   $KickoffFile->add_line("");
    #   $KickoffFile->add_line($kickoff_command);
    # }

    # $KickoffFile->add_linebreak;
    # $KickoffFile->add_line("# Margin scripts to be generated by report_interface_timing_margin above");
    # foreach my $set_name (sort keys %scenario_sets) {
    #   $KickoffFile->add_line("./HYDRA.${set_name}.margin");
    # }
    
    # foreach my $set_name (sort keys %scenario_sets) {
    #   # Process margin timing
    #   my $kickoff_command = "$ENV{HYDRA_HOME}/hydra.pl process_interface_timing_margin -set $set_name -rpt_dir ./rpt -scenarios \\\n";
    #   foreach my $scenario (sort keys %{ $scenario_sets{$set_name} }) {
    #     $kickoff_command .= "  $scenario \\\n";
    #   }
    #   $kickoff_command .= "|& tee log/process_margin.log";
    #   $KickoffFile->add_line("");
    #   $KickoffFile->add_line($kickoff_command);
    # }
    ### END old margin flow
  }

  if ($sta_lib) {
    my $lc_shell = $Paramref->get_param_value("STA_lc_bin", "strict");
    $KickoffFile->add_line("");
    $KickoffFile->add_line("$ENV{HYDRA_HOME}/hydra.pl convert_lib -dir ./output -lc_shell $lc_shell |& tee log/convert_lib.log");
  }

  return (@LibFiles, @ScriptFiles, $KickoffFile);
}

#++
# Tool: pt
# Flow: STA_DMSA
# Subtype: dmsa
#--
sub pt_STA_DMSA {
  my ($Paramref, $KickoffFile, $subtype) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Use dmsa as subtype if subtype is not given
  # dmsa should always be prepended to any subtype given to this flow
  if (!defined $subtype) {
    $subtype = "dmsa";
  }

  my @LibFiles;
  if (defined $subtype && $subtype =~ /fullchip/) {
    # Full STA runs use block spef/netlist
    @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "sta", $subtype);
  }
  else {
    # Non-fullchip STA runs get the block lib/db list
    @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY_BLOCK($Paramref, "sta", $subtype);
  }
  
  my @ScriptFiles       = ();
  my $TopFile  = new Hydra::Setup::File("script/dmsa.sta.tcl", "sta", $subtype);
  push(@ScriptFiles, $TopFile);
  my $top_line = "";

  # Get all scenarios from SCENARIO param
  my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);
  my @missing_spefs = ();
  my $num_scenarios = 0;
  foreach my $aref_keys (sort { "$a->[0].$a->[1].$a->[2].$a->[3]" cmp "$b->[0].$b->[1].$b->[2].$b->[3]" } @keysets) {
    my $scenario_value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);
    my %scenario_tags  = &Hydra::Setup::Flow::parse_scenario_value($scenario_value);
    my $dmsa_tag = "sta_dmsa";
    if (defined $subtype && $subtype =~ /fullchip/) {
      $dmsa_tag = "sta_dmsa_fullchip";
    }
    next if (!$scenario_tags{$dmsa_tag});
    $num_scenarios++;

    my ($mode, $process, $temp, $rc) = @$aref_keys;
    my $scenario_name = "${mode}.${process}.${temp}.${rc}";

    # Write to top dmsa.tcl
    $top_line .= sprintf <<EOF;
create_scenario \\
    -mode          ${mode} \\
    -corner        ${process}.${temp}.${rc} \\
    -specific_data script/${scenario_name}.sta.tcl

EOF

    my $File = new Hydra::Setup::File("script/${scenario_name}.sta.tcl", "sta", $subtype);
    push(@ScriptFiles, $File);
    my $line = "";

    my $db_var  = &Hydra::Setup::Flow::HYDRA::get_lib_var($Paramref, "db", $process, $temp);

    $line .= sprintf <<EOF;
set MODE $mode
set PV   $process
set TEMP $temp
set RC   $rc

source ../script/sta_init_library.tcl
set link_path [concat * \$$db_var]

EOF

    $line .= "# Read Verilog\n";
    if (defined $subtype && $subtype eq "dmsa_fullchip") {
      my $verilog = $Paramref->get_param_value("STA_FULLCHIP_verilog", "strict", @$aref_keys);
      $line .= &Hydra::Setup::Flow::write_repeating_param("read_verilog", $verilog, 1);
    }
    else {
      my $verilog = $Paramref->get_param_value("STA_verilog", "strict", @$aref_keys);
      $line .= &Hydra::Setup::Flow::write_repeating_param("read_verilog", $verilog, 1);
    }
    $line .= "current_design $design_name\n";
    $line .= "link_design    $design_name\n";
    $line .= "\n";

    # Block-level spefs
    # Default spef location can be overridden by STA_spef_commands
    my $block_spef_commands = $Paramref->get_param_value("STA_spef_commands", "relaxed", ($temp, $rc));
    $line .= "# Read spef\n";
    if (&Hydra::Setup::Param::has_value($block_spef_commands)) {
      $line .= "$block_spef_commands\n";
    }
    else {
      $line .= "read_parasitics -keep_capacitive_coupling -format spef ../rc_extract/output/${design_name}.${rc}.${temp}.spef.gz\n";
    }
    if (defined $subtype && $subtype eq "dmsa_fullchip") {
      # Top-level spefs
      # Default spef location can be overriden by STA_FULLCHIP_spef_commands
      my $top_spef_commands = $Paramref->get_param_value("STA_FULLCHIP_spef_commands", "relaxed", ($temp, $rc));
      if (&Hydra::Setup::Param::has_value($top_spef_commands)) {
        $line .= "$top_spef_commands\n";
      }
      else {
        my $proj_home = $Paramref->get_param_value("HYDRA_proj_home", "strict");
        my @keysets = $Paramref->get_param_keysets("STA_FULLCHIP_spef_blocks", 1);
        foreach my $aref_keys (@keysets) {
          my $block_name = $aref_keys->[0];
          my $block_path = $Paramref->get_param_value("STA_FULLCHIP_spef_blocks", "relaxed", @$aref_keys);
          if (&Hydra::Setup::Param::has_value($block_path)) {
            if ($block_path =~ /\S\s+\S/) {
              $block_path = "{${block_path}}";
            }
            my $block_spef = "${proj_home}/DATA/${block_name}/spef/${block_name}.${rc}.${temp}.spef.gz";
            $line .= "read_parasitics -keep_capacitive_coupling -pin_cap_included -format spef -path ${block_path} ${block_spef}\n";
          }
        }
      }
      $line .= "\n";
    }
    $line .= "\n";

    # AOCV
    my $aocv = $Paramref->get_param_value("STA_aocv", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($aocv)) {
      $line .= &Hydra::Setup::Flow::write_repeating_param("read_ocvm", $aocv);
      $line .= "set timing_aocvm_enable_analysis true\n";
      $line .= "\n";
    }

    # Sdc
    $line .= "# Read sdc\n";
    if (defined $subtype && $subtype eq "dmsa_fullchip") {
      my $sdc = $Paramref->get_param_value("STA_FULLCHIP_sdc", "strict", ($mode));
      $line .= &Hydra::Setup::Flow::write_repeating_param("source", $sdc);
    }
    else {
      my $sdc = $Paramref->get_param_value("STA_sdc", "strict", ($mode));
      $line .= &Hydra::Setup::Flow::write_repeating_param("source", $sdc);
    }
    $line .= "\n";

    $line .= sprintf <<EOF;
# Propagate all clocks
set_propagated_clock [all_clocks]

EOF

    # Source catchalls
    $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "STA", @$aref_keys);
    
    # my $source_post = $Paramref->get_param_value("STA_source_catchall_post", "relaxed", @$aref_keys);
    # if (&Hydra::Setup::Param::has_value($source_post)) {
    #   $line .= "\# post source catchalls, useful for things like reading in latency files from innovus or things that require actual clocks\n";
    #   $line .= "\# source catchall post design readin\n";
    # }
    # $line .= &Hydra::Setup::Flow::write_repeating_param("source", $source_post);
    # $line .= "\n";

    $File->add_line($line);
  }

  if (defined $subtype && $subtype =~ /fullchip/) {
    my $host_options = $Paramref->get_param_value("STA_DMSA_FULLCHIP_host_options", "relaxed");
    if (&Hydra::Setup::Param::has_value($host_options)) {
      $top_line .= "set_host_options $host_options\n";
      $top_line .= "\n";
    }
    
    # Check that -num_processes equals number of scenarios
    if (&Hydra::Setup::Param::has_value($host_options)) {
      if ($host_options =~ /-num_processes\s+(\S+)/) {
        my $num_processes = $1;
        if ($num_processes != $num_scenarios) {
          print "WARN: STA_DMSA_FULLCHIP_host_options -num_processes ($num_processes) does not match number of scenarios ($num_scenarios) in flow STA_DMSA_FULLCHIP\n";
          print "      This is required if you will be running flow FIX_TIMING_DMSA_FULLCHIP\n";
        }
      }
    }
    else {
      print "WARN: STA_DMSA_host_options should have a -num_processes that matches the number of scenarios ($num_scenarios) in flow STA_DMSA_FULLCHIP\n";
      print "      This is required if you will be running flow FIX_TIMING_DMSA_FULLCHIP\n";
    }
  }
  else {
    my $host_options = $Paramref->get_param_value("STA_DMSA_host_options", "relaxed");
    if (&Hydra::Setup::Param::has_value($host_options)) {
      $top_line .= "set_host_options $host_options\n";
      $top_line .= "\n";
    }

    # Check that -num_processes equals number of scenarios
    if (&Hydra::Setup::Param::has_value($host_options)) {
      if ($host_options =~ /-num_processes\s+(\S+)/) {
        my $num_processes = $1;
        if ($num_processes != $num_scenarios) {
          print "WARN: STA_DMSA_host_options -num_processes ($num_processes) does not match number of scenarios ($num_scenarios) in flow STA_DMSA\n";
          print "      This is required if you will be running flow FIX_TIMING_DMSA\n";
        }
      }
    }
    else {
      print "WARN: STA_DMSA_host_options should have a -num_processes that matches the number of scenarios ($num_scenarios) in flow STA_DMSA\n";
      print "      This is required if you will be running flow FIX_TIMING_DMSA\n";
    }
  }

  $top_line .= sprintf <<EOF;
start_hosts
current_session -all

remote_execute {set_app_var si_enable_analysis true; set_app_var si_xtalk_double_switching_mode full_design}
remote_execute {update_timing}

save_session db/dmsa.timing.session

# Reports
report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 -include_hierarchical_pins \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/hold.timing.rpt

report_global_timing -significant_digits 3                                                       > rpt/global_timing.rpt
report_constraint -nosplit -all_violators                                                        > rpt/all_viols.const.rpt

exit

EOF

  $TopFile->add_line($top_line);

  # Warn if block spefs are missing
  my %dup = map {$_ => 1} @missing_spefs;
  @missing_spefs = sort keys %dup;
  if (scalar(@missing_spefs) > 0) {
    warn "WARN: Could not find the following block spefs for STA:\n";
    foreach my $block_spef (@missing_spefs) {
      warn "  $block_spef\n";
    }
  }

  # Error if no scenarios were defined
  if ($num_scenarios <= 0) {
    my $err_flow_name = "STA_DMSA";
    if (defined $subtype && $subtype =~ /fullchip/) {
      $err_flow_name = "STA_DMSA_FULLCHIP";
    }
    &Hydra::Setup::Control::register_error_param($err_flow_name, "no_scenario");
  }

  # Run scripts
  #my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "sta");
  #&Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, @script_file_names);
  &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, "script/dmsa.sta.tcl", "-multi_scenario");

  return (@LibFiles, @ScriptFiles, $KickoffFile);
}

#++
# Tool: pt
# Flow: STA_FULLCHIP
# Subtype: fullchip
#--
sub pt_STA_FULLCHIP {
  my ($Paramref, $KickoffFile) = @_;
  return &pt_STA($Paramref, $KickoffFile, "fullchip");
}

#++
# Tool: pt
# Flow: STA_DMSA_FULLCHIP
# Subtype: dmsa_fullchip
#--
sub pt_STA_DMSA_FULLCHIP {
  my ($Paramref, $KickoffFile) = @_;
  return &pt_STA_DMSA($Paramref, $KickoffFile, "dmsa_fullchip");
}

=pod

=head1 pt STA

=over

=item SCENARIO

Specify the scenarios that will be run. Use param keys for mode, process, temperature, and RC corner. The param key order matters. The value is a space-delimited list indicating what flow types the scenario is valid for. Use "sta" for STA. Keywords "sta_lib" and "sta_sdf" may also be added to enable sdf and lib/db generation per scenario.
 SCENARIO(<mode>)(<process>)(<temp>)(<rc>) = <value>
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta sta_lib sta_sdf

=item STA_spef_commands

Commands used to read in spefs. This is intended to override the default read_parasitics command for particular scenarios. Leave this empty to use the default spef read-in.

Use semicolons to between each separate command. This param can be used with the same temperature and RC corner keys as SCENARIO.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta
 STA_spef_commands(125c)(cbest) = read_parasitics file.spef

=item STA_sdc

One or more timing constraint files. Different files can be specified for different modes using param keys. Use the same mode key that was used in the SCENARIO param.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta
 STA_sdc(func) = design.sdc

=item STA_source_catchall_global 

A space-delimited list of misc source scripts. This param can be used with the same param keys as SCENARIO.

=item STA_source_catchall_local

A space-delimited list of misc source scripts. This param can be used with the same param keys as SCENARIO.

=item STA_source_catchall_post 

A space-delimited list of misc source scripts. Sourced after the SDC is read in. Useful for things that require actual clocks. This param can be used with the same param keys as SCENARIO.

=item STA_aocv

The aocv file. For more sophisticated derating. This param can be used with the same param keys as SCENARIO.

=item STA_verilog

One or more PNR netlists. This param can be used with the same param keys as SCENARIO.

=item DB_block_list

Specify your block dbs. Valid only for non-fullchip STA runs. Unlike DB_std_list and DB_macro_list, param keys for DB_block_list are optional.

=item STA_lc_bin

Path to the library compiler binary. Used to convert lib to db when library generation is enabled with the "sta_lib" keyword in the SCENARIO param.

=back

=head1 pt STA_DMSA

STA_DMSA uses all the same params as STA. Instead of the "sta" tag, use "sta_dmsa" in the SCENARIO param. The following params are also used:

=over

=item STA_DMSA_host_options

Options for the command set_host_options. Be sure to specify enough resources for the number of scenarios that will be run.

=back

=head1 pt STA_FULLCHIP

=over

STA_FULLCHIP uses all the same params as STA. Instead of the "sta" tag, use "sta_fullchip" in the SCENARIO param. The following params are also used:

=item STA_FULLCHIP_spef_commands

Commands used to read in block level spefs for fullchip sta. This is intended to override the default read_parasitics command for particular scenarios. Leave this empty to use the default spef read-in.

Use semicolons to between each separate command. This param can be used with the same temperature and RC corner keys as SCENARIO.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta
 STA_FULLCHIP_spef_commands(125c)(cbest) = read_parasitics file.spef

=item STA_FULLCHIP_spef_blocks

Block information for reading in spefs. If STA_FULLCHIP_spef_commands is not defined for the current scenario, then this param along with HYDRA_home will be used to read in a default spef file path.
 
Use the block name as the key and the block hierarchical path as the value.
 STA_FULLCHIP_spef_blocks(ddr_top) = soc_top_u/ddr_top_u
 STA_FULLCHIP_spef_blocks(usb_top) = soc_top_u/usb_top_u
 
If no hierarchical path is specified for a block (i.e. the param key is defined with no value), then that block will be ignored. Do this in your control file to remove a block defined in the param file.
 STA_FULLCHIP_spef_blocks(usb_top) = 

=item STA_FULLCHIP_verilog

One or more PNR netlists. This param can be used with the same param keys as SCENARIO. This param is used in place of STA_verilog.

=item STA_FULLCHIP_sdc

One or more timing constraint files. Different files can be specified for different modes using param keys. Use the same mode key that was used in the SCENARIO param. This param is used in place of STA_sdc.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta
 STA_sdc(func) = design.sdc

=back

=head1 pt STA_DMSA_FULLCHIP

STA_DMSA_FULLCHIP uses all the same params as STA_DMSA. Instead of the "sta_dmsa" tag, use "sta_dmsa_fullchip" in the SCENARIO param. The following params are also used:

=over

=item STA_DMSA_FULLCHIP_host_options

Options for the command set_host_options. Be sure to specify enough resources for the number of scenarios that will be run.

=item STA_FULLCHIP_spef_commands

Commands used to read in block level spefs for fullchip sta. This is intended to override the default read_parasitics command for particular scenarios. Leave this empty to use the default spef read-in.

Use semicolons to between each separate command. This param can be used with the same temperature and RC corner keys as SCENARIO.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta
 STA_FULLCHIP_spef_commands(125c)(cbest) = read_parasitics file.spef

=item STA_FULLCHIP_spef_blocks

Block information for reading in spefs. If STA_FULLCHIP_spef_commands is not defined for the current scenario, then this param along with HYDRA_home will be used to read in a default spef file path.
 
Use the block name as the key and the block hierarchical path as the value.
 STA_FULLCHIP_spef_blocks(ddr_top) = soc_top_u/ddr_top_u
 STA_FULLCHIP_spef_blocks(usb_top) = soc_top_u/usb_top_u
 
If no hierarchical path is specified for a block (i.e. the param key is defined with no value), then that block will be ignored. Do this in your control file to remove a block defined in the param file.
 STA_FULLCHIP_spef_blocks(usb_top) = 

=item STA_FULLCHIP_verilog

One or more PNR netlists. This param can be used with the same param keys as SCENARIO. This param is used in place of STA_verilog.

=item STA_FULLCHIP_sdc

One or more timing constraint files. Different files can be specified for different modes using param keys. Use the same mode key that was used in the SCENARIO param. This param is used in place of STA_sdc.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = sta
 STA_sdc(func) = design.sdc

=item STA_FULLCHIP_enable_margin_report

Set to "on" to enable reporting of block-to-block timing margin. This will add timing reports for paths through all block pins and calls to processing functions in the kickoff script. Do "hydra help report_interface_timing_margin" and "hydra help process_interface_timing_margin" for more information.

Setup will be checked for RC corners with a "_T" suffix, and hold will be checked for all other RC corners.

When margin reporting is enabled, you can control the scenarios that are considered using the SCENARIO param and the keyword "sta_margin.<name>", where <name> is the name for the scenario set. Margin reporting will be carried out for each scenario set. In the following example, a "func" set and "dft" set are defined. Two sets of margin reports will be created, one for "func" scenarios only and one for "dft" scenarios only.
 SCENARIO(func)(ff_0p99)(125c)(cbest)  = sta_margin.func
 SCENARIO(func)(ss_0p99)(125c)(cworst) = sta_margin.func
 SCENARIO(scan)(ff_0p99)(125c)(cbest)  = sta_margin.dft

If no scenario sets are defined, then a default set named "all" will include all STA scenarios. This default set will not appear if at least one set is defined. Because of this, do not use the name "all" for your custom scenario sets.

=item STA_FULLCHIP_margin_blocks

If STA_FULLCHIP_enable_margin_report is on, then specify the blocks to consider here. This is required if STA_FULLCHIP_enable_margin_report is on. The full path to each block (without the top module name) should be included.

=item STA_FULLCHIP_margin_slack_threshold

If STA_FULLCHIP_enable_margin_report is on, then specify a threshold value for slack here. Only violations that are worse than the specified value will be considered. Optional.

=item STA_FULLCHIP_margin_mode

If STA_FULLCHIP_enable_margin_report is on, then specify a mode here to only consider violations for the specified mode.

=item STA_FULLCHIP_margin_skip_pins

A space-delimited list of block pins to skip when generating the margin report.

=back

=cut

1;
