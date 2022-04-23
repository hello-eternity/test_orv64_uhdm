#------------------------------------------------------
# Module Name: PathPoint
# Date:        Mon Feb  3 12:52:09 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Report::PathPoint;

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
sub new {
  my ($class) = @_;
  my $self = {
    inst => undef,
    cell => undef,
  };
  bless $self, $class;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_inst {
  my ($self) = @_;
  return $self->{inst};
}

sub get_cell {
  my ($self) = @_;
  return $self->{cell};
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_inst {
  my ($self, $inst) = @_;
  $self->{inst} = $inst;
}

sub set_cell {
  my ($self, $cell) = @_;
  $self->{cell} = $cell;
}

1;
