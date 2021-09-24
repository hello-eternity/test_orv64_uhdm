#!/usr/bin/perl
#------------------------------------------------------
# Script Name: hydra
# Date:        Mon Jan 28 11:40:42 2019
# Author:      kvu
#------------------------------------------------------
use strict;
use warnings;
use Carp;

use lib "$ENV{HYDRA_HOME}/lib";
use Hydra;

# Uncomment to print stack trace on every error
#$SIG{__DIE__} = sub { Carp::confess @_ };

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our %glb_dispatch = ();
$glb_dispatch{"setup"}                 = \&Hydra::Setup::setup;
$glb_dispatch{"write_flow_man"}        = \&Hydra::Doc::write_flow_man;
$glb_dispatch{"clean_flow_man"}        = \&Hydra::Doc::clean_flow_man;
$glb_dispatch{"convert_pod_docs"}      = \&Hydra::Doc::convert_pod_docs;
$glb_dispatch{"clean_man_docs"}        = \&Hydra::Doc::clean_man_docs;
$glb_dispatch{"display_manpage"}       = \&Hydra::Doc::display_manpage;
$glb_dispatch{"init_param_files"}      = \&Hydra::Setup::init_param_files;
$glb_dispatch{"init_proj_dir"}         = \&Hydra::Setup::init_proj_dir;
$glb_dispatch{"connect_interface"}     = \&Hydra::Func::ConnectInterface::connect_interface;
$glb_dispatch{"rtl_copy"}              = \&Hydra::Func::RtlCopy::rtl_copy;
$glb_dispatch{"sdc_copy"}              = \&Hydra::Func::SdcCopy::sdc_copy;
$glb_dispatch{"report_synth_git_info"} = \&Hydra::Func::ReportGitInfo::report_git_info;
$glb_dispatch{"report_git_info"}       = \&Hydra::Func::ReportGitInfo::report_git_info;
$glb_dispatch{"report_regr_build_id"}  = \&Hydra::Func::ReportGitInfo::report_regr_build_id;
$glb_dispatch{"promote_sdc"}           = \&Hydra::Func::PromoteSdc::promote_sdc;
$glb_dispatch{"incoming"}              = \&Hydra::Func::Incoming::incoming;
$glb_dispatch{"incoming_gpg"}          = \&Hydra::Func::Incoming::incoming_gpg;
$glb_dispatch{"bump_map"}              = \&Hydra::Func::BumpMap::bump_map;
$glb_dispatch{"worst_global_timing"}   = \&Hydra::Func::WorstGlobalTiming::worst_global_timing;
#$glb_dispatch{"report_interface_timing_margin"}  = \&Hydra::Func::ReportInterfaceTimingMargin::report_interface_timing_margin;
#$glb_dispatch{"process_interface_timing_margin"} = \&Hydra::Func::ReportInterfaceTimingMargin::process_interface_timing_margin;
$glb_dispatch{"license"}               = \&Hydra::Func::License::license;
$glb_dispatch{"trace_clock"}           = \&Hydra::Func::TraceClock::trace_clock;
$glb_dispatch{"trace_hierarchy"}       = \&Hydra::Func::TraceHierarchy::trace_hierarchy;
$glb_dispatch{"convert_lib"}           = \&Hydra::Func::ConvertLib::convert_lib;
$glb_dispatch{"trace_power"}           = \&Hydra::Func::TracePower::trace_power;
$glb_dispatch{"edit_scan_pattern"}     = \&Hydra::Func::EditScanPattern::edit_scan_pattern;
$glb_dispatch{"padframe"}              = \&Hydra::Func::Padframe::padframe;
$glb_dispatch{"dashboard"}             = \&Hydra::Func::Dashboard::dashboard;
$glb_dispatch{"vtswap"}                = \&Hydra::Func::VTSwap::vtswap;
$glb_dispatch{"man_error"}             = \&Hydra::Func::ManError::man_error;
$glb_dispatch{"netlist_navi"}          = \&Hydra::Func::NetlistNavi::netlist_navi;
$glb_dispatch{"write_sta_kickoff"}     = \&Hydra::Func::WriteSTAKickoff::write_sta_kickoff;
$glb_dispatch{"split_eco"}             = \&Hydra::Func::SplitECO::split_eco;
$glb_dispatch{"report_interface_margin"}  = \&Hydra::Func::ReportInterfaceTimingMargin::report_interface_margin;
$glb_dispatch{"help"}                  = \&help;

# Debug
#$glb_dispatch{"read_netlist"}          = \&Hydra::Verilog::read_netlist;
#$glb_dispatch{"test_trace"}            = \&Hydra::Verilog::test_trace;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub process_arguments {
  &Hydra::Util::Option::process_options;
}

sub process_dispatch {
  
}

sub main {
  my $run_command = &Hydra::Util::Option::get_run_command;
  if (!defined $run_command) {
    warn "ERROR: no run command found\n";
    &print_usage;
  }

  if (defined $glb_dispatch{$run_command}) {
    $glb_dispatch{$run_command}->();
  }
  else {
    warn "ERROR: command=${run_command} not recognized!\n";
    &print_usage;
  }
}

sub print_usage {
  print "hydra.pl <run_command> [options]\n";
  print "  Try \"hydra.pl help\" for a command list\n";
  print "  Try \"hydra.pl help <COMMAND>\" for a command man page\n";
  exit;
}

sub help {
  my $command_name = &Hydra::Util::Option::get_opt_value_array("", "relaxed", [""])->[0];
  my $sub_command  = &Hydra::Util::Option::get_opt_value_array("", "relaxed", [""])->[1];

  if ($command_name eq "") {
    # Print command list
    print "HYDRA COMMAND LIST:\n";
    foreach my $command (sort keys %glb_dispatch) {
      print "  $command\n";
    }

    # Print flow list
    print "HYDRA FLOW LIST:\n";
    &Hydra::Setup::Flow::initialize_flows();
    my @all_flows = &Hydra::Setup::Flow::get_all_flows;
    foreach my $flow_name (@all_flows) {
      my $eco_only = "";
      if (&Hydra::Setup::Flow::is_flow_eco_only($flow_name)) {
        $eco_only = "(eco only)";
      }

      my @all_tools = &Hydra::Setup::Flow::get_all_flow_tools($flow_name);
      foreach my $tool (@all_tools) {
        print "  $flow_name ($tool) ${eco_only}\n";
      }
    }
  }
  else {
    &Hydra::Doc::display_man_page($command_name, $sub_command);
  }
}

&process_arguments;
&process_dispatch;
&main;

1;
