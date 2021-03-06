#------------------------------------------------------
# Module Name: LINT
# Date:        Tue Apr  9 11:46:36 2019
# Author:      kvu
# Type:        lint
#------------------------------------------------------
package Hydra::Setup::Flow::LINT;

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
# Tool: spyglass
# Flow: LINT
#--
sub spyglass_LINT {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");

  my @LibFiles = &Hydra::Setup::Flow::HYDRA::INIT_LIBRARY($Paramref, "lint");
  
  # Run scripts
  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "lint");
  #&Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, ("script/lint.tcl"));
  my $time = localtime;
  $KickoffFile->add_line("#!/usr/bin/bash");
  $KickoffFile->add_line("# Generated by Hydra on $time");
  $KickoffFile->add_line("export HYDRA_HOME=$ENV{HYDRA_HOME}");
  $KickoffFile->add_line("export SKIP_PLATFORM_CHECK=1");
  $KickoffFile->add_linebreak;
  my $tool_command = &Hydra::Setup::Tool::get_tool_command($Paramref, $KickoffFile->get_type, "script/lint.tcl");
  $KickoffFile->add_line($tool_command);
  $KickoffFile->add_line("echo \"RUN ENDED AT \`date\`\" >> log/lint.log");
  $KickoffFile->make_executable;

  # Tool scripts
  my $ScriptFile = new Hydra::Setup::File("script/lint.tcl", "lint");
  my $line = "";

  $line .= sprintf <<EOF;
source script/lint_init_library.tcl
source $ENV{HYDRA_HOME}/script/tcl/file_to_list.tcl

new_project ./db/${design_name}.prj -projectwdir "./db" -force

EOF

  my $rtl_flist = $Paramref->get_param_value("LINT_rtl_flist", "strict");
  my @flists = split(/\s+/, &Hydra::Setup::Param::remove_param_value_linebreak($rtl_flist));
  $line .= "# Read RTL\n";
  foreach my $flist (@flists) {
    $line .= "read_file -type hdl [concat [expand_file_list \"${flist}\"]]\n";
  }
  $line .= "\n";
 
#  $line .= sprintf <<EOF;
## Read RTL
#read_file -type hdl [concat [expand_file_list \"${rtl_flist}\"]]
#
#EOF

  my @incdirs = ();
  foreach my $flist (@flists) {
    my $resolved_rtl_flist = &Hydra::Util::File::resolve_env($flist);
    if (-f $resolved_rtl_flist) {
      my ($aref_files, $aref_incdirs) = &Hydra::Util::File::expand_file_list($resolved_rtl_flist);
      @incdirs = @$aref_incdirs;
    }
  }
  if (scalar(@incdirs) > 0) {
    my $dir_list = "\"" . join(" ", @incdirs) . "\"";
    $line .= "set_option incdir $dir_list\n";
  }
  $line .= "\n";

  my $awl_file  = $Paramref->get_param_value("LINT_awl_file", "relaxed");
  if (&Hydra::Setup::Param::has_value($awl_file)) {
    $line .= "# Read AWL\n";
    $line .= "read_file -type awl ${awl_file}\n";
    $line .= "set_option default_waiver_file ${awl_file}\n";
  }

  my $db_var = &Hydra::Setup::Flow::get_scenario_lib_var($Paramref, "LINT", "db");
  $line .= sprintf <<EOF;
# Read DB
read_file -type gateslibdb [concat \"\$$db_var\"]

set_option top ${design_name}

# Options
set_option mthresh 1000000
set_option dw yes
set_option disable_amg yes
set_option show_lib yes
set_option allow_duplicate_files true
set_option allow_module_override yes
set_option sort yes
set_option prefer_tech_lib yes
set_option enable_pgnetlist_all_products yes 
set_option enable_pgnetlist yes
set_option max_err_count 0
set_option enable_unified_naming_search yes
set_option enableSV09 yes

EOF

  my $ignoredu = $Paramref->get_param_value("LINT_ignoredu", "relaxed");
  $line .= &Hydra::Setup::Flow::write_repeating_param("set_option ignoredu", $ignoredu);
  $line .= "\n";

  my $define = $Paramref->get_param_value("LINT_define", "relaxed");
  $line .= &Hydra::Setup::Flow::write_repeating_param("set_option define", $define);
  $line .= "\n";

  $line .= sprintf <<EOF;
# run settings
current_methodology \$SPYGLASS_HOME/GuideWare/latest/block/rtl_handoff
current_goal lint/lint_rtl

EOF

  my $add_rules    = $Paramref->get_param_value("LINT_add_rules", "relaxed");
  my $ignore_rules = $Paramref->get_param_value("LINT_ignore_rules", "relaxed");
  if (&Hydra::Setup::Param::has_value($add_rules)) {
    $line .= "set_goal_option addrules {$add_rules}\n";
  }
  if (&Hydra::Setup::Param::has_value($ignore_rules)) {
    $line .= "set_goal_option ignorerules {$ignore_rules}\n";
  }
  $line .= "\n";
  
  $line .= sprintf <<EOF;
set_parameter check_static_value yes
set_parameter strict yes
set_parameter report_reset_type all

EOF

  # Removed this parameter since it defaults to 1 and causes an error for some reason
  #set_parameter lp_skip_pwr_gnd 1

  $line .= &Hydra::Setup::Flow::write_source_catchall($Paramref, "LINT");

  $line .= sprintf <<EOF;
run_goal

save_project

write_aggregate_report project_summary -reportdir ./rpt
# no licenses
#write_aggregate_report datasheet -reportdir ./rpt
#write_aggregate_report dashboard -reportdir ./rpt

exit

EOF

  $ScriptFile->add_line($line);
  
  return (@LibFiles, $KickoffFile, $ScriptFile);
}

=pod

=over

=head1 spyglass LINT

=item LINT_add_rules

Add goal level rules.

=item LINT_ignore_rules

Ignores goal level rules.

=item LINT_awl_file

The default waiver file for project level waivers.

=item LINT_rtl_flist

An flist containing RTL files.

=item LINT_define

A space-delimited list of `define macros.

=back

=cut

1;
