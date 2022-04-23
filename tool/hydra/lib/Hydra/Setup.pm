#------------------------------------------------------
# Module Name: Setup
# Date:        Mon Jan 28 12:20:24 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup;

use Hydra::Setup::Param;
use Hydra::Setup::Control;
use Hydra::Setup::Run;
use Hydra::Setup::Eco;
use Hydra::Setup::Tool;
use Hydra::Setup::File;
use Hydra::Setup::Flow;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our $glb_param_template_dir = "$ENV{HYDRA_HOME}/param";
our $glb_flow_module_dir    = "$ENV{HYDRA_HOME}/lib/Hydra/Setup/Flow";

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub setup {
  my $aref_param_files = &Hydra::Util::Option::get_opt_value_array("-param", "strict");
  my $control_file     = &Hydra::Util::Option::get_opt_value_scalar("-control", "strict");
  my $aref_runs        = &Hydra::Util::Option::get_opt_value_array("-run", "relaxed", []);
  my $out_dir          = &Hydra::Util::Option::get_opt_value_scalar("-out_dir", "relaxed", undef);

  # Create param object
  my $Param = new Hydra::Setup::Param(@$aref_param_files);

  # Create control object
  my $Control = new Hydra::Setup::Control($Param, $control_file);

  # Initialize tool info
  &Hydra::Setup::Tool::initialize_tools($Control);
  my %error_params = &Hydra::Setup::Control::get_error_params;
  &Hydra::Setup::Control::reset_error_params;
  if (&Hydra::Setup::Control::check_error_params(\%error_params, "initialize_tools")) {
    die;
  }

  # Initialize flow info
  &Hydra::Setup::Flow::initialize_flows;
  
  # Write runs
  if (scalar(@$aref_runs) > 0) {
    $Control->write_runs($aref_runs, $out_dir);
  }
  else {
    $Control->write_all_runs($out_dir);
  }
}

sub init_proj_dir {
  my @dir_names = (
    "HYDRA",
    "HYDRA/control",
    "HYDRA/param",
    "STATION",
    "STATION/incoming",
    "STATION/outgoing",
    "DATA",
    "DATA/block",
    "DATA/block/vlg",
    "DATA/block/mdb",
    "DATA/block/lib_db",
    "DATA/sta",
    "DATA/lvs",
    "SOURCE",
    "SOURCE/floorplan",
    "SOURCE/power",
    "SOURCE/cts",
    "SOURCE/cts/exceptions",
    "SOURCE/cts/sdc",
    "SOURCE/eco",
    "SOURCE/eco/eco01",
    "SOURCE/eco/eco02",
    "WORK",
      );

  foreach my $dir_name (@dir_names) {
    &Hydra::Util::File::make_dir($dir_name);
  }
}

