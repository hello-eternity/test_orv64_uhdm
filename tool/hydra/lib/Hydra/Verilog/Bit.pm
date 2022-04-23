#------------------------------------------------------
# Module Name: Bit
# Date:        Thu Aug  8 14:47:25 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Bit;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Hydra::Verilog::Node Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $Pin, $name, $bit) = @_;
  my $self = {
    name       => $name,
    type       => "pin",
    bit        => $bit,
    Pin        => $Pin,
    input      => undef,
    output     => undef,
    inout      => undef,
    undirected => undef,
    data       => undef,
  };
  bless $self, $class;

  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_header {
  my ($self) = @_;
  return $self->{Pin};
}

sub get_hier_name {
  my ($self) = @_;
  return $self->get_header->get_parent->get_hier_name . "/$self->{name}";
}

sub get_parent {
  my ($self) = @_;
  return $self->get_header->get_parent;
}

sub get_msb {
  my ($self) = @_;
  return $self->get_header->get_msb;
}

sub get_lsb {
  my ($self) = @_;
  return $self->get_header->get_lsb;
}

sub get_direction {
  my ($self) = @_;
  return $self->get_header->get_direction;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_direction {
  my ($self, $direction) = @_;
  $self->get_header->set_direction($direction);
}

sub set_msb {
  my ($self, $msb) = @_;
  $self->get_header->set_msb($msb);
}

sub set_lsb {
  my ($self, $lsb) = @_;
  $self->get_header->set_lsb($lsb);
}

1;
