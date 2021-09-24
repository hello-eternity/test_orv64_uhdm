#------------------------------------------------------
# Module Name: Tool
# Date:        Mon Jan 28 12:24:18 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::Tool;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our %glb_default_tools = (
  "pnr"         => "icc2",
  "sta"         => "pt",
  "lvs"         => "icv",
  "drc"         => "icv",
  "rc_extract"  => "starrc",
  "synth"       => "dc",
  "lec"         => "fm",
  "timing_opt"  => "tweaker",
  "power"       => "ptpx",
  "scan_insert" => "dc",
  "atpg"        => "tmax",
  "sim"         => "vcs",
  "lint"        => "spyglass",
  "rtl_power"   => "spyglass",
  "cdc"         => "conformal_ec",
  "hydra"       => "hydra",
    );

our %glb_default_tool_options = (
  "edi"       => "-init -64",
  "icc2"      => "-64bit -f",
  "innovus"   => "-64 -no_gui -init",
  "pt"        => "-file",
  "ets"       => "",
  "tempus"    => "-nowin -file",
  "calibre"   => "-64", #-hier -turbo -hyper
  "icv"       => "",
  "starrc"    => "",
  "qrc"       => "-cmd",
  "rc"        => "",
  "dc"        => "-f",
  "conformal" => "",
  "conformal_ec" => "-verify -nogui -tclmode -64 -dofile",
  "conformal_cd" => "-nogui -dofile",
  "fm"        => "-64 -file",
  "tweaker"   => "-pre_check -no_gui -t -cmd",
  "voltus"    => "-nowin -init",
  "ptpx"      => "-f",
  "joules"    => "-batch -abort_on_error -files",
  "tmax"      => "-nogui",
  "vcs"       => "-full64 -file",
  "spyglass"  => "-tcl",
  "powerartist" => "-tcl",
  "hydra"     => "",
    );

our %glb_default_tool_bin_names = (
  "edi"       => "",
  "icc2"      => "icc2_shell",
  "innovus"   => "",
  "pt"        => "pt_shell",
  "ets"       => "",
  "tempus"    => "",
  "calibre"   => "calibre",
  "icv"       => "icv",
  "starrc"    => "StarXtract",
  "qrc"       => "",
  "rc"        => "",
  "dc"        => "dc_shell",
  "conformal" => "",
  "conformal_ec" => "lec",
  "conformal_cd" => "CCD-T",
  "fm"        => "fm_shell",
  "tweaker"   => "",
  "voltus"    => "",
  "ptpx"      => "pt_shell",
  "joules"    => "joules",
  "tmax"      => "tmax",
  "vcs"       => "vcs",
  "spyglass"  => "sg_shell",
  "powerartist" => "pa_shell",
    );

our %glb_default_log_style = (
  "edi"       => "option:-log",
  "icc2"      => "tee",
  "innovus"   => "option:-log",
  "pt"        => "tee",
  "ets"       => "tee",
  "tempus"    => "option:-log",
  "calibre"   => "tee",
  "icv"       => "",
  "starrc"    => "teestderr",
  "qrc"       => "tee",
  "rc"        => "tee",
  "dc"        => "tee",
  "conformal" => "tee",
  "conformal_ec" => "option:-logfile",
  "conformal_cd" => "option:-logfile",
  "fm"        => "tee",
  "tweaker"   => "option:-log",
  "voltus"    => "option:-log",
  "ptpx"      => "tee",
  "joules"    => "option:-log",
  "tmax"      => "tee",
  "vcs"       => "option:-l",
  "spyglass"  => "option:-shell_log_file",
  "powerartist" => "option:-log",
  "hydra"     => "",
    );

our @glb_default_tool_order = ("pnr",
                               "sta",
                               "lec",
                               "rc_extract",
                               "lvs",
                               "drc",
                               "synth",
                               "timing_opt",
                               "power",
                               "scan_insert",
                               "atpg",
                               "sim",
                               "lint",
                               "rtl_power",
                               "cdc",
                               "hydra",
    );

