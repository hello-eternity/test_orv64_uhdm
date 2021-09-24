#------------------------------------------------------
# Module Name: SIM
# Date:        Thu Jun 27 17:18:39 2019
# Author:      kvu
# Type:        sim
#------------------------------------------------------
package Hydra::Setup::Flow::SIM;

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
my $glb_self_module = "$ENV{HYDRA_HOME}/lib/Hydra/Setup/Flow/SIM.pm";

#------------------------------------------------------
# Subroutines
#------------------------------------------------------

#++
# Tool: vcs
# Flow: SIM
#--
sub vcs_SIM {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");
  my $sim_home    = $Paramref->get_param_value("SIM_home_dir", "strict");

  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "sim");
  $KickoffFile->make_executable;

  my $time = localtime;
  $KickoffFile->add_line("#!/usr/bin/bash");
  $KickoffFile->add_line("# Generated by Hydra on $time");
  $KickoffFile->add_line("export HYDRA_HOME=$ENV{HYDRA_HOME}");
  $KickoffFile->add_line("export VCS_HOME=${sim_home}");
  $KickoffFile->add_linebreak;

  # Self-parse to compile a list of all params used
  # Check each param for keys to determine iterations
  my @param_list  = &Hydra::Setup::Flow::parse_self_for_params($glb_self_module, "vcs_SIM");
  my @all_keysets = ();
  foreach my $param_name (@param_list) {
    if ($Paramref->has_param_keysets($param_name, 2)) {
      push(@all_keysets, $Paramref->get_param_keysets($param_name, 2));
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
  foreach my $aref_keys (@keysets) {
    my $script_name;
    my $fault_model;
    my $pattern_mode;
    if ($aref_keys->[0] eq "default") {
      $fault_model = "stuck";
      $pattern_mode = "serial";
    }
    else {
      $fault_model = $aref_keys->[0];
      $pattern_mode = $aref_keys->[1];
    }
    $script_name = "script/${fault_model}.${pattern_mode}.sim.tcl";
    
    # Compile script
    my $ScriptFile = new Hydra::Setup::File($script_name, "sim");
    push(@ScriptFiles, $ScriptFile);
    my $line = "";

    my $stil         = $Paramref->get_param_value("SIM_stil", "relaxed", @$aref_keys);
    my $testbench    = $Paramref->get_param_value("SIM_testbench", "relaxed", @$aref_keys);
    my $scan_netlist = $Paramref->get_param_value("SIM_scan_netlist", "strict", @$aref_keys);

    if (&Hydra::Setup::Param::has_value($testbench)) {
      $line .= "$testbench\n";
    }
    elsif (&Hydra::Setup::Param::has_value($stil)) {
      my $stil2verilog_bin  = $Paramref->get_param_value("SIM_stil2verilog_bin", "strict", @$aref_keys);
      my $stil2verilog_home = $Paramref->get_param_value("SIM_stil2verilog_home", "strict", @$aref_keys);
      my $stil2verilog_name = $stil;
      $stil2verilog_name =~ s/\.[^\s\.]+$//;

      # Add stil to verilog conversion to kickoff script
      $KickoffFile->add_line("export SYNOPSYS=${stil2verilog_home}");
      $KickoffFile->add_line("$stil2verilog_bin $stil $stil2verilog_name -replace");

      $stil2verilog_name .= ".v";
      $line .= "$stil2verilog_name\n";
    }
    else {
      die "ERROR: No testbench or stil file specified for SIM flow!\n";
    }
    $scan_netlist = &Hydra::Setup::Param::remove_param_value_linebreak($scan_netlist);
    foreach my $file (split(/\s+/, $scan_netlist)) {
      $line .= "$file\n";
    }
  
    my $sdf_file = $Paramref->get_param_value("SIM_sdf", "relaxed", @$aref_keys);
    my $sdf_type = $Paramref->get_param_value("SIM_sdf_type", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($sdf_file) && &Hydra::Setup::Param::has_value($sdf_type)) {
      $line .= "-sdf ${sdf_type}:${design_name}:${sdf_file}\n";
    }

    my $delay_mode = $Paramref->get_param_value("SIM_delay_mode", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($delay_mode)) {
      $line .= "+delay_mode_${delay_mode}\n";
    }
 
    $line .= sprintf <<EOF;
-R
-debug_all
-picarchive
+v2k
+vcs+lic+wait
+verilog2001ext+.v
+nospecify
+notimingchecks
+define+no_warning
+vcs+loopreport
+vcs+loopdetect
+tmax_msg=3
+tmax_rpt=3
EOF

    my $pattern_count = $Paramref->get_param_value("SIM_pattern_count", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($pattern_count)) {
      if ($pattern_mode eq "serial") {
        $line .= "+tmax_n_pattern_sim=${pattern_count}\n";
      }
      elsif ($pattern_mode eq "parallel") {
        $line .= "+tmax_parallel=${pattern_count}\n";
      }
    }

    my $sim_options = $Paramref->get_param_value("SIM_options", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($sim_options)) {
      $line .= "$sim_options\n";
    }

    my $lib_list = $Paramref->get_param_value("SIM_lib_list", "strict", @$aref_keys);
    $line .= &Hydra::Setup::Flow::write_repeating_param("-v", $lib_list);
    $line .= "\n";
    $ScriptFile->add_line($line);

    # Add command to kickoff script
    &Hydra::Setup::Flow::add_kickoff_command($Paramref, $KickoffFile, $script_name);
  }

  return (@ScriptFiles, $KickoffFile);
}

=pod

=head1 vcs SIM

Use param keys to define the fault model and pattern mode. Define these two param keys on at least one SIM param to activate an iteration of SIM with the specified fault model and pattern mode. If no or the wrong number of param keys are defined, then the run will default to the "stuck" fault model and "serial" pattern mode.

Pattern mode can be "serial" or "parallel".

Example:
 SIM_scan_netlist(stuck)(serial) = ./netlist.v

=over

=item SIM_home_dir

The home directory of VCS. This is used to set necessary environment variables for VCS.

=item SIM_testbench

The sim testbench generated from ATPG.

=item SIM_scan_netlist

The scan-inserted verilog netlist.

=item SIM_sdf

The sdf generated from STA. Optional.

=item SIM_sdf_type

The sdf corner type. Value: min|max. Optional. Must be defined if SIM_sdf is defined.

=item SIM_delay_mode

The delay mode. Use "zero" when doing zero-delay sims.

=item SIM_options

Extra options to pass to vcs.

=item SIM_lib_list

A space-delimited list of rtl verilog or tmax library models.

=item SIM_pattern_count

The number of patterns that the testbench contains.

=item SIM_stil

A stil file that can be specified instead of a testbench.

=item SIM_stil2verilog_bin

A full path to the Synopsys stil2verilog tool. Required if a stil file is specified instead of a testbench. A verilog file will be generated from the stil file for use in simulation.

=item SIM_stil2verilog_home

A full path to the home directory of the stil2verilog tool. The stil2verilog tool requires this as an environment variable.

=back

=cut

1;