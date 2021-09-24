#------------------------------------------------------
# Module Name: Sta
# Date:        Mon Jan 13 16:56:08 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Sta;

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
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $run_dir, $tool) = @_;
  my $self = {
    run_dir => $run_dir,
    tool    => $tool,
  };
  bless $self, $class;

  # # Intialize
  # foreach my $type (qw(setup hold)) {
  #   foreach my $metric (qw(worst_count worst_wns worst_tns)) {
  #     $self->{timing}{$type}{$metric}{scenario} = "";
  #     $self->{timing}{$type}{$metric}{count} = 0;
  #     $self->{timing}{$type}{$metric}{wns} = 0;
  #     $self->{timing}{$type}{$metric}{tns} = 0;
  #   }
  # }

  my $subref = \&{ "${tool}_sum_sta" };
  if (defined &$subref) {
    $self->$subref;
  }

  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub pt_sum_sta {
  my ($self) = @_;
  my $run_dir = $self->{run_dir};
  my $rpt_dir = "${run_dir}/rpt";

  # Get all scenarios
  my %scenarios = ();
  foreach my $entry (&Hydra::Util::File::get_sub_dirs($rpt_dir)) {
    if (-f "${rpt_dir}/${entry}/setup.global_timing.rpt") {
      my ($mode, $corner, $temp, $rc) = split(/\./, $entry);
      $scenarios{$entry} = $mode;
    }
  }

  my %data = ();
  # %data =>
  #   $mode
  #     setup|hold =>
  #       $scenario =>
  #         wns       => <num>
  #         tns       => <num>
  #         count     => <num>
  #         max_trans => <num>
  #         max_cap   => <num>
  #         double_switching => <num>
  #         annotation => <num>
  #         min_pulse_width => <num>
  #

  # Setup/hold
  foreach my $scenario (sort keys %scenarios) {
    my $mode = $scenarios{$scenario};

    foreach my $delay_type (qw(Setup Hold)) {
      my $global_timing_rpt = "${rpt_dir}/${scenario}/global_timing.rpt";
      my $timing_rpt = "${rpt_dir}/${scenario}/" . lc($delay_type) . ".global_timing.rpt";
      if (-f $timing_rpt) {
        $data{$mode}{$delay_type}{$scenario}{WNS}   = 0;
        $data{$mode}{$delay_type}{$scenario}{TNS}   = 0;
        $data{$mode}{$delay_type}{$scenario}{Count} = 0;

        my $fh_rpt = &Hydra::Util::File::open_file_for_read($timing_rpt);
        while (my $line = <$fh_rpt>) {
          if ($line =~ /WNS\s+\S+\s+(\S+)/) {
            $data{$mode}{$delay_type}{$scenario}{WNS} = $1;
          }
          elsif ($line =~ /TNS\s+\S+\s+(\S+)/) {
            $data{$mode}{$delay_type}{$scenario}{TNS} = $1;
          }
          elsif ($line =~ /NUM\s+\S+\s+(\S+)/) {
            $data{$mode}{$delay_type}{$scenario}{Count} = $1;
          }
        }
        &Hydra::Util::File::close_file($fh_rpt);
      }
    }

    # Annotation coverage
    my $anno_rpt = "${rpt_dir}/${scenario}/annotated_parasitics.rpt";
    if (-f $anno_rpt) {
      $data{$mode}{Setup}{$scenario}{"Annotation Coverage"} = 0;
      $data{$mode}{Hold}{$scenario}{"Annotation Coverage"} = 0;
      
      my $fh_rpt = &Hydra::Util::File::open_file_for_read($anno_rpt);
      while (my $line = <$fh_rpt>) {
        if ($line =~ /^\s+\|\s*(\S+)\s*\|\s*\S+\s*\|\s*\S+\s*\|\s*\S+\s*\|\s*\S+\s*\|\s*(\S+)\s*\|\s*$/) {
          my $total    = $1;
          my $non_anno = $2;
          my $anno_coverage = sprintf "%.2f", 100 - ($non_anno / $total);
          $anno_coverage .= '%';
          $data{$mode}{Setup}{$scenario}{"Annotation Coverage"} = $anno_coverage;
          $data{$mode}{Hold}{$scenario}{"Annotation Coverage"} = $anno_coverage;
        }
      }
      &Hydra::Util::File::close_file($fh_rpt);
    }

    # Max transition
    my $trans_rpt = "${rpt_dir}/${scenario}/max_trans.rpt";
    if (-f $trans_rpt) {
      $data{$mode}{Setup}{$scenario}{"Max Trans"} = 0;
      $data{$mode}{Hold}{$scenario}{"Max Trans"} = 0;

      my $fh_rpt = &Hydra::Util::File::open_file_for_read($trans_rpt);
      while (my $line = <$fh_rpt>) {
        if ($line =~ /^\s*\S+\s+\S+\s+\S+\s+([\d\-\.]+)/) {
          my $slack = $1;
          if ($slack < $data{$mode}{Setup}{$scenario}{"Max Trans"}) {
            $data{$mode}{Setup}{$scenario}{"Max Trans"} = $slack;
            $data{$mode}{Hold}{$scenario}{"Max Trans"} = $slack;
          }
        }
      }
      &Hydra::Util::File::close_file($fh_rpt);
    }

    # Max capacitance
    my $cap_rpt = "${rpt_dir}/${scenario}/max_cap.rpt";
    if (-f $cap_rpt) {
      $data{$mode}{Setup}{$scenario}{"Max Cap"} = 0;
      $data{$mode}{Hold}{$scenario}{"Max Cap"} = 0;

      my $fh_rpt = &Hydra::Util::File::open_file_for_read($cap_rpt);
      while (my $line = <$fh_rpt>) {
        if ($line =~ /^\s*\S+\s+\S+\s+\S+\s+([\d\-\.]+)/) {
          my $slack = $1;
          if ($slack < $data{$mode}{Setup}{$scenario}{"Max Cap"}) {
            $data{$mode}{Setup}{$scenario}{"Max Cap"} = $slack;
            $data{$mode}{Hold}{$scenario}{"Max Cap"} = $slack;
          }
        }
      }
      &Hydra::Util::File::close_file($fh_rpt);
    }

    # Min pulse width
    my $pulse_rpt = "${rpt_dir}/${scenario}/min_pulse.rpt";
    if (-f $pulse_rpt) {
      $data{$mode}{Setup}{$scenario}{"Min Pulse Width"} = 0;
      $data{$mode}{Hold}{$scenario}{"Min Pulse Width"} = 0;

      
      my $fh_rpt = &Hydra::Util::File::open_file_for_read($pulse_rpt);
      while (my $line = <$fh_rpt>) {
        if ($line =~ /^\s*\S+\s+\S+\s+\S+\s+([\d\-\.]+)/) {
          my $slack = $1;
          if ($slack < $data{$mode}{Setup}{$scenario}{"Min Pulse Width"}) {
            $data{$mode}{Setup}{$scenario}{"Min Pulse Width"} = $slack;
            $data{$mode}{Hold}{$scenario}{"Min Pulse Width"} = $slack;
          }
        }
      }
      &Hydra::Util::File::close_file($fh_rpt);
    }

    # Double switching
    my $si_rpt = "${rpt_dir}/${scenario}/double_switching.rpt";
    if (-f $si_rpt) {
      $data{$mode}{Setup}{$scenario}{"Double Switching"} = 0;
      $data{$mode}{Hold}{$scenario}{"Double Switching"} = 0;

      my $fh_rpt = &Hydra::Util::File::open_file_for_read($si_rpt);
      while (my $line = <$fh_rpt>) {
        if ($line =~ /^\s*\S+\s+\S+\s+\S+\s+\S+\s+([\d\-\.]+)/) {
          my $slack = $1;
          if ($slack < $data{$mode}{Setup}{$scenario}{"Double Switching"}) {
            $data{$mode}{Setup}{$scenario}{"Double Switching"} = $slack;
            $data{$mode}{Hold}{$scenario}{"Double Switching"} = $slack;
          }
        }
      }
      &Hydra::Util::File::close_file($fh_rpt);
    }
  }

  # Get worst scenario for each mode
  foreach my $mode (keys %data) {
    foreach my $delay_type (keys %{ $data{$mode} }) {
      # Get worst scenario by tns
      my @worst_tns_scenarios = sort { $data{$mode}{$delay_type}{$a}{TNS} <=> $data{$mode}{$delay_type}{$b}{TNS} } keys %{ $data{$mode}{$delay_type} };
      my $worst_tns_scenario  = $worst_tns_scenarios[0];
      if (defined $worst_tns_scenario) {
        $self->{timing}{$mode}{$delay_type}{"Worst Scenario By TNS"} = $worst_tns_scenario;

        foreach my $metric (qw(WNS TNS Count)) {
          $self->{timing}{$mode}{$delay_type}{$metric} = $data{$mode}{$delay_type}{$worst_tns_scenario}{$metric};
        }
          
        foreach my $metric (("Annotation Coverage", "Max Trans", "Max Cap", "Double Switching")) {
          $self->{timing}{$mode}{"WNS For Worst $delay_type Scenario"}{$metric} = $data{$mode}{$delay_type}{$worst_tns_scenario}{$metric};
        }
      }
    }
  }
}

