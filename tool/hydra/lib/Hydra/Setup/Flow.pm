#------------------------------------------------------
# Module Name: Flow
# Date:        Tue Jan 29 15:23:24 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::Flow;

use Hydra::Setup::Flow::PNR;
use Hydra::Setup::Flow::LEC;
use Hydra::Setup::Flow::STA;
use Hydra::Setup::Flow::RC_EXTRACT;
use Hydra::Setup::Flow::SYNTH;
use Hydra::Setup::Flow::SCAN_INSERT;
use Hydra::Setup::Flow::ATPG;
use Hydra::Setup::Flow::SIM;
use Hydra::Setup::Flow::LVS;
use Hydra::Setup::Flow::DRC;
use Hydra::Setup::Flow::POWER;
use Hydra::Setup::Flow::LINT;
use Hydra::Setup::Flow::RTL_POWER;
use Hydra::Setup::Flow::FIX_TIMING;
use Hydra::Setup::Flow::CDC;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my %all_flows = ();

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
# sub dispatch {
#   my ($Paramref, $flow_name) = @_;
#   my $subref = \&{ "Hydra::Setup::Flow::${flow_name}::get_type" };

#   my $tool = &Hydra::Setup::Tool::get_tool($subref->());
#   my $sub_name;
#   if ($flow_name =~ /^([^\s\.]+)\.([^\s\.]+)$/) {
#     $sub_name = "${tool}_${2}";
#   }
#   else {
#     $sub_name = "${tool}_std";
#   }

#   $subref = \&{ "Hydra::Setup::Flow::${flow_name}::${sub_name}" };
#   return $subref->($Paramref);
# }

sub dispatch {
  my ($Paramref, $flow_name, $KickoffFile) = @_;
  my $type     = &get_flow_type($flow_name);
  if (!defined $type) {
    die "ERROR: flow $flow_name not found!\n";
  }
  my $tool     = &Hydra::Setup::Tool::get_tool($type);
  my $module   = &get_flow_module($flow_name);
  my $sub_name = &get_flow_sub_name($flow_name, $tool);
  
  my $subref = \&{ "Hydra::Setup::Flow::${module}::${sub_name}" };
  return $subref->($Paramref, $KickoffFile);
}

sub initialize_flows {
  my $flow_dir = "$ENV{HYDRA_HOME}/lib/Hydra/Setup/Flow";
  my @entries = &Hydra::Util::File::get_dir_files($flow_dir);

  foreach my $entry (@entries) {
    my $module = $entry;
    $module =~ s/\.pm//;
    my $run_type;
    my $tool;
    my $flow;
    my $sub_type;
    my $in_header = 0;
    my $fh_in = &Hydra::Util::File::open_file_for_read("${flow_dir}/${entry}");
    while (my $line = <$fh_in>) {
      if ($line =~ /^\s*\#\s*Type:\s+(\S+)\s*$/) {
        $run_type = $1;
      }
      elsif ($line =~ /^\s*\#\+\+\s*$/) {
        $in_header = 1;
      }
      elsif ($line =~ /^\s*\#\-\-\s*$/) {
        $in_header = 0;
      }
      elsif ($in_header && $line =~ /^\s*\#\s*Tool:\s+(\S+)\s*$/) {
        $tool = $1;
      }
      elsif ($in_header && $line =~ /^\s*\#\s*Flow:\s+(\S+)\s*$/) {
        $flow = $1;
      }
      elsif ($in_header && $line =~ /^\s*\#\s*Subtype:\s+(\S+)\s*$/) {
        $sub_type = $1;
      }
      elsif ($line =~ /^\s*sub\s+(\S+)/) {
        my $sub_name = $1;

        if (defined $run_type && defined $tool && defined $flow) {
          $all_flows{$flow}{sub_type}    = $sub_type;
          $all_flows{$flow}{run_type}    = $run_type;
          $all_flows{$flow}{module}      = $module;
          $all_flows{$flow}{subs}{$tool} = $sub_name;
        }

        $sub_type = undef;
        $tool = undef;
        $flow = undef;
      }
    }
    &Hydra::Util::File::close_file($fh_in);
  }
}

sub get_all_flow_tools {
  my ($flow_name) = @_;
  return sort keys %{ $all_flows{$flow_name}{subs} };
}

sub get_all_flows {
  return sort keys %all_flows;
}

sub get_all_flows_of_tool {
  my ($find_tool) = @_;
  my @flows = ();
  foreach my $flow_name (keys %all_flows) {
    foreach my $tool (keys %{ $all_flows{$flow_name}{subs} }) {
      if ($find_tool eq $tool) {
        push(@flows, $flow_name);
      }
    }
  }

  my %dup = map {$_ => 1} @flows;
  @flows = sort keys %dup;
  return @flows;
}

sub get_all_sorted_flows_of_tool {
  my ($find_tool, @flow_list) = @_;
  my @flows = ();
  my @unsorted_flows = &get_all_flows_of_tool($find_tool);
  my %unsorted_flows = map {$_ => 1} @unsorted_flows;
  
  # Add flows to list in order if they exist
  foreach my $flow_name (@flow_list) {
    if (defined $unsorted_flows{$flow_name}) {
      push(@flows, $flow_name);
      delete $unsorted_flows{$flow_name};
    }
  }

  # Add the rest of the flows alphabetically
  foreach my $flow_name (sort keys %unsorted_flows) {
    push(@flows, $flow_name);
  }

  return @flows;
}

