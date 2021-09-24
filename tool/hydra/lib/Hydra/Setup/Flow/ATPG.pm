#------------------------------------------------------
# Module Name: ATPG
# Date:        Fri Feb 15 18:23:56 2019
# Author:      kvu
# Type:        atpg
#------------------------------------------------------
package Hydra::Setup::Flow::ATPG;

use strict;
use warnings;
use Carp;
use Exporter;
use Digest::MD5 qw(md5_hex);

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_self_module = "$ENV{HYDRA_HOME}/lib/Hydra/Setup/Flow/ATPG.pm";

#------------------------------------------------------
# Subroutines
#------------------------------------------------------

#++
# Tool: tmax
# Flow: ATPG
#--
sub tmax_ATPG {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  # Self-parse to compile a list of all params used
  # Check each param for keys to determine iterations
  my @param_list  = &Hydra::Setup::Flow::parse_self_for_params($glb_self_module, "tmax_ATPG");
  my @all_keysets = ();
  foreach my $param_name (@param_list) {
    if ($Paramref->has_param_keysets($param_name, 1)) {
      push(@all_keysets, $Paramref->get_param_keysets($param_name, 1));
    }
  }

  # Remove duplicate keysets
  my %found   = ();
  my @keysets = ();
  foreach my $aref_keys (@all_keysets) {
    if (!defined $found{md5_hex(@$aref_keys)}) {
      push(@keysets, $aref_keys);
      $found{md5_hex(@$aref_keys)} = 1;
    }
  }

  # Add the "default" keyset if there are no keysets
  if (scalar(@keysets) <= 0) {
    push(@keysets, ["default"]);
  }

  # Tool scripts
  my @ScriptFiles = ();
  my @script_file_names = ();
  foreach my $aref_keys (@keysets) {
    my $script_name;
    my $fault_model;
    if ($aref_keys->[0] eq "default") {
      $fault_model = "stuck";
      $script_name = "script/stuck.atpg.tcl";
    }
    else {
      $fault_model = $aref_keys->[0];
      $script_name = "script/${fault_model}.atpg.tcl";
    }

    my $ScriptFile = new Hydra::Setup::File($script_name, "atpg");
    push(@ScriptFiles, $ScriptFile);
    push(@script_file_names, $script_name);
    my $line = "";
  
    $line .= sprintf <<EOF;
if ![file exists rpt/image] {
    mkdir rpt/image
}
if ![file exists rpt/drc] {
    mkdir rpt/drc
}
if ![file exists rpt/post_atpg] {
    mkdir rpt/post_atpg
}

set_messages -level expert -leading_comment
set_netlist -redefined_module first

echo \"RUN STARTED AT [date]\"

EOF

    my $lib_list = $Paramref->get_param_value("ATPG_lib_list", "strict", @$aref_keys);
    $line .= "# Read libraries\n";
    $line .= &Hydra::Setup::Flow::write_repeating_param("read_netlist -lib", $lib_list);
    $line .= "\n";
    
    my $netlist  = $Paramref->get_param_value("ATPG_scan_netlist", "strict", @$aref_keys);
    $line .= "# Read scan netlist\n";
    $line .= &Hydra::Setup::Flow::write_repeating_param("read_netlist", $netlist);
    $line .= "\n";

    my $source_catchall_init = $Paramref->get_param_value("ATPG_source_catchall_init", "relaxed", @$aref_keys);
    $line .= &Hydra::Setup::Flow::write_repeating_param("source", $source_catchall_init);
    $line .= "\n";

    my $mask_rules = $Paramref->get_param_value("ATPG_mask_rules", "relaxed", @$aref_keys);
    $line .= "set_build -delete_unused_gates\n";
    if (&Hydra::Setup::Param::has_value($mask_rules)) {
      $mask_rules = &Hydra::Setup::Param::remove_param_value_linebreak($mask_rules);
      foreach my $value (split(/\s+/, $mask_rules)) {
        $line .= "set_rules $value -mask\n";
      }
    }
    $line .= "run_build_model $design_name\n";
    $line .= "\n";

    $line .= sprintf <<EOF;
report_modules -undefined     > ./rpt/image/undefined_modules.${fault_model}.rpt
report_rules   -fail          > ./rpt/image/fail_rules.${fault_model}.rpt
report_violations -all        > ./rpt/image/violations.${fault_model}.rpt
report_memory -all -verbose   > ./rpt/image/memory_all.verbose.${fault_model}.rpt
report_memory -all            > ./rpt/image/memory_all.${fault_model}.rpt
report_memory -summary        > ./rpt/image/memory_all.summary.${fault_model}.rpt

write_image ./output/${design_name}.${fault_model}.image -design_view -netlist_data -replace

# Run DRC
set_drc -allow_unstable_set_resets -extract_cascaded_clock_gating
set_drc -nodslave_remodel -noreclassify_invalid_dslaves

EOF

    my $sdc = $Paramref->get_param_value("ATPG_sdc", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($sdc)) {
      $line .= "read_sdc -echo $sdc\n";
      $line .= "\n";
    }

    my $source_pre = $Paramref->get_param_value("ATPG_source_catchall_pre", "relaxed", @$aref_keys);
    $line .= "# Source catchall pre\n";
    $line .= &Hydra::Setup::Flow::write_repeating_param("source", $source_pre);
    $line .= "\n";

    my $spf = $Paramref->get_param_value("ATPG_spf", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($spf)) {
      $line .= "run_drc $spf\n";
      $line .= "\n";
    }

    my $coverage = $Paramref->get_param_value("ATPG_coverage", "strict", @$aref_keys);

    $line .= sprintf <<EOF;
# Write timing constraints
source /work/tools/synopsys/txs/P-2019.03-SP1/auxx/syn/tmax/tmax2pt.tcl
write_timing_constraints -mode shift   -wft _default_WFT_ ./output/timing_constraints.${fault_model}.shift -replace
write_timing_constraints -mode capture -wft _default_WFT_ ./output/timing_constraints.${fault_model}.capture -replace

# Define clock and pin constraints
report_pi_constraints
report_cell_constraints
report_clocks -matrix -verbose

# Post DRC reports
report_scan_cells     -all -reverse -verbose  >  rpt/drc/scan_cells.${fault_model}.rpt
report_nonscan_cells  -all -verbose           >  rpt/drc/non_scan_cells.${fault_model}.rpt
report_scan_chains                            >  rpt/drc/scan_chains.${fault_model}.rpt
report_lockup_latches                         >  rpt/drc/lockup.${fault_model}.rpt
report_violations     -all                    >  rpt/drc/violations.${fault_model}.rpt
report_rules          -all                    >  rpt/drc/rules.${fault_model}.rpt
report_summaries

# Config faults
set_faults -summary verbose -atpg_effectiveness
set_faults -model $fault_model -report collapsed
EOF

    my $fault_script = $Paramref->get_param_value("ATPG_fault_script", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($fault_script)) {
      $line .= "source $fault_script\n";
      $line .= "\n";
    }
    else {
      $line .= sprintf <<EOF;
add_equivalent_nofaults
add_faults -all
update_faults -reset_au

EOF
    }

    $line .= sprintf <<EOF;
# Config atpg
set_patterns -histogram_summary
set_atpg -verbose
set_atpg -coverage ${coverage}
set_atpg -quiet_chain_test
EOF

    my $num_proc = $Paramref->get_param_value("ATPG_num_processes", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($num_proc)) {
      $line .= "set_atpg -num_processes $num_proc\n";
    }
    $line .= "\n";
  
    $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "ATPG", @$aref_keys);

    $line .= sprintf <<EOF;
# Run ATPG
run_atpg -optimize_patterns
set_atpg -capture 8 -abort_limit 1000
run_atpg -auto_compression

# Run Sim
set_simulation -xclock_gives_xout
EOF

    if (&Hydra::Setup::Param::has_value($num_proc)) {
      $line .= "set_simulation -num_processes $num_proc\n";
    }
    $line .= "\n";

    $line .= sprintf <<EOF;
run_simulation

# Post ATPG reports
report_rules -fail                      > rpt/post_atpg/rules_fail.${fault_model}.rpt
report_nonscan_cells -summary           > rpt/post_atpg/non_scan_cells_summary.${fault_model}.rpt
report_nonscan_cells -verbose -all      > rpt/post_atpg/non_scan_cells.${fault_model}.rpt
report_scan_cells  -all                 > rpt/post_atpg/scancells.${fault_model}.rpt
report_buses -summary                   > rpt/post_atpg/buses.${fault_model}.rpt
report_feedback_paths -summary          > rpt/post_atpg/feedback_path.${fault_model}.rpt
report_violations -all                  > rpt/post_atpg/violations.${fault_model}.rpt
report_scan_chains                      > rpt/post_atpg/scan_chains.${fault_model}.rpt
report_patterns -all                    > rpt/post_atpg/patterns.${fault_model}.rpt
report_summaries                        > rpt/post_atpg/summary.${fault_model}.rpt
report_patterns -clock -all             > rpt/post_atpg/patterns_with_clock.${fault_model}.rpt
report_faults -all                      > rpt/post_atpg/faults.${fault_model}.rpt
report_faults -class AU                 > rpt/post_atpg/AU_faults.${fault_model}.rpt

# Write faults
write_faults       rpt/post_atpg/${fault_model}.faults -all -replace

# Write patterns
write_patterns output/${design_name}.serial.${fault_model}.stil   -format stil   -replace -serial
write_patterns output/${design_name}.serial.${fault_model}.bin    -format binary -replace -serial
write_patterns output/${design_name}.parallel.${fault_model}.stil -format stil   -replace -parallel
write_patterns output/${design_name}.parallel.${fault_model}.bin  -format binary -replace -parallel

# Write testbench
write_testbench -input output/${design_name}.parallel.${fault_model}.stil -output output/${design_name}.parallel.${fault_model}.tb -replace
write_testbench -input output/${design_name}.serial.${fault_model}.stil   -output output/${design_name}.serial.${fault_model}.tb -replace

# Report power
analyze_fault -class an
report_faults -level 4 64
report_power -shift -percentage   > ./rpt/post_atpg/power_peak_average.${fault_model}.shift.rpt
report_power -capture -percentage > ./rpt/post_atpg/power_peak_average.${fault_model}.capture.rpt

echo \"RUN ENDED AT [date]\"

exit -f

EOF

    $ScriptFile->add_line($line);
    $ScriptFile->add_dir("rpt/image");
    $ScriptFile->add_dir("rpt/drc");
    $ScriptFile->add_dir("rpt/post_atpg");
  }

  # Run scripts
  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "atpg");
  &Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, @script_file_names);
  
  return ($KickoffFile, @ScriptFiles);
}

=pod

=head1 tmax ATPG

Use param keys to define the fault model. Define a param key on at least one ATPG param to activate an iteration of ATPG with the specified fault model. If no param keys are defined, then the run will default to the "stuck" fault model.

Example:
 ATPG_scan_netlist(stuck) = ./netlist.v

=over

=item ATPG_lib_list

A space-delimited list of verilog library models specifically for tmax.

=item ATPG_scan_netlist

The scan-inserted netlist.

=item ATPG_sdc

The constraint file. Optional.

=item ATPG_source_catchall_pre

A space-delimited list of misc scripts. Sourced before drc/atpg is run. Optional.

=item ATPG_source_catchall_global

A space-delimited list of global misc scripts. Sourced after drc but before atpg is run. Optional.

=item ATPG_source_catchall_local

A space-delimited list of local misc scripts. Sourced after drc but before atpg is run. Optional.

=item ATPG_spf

An spf file. Optional.

=back

=cut

1;
