#------------------------------------------------------
# Module Name: VTSwap
# Date:        Mon Feb  3 12:28:44 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::VTSwap;

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
sub vtswap {
  my $rpt         = &Hydra::Util::Option::get_opt_value_scalar("-rpt", "strict");
  my $margin      = &Hydra::Util::Option::get_opt_value_scalar("-margin", "strict");
  #my $hvt_pattern = &Hydra::Util::Option::get_opt_value_scalar("-hvt_pattern", "strict");
  #my $lvt_pattern = &Hydra::Util::Option::get_opt_value_scalar("-lvt_pattern", "strict");
  #my $svt_pattern = &Hydra::Util::Option::get_opt_value_scalar("-svt_pattern", "strict");
  my $hvt_pattern = '^.*BWP.*HVT$';
  my $lvt_pattern = '^.*BWP.*LVT$';
  my $svt_pattern = '^.*BWP.*$';
  my $clock_pattern = "^CKL";
  
  my %insts = ();
  # %insts =>
  #   $inst_name =>
  #     cell  => <str>
  #     slack => <str> worst slack across all paths this inst appears in
  #

  my $Timing = new Hydra::Report::PtTiming(undef, $rpt, 999);
  foreach my $Path ($Timing->get_path_list) {
    my $slack = $Path->get_slack;
    foreach my $Point ($Path->get_data_points) {
      my $inst = $Point->get_inst;
      my $cell = $Point->get_cell;
      if (($cell =~ /$lvt_pattern/ || $cell =~ /$svt_pattern/) && $cell !~ /$hvt_pattern/ && $cell !~ /$clock_pattern/)  {
        if (!defined $insts{$inst}{slack} || $slack < $insts{$inst}{slack}) {
          $insts{$inst}{cell}  = $cell;
          $insts{$inst}{slack} = $slack;

          #$insts{$inst}{endpoints}{$Path->get_endpoint} = 1;
        }
      }
    }
  }

  my %endpoints = ();
  #my $skipped = 0;
  my @query_lines = ();
  my @size_lines  = ();
  my $count = 0;
  #my $fh_out = &Hydra::Util::File::open_file_for_write("icc2.vtswap.tcl");
  my $fh_pt  = &Hydra::Util::File::open_file_for_write("pt.vtswap.tcl");
  foreach my $inst (sort { $insts{$b}{slack} <=> $insts{$a}{slack} } keys %insts) {
    # my $skip = 0;
    # foreach my $inst_endpoint (keys %{ $insts{$inst}{endpoints} }) {
    #   if (defined $endpoints{$inst_endpoint}) {
    #     #print "For inst $inst, endpoint $insts{$inst}{endpoint} already swapped\n";
    #     $skip = 1;
    #     $skipped++;
    #   }
    #   else {
    #     $endpoints{$inst_endpoint} = 1;
    #   }
    # }
    # next if ($skip);

    if ($insts{$inst}{slack} >= $margin) {
      my $new_cell = $insts{$inst}{cell};
      if ($new_cell =~ /$lvt_pattern/) {
        $new_cell =~ s/LVT/HVT/;
      }
      elsif ($new_cell =~ /$svt_pattern/) {
        $new_cell .= "HVT";
      }
      
      #print $fh_out "# Cell: $insts{$inst}{cell} Slack: $insts{$inst}{slack}\n";
      #print $fh_out "size_cell -lib_cell [get_lib_cells */${new_cell}] [get_cells $inst]\n";

      my $var = "PATHSIZE${count}";
      if ($count % 10000 == 0) {
        push(@query_lines, "puts \"INFO: $count vtswap queries completed\"");
        push(@size_lines, "puts \"INFO: $count vtswap size_cells completed\"");
      }

      push(@query_lines, "set $var [sizeof_collection [get_timing_paths -through $inst -nworst 1 -max_paths 1 -slack_lesser_than $margin]]");

      push(@size_lines, "# Cell: $insts{$inst}{cell} Slack: $insts{$inst}{slack}");
      push(@size_lines, "if {\$$var == 0} {");
      push(@size_lines, "  size_cell [get_cells $inst] $new_cell");
      push(@size_lines, "}");
      push(@size_lines, "");

      $count++;
    }
  }

  foreach my $line (@query_lines) {
    print $fh_pt "$line\n";
  }
  print $fh_pt "\n";

  foreach my $line (@size_lines) {
    print $fh_pt "$line\n";
  }
  print $fh_pt "\n";

  print $fh_pt "report_global_timing -significant_digits 3 > ./rpt/vtswap.global_timing.rpt\n";
  print $fh_pt "write_changes -format icc2tcl -output ./output/vtswap.icc2.tcl\n";

  #&Hydra::Util::File::close_file($fh_out);
  &Hydra::Util::File::close_file($fh_pt);

  print "$count candidate instances found\n";
}

1;