sub init_param_files {
  my $proj_name = &Hydra::Util::Option::get_opt_value_scalar("-proj_name", "strict");
  &Hydra::Setup::Tool::pre_initialize_tools;
  &Hydra::Setup::Flow::initialize_flows;

  # Read config file
  my %config = &read_param_config_file;

  my %params          = ();
  my %flows           = ();
  my %seen_tools      = ();
  my %required_params = ();
  my @flow_list       = ();
  my $max_length      = 0;
  # Parse all flows for the given tools
  foreach my $flow_type (&Hydra::Setup::Tool::get_all_flow_types) {
    my $tool = &Hydra::Setup::Tool::get_tool($flow_type);
    next if (defined $seen_tools{$tool});
    $seen_tools{$tool} = 1;

    foreach my $flow_name (&Hydra::Setup::Flow::get_all_sorted_flows_of_tool($tool, @{ $config{flow}{array} })) {
      my $module   = &Hydra::Setup::Flow::get_flow_module($flow_name);
      my $sub_name = &Hydra::Setup::Flow::get_flow_sub_name($flow_name, $tool);
      if (defined $sub_name) {
        my $module_file = "${glb_flow_module_dir}/${module}.pm";
        my %data = &Hydra::Setup::Flow::parse_flow_sub_for_params($module_file, $sub_name);
        push(@flow_list, $flow_name);

        foreach my $param_name (@{ $data{params} }) {
          # String length
          $max_length = length($param_name) if (length($param_name) > $max_length);
              
          # Params under flow
          push(@{ $params{$flow_name} }, $param_name);
          
          # Flows under param
          $flows{$param_name}{$flow_name} = 1;
        }
        foreach my $param_name (keys %{ $data{required} }) {
          # Required params
          $required_params{$param_name} = 1;
        }
      }
    }
  }

  # Add HYDRA group to flow list, for params not associated with a flow
  unshift(@flow_list, "HYDRA");

  # Add tool params to HYDRA group
  foreach my $flow_type (&Hydra::Setup::Tool::get_all_flow_types) {
    # Skip flow type "hydra", used for flows like library creation
    next if ($flow_type eq "hydra");
    my $tool = &Hydra::Setup::Tool::get_tool($flow_type);
    unshift(@{ $params{HYDRA} }, "HYDRA_${flow_type}_tool");
    unshift(@{ $params{HYDRA} }, "HYDRA_${flow_type}_bin");
    unshift(@{ $params{HYDRA} }, "HYDRA_${flow_type}_options");
  }

  # Add proj home param to HYDRA group
  unshift(@{ $params{HYDRA} }, "HYDRA_proj_home");
  
  # Add global params to HYDRA group
  foreach my $global (&Hydra::Setup::Param::get_global_param_list) {
    unshift(@{ $params{HYDRA} }, $global);
  }
  
  # Check all params for conflicting grouping
  # Move params to prefer matching prefix to flow name
  # Add to HYDRA group if there is no matching prefix
  foreach my $param_name (keys %flows) {
    if (scalar(keys %{ $flows{$param_name} })) {
      $param_name =~ /^([A-Z_]+)/;
      my $prefix = $1;
      $prefix =~ s/_$//;

      # Delete param from all flow groups in prep for adding it to the correct flow
      my @param_flows = keys %{ $flows{$param_name} };
      push(@param_flows, "HYDRA");
      foreach my $flow_name (@param_flows) {
        for (my $i = 0; $i <= $#{ $params{$flow_name} }; $i++) {
          my $cur_param = $params{$flow_name}[$i];
          if ($param_name eq $cur_param) {
            splice(@{ $params{$flow_name} }, $i, 1);
            last;
          }
        }
      }

      if (defined $config{prefix}{$prefix}) {
        my $flow_name = $config{prefix}{$prefix};
        push(@{ $params{$flow_name} }, $param_name);
      }
      elsif (defined $flows{$param_name}{$prefix}) {
        # Add param to the matched flow
        push(@{ $params{$prefix} }, $param_name);
      }
      else {
        # Add param to the HYDRA group
        push(@{ $params{HYDRA} }, $param_name);
      }
    }
  }

  # Write param file
  my $proj_param_file = "${proj_name}.proj.param";
  my $fh_proj = &Hydra::Util::File::backup_and_open_file_for_write($proj_param_file);
  &print_param_header_comments($fh_proj);
  my $divider = "#---------------------------------------------\n";
  my %hydra_params = map {$_ => 1} @{ $params{HYDRA} };
  foreach my $flow_name (@flow_list) {
    next if (!defined $params{$flow_name} || scalar(@{ $params{$flow_name} }) <= 0);
    print $fh_proj $divider;
    print $fh_proj "# $flow_name\n";
    print $fh_proj $divider;

    foreach my $param_name (sort @{ $params{$flow_name} }) {
      next if ($flow_name ne "HYDRA" && defined $hydra_params{$param_name});
      my $param_value = "";
      if (defined $config{param}{$param_name}{value}) {
        # Get default param value from config
        $param_value = $config{param}{$param_name}{value};
      }
      elsif (defined $required_params{$param_name} || $param_name =~ /HYDRA_.*_bin/) {
        # Param is required
        $param_value = "<required>";
      }

      # Print comments for this param
      if (defined $config{param}{$param_name}{comment}) {
        foreach my $comment_string (@{ $config{param}{$param_name}{comment} }) {
          print $fh_proj "#${comment_string}\n";
        }
      }

      if ($param_name =~ /^HYDRA_(\S+?)_tool/) {
        # For tool params, get the specified tool
        my $flow_type   = $1;
        my $param_value = &Hydra::Setup::Tool::get_tool($flow_type);
        printf $fh_proj "%-${max_length}s = ${param_value}\n", $param_name;
      }
      elsif ($param_name =~ /^HYDRA_(\S+?)_bin/) {
        # Attempt to get tool binary
        my $flow_type = $1;
        my $tool      = &Hydra::Setup::Tool::get_tool($flow_type);
        my $bin       = &Hydra::Setup::Tool::get_default_tool_binary($tool);
        printf $fh_proj "%-${max_length}s = ${bin}\n", $param_name;
      }
      else {
        # Print param normally
        printf $fh_proj "%-${max_length}s = ${param_value}\n", $param_name;
      }
    }
    print $fh_proj "\n";
  }
  &Hydra::Util::File::close_file($fh_proj);

  # Write example control file
  my $control_file = "${proj_name}.control";
  my $fh_control   = &Hydra::Util::File::backup_and_open_file_for_write($control_file);
  print $fh_control "START run01\n";
  print $fh_control "  # List flows here\n";
  print $fh_control "  FLOW = PNR\n";
  print $fh_control "  \n";
  print $fh_control "  # List param overrides here\n";
  print $fh_control "\n";
  print $fh_control "END\n";
  print $fh_control "\n";
  &Hydra::Util::File::close_file($fh_control);
}

