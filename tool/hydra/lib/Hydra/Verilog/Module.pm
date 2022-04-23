#------------------------------------------------------
# Module Name: Module
# Date:        Fri Aug  2 16:11:32 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Module;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Verilog::Instance;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $Design, $name, $aref_port_declarations, $aref_port_stmts, $aref_net_stmts, $aref_module_stmts) = @_;
  my $self = {
    name         => $name,
    type         => "unknown",
    Design       => $Design,
    port_decls   => $aref_port_declarations,
    port_stmts   => $aref_port_stmts,
    net_stmts    => $aref_net_stmts,
    module_stmts => $aref_module_stmts,
    lib          => undef,
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

sub get_design {
  my ($self) = @_;
  return $self->{Design};
}

sub get_port_declarations {
  my ($self) = @_;
  return $self->{port_decls};
}

sub get_port_statements {
  my ($self) = @_;
  return $self->{port_stmts};
}

sub get_net_statements {
  my ($self) = @_;
  return $self->{net_stmts};
}

sub get_module_statements {
  my ($self) = @_;
  return $self->{module_stmts};
}

sub get_literal {
  my ($self, $name) = @_;
  return $self->get_design->get_literal($name);
}

sub get_lib {
  my ($self) = @_;
  return $self->{lib};
}

sub has_lib {
  my ($self) = @_;
  if (defined $self->{lib}) {
    return 1;
  }
  else {
    return 0;
  }
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_type {
  my ($self, $type) = @_;
  $self->{type} = $type;
}

sub set_lib {
  my ($self, $Lib) = @_;
  $self->{lib} = $Lib;
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub instantiate {
  my ($self, $Parent, $name, $is_top) = @_;
  my $Inst = new Hydra::Verilog::Instance($self, $Parent, $name);
  if ($is_top) {
    $Inst->set_as_top;
  }

  #if ($self->get_type eq "cell") {
  if ($self->has_lib) {
    # Instantiate using info from liberty if this is a lib cell
    $Inst->process_lib($self->{lib});
  }
  else {
    # Instantiate using info from verilog if this is a module or unknown
    $Inst->parse_port_declarations($self->{port_decls});
    $Inst->parse_port_statements($self->{port_stmts});
    $Inst->parse_net_statements($self->{net_stmts});
  }

  if ($is_top) {
      $Inst->resolve;
  }
  return $Inst;
}


1;
