#------------------------------------------------------
# Module Name: Param
# Date:        Mon Jan 28 12:21:04 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Setup::Param;

use strict;
use warnings;
use Carp;
use Exporter;
use Digest::MD5 qw(md5_hex);

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our %glb_global_whitelist   = (
  "GLOBAL_design" => 1,
    );

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, @param_files) = @_;
  my $self = {
    type       => "param",
    params     => {},
    pbackups   => {},
    param_file => \@param_files,
  };
  bless $self, $class;

  foreach my $param_file (@param_files) {
    $self->parse_param_file($param_file);
  }

  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_param_value {
  my ($self, $param_name, $mode, @keys) = @_;
  if (scalar(@keys) <= 0) {
    @keys = qw(default);
  }
  $mode = "relaxed" if (!defined $mode);

  # Check for exact key match
  #print "looking for $param_name keys: @keys\n";
  my $return_value = $self->do_get_param_value($param_name, $mode, @keys);
  #print "value: $return_value\n";

  # Check for default key match if return value is invalid
  if (!&has_value($return_value) && $keys[0] ne "default") {
    #print "looking for default key of $param_name\n";
    $return_value = $self->do_get_param_value($param_name, $mode, ("default"));
    #print "value: $return_value\n";
  }

  # Change error type from HYDRA_KEY to HYDRA_NOKEY if the requested keyset is default and
  #   it was not found, implying that the param has keyed versions but no non-keyed version
  if ($return_value =~ /^HYDRA_KEY$/ && scalar(@keys) == 1 && $keys[0] eq "default") {
    $return_value = "HYDRA_NOKEY";
  }

  # If mode is not strict, then downgrade error tags
  if ($mode ne "strict" && $return_value =~ /HYDRA_VALUE|HYDRA_REQUIRED|HYDRA_KEY|HYDRA_NOKEY/) {
    $return_value = "";
  }

  # If mode is not strict and error tag is HYDRA_MISSING, remove keys so that
  # error is set to non-keyed param
  if ($mode ne "strict" && $return_value =~ /HYDRA_MISSING/) {
    @keys = ("default");
  }
  
  # Check for global params
  while ($return_value =~ /(<(\S+?)>)/g) {
    my $global_directive = $1;
    my $global_name      = $2;
    if (&is_global_param($global_name)) {
      my $global_value = $self->do_get_global_param_value($global_name, "strict");

      if (defined $global_value) {
        $return_value =~ s/${global_directive}/${global_value}/;
      }
      else {
        warn "WARN: Value for global param=${global_name} within param=${param_name} not found\n";
      }
    }
    else {
      warn "WARN: Global param=${global_name} within param=${param_name} is not a valid global\n";
    }
  }

  # Check for error param tag
  if ($return_value =~ /^HYDRA_(\S+)$/) {
    my $error_type = lc($1);
    #if ($error_type eq "key") {
      my $key_string = "";
      foreach my $key (@keys) {
        if ($key ne "default") {
          $key_string .= "($key)";
        }
      }
      #my $error_string = "$param_name: @keys";
      my $error_string = "${param_name}${key_string}";
      &Hydra::Setup::Control::register_error_param($error_string, $error_type);
    #}
    #else {
    #  &Hydra::Setup::Control::register_error_param($param_name, $error_type);
    #}
  }

  return $return_value;
}