sub print_param_header_comments {
  my ($fh_out) = @_;
  my $date = localtime;
  my $line = "";

  $line .= "#------------------------------------------------------------------------------------\n";
  $line .= "# Hydra Param File\n";
  $line .= "# Generated: $date\n";
  $line .= "#\n";
  $line .= "# Params with <required> tag MUST have a value.\n";
  $line .= "#\n";
  $line .= "#------------------------------------------------------------------------------------\n";
  $line .= "\n";

  print $fh_out $line;
}

sub get_param_config_file {
  return "${glb_param_template_dir}/param.config";
}

sub read_param_config_file {
  my %config = ();
  # %config => {
  #   flow => {
  #     hash => {
  #       $entry = 1
  #     }
  #     array => \@entries
  #   }
  #   param => {
  #     $param_name => {
  #       value = <str>
  #       comment => \@comments
  #     }
  #   }
  #   prefix => {
  #     $prefix = <flow_name>
  #   }
  # }

  my $list_type = "param";
  my $param_config_file = &get_param_config_file;
  if (defined $param_config_file) {
    my $fh_in = &Hydra::Util::File::open_file_for_read($param_config_file);
    while (my $line = <$fh_in>) {
      next if ($line =~ /^\s*\/\//);

      if ($line =~ /<FLOW_LIST>/) {
        $list_type = "flow";
        next;
      }
      elsif ($line =~ /<\/FLOW_LIST>/) {
        $list_type = "param";
        next;
      }
      
      if ($list_type =~ /flow/) {
        # Flow list
        chomp($line);
        $config{flow}{hash}{$line} = 1;
        push(@{ $config{flow}{array} }, $line);
      }
      elsif ($list_type =~ /param/ && $line =~ /(^\s*(\S+)\s*\=).*/) {
        # Param Definition
        my $left_side_def = $1;
        my $param_name    = $2;
        
        # Append following lines if there is a linebreak
        if ($line =~ /\\\s*$/) {
          while (my $subline = <$fh_in>) {
            $line .= $subline;
            last if ($subline !~ /\\\s*$/);
          }
        }
        
        chomp($line);
        $line =~ s/\Q$left_side_def\E//;
        $line =~ s/^\s*//;
        $line =~ s/\s*$//;
        $config{param}{$param_name}{value} = $line if ($line !~ /^\s*$/);
      }
      elsif ($list_type =~ /param/ && $line =~ /^\s*\#<(\S+)>(.*)/) {
        # Param Comment
        my $param_name      = $1;
        my $comment_content = $2;
        push(@{ $config{param}{$param_name}{comment} }, $comment_content);
      }
      elsif ($list_type =~ /param/ && $line =~ /^\s*(\S+)\s*\-\>\s*(.*)\s*/) {
        # Flow prefix mapping
        my $flow_name = $1;
        my @prefixes = split(/\s+/, $2);
        foreach my $prefix (@prefixes) {
          $config{prefix}{$prefix} = $flow_name;
        }
      }
    }
    &Hydra::Util::File::close_file($fh_in);
  }

  return %config;
}


1;
