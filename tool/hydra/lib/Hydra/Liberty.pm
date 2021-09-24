#------------------------------------------------------
# Module Name: Liberty
# Date:        Mon Aug 19 13:13:50 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Liberty::LibSet;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_libset;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub read_lib {
  my $aref_files = &Hydra::Util::Option::get_opt_value_array("-lib_files", "relaxed", []);
  my @lib_files = @$aref_files;

  # Remove duplicates
  my %undup = map {$_ => 1} @lib_files;
  @lib_files = sort keys %undup;

  my $LibSet = new Hydra::Liberty::LibSet;
  &set_libset($LibSet);
  foreach my $lib_file (@lib_files) {
    $LibSet->read_lib_file($lib_file);
  }
}

sub get_libset {
  return $glb_libset;
}

sub has_libset {
  if (defined $glb_libset) {
    return 1;
  }
  return 0;
}

sub set_libset {
  my ($LibSet) = @_;
  $glb_libset = $LibSet;
}

#------------------------------------------------------
# Library Accessing Functions
#------------------------------------------------------
sub find_cell_lib {
  my ($cell_name) = @_;
  my $LibSet = &get_libset;

  if (defined $LibSet) {
    foreach my $Library ($LibSet->get_library_list) {
      if ($Library->has_cell($cell_name)) {
        return $Library->get_cell($cell_name);
      }
    }
  }

  return undef;
}

sub find_library_with_cell {
  my ($cell_name) = @_;
  my $LibSet = &get_libset;

  if (defined $LibSet) {
    foreach my $Library ($LibSet->get_library_list) {
      if ($Library->has_cell($cell_name)) {
        return $Library;
      }
    }
  }

  return undef;
}

sub get_cell_type {
  my ($CellLib) = @_;
  my $is_macro_cell = "false";
  my $is_pad_cell   = "false";
  if ($CellLib->has_simple_attribute("is_macro_cell")) {
    $is_macro_cell = $CellLib->get_simple_attribute("is_macro_cell");
  }
  if ($CellLib->has_simple_attribute("pad_cell")) {
    $is_pad_cell = $CellLib->get_simple_attribute("pad_cell");
  }
  
  if ($is_macro_cell =~ /true/i) {
    return "macro";
  }
  elsif ($is_pad_cell =~ /true/i) {
    return "pad";
  }
  else {
    return "cell";
  }
}

sub trace_to_output {
  my ($InPin) = @_;
  if (&Hydra::Verilog::is_flop($InPin->get_parent)) {
    return &trace_to_ff_output($InPin);
  }
  elsif (&Hydra::Verilog::is_icg($InPin->get_parent)) {
    return &trace_to_icg_output($InPin);
  }
  else {
    return &trace_to_std_cell_output($InPin);
  }
}

sub trace_to_input {
  my ($OutPin) = @_;
  if (&Hydra::Verilog::is_flop($OutPin->get_parent)) {
    return &trace_to_ff_input($OutPin);
  }
  elsif (&Hydra::Verilog::is_icg($OutPin->get_parent)) {
    return &trace_to_icg_input($OutPin);
  }
  else {
    return &trace_to_std_cell_input($OutPin);
  }
}

sub trace_to_icg_output {
  my ($InPin) = @_;
  my $CellLib  = $InPin->get_parent->get_module->get_lib;
  return () if (!defined $CellLib);

  my @OutNodes = ();
  foreach my $OutPinLib ($CellLib->get_pin_list) {
    if ($OutPinLib->is_simple_attribute_true("clock_gate_out_pin")) {
      push(@OutNodes, $InPin->get_parent->get_pin($OutPinLib->get_name));
    }
  }

  return @OutNodes;
}

sub trace_to_std_cell_output {
  my ($InPin) = @_;
  my $CellLib  = $InPin->get_parent->get_module->get_lib;
  return () if (!defined $CellLib);

  my $InPinLib = $CellLib->find_pin($InPin->get_name);
  return () if (!defined $InPinLib);

  my @OutNodes = ();
  foreach my $OutPinLib ($CellLib->get_pin_list) {
    if ($OutPinLib->is_simple_attribute_equal_to("direction", "output")) {
      if ($OutPinLib->has_simple_attribute("function")) {
        # Look for input pin inside function attribute of this output pin
        my $function = $OutPinLib->get_simple_attribute("function");
        if (&is_pin_in_function($function, $InPinLib)) {
          push(@OutNodes, $InPin->get_parent->get_pin($OutPinLib->get_name));
        }
      }
      else {
        # Look for input pin inside related_pin attribute inside timing subgroup of this output pin
        my %related_pins = ();
        foreach my $Timing ($OutPinLib->get_empty_subgroup("timing")) {
          my $related_pin = $Timing->get_simple_attribute("related_pin");
          $related_pin =~ s/\"//g;
          $related_pins{$related_pin} = 1;
        }
        if (&is_pin_in_timing_group(\%related_pins, $InPinLib)) {
          push(@OutNodes, $InPin->get_parent->get_pin($OutPinLib->get_name));
        }
      }
    }
  }

  return @OutNodes;
}

