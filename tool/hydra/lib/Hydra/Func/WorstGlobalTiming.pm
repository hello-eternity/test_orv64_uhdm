#------------------------------------------------------
# Module Name: WorstGlobalTiming
# Date:        Fri Jun 28 12:51:59 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::WorstGlobalTiming;

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
sub worst_global_timing {
  my $rpt_dir = &Hydra::Util::Option::get_opt_value_scalar("-rpt_dir", "strict");
  my $scenario_pattern = '^([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)$';

  my @corners = ();
  foreach my $entry (&Hydra::Util::File::get_sub_dirs($rpt_dir)) {
    if ($entry =~ /$scenario_pattern/) {
      push(@corners, $entry);
    }
  }

  my %modes = ();
  my %data = ();
  foreach my $corner_name (@corners) {
    $corner_name =~ /$scenario_pattern/;
    my $mode = $1;
    $modes{$mode} = 1;

    my $corner_dir = "${rpt_dir}/${corner_name}";
    my $setup_rpt  = "${corner_dir}/setup.global_timing.rpt";
    my $hold_rpt   = "${corner_dir}/hold.global_timing.rpt";
    my $global_rpt = "${corner_dir}/global_timing.rpt";

    if (-e $global_rpt && (!-e $hold_rpt || !-e $setup_rpt)) {
      # Postprocess global rpt into separate hold and setup rpts
      my $fh_in = &Hydra::Util::File::open_file_for_read($global_rpt);
      my %fh = ();
      if (!-e $setup_rpt) {
        print "INFO: Creating setup global timing rpt at $setup_rpt\n";
        $fh{setup} = &Hydra::Util::File::open_file_for_write($setup_rpt);
      }
      if (!-e $hold_rpt) {
        print "INFO: Creating hold global timing rpt at $hold_rpt\n";
        $fh{hold} = &Hydra::Util::File::open_file_for_write($hold_rpt);
      }

      my $mode = "";
      while (my $line = <$fh_in>) {
        if ($line =~ /Setup violations/) {
          $mode = "setup";
        }
        if ($line =~ /Hold violations/) {
          $mode = "hold";
        }

        if ($mode ne "") {
          if (defined $fh{$mode}) {
            my $fh_out = $fh{$mode};
            print $fh_out $line;
          }
        }
      }
      &Hydra::Util::File::close_file($fh_in);

      foreach my $type (keys %fh) {
        &Hydra::Util::File::close_file($fh{$type});
      }
    }
    
    if (-e $setup_rpt && $corner_name =~ /_T$/) {
      my @lines = ();
      my $record = 0;
      my $fh_in = &Hydra::Util::File::open_file_for_read($setup_rpt);
      while (my $line = <$fh_in>) {
        push(@lines, $line) if ($record);
        if ($line =~ /Setup violations/) {
          $record = 1;
        }
        elsif ($record && $line =~ /^\s*$/) {
          $record = 0;
        }
        elsif ($line =~ /WNS\s+\S+\s+(\S+)/) {
          $data{$corner_name}{$mode}{setup}{wns} = $1;
        }
        elsif ($line =~ /TNS\s+\S+\s+(\S+)/) {
          $data{$corner_name}{$mode}{setup}{tns} = $1;
        }
      }
      &Hydra::Util::File::close_file($fh_in);
      
      if (!defined $data{$corner_name}{$mode}{setup}{wns}) {
        $data{$corner_name}{$mode}{setup}{wns} = 0;
        $data{$corner_name}{$mode}{setup}{tns} = 0;
      }
      $data{$corner_name}{$mode}{setup}{lines} = \@lines;
    }

    if (-e $hold_rpt && $corner_name !~ /_T$/) {
      my @lines = ();
      my $record = 0;
      my $fh_in = &Hydra::Util::File::open_file_for_read($hold_rpt);
      while (my $line = <$fh_in>) {
        push(@lines, $line) if ($record);
        if ($line =~ /Hold violations/) {
          $record = 1;
        }
        elsif ($record && $line =~ /^\s*$/) {
          $record = 0;
        }
        elsif ($line =~ /WNS\s+\S+\s+(\S+)/) {
          $data{$corner_name}{$mode}{hold}{wns} = $1;
        }
        elsif ($line =~ /TNS\s+\S+\s+(\S+)/) {
          $data{$corner_name}{$mode}{hold}{tns} = $1;
        }
      }
      &Hydra::Util::File::close_file($fh_in);
      
      if (!defined $data{$corner_name}{$mode}{hold}{wns}) {
        $data{$corner_name}{$mode}{hold}{wns} = 0;
        $data{$corner_name}{$mode}{hold}{tns} = 0;
      }
      $data{$corner_name}{$mode}{hold}{lines} = \@lines;
    }
  }

  my %winners = ();
  foreach my $mode (sort keys %modes) {
    foreach my $corner_name (@corners) {
      $corner_name =~ /$scenario_pattern/;
      my $corner_mode = $1;
      next if ($corner_mode ne $mode);
      
      foreach my $type (qw(setup hold)) {
        foreach my $slack (qw(wns tns)) {
          if (defined $data{$corner_name}{$mode}{$type}{$slack}) {
            if (!defined $winners{$type}{$slack}{$mode}{value} || $data{$corner_name}{$mode}{$type}{$slack} < $winners{$type}{$slack}{$mode}{value}) {
              $winners{$type}{$slack}{$mode}{value}  = $data{$corner_name}{$mode}{$type}{$slack};
              $winners{$type}{$slack}{$mode}{corner} = $corner_name;
            }
          }
        }
      }
    }
  }

  my $fh_out = &Hydra::Util::File::open_file_for_write("summary.rpt");
  foreach my $type (sort keys %winners) {
    foreach my $slack (sort keys %{ $winners{$type} }) {
      foreach my $mode (sort keys %modes) {
        my $corner_name;
        my $aref_lines;
        if (defined $winners{$type}{$slack}{$mode}{corner}) {
          $corner_name = $winners{$type}{$slack}{$mode}{corner};
          $aref_lines  = $data{$corner_name}{$mode}{$type}{lines};
        }
        else {
          $corner_name = "NONE";
          $aref_lines = ["NO REPORT FOUND\n", "\n"];
        }
          
        print $fh_out uc($type) . " " . uc($slack) . " $mode: $corner_name\n";
        print $fh_out @$aref_lines;
        print $fh_out "\n";
      }
    }
  }
  &Hydra::Util::File::close_file($fh_out);

  $fh_out = &Hydra::Util::File::open_file_for_write("all.rpt");
  foreach my $corner_name (sort keys %data) {
    foreach my $mode (sort keys %{ $data{$corner_name} }) {
      foreach my $type (qw(setup hold)) {
        if (defined $data{$corner_name}{$mode}{$type}{lines}) {
          print $fh_out "Corner: $corner_name Type: $type\n";
          print $fh_out @{ $data{$corner_name}{$mode}{$type}{lines} };
          print $fh_out "\n";
        }
      }
    }
  }
  &Hydra::Util::File::close_file($fh_out);
}

1;
