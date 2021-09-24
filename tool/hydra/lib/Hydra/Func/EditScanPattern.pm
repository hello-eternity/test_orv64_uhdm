#------------------------------------------------------
# Module Name: EditScanPattern
# Date:        Mon Nov 25 14:21:28 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::EditScanPattern;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $bit_blast = 1;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub edit_scan_pattern {
  my $chain_file     = &Hydra::Util::Option::get_opt_value_scalar("-chain_file", "strict");
  my $create_pattern = &Hydra::Util::Option::get_opt_value_scalar("-create_random_pattern", "relaxed", "off");
  my $pattern_file   = &Hydra::Util::Option::get_opt_value_scalar("-pattern_file", "relaxed", undef);
  my $register_file  = &Hydra::Util::Option::get_opt_value_scalar("-register_file", "relaxed", undef);
  my $out_file       = &Hydra::Util::Option::get_opt_value_scalar("-out_file", "relaxed", undef);
  $bit_blast         = &Hydra::Util::Option::get_opt_value_scalar("-bit_blast", "relaxed", "on");
  if ($create_pattern =~ /true|on|yes/i) {
    $pattern_file = "random_pattern.txt";
  }
  if ($bit_blast =~ /true|on|yes/i) {
    $bit_blast = 1;
  }
  else {
    $bit_blast = 0;
  }

  if (defined $pattern_file && defined $register_file) {
    print "ERROR: Both -pattern_file and -register_file cannot be defined!\n";
    die;
  }
  elsif (defined $pattern_file && !defined $out_file) {
    $out_file = "register.txt";
  }
  elsif (defined $register_file && !defined $out_file) {
    $out_file = "pattern.txt";
  }

  my %chains = ();
  # %chains =>
  #   $chain_name => 
  #     [
  #       hier => <name>
  #       inst => <name>
  #       cell => <name>
  #     ]
  #
  my %buses = ();
  # %buses =>
  #   $bus_name => 
  #     val => []
  #     msb => []
  #     lsb => []
  #
  my %patterns = ();

  # Read scan chain file
  my $fh_chain = &Hydra::Util::File::open_file_for_read($chain_file);
  while (my $line = <$fh_chain>) {
    my @tokens = split(/\s+/, $line);
    my $chain_name  = $tokens[1];
    my $chain_index = $tokens[2];
    next if ($chain_index !~ /^\d+$/);
    my $inst_hier = $tokens[$#tokens-1];
    my $cell      = $tokens[$#tokens];
    $cell =~ s/\(|\)//g;
    
    my $hier = "";
    my $inst = $inst_hier;
    if ($inst_hier =~ /^(\S+)\/([^\s\/]+)$/) {
      $hier = $1;
      $inst = $2;
    }
    #$inst =~ s/_(\d+)_/[$1]/g;
    # Only change numbers at the end of the instance name to bit selects
    my @bits = ();
    while ($inst =~ /(_(\d+)_)$/) {
      my $match = $1;
      my $bit   = $2;

      unshift(@bits, $bit);
      $inst =~ s/\Q$match\E$//;
    }
    foreach my $bit (@bits) {
      $inst .= "[$bit]";
    }

    if (!defined $chains{$chain_name}) {
      $chains{$chain_name} = [];
    }
    $chains{$chain_name}[$chain_index] = { hier => $hier, inst => $inst, cell => $cell };
  }
  &Hydra::Util::File::close_file($fh_chain);

  if (defined $pattern_file) {
    # Pattern to register mode
    &Hydra::Util::File::print_unbuffered("INFO: Converting pattern to register...\n");

    # Create random sample pattern
    if ($create_pattern =~ /true|on|yes/i) {
      my $fh_create_pattern = &Hydra::Util::File::open_file_for_write($pattern_file);
      foreach my $chain_name (sort keys %chains) {
        my @values = ();
        foreach my $index (0..$#{ $chains{$chain_name} }) {
          push(@values, int(rand(2)));
        }
        
        my $pattern = join("", @values);
        print $fh_create_pattern "$chain_name : $pattern\n";
      }
      &Hydra::Util::File::close_file($fh_create_pattern);
    }

    # Read pattern file
    my $fh_pattern = &Hydra::Util::File::open_file_for_read($pattern_file);
    while (my $line = <$fh_pattern>) {
      if ($line =~ /^(\S+)\s*\:\s*(\S+)$/) {
        my $chain_name = $1;
        my $pattern    = $2;
        $patterns{$chain_name} = [];
        
        my @values = split(//, $pattern);
        $patterns{$chain_name} = \@values;

        if (!defined $chains{$chain_name}) {
          print "WARN: Skipping undefined chain $chain_name in pattern file\n";
          next;
        }

        if (scalar(@{ $chains{$chain_name} }) != scalar(@values)) {
          print "ERROR: Mismatched pattern count:\n";
          print "       Cells in chain $chain_name: " . scalar(@{ $chains{$chain_name} }) . "\n";
          print "       Values in pattern: " . scalar(@values) . "\n";
          die;
        }
      }
    }
    &Hydra::Util::File::close_file($fh_pattern);

    # Save pattern values
    foreach my $chain_name (sort keys %chains) {
      foreach my $index (0..$#{ $chains{$chain_name} }) {
        my $val  = $patterns{$chain_name}[$index];
        my $hier = $chains{$chain_name}[$index]{hier};
        my $inst = $chains{$chain_name}[$index]{inst};

        my ($inst_base, $aref_bits) = &parse_bit($inst);
        my $inst_hier = &get_inst_hier($hier, $inst_base);
        $buses{$inst_hier}{val} = [] if (!defined $buses{$inst_hier}{val});
        $buses{$inst_hier}{msb} = [] if (!defined $buses{$inst_hier}{msb});
        $buses{$inst_hier}{lsb} = [] if (!defined $buses{$inst_hier}{lsb});
        
        # Get bit msb and lsb for each level
        foreach my $bit_index (0..$#$aref_bits) {
          my $bit = $aref_bits->[$bit_index];
          if (!defined $buses{$inst_hier}{msb}[$bit_index] ||
              $bit > $buses{$inst_hier}{msb}[$bit_index]) {
            $buses{$inst_hier}{msb}[$bit_index] = $bit;
          }
          if (!defined $buses{$inst_hier}{lsb}[$bit_index] ||
              $bit < $buses{$inst_hier}{lsb}[$bit_index]) {
            $buses{$inst_hier}{lsb}[$bit_index] = $bit;
          }
        }

        &assign_bus_value(\${buses{$inst_hier}{val}}, $aref_bits, $val);
      }
    }

    # Fix missing values leaving bus structure with undef where an aref might be expected
    #   due to multiple dimensions
    foreach my $bus_name (keys %buses) {
      &repair_bus($buses{$bus_name}{val}, \@{ $buses{$bus_name}{msb} });
    }

    my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
    foreach my $bus_name (sort { &sort_buses } keys %buses) {
      my $val = &push_val($buses{$bus_name}{val});

      # Bits that dont matter are "X"
      # Remove all leading and trailing "X"s to fit in bit range, change all
      #   inbetween "X"s to 0s
      #$val =~ s/^X+//;
      #$val =~ s/X+$//;
      #$val =~ s/X/0/g;

      my $bit_range = "";
      foreach my $arr_dim (0..$#{ $buses{$bus_name}{msb} }) {
        my $msb = $buses{$bus_name}{msb}[$arr_dim];
        #my $lsb = $buses{$bus_name}{lsb}[$arr_dim];
        my $lsb = 0;
        $bit_range .= "[${msb}:${lsb}]";
      }

      my $hex = &convert_to_hex($val);
      printf $fh_out "${bus_name}${bit_range} = ${hex}\n";
    }
    &Hydra::Util::File::close_file($fh_out);
  }
  elsif (defined $register_file) {
    # Register to pattern mode
    &Hydra::Util::File::print_unbuffered("INFO: Converting register to pattern...\n");

    # Read register file
    my $fh_register = &Hydra::Util::File::open_file_for_read($register_file);
    while (my $line = <$fh_register>) {
      if ($line =~ /^(\S+)\s*\=\s*(\S+)/) {
        my $inst_entry = $1;
        my $hex_val    = $2;
        my $bin_val    = &convert_to_bin($hex_val);
        #my @values     = split(//, &convert_to_bin($hex_val));

        my $hier = "";
        my $inst = $inst_entry;
        if ($inst_entry =~ /^(\S+)\/([^\s\/]+)$/) {
          $hier = $1;
          $inst = $2;
        }

        # Check width of register against width of value
        # Remove leading zeroes and zero-pad if needed
        $bin_val =~ s/^0+//;
        $bin_val = "0" if ($bin_val eq "");
        my $num_bits = &get_num_bits($inst);
        if ($num_bits < length($bin_val)) {
          print "ERROR: Width of value does not match width of register!\n";
          print "       Register: $inst_entry ($num_bits bits)\n";
          print "       Value:    $hex_val (" . length($bin_val) . " bits)\n";
        }
        else {
          #$bin_val = sprintf("%0${num_bits}b", oct("0b$bin_val"));
          my $num_zeroes = $num_bits - length($bin_val);
          $bin_val = ("0" x $num_zeroes) . $bin_val;
        }
        my @values = split(//, $bin_val);

        # Save pattern values
        my ($inst_base, $aref_bits) = &parse_bit($inst);
        my $inst_hier = &get_inst_hier($hier, $inst_base);
        my $aaref_branches = &expand_bits($aref_bits);

        $buses{$inst_hier}{val} = [] if (!defined $buses{$inst_hier}{val});
        $buses{$inst_hier}{msb} = [] if (!defined $buses{$inst_hier}{msb});
        $buses{$inst_hier}{lsb} = [] if (!defined $buses{$inst_hier}{lsb});

        # Get bit msb and lsb for each level
        foreach my $aref_branch (@$aaref_branches) {
          foreach my $bit_index (0..$#$aref_branch) {
            my $bit = $aref_branch->[$bit_index];
            if (!defined $buses{$inst_hier}{msb}[$bit_index] ||
                $bit > $buses{$inst_hier}{msb}[$bit_index]) {
              $buses{$inst_hier}{msb}[$bit_index] = $bit;
            }
            if (!defined $buses{$inst_hier}{lsb}[$bit_index] ||
                $bit < $buses{$inst_hier}{lsb}[$bit_index]) {
              $buses{$inst_hier}{lsb}[$bit_index] = $bit;
            }
          }
        }

        if (scalar(@$aaref_branches) <= 0) {
          # Push undef to an empty branch list to signify a non-bus
          push(@$aaref_branches, undef);
        }

        foreach my $aref_branch (@$aaref_branches) {
          &assign_bus_value(\${buses{$inst_hier}{val}}, $aref_branch, shift @values);
        }
      }
    }
    &Hydra::Util::File::close_file($fh_register);

    # Gather bus values into chain pattern
    foreach my $chain_name (sort keys %chains) {
      my $pattern = "";
      foreach my $chain_index (0..$#{ $chains{$chain_name} }) {
        my $hier = $chains{$chain_name}[$chain_index]{hier};
        my $inst = $chains{$chain_name}[$chain_index]{inst};
        my ($inst_base, $aref_bits) = &parse_bit($inst);
        my $inst_hier = &get_inst_hier($hier, $inst_base);
        $pattern .= &get_bus_value(\${buses{$inst_hier}{val}}, $aref_bits);
      }

      my @values = split(//, $pattern);
      $patterns{$chain_name} = \@values;
    }

    # Print patterns for all chains
    my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
    foreach my $chain_name (sort keys %chains) {
      my $pattern = join("", @{ $patterns{$chain_name} });
      print $fh_out "$chain_name : $pattern\n";
    }
    &Hydra::Util::File::close_file($fh_out);
  }
}

sub push_val {
  my ($aref_bus) = @_;
  my $val = "";
  if (ref($aref_bus) ne "ARRAY") {
    return $aref_bus;
  }

  foreach my $ref_val (reverse @$aref_bus) {
    if (defined $ref_val) {
      if (ref($ref_val) eq "ARRAY") {
        $val .= &push_val($ref_val);
      }
      else {
        $val .= $ref_val;
      }
    }
    else {
      $val .= "0";
    }
  }

  return $val;
}

sub repair_bus {
  my ($aref_bus, $aref_msbs) = @_;
  return if (ref($aref_bus) ne "ARRAY");
  my $msb = shift @$aref_msbs;

  foreach my $index (reverse 0..$msb) {
    if (!defined $aref_bus->[$index]) {
      if (scalar(@$aref_msbs) > 0) {
        $aref_bus->[$index] = [];
      }
      else {
        $aref_bus->[$index] = undef;
      }
    }
    &repair_bus($aref_bus->[$index], $aref_msbs);
  }

  unshift(@$aref_msbs, $msb);
}

sub get_num_bits {
  my ($name) = @_;
  
  if ($name !~ /^\\/ && $name =~ /\[/) {
    if ($bit_blast) {
      # Combine only the last dimension
      if ($name =~ /\[(\d+)\:(\d+)\]$/) {
        my $num_bits = $1 - $2 + 1;
        return $num_bits;
      }
    }
    else {
      # Combine multiple dimensions
      my $num_bits = 1;
      while ($name =~ /(\[([\d\:]+)\])/g) {
        my $match = $1;
        my $bit   = $2;
        $name =~ s/\Q$match\E//;
        if ($bit =~ /(\d+)\:(\d+)/) {
          $num_bits *= $1 - $2 + 1;
        }
      }
      return $num_bits;
    }
  }

  return 1;
}

sub parse_bit {
  my ($name) = @_;
  my $ret_name     = $name;
  my $aref_ret_bit = undef;

  if ($name =~ /^\\/) {
    # Name is escaped, so there is no bit select
  }
  else {
    if ($bit_blast) {
      # Combine only the last dimension
      my @bits = ();
      if ($name =~ /(\[([\d\:]+)\])$/) {
        my $match = $1;
        my $bit   = $2;
        $ret_name =~ s/\Q$match\E//;
        push(@bits, $bit);
      }
      if (scalar(@bits) > 0) {
        $aref_ret_bit = \@bits;
      }
    }
    else {
      # Combine multiple dimensions
      my @bits = ();
      while ($name =~ /(\[([\d\:]+)\])/g) {
        my $match = $1;
        my $bit   = $2;
        $ret_name =~ s/\Q$match\E//;
        push(@bits, $bit);
      }
      if (scalar(@bits) > 0) {
        $aref_ret_bit = \@bits;
      }
    }
  }

  return ($ret_name, $aref_ret_bit);
}

sub expand_bits {
  my ($aref_bits, $index) = @_;
  $index = 0 if (!defined $index);
  my @bits     = ();
  my @branches = ();

  if (defined $aref_bits->[$index]) {
    my $bit = $aref_bits->[$index];
    if ($bit =~ /(\d+)\:(\d+)/) {
      my $msb = $1;
      my $lsb = $2;
      foreach my $expanded_bit (reverse $lsb..$msb) {
        push(@bits, $expanded_bit);
      }
    }
    else {
      push(@bits, $bit);
    }

    my $aaref_sub_branch = &expand_bits($aref_bits, $index+1);
    foreach my $bit (@bits) {
      if (scalar(@$aaref_sub_branch) > 0) {
        foreach my $aref_sub (@$aaref_sub_branch) {
          push(@branches, [$bit, @$aref_sub]);
        }
      }
      else {
        push(@branches, [$bit]);
      }
    }
  }
  
  return \@branches;
}

sub assign_values {
  my ($href_branches, $aref_values, $daref_bus) = @_;
  if (scalar(keys %$href_branches) <= 0) {
    $$daref_bus = shift @$aref_values;
    return;
  }
  
  foreach my $bit (sort { $b <=> $a } keys %$href_branches) {
    my $href_subbranch = $href_branches->{$bit};
    if (ref($href_subbranch) eq "HASH") {
      ${$daref_bus}->[$bit] = [] if (!defined ${$daref_bus}->[$bit]);
      &assign_values($href_subbranch, $aref_values, \${$daref_bus}->[$bit]);
    }
    elsif ($href_subbranch == 1) {
      ${$daref_bus}->[$bit] = shift @$aref_values;
    }
  }
}

sub convert_to_hex {
  my ($bin) = @_;
  my $hex = "";

  my @tokens = split(//, $bin);
  while (scalar(@tokens) > 0) {
    my $substr = "";
    while (length($substr) < 8 && scalar(@tokens) > 0) {
      $substr = pop(@tokens) . $substr;
    }
    $hex = sprintf("%02x", oct("0b$substr")) . $hex;
  }

  return $hex;
}

sub convert_to_bin {
  my ($hex) = @_;
  my $bin = "";

  $hex =~ s/^0x//;
  foreach my $char (reverse split(//, $hex)) {
    $bin = sprintf("%04b", oct("0x$char")) . $bin;
  }

  return $bin;
}

sub get_inst_hier {
  my ($hier, $inst) = @_;
  if ($hier eq "") {
    return $inst;
  }
  else {
    return "${hier}/${inst}";
  }
}

sub assign_bus_value {
  my ($daref_bus, $aref_bits, $value) = @_;
  my $sref_value = &find_bus($daref_bus, $aref_bits);
  $$sref_value = $value;
}

sub get_bus_value {
  my ($daref_bus, $aref_bits) = @_;
  my $sref_value = &find_bus($daref_bus, $aref_bits);
  return $$sref_value;
}

sub find_bus {
  my ($daref_bus, $aref_bits) = @_;
  my $daref_cur = $daref_bus;
  my $sref_value;

  if (defined $aref_bits) {
    # Find the array element corresponding to the indexes (bits) given
    foreach my $bit_index (0..$#$aref_bits) {
      my $bit = $aref_bits->[$bit_index];
      ${$daref_cur}->[$bit] = [] if (!defined ${$daref_cur}->[$bit]);
      $daref_cur = \${$daref_cur}->[$bit];
    }

    # Change the element to scalar if it is not already
    $$daref_cur = "" if (ref($$daref_cur) ne "");
    $sref_value = \${$daref_cur};
  }
  else {
    # For a non-bus, the original reference can just be a scalar
    $$daref_bus = "" if (ref($$daref_bus) ne "");
    $sref_value = \${$daref_bus};
  }

  return $sref_value;
}

sub sort_buses {
  return 0 if ($a eq $b);

  my @a_tokens = ();
  my @b_tokens = ();
  while ($a =~ /(\d+|[^\d]+)/g) {
    push(@a_tokens, $1);
  }
  while ($b =~ /(\d+|[^\d]+)/g) {
    push(@b_tokens, $1);
  }

  my $last_index;
  if (scalar(@a_tokens) < scalar(@b_tokens)) {
    $last_index = $#a_tokens;
  }
  else {
    $last_index = $#b_tokens;
  }

  foreach my $index (0..$last_index) {
    if ($a_tokens[$index] eq $b_tokens[$index]) {
      next;
    }
    elsif ($a_tokens[$index] =~ /\d+/ && $a_tokens[$index] =~ /\d+/) {
      return $b_tokens[$index] <=> $a_tokens[$index];
    }
    else {
      return $a_tokens[$index] cmp $b_tokens[$index];
    }
  }

  if (scalar(@a_tokens) < scalar(@b_tokens)) {
    return -1;
  }
  elsif (scalar(@a_tokens) > scalar(@b_tokens)) {
    return 1;
  }
  else {
    return 0;
  }
}

1;
