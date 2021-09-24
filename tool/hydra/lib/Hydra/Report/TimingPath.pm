#------------------------------------------------------
# Module Name: TimingPath
# Date:        Fri Jun 28 16:14:38 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Report::TimingPath;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Report::PathPoint;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub new {
  my ($class, $startpoint, $endpoint) = @_;
  my $self = {
    startpoint   => $startpoint,
    endpoint     => $endpoint,
    group        => undef,
    delay_type   => undef,
    slack        => undef,
    required     => undef,
    arrival      => undef,
    startpin     => undef,
    endpin       => undef,
    thrupin      => undef,
    data_points  => [],
    #clock_points => [],
  };
  # %point = # each element in data_points and clock_points
  #   inst|cell|si|incr|path|fanout
  #

  bless $self, $class;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_startpoint {
  my ($self) = @_;
  return $self->{startpoint};
}

sub get_endpoint {
  my ($self) = @_;
  return $self->{endpoint};
}

sub get_startpin {
  my ($self) = @_;
  return $self->{startpin};
}

sub get_endpin {
  my ($self) = @_;
  return $self->{endpin};
}

sub get_thrupin {
  my ($self) = @_;
  return $self->{thrupin};
}

sub get_group {
  my ($self) = @_;
  return $self->{group};
}

sub get_delay_type {
  my ($self) = @_;
  return $self->{delay_type};
}

sub get_slack {
  my ($self) = @_;
  return $self->{slack};
}

sub get_required {
  my ($self) = @_;
  return $self->{required};
}

sub get_arrival {
  my ($self) = @_;
  return $self->{arrival};
}

sub get_data_points {
  my ($self) = @_;
  return @{ $self->{data_points} };
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_group {
  my ($self, $group) = @_;
  $self->{group} = $group;
}

sub set_delay_type {
  my ($self, $delay_type) = @_;
  $self->{delay_type} = $delay_type;
}

sub set_slack {
  my ($self, $slack) = @_;
  $self->{slack} = $slack;
}

sub set_required {
  my ($self, $required) = @_;
  $self->{required} = $required;
}

sub set_arrival {
  my ($self, $arrival) = @_;
  $self->{arrival} = $arrival;
}

sub set_thrupin {
  my ($self, $pin) = @_;
  $self->{thrupin} = $pin;
}

sub add_data_point {
  my ($self, $inst, $cell) = @_;
  my $Point = new Hydra::Report::PathPoint;
  $Point->set_inst($inst);
  $Point->set_cell($cell);
  push(@{ $self->{data_points} }, $Point);
}

1;
