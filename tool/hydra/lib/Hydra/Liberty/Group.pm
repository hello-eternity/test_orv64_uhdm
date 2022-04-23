#------------------------------------------------------
# Module Name: Group
# Date:        Mon Aug 19 13:22:31 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::Group;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Liberty::LibraryGroup;
use Hydra::Liberty::WithPinGroup;
use Hydra::Liberty::CellGroup;
use Hydra::Liberty::BusGroup;
use Hydra::Liberty::BundleGroup;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $type, $name) = @_;
  my $self = {
    name => $name,
    type => $type,
    attr => {
      simple  => {},
      complex => {},
    },
    groups       => {},
    empty_groups => {},
    pin_list     => undef,
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

sub get_simple_attribute {
  my ($self, $attr_name) = @_;
  if (!defined $self->{attr}{simple}{$attr_name}) {
    die "ERROR: simple attr=${attr_name} not found in group=$self->{name} type=$self->{type}!\n";
  }
  return $self->{attr}{simple}{$attr_name};
}

sub get_complex_attribute {
  my ($self, $attr_name) = @_;
  if (!defined $self->{attr}{complex}{$attr_name}) {
    die "ERROR: complex attr=${attr_name} not found in group=$self->{name} type=$self->{type}!\n";
  }
  return @{ $self->{attr}{complex}{$attr_name} };
}

sub get_subgroup_list {
  my ($self, $type) = @_;
  my @groups = ();
  foreach my $name (sort keys %{ $self->{groups}{$type} }) {
    push(@groups, $self->{groups}{$type}{$name});
  }
  return @groups;
}

sub get_empty_subgroup_list {
  my ($self, $type) = @_;
  return () if (!defined $self->{empty_groups}{$type});
  return @{ $self->{empty_groups}{$type} };
}

sub get_subgroup {
  my ($self, $type, $name) = @_;
  return $self->{groups}{$type}{$name};
}

sub get_empty_subgroup {
  my ($self, $type) = @_;
  return () if (!defined $self->{empty_groups}{$type});
  return @{ $self->{empty_groups}{$type} };
}

#------------------------------------------------------
# Queries
#------------------------------------------------------
sub has_simple_attribute {
  my ($self, $attr_name) = @_;
  if (defined $self->{attr}{simple}{$attr_name}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub is_simple_attribute_true {
  my ($self, $attr_name) = @_;
  return 0 if (!$self->has_simple_attribute($attr_name));

  my $value = $self->get_simple_attribute($attr_name);
  if ($value =~ /true/i) {
    return 1;
  }
  else {
    return 0;
  }
}

sub is_simple_attribute_equal_to {
  my ($self, $attr_name, $test_val) = @_;
  return 0 if (!$self->has_simple_attribute($attr_name));

  my $attr_val = $self->get_simple_attribute($attr_name);
  if ($attr_val =~ /^\s*\Q${test_val}\E\s*$/i) {
    return 1;
  }
  else {
    return 0;
  }
}

sub has_complex_attribute {
  my ($self, $attr_name) = @_;
  if (defined $self->{attr}{complex}{$attr_name} &&
      scalar(@{ $self->{attr}{complex}{$attr_name} }) > 0) {
    return 1;
  }
  return 0;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub add_simple_attribute {
  my ($self, $attr_name, $attr_value) = @_;
  if (defined $self->{attr}{simple}{$attr_name}) {
    warn "ERROR: simple attr=${attr_name} already defined in group=$self->{name} type=$self->{type}! skipping...\n";
  }
  else {
    $self->{attr}{simple}{$attr_name} = $attr_value;
  }
}

sub add_complex_attribute {
  my ($self, $attr_name, $attr_value) = @_;
  push(@{ $self->{attr}{complex}{$attr_name} }, $attr_value);
}

sub add_group {
  my ($self, $SubGroup) = @_;
  my $name = $SubGroup->get_name;
  my $type = $SubGroup->get_type;

  # Record pg_pin as regular pin to simplify pin list
  $type = "pin" if ($type eq "pg_pin");

  if ($type eq "pin" || $type eq "bus") {
    push(@{ $self->{pin_list} }, $name);
  }
  elsif ($type eq "bundle") {
    # Extract pins from bundle and record order
    my @pins = $SubGroup->get_bundled_pin_list;
    foreach my $pin_name (@pins) {
      push(@{ $self->{pin_list} }, $pin_name);
    }
  }

  # Subgroups are hashed by name
  # There can be multiple subgroups of the same type and name but we dont care
  #   about those right now (e.g. normalized_driver_waveform, dc_current)
  $self->{groups}{$type}{$name} = $SubGroup;
}

sub add_empty_group {
  my ($self, $EmptyGroup) = @_;
  my $type = $EmptyGroup->get_type;

  # Empty subgroups are arrayed since they have no name
  push(@{ $self->{empty_groups}{$type} }, $EmptyGroup);
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub parse_group_statements {
  my ($self, $aref_lines) = @_;

  my $full_line = "";
  for (my $index = 0; $index <= $#$aref_lines; $index++) {
    my $line = $aref_lines->[$index];
    chomp($line);
    $full_line .= $line;
    if ($line =~ /\\\s*$/) {
      $full_line =~ s/\\\s*$/ /;
      next;
    }
    else {
      if ($full_line =~ /^\s*((\S+)\s*\(\s*(.*?)\s*\)\s*\{)\s*$/) {
        # Subgroup
        my $group_stmt = $1;
        my $group_type = $2;
        my $group_name = $3;
        $group_name =~ s/^\"\s*//;
        $group_name =~ s/\s*\"$//;

        # Gather contents of group
        my $brace_counter = 1;
        my @lines = ();
        push(@lines, $full_line);
        while ($brace_counter != 0) {
          $index++;
          $full_line = $aref_lines->[$index];
          
          if ($full_line =~ /\}/) {
            $brace_counter--;

            # For cases where a statement directly follows a closing brace
            # Move the statement onto a new line
            if ($full_line =~ /(\})(.+)$/) {
              $full_line    = $1;
              my $next_line = $2;
              splice(@$aref_lines, $index+1, 0, $next_line);
            }
          }
          if ($full_line =~ /\{/) {
            $brace_counter++;
          }
          
          push(@lines, $full_line);
        }

        # Remove group declaration and braces
        $lines[0] =~ s/^\s*\Q${group_stmt}\E//;
        $lines[$#lines] =~ s/\}\s*$//;
        
        if (defined $group_name && $group_name ne "") {
          # Named group
          my $SubGroup;
          if ($group_type eq "library") {
            $SubGroup = new Hydra::Liberty::LibraryGroup($group_name);
          }
          elsif ($group_type eq "cell") {
            $SubGroup = new Hydra::Liberty::CellGroup($group_name);
          }
          elsif ($group_type eq "bus") {
            $SubGroup = new Hydra::Liberty::BusGroup($group_name);
          }
          elsif ($group_type eq "bundle") {
            $SubGroup = new Hydra::Liberty::BundleGroup($group_name);
          }
          else {
            # Skip certain groups to speed up lib reading
            if ($group_type !~ /power|cell_rise|cell_fall|transition/) {
              $SubGroup = new Hydra::Liberty::Group($group_type, $group_name);
            }
          }

          if (defined $SubGroup) {
            $SubGroup->parse_group_statements(\@lines);
            $self->add_group($SubGroup);
          }
        }
        else {
          # Empty group
          my $SubGroup = new Hydra::Liberty::Group($group_type, "");
          $SubGroup->parse_group_statements(\@lines);
          $self->add_empty_group($SubGroup);
        }
      }
      elsif ($full_line =~ /^\s*(\S+)\s*\:\s*(.+?)\s*\;\s*$/) {
        # Simple attribute
        my $attr_name  = $1;
        my $attr_value = $2;
        $attr_value =~ s/^\"\s*//;
        $attr_value =~ s/\s*\"$//;
        $self->add_simple_attribute($attr_name, $attr_value);
        
      }
      elsif ($full_line =~ /^\s*(\S+)\s*\(\s*(.+?)\s*\)\s*\;\s*$/) {
        # Complex attribute
        my $attr_name  = $1;
        my $attr_value = $2;
        $attr_value =~ s/^\"\s*//;
        $attr_value =~ s/\s*\"$//;
        $self->add_complex_attribute($attr_name, $attr_value);
      }

      $full_line = "";
    }
  }

}

1;
