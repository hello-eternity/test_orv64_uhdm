#------------------------------------------------------
# Module Name: LibraryGroup
# Date:        Wed Aug 21 17:54:41 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::LibraryGroup;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Hydra::Liberty::Group Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $type, $name) = @_;
  my $self;
  if (defined $name) {
    $self = $class->SUPER::new($type, $name);
  }
  else {
    $name = $type;
    $self = $class->SUPER::new("library", $name);
  }
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_cell {
  my ($self, $name) = @_;
  return $self->get_subgroup("cell", $name);
}

sub get_bus_width {
  my ($self, $bus_type) = @_;
  my $BusType = $self->get_subgroup("type", $bus_type);
  if (!defined $BusType) {
    return (undef, undef);
  }

  my $msb;
  my $lsb;
  if ($BusType->has_simple_attribute("bit_from") && $BusType->has_simple_attribute("bit_to")) {
    $msb = $BusType->get_simple_attribute("bit_from");
    $lsb = $BusType->get_simple_attribute("bit_to");
  }
  elsif ($BusType->has_simple_attribute("bit_width")) {
    my $width = $BusType->get_simple_attribute("bit_width");
    $msb = $width-1;
    $lsb = 0;
  }
  else {
    return (undef, undef);
  }

  return ($msb, $lsb);
}

#------------------------------------------------------
# Queries
#------------------------------------------------------
sub has_cell {
  my ($self, $name) = @_;
  if (defined $self->get_cell($name)) {
    return 1;
  }
  return 0;
}

1;