sub do_get_param_value {
  my ($self, $param_name, $mode, @keys) = @_;
  
  if (!defined $self->{params}{$param_name}) {
    if (defined $self->{Parent}) {
      # Cant find param at all; try parent
      return $self->{Parent}->do_get_param_value($param_name, $mode, @keys);
    }
    else {
      # Param is missing
      return "HYDRA_MISSING";
    }
  }

  my $param_value = $self->do_get_param_value_keys($self->{params}{$param_name}, $mode, @keys);
  if (&has_value($param_value)) {
    if ($param_value =~ /^\s*<required>\s*$/) {
      if (defined $self->{Parent} && $mode eq "strict") {
        # Param value is <required> tag and mode is strict; try parent
        return $self->{Parent}->do_get_param_value($param_name, $mode, @keys);
      }
      else {
        # Param has <required> tag
        return "HYDRA_REQUIRED";
      }
    }
  }
  else {
    if ($param_value eq "HYDRA_KEY") {
      if (defined $self->{Parent}) {
        # Cant find param with specified keys; try parent
        return $self->{Parent}->do_get_param_value($param_name, $mode, @keys);
      }
      else {
        # Specified keys could not be found
        return "HYDRA_KEY";
      }
    }
    else {
      if (defined $self->{Parent} && $mode eq "strict") {
        # Param value is empty and mode is strict; try parent
        return $self->{Parent}->do_get_param_value($param_name, $mode, @keys);
      }
      else {
        # Param has no value
        return "HYDRA_VALUE";
      }
    }
  }
  
  return $param_value;
  

  # if ($param_value eq "HYDRA_KEY") {
  #   if (defined $self->{Parent}) {
  #     # Cant find param with specified keys; try parent
  #     return $self->{Parent}->do_get_param_value($param_name, $mode, @keys);
  #   }
  #   else {
  #     return $param_value;
  #   }
  # }
  # elsif ($mode eq "strict" && !&has_value($param_value) && !defined $self->{Parent}) {
  #   # The param (with keys) was found, but there is no value and no parent; param needs a value
  #   return "HYDRA_VALUE";
  # }
  # elsif ($param_value =~ /^\s*<required>\s*$/) {
  #   # Param required tag must be removed
  #   return "HYDRA_REQUIRED";
  # }

  #return $param_value;
}

# sub bak_do_get_param_value {
#   my ($self, $param_name, $mode, @keys) = @_;

#   if (defined $self->{params}{$param_name}) {
#     my $param_value = $self->do_get_param_value_keys($self->{params}{$param_name}, $mode, @keys);
#     if (defined $mode && $mode eq "strict") {
#       if (&Hydra::Setup::Param::has_value($param_value)) {
#         if ($param_value =~ /^\s*<required>\s*$/) {
#           return "HYDRA_REQUIRED";
#         }
#       }
#       else {
#         return "HYDRA_VALUE";
#       }
#     }
#     return $param_value;
#   }
#   else {
#     if (defined $self->{Parent}) {
#       return $self->{Parent}->do_get_param_value($param_name, $mode, @keys);
#     }
#     else {
#       return "HYDRA_MISSING";
#     }
#   }
# }

sub do_get_param_value_keys {
  my ($self, $href_param, $mode, @keys) = @_;
  if (defined $href_param->{md5_hex(@keys)}) {
    # Return exact key match
    return $href_param->{md5_hex(@keys)}{value};
  }
  # elsif (defined $href_param->{md5_hex(("default"))}) {
  #   # Return default key
  #   return $href_param->{md5_hex(("default"))}{value};
  # }
  # elsif ($mode eq "strict") {
  #   # Missing param value for this key set
  #   return "HYDRA_KEY";
  # }
  # else {
  #   return "";
  # }
  else {
    return "HYDRA_KEY";
  }
}

sub do_get_global_param_value {
  my ($self, $param_name, $mode) = @_;
  
  if (defined $self->{params}{$param_name}) {
    my $param_value = $self->{params}{$param_name}{md5_hex(("default"))}{value};
    if (defined $mode && $mode eq "strict") {
      if (&Hydra::Setup::Param::has_value($param_value)) {
        if ($param_value =~ /^\s*<required>\s*$/) {
          return undef;
        }
        else {
          return $param_value;
        }
      }
      else {
        return undef;
      }
    }
    else {
      return $param_value;
    }
  }
  else {
    if (defined $self->{Parent}) {
      return $self->{Parent}->do_get_global_param_value($param_name, $mode);
    }
    else {
      return undef;
    }
  }
}

sub has_param_keysets {
  my ($self, $param_name, $expected_num_keys) = @_;
  
  if (defined $self->{params}{$param_name}) {
    foreach my $id (keys %{ $self->{params}{$param_name} }) {
      next if ($id eq md5_hex(("default")));
      if (defined $expected_num_keys && scalar(@{ $self->{params}{$param_name}{$id}{keys} }) == $expected_num_keys) {
        return 1;
      }
      elsif (!defined $expected_num_keys && scalar(@{ $self->{params}{$param_name}{$id}{keys} }) > 0) {
        return 1;
      }
      # if (scalar(@{ $self->{params}{$param_name}{$id}{keys} }) > 0) {
      #   return 1;
      # }
    }
  }

  if (defined $self->{Parent}) {
    return $self->{Parent}->has_param_keysets($param_name, $expected_num_keys);
  }

  return 0;
}

