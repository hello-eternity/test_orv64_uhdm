#------------------------------------------------------
# Module Name: Control
# Date:        Mon Jan 28 12:21:07 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::Control;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;
use Hydra::Setup::Run;

our $VERSION = 1.00;
our @ISA     = qw(Hydra::Setup::Param Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our %glb_error_params = ();

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $Param, $control_file) = @_;
  my $self = {
    type         => "control",
    Parent       => $Param,
    params       => {},
    runs         => {},
    control_file => $control_file,
  };
  bless $self, $class;

  $self->error_check_control_file;
  $self->parse_control_file_for_control_overrides;
  $self->parse_control_file_for_runs;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_control_file {
  my ($self) = @_;
  return $self->{control_file};
}

sub get_runs {
  my ($self) = @_;
  return $self->{runs};
}

sub get_run_list {
  my ($self) = @_;
  return sort keys %{ $self->{runs} };
}

sub is_run {
  my ($self, $run_name) = @_;
  if (defined $self->{runs}{$run_name}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_run {
  my ($self, $run_name) = @_;
  return $self->{runs}{$run_name};
}

#------------------------------------------------------
# Run
#------------------------------------------------------
sub write_runs {
  my ($self, $aref_runs, $out_dir) = @_;

  # Move to out dir for generation
  my $orig_dir = cwd;
  if (defined $out_dir) {
    chdir($out_dir);
  }

  my %resolved = ();
  foreach my $run_name (@$aref_runs) {
    if (!$self->is_run($run_name)) {
      warn "WARN: Run \"${run_name}\" is not valid, skipping...\n";
      next;
    }

    my $Run = $self->get_run($run_name);
    $Run->resolve;

    my %error_params = &get_error_params;
    &reset_error_params;

    $resolved{$run_name}{run}   = $Run;
    $resolved{$run_name}{err}   = \%error_params;

    # Resolve subruns
    foreach my $subrun_name ($Run->get_subrun_list) {
      my $SubRun = $Run->get_subrun($subrun_name);
      $SubRun->resolve;

      my %suberror_params = &get_error_params;
      &reset_error_params;

      $resolved{$run_name}{subrun}{$subrun_name}{run} = $SubRun;
      $resolved{$run_name}{subrun}{$subrun_name}{err} = \%suberror_params;
    }
  }

  # Check for error params
  my $has_error = 0;
  foreach my $run_name (keys %resolved) {
    if (&check_error_params($resolved{$run_name}{err}, $run_name)) {
      $has_error = 1;
    }

    foreach my $subrun_name (keys %{ $resolved{$run_name}{subrun} }) {
      if (&check_error_params($resolved{$run_name}{subrun}{$subrun_name}{err}, $run_name, $subrun_name)) {
        $has_error = 1;
      }
    }
  }
  die if ($has_error);

  # Write all files
  foreach my $run_name (keys %resolved) {
    my $Run = $resolved{$run_name}{run};
    $Run->write;

    # Write subfiles
    foreach my $subrun_name (keys %{ $resolved{$run_name}{subrun} }) {
      my $top_dir = cwd;
      chdir $run_name;
      
      my $SubRun = $resolved{$run_name}{subrun}{$subrun_name}{run};
      $SubRun->write;
      
      chdir $top_dir;
    }
  }

  if (defined $out_dir) {
    chdir($orig_dir);
  }
}

sub write_all_runs {
  my ($self, $out_dir) = @_;
  my @runs = $self->get_run_list;
  $self->write_runs(\@runs, $out_dir);
}

#------------------------------------------------------
# Parsers
#------------------------------------------------------
sub parse_control_file_for_control_overrides {
  my ($self) = @_;
  my $href_params  = $self->get_params;
  my $control_file = $self->get_control_file;

  my $fh_control = &Hydra::Util::File::open_file_for_read($control_file);
  my $in_param   = 0;
  my @param_line_array = ();
  while (my $line = <$fh_control>) {
    #chomp($line);

    # Skip all START definitions
    if ($line =~ /^\s*START/) {
      while ($line = <$fh_control>) {
        last if ($line =~ /^\s*END\s*$/);
      }
    }

    # Anything not within a START statement is a control override param
    push(@param_line_array, $line);
  }
  &Hydra::Setup::Param::parse_param_block($href_params, \@param_line_array, "control");

  &Hydra::Util::File::close_file($fh_control);
}

sub parse_control_file_for_runs {
  my ($self) = @_;
  my $href_runs    = $self->get_runs;
  my $control_file = $self->get_control_file;
  
  my @runs = ();
  my $fh_control = &Hydra::Util::File::open_file_for_read($control_file);
  while (my $line = <$fh_control>) {
    chomp($line);
    $line =~ s/\#.*//g;
    next if ($line =~ /^\s*$/);

    if ($line =~ /^\s*START\s+(\S+)\s*$/) {
      push(@runs, $1);
    }
  }
  &Hydra::Util::File::close_file($fh_control);

  foreach my $run_name (@runs) {
    die "ERROR: run=${run_name} is being redefined!\n"
        if (defined $href_runs->{$run_name});

    $href_runs->{$run_name} = new Hydra::Setup::Run($self, $run_name, $control_file);
  }
}

sub error_check_control_file {
  my ($self) = @_;
  my $control_file = $self->get_control_file;

  my $fh_control = &Hydra::Util::File::open_file_for_read($control_file);
  my $run_name;
  my $eco_name;
  while (my $line = <$fh_control>) {
    if ($line =~ /^\s*START\s+(\S+)\s*$/) {
      # Check that previous run was ENDed
      if (defined $run_name) {
        die "ERROR: Run statement for $run_name not terminated with END!\n";
      }

      $run_name = $1;
    }
    elsif ($line =~ /^\s*ECO\s+(\S+)\s*$/) {
      # Check that previous eco was ENDed
      if (defined $eco_name) {
        die "ERROR: Eco statement for $eco_name not terminated with ECOEND!\n";
      }

      $eco_name = $1;

      # Check that eco is inside run
      if (!defined $run_name) {
        die "ERROR: ECO statement for $eco_name is not defined inside a run!\n";
      }
    }
    elsif ($line =~ /^\s*END\s*$/) {
      $run_name = undef;
    }
    elsif ($line =~ /^\s*ECOEND\s*$/) {
      $eco_name = undef;
    }
  }
  &Hydra::Util::File::close_file($fh_control);

  # Check that previous run was ENDed
  if (defined $run_name) {
    die "ERROR: Run statement for $run_name not terminated with END!\n";
  }

  # Check that previous eco was ENDed
  if (defined $eco_name) {
    die "ERROR: Eco statement for $eco_name not terminated with ECOEND!\n";
  }
}

#------------------------------------------------------
# Class Methods
#------------------------------------------------------
sub register_error_param {
  my ($param_name, $error_type) = @_;
  push(@{ $glb_error_params{$error_type} }, $param_name);
}

sub get_error_params {
  return %glb_error_params;
}

sub reset_error_params {
  %glb_error_params = ();
}

sub check_error_params {
  my ($href_error, $run_name, $subrun_name) = @_;

  if (&has_error_params($href_error)) {
    if (defined $subrun_name) {
      warn "ERROR: Param issues encountered while resolving run ${run_name} - eco ${subrun_name}\n";
    }
    else {
      warn "ERROR: Param issues encountered while resolving run ${run_name}\n";
    }
    foreach my $error_type (sort keys %$href_error) {
      if ($error_type eq "required") {
        warn "       The following params have a value not changed from <required> flag:\n";
      }
      elsif ($error_type eq "value") {
        warn "       The following params require a value:\n";
      }
      elsif ($error_type eq "missing") {
        warn "       The following params are missing:\n";
      }
      elsif ($error_type eq "key") {
        warn "       The following params could not be found for the given keys:\n";
      }
      elsif ($error_type eq "nokey") {
        warn "       The following params have keys, but a non-keyed version is needed:\n";
      }
      elsif ($error_type eq "numkey") {
        warn "       The following params have the wrong number of keys:\n";
      }
      elsif ($error_type eq "lib") {
        warn "       The following params could not be linked to a lib var:\n";
      }
      elsif ($error_type eq "cts_corner") {
        warn "       More than one pnr_cts corner specified during PNR SCENARIO creation:\n";
      }
      elsif ($error_type eq "no_cts_corner") {
        warn "       No pnr_cts corner specified during PNR SCENARIO creation:\n";
      }
      elsif ($error_type eq "scenario_lib") {
        warn "       No library name specified during PNR SCENARIO creation:\n";
      }
      elsif ($error_type eq "format") {
        warn "       The following params have the wrong value format:\n";
      }
      elsif ($error_type eq "lib_corner") {
        warn "       The following flows have more or less than one library corner defined:\n";
      }
      elsif ($error_type eq "no_scenario") {
        warn "       The following flows have no scenario defined:\n";
      }
      elsif ($error_type eq "generic") {
        warn "       General error encountered:\n";
      }
      
      my @params = @{ $href_error->{$error_type} };
      my %unique = map{$_ => 1} @params;
      @params = sort keys %unique;
      foreach my $param_name (@params) {
        warn "         $param_name\n";
      }
    }
    return 1;
  }

  return 0;
}

sub has_error_params {
  my ($href_error) = @_;
    foreach my $error_type (keys %$href_error) {
    if (defined $href_error->{$error_type} && scalar(@{ $href_error->{$error_type} }) > 0) {
      return 1;
    }
  }
  
  return 0;
}


1;
