#------------------------------------------------------
# Module Name: PromoteSdc
# Date:        Thu Jun  6 15:43:16 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::PromoteSdc;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_tmp_file = ".tmp.sdc";

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub promote_sdc {
  my $netlist            = &Hydra::Util::Option::get_opt_value_scalar("-netlist", "relaxed", undef);
  my $user_inst          = &Hydra::Util::Option::get_opt_value_scalar("-target_inst", "relaxed", undef);
  my $sdc                = &Hydra::Util::Option::get_opt_value_scalar("-sdc", "strict");
  my $target_module      = &Hydra::Util::Option::get_opt_value_scalar("-module", "relaxed", undef);
  my $input_delay        = &Hydra::Util::Option::get_opt_value_scalar("-input_delay", "relaxed", "0");
  my $output_delay       = &Hydra::Util::Option::get_opt_value_scalar("-output_delay", "relaxed", "0");
  my $aref_remove_clocks = &Hydra::Util::Option::get_opt_value_array("-remove_clocks", "relaxed", []);
  my %remove_clocks = map{$_ => 1} @$aref_remove_clocks;

  # Get name of module to promote from sdc file name
  if (!defined $target_module) {
    $target_module = &Hydra::Util::File::get_file_name_from_path($sdc);
    $target_module =~ s/\..*$//;
  }

  my $target_inst;
  my $href_ports;
  if (defined $netlist) {
    # Read netlist
    &Hydra::Util::File::print_unbuffered("INFO: Reading netlist $netlist\n");
    my ($top_module, $netlist_inst, $href_netlist_ports) = &parse_netlist($netlist, $target_module);
    $target_inst = $netlist_inst;
    $href_ports  = $href_netlist_ports;
    if (!defined $top_module) {
      die "ERROR: Top module for $target_module not found in netlist!\n";
    }
  }
  elsif (defined $user_inst) {
    $target_inst = $user_inst;
    $href_ports  = {};
  }
  else {
    die "ERROR: Neither -netlist nor -target_inst is defined!\n";
  }
  
  # Get all sdc commands pre-tokenized
  &Hydra::Util::File::print_unbuffered("INFO: Reading sdc $sdc\n");
  my @commands = &parse_sdc($sdc);

  # Process all sdc commands and print to new sdc
  my $out_file = &Hydra::Util::File::get_file_name_from_path($sdc) . ".promoted";
  &Hydra::Util::File::print_unbuffered("INFO: Promoting sdc...\n");
  my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
  foreach my $aref_command (@commands) {
    if (ref($aref_command) eq "" && $aref_command =~ /^\s*\#/) {
      # Print comments directly
      print $fh_out "$aref_command\n";
      next;
    }

    my @tokens = @$aref_command;
    my $command = shift @tokens;

    my $stmt = "";
    if ($command eq "create_clock") {
      $stmt .= "create_generated_clock ";
      # Search all tokens for a name; if not found then use the clock name
      my $clock_name;
      my $clock_ref;
      foreach my $idx (0..$#tokens) {
        my $token = $tokens[$idx];
        if ($token eq "-name") {
          $clock_name = $tokens[$idx+1];
          last;
        }
        elsif ($token =~ /(HYDRAPORT|HYDRAPIN|HYDRANET)\$(\S+)/) {
          $clock_ref = $2;
        }
      }
      $clock_name = $clock_ref if (!defined $clock_name);

      if (defined $remove_clocks{$clock_name}) {
        # Dont print this create_clock statement if this clock is to be removed
        $stmt = "";
      }
      else {
        $stmt .= "-name $clock_name -source <required> -master_clock <required> -add -divide_by <required>";
        for (my $idx = 0; $idx <= $#tokens; $idx++) {
          my $token = &resolve_token($tokens[$idx], $target_inst, \%remove_clocks);
          if ($token eq "-name") {
            $idx++;
          }
          elsif ($token eq "-period") {
            $idx++;
          }
          elsif ($token eq "-waveform") {
            $idx++;
          }
          else {
            $stmt .= "$token ";
          }
        }
      }
    }
    else {
      $stmt .= "$command ";
      foreach my $idx (0..$#tokens) {
        my $token = &resolve_token($tokens[$idx], $target_inst, \%remove_clocks);
        if ($token eq "" && $command =~ /^set_clock/ && $command !~ /^(set_clock_groups|set_clock_gating_check)$/) {
          # For set_clock_* commands, just remove the entire statement if all clocks are removed
          # Dont remove set_clock_groups or set_clock_gating_check
          $stmt = "";
          last;
        }
        elsif ($token eq "" && $command =~ /^set_clock_groups$/) {
          # For set_clock_groups, if the token is empty then remove the previous token (probably the -group option)
          $stmt =~ s/\S+ $//;
        }
        elsif ($token eq "") {
          # A clock was removed that caused this token to be empty
          # Get the original token (with no clock removal) and comment out the statement
          $token = &resolve_token($tokens[$idx], $target_inst);
          $stmt .= "$token ";
          $stmt = "#${stmt}";
        }
        else {
          $stmt .= "$token ";
        }
      }

      # For set_clock_groups, check that there is at least one -group option, or else wipe out the statement
      if ($command =~ /^set_clock_groups$/ && $stmt !~ /-group/) {
        $stmt = "";
      }

      # For set_clock_groups, issue a warning if only one clock group is present
      if ($command =~ /^set_clock_groups$/) {
        my $num_groups = 0;
        while ($stmt =~ /-group/g) {
          $num_groups++;
        }

        if ($num_groups == 1) {
          $stmt =~ /-name\s+(\S+)/;
          my $clock_name = $1;
          print "WARN: Wrote out set_clock_group command for $clock_name with only one -group; check to see if this was intentional.\n";
        }
      }
    }
    $stmt .= "\n";

    print $fh_out $stmt;
  }

  # Print port delays
  foreach my $port_name (sort keys %$href_ports) {
    my $dir = $href_ports->{$port_name};
    if ($dir eq "input") {
      printf $fh_out "%-18s %-4s %s\n", "set_input_delay", $input_delay, "[get_ports $port_name]";
    }
    elsif ($dir eq "output") {
      printf $fh_out "%-18s %-4s %s\n", "set_output_delay", $output_delay, "[get_ports $port_name]";
    }
  }

  &Hydra::Util::File::close_file($fh_out);
}

