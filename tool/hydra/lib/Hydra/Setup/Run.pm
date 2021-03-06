#------------------------------------------------------
# Module Name: Run
# Date:        Tue Jan 29 12:59:26 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::Run;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;

use Hydra::Setup::File;
use Hydra::Setup::Eco;

our $VERSION = 1.00;
our @ISA     = qw(Hydra::Setup::Control Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $Control, $run_name, $control_file) = @_;
  my $self = {
    name         => $run_name,
    type         => "run",
    Parent       => $Control,
    params       => {},
    files        => {},
    kfiles       => {},
    subruns      => {},
    control_file => $control_file,
  };
  bless $self, $class;

  $self->parse_control_file_for_overrides;
  $self->parse_control_file_for_subruns;
  $self->check_subrun_naming;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_name {
  my ($self) = @_;
  return $self->{name};
}

sub get_files {
  my ($self) = @_;
  return $self->{files};
}

sub get_kickoff_file {
  my ($self, $flow_type, $sub_type) = @_;
  my $file_type = $flow_type;
  $file_type .= "_${sub_type}" if (defined $sub_type);

  if (defined $self->{kfiles}{$file_type}) {
    return $self->{kfiles}{$file_type};
  }
  else {
    my $KickoffFile = new Hydra::Setup::File("HYDRA.run", $flow_type, $sub_type);
    $self->{kfiles}{$file_type} = $KickoffFile;
    my $time = localtime;
    $KickoffFile->add_line("#!/usr/bin/bash");
    $KickoffFile->add_line("# Generated by Hydra on $time");
    $KickoffFile->add_line("export HYDRA_HOME=$ENV{HYDRA_HOME}");
    $KickoffFile->add_linebreak;
    $KickoffFile->make_executable;
    
    return $KickoffFile;
  }
}

sub get_all_kickoff_files {
  my ($self) = @_;
  my @Files = ();
  foreach my $flow_type (sort keys %{ $self->{kfiles} }) {
    push(@Files, $self->{kfiles}{$flow_type});
  }
  return \@Files;
}

sub get_subruns {
  my ($self) = @_;
  return $self->{subruns};
}

sub get_subrun_list {
  my ($self) = @_;
  return sort keys %{ $self->{subruns} };
}

sub get_subrun {
  my ($self, $name) = @_;
  return $self->{subruns}{$name};
}

sub is_run {
  my ($self) = @_;
  return 1;
}

