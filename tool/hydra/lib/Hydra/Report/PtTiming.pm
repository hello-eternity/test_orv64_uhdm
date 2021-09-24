#------------------------------------------------------
# Module Name: PtTiming
# Date:        Fri Jun 28 16:02:19 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Report::PtTiming;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Report::TimingPath;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub new {
  my ($class, $scenario, $rpt_file, $slack_threshold) = @_;
  $slack_threshold = 0 if (!defined $slack_threshold);
  my $self = {
    file            => $rpt_file,
    scenario        => $scenario,
    slack_threshold => $slack_threshold,
    paths           => [],
    wns             => 0,
    tns             => 0,
    count           => 0,
  };
  bless $self, $class;

  $self->parse_timing_report;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_file {
  my ($self) = @_;
  return $self->{file};
}

sub get_scenario {
  my ($self) = @_;
  return $self->{scenario};
}

sub get_path_list {
  my ($self) = @_;
  return @{ $self->{paths} };
}

sub get_wns {
  my ($self) = @_;
  return $self->{wns};
}

sub get_tns {
  my ($self) = @_;
  return $self->{tns};
}

sub get_count {
  my ($self) = @_;
  return $self->{count};
}

#------------------------------------------------------
# Setters
#------------------------------------------------------

#------------------------------------------------------
# Parsers
#------------------------------------------------------
sub parse_timing_report {
  my ($self) = @_;
  my $rpt_file = $self->{file};

  my $fh_in = &Hydra::Util::File::open_file_for_read($rpt_file);
  my $full_line = "";
  my $startpoint;
  my $endpoint;
  my $current_path = "data";
  my $TimingPath;
  while (my $line = <$fh_in>) {
    chomp($line);
    $full_line .= " $line";

    # Eliminate split lines
    # if ($line =~ /\((\S+)\)\s*$/) {
    #   # PT timing report sometimes splits the line after the cell reference
    #   next;
    # }
    # else {
    #   $line = $full_line;
    #   $full_line = "";
    # }

    # Dont eliminate split lines for now
    $line = $full_line;
    $full_line = "";

    if ($line =~ /Startpoint\:\s+(\S+)/) {
      $startpoint = $1;
    }
    if ($line =~ /Endpoint\:\s+(\S+)/) {
      $endpoint   = $1;
    }
    if (defined $startpoint && defined $endpoint) {
      $TimingPath = new Hydra::Report::TimingPath($startpoint, $endpoint);
      push(@{ $self->{paths} }, $TimingPath);
      $startpoint   = undef;
      $endpoint     = undef;
      $current_path = "data";
    }
    
    if (defined $TimingPath) {
      if ($line =~ /Path Group\:\s+(\S+)/) {
        $TimingPath->set_group($1);
      }
      elsif ($line =~ /Path Type\:\s+(\S+)/) {
        $TimingPath->set_delay_type($1);
      }
      elsif ($line =~ /data arrival time\s+(\S+)/) {
        $TimingPath->set_arrival($1);
        $current_path = "clock";
      }
      elsif ($line =~ /data required time\s+(\S+)/) {
        $TimingPath->set_required($1);
      }
      elsif ($line =~ /slack\s+\((VIOLATED|MET)[^\)]*\)\s+(\S+)/) {
        my $slack = $2;

        # Only record paths that are worse than the threshold
        if ($slack < $self->{slack_threshold}) {
          $TimingPath->set_slack($slack);
          
          # Process wns, tns, and count
          if ($slack < 0) {
            $self->{count}++;
            $self->{tns} += $slack;
            
            if ($slack < $self->{wns}) {
              $self->{wns} = $slack;
            }
          }
        }
        else {
          pop(@{ $self->{paths} });
        }

        $TimingPath = undef;
      }

      if ($current_path eq "data") {
        # my $startinst = $TimingPath->get_startpoint;
        # my $endinst   = $TimingPath->get_endpoint;
        # if ($line =~ /^\s*\Q${startinst}\E\/([^\s\/]+)\s+\(\S+\)/) {
        #   $TimingPath->set_startpin($1);
        # }
        # elsif ($line =~ /^\s*\Q${endinst}\E\/([^\s\/]+)\s+\(\S+\)/) {
        #   $TimingPath->set_endpin($1);
        # }
        if ($line =~ /^\s*(\S+)\s+\(\S+\)\s+\<\-/) {
          $TimingPath->set_thrupin($1);
        }

        if ($line =~ /^\s*(\S+)\s+\((\S+)\)/) {
          # Instance in data path
          my $inst_pin = $1;
          my $cell     = $2;
          next if ($cell eq "net");
          
          $inst_pin =~ s/\/[^\s\/]+$//;
          $TimingPath->add_data_point($inst_pin, $cell);
        }
      }
    }
  }
  &Hydra::Util::File::close_file($fh_in);
}

1;