sub get_flow_sub_type {
  my ($flow_name) = @_;
  return $all_flows{$flow_name}{sub_type};
}

sub is_flow_eco_only {
  my ($flow_name) = @_;
  my $sub_type = &get_flow_sub_type($flow_name);
  if (defined $sub_type && $sub_type =~ "eco") {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_flow_type {
  my ($flow_name) = @_;
  return $all_flows{$flow_name}{run_type};
}

sub get_flow_module {
  my ($flow_name) = @_;
  return $all_flows{$flow_name}{module};
}

sub get_flow_sub_name {
  my ($flow_name, $tool) = @_;
  return $all_flows{$flow_name}{subs}{$tool};
}

sub get_flow_from_sub_name {
  my ($sub_name) = @_;
  
  foreach my $flow_name (keys %all_flows) {
    my $module_search = $all_flows{$flow_name}{module};
    foreach my $tool (keys %{ $all_flows{$flow_name}{subs} }) {
      my $sub_search = $all_flows{$flow_name}{subs}{$tool};
      $sub_search    = "Hydra::Setup::Flow::${module_search}::${sub_search}";
      if ($sub_name eq $sub_search) {
        return ($flow_name, $tool);
      }
    }
  }

  return (undef, undef);
}

sub write_std_kickoff {
  my ($Paramref, $File, @scripts) = @_;

  my $time = localtime;
  $File->add_line("#!/usr/bin/bash");
  $File->add_line("# Generated by Hydra on $time");
  $File->add_line("export HYDRA_HOME=$ENV{HYDRA_HOME}");
  $File->add_linebreak;

  foreach my $script_name (@scripts) {
    my $tool_command = &Hydra::Setup::Tool::get_tool_command($Paramref, $File->get_type, $script_name);
    $File->add_line($tool_command);
  }

  $File->make_executable;

  return;
}

sub add_kickoff_command {
  my ($Paramref, $File, $script, $flow_options) = @_;

  my $tool_command = &Hydra::Setup::Tool::get_tool_command($Paramref, $File->get_type, $script, $flow_options);
  $File->add_line($tool_command);

  return;
}

sub write_source_catchall {
  my ($Paramref, $prefix, @keys) = @_;
  my $line = "";

  my $global_source = $Paramref->get_param_value("${prefix}_source_catchall_global", "relaxed", @keys);
  my $local_source  = $Paramref->get_param_value("${prefix}_source_catchall_local", "relaxed", @keys);
  if (&Hydra::Setup::Param::has_value($global_source) || &Hydra::Setup::Param::has_value($local_source)) {
    $line .= "# Source catchall\n";
  }
  $line .= &write_repeating_param("source", $global_source);
  $line .= &write_repeating_param("source", $local_source);
  $line .= "\n";

  return $line;
}

sub write_repeating_param {
  my ($command, $param_value, $fix_relative_path) = @_;
  my $line = "";
  
  if (&Hydra::Setup::Param::has_value($param_value)) {
    $param_value = &Hydra::Setup::Param::remove_param_value_linebreak($param_value);
    foreach my $single_value (split(/\s+/, $param_value)) {
      if (defined $fix_relative_path) {
        $single_value = &fix_relative_path($single_value);
      }

      $line .= "$command $single_value\n";
    }
  }

  return $line;
}

# Adds a "../" to a relative path file
sub fix_relative_path {
  my ($filename) = @_;
  if ($filename !~ /^\//) {
    $filename = "../${filename}";
  }
  return $filename;
}

sub parse_scenario_value {
  my ($value) = @_;
  my %scenario_tags = (lib_name     => "",
                       corner_speed => "",
                       corner_cts   => 0,
                       sta          => 0,
                       sta_dmsa     => 0,
                       sta_sdf      => 0,
                       sta_lib      => 0,
                       sta_fullchip => 0,
                       sta_dmsa_fullchip => 0,
                       synth        => 0,
                       lec          => 0,
                       scan_insert  => 0,
                       power        => 0,
                       rc_extract   => 0,
                       lint         => 0,
                       rtl_power    => 0,
                       sta_margin   => "",
                       cdc          => 0,
      );

  my @tokens = split(/\s+/, $value);
  foreach my $token (@tokens) {
    if ($token =~ /^(pnr_slow|pnr_fast|pnr_setup|pnr_hold|pnr_both)$/) {
      $scenario_tags{corner_speed} = $token;
    }
    elsif ($token =~ /^pnr_cts$/) {
      $scenario_tags{corner_cts} = 1;
    }
    elsif ($token =~ /^(sta|sta_dmsa|sta_fullchip|sta_dmsa_fullchip|synth|lec|scan_insert|power|rc_extract|lint|rtl_power|sta_sdf|sta_lib|cdc)$/) {
      $scenario_tags{$1} = 1;
    }
    elsif ($token =~ /^sta_margin\.(\S+)$/) {
      $scenario_tags{sta_margin} = $1;
    }
    else {
      $scenario_tags{lib_name} = $token;
    }
  }

  return %scenario_tags
}

sub get_scenario_lib_var {
  my ($Paramref, $flow_name, $lib_type) = @_;
  
  my $lib_var = "";
  my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);
  my %lib_corners = ();
  foreach my $aref_keys (@keysets) {
    my $scenario_value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);
    my %scenario_tags  = &Hydra::Setup::Flow::parse_scenario_value($scenario_value);
    if ($scenario_tags{lc($flow_name)}) {
      my ($mode, $process, $temp, $rc) = @$aref_keys;
      $lib_corners{"$process $temp"} = 1;
    }
  }
  if (scalar(keys %lib_corners) != 1) {
    my $key_string = "";
    foreach my $corner_string (sort keys %lib_corners) {
      my ($process, $temp) = split(/\s+/, $corner_string);
      $key_string .= "($process)($temp), ";
    }
    $key_string =~ s/\,\s*$//;
    $key_string = "(NO_SCENARIO)" if ($key_string eq "");
    &Hydra::Setup::Control::register_error_param("${flow_name}: $key_string", "lib_corner");
  }
  else {
    my @keys = keys %lib_corners;
    my ($process, $temp) = split(/\s+/, $keys[0]);
    $lib_var = &Hydra::Setup::Flow::HYDRA::get_lib_var($Paramref, $lib_type, $process, $temp);
  }

  return $lib_var;
}