sub resolve_token {
  my ($token, $target_inst, $href_remove_clocks) = @_;
  $href_remove_clocks = {} if (!defined $href_remove_clocks);
  my $ret_val = "";

  my @subtokens = split(/\s+/, $token);
  foreach my $subtoken (@subtokens) {
    if ($subtoken =~ /(HYDRAPIN|HYDRAPORT|HYDRANET|HYDRACELL|HYDRACLOCK)\$(\S+)/) {
      my $type = $1;
      my $name = $2;
      if ($type eq "HYDRACLOCK") {
        $subtoken =~ s/${type}\$\Q${name}\E/${name}/;
      }
      else {
        $subtoken =~ s/${type}\$\Q${name}\E/${target_inst}\/${name}/;
      }

      if ($type eq "HYDRAPIN") {
        $subtoken = "[get_pins $subtoken]";
      }
      elsif ($type eq "HYDRAPORT") {
        $subtoken = "[get_pins $subtoken]";
      }
      elsif ($type eq "HYDRANET") {
        $subtoken = "[get_nets $subtoken]";
      }
      elsif ($type eq "HYDRACELL") {
        $subtoken = "[get_cells $subtoken]";
      }
      elsif ($type eq "HYDRACLOCK") {
        my $no_braces = $subtoken;
        $no_braces =~ s/{|}//g;
        # Check to see if this clock should be removed
        if (defined $href_remove_clocks->{$subtoken} ||
            defined $href_remove_clocks->{$no_braces}) {
          $subtoken = "";
        }
        else {
          $subtoken = "[get_clocks $subtoken]";
        }
      }
    }
    
    $ret_val .= "$subtoken ";
  }
  $ret_val =~ s/\s*$//;

  if ($ret_val !~ /^\s*$/ && scalar(@subtokens) > 1) {
    $ret_val = "[list $ret_val]";
  }

  return $ret_val;
}

sub parse_sdc {
  my ($sdc) = @_;
  my @commands = ();

  my $fh_in = &Hydra::Util::File::open_file_for_read($sdc);
  my $stmt = "";
  while (my $line = <$fh_in>) {
    if ($line =~ /^\s*\#/) {
      # Save comments
      chomp($line);
      push(@commands, $line);
      next;
    }

    $line =~ s/\#.*$//;
    
    if ($line =~ /\s*\\\s*$/) {
      $line =~ s/\s*\\\s*$//;
      $stmt .= " $line";
      next;
    }
    else {
      $stmt .= " $line";
    }

    if ($stmt =~ /^\s*set_driving_cell/) {
    }
    elsif ($stmt =~ /^\s*set_load/) {
    }
    elsif ($stmt =~ /^\s*set_input_delay/) {
    }
    elsif ($stmt =~ /^\s*set_output_delay/) {
    }
    elsif ($stmt =~ /^\s*set_port_fanout_number/) {
    }
    elsif ($stmt =~ /^\s*group_path/) {
    }
    elsif ($stmt =~ /^\s*(\S+)/) {
      my $command = $1;
      my @tokens = &resolve_sdc_stmt($stmt);
      unshift(@tokens, $command);
      
      push(@commands, \@tokens);
    }

    $stmt = "";
  }
  &Hydra::Util::File::close_file($fh_in);

  return @commands;
}

