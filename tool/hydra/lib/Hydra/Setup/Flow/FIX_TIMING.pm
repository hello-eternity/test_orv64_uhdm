#------------------------------------------------------
# Module Name: FIX_TIMING
# Date:        Tue Jun 18 13:57:03 2019
# Author:      kvu
# Type:        fix_timing
#------------------------------------------------------
package Hydra::Setup::Flow::FIX_TIMING;

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
# Flow: FIX_TIMING_DMSA
# Subtype: dmsa_eco
#--
sub pt_FIX_TIMING_DMSA {
  my ($Paramref, $KickoffFile, $subtype) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");
  my $eco_name    = $Paramref->get_name;

  # Use dmsa_eco as subtype if not given
  # dmsa_eco should always be prepended to any subtype given to this flow
  if (!defined $subtype) {
    $subtype = "dmsa_eco";
  }
  
  my $tool_command = &Hydra::Setup::Tool::get_tool_command($Paramref, "sta", "script/dmsa.${eco_name}.tcl", "-multi_scenario");
  $KickoffFile->add_line($tool_command);

  my $File = new Hydra::Setup::File("script/dmsa.${eco_name}.tcl", "fix_timing", $subtype);
  my $line = "";

  my $session;
  if (defined $subtype && $subtype =~ /fullchip/) {
    $session = $Paramref->get_param_value("FIX_TIMING_DMSA_FULLCHIP_session", "strict");
  }
  else {
    $session = $Paramref->get_param_value("FIX_TIMING_DMSA_session", "strict");
  }

  $line .= sprintf <<EOF;
source $ENV{HYDRA_HOME}/script/tcl/restore_dmsa_session.tcl
restore_dmsa_session ${session}

EOF

  if (defined $subtype && $subtype =~ /fullchip/) {
    my $host_options = $Paramref->get_param_value("STA_DMSA_FULLCHIP_host_options", "relaxed");
    if (&Hydra::Setup::Param::has_value($host_options)) {
      $line .= "set_host_options $host_options\n";
      $line .= "\n";
    }
  }
  else {
    my $host_options = $Paramref->get_param_value("STA_DMSA_host_options", "relaxed");
    if (&Hydra::Setup::Param::has_value($host_options)) {
      $line .= "set_host_options $host_options\n";
      $line .= "\n";
    }
  }

  my $execute_commands;
  if (defined $subtype && $subtype =~ /fullchip/) {
    $execute_commands = $Paramref->get_param_value("FIX_TIMING_DMSA_FULLCHIP_execute_commands", "strict");
  }
  else {
    $execute_commands = $Paramref->get_param_value("FIX_TIMING_DMSA_execute_commands", "strict");
  }
  $line .= sprintf <<EOF;
start_hosts
current_session -all

$execute_commands

# Reports
if ![file exists rpt/eco] {
  file mkdir rpt/eco
}

report_timing -delay_type max -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/eco/setup.timing.rpt
report_timing -delay_type min -path_type full_clock_expanded -max_paths 1000 -nworst 1 -slack_lesser_than 0.010 \\
  -input_pins -nets -transition_time -capacitance -crosstalk_delta -derate -significant_digits 3 > rpt/eco/hold.timing.rpt

report_global_timing -significant_digits 3                                                       > rpt/eco/global_timing.rpt
report_constraint -nosplit -all_violators                                                        > rpt/eco/all_viols.const.rpt

remote_execute { write_changes -format icc2tcl -output ../output/dmsa.${eco_name}.icc2.tcl }
remote_execute { write_changes -format ptsh    -output ../output/dmsa.${eco_name}.pt.tcl }

exit

EOF

  $File->add_line($line);
  $File->add_dir("rpt/eco");

  return ($File);
}

#++
# Tool: pt
# Flow: FIX_TIMING_DMSA_FULLCHIP
# Subtype: dmsa_fullchip_eco
#--
sub pt_FIX_TIMING_DMSA_FULLCHIP {
  my ($Paramref, $KickoffFile) = @_;
  return &pt_FIX_TIMING_DMSA($Paramref, $KickoffFile, "dmsa_fullchip_eco");
}

=pod

=head1 pt FIX_TIMING_DMSA

=over

=item STA_DMSA_host_options

Used to set host options. The option -num_processes should always match the number of scenarios in your session.

=item FIX_TIMING_DMSA_session

The previously created dmsa session to use.

=item FIX_TIMING_DMSA_execute_commands

The timing fix commands to use. Default=fix_eco_timing -type hold

=back

=head1 pt FIX_TIMING_DMSA_FULLCHIP

FIX_TIMING_DMSA_FULLCHIP uses all the same params as FIX_TIMING_DMSA, along with the following:

=over

=item STA_DMSA_FULLCHIP_host_options

Used to set host options. The option -num_processes should always match the number of scenarios in your session.

=item FIX_TIMING_DMSA_FULLCHIP_session

The previously created dmsa fullchip session to use.

=item FIX_TIMING_DMSA_FULLCHIP_execute_commands

The timing fix commands to use. Default=fix_eco_timing -type hold

=back

=cut

1;
