#------------------------------------------------------
# Module Name: BundleGroup
# Date:        Wed Aug 21 17:55:02 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::BundleGroup;

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
    $self = $class->SUPER::new("bundle", $name);
  }
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_bundled_pin_list {
  my ($self) = @_;
  my @values = $self->get_complex_attribute("members");
  if (scalar(@values) > 1) {
    die "ERROR: bundle=" . $self->get_name . " has more than one members attribute\n";
  }

  my $members_val = $values[0];
  $members_val =~ s/\"//g;
  my @pins = split(/\s*\,\s*/, $members_val);
  return @pins;
}

1;
