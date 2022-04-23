#------------------------------------------------------
# Module Name: Pnr
# Date:        Mon Jan 13 16:56:06 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Pnr;

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

  my $subref = \&{ "${tool}_sum_pnr" };
  if (defined &$subref) {
    $self->$subref;
  }

  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub icc2_sum_pnr {
  my ($self) = @_;
  my $run_dir = $self->{run_dir};
  my $rpt_dir = "${run_dir}/rpt";
  my $log_dir = "${run_dir}/log";

  # Design report
  my $design_rpt = "${rpt_dir}/design.netlist.rpt";
  if (-f $design_rpt) {
    my $fh_design = &Hydra::Util::File::open_file_for_read($design_rpt);
    while (my $line = <$fh_design>) {
      if ($line =~ /Standard cells\s+(\d+)/) {
        $self->{stats}{"Std Count"} = $1;
      }
      elsif ($line =~ /Sequential\s+(\d+)/) {
        $self->{stats}{"Flop Count"} = $1;
      }
      elsif ($line =~ /Buffer\/inverter\s+(\d+)/) {
        $self->{stats}{"Buffer Count"} = $1;
      }
    }
    &Hydra::Util::File::close_file($fh_design);
  }

  # Congestion report
  my $cong_rpt = "${rpt_dir}/congestion.rpt";
  if (-f $cong_rpt) {
    my $fh_cong = &Hydra::Util::File::open_file_for_read($cong_rpt);
    while (my $line = <$fh_cong>) {
      if ($line =~ /H routing\s*\|\s*\S+\s*\|\s*\S+\s*\|\s*\S+\s*\(\s*([\d\.\%]+)\s*\)/) {
        $self->{stats}{"Horizontal GRC"} = $1;
      }
      elsif ($line =~ /V routing\s*\|\s*\S+\s*\|\s*\S+\s*\|\s*\S+\s*\(\s*([\d\.\%]+)\s*\)/) {
        $self->{stats}{"Vertical GRC"} = $1;
      }
    }
    &Hydra::Util::File::close_file($fh_cong);
  }

  # Route opt log
  my $route_opt_log = "${log_dir}/route_opt.log";
  if (-f $route_opt_log) {
    my $fh_log = &Hydra::Util::File::open_file_for_read($route_opt_log);
    while (my $line = <$fh_log>) {
      if ($line =~ /Total number of short violations is (\d+)/) {
        $self->{stats}{Shorts} = $1;
      }
    }
    &Hydra::Util::File::close_file($fh_log);
  }
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub dump {
  my ($self) = @_;
  my $ret_val = "";

  foreach my $metric (sort keys %{ $self->{stats} }) {
    $ret_val .= "PNR ${metric}=$self->{stats}{$metric}\n";
  }

  return $ret_val;
}

1;
