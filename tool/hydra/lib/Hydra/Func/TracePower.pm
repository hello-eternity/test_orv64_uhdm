#------------------------------------------------------
# Module Name: TracePower
# Date:        Wed Nov 20 11:05:52 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::TracePower;

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
sub trace_power {
  # Disable unnecessary net connection resolution
  &Hydra::Verilog::disable_resolve_conn;
  &Hydra::Verilog::read_netlist;

  my $top_module         = &Hydra::Util::Option::get_opt_value_scalar("-top_module", "strict");
  my $aref_cell_patterns = &Hydra::Util::Option::get_opt_value_array("-cell_patterns", "relaxed");
  my $aref_power_nets    = &Hydra::Util::Option::get_opt_value_array("-power_nets", "strict");
  my %power_nets = map {$_ => 1} @$aref_power_nets;

  my $Design        = &Hydra::Verilog::get_design;
  my $TopInst       = $Design->get_top_inst;
  my $top_inst_name = $TopInst->get_name;
  
  my %data = ();
  $data{cell_patterns} = $aref_cell_patterns;
  $data{power_nets}    = \%power_nets;
  # %data =>
  #   cell_patterns => []
  #   power_nets    => {}
  #   groups =>
  #     $pattern =>
  #       [
  #         pin   => <name>
  #         net   => <name>
  #         count => <num>
  #       ]
  #   len =>
  #     group => <num>
  #     pin   => <num>
  #     net   => <num>
  #

  &Hydra::Util::File::print_unbuffered("INFO: Tracing power of top module $top_inst_name...\n");
  &do_trace_power($TopInst, \%data);

  # foreach my $pattern_group (keys %{ $data{groups} }) {
  #   print "$pattern_group\n";
  #   foreach my $href_pin (@{ $data{groups}{$pattern_group} }) {
  #     print "  $href_pin->{pin} $href_pin->{net} $href_pin->{count}\n";
  #   }
  # }

  my $fh_out = &Hydra::Util::File::open_file_for_write("${top_module}.trace_power.rpt");
  my $divider_len = $data{len}{group} + 4 + $data{len}{pin} + 5 + $data{len}{net} + 1 + 10;
  my $divider = '-' x $divider_len;
  print $fh_out "Nets traced: @$aref_power_nets\n\n";
  printf $fh_out "%-${data{len}{group}}s    %-${data{len}{pin}}s <-> %-${data{len}{net}}s %-10s\n", "Group", "Pin", "Net", "Count";
  print $fh_out "$divider\n";
  foreach my $pattern_group (sort { &sort_pattern_groups } keys %{ $data{groups} }) {
    # Sanity check group
    my $duplicate = 0;
    my %prev      = ();
    foreach my $href_pin (@{ $data{groups}{$pattern_group} }) {
      # Check for duplicate net connections
      if (defined $prev{net}{$href_pin->{net}}) {
        $duplicate = 1;
      }
      $prev{net}{$href_pin->{net}} = 1;
    }

    foreach my $index (0..$#{ $data{groups}{$pattern_group} }) {
      my $href_pin   = $data{groups}{$pattern_group}[$index];
      my $group_name = $pattern_group;
      $group_name = "" if ($index != 0);
      printf $fh_out "%-${data{len}{group}}s    %-${data{len}{pin}}s <-> %-${data{len}{net}}s %-50s\n", $group_name, $href_pin->{pin}, $href_pin->{net}, $href_pin->{count};
    }

    # Print sanity check warnings
    if ($duplicate) {
      print $fh_out "WARN: Duplicate net connection\n";
    }
    
    print $fh_out "$divider\n";
  }
  &Hydra::Util::File::close_file($fh_out);
}

sub do_trace_power {
  my ($Inst, $href_data) = @_;
  my $cell_name = $Inst->get_module->get_name;

  # Determine group for this cell
  my $pattern_group;
  foreach my $pattern (@{ $href_data->{cell_patterns} }) {
    my $conv_pattern = $pattern;
    $conv_pattern =~ s/\*/.*/g;
    
    if ($cell_name =~ /^$conv_pattern$/) {
      $pattern_group = $pattern;
      last;
    }
  }
  $pattern_group = $cell_name if (!defined $pattern_group);

  # Only look at real cells, not modules
  if ($Inst->get_module->get_type ne "module") {
    my $href_pins = $Inst->parse_conn_stmt("return");
    foreach my $pin_name (keys %$href_pins) {
      foreach my $net_name (@{ $href_pins->{$pin_name} }) {
        if (defined $href_data->{power_nets}{$net_name}) {
          # Search for identical bit->net connections already in this group
          my $found_pin = 0;
          foreach my $href_pin (@{ $href_data->{groups}{$pattern_group} }) {
            if ($href_pin->{pin} eq $pin_name && $href_pin->{net} eq $net_name) {
              $href_pin->{count} += 1;
              $found_pin = 1;
              last;
            }
          }

          if (!$found_pin) {
            # Create new bit->net connection
            my %pin = (pin => $pin_name, net => $net_name, count => 1);
            push(@{ $href_data->{groups}{$pattern_group} }, \%pin);
            &update_len($href_data, $pattern_group, "group");
            &update_len($href_data, $pin_name, "pin");
            &update_len($href_data, $net_name, "net");
          }
        }
      }
    }
  }

  foreach my $SubInst ($Inst->get_instance_list) {
    &do_trace_power($SubInst, $href_data);
  }
}

sub sort_pattern_groups {
  if ($a =~ /\*/ && $b =~ /\*/) {
    return $a cmp $b;
  }
  elsif ($a =~ /\*/) {
    return -1;
  }
  elsif ($b =~ /\*/) {
    return 1;
  }
  else {
    return $a cmp $b;
  }
}

sub update_len {
  my ($href_data, $name, $type) = @_;
  if (!defined $href_data->{len}{$type} || length($name) > $href_data->{len}{$type}) {
    $href_data->{len}{$type} = length($name);
  }
}


1;
