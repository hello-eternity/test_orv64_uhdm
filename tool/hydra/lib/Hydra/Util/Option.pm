#------------------------------------------------------
# Module Name: Option
# Date:        Mon Jan 28 11:45:29 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Util::Option;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our %glb_options = ();
our $glb_run_command;
our $glb_raw_options = "";

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub process_options {
  my $arg;
  my $opt_name = "";

  # First argument is always the command
  $glb_run_command = shift @ARGV;

  # Record options as is
  $glb_raw_options = join(" ", @ARGV);

  while ($arg = shift @ARGV) {
    if ($arg =~ /^\-/) {
      $opt_name = $arg;
    }
    else {
      my $opt_value = $arg;
      
      # Previous value was already defined for option
      if (defined $glb_options{$opt_name}) {
        # Create array containing previous scalar
        if (ref($glb_options{$opt_name}) eq "") {
          my @opt_vals = ();
          push(@opt_vals, $glb_options{$opt_name});
          push(@opt_vals, $opt_value);
          $glb_options{$opt_name} = \@opt_vals;
        }
        # Add to existing array
        elsif (ref($glb_options{$opt_name}) eq "ARRAY") {
          push(@{ $glb_options{$opt_name} }, $opt_value);
        }
      }
      # New option
      else {
        $glb_options{$opt_name} = $opt_value;
      }
    }
  }
}

sub get_opt_value_scalar {
  my ($opt_name, $mode, $default) = @_;
  $mode = "relaxed" if (!defined $mode);

  my $value = $glb_options{$opt_name};
  # Defined: for checking strict
  if (defined $value) {
    # Ref type: for checking scalar
    if (ref($value) eq "") {
      return $value;
    }
    else {
      die "ERROR: only single values supported for option=${opt_name}\n";
    }
  }
  else {
    if ($mode eq "strict") {
      warn "ERROR: value for option=${opt_name} not defined!\n";
      die  "       Try \"hydra.pl help ${glb_run_command}\" to see valid options\n";
    }
    else {
      return $default;
    }
  }
}

sub get_opt_value_array {
  my ($opt_name, $mode, $aref_default) = @_;
  $mode = "relaxed" if (!defined $mode);

  my $value = $glb_options{$opt_name};
  # Defined: for checking strict
  if (defined $value) {
    # Ref type: for checking array
    if (ref($value) eq "ARRAY") {
      return $value;
    }
    elsif (ref($value) eq "") {
      my @array = ();
      push(@array, $value);
      return \@array;
    }
    else {
      confess "ERROR: unexpected value encountered for option=${opt_name}\n";
    }
  }
  else {
    if ($mode eq "strict") {
      warn "ERROR: value for option=${opt_name} not defined!\n";
      die  "       Try \"hydra.pl help ${glb_run_command}\" to see valid options\n";
    }
    else {
      return $aref_default;
    }
  }
}

sub get_raw_options {
  return $glb_raw_options;
}

sub is_option {
  my ($opt_name) = @_;
  if (defined $glb_options{$opt_name}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_run_command {
  return $glb_run_command;
}

1;
