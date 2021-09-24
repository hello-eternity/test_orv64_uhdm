#------------------------------------------------------
# Module Name: Literal
# Date:        Fri Aug 16 13:27:21 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Literal;

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
  my ($class, $Design, $name) = @_;
  my $self = {
    name     => $name,
    Design   => $Design,
    output   => undef,
  };
  bless $self, $class;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_hier_name {
  my ($self) = @_;
  return $self->get_name;
}

sub get_direction {
  my ($self) = @_;
  return "output";
}

sub get_connection_list {
  my ($self, $direction) = @_;
  if ($direction ne "output") {
    die "ERROR: attempting to retrieve non-output connection on a literal!\n";
  }

  return $self->SUPER::get_connection_list($direction);
}

#------------------------------------------------------
# Queries
#------------------------------------------------------
sub is_literal {
  my ($self) = @_;
  return 1;
}


1;