sub resolve_sdc_stmt {
  my ($stmt) = @_;

  # Replace the command with resolve_args, which will echo back all args after tcl resolves them
  $stmt =~ s/^\s*(\S+)/resolve_args/;

  # Escape bus brackets
  $stmt =~ s/(\S)\[(\d+)\]/${1}\\[${2}\\]/g;

  my $output;

  if (length($stmt) < 1000) {
    $output = `tclsh $ENV{HYDRA_HOME}/script/tcl/run_cmd.tcl \"source $ENV{HYDRA_HOME}/script/tcl/sdc_resolver.tcl; $stmt\"`;
  }
  else {
    # For huge statements, print them to a temp script
    my $fh_tmp = &Hydra::Util::File::open_file_for_write($glb_tmp_file);
    print $fh_tmp "$stmt\n";
    &Hydra::Util::File::close_file($fh_tmp);
    
    $output = `tclsh $ENV{HYDRA_HOME}/script/tcl/run_cmd.tcl \"source $ENV{HYDRA_HOME}/script/tcl/sdc_resolver.tcl; source ./${glb_tmp_file}\"`;

    unlink($glb_tmp_file);
  }

  # Remove escape from bus brackets
  $output =~ s/\\\[/[/g;
  $output =~ s/\\\]/]/g;

  return split(/\n/, $output);
}

sub parse_netlist {
  my ($netlist, $target_module) = @_;
  my $target_inst;
  my $top_module;
  my %top_ports = ();

  # Find name of new top module by reading netlist
  local $/ = ";";
  my $fh_in = &Hydra::Util::File::open_file_for_read($netlist);
  my $cur_module;
  my %ports = ();
  my $comment_stmt = "";
  while (my $stmt = <$fh_in>) {
      # Remove comments
      $stmt =~ s/\/\/.*\n//g;

      # Remove group comments
      ### Someone doing something weird like /* */ */ will still probably not work...
      if ($stmt =~ /\/\*/) {
        if ($stmt =~ /\*\//) {
          $stmt =~ s/\/\*.*\*\///s;
        }
        else {
          $comment_stmt .= $stmt;
          while (my $sub_stmt = <$fh_in>) {
            $comment_stmt .= $sub_stmt;
            last if ($sub_stmt =~ /\*\//);
          }
          $comment_stmt =~ s/\/\*.*\*\///s;
          $stmt = $comment_stmt;
          $comment_stmt = "";
        }
      }

      # Remove backtick statements
      $stmt =~ s/\s*\`.*\n//g;

      # Remove newlines
      $stmt =~ s/\n//g;

      # Remove keyword statements that dont end in semicolon
      if ($stmt =~ /endmodule/) {
        $cur_module = undef;
        %ports      = ();
        $stmt =~ s/\s*endmodule\s*//;
      }

      # Get current module
      if ($stmt =~ /^\s*module\s+(\S+)/) {
        $cur_module = $1;
      }

      # Record port names and direction in case we are at the correct module
      if ($stmt =~ /^\s*(input|output|inout)\s+(.+?)\s*\;\s*$/) {
        my $direction   = $1;
        my $port_string = $2;

        # Check for bus
        if ($port_string !~ /^\\/ && $port_string =~ /(\[([\d\-]+)\:([\d\-]+)\])/) {
          my $bus_stmt = $1;
          $port_string =~ s/\s*\Q${bus_stmt}\E\s*//;
        }

        my @port_names = split(/\s*\,\s*/, $port_string);
        foreach my $port_name (@port_names) {
          $ports{$port_name} = $direction;
        }
      }

      # Check for instance of target module type
      if ($stmt =~ /^\s*${target_module}\s+(\S+)/) {
        $target_inst = $1;
        $top_module  = $cur_module;
        %top_ports = %ports;
        last;
      }
  }
  &Hydra::Util::File::close_file($fh_in);

  return ($top_module, $target_inst, \%top_ports);
}

1;