sub get_param_keysets {
  my ($self, $param_name, $expected_num_keys) = @_;
  my @return_value = $self->do_get_param_keysets($param_name, $expected_num_keys);

  # Check for error param tag
  # foreach my $key (@return_value) {
  #   if ($key =~ /^HYDRA_(\S+)$/) {
  #     my $error_type = lc($1);
  #     &Hydra::Setup::Control::register_error_param($param_name, $error_type);
  #   }
  # }

  if (scalar(@return_value) <= 0) {
    # Param is missing if no keysets were found
    &Hydra::Setup::Control::register_error_param($param_name, "missing");
  }
  else {
    # Remove duplicate keysets
    my @keys = ();
    my %seen = ();
    foreach my $aref_keys (@return_value) {
      if (!defined $seen{md5_hex(@$aref_keys)}) {
        push(@keys, $aref_keys);
        $seen{md5_hex(@$aref_keys)} = 1;
      }
    }
    @return_value = @keys;
  }

  return @return_value;
}

sub do_get_param_keysets {
  my ($self, $param_name, $expected_num_keys) = @_;
  my @keysets = ();

  if (defined $self->{params}{$param_name}) {
    #foreach my $id (keys %{ $self->{params}{$param_name} }) {
    foreach my $id (sort { $self->{params}{$param_name}{$a}{index} <=> $self->{params}{$param_name}{$b}{index} } keys %{ $self->{params}{$param_name} }) {
      # Skip default keyset
      next if ($id eq md5_hex(("default")));

      if (defined $expected_num_keys && scalar(@{ $self->{params}{$param_name}{$id}{keys} }) != $expected_num_keys) {
        my $key_string = "";
        foreach my $key (@{ $self->{params}{$param_name}{$id}{keys} }) {
          if ($key ne "default") {
            $key_string .= "($key)";
          }
        }
        my $error_string = "${param_name}${key_string} ; $expected_num_keys keys expected";
        &Hydra::Setup::Control::register_error_param($error_string, "numkey");
      }
      else {
        push(@keysets, $self->{params}{$param_name}{$id}{keys});
      }
    }
  }

  if (defined $self->{Parent}) {
    #push(@keysets, $self->{Parent}->do_get_param_keysets($param_name, $expected_num_keys));

    # Parent keysets should take precedence over child keysets
    unshift(@keysets, $self->{Parent}->do_get_param_keysets($param_name, $expected_num_keys));
  }

  return @keysets;
}

# sub do_get_param_keysets {
#   my ($self, $param_name, $expected_num_keys) = @_;

#   if (defined $self->{params}{$param_name}) {
#     my @keysets = ();
#     foreach my $id (keys %{ $self->{params}{$param_name} }) {
#       if (defined $expected_num_keys && scalar(@{ $self->{params}{$param_name}{$id}{keys} }) != $expected_num_keys) {
#         my $key_string = "";
#         foreach my $key (@{ $self->{params}{$param_name}{$id}{keys} }) {
#           if ($key ne "default") {
#             $key_string .= "($key)";
#           }
#         }
#         #my $error_string = "$param_name: @{ $self->{params}{$param_name}{$id}{keys} } ; $expected_num_keys expected";
#         my $error_string = "${param_name}${key_string} ; $expected_num_keys keys expected";
#         &Hydra::Setup::Control::register_error_param($error_string, "numkey");
#       }
#       else {
#         push(@keysets, $self->{params}{$param_name}{$id}{keys});
#       }
#     }

#     return @keysets;
#   }
#   else {
#     if (defined $self->{Parent}) {
#       return $self->{Parent}->do_get_param_keysets($param_name, $expected_num_keys);
#     }
#     else {
#       # Missing param
#       &Hydra::Setup::Control::register_error_param($param_name, "missing");
#       return ();
#     }
#   }
# }

sub get_params {
  my ($self) = @_;
  return $self->{params};
}

sub get_param_file {
  my ($self) = @_;
  return $self->{param_file};
}

sub get_type {
  my ($self) = @_;
  return $self->{type};
}

sub has_value {
  my ($param_value) = @_;
  if (!defined $param_value || $param_value =~ /^\s*$/ || $param_value =~ /^\s*HYDRA_/) {
    return 0;
  }
  else {
    return 1;
  }
}

sub is_global_param {
  my ($param_name) = @_;
  return (defined $glb_global_whitelist{$param_name});
}