sub parse_flow_sub_for_params {
  my ($module_file, $sub_name) = @_;
  my %data        = ();
  $data{params}   = [];
  $data{required} = {};
  
  my $fh_in  = &Hydra::Util::File::open_file_for_read($module_file);
  my $in_sub = 0;
  my %vars   = ();
  while (my $line = <$fh_in>) {
    if ($line =~ /^\s*sub\s+${sub_name}\s+\{/) {
      $in_sub = 1;
    }
    elsif ($line =~ /^\s*sub\s+/) {
      $in_sub = 0;
    }
    next if (!$in_sub);

    if ($line =~ /get_param_value\(\"(\S+?)\"/) {
      my $param_name = $1;
      if ($line =~ /\"strict\"/) {
        $data{required}{$param_name} = 1;
      }

      if ($param_name =~ /(\$\{(\S+?)\})_/) {
        # Replace variables within param name with values from comment directives
        my $complete_var = $1;
        my $var_name     = $2;
        if (defined $vars{$var_name}) {
          foreach my $val (@{ $vars{$var_name} }) {
            my $resolved_param_name = $param_name;
            $resolved_param_name =~ s/\Q${complete_var}\E/$val/;
            push(@{ $data{params} }, $resolved_param_name);
          }
        }
        else {
          die "ERROR: No var name found for param: $param_name\n";
        }
      }
      else {
        # Normal param name
        push(@{ $data{params} }, $param_name);
      }
    }
    elsif ($line =~ /write_source_catchall\(.*\"(\S+)\"/) {
      my $prefix = $1;
      push(@{ $data{params} }, "${prefix}_source_catchall_global");
      push(@{ $data{params} }, "${prefix}_source_catchall_local");
    }
    elsif ($line =~ /\# HYDRA_PARSE: \$(\S+) =\s*(.*)\s*/) {
      # Save values from comment directives for use when resolving param names
      my $var_name = $1;
      my @var_vals = split(/\s+/, $2);
      $vars{$var_name} = \@var_vals;
    }
  }
  &Hydra::Util::File::close_file($fh_in);

  return %data;
}

sub parse_self_for_params {
  my ($file_name, $sub_name, $subtype) = @_;
  $subtype = "HYDRA_UNDEF" if (!defined $subtype);
  my @param_list = ();

  my $fh_in = &Hydra::Util::File::open_file_for_read($file_name);
  my $in_sub = 0;
  my $dont_parse = 0;
  while (my $line = <$fh_in>) {
    if ($line =~ /^\s*sub\s+${sub_name}\s+\{/) {
      $in_sub = 1;
    }
    elsif ($line =~ /^\s*sub\s+/) {
      $in_sub = 0;
    }
    next if (!$in_sub);

    if (!$dont_parse && $line =~ /get_param_value\(\"(\S+?)\"/) {
      push(@param_list, $1);
    }
    elsif (!$dont_parse && $line =~ /write_source_catchall\(.*\"(\S+)\"/) {
      my $prefix = $1;
      push(@param_list, "${prefix}_source_catchall_global");
      push(@param_list, "${prefix}_source_catchall_local");
    }
    elsif ($line =~ /\# StartParseSelfSubtype: (\S+)/) {
      if ($subtype ne $1) {
        $dont_parse = 1;
      }
    }
    elsif ($line =~ /\# EndParseSelfSubtype: (\S+)/) {
      if ($subtype ne $1) {
        $dont_parse = 0;
      }
    }
  }
  &Hydra::Util::File::close_file($fh_in);

  return @param_list;
}

1;
