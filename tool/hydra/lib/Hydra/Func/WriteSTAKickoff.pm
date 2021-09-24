#------------------------------------------------------
# Module Name: WriteSTAKickoff
# Date:        Mon Mar  9 15:20:35 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::WriteSTAKickoff;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub write_sta_kickoff {
  my $aref_rules = &Hydra::Util::Option::get_opt_value_array("-rules", "relaxed", []);

  my $run_dir = cwd;
  my $starrc_bin;
  my $pt_bin;
  my %rc_corners = ();
  # %rc_corners =>
  #   $rc => 
  #     $temp =>
  #       command = <str>
  #       sta_commands =
  #         $sta_type = [<str>]
  #       
  my %sta_corners = ();
  # %sta_corners =>
  #   sta|sta_fullchip =>
  #     $mode =>
  #       $pv =>
  #         $temp =>
  #           $rc =>
  #             command    = <str>

  # Get all RC runs
  my $rc_kickoff = "${run_dir}/rc_extract/HYDRA.run";
  if (-f $rc_kickoff) {
    my $fh_in = &Hydra::Util::File::open_file_for_read($rc_kickoff);
    while (my $line = <$fh_in>) {
      if ($line =~ /^\s*((\S+)\s+script\/([^\s\.]+)\.([^\s\.]+)\.rc_extract\.cmd\s+\|\&\s+tee\s+log\/\S+)\s*$/) {
        my $command = $1;
        $starrc_bin = $2;
        my $rc      = $3;
        my $temp    = $4;
        $rc_corners{$rc}{$temp}{command} = $command;
      }
    }
    &Hydra::Util::File::close_file($fh_in);
  }

  # Get all STA runs
  foreach my $sta_type (qw(sta sta_fullchip)) {
    my $sta_kickoff = "${run_dir}/${sta_type}/HYDRA.run";
    if (-f $sta_kickoff) {
      my $fh_in = &Hydra::Util::File::open_file_for_read($sta_kickoff);
      while (my $line = <$fh_in>) {
        if ($line =~ /^\s*((\S+)\s+\-file\s+script\/([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)\.sta\.tcl\s+\|\s+tee\s+log\/\S+)\s*$/) {
          my $command = $1;
          $pt_bin     = $2;
          my $mode    = $3;
          my $pv      = $4;
          my $temp    = $5;
          my $rc      = $6;

          $sta_corners{$sta_type}{$mode}{$pv}{$temp}{$rc}{command} = $command;
        }
      }
      &Hydra::Util::File::close_file($sta_kickoff);
    }
  }

  # Eliminate sta corners that dont follow rules
  foreach my $rule (@$aref_rules) {
    my ($rule_type, $rule_name) = split(/\=/, $rule);
    $rule_name =~ s/\,/|/g;

    foreach my $sta_type (keys %sta_corners) {
      foreach my $mode (keys %{ $sta_corners{$sta_type} }) {
        foreach my $pv (keys %{ $sta_corners{$sta_type}{$mode} }) {
          foreach my $temp (keys %{ $sta_corners{$sta_type}{$mode}{$pv} }) {
            foreach my $rc (keys %{ $sta_corners{$sta_type}{$mode}{$pv}{$temp} }) {
              my $comp_name;
              if ($rule_type eq "type") {
                $comp_name = $sta_type;
              }
              elsif ($rule_type eq "mode") {
                $comp_name = $mode;
              }
              elsif ($rule_type eq "pv") {
                $comp_name = $pv;
              }
              elsif ($rule_type eq "temp") {
                $comp_name = $temp;
              }
              elsif ($rule_type eq "rc") {
                $comp_name = $rc;
              }

              if (defined $comp_name && $comp_name !~ /^(${rule_name})$/) {
                delete $sta_corners{$sta_type}{$mode}{$pv}{$temp}{$rc};
              }
            }
          }
        }
      }
    }
  }

  # File each STA command under the corresponding RC command
  foreach my $sta_type (keys %sta_corners) {
    foreach my $mode (keys %{ $sta_corners{$sta_type} }) {
      foreach my $pv (keys %{ $sta_corners{$sta_type}{$mode} }) {
        foreach my $temp (keys %{ $sta_corners{$sta_type}{$mode}{$pv} }) {
          foreach my $rc (keys %{ $sta_corners{$sta_type}{$mode}{$pv}{$temp} }) {
            if (defined $rc_corners{$rc}{$temp}) {
              push(@{ $rc_corners{$rc}{$temp}{sta_commands}{$sta_type} }, $sta_corners{$sta_type}{$mode}{$pv}{$temp}{$rc}{command});
            }
          }
        }
      }
    } 
  }

  my $fh_out = &Hydra::Util::File::open_file_for_write("HYDRA.sta.run");
  print $fh_out "#!/usr/bin/bash\n";
  print $fh_out "# Generated by Hydra write_sta_kickoff on " . localtime . "\n";
  print $fh_out "export HYDRA_HOME=$ENV{HYDRA_HOME}\n";
  print $fh_out "export SNPSLMD_QUEUE=true\n";
  print $fh_out "\n";
  foreach my $rc (sort keys %rc_corners) {
    foreach my $temp (sort keys %{ $rc_corners{$rc} }) {
      my $rc_command = $rc_corners{$rc}{$temp}{command};
      if ((defined $rc_corners{$rc}{$temp}{sta_commands}{sta} && 
           scalar(@{ $rc_corners{$rc}{$temp}{sta_commands}{sta} }) > 0) ||
           (defined $rc_corners{$rc}{$temp}{sta_commands}{sta_fullchip} &&
           scalar(@{ $rc_corners{$rc}{$temp}{sta_commands}{sta_fullchip} }) > 0)) {
        print $fh_out "# RC: $rc $temp\n";
        print $fh_out "cd rc_extract\n";
        print $fh_out "$rc_command\n";
        print $fh_out "cd ..\n";
        
        foreach my $sta_type (sort keys %{ $rc_corners{$rc}{$temp}{sta_commands} }) {
          print $fh_out "cd $sta_type\n";
          foreach my $sta_command (@{ $rc_corners{$rc}{$temp}{sta_commands}{$sta_type} }) {
            print $fh_out "$sta_command \&\n";
          }
          print $fh_out "cd ..\n";
        }

        print $fh_out "\n";
      }
    }
  }
  &Hydra::Util::File::close_file($fh_out);
  &Hydra::Util::File::chmod_script("HYDRA.sta.run");
}

1;