sub is_eco {
  my ($self) = @_;
  return 0;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_files {
  my ($self, @Files) = @_;
  $self->{files} = \@Files;
}

#------------------------------------------------------
# Parsers
#------------------------------------------------------
sub parse_control_file_for_overrides {
  my ($self, $type) = @_;
  my $href_overrides = $self->get_params;
  my $name           = $self->get_name;
  my $control_file   = $self->get_control_file;

  my $fh_control = &Hydra::Util::File::open_file_for_read($control_file);
  my $in_param   = 0;
  my @param_line_array = ();
  while (my $line = <$fh_control>) {
    #chomp($line);
    
    # Only parse params within a START for this run
    if ($line =~ /^\s*START\s+${name}\s*$/) {
      die "ERROR: param overrides for run=${name} is being redefined!\n" if ($in_param);

      $in_param = 1;
    }
    elsif ($line =~ /^\s*END/) {
      $in_param = 0;
      &Hydra::Setup::Param::parse_param_block($href_overrides, \@param_line_array);
      @param_line_array = ();
    }
    elsif ($line =~ /^\s*ECO\s+(\S+)/) {
      # Skip ECO subrun
      $in_param = 0;
    }
    elsif ($line =~ /^\s*ECOEND/) {
      # Skip ECO subrun
      $in_param = 1;
    }
    # Parse param if we are currently in a START
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

sub parse_control_file_for_subruns {
  my ($self) = @_;
  my $run_name     = $self->get_name;
  my $href_subruns = $self->get_subruns;
  my $control_file = $self->get_control_file;

  my @subruns = ();
  my $fh_control = &Hydra::Util::File::open_file_for_read($control_file);
  my $in_run = 0;
  while (my $line = <$fh_control>) {
    chomp($line);
    $line =~ s/\#.*//g;
    next if ($line =~ /^\s*$/);

    if ($line =~ /^\s*START\s+${run_name}\s*$/) {
      $in_run = 1;
    }
    elsif ($line =~ /^\s*END\s*$/) {
      $in_run = 0;
    }
    elsif ($in_run && $line =~ /^\s*ECO\s+(\S+)\s*$/) {
      push(@subruns, $1);
    }
  }
  &Hydra::Util::File::close_file($fh_control);

  foreach my $subrun_name (@subruns) {
    die "ERROR: ecorun=${subrun_name} if being redefined!\n"
        if (defined $href_subruns->{$subrun_name});

    $href_subruns->{$subrun_name} = new Hydra::Setup::Eco($self, $subrun_name, $control_file);
  }
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub resolve {
  my ($self) = @_;
  my @Files    = ();

  # Regular run
  my $flow = $self->get_param_value("FLOW", "strict");
  $flow = &Hydra::Setup::Param::remove_param_value_linebreak($flow);
  foreach my $flow_name (split(/\s+/, $flow)) {
    # Check for ECO only flows
    if ($self->is_run && &Hydra::Setup::Flow::is_flow_eco_only($flow_name)) {
      warn "WARN: Skipping eco only flow $flow_name called in run " . $self->get_name . "\n";
      next;
    }

    # Create/get kickoff script
    my $KickoffFile;
    my $flow_type = &Hydra::Setup::Flow::get_flow_type($flow_name);
    my $sub_type  = &Hydra::Setup::Flow::get_flow_sub_type($flow_name);
    if (defined $flow_type && $flow_type ne "hydra") {
      $KickoffFile = $self->get_kickoff_file($flow_type, $sub_type);
    }
    
    push(@Files, &Hydra::Setup::Flow::dispatch($self, $flow_name, $KickoffFile));
  }

  $self->set_files(@Files);
}

sub write {
  my ($self) = @_;

  my $aref_Files  = $self->get_files;
  my $aref_KFiles = $self->get_all_kickoff_files;

  # Dont create eco's that are not listed in ECO_runs
  my $eco_runs = $self->get_param_value("ECO_runs", "relaxed");
  if (&Hydra::Setup::Param::has_value($eco_runs)) {
    $eco_runs = &Hydra::Setup::Param::remove_param_value_linebreak($eco_runs);
    my %runs = map{$_ => 1} split(/\s+/, $eco_runs);
    if ($self->is_eco && !defined $runs{$self->get_name}) {
      return;
    }
  }
  
  # Make run directory and default directories
  my $run_name = $self->get_name;
  &Hydra::Util::File::make_dir($run_name);
  my $top_dir = cwd;
  chdir $run_name;
  my $run_dir = cwd;

  # Write all files
  # Global KickoffFiles stored here are written first so that local KickoffFiles
  # returned by dispatch will overwrite them
  my $eco_only = $self->get_param_value("ECO_only", "relaxed");
  if ($self->is_eco || ($self->is_run && !&Hydra::Setup::Param::is_on($eco_only))) {
    # Dont resolve this Run if ECO_only is on
    foreach my $File ((@$aref_KFiles, @$aref_Files)) {
      my $type_dir = $File->get_type_dir;
      &Hydra::Util::File::make_dir($type_dir);
      chdir $type_dir;
      &make_run_dirs($File);
      
      $File->write;
      
      chdir $run_dir;
    }
  }

  chdir $top_dir;
}

sub make_run_dirs {
  my ($File) = @_;
  my @run_dirs = qw(script log rpt output db);

  foreach my $dir (@run_dirs) {
    &Hydra::Util::File::make_dir($dir);
  }

  if (defined $File) {
    foreach my $dir ($File->get_dirs) {
      &Hydra::Util::File::make_dir($dir);
    }
  }
}

sub check_subrun_naming {
  my ($self) = @_;
  my $run_name     = $self->get_name;
  my $href_subruns = $self->get_subruns;

  # Check that every name follows eco<num> naming convention
  foreach my $subrun_name (keys %$href_subruns) {
    if ($subrun_name !~ /eco\d\d/) {
      warn "ERROR: Run ${run_name} contains eco with invalid name: ${subrun_name}\n";
      die  "       Use naming convention \"eco01_description\"\n";
    }
  }

  # Check that numbering is consecutive, including possible existing eco runs
  my @subrun_names = keys %$href_subruns;
  my $run_dir = cwd . "/" . $self->get_name;
  if (-d $run_dir) {
    foreach my $subdir (&Hydra::Util::File::get_sub_dirs($run_dir)) {
      if ($subdir =~ /^eco\d+/) {
        push(@subrun_names, $subdir);
      }
    }
  }
  my %dup = map {$_ => 1} @subrun_names;
  @subrun_names = sort { &sort_subruns($a, $b) } keys %dup;

  my $count      = 1;
  my $error_list = "";
  my $has_error  = 0;
  foreach my $subrun_name (@subrun_names) {
    $subrun_name =~ /eco(\d+)/;
    my $subrun_num = $1;

    if ($count != $subrun_num) {
      $has_error = 1;
      $error_list .= "   --> $subrun_name <--\n";
    }
    else {
      $error_list .= "       $subrun_name\n";
    }
    $count++;
  }

  if ($has_error) {
    warn "WARN: Run ${run_name} has nonconsecutive eco:\n";
    warn "$error_list";
  }
}

sub sort_subruns {
  my ($a, $b) = @_;
  my ($a_num, $b_num);

  $a =~ /eco(\d+)/;
  $a_num = $1;

  $b =~ /eco(\d+)/;
  $b_num = $1;

  return $a_num <=> $b_num;
}

1;
