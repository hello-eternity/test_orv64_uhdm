#------------------------------------------------------
# Module Name: Verilog
# Date:        Fri Aug  2 16:11:10 2019
# Author:      kvu
#-----------------------------------------------------
package Hydra::Verilog;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Verilog::Design;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_Design;
my $glb_resolve_conn = 1;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub read_netlist {
  my $aref_vlg        = &Hydra::Util::Option::get_opt_value_array("-vlg_files", "strict");
  my $top_module      = &Hydra::Util::Option::get_opt_value_scalar("-top_module", "strict");
  my $aref_bb_modules = &Hydra::Util::Option::get_opt_value_array("-bb_modules", "relaxed");
  my $aref_bb_insts   = &Hydra::Util::Option::get_opt_value_array("-bb_insts", "relaxed");

  my $Design = new Hydra::Verilog::Design($top_module);
  &set_design($Design);

  $Design->parse_verilog_files($aref_vlg);
}

sub get_design {
  return $glb_Design;
}

sub set_design {
  my ($Design) = @_;
  $glb_Design = $Design;
}

sub is_resolve_conn_on {
  return $glb_resolve_conn;
}

sub disable_resolve_conn {
  $glb_resolve_conn = 0;
}

sub enable_resolve_conn {
  $glb_resolve_conn = 1;
}

sub get_object_from_hier_name {
  my ($Design, $hier_name) = @_;
  my @levels = split(/\//, $hier_name);

  my $Cursor = $Design->get_top_inst;
  my $name   = shift @levels;

  if ($name ne $Cursor->get_name) {
    warn "ERROR: ${hier_name} not contained in top module " . $Cursor->get_name . "!\n";
    return undef;
  }

  while ($name = shift @levels) {
    if (scalar(@levels) == 0) {
      $Cursor = $Cursor->get_pin($name);
      return undef if (!defined $Cursor);
    }
    else {
      $Cursor = $Cursor->get_instance($name);
      return undef if (!defined $Cursor);
    }
  }

  return $Cursor;
}

#------------------------------------------------------
# Universal Helper Utilities
#------------------------------------------------------

# Returns sigbit values that are guaranteed low then high, since msb can possibly be smaller than lsb
sub normalize_bit_range {
  my ($msb, $lsb) = @_;
  my $upper;
  my $lower;

  if (!defined $msb || !defined $lsb) {
    confess;
  }

  if ($msb >= $lsb) {
    $upper = $msb;
    $lower = $lsb;
  }
  else {
    $upper = $lsb;
    $lower = $msb;
  }

  return ($upper, $lower);
}

# Separates name and bit
sub parse_bit {
  my ($name) = @_;
  my $ret_name = $name;
  my $ret_bit  = "-1";

  if ($name =~ /^\\/) {
    # Name is escaped, so there is no bit select
  }
  elsif ($name =~ /^([^\[\]\s]+)\[(\d+)\]$/) {
    $ret_name = $1;
    $ret_bit  = $2;
  }

  return ($ret_name, $ret_bit);
}

# Combines name and bit
sub form_bit {
  my ($name, $bit) = @_;
  if ($bit eq "-1") {
    return $name;
  }
  else {
    return "${name}[${bit}]";
  }
}

# Checks whether this instance is a flop or not
sub is_flop {
  my ($Inst) = @_;
  my $CellLib = $Inst->get_module->get_lib;
  return 0 if (!defined $CellLib);

  if (defined $CellLib) {
    my @ff_list = $CellLib->get_ff_list;
    if (scalar(@ff_list) > 0) {
      return 1;
    }
  }

  return 0;
}

# Checks whether this instance is an icg or not
sub is_icg {
  my ($Node) = @_;
  my $CellLib = $Node->get_module->get_lib;
  return 0 if (!defined $CellLib);

  foreach my $PinLib ($CellLib->get_pin_list) {
    if ($PinLib->is_simple_attribute_true("clock_gate_clock_pin")) {
      return 1;
    }
  }

  return 0;
}

#------------------------------------------------------
# Debugging
#------------------------------------------------------
sub test_trace {
  my $start_time = time;
  &Hydra::Liberty::read_lib;
  &Hydra::Verilog::read_netlist;

  my $run_time = (time - $start_time) / 60;
  print "read_netlist/read_lib finished in $run_time minutes\n";

  ## DEBUG
  # use Memory::Usage;
  # my $Mem = Memory::Usage->new();
  # $Mem->record('mem usage after read_netlist/read_lib');
  # $Mem->dump();

  my $Design = &get_design;
  print "INFO: Performing test trace...\n";
  #my $Pin = &get_object_from_hier_name($Design, "vcore_fp_top/external_int");
  my $Pin = &get_object_from_hier_name($Design, "vcore_fp_top/PLC_OPT_HFSINV_22_55034/ZN");
  #my $Pin = &get_object_from_hier_name($Design, "vcore_fp_top/u_uP_core/s2b_ext_int");
  &trace($Pin, 0);

  # my $Literal = $Design->get_literal("1\'b0");
  # print "LITERAL 1\'b0:\n";
  # foreach my $Conn ($Literal->get_connection_list("output")) {
  #   print "  output pin=" . $Conn->get_name . " inst=" . $Conn->get_header->get_parent->get_hier_name . " cell=" . $Conn->get_header->get_parent->get_module->get_name . "\n";
  # }
}

sub trace {
  my ($Pin, $level) = @_;
  my $indent = "  " x $level;
  print "${indent}pin=" . $Pin->get_name . " inst=" . $Pin->get_header->get_parent->get_name . " cell=" . $Pin->get_header->get_parent->get_module->get_name . "\n";
  
  foreach my $dir (qw(input inout undirected)) {
    foreach my $Conn ($Pin->get_connection_list($dir)) {
      print "${indent}  $dir pin=" . $Conn->get_name . " inst=" . $Conn->get_header->get_parent->get_name . " cell=" . $Conn->get_header->get_parent->get_module->get_name . "\n";
    }
  }

  foreach my $Conn ($Pin->get_connection_list("output")) {
    &trace($Conn, $level+1);
  }
}

1;
