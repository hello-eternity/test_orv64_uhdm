#------------------------------------------------------
# Module Name: CellGroup
# Date:        Wed Aug 21 17:54:48 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::CellGroup;

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
    $self = $class->SUPER::new("cell", $name);
  }
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_ff {
  my ($self, $name) = @_;
  return $self->get_subgroup("ff", $name);
}

sub get_ff_list {
  my ($self) = @_;
  return () if (!defined $self->{groups}{ff});
  return sort keys %{ $self->{groups}{ff} };
}

# sub get_type {
#   my ($self) = @_;
  
#   my $is_macro_cell = "false";
#   my $is_pad_cell   = "false";
#   if ($self->has_simple_attribute("is_macro_cell")) {
#     $is_macro_cell = $self->get_simple_attribute("is_macro_cell");
#   }
#   if ($self->has_simple_attribute("pad_cell")) {
#     $is_pad_cell = $self->get_simple_attribute("pad_cell");
#   }

#   if ($is_macro_cell =~ /true/i) {
#     return "macro";
#   }
#   elsif ($is_pad_cell =~ /true/i) {
#     return "pad";
#   }
#   else {
#     return "cell";
#   }
# }

1;
