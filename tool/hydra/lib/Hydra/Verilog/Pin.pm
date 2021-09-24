#------------------------------------------------------
# Module Name: Pin
# Date:        Fri Aug  2 16:11:50 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Pin;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Verilog::Node;
use Hydra::Verilog::Bit;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $Parent, $name) = @_;
  my $self = {
    name         => $name,
    direction    => "undirected",
    msb          => undef,
    lsb          => undef,
    bits         => {},
    renamed_nets => undef,
    Parent       => $Parent,
    data         => undef,
  };
  bless $self, $class;
  
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_name {
  my ($self) = @_;
  return $self->{name};
}

sub get_parent {
  my ($self) = @_;
  return $self->{Parent};
}

sub get_msb {
  my ($self) = @_;
  return $self->{msb};
}

sub get_lsb {
  my ($self) = @_;
  return $self->{lsb};
}

sub get_direction {
  my ($self) = @_;
  return $self->{direction};
}

sub has_bus {
  my ($self) = @_;
  if (defined $self->{msb} && defined $self->{lsb}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_bit {
  my ($self, $bit) = @_;

  # Check that bit is valid for this pin
  if ($bit ne "-1") {
    # Check that msb/lsb are defined
    if (!defined $self->{msb} || !defined $self->{lsb}) {
      print "WARN: Requested bit=${bit} for non-bus pin=$self->{name}!\n";
      return undef;
    }

    # Check that bit is in range
    my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($self->{msb}, $self->{lsb});
    if ($bit > $upper || $bit < $lower) {
      print "WARN: Requested bit=${bit} out of range for pin=$self->{name} msb=$self->{msb} lsb=$self->{lsb}!\n";
      return undef;
    }
  }

  # Resolve bits on first request
  if (!defined $self->{bits}{$bit}) {
    $self->resolve_bit($bit);
  }

  return $self->{bits}{$bit};
}

sub get_bit_list {
  my ($self) = @_;
  my @bits = ();
  if ($self->has_bus) {
    my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($self->{msb}, $self->{lsb});
    foreach my $index ($lower..$upper) {
      push(@bits, $self->get_bit($index));
    }

    # Preserve endianness
    if ($lower == $self->{lsb}) {
      @bits = reverse @bits;
    }
  }
  else {
    push(@bits, $self->get_bit(-1));
  }

  return @bits;
}

sub has_renamed_nets {
  my ($self) = @_;
  return 1 if (defined $self->{renamed_nets});
  return 0;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_msb {
  my ($self, $msb) = @_;
  $self->{msb} = $msb;
}

sub set_lsb {
  my ($self, $lsb) = @_;
  $self->{lsb} = $lsb;
}

sub set_renamed_nets {
  my ($self, $aref_nets) = @_;
  $self->{renamed_nets} = $aref_nets;
}

sub set_direction {
  my ($self, $direction) = @_;
  $self->{direction} = $direction;
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub resolve_bit {
  my ($self, $bit) = @_;
  my $bit_name = $self->{name};
  unless ($bit eq "-1") {
    $bit_name .= "[${bit}]";
  }
  my $Bit = new Hydra::Verilog::Bit($self, $bit_name, $bit);
  $self->{bits}{$bit} = $Bit;
}

1;
