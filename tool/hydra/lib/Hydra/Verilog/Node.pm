#------------------------------------------------------
# Module Name: Node
# Date:        Fri Aug  2 16:11:40 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Node;

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
  my ($class, $Parent, $name) = @_;
  my $self = {
    name      => $name,
    Parent    => $Parent,
    data      => undef,
    net       => undef,
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

sub get_connection_list {
  my ($self, $direction) = @_;
  my @conns = ();
  
  foreach my $token (split(/\_/, $direction)) {
    if (defined $self->{$token}) {
      foreach my $conn_hier_name (sort keys %{ $self->{$token} }) {
        my $Conn = $self->{$token}{$conn_hier_name};
        # Resolve the connected bit and its instance the first time it is requested
        $Conn->get_header->get_parent->resolve;
        push(@conns, $Conn);
      }
    }
  }

  return @conns;
}

sub get_net {
  my ($self) = @_;
  return () if (!defined $self->{net});
  return sort keys %{ $self->{net} };
}

sub get_data {
  my ($self) = @_;
  return $self->{data};
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub add_connection {
  my ($self, $Bit, $dir) = @_;
  # Do not make connections to self
  return if (scalar($self) eq scalar($Bit));

  if (!defined $Bit) {
    print "WARN: Bit not found when trying connection for " . $self->get_hier_name . "...skipping connection\n";
    return;
  }

  if (!defined $self->{$dir}) {
    $self->{$dir} = {};
  }

  my $bit_hier_name   = $Bit->get_hier_name;
  my $skip_connection = 0;
  foreach my $testdir (qw(input output inout undirected)) {
    if (defined $self->{$testdir}{$bit_hier_name}) {
      # If the same connection was already made, then skip the connection
      #   unless a non-undirected connection will be overwriting an undirected one
      if ($testdir eq "undirected" && $dir ne "undirected") {
        delete $self->{$testdir}{$bit_hier_name};
        last;
      }
      else {
        $skip_connection = 1;
        last;
      }
    }
  }

  return if ($skip_connection);

  # Check number of input connections
  if ($dir eq "input" && defined $self->{input} && scalar(keys %{ $self->{input} }) >= 1) {
    my $name      = $self->get_name;
    my $inst_name = $self->get_header->get_parent->get_hier_name;
    my $cell_name = $self->get_header->get_parent->get_module->get_name;
    print "WARN: Pin=${name} for inst=${inst_name} cell=${cell_name} has more than one input!\n";

    foreach my $input_hier_name (keys %{ $self->{input} }) {
      my $InputBit        = $self->{input}{$input_hier_name};
      my $input_name      = $InputBit->get_name;
      my $input_inst_name = $InputBit->get_header->get_parent->get_hier_name;
      my $input_cell_name = $InputBit->get_header->get_parent->get_module->get_name;
      print "      Pin=${input_name} inst=${input_inst_name} cell=${input_cell_name}\n";
    }

    my $bit_name      = $Bit->get_name;
    my $bit_inst_name = $Bit->get_header->get_parent->get_hier_name;
    my $bit_cell_name = $Bit->get_header->get_parent->get_module->get_name;
    print "      Pin=${bit_name} inst=${bit_inst_name} cell=${bit_cell_name}\n";
    print "      skipping connection...\n";
    return;
  }

  $self->{$dir}{$bit_hier_name} = $Bit;
}

sub set_net {
  my ($self, $net) = @_;
  $self->{net}{$net} = 1;
}

sub set_data {
  my ($self, $href_data) = @_;
  $self->{data} = $href_data;
}

#------------------------------------------------------
# Queries
#------------------------------------------------------
sub is_literal {
  my ($self) = @_;
  return 0;
}


1;
