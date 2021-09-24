#------------------------------------------------------
# Module Name: BusGroup
# Date:        Wed Aug 21 17:54:57 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::BusGroup;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Hydra::Liberty::WithPinGroup Exporter);

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
    $self = $class->SUPER::new("bus", $name);
  }
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_bus_type {
  my ($self) = @_;
  return $self->get_simple_attribute("bus_type");
}

sub get_bus_direction {
  my ($self) = @_;
  if ($self->has_simple_attribute("direction")) {
    return $self->has_simple_attribute("direction");
  }
  else {
    # Try looking through the pin list if direction is not found
    foreach my $PinLib ($self->get_pin_list) {
      if ($PinLib->has_simple_attribute("direction")) {
        return $PinLib->get_simple_attribute("direction");
      }
    }
  }

  return undef;
}

1;
