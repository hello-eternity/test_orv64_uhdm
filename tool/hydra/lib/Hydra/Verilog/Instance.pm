#------------------------------------------------------
# Module Name: Instance
# Date:        Fri Aug  2 16:11:35 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Instance;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Verilog::Pin;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $Module, $Parent, $name) = @_;
  # nets =>
  #   $net_base =>
  #     bits =>
  #       $bit =>
  #         input|output|inout|undirected => [$Pin...]
  #     msb|lsb => <int>
  #
  my $self = {
    name          => $name,
    pins          => {},      # Pin objects by name
    pin_order     => [],      # Pin names in order of declaration
    instances     => {},      # Subinstance objects by name
    nets          => {},      # Net connections by name
    port_nets     => {},      # Renamed port nets by name
    conn_stmt     => undef,   # The pin connection statement for sub-instances
    top           => 0,       # A flag for whether this is the top module instance
    Module        => $Module, # The module object that this instantiates
    Parent        => $Parent, # The parent instance object
    resolved      => 0,       # A flag for whether this instance has been resolved yet
    resolved_inst => 0,       # A flag for whether this instance has resolved its sub-instances yet
    data          => undef,   # Misc data that the user can set
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

sub get_hier_name {
  my ($self) = @_;  
  if (!$self->is_top) {
    return $self->get_parent->get_hier_name . "/$self->{name}";
  }
  else {
    return $self->{name};
  }
}

sub is_top {
  my ($self) = @_;
  return $self->{top};
}

sub get_pin_header {
  my ($self, $name) = @_;
  my ($base, $bit) = &Hydra::Verilog::parse_bit($name);
  if (defined $self->{pins}{$base}) {
    return $self->{pins}{$base};
  }
  else {
    print "WARN: Pin=${base} not found in inst=$self->{name}!\n";
    return undef;
  }
}

sub has_pin_header {
  my ($self, $name) = @_;
  my ($base, $bit) = &Hydra::Verilog::parse_bit($name);
  if (defined $self->{pins}{$base}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_pin {
  my ($self, $name) = @_;
  my ($base, $bit) = &Hydra::Verilog::parse_bit($name);
  if (defined $self->{pins}{$base}) {
    return $self->{pins}{$base}->get_bit($bit);
  }
  else {
    print "WARN: Pin=${name} not found in inst=$self->{name}!\n";
    return undef;
  }
}

sub get_pin_list {
  my ($self) = @_;
  my @Pins = ();
  foreach my $pin_name (@{ $self->{pin_order} }) {
    push(@Pins, $self->{pins}{$pin_name});
  }
  return @Pins;
}

sub get_pin_order {
  my ($self) = @_;
  return @{ $self->{pin_order} };
}

sub get_pin_from_port_net {
  my ($self, $port_net_name) = @_;
  return $self->get_pin($self->{port_nets}{$port_net_name}) if (defined $self->{port_nets}{$port_net_name});
  return $self->get_pin($port_net_name);
}

sub get_instance {
  my ($self, $name) = @_;
  if (defined $self->{instances}{$name}) {
    # Resolve the target instance the first time it is requested
    my $SubInst = $self->{instances}{$name};
    $SubInst->resolve;
    return $SubInst;
  }
  else {
    print "WARN: Sub-inst=${name} not found in inst=$self->{name}!\n";
    return undef;
  }
}

sub has_instance {
  my ($self, $name) = @_;
  if (defined $self->{instances}{$name}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_instance_list {
  my ($self) = @_;

  # Resolve all sub-instances
  foreach my $SubInst (values %{ $self->{instances} }) {
    $SubInst->resolve;
  }

  return sort values %{ $self->{instances} };
}

sub get_instance_list_no_resolve {
  my ($self) = @_;
  return sort values %{ $self->{instances} };
}

sub get_module {
  my ($self) = @_;
  return $self->{Module};
}

sub get_parent {
  my ($self) = @_;
  return $self->{Parent};
}

sub get_conn_stmt {
  my ($self) = @_;
  return $self->{conn_stmt};
}

sub is_resolved {
  my ($self) = @_;
  return $self->{resolved};
}

sub is_resolved_inst {
  my ($self) = @_;
  return $self->{resolved_inst};
}

sub has_net {
  my ($self, $name) = @_;
  if (defined $self->{nets}{$name}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_net {
  my ($self, $name) = @_;
  return () if (!defined $self->{nets}{$name});
  return @{ $self->{nets}{$name} };
}

sub is_net_bus {
  my ($self, $name) = @_;
  if (defined $self->{nets}{$name}{msb} && defined $self->{nets}{$name}{lsb}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_net_msb {
  my ($self, $name) = @_;
  return $self->{nets}{$name}{msb};
}

sub get_net_lsb {
  my ($self, $name) = @_;
  return $self->{nets}{$name}{lsb};
}

sub has_net_bit {
  my ($self, $name, $bit) = @_;
  if (defined $self->{nets}{$name}{bits}{$bit}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_literal {
  my ($self, $name) = @_;
  return $self->get_module->get_literal($name);
}

sub get_data {
  my ($self) = @_;
  return $self->{data};
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub add_pin {
  my ($self, $Pin) = @_;
  my $name = $Pin->get_name;
  if (defined $self->{pins}{$name}) {
    print "WARN: Pin=${name} already defined for inst=$self->{name}! skipping..\n";
  }
  else {
    $self->{pins}{$name} = $Pin;
    push(@{ $self->{pin_order} }, $name);
  }
}

sub add_instance {
  my ($self, $Inst) = @_;
  my $name = $Inst->get_name;
  if (defined $self->{instances}{$name}) {
    print "WARN: subinst=${name} already defined for inst=$self->{name}! skipping...\n";
  }
  else {
    $self->{instances}{$name} = $Inst;
  }
}

sub set_net_bus {
  my ($self, $name, $msb, $lsb) = @_;
  my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);

  # Delete scalar net represented by -1 index
  delete $self->{nets}{$name}{bits}{"-1"};

  $self->{nets}{$name}{msb} = $msb;
  $self->{nets}{$name}{lsb} = $lsb;
  foreach my $index ($lower..$upper) {
    # Add each bit for this net
    $self->{nets}{$name}{bits}{$index}{input}      = [];
    $self->{nets}{$name}{bits}{$index}{output}     = [];
    $self->{nets}{$name}{bits}{$index}{inout}      = [];
    $self->{nets}{$name}{bits}{$index}{undirected} = [];
  }
}

sub add_net {
  my ($self, $name) = @_;
  # Scalar net represented by -1 index
  $self->{nets}{$name}{bits}{"-1"}{input}      = [];
  $self->{nets}{$name}{bits}{"-1"}{output}     = [];
  $self->{nets}{$name}{bits}{"-1"}{inout}      = [];
  $self->{nets}{$name}{bits}{"-1"}{undirected} = [];
}

sub set_conn_stmt {
  my ($self, $stmt) = @_;
  $self->{conn_stmt} = $stmt;
}

sub set_as_top {
  my ($self) = @_;
  $self->{top} = 1;
}

sub set_resolved {
  my ($self) = @_;
  $self->{resolved} = 1;
}

sub set_resolved_inst {
  my ($self) = @_;
  $self->{resolved_inst} = 1;
}

sub set_data {
  my ($self, $href_data) = @_;
  $self->{data} = $href_data;
}

sub check_missing_pin {
  my ($self, $pin_name, $msb, $lsb) = @_;
  
  if (!$self->has_pin_header($pin_name)) {
    return 0;
  }

  if (defined $msb && defined $lsb) {
    my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);
    my $Pin = $self->get_pin_header($pin_name);
    if (!$Pin->has_bus) {
      return 0;
    }

    # Check that every bit is within the pin bus range
    my ($pin_upper, $pin_lower) = &Hydra::Verilog::normalize_bit_range($Pin->get_msb, $Pin->get_lsb);
    foreach my $index ($lower..$upper) {
      if ($index > $pin_upper || $index < $pin_lower) {
        return 0;
      }
    }
  }

  return 1;
}

sub create_missing_pin {
  my ($self, $pin_name, $msb, $lsb) = @_;

  # Check for existence of pin and create it if it doesnt exist
  my $creating_pin = 0;
  if (!$self->has_pin_header($pin_name)) {
    if ($self->get_module->get_type ne "unknown") {
      print "WARN: Creating missing pin=$pin_name on previously defined module inst=$self->{name} cell=" . $self->get_module->get_name . "\n";
    }
    # else {
    #   print "WARN: Creating missing pin=$pin_name on unknown module inst=$self->{name} cell=" . $self->get_module->get_name . "\n";
    # }

    # Create pin header
    my $Pin = new Hydra::Verilog::Pin($self, $pin_name);
    $self->add_pin($Pin);
    $creating_pin = 1;
  }

  # Check that number of bits matches      
  my $Pin = $self->get_pin_header($pin_name);
  
  my $num_conn_bits = 1;
  if (defined $msb && defined $lsb) {
    if ($creating_pin) {
      $Pin->set_msb($msb);
      $Pin->set_lsb($lsb);
      if ($self->get_module->get_type ne "unknown") {
        print "WARN:   New pin=$pin_name is a bus with msb=$msb lsb=$lsb\n";
      }
    }

    $num_conn_bits = abs($msb-$lsb)+1;
  }
 
  my $num_pin_bits = 1;
  if ($Pin->has_bus) {
    $num_pin_bits = abs($Pin->get_msb-$Pin->get_lsb)+1;
  }
  
  if ($num_conn_bits != $num_pin_bits) {
    print "WARN: attempting to connect pin=${pin_name} to mismatched number of bits! skipping...\n";
    print "      inst=$self->{name} cell=" . $self->get_module->get_name . "\n";
    print "      expected=${num_conn_bits} actual=${num_pin_bits}\n";
    return 0;
  }

  return 1;
}

sub check_missing_net {
  my ($self, $net_name, $msb, $lsb) = @_;

  if (!$self->has_net($net_name)) {
    return 0;
  }

  if (defined $msb && defined $lsb) {
    my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);
    foreach my $index ($lower..$upper) {
      if (!$self->has_net_bit($net_name, $index)) {
        return 0;
      }
    }
  }

  return 1;
}

sub create_missing_net {
  my ($self, $net_name, $msb, $lsb) = @_;

  my $creating_net = 0;
  my $creating_bus = 0;
  if (!$self->has_net($net_name)) {
    $self->add_net($net_name);
    $creating_net = 1;
  }

  if (defined $msb && defined $lsb) {
    $self->set_net_bus($net_name, $msb, $lsb);
    $creating_bus = 1;
  }

  if ($creating_net && !$creating_bus) {
    print "WARN: creating implicit net for module=" . $self->get_module->get_name . " net=${net_name}\n";
  }
  elsif ($creating_net && $creating_bus) {
    print "WARN: creating implicit net for module=" . $self->get_module->get_name . " net=${net_name} with msb=${msb} lsb=${lsb}\n";
  }

  return 1;
}

#------------------------------------------------------
# Pin Connection Subroutines
#------------------------------------------------------
sub connect_named_pin_to_group {
  my ($self, $pin_name, $aref_group) = @_;
  return if ($pin_name eq "");
  my $aref_nets;
  my $aref_pins;

  my $num_pin_bits = $self->get_pin_bits_from_name("num", $pin_name);
  my $num_net_bits = 0;
  my %net_nums     = ();
  my $has_undefined_net = 0;
  # Get total number of net bits across all nets
  foreach my $net_name (@$aref_group) {
    # Skip empty net connection
    next if ($net_name eq "");
    my $this_num_net_bits = $self->get_parent->get_net_bits_from_name("num", $net_name);
    $net_nums{$net_name} = $this_num_net_bits;
    if (defined $this_num_net_bits) {
      $num_net_bits += $this_num_net_bits;
    }
    else {
      $has_undefined_net = 1;
    }
  }

  if (!defined $num_pin_bits && $has_undefined_net) {
    # Both pin and nets have undefined widths; skip this connection since width cannot be inferred
    warn "WARN: found connection where both pin and at least one net in group are undefined!\n";
    warn "      pin=${pin_name}\n";
    my @undefined_nets = ();
    foreach my $net_name (@$aref_group) {
      if (!defined $net_nums{$net_name}) {
        push(@undefined_nets, $net_name);
      }
    }
    warn "      nets={" . join(" ", @undefined_nets) . "}\n";
    warn "      skipping connection...\n";
    return;
  }

  # Get number of undefined net bits if any nets were not defined
  my $num_undefined_net_bits = $num_pin_bits;
  my %undefined_nets = ();
  foreach my $net_name (@$aref_group) {
    if (defined $net_nums{$net_name}) {
      $num_undefined_net_bits -= $net_nums{$net_name};
    }
    else {
      $undefined_nets{$net_name} = 1;
    }
  }

  # Infer width of undefined nets
  my $num_undefined_nets = scalar(keys %undefined_nets);
  if ($num_undefined_nets != 0) {
    if ($num_undefined_nets == 1) {
      # Single undefined net's width is the number of undefined bits
      $undefined_nets{(keys %undefined_nets)[0]} = $num_undefined_net_bits;

      # Update total number of net bits as undefined nets are inferred
      $num_net_bits += $num_undefined_net_bits;
    }
    elsif ($num_undefined_nets == $num_undefined_net_bits) {
      # Width of every undefined net is 1 if the number of undefined nets matches the total number of undefined net bits
      foreach my $net_name (keys %undefined_nets) {
        $undefined_nets{$net_name} = 1;

        # Update total number of net bits as undefined nets are inferred
        $num_net_bits++;
      }
    }
    elsif ($num_undefined_nets > 1) {
      # Width of undefined nets is ambiguous
      warn "WARN: Cannot infer width of undefined nets while connecting to pin=${pin_name}\n";
      my @undefined_nets = ();
      foreach my $net_name (@$aref_group) {
        if (!defined $net_nums{$net_name}) {
          push(@undefined_nets, $net_name);
        }
      }
      warn "      nets={" . join(" ", @undefined_nets) . "}\n";
      warn "      skipping connection...\n";
      return;
    }
  }

  # Get actual net bits
  foreach my $net_name (@$aref_group) {
    my $aref_bits;
    if (defined $undefined_nets{$net_name}) {
      # Create missing nets
      $aref_bits = $self->get_parent->get_net_bits_from_name("bits", $net_name, $undefined_nets{$net_name});
    }
    else {
      # Dont create existing nets
      $aref_bits = $self->get_parent->get_net_bits_from_name("bits", $net_name);
    }

    return if (!defined $aref_bits);
    push(@$aref_nets, @$aref_bits);
  }
  
  # Get actual pin bits
  $aref_pins = $self->get_pin_bits_from_name("bits", $pin_name, $num_net_bits);

  # Dont connect if pins or nets are not valid
  return if (!defined $aref_nets || !defined $aref_pins);

  # Check number of bits
  if (scalar(@$aref_pins) ne scalar(@$aref_nets)) {
    warn "WARN: bit width mismatch detected when connecting bits on \n";
    warn "      instance=" . $self->get_hier_name . "\n";
    warn "      pin=${pin_name} bits=" . scalar(@$aref_pins) . "\n";
    warn "      group={" . join(" ", @$aref_group) . "} bits=" . scalar(@$aref_nets) . "\n";
    warn "      skipping connection\n";
    return;
  }

  # Check direction
  foreach my $index (0..$#$aref_pins) {
    my $pin_direction = $aref_pins->[$index]->get_direction;
    my $net_direction = "undirected";
    if (ref($aref_nets->[$index]) ne "HASH") {
      # If the net bit is not a hash ref, then it is a literal object which is always output
      $net_direction = "output";
    }
    if ($pin_direction eq $net_direction && 
        $pin_direction ne "inout" && $pin_direction ne "undirected") {
      warn "WARN: directions are both ${pin_direction} when connecting bit=${index} on\n";
      warn "      instance=" . $self->get_hier_name . "\n";
      warn "      pin=${pin_name} group={" . join(" ", @$aref_group) . "\n";
      warn "      skipping connection...\n";
      return;
    }
  }

  $self->connect_ordered_bits($aref_pins, $aref_nets);
}

sub connect_named_pin {
  my ($self, $pin_name, $net_name) = @_;
  # Skip if pin is connected to an empty net
  next if ($pin_name eq "" || $net_name eq "");
  my $aref_pins;
  my $aref_nets;

  my $num_pin_bits = $self->get_pin_bits_from_name("num", $pin_name);
  my $num_net_bits = $self->get_parent->get_net_bits_from_name("num", $net_name);

  if (defined $num_net_bits && defined $num_pin_bits) {
    # Both pins and nets are defined; connect normally
    $aref_pins = $self->get_pin_bits_from_name("bits", $pin_name);
    $aref_nets = $self->get_parent->get_net_bits_from_name("bits", $net_name);
  }
  elsif (defined $num_net_bits && !defined $num_pin_bits) {
    # Only nets are defined; create missing pins
    $aref_pins = $self->get_pin_bits_from_name("bits", $pin_name, $num_net_bits);
    $aref_nets = $self->get_parent->get_net_bits_from_name("bits", $net_name);
  }
  elsif (!defined $num_net_bits && defined $num_pin_bits) {
    # Only pins are defined; create missing nets
    $aref_pins = $self->get_pin_bits_from_name("bits", $pin_name);
    $aref_nets = $self->get_parent->get_net_bits_from_name("bits", $net_name, $num_pin_bits);
  }
  else {
    # Neither are defined; skip the connection
    print "WARN: for module=" . $self->get_module->get_name . " inst=$self->{name}, pin=${pin_name} and net=${net_name} are both undefined! skipping connection...\n";
    return;
  }

  # Do not attempt connection if set of pins and nets are not both valid
  return if (!defined $aref_pins || !defined $aref_nets);

  # Check number of bits
  if (scalar(@$aref_pins) ne scalar(@$aref_nets)) {
    warn "WARN: bit width mismatch detected when connecting bits on\n";
    warn "      instance=$self->{name}\n";
    warn "      pin=${pin_name} bits=" . scalar(@$aref_pins) . "\n";
    warn "      net=${net_name} bits=" . scalar(@$aref_nets) . "\n";
    warn "      skipping connection...\n";
    return;
  }

  # Check direction
  foreach my $index (0..$#$aref_pins) {
    my $pin_direction = $aref_pins->[$index]->get_direction;
    my $net_direction = "undirected";
    if (ref($aref_nets->[$index]) ne "HASH") {
      # If the net bit is not a hash ref, then it is a literal object which is always output
      $net_direction = "output";
    }
    if ($pin_direction eq $net_direction && 
        $pin_direction ne "inout" && $pin_direction ne "undirected") {
      warn "WARN: directions are both ${pin_direction} when connecting bit=${index} on\n";
      warn "      instance=$self->{name}\n";
      warn "      pin=${pin_name} net=${net_name}\n";
      warn "      skipping connection...\n";
      return;
    }
  }

  $self->connect_ordered_bits($aref_pins, $aref_nets);
}

sub connect_positional_nets {
  my ($self, $aref_nets) = @_;
  my @Pins = $self->get_pin_list;

  for (my $index = 0; $index <= $#Pins; $index++) {
    my $net_name = $aref_nets->[$index];
    my $pin_name = $Pins[$index]->get_name;

    if ($net_name =~ /\,/) {
      # Curly brace grouped nets
      my @nets = split(/\s*\,\s*/, $net_name);
      $self->connect_named_pin_to_group($pin_name, \@nets);
    }
    else {
      # Single net
      $self->connect_named_pin($pin_name, $net_name);
    }
  }
}

# sub connect_positional_nets {
#   my ($self, $mode, $aref_nets) = @_;
#   $mode = "conn" if (!defined $mode);
#   my @pin_order = $self->get_pin_order;
  
#   for (my $index = 0; $index <= $#pin_order; $index++) {
#     my $net_name = $aref_nets->[$index];
#     my $pin_name = $pin_order[$index];
    
#     if ($net_name =~ /\,/) {
#       # Curly brace grouped nets
#       my @nets = split(/\s*\,\s*/, $net_name);
#       if ($mode eq "conn") {
#         $self->connect_named_pin_to_group($pin_name, \@nets);
#       }
#       elsif ($mode eq "net") {
#         foreach my $net_name (@nets) {
#           $self->get_parent->add_net_inst_connection($net_name, $self->get_name, $pin_name);
#         }
#       }
#     }
#     else {
#       # Single net
#       if ($mode eq "conn") {
#         $self->connect_named_pin($pin_name, $net_name);
#       }
#       elsif ($mode eq "net") {
#         $self->get_parent->add_net_inst_connection($net_name, $self->get_name, $pin_name);
#       }
#     }
#   }
# }

sub process_assign {
  my ($self, $left_name, $right_name) = @_;
  my $aref_left;
  my $aref_right;

  my $num_left_bits  = $self->get_net_bits_from_name("num", $left_name);
  my $num_right_bits = $self->get_net_bits_from_name("num", $right_name);

  if (defined $num_left_bits && defined $num_right_bits) {
    # Both pins and nets are defined; connect normally
    $aref_left  = $self->get_net_bits_from_name("bits", $left_name);
    $aref_right = $self->get_net_bits_from_name("bits", $right_name);
  }
  elsif (defined $num_left_bits && !defined $num_right_bits) {
    # Only nets are defined; create missing pins
    $aref_left  = $self->get_net_bits_from_name("bits", $left_name, $num_right_bits);
    $aref_right = $self->get_net_bits_from_name("bits", $right_name);
  }
  elsif (!defined $num_left_bits && defined $num_right_bits) {
    # Only pins are defined; create missing nets
    $aref_left  = $self->get_net_bits_from_name("bits", $left_name);
    $aref_right = $self->get_net_bits_from_name("bits", $right_name, $num_left_bits);
  }
  else {
    # Neither are defined; skip the connection
    warn "WARN: left=${left_name} and right=${right_name} are both undefined in assign stmt! skipping connection...\n";
    return;
  }

  # Do not attempt connect if both left and right are not valid
  return if (!defined $aref_left || !defined $aref_right);

  # Check number of bits
  if (scalar(@$aref_left) ne scalar(@$aref_right)) {
    warn "WARN: bit width mismatch detected when connecting bits on\n";
    warn "      instance=$self->{name}\n";
    warn "      left=${left_name} bits=" . scalar(@$aref_left) . "\n";
    warn "      right=${right_name} bits=" . scalar(@$aref_right) . "\n";
    warn "      skipping assign...\n";
    next;
  }

  for (my $index = 0; $index <= $#$aref_left; $index++) {
    my $href_left  = $aref_left->[$index];
    my $href_right = $aref_right->[$index];

    # Only make connection if this is a net hash and not a literal object
    if (ref($href_left) eq "HASH") {
      push(@{ $href_left->{input} }, $href_right);
    }
    if (ref($href_right) eq "HASH") {
      push(@{ $href_right->{output} }, $href_left);
    }
  }
}

sub get_net_bits_from_name {
  my ($self, $mode, $net_name, $num_conn_bits) = @_;
  # bits - return list of bit objects
  # num  - return count of all bits
  $mode = "bits" if (!defined $mode);
  
  my @bits = ();

  if ($net_name =~ /(\d+)\'b(\d+)/) {
    # Binary literal
    my $size   = $1;
    my $value  = $2;
    my @digits = split(//, $value);

    # Modify value based on size, if necessary
    while (scalar(@digits) > $size) {
      shift(@digits);
    }
    while (scalar(@digits) < $size) {
      unshift(@digits, 0);
    }
    foreach my $digit (@digits) {
      my $literal_name = "1\'b${digit}";
      push(@bits, $self->get_literal($literal_name));
    }
  }
  elsif ($net_name =~ /(\d+)\'h(\d+)/) {
    # Hex literal
    my $hex_size   = $1;
    my $hex_value  = $2;
    my $dec_value  = hex($hex_value);
    my $value      = sprintf "%b", $dec_value;
    my $size       = $hex_size*4;

    my @digits = split(//, $value);

    # Modify value based on size, if necessary
    while (scalar(@digits) > $size) {
      shift(@digits);
    }
    while (scalar(@digits) < $size) {
      unshift(@digits, 0);
    }
    foreach my $digit (@digits) {
      my $literal_name = "1\'b${digit}";
      push(@bits, $self->get_literal($literal_name));
    }
  }
  elsif ($net_name !~ /^\\/ && $net_name =~ /(\S+?)\[([\d\-]+)\]/) {
    # Explicit single bit
    my $net_base = $1;
    my $net_bit  = $2;

    # Process missing nets
    return undef if ($mode eq "num"  && !$self->check_missing_net($net_base, $net_bit, $net_bit));
    return undef if ($mode eq "bits" && defined $num_conn_bits && !$self->create_missing_net($net_base, $net_bit, $net_bit));

    # Get hash ref of net bit
    push(@bits, $self->{nets}{$net_base}{bits}{$net_bit});
  }
  elsif ($net_name !~ /^\\/ && $net_name =~ /(\S+?)\[([\d\-]+)\:([\d\-]+)\]/) {
    # Explicit range of bits
    my $net_base = $1;
    my $msb      = $2;
    my $lsb      = $3;

    # Process missing nets
    return undef if ($mode eq "num"  && !$self->check_missing_net($net_base, $msb, $lsb));
    return undef if ($mode eq "bits" && defined $num_conn_bits && !$self->create_missing_net($net_base, $msb, $lsb));

    my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);
    foreach my $index ($lower..$upper) {
      push(@bits, $self->{nets}{$net_base}{bits}{$index});
    }

    # Preserve endianness
    if ($lower == $lsb) {
      @bits = reverse @bits;
    }
  }
  else {
    # Either a regular name with no bit select, or an escaped name
    # In both cases, width is ambiguous and the number of connected bits
    #   must be used to infer a missing pin's width

    # Process missing nets
    return undef if ($mode eq "num" && !$self->check_missing_net($net_name));
    if ($mode eq "bits") {
      if (defined $num_conn_bits) {
        if ($num_conn_bits > 1) {
          # Create net bus to match connected bus, assume lsb is 0
          return undef if (!$self->create_missing_net($net_name, $num_conn_bits-1, 0));
        }
        else {
          # Create single net to match single connected bit
          return undef if (!$self->create_missing_net($net_name));
        }
      }
    }

    if ($self->is_net_bus($net_name)) {
      # Implicit bus
      my $msb = $self->get_net_msb($net_name);
      my $lsb = $self->get_net_lsb($net_name);
      my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);

      # Number of bits of this net, for getting bits of the next connected pin
      my $num_bits = undef;
      if ($mode eq "bits") {
        $num_bits = abs($msb-$lsb)+1;
      }

      foreach my $index ($lower..$upper) {
        push(@bits, $self->{nets}{$net_name}{bits}{$index});
      }

      # Preserve endianness
      if ($lower == $lsb) {
        @bits = reverse @bits;
      }
    }
    else {
      # Implicit scalar
      push(@bits, $self->{nets}{$net_name}{bits}{"-1"});
    }
  }

  if ($mode eq "num") {
    return scalar(@bits);
  }
  elsif ($mode eq "bits") {
    return \@bits;
  }
}

sub get_pin_bits_from_name {
  my ($self, $mode, $pin_name, $num_conn_bits) = @_;
  # bits - return list of bit objects
  # num  - return count of all bits
  $mode = "bits" if (!defined $mode);

  my @bits = ();

  if ($pin_name !~ /^\\/ && $pin_name =~ /(\S+?)\[([\d\-]+)\]/) {
    # Explicit single bit
    my $pin_base = $1;
    my $pin_bit  = $2;

    # Process missing pins
    return undef if ($mode eq "num"  && !$self->check_missing_pin($pin_base, $pin_bit, $pin_bit));
    return undef if ($mode eq "bits" && defined $num_conn_bits && !$self->create_missing_pin($pin_base, $pin_bit, $pin_bit));
    push(@bits, $self->get_pin($pin_name));
  }
  elsif ($pin_name !~ /^\\/ && $pin_name =~ /(\S+?)\[([\d\-]+)\:([\d\-]+)\]/) {
    # Explicit range of bits
    my $pin_base = $1;
    my $msb      = $2;
    my $lsb      = $3;

    # Process missing pins
    return undef if ($mode eq "num"  && !$self->check_missing_pin($pin_base, $msb, $lsb));
    return undef if ($mode eq "bits" && defined $num_conn_bits && !$self->create_missing_pin($pin_base, $msb, $lsb));
    
    my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);
    foreach my $index ($lower..$upper) {
      push(@bits, $self->get_pin("${pin_base}[${index}]"));
    }

    # Preserve endianness
    if ($lower == $lsb) {
      @bits = reverse @bits;
    }
  }
  else {
    # Either a regular name with no bit select, or an escaped name
    # In both cases, width is ambiguous and the number of connected bits
    #   must be used to infer a missing pin's width

    # Process missing pins
    return undef if ($mode eq "num" && !$self->check_missing_pin($pin_name));
    if ($mode eq "bits") {
      if (defined $num_conn_bits) {
        if ($num_conn_bits > 1) {
          # Create pin bus to match connected bus, assume lsb is 0
          return undef if (!$self->create_missing_pin($pin_name, $num_conn_bits-1, 0));
        }
        else {
          # Create single pin to match single connected bit
          return undef if (!$self->create_missing_pin($pin_name));
        }
      }
    }

    my $Pin = $self->get_pin_header($pin_name);
    if ($Pin->has_bus) {
      # Implicit bus
      my $msb = $Pin->get_msb;
      my $lsb = $Pin->get_lsb;
      my ($upper, $lower) = &Hydra::Verilog::normalize_bit_range($msb, $lsb);
      foreach my $index ($lower..$upper) {
        push(@bits, $self->get_pin("${pin_name}[${index}]"));
      }

      # Preserve endianness
      if ($lower == $lsb) {
        @bits = reverse @bits;
      }
    }
    else {
      # Implicit scalar
      push(@bits, $self->get_pin($pin_name));
    }
  }

  if ($mode eq "num") {
    return scalar(@bits);
  }
  elsif ($mode eq "bits") {
    return \@bits;
  }
}

sub connect_ordered_bits {
  my ($self, $aref_pins, $aref_nets, $aref_pindirs, $aref_netdirs, $pin_name) = @_;
  # Pindirs and netdirs are optionally used to override the direction
  #   found in the bit object; used for correctly identifying the
  #   direction of pins on the internal side of the instance
  
  for (my $index = 0; $index <= $#$aref_pins; $index++) {
    my $PinBit      = $aref_pins->[$index];
    my $href_netbit = $aref_nets->[$index];
    my $pin_dir;
    my $net_dir;
    if (defined $aref_pindirs) {
      $pin_dir = $aref_pindirs->[$index];
    }
    else {
      $pin_dir = $PinBit->get_direction;
    }
    if (defined $aref_netdirs) {
      $net_dir = $aref_netdirs->[$index];
    }
    else {
      $net_dir = "undirected";
    }

    # Check whether this is a temporary net or a literal object
    if (ref($href_netbit) ne "HASH") {
      $net_dir = "output";
    }

    # Infer direction of undirected connections if possible
    if ($pin_dir eq "undirected" && $net_dir eq "undirected") {
      # Do Nothing
    }
    elsif ($net_dir eq "undirected") {
      $net_dir = "output" if ($pin_dir eq "input");
      $net_dir = "input"  if ($pin_dir eq "output");
      $net_dir = "inout"  if ($pin_dir eq "inout");
    }
    elsif ($pin_dir eq "undirected") {
      $pin_dir = "output" if ($net_dir eq "input");
      $pin_dir = "input"  if ($net_dir eq "output");
      $pin_dir = "inout"  if ($net_dir eq "inout");
    }
    
    if (ref($href_netbit) eq "HASH") {
      # For nets, add to hash for resolving later
      push(@{ $href_netbit->{$net_dir} }, $PinBit);
    }
    else {
      # For literals, make the connection now
      $PinBit->add_connection($href_netbit, $pin_dir);
      $PinBit->set_net("LITERAL");
      $href_netbit->add_connection($PinBit, $net_dir);
    }
  }
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub parse_port_declarations {
  my ($self, $aref_port_decls) = @_;
  return if (!defined $aref_port_decls);

  my @tokens = @$aref_port_decls;

  my $direction;
  my $msb;
  my $lsb;
  my @renamed_nets = ();
  for (my $index = 0; $index <= $#tokens; $index++) {
    my $port_name;
    my $token = $tokens[$index];
    if ($token =~ /^(input|output|inout)\s+/) {
      $direction = $1;
      $token =~ s/^\s*${direction}\s+//;
      
      $msb = undef;
      $lsb = undef;
      if ($token !~ /^\\/ && $token =~ /\[([\d\-]+)\:([\d\-]+)\]/) {
        $msb = $1;
        $lsb = $2;
        $token =~ s/\s*\[${msb}\:${lsb}\]\s*//;
      }
    }

    $token =~ s/^\s*//;
    $token =~ s/\s*$//;

    # Warn if negative indices are found
    if ((defined $msb && defined $lsb) && ($msb =~ /\-/ || $lsb =~ /\-/)) {
      print "WARN: Negative bus index defined on module=" . $self->get_name . " port=${token} msb=${msb} lsb=${lsb}\n";
    }

    # Check for port renaming
    if ($token =~ /\./) {
      # Get the rest of the declaration, which may have been split by comma (grouped nets)
      while ($token !~ /\)/) {
        $index++;
        $token .= "," . $tokens[$index];
      }
      $token .= "," . $tokens[$index];

      # Process statement
      if ($token =~ /\.([^\s\(\)]+)\s*\(\s*(.*?)\s*\)/) {
        $port_name    = $1;
        my $conn_stmt = $2;

        # Check for grouped nets
        if ($conn_stmt =~ /\{/) {
          $conn_stmt =~ s/^\{\s*//;
          $conn_stmt =~ s/\s*\}$//;
          my @net_tokens = split(/\s*\,\s*/, $conn_stmt);
          my @nets = ();
          foreach my $net_name (@net_tokens) {
            if ($net_name =~ /^\s*(\d+)\s*\{\s*([^\{\}\s]+)\s*\}/) {
              # Support concatentation repetition multiplier
              my $count = $1;
              my $real_net_name = $2;
              foreach (1..$count) {
                push(@renamed_nets, $real_net_name);
              }
            }
            else {
              push(@renamed_nets, $net_name);
            }
          }
        }
      }
      else {
        print "WARN: skipping unrecognized port renaming syntax: ${token}\n";
      }
    }
    else {
      $port_name = $token;
    }

    if (defined $port_name) {
      # Create pin object
      my $Pin = new Hydra::Verilog::Pin($self, $port_name);
      $self->add_pin($Pin);

      # Apply direction obtained above
      if (defined $direction) {
        $Pin->set_direction($direction);
      }

      # Apply msb/lsb obtained above
      if (defined $msb && defined $lsb) {
        # Check that msb/lsb is consistent with the grouped net width
        if (scalar(@renamed_nets) > 0) {
          my $decl_width  = abs($msb-$lsb);
          my $group_width = scalar(@renamed_nets);
          if ($decl_width != $group_width) {
            print "WARN: declared port width does not match port renaming width ...port renaming width will be used\n";
            print "      stmt=${token}\n";
            print "      declared msb=${msb} lsb=${lsb}\n";
            print "      port renaming width=${group_width}\n";
            $msb = scalar(@renamed_nets) - 1;
            $lsb = 0;
          }
        }

        $Pin->set_msb($msb);
        $Pin->set_lsb($lsb);
      }

      # Apply renamed nets obtained above
      if (scalar(@renamed_nets) > 0) {
        foreach my $net_name (@renamed_nets) {
          # Store renamed nets, which will be used to find what the original port is
          $self->{port_nets}{$net_name} = $port_name;

          # Add renamed nets to net-list, which will be used to find what each net is connected to later
          $self->add_net($net_name);
          #$self->add_net_pin_connection($net_name, $port_name);
        }
        $Pin->set_renamed_nets(\@renamed_nets);
      }
      else {
        # Add net with same name as pin to net-list
        $self->add_net($port_name);
        #$self->add_net_pin_connection($port_name, $port_name);
      }
    }
  }
}

sub parse_port_statements {
  my ($self, $aref_stmts) = @_;
  return if (!defined $aref_stmts);

  for (my $index = 0; $index <= $#$aref_stmts; $index++) {
    my $stmt = $aref_stmts->[$index];
    $stmt =~ s/\n//g;
    if ($stmt =~ /^\s*(input|output|inout)\s+(.+?)\s*\;\s*$/) {
      # Port direction statement
      my $direction   = $1;
      my $port_string = $2;
      my $Pin;

      # Bus Port
      if ($port_string !~ /^\\/ && $port_string =~ /(\[([\d\-]+)\:([\d\-]+)\])/) {
        my $bus_stmt = $1;
        my $msb      = $2;
        my $lsb      = $3;

        $port_string =~ s/\s*\Q${bus_stmt}\E\s*//;
        my @port_names = split(/\s*\,\s*/, $port_string);

        # Warn if negative indices are found
        if ($msb =~ /\-/ || $lsb =~ /\-/) {
          foreach my $port_name (@port_names) {
            print "WARN: Negative bus index defined on module=" . $self->get_name . " port=${port_name} msb=${msb} lsb=${lsb}\n";
          }
        }

        foreach my $port_name (@port_names) {
          $Pin = $self->get_pin_from_port_net($port_name);
          if (defined $Pin) {
            $Pin->set_direction($direction);
            if (defined $msb && defined $lsb) {
              $self->set_net_bus($port_name, $msb, $lsb);
              $Pin->set_msb($msb);
              $Pin->set_lsb($lsb);
            }
          }
        }
      }
      # Single Port
      else {
        my @port_names = split(/\s*\,\s*/, $port_string);
        foreach my $port_name (@port_names) {
          $Pin = $self->get_pin_from_port_net($port_name);
          if (defined $Pin) {
            $Pin->set_direction($direction);
          }
        }
      }
    }
  }
}

sub parse_net_statements {
  my ($self, $aref_stmts) = @_;
  return if (!defined $aref_stmts);

  for (my $index = 0; $index <= $#$aref_stmts; $index++) {
    my $stmt = $aref_stmts->[$index];
    $stmt =~ s/\n//g;
    if ($stmt =~ /^\s*wire\s+(.+?)\s*\;\s*$/) {
      # Wire statement
      my $net_string = $1;

      # Bus Net
      if ($net_string !~ /^\\/ && $net_string =~ /(\[([\d\-]+)\:([\d\-]+)\])/) {
        my $bus_stmt = $1;
        my $msb    = $2;
        my $lsb    = $3;

        $net_string =~ s/\s*\Q${bus_stmt}\E\s*//;
        my @net_names = split(/\s*\,\s*/, $net_string);

        # Warn if negative indices are found
        if ($msb =~ /\-/ || $lsb =~ /\-/) {
          foreach my $net_name (@net_names) {
            print "WARN: Negative bus index defined on module=" . $self->get_name . " net=${net_name} msb=${msb} lsb=${lsb}\n";
          }
        }

        foreach my $net_name (@net_names) {
          $self->add_net($net_name);
          $self->set_net_bus($net_name, $msb, $lsb);
        }
      }
      # Single Net
      else {
        my @net_names = split(/\s*\,\s*/, $net_string);
        foreach my $net_name (@net_names) {
          $self->add_net($net_name);
        }
      }
    }
  }
}

sub parse_module_statements {
  my ($self, $aref_stmts) = @_;
  return if (!defined $aref_stmts);
  my $stmt_cursor = 0;

  for (my $index = 0; $index <= $#$aref_stmts; $index++) {
    $stmt_cursor++;
    if (($stmt_cursor % 10000) == 0 && $stmt_cursor != 0) {
      #&Hydra::Util::File::print_unbuffered("INFO:  read $stmt_cursor statements...\n");
    }
    my $stmt = $aref_stmts->[$index];
    $stmt =~ s/\n//g;

    if ($stmt =~ /^\s*assign\s+(\S+)\s+\=\s+(\S+)\s*\;\s*$/) {
      # Assign statement
      my $left  = $1;
      my $right = $2;
      
      $self->process_assign($left, $right);
    }
    elsif ($stmt =~ /^\s*(\S+)\s+(\S+?)\s+\((.+)\)\s*\;\s*$/ ||
           $stmt =~ /^\s*(\S+)\s+(\S+?)\s*\((.+)\)\s*\;\s*$/) {
      # Instance statement
      my $cell_name   = $1;
      my $inst_name   = $2;
      my $conn_stmt   = $3;
      my $SubModule   = $self->get_module->get_design->find_cell($cell_name);
      if (defined $SubModule) {
        # Instantiate existing cell from module object
        my $SubInst = $SubModule->instantiate($self, $inst_name);
        $SubInst->set_conn_stmt($conn_stmt);
        $self->add_instance($SubInst);
      }
      else {
        confess;
      }
      # else {
      #   # Cell does not exist; manually instantiate and resolve to infer pin info
      #   my $SubInst = new Hydra::Verilog::Instance(undef, $self, $inst_name);
      #   $SubInst->set_conn_stmt($conn_stmt);
      #   $SubInst->resolve;
      #   #$SubInst->parse_conn_stmt;
      #   $self->add_instance($SubInst);
      # }
    }
  }
}

sub parse_conn_stmt {
  my ($self, $mode) = @_;
  $mode = "normal" if (!defined $mode);
  # Normal mode - Add net connections to object
  # Return mode - Return net connections in a hash

  my $conn_stmt = $self->get_conn_stmt;
  my %pins      = ();
  
  # No net connection statement; this is probably the top instance
  return if (!defined $conn_stmt);
  
  # Remove spaces between name and bus width operator ([])
  $conn_stmt =~ s/(\S)\s+\[/$1\[/g;

  if ($conn_stmt =~ /\./) {
    # Named notation
    while ($conn_stmt =~ /\.([^\s\(\)]+)\s*\(\s*(.*?)\s*\)/g) {
      my $pin_name = $1;
      my $net_stmt = $2;

      # Bus braces
      if ($net_stmt =~ /\{/) {
        $net_stmt =~ s/^\{\s*//;
        $net_stmt =~ s/\s*\}$//;
        my @net_tokens = split(/\s*\,\s*/, $net_stmt);
        my @nets = ();
        foreach my $net_name (@net_tokens) {
          if ($net_name =~ /^\s*(\d+)\s*\{\s*([^\{\}\s]+)\s*\}/) {
            # Support concatentation repetition multiplier
            my $count = $1;
            my $real_net_name = $2;
            foreach (1..$count) {
              push(@nets, $real_net_name);
            }
          }
          else {
            push(@nets, $net_name);
          }
        }

        if ($mode eq "return") {
          $pins{$pin_name} = \@nets;
        }
        else {
          $self->connect_named_pin_to_group($pin_name, \@nets);
        }
      }
      else {
        if ($mode eq "return") {
          $pins{$pin_name} = [$net_stmt];
        }
        else {
          $self->connect_named_pin($pin_name, $net_stmt);
        }
      }
    }
  }
  else {
    # Positional notation
    if ($conn_stmt =~ /\{/) {
      # Has bus braces
      $conn_stmt =~ s/\s*//g;
      my @nets = ("");
      my @tokens = split(/\,/, $conn_stmt);
      my $nindex = 0;
      for (my $tindex = 0; $tindex <= $#tokens; $tindex++) {
        my $token = $tokens[$tindex];
        
        if ($token =~ /^\s*\{/) {
          $token =~ s/^\s*\{//;
          while ($token !~ /\}\s*$/) {
            if ($token =~ /^\s*(\d+)\s*\{\s*([^\{\}\s]+)\s*\}/) {
              # Support concatentation repetition multiplier
              my $count    = $1;
              my $net_name = $2;
              foreach (1..$count) {
                $nets[$nindex] .= ",$net_name";
              }
            }
            else {
              $nets[$nindex] .= ",$token";
            }
            $tindex++;
            $token = $tokens[$tindex];
          }

          # Process the last token
          $token =~ s/\}\s*$//;
          if ($token =~ /^\s*(\d+)\s*\{\s*([^\{\}\s]+)\s*\}/) {
            # Support concatentation repetition multiplier
            my $count    = $1;
            my $net_name = $2;
            foreach (1..$count) {
              $nets[$nindex] .= ",$net_name";
            }
          }
          else {
            $nets[$nindex] .= ",$token";
          }
        }
        else {
          $nets[$nindex] = $token;
        }

        $nets[$nindex] =~ s/^\,//;
        $nindex++;
        $nets[$nindex] = "";
      }

      if ($mode eq "return") {
        my @Pins = $self->get_pin_list;
        foreach my $index (0..$#Pins) {
          $pins{$Pins[$index]->get_name} = [$nets[$index]];
        }
      }
      else {
        $self->connect_positional_nets(\@nets);
      }
    }
    else {
      # No bus braces
      if ($conn_stmt !~ /^\s*$/) {
        my @nets = split(/\s*\,\s*/, $conn_stmt);

        if ($mode eq "return") {
          my @Pins = $self->get_pin_list;
          foreach my $index (0..$#Pins) {
            $pins{$Pins[$index]->get_name} = [$nets[$index]];
          }
        }
        else {
          $self->connect_positional_nets(\@nets);
        }
      }
    }
  }

  if ($mode eq "return") {
    return \%pins;
  }
  else {
    return;
  }
}

sub connect_port_nets {
  my ($self) = @_;

  foreach my $Pin ($self->get_pin_list) {
    my $pin_name = $Pin->get_name;
    if ($Pin->has_renamed_nets) {
      # Connect renamed nets
      my $aref_net_names = $Pin->get_renamed_nets;
      my $aref_pins      = $self->get_pin_bits_from_name("bits", $pin_name);
      my $aref_nets      = [];

      foreach my $net_name (@$aref_net_names) {
        my $aref_bits = $self->get_net_bits_from_name("bits", $net_name);
        next if (!defined $aref_bits);
        push(@$aref_nets, @$aref_bits);
      }

      my $aref_pindirs = $self->translate_pin_dirs($aref_pins);
      $self->connect_ordered_bits($aref_pins, $aref_nets, $aref_pindirs);
    }
    else {
      # Connect same-name nets
      my $aref_pins    = $self->get_pin_bits_from_name("bits", $pin_name);
      my $aref_nets    = $self->get_net_bits_from_name("bits", $pin_name);
      my $aref_pindirs = $self->translate_pin_dirs($aref_pins);
      $self->connect_ordered_bits($aref_pins, $aref_nets, $aref_pindirs);
    }
  }
}

sub translate_pin_dirs {
  my ($self, $aref_pins) = @_;
  # For internal side of pins, count the direction as opposite
  #   because the nominal direction of the pin is from the context of
  #   outside the instance
  my $aref_pindirs = [];
  foreach my $index (0..$#$aref_pins) {
    my $dir = $aref_pins->[$index]->get_direction;
    if ($dir eq "input") {
      $dir = "output";
    }
    elsif ($dir eq "output") {
      $dir = "input";
    }
    push(@{ $aref_pindirs }, $dir);
  }
  return $aref_pindirs;
}

sub resolve_net_connections {
  my ($self) = @_;
  my %nets = ();

  foreach my $net_name (keys %{ $self->{nets} }) {
    foreach my $bit (keys %{ $self->{nets}{$net_name}{bits} }) {
      # Get all connection combinations of Pins
      my %all_pins = (input => [], output => [], inout => [], undirected => []);
      my @combos   = ();
      foreach my $dir (qw(input output inout undirected)) {
        foreach my $Pin (@{ $self->{nets}{$net_name}{bits}{$bit}{$dir} }) {
          if (ref($Pin) eq "HASH") {
            # This is an assign net; trace through to next net and get its pins
            my @assign_pins = $self->get_assign_net_pins($Pin, $dir, $Pin);
            foreach my $href_entry (@assign_pins) {
              push(@{ $all_pins{$href_entry->{dir}} }, $href_entry);
            }
          }
          else {
            # Check whether this Pin's direction was previously inferred and override if so
            my $inferred_dir = $dir;
            my $pin_dir = $Pin->get_direction;
            if ($inferred_dir eq "undirected") {
              if ($pin_dir eq "input") {
                $inferred_dir = "output";
              }
              elsif ($pin_dir eq "output") {
                $inferred_dir = "input";
              }
              elsif ($pin_dir eq "inout") {
                $inferred_dir = "inout";
              }
            }

            my %entry = (pin => $Pin, dir => $inferred_dir);
            push(@{ $all_pins{$entry{dir}} }, \%entry);
          }
        }
      }

      # Count number of undirected and input pins for inferring direction of undirected connections
      my $num_undirected = scalar(@{ $all_pins{undirected} });
      my $num_input      = scalar(@{ $all_pins{input} });

      # Infer direction of undirected connections
      my @new_undirected_pins = ();
      foreach my $href_entry (@{ $all_pins{undirected} }) {
        if ($num_input == 0 && $num_undirected == 1) {
          # Special case for nets with no input and one undirected:
          #   infer the undirected to input
          $href_entry->{dir} = "input";
          $href_entry->{pin}->set_direction("output");
          push(@{ $all_pins{input} }, $href_entry);
        }
        elsif ($num_input >= 1) {
          # Special case for nets that already have an input:
          #   infer all undirected to output
          $href_entry->{dir} = "output";
          $href_entry->{pin}->set_direction("input");
          push(@{ $all_pins{output} }, $href_entry);
        }
        else {
          push(@new_undirected_pins, $href_entry);
        }
      }
      $all_pins{undirected} = \@new_undirected_pins;

      # Create list of all pin pairs
      foreach my $href_pin1 ((@{ $all_pins{input} }, @{ $all_pins{inout} }, @{ $all_pins{undirected} })) {
        foreach my $href_pin2 ((@{ $all_pins{output} }, @{ $all_pins{inout} }, @{ $all_pins{undirected} })) {
          my %entry = (pin1 => $href_pin1->{pin},
                       dir1 => $href_pin1->{dir},
                       pin2 => $href_pin2->{pin},
                       dir2 => $href_pin2->{dir});
          push(@combos, \%entry);
        }
      }

      # Connect all Pin pairs
      foreach my $href_entry (@combos) {
        my $Pin1 = $href_entry->{pin1};
        my $Pin2 = $href_entry->{pin2};
        my $dir1 = $href_entry->{dir1};
        my $dir2 = $href_entry->{dir2};
        
        if ($dir1 eq "input") {
          if ($dir2 eq "input") {
            next;
          }
          elsif ($dir2 eq "output") {
            $dir1 = "output";
            $dir2 = "input";
          }
          elsif ($dir2 eq "inout") {
            $dir1 = "output";
            $dir2 = "input";
          }
          elsif ($dir2 eq "undirected") {
            $dir1 = "output";
            $dir2 = "input";
          }
        }
        elsif ($dir1 eq "output") {
          if ($dir2 eq "input") {
            $dir1 = "input";
            $dir2 = "output";
          }
          elsif ($dir2 eq "output") {
            next;
          }
          elsif ($dir2 eq "inout") {
            $dir1 = "input";
            $dir2 = "output";
          }
          elsif ($dir2 eq "undirected") {
            $dir1 = "undirected";
            $dir2 = "undirected";
          }
        }
        elsif ($dir1 eq "inout") {
          if ($dir2 eq "input") {
            $dir1 = "input";
            $dir2 = "output";
          }
          elsif ($dir2 eq "output") {
            $dir1 = "output";
            $dir2 = "input";
          }
          elsif ($dir2 eq "inout") {
            $dir1 = "inout";
            $dir2 = "inout";
          }
          elsif ($dir2 eq "undirected") {
            $dir1 = "inout";
            $dir2 = "inout";
          }
        }
        elsif ($dir1 eq "undirected") {
          if ($dir2 eq "input") {
            $dir1 = "input";
            $dir2 = "output";
          }
          elsif ($dir2 eq "output") {
            $dir1 = "undirected";
            $dir2 = "undirected";
          }
          elsif ($dir2 eq "inout") {
            $dir1 = "inout";
            $dir2 = "inout";
          }
          elsif ($dir2 eq "undirected") {
            # Leave both as undirected
          }
        }

        # Skip input-input and output-output connections
        if (($dir1 eq "input" && $dir2 eq "input") ||
            ($dir1 eq "output" && $dir2 eq "output")) {
          next;
        }

        my $net_bit = $self->get_hier_name . "/${net_name}";
        if ($bit ne "-1") {
          $net_bit .= "[${bit}]";
        }

        $Pin1->add_connection($Pin2, $dir1);
        $Pin1->set_net($net_bit);
        $Pin2->add_connection($Pin1, $dir2);
        $Pin2->set_net($net_bit);

        #push(@{ $nets{$net_bit} }, $Pin1);
        #push(@{ $nets{$net_bit} }, $Pin2);
      }
    }
  }

  #delete $self->{nets};
  #$self->{nets} = \%nets;
}

sub get_assign_net_pins {
  my ($self, $href_net, $assign_dir, $href_starting_net) = @_;
  my @pins = ();

  # Dont add output pins for input assigns and vice versa
  my $skip_dir;
  if ($assign_dir eq "input") {
    $skip_dir = "output";
  }
  elsif ($assign_dir eq "output") {
    $skip_dir = "input";
  }

  foreach my $dir (qw(input output inout undirected)) {
    next if ($dir eq $skip_dir);
    foreach my $Pin (@{ $href_net->{$dir} }) {
      if (ref($Pin) eq "HASH") {
        # This is an assign net; trace through to next net and get its pins
        # Dont trace if the starting net is encountered again, to avoid infinite loops
        unless (scalar($href_starting_net) eq scalar($Pin)) {
          push(@pins, $self->get_assign_net_pins($Pin, $dir, $href_starting_net));
        }
      }
      else {
        my %entry = (pin => $Pin, dir => $dir);
        push(@pins, \%entry);
      }
    }
  }

  return @pins;
}

sub process_lib {
  my ($self, $CellLib) = @_;
  foreach my $PinLib ($CellLib->get_pin_list) {
    my $pin_name = $PinLib->get_name;
    my $pin_type = $PinLib->get_type;
    #my $pin_type = $CellLib->get_pin_type($pin_name);
    if ($pin_name =~ /\[.*\]/) {
      # Preprocess [] special characters
      $pin_name = "\\" . $pin_name;
    }

    my $Pin = new Hydra::Verilog::Pin($self, $pin_name);
    $self->add_pin($Pin);

    if ($pin_type eq "bus") {
      # Get msb/lsb
      my $direction   = $PinLib->get_bus_direction;
      my $bus_type    = $PinLib->get_bus_type;

      my $Library     = &Hydra::Liberty::find_library_with_cell($CellLib->get_name);
      my ($msb, $lsb) = $Library->get_bus_width($bus_type);

      if (defined $direction) {
        $Pin->set_direction($direction);
      }

      if (defined $msb && defined $lsb) {
        $Pin->set_msb($msb);
        $Pin->set_lsb($lsb);
      }
      else {
        print "WARN: Msb/lsb not found for bus pin=${pin_name} of lib cell=" . $CellLib->get_name . "! Skipping bus creation...\n";
      }
    }
    elsif ($pin_type eq "pin" || $pin_type eq "bundle") {
      if ($PinLib->has_simple_attribute("direction")) {
        $Pin->set_direction($PinLib->get_simple_attribute("direction"));
      }
    }
    # elsif ($pin_type eq "bundled_pin") {
    #   $Pin->set_direction($CellLib->get_bundled_pin_direction($pin_name));
    # }
  }
}

sub resolve {
  my ($self) = @_;
  if ($self->is_resolved && $self->is_resolved_inst) {
    # Dont re-resolve instances
    return;
  }
  if ($self->get_module->get_type ne "module") {
    # Only resolve module instances
    return;
  }
  #&Hydra::Util::File::print_unbuffered("INFO: Resolving instance " . $self->get_hier_name . "\n");

  if (!$self->is_resolved_inst) {
    $self->parse_module_statements($self->get_module->get_module_statements);
    $self->set_resolved_inst;
  }

  # Switch for disabling resolution of net connections
  if (&Hydra::Verilog::is_resolve_conn_on && !$self->is_resolved) {
    # Create all connections between all sub-instances
    foreach my $SubInst ($self->get_instance_list_no_resolve) {
      $SubInst->parse_conn_stmt;
    }
    
    # Connect pins to corresponding port nets
    $self->connect_port_nets;
    
    # Connect pins directly and remove all nets
    $self->resolve_net_connections;

    # Flag this instance as resolved
    $self->set_resolved;
  }
}


1;