sub get_parent {
  my ($self) = @_;
  return $self->{Parent};
}

#------------------------------------------------------
# Parser
#------------------------------------------------------
sub parse_param_file {
  my ($self, $param_file) = @_;
  my $href_params = $self->get_params;

  my @lines = &Hydra::Util::File::slurp_file_into_array($param_file);
  &parse_param_block($href_params, \@lines);
}

sub parse_param_block {
  my ($href_params, $aref_lines) = @_;
  return if (!defined $aref_lines);

  # Add empty line to avoid case where a linebreak at the end of file causes
  #   the whole param to not be processed
  my @lines = @$aref_lines;
  push(@lines, "");

  my $full_line = "";
  foreach my $line (@lines) {
    $line =~ s/\#.*//g;
    $full_line .= $line;
    next if ($line =~ /\\\s*$/);

    chomp($full_line);
    $full_line =~ s/\s*$//;
    if ($full_line =~ /^\s*(\S+)\s*\=\s*(.*)\s*$/s) {
      my $param_name  = $1;
      my $param_value = $2;

      if ($param_name =~ /^\s*([^\s\(\)]+)(\(.*)/) {
        # Param name is a dictionary, store using keys as md5 hash
        my $base_name  = $1;
        my $key_string = $2;
        
        # Get all keys
        $key_string =~ s/^\(//;
        $key_string =~ s/\)$//;
        $key_string =~ s/\(|\)/:/g;
        my @keys = split(/\:+/, $key_string);

        # Generate md5 for this param with this set of keys
        my $md5 = md5_hex(@keys);

        # Determine index value to preserve order in which keys are defined
        my $index = -1;
        if (defined $href_params->{$base_name}) {
          foreach my $id (keys %{ $href_params->{$base_name} }) {
            if ($href_params->{$base_name}{$id}{index} > $index) {
              $index = $href_params->{$base_name}{$id}{index};
            }
          }
          $index++;
        }

        # Warn if param is being overwritten
        if (defined $href_params->{$base_name}{$md5}{value}) {
          print "WARN: param=${param_name} was redefined in the same scope\n";
        }

        # Store param
        $href_params->{$base_name}{$md5}{value} = $param_value;
        $href_params->{$base_name}{$md5}{keys}  = \@keys;
        $href_params->{$base_name}{$md5}{index} = $index;
      }
      else {
        # Regular param name

        # Generate md5 for this param with the default key
        my @keys = qw(default);
        my $md5 = md5_hex(@keys);

        # Determine index value to preserve order in which keys are defined
        my $index = -1;
        if (defined $href_params->{$param_name}) {
          foreach my $id (keys %{ $href_params->{$param_name} }) {
            if ($href_params->{$param_name}{$id}{index} > $index) {
              $index = $href_params->{$param_name}{$id}{index};
            }
          }
          $index++;
        }

        # Warn if param is being overwritten
        if (defined $href_params->{$param_name}{$md5}{value}) {
          print "WARN: param=${param_name} was redefined in the same scope\n";
        }

        # Store param
        $href_params->{$param_name}{$md5}{value} = $param_value;
        $href_params->{$param_name}{$md5}{keys}  = \@keys;
        $href_params->{$param_name}{$md5}{index} = $index;
      }
    }

    $full_line = "";
  }
}

#------------------------------------------------------
# Class Methods
#------------------------------------------------------
sub remove_param_value_indent {
  my ($param_value) = @_;
  $param_value =~ s/\n\s*(\S)/\n${1}/g;
  return $param_value;
}

sub remove_param_value_linebreak {
  my ($param_value) = @_;
  $param_value =~ s/(\n|\\)/ /g;
  $param_value =~ s/^\s*//;
  $param_value =~ s/\s*$//;
  return $param_value;
}

sub is_on {
  my ($param_value) = @_;
  if (!defined $param_value ||
      $param_value =~ /^HYDRA_(\S+)$/ ||
      $param_value =~ /^\s*$/ ||
      $param_value =~ /^\s*(off|false|0|no)\s*$/i) {
    return 0;
  }
  else {
    return 1;
  }
}

sub is_default_key {
  my ($param_value) = @_;
  if (!defined $param_value || $param_value =~ /^\s*default\s*$/) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_global_param_list {
  return sort keys %glb_global_whitelist;
}

1;
