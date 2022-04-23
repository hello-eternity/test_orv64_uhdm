#------------------------------------------------------
# Module Name: Eco
# Date:        Mon Jun 17 17:36:42 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::Eco;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Hydra::Setup::Run Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub new {
  my ($class, $Run, $name, $control_file) = @_;
  my $self = {
    name         => $name,
    type         => "eco",
    Parent       => $Run,
    params       => {},
    files        => {},
    kfiles       => {},
    control_file => $control_file,
  };
  bless $self, $class;

  $self->parse_control_file_for_overrides;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub is_run {
  my ($self) = @_;
  return 0;
}

sub is_eco {
  my ($self) = @_;
  return 1;
}

#------------------------------------------------------
# Parsers
#------------------------------------------------------
sub parse_control_file_for_overrides {
  my ($self, $type) = @_;
  my $href_overrides = $self->get_params;
  my $name           = $self->get_name;
  my $run_name       = $self->get_parent->get_name;
  my $control_file   = $self->get_control_file;

  my $fh_control = &Hydra::Util::File::open_file_for_read($control_file);
  my $in_run     = 0;
  my $in_param   = 0;
  my @param_line_array = ();
  while (my $line = <$fh_control>) {
    #chomp($line);
    
    # Only parse params within a START for this run and ECO for this ecorun
    if ($line =~ /^\s*START\s+${run_name}\s*$/) {
      $in_run = 1;
    }
    elsif ($line =~ /^\s*END/) {
      $in_run = 0;
    }
    elsif ($in_run && $line =~ /^\s*ECO\s+${name}\s*$/) {
      die "ERROR: param overrides for ecorun=${name} is being redefined!\n" if ($in_param);
      $in_param = 1;
    }
    elsif ($in_run && $line =~ /^\s*ECOEND/) {
      $in_param = 0;
      &Hydra::Setup::Param::parse_param_block($href_overrides, \@param_line_array);
      @param_line_array = ();
    }
    # Parse param if we are currently in a ECO
    elsif ($in_param) {
      push(@param_line_array, $line);
    }
  }
  &Hydra::Util::File::close_file($fh_control);

  # Get a param block from the command line to override run params
  my $cmd_line_override_block = &Hydra::Util::Option::get_opt_value_scalar("-param_override", "relaxed", "");
  @param_line_array = split(/\;/, $cmd_line_override_block);
  &Hydra::Setup::Param::parse_param_block($href_overrides, \@param_line_array);
}

1;
