#------------------------------------------------------
# Module Name: Power
# Date:        Mon Jan 13 16:56:20 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Power;

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
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $run_dir, $tool) = @_;
  my $self = {
    run_dir => $run_dir,
    tool    => $tool,
  };
  bless $self, $class;

  my $subref = \&{ "${tool}_sum_power" };
  if (defined &$subref) {
    $self->$subref;
  }

  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub dump {

}

1;
