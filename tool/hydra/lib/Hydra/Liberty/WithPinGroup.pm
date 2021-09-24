#------------------------------------------------------
# Module Name: WithPinGroup
# Date:        Thu Aug 20 15:31:38 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::WithPinGroup;

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
# This class is for groups (such as cell or bus) that
#   need subroutines for accessing pin groups
#------------------------------------------------------
sub new {
  my ($class, $type, $name) = @_;
  return $class->SUPER::new($type, $name);
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub find_pin {
  my ($self, $pin_name) = @_;

  if ($pin_name =~ /\[(\d+)\]/) {
    # Bus
    my $bit = $1;
    my $base_pin = $pin_name;
    $base_pin =~ s/\[\d+\]//;

    my $Bus = $self->get_bus($base_pin);
    my $BusPin;
    $BusPin = $Bus->get_pin($pin_name) if (defined $Bus);

    # Return pin group defined under bus if it exists
    return $BusPin if (defined $BusPin);

    # Return bus group
    return $Bus if (defined $Bus);

    # Return bundle group
    my $Bundle = $self->get_bundled_pin($pin_name);
    return $Bundle if (defined $Bundle);
  }
  else {
    # Pin
    my $Pin = $self->get_pin($pin_name);
    return $Pin if (defined $Pin);

    # Bus
    my $Bus = $self->get_bus($pin_name);
    return $Bus if (defined $Bus);

    # Bundle
    my $Bundle = $self->get_bundled_pin($pin_name);
    return $Bundle if (defined $Bundle);
  }

  return undef;
}

sub get_pin_list {
  my ($self) = @_;
  my @pins = ();
  if (defined $self->{pin_list}) {
    foreach my $pin_name (@{ $self->{pin_list} }) {
      if ($self->has_pin($pin_name)) {
        push(@pins, $self->get_pin($pin_name));
      }
      elsif ($self->has_bus($pin_name)) {
        push(@pins, $self->get_bus($pin_name));
      }
      elsif ($self->has_bundled_pin($pin_name)) {
        push(@pins, $self->get_bundled_pin($pin_name));
      }
    }
  }
  return @pins;
}

sub get_pin {
  my ($self, $name) = @_;
  return $self->get_subgroup("pin", $name);
  ### Support bit range?
  ### e.g. pin(WTSEL[1:0]) {
}

sub get_bus {
  my ($self, $name) = @_;
  return $self->get_subgroup("bus", $name);
}

sub get_bundled_pin {
  my ($self, $name) = @_;

  foreach my $Bundle ($self->get_subgroup_list("bundle")) {
    my @pins = $Bundle->get_bundled_pin_list;
    my %pins = map {$_ => 1} @pins;
    return $Bundle if (defined $pins{$name});
  }

  return undef;
}

#------------------------------------------------------
# Queries
#------------------------------------------------------
sub has_pin {
  my ($self, $name) = @_;
  if (defined $self->get_pin($name)) {
    return 1;
  }
  return 0;
}

sub has_bus {
  my ($self, $name) = @_;
  if (defined $self->get_bus($name)) {
    return 1;
  }
  return 0;
}

sub has_bundled_pin {
  my ($self, $name) = @_;
  if (defined $self->get_bundled_pin($name)) {
    return 1;
  }
  return 0;
}

1;
