#------------------------------------------------------
# Module Name: File
# Date:        Tue Jan 29 14:55:42 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::File;

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
  my ($class, $file_name, $file_type, $sub_type) = @_;
  my $self = {
    name          => $file_name,
    type          => $file_type,
    subtype       => $sub_type,
    executable    => 0,
    lines         => [],
    dirs          => [],
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

sub get_type {
  my ($self) = @_;
  return $self->{type};
}

sub get_subtype {
  my ($self) = @_;
  return $self->{subtype};
}

sub get_type_dir {
  my ($self) = @_;
  my $type_dir = $self->{type};
  if (defined $self->{subtype}) {
    $type_dir .= "_$self->{subtype}";
  }
  return $type_dir;
}

sub get_lines {
  my ($self) = @_;
  my @lines = ();
 
  foreach my $line (@{ $self->{lines} }) {
    push(@lines, $line);
  }

  return @lines;
}

sub get_dirs {
  my ($self) = @_;
  my @dirs = ();

  foreach my $dir (@{ $self->{dirs} }) {
    push(@dirs, $dir);
  }

  return @dirs;
}

sub is_executable {
  my ($self) = @_;
  return $self->{executable};
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub add_line {
  my ($self, $line) = @_;
  push(@{ $self->{lines} }, $line);
}

sub add_linebreak {
  my ($self) = @_;
  push(@{ $self->{lines} }, "");
}

sub make_executable {
  my ($self) = @_;
  $self->{executable} = 1;
}

sub add_dir {
  my ($self, $dir) = @_;
  push(@{ $self->{dirs} }, $dir);
}

sub set_subtype {
  my ($self, $type) = @_;
  $self->{subtype} = $type;
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub write {
  my ($self) = @_;
  my $filename = $self->get_name;
  my @lines    = $self->get_lines;

  my $fh_out = &Hydra::Util::File::open_file_for_write($filename);
  foreach my $line (@lines) {
    print $fh_out "$line\n";
  }
  &Hydra::Util::File::close_file($fh_out);

  if ($self->is_executable) {
    &Hydra::Util::File::chmod_script($filename);
  }
}

1;