our %glb_flow_type_map = ("fix_timing" => "sta",
    );

our %glb_tools = ();

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub initialize_tools {
  my ($Paramref) = @_;
  %glb_tools = %glb_default_tools;
  foreach my $flow_type (keys %glb_tools) {
    next if ($flow_type eq "hydra");
    $glb_tools{$flow_type} = $Paramref->get_param_value("HYDRA_${flow_type}_tool", "strict");
  }
}

sub pre_initialize_tools {
  %glb_tools = %glb_default_tools;
  foreach my $flow_type (keys %glb_tools) {
    if (&Hydra::Util::Option::is_option("-${flow_type}_tool")) {
      $glb_tools{$flow_type} = &Hydra::Util::Option::get_opt_value_scalar("-${flow_type}_tool", "strict");
    }
  }
}

sub get_initialized_tools {
  # Get hash of tools; used for Summary module
  my ($Paramref) = @_;
  my %tools = %glb_default_tools;
  foreach my $flow_type (keys %tools) {
    next if ($flow_type eq "hydra");
    $tools{$flow_type} = $Paramref->get_param_value("HYDRA_${flow_type}_tool", "relaxed", "");
  }
  return \%tools;
}

sub get_tool {
  my ($flow_type) = @_;
  if (defined $glb_flow_type_map{$flow_type}) {
    $flow_type = $glb_flow_type_map{$flow_type};
  }

  if (!defined $glb_tools{$flow_type}) {
    die "ERROR: tool not found for flow type=${flow_type}\n";
  }
  return $glb_tools{$flow_type};
}

sub get_tool_command {
  my ($Paramref, $run_type, $file_path, $flow_options) = @_;
  $flow_options = "" if (!defined $flow_options);
  my $tool_binary    = &get_tool_binary($Paramref, $run_type);
  my $tool_options   = &get_tool_options($Paramref, $run_type);
  my $user_options   = &get_user_options($Paramref, $run_type);
  my $tool_log_style = &get_tool_log_style($run_type);
  my $log_name       = &Hydra::Util::File::get_file_name_from_path($file_path);
  $log_name =~ s/\.[^\.\s]+$/\.log/;

  my $command;
  if ($tool_log_style =~ /option\:(\S+)/) {
    my $log_option = $1;
    $command = "${tool_binary} ${flow_options} ${user_options} ${log_option} log/${log_name} ${tool_options} ${file_path}";
  }
  elsif ($tool_log_style =~ /teestderr/) {
    $command = "${tool_binary} ${flow_options} ${user_options} ${tool_options} ${file_path} |& tee log/${log_name}";
  }
  else {
    # Use tee by default
    $command = "${tool_binary} ${flow_options} ${user_options} ${tool_options} ${file_path} | tee log/${log_name}";
  }

  return $command;
}

sub get_default_tool_binary {
  my ($tool) = @_;
  if (defined $glb_default_tool_bin_names{$tool}) {
    my $bin = `which $glb_default_tool_bin_names{$tool} 2> /dev/null`;
    chomp($bin);
    if ($bin !~ /no \Q$glb_default_tool_bin_names{$tool}\E in/ && $bin !~ /^\s*$/) {
      return $bin;
    }
  }

  return "<required>";
}

sub get_tool_binary {
  my ($Paramref, $flow_type) = @_;
  return $Paramref->get_param_value("HYDRA_${flow_type}_bin", "strict");
}

sub get_tool_options {
  my ($Paramref, $flow_type) = @_;
  my $tool = &get_tool($flow_type);
  return $glb_default_tool_options{$tool};
}

sub get_user_options {
  my ($Paramref, $flow_type, $file_name) = @_;
  return $Paramref->get_param_value("HYDRA_${flow_type}_options");
}

sub get_tool_log_style {
  my ($flow_type) = @_;
  my $tool = &get_tool($flow_type);
  return $glb_default_log_style{$tool};
}

sub get_all_flow_types {
  return @glb_default_tool_order;
}


1;