# sub pt_sum_sta2 {
#   my ($self) = @_;
#   my $run_dir = $self->{run_dir};
#   my $rpt_dir = "${run_dir}/rpt";

#   # Get all scenarios
#   my @scenarios = ();
#   foreach my $entry (&Hydra::Util::File::get_sub_dirs($rpt_dir)) {
#     if (-f "${rpt_dir}/${entry}/global_timing.rpt") {
#       push(@scenarios, $entry);
#     }
#   }

#   my %data = ();
#   foreach my $scenario (@scenarios) {
#     my $global_timing_rpt = "${rpt_dir}/${scenario}/global_timing.rpt";
#     if (-f $global_timing_rpt) {
#       my $fh_gt = &Hydra::Util::File::open_file_for_read($global_timing_rpt);
#       my $delay_type;
#       while (my $line = <$fh_gt>) {
#         if ($line =~ /Setup violations/) {
#           $delay_type = "setup";
#         }
#         elsif ($line =~ /Hold violations/) {
#           $delay_type = "hold";
#         }

#         if (defined $delay_type) {
#           if ($line =~ /WNS\s+\S+\s+(\S+)/) {
#             $data{$delay_type}{$scenario}{wns} = $1;
#           }
#           elsif ($line =~ /TNS\s+\S+\s+(\S+)/) {
#             $data{$delay_type}{$scenario}{tns} = $1;
#           }
#           elsif ($line =~ /NUM\s+\S+\s+(\S+)/) {
#             $data{$delay_type}{$scenario}{count} = $1;
#           }
#         }
#       }
#       &Hydra::Util::File::close_file($fh_gt);
#     }
#   }