sub trace_to_icg_input {
  my ($OutPin) = @_;
  my $CellLib  = $OutPin->get_parent->get_module->get_lib;
  return () if (!defined $CellLib);

  my @InNodes = ();
  foreach my $InPinLib ($CellLib->get_pin_list) {
    if ($InPinLib->is_simple_attribute_true("clock_gate_clock_pin")) {
      push(@InNodes, $OutPin->get_parent->get_pin($InPinLib->get_name));
    }
  }

  return @InNodes;
}

sub trace_to_std_cell_input {
  my ($OutPin) = @_;
  my $CellLib   = $OutPin->get_parent->get_module->get_lib;
  return () if (!defined $CellLib);

  my $OutPinLib = $CellLib->find_pin($OutPin->get_name);
  return () if (!defined $OutPinLib);

  my @InNodes = ();
  if ($OutPinLib->has_simple_attribute("function")) {
    # Find input via function attribute
    my $function = $OutPinLib->get_simple_attribute("function");
    foreach my $InPinLib ($CellLib->get_pin_list) {
      next if ($InPinLib->get_name eq $OutPin->get_name);

      if (&is_pin_in_function($function, $InPinLib)) {
        push(@InNodes, $OutPin->get_parent->get_pin($InPinLib->get_name));
      }
    }
  }
  else {
    # Find input pin via related_pin attribute inside timing subgroup
    my %related_pins = ();
    foreach my $Timing ($OutPinLib->get_empty_subgroup("timing")) {
      if ($Timing->has_simple_attribute("related_pin")) {
        my $related_pin = $Timing->get_simple_attribute("related_pin");
        $related_pin =~ s/\"//g;
        $related_pins{$related_pin} = 1;
      }
    }
    foreach my $InPinLib ($CellLib->get_pin_list) {
      next if ($InPinLib->get_name eq $OutPin->get_name);

      if (&is_pin_in_timing_group(\%related_pins, $InPinLib)) {
        push(@InNodes, $OutPin->get_parent->get_pin($InPinLib->get_name));
      }
    }
  }

  return @InNodes;
}

sub trace_to_ff_output {
  my ($InPin) = @_;
  my $CellLib = $InPin->get_parent->get_module->get_lib;
  return () if (!defined $CellLib);

  my @OutNodes = ();
  foreach my $OutPinLib ($CellLib->get_pin_list) {
    if ($OutPinLib->is_simple_attribute_equal_to("direction", "output")) {
      push(@OutNodes, $InPin->get_parent->get_pin($OutPinLib->get_name));
    }
  }

  return @OutNodes;
}

sub trace_to_ff_input {
  my ($OutPin) = @_;
  my $CellLib = $OutPin->get_parent->get_module->get_lib;
  return () if (!defined $CellLib);

  my @InNodes = ();
  foreach my $InPinLib ($CellLib->get_pin_list) {
    next if ($InPinLib->get_name eq $OutPin->get_name);

    if ($InPinLib->is_simple_attribute_equal_to("nextstate_type", "data")) {
      push(@InNodes, $OutPin->get_parent->get_pin($InPinLib->get_name));
    }
  }

  return @InNodes;
}

sub is_pin_in_function {
  my ($function, $PinLib) = @_;
  my $pin_name = $PinLib->get_name;
  $function =~ s/[^a-zA-Z0-9\_]+/ /g;

  my %pins = map {$_ => 1} split(/\s+/, $function);
  if (defined $pins{$pin_name}) {
    return 1;
  }
  elsif (defined $PinLib && $PinLib->has_complex_attribute("members")) {
    # PinLib is a bundle

    # Check for bundle name referenced in function
    my $bundle_name = $PinLib->get_name;
    if (defined $pins{$bundle_name}) {
      return 1;
    }

    # Expand the bundle into its pin members to check for pin member referenced in function
    my @bundle_pins = $PinLib->get_bundled_pin_list;
    foreach my $bundle_pin (@bundle_pins) {
      if (defined $pins{$bundle_pin}) {
        return 1;
      }
    }
  }

  return 0;
}

sub is_pin_in_timing_group {
  my ($href_related_pins, $PinLib) = @_;
  my $pin_name = $PinLib->get_name;

  if (defined $href_related_pins->{$pin_name}) {
    return 1;
  }
  elsif ($PinLib->has_complex_attribute("members")) {
    # InPinLib is a bundle
    
    # Check for bundle name referenced in related_pin
    my $bundle_name = $PinLib->get_name;
    return 1 if (defined $href_related_pins->{$bundle_name});
    
    # Expand the bundle into its pin members to check for pin member referenced in function
    my @bundle_pins = $PinLib->get_bundled_pin_list;
    foreach my $bundle_pin (@bundle_pins) {
      return 1 if (defined $href_related_pins->{$bundle_pin});
    }
  }

  return 0;
}


1;