#   foreach my $delay_type (keys %data) {
#     my @wns_scenarios   = sort { $data{$delay_type}{$a}{wns} <=> $data{$delay_type}{$b}{wns} } keys %data;
#     my @tns_scenarios   = sort { $data{$delay_type}{$a}{tns} <=> $data{$delay_type}{$b}{tns} } keys %data;
#     my @count_scenarios = sort { $data{$delay_type}{$b}{count} <=> $data{$delay_type}{$a}{count} } keys %data;
    
#     my $worst_wns_scenario = $wns_scenarios[0];
#     if (defined $worst_wns_scenario) {
#       $self->{timing}{$delay_type}{worst_wns}{scenario} = $worst_wns_scenario;
#       $self->{timing}{$delay_type}{worst_wns}{wns}      = $data{$delay_type}{$worst_wns_scenario}{wns};
#       $self->{timing}{$delay_type}{worst_wns}{tns}      = $data{$delay_type}{$worst_wns_scenario}{tns};
#       $self->{timing}{$delay_type}{worst_wns}{count}    = $data{$delay_type}{$worst_wns_scenario}{count};
#     }

#     my $worst_tns_scenario = $wns_scenarios[0];
#     if (defined $worst_tns_scenario) {
#       $self->{timing}{$delay_type}{worst_tns}{scenario} = $worst_tns_scenario;
#       $self->{timing}{$delay_type}{worst_tns}{wns}      = $data{$delay_type}{$worst_tns_scenario}{wns};
#       $self->{timing}{$delay_type}{worst_tns}{tns}      = $data{$delay_type}{$worst_tns_scenario}{tns};
#       $self->{timing}{$delay_type}{worst_tns}{count}    = $data{$delay_type}{$worst_tns_scenario}{count};
#     }

#     my $worst_count_scenario = $wns_scenarios[0];
#     if (defined $worst_count_scenario) {
#       $self->{timing}{$delay_type}{worst_count}{scenario} = $worst_count_scenario;
#       $self->{timing}{$delay_type}{worst_count}{wns}      = $data{$delay_type}{$worst_count_scenario}{wns};
#       $self->{timing}{$delay_type}{worst_count}{tns}      = $data{$delay_type}{$worst_count_scenario}{tns};
#       $self->{timing}{$delay_type}{worst_count}{count}    = $data{$delay_type}{$worst_count_scenario}{count};
#     }
#   }
# }

#------------------------------------------------------
# Setters
#------------------------------------------------------
# sub dump {
#   my ($self) = @_;
#   my $ret_val = "";

#   foreach my $delay_type (qw(setup hold)) {
#     foreach my $metric (qw(worst_count worst_wns worst_tns)) {
#       foreach my $value_type (qw(scenario count wns tns)) {
#         #$ret_val .= "sta/${delay_type}/${metric}/${value_type} = $self->{timing}{$delay_type}{$metric}{$value_type}\n";
#         if (defined $self->{timing}{$delay_type}{$metric}{$value_type}) {
#           #$ret_val .= "  <timing delay=\"${delay_type}\" metric=${metric} type=\"${value_type}\">$self->{timing}{$delay_type}{$metric}{$value_type}</timing>\n";
          
#         }
#       }
#     }
#   }

#   return $ret_val;
# }

sub dump {
  my ($self) = @_;
  my $ret_val = "";

  foreach my $mode (sort keys %{ $self->{timing} }) {
    foreach my $delay_type (sort keys %{ $self->{timing}{$mode} }) {
      foreach my $metric (sort keys %{ $self->{timing}{$mode}{$delay_type} }) {
        if (defined $self->{timing}{$mode}{$delay_type}{$metric}) {
          $ret_val .= "$mode=STA $delay_type $metric=$self->{timing}{$mode}{$delay_type}{$metric}\n";
        }
      }
    }
  }

  return $ret_val;
}

1;
