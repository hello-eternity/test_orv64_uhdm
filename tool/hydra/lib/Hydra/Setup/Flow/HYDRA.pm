#------------------------------------------------------
# Module Name: HYDRA
# Date:        Wed Jan 30 11:22:34 2019
# Author:      kvu
# Type:        hydra
#------------------------------------------------------
package Hydra::Setup::Flow::HYDRA;

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

#------------------------------------------------------
# Subroutines
#------------------------------------------------------

#++
# Tool: hydra
# Flow: PNR_INIT_LIBRARY
#--
sub PNR_INIT_LIBRARY {
  my ($Paramref) = @_;
  return &INIT_LIBRARY($Paramref, "pnr");
}

sub INIT_LIBRARY {
  my ($Paramref, $run_type, $sub_type) = @_;
  my $File = new Hydra::Setup::File("script/${run_type}_init_library.tcl", $run_type, $sub_type);
  &INIT_LIBRARY_LIB($Paramref, $File);
  &INIT_LIBRARY_NDM($Paramref, $File);
  &INIT_LIBRARY_GDS($Paramref, $File);
  return $File;
}

sub INIT_LIBRARY_BLOCK {
  my ($Paramref, $run_type, $sub_type) = @_;
  my $File = new Hydra::Setup::File("script/${run_type}_init_library.tcl", $run_type, $sub_type);
  &INIT_LIBRARY_LIB_BLOCK($Paramref, $File);
  &INIT_LIBRARY_NDM($Paramref, $File);
  &INIT_LIBRARY_GDS($Paramref, $File);
  return $File;
}

sub INIT_LIBRARY_LIB {
  my ($Paramref, $File) = @_;
  my $line = "";

  # LIB and DB
  foreach my $lib_type (qw(LIB DB)) {
    # HYDRA_PARSE: $lib_type = LIB DB
    my @all_keysets = ();
    push(@all_keysets, $Paramref->get_param_keysets("${lib_type}_std_list", 2));
    push(@all_keysets, $Paramref->get_param_keysets("${lib_type}_macro_list", 2));

    # Remove duplicate keysets
    my %found = ();
    my @keysets = ();
    foreach my $aref_keys (@all_keysets) {
      if (!defined $found{md5_hex(@$aref_keys)}) {
        push(@keysets, $aref_keys);
        $found{md5_hex(@$aref_keys)} = 1;
      }
    }

    foreach my $aref_keys (@keysets) {
      my ($process, $temp) = @$aref_keys;
      my $std_value = $Paramref->get_param_value("${lib_type}_std_list", "relaxed", @$aref_keys);
      $std_value = &Hydra::Setup::Param::remove_param_value_linebreak($std_value);
      $std_value = &Hydra::Setup::Param::remove_param_value_indent($std_value);
      my $macro_value = $Paramref->get_param_value("${lib_type}_macro_list", "relaxed", @$aref_keys);
      $macro_value = &Hydra::Setup::Param::remove_param_value_linebreak($macro_value);
      $macro_value = &Hydra::Setup::Param::remove_param_value_indent($macro_value);

      $line .= "set $lib_type(${process},${temp}) {\n";
      if (&Hydra::Setup::Param::has_value($std_value)) {
        foreach my $file (split(/\s+/, $std_value)) {
          $line .= "$file \\\n";
        }
      }
      if (&Hydra::Setup::Param::has_value($macro_value)) {
        foreach my $file (split(/\s+/, $macro_value)) {
          $line .= "$file \\\n";
        }
      }
      $line .= "}\n";
      $line .= "\n";
    }
  }

  $File->add_line($line);
}

sub INIT_LIBRARY_LIB_BLOCK {
  my ($Paramref, $File) = @_;
  my $line = "";

  # LIB and DB
  foreach my $lib_type (qw(LIB DB)) {
    # HYDRA_PARSE: $lib_type = LIB DB
    my @all_keysets = ();
    push(@all_keysets, $Paramref->get_param_keysets("${lib_type}_std_list", 2));
    push(@all_keysets, $Paramref->get_param_keysets("${lib_type}_macro_list", 2));
    if ($Paramref->has_param_keysets("${lib_type}_block_list", 2)) {
      # Allow block list to have no keys
      push(@all_keysets, $Paramref->get_param_keysets("${lib_type}_block_list", 2));
    }

    # Remove duplicate keysets
    my %found = ();
    my @keysets = ();
    foreach my $aref_keys (@all_keysets) {
      if (!defined $found{md5_hex(@$aref_keys)}) {
        push(@keysets, $aref_keys);
        $found{md5_hex(@$aref_keys)} = 1;
      }
    }

    foreach my $aref_keys (@keysets) {
      my ($process, $temp) = @$aref_keys;
      my $std_value = $Paramref->get_param_value("${lib_type}_std_list", "relaxed", @$aref_keys);
      $std_value = &Hydra::Setup::Param::remove_param_value_linebreak($std_value);
      $std_value = &Hydra::Setup::Param::remove_param_value_indent($std_value);
      my $macro_value = $Paramref->get_param_value("${lib_type}_macro_list", "relaxed", @$aref_keys);
      $macro_value = &Hydra::Setup::Param::remove_param_value_linebreak($macro_value);
      $macro_value = &Hydra::Setup::Param::remove_param_value_indent($macro_value);
      my $block_value = $Paramref->get_param_value("${lib_type}_block_list", "relaxed", @$aref_keys);
      $block_value = &Hydra::Setup::Param::remove_param_value_linebreak($block_value);
      $block_value = &Hydra::Setup::Param::remove_param_value_indent($block_value);

      $line .= "set $lib_type(${process},${temp}) {\n";
      if (&Hydra::Setup::Param::has_value($std_value)) {
        foreach my $file (split(/\s+/, $std_value)) {
          $line .= "$file \\\n";
        }
      }
      if (&Hydra::Setup::Param::has_value($macro_value)) {
        foreach my $file (split(/\s+/, $macro_value)) {
          $line .= "$file \\\n";
        }
      }
      if (&Hydra::Setup::Param::has_value($block_value)) {
        foreach my $file (split(/\s+/, $block_value)) {
          $line .= "$file \\\n";
        }
      }
      $line .= "}\n";
      $line .= "\n";
    }
  }

  $File->add_line($line);
}


sub INIT_LIBRARY_NDM {
  my ($Paramref, $File) = @_;
  my $line = "";

  # NDM
  my $ndm_std_value   = $Paramref->get_param_value("NDM_std_list", "relaxed");
  my $ndm_macro_value = $Paramref->get_param_value("NDM_macro_list", "relaxed");
  $ndm_std_value   = &Hydra::Setup::Param::remove_param_value_linebreak($ndm_std_value);
  $ndm_std_value   = &Hydra::Setup::Param::remove_param_value_indent($ndm_std_value);
  $ndm_macro_value = &Hydra::Setup::Param::remove_param_value_linebreak($ndm_macro_value);
  $ndm_macro_value = &Hydra::Setup::Param::remove_param_value_indent($ndm_macro_value);

  $line .= "set NDM {\n";
  if (&Hydra::Setup::Param::has_value($ndm_std_value)) {
    foreach my $file (split(/\s+/, $ndm_std_value)) {
      $line .= "$file \\\n";
    }
  }
  if (&Hydra::Setup::Param::has_value($ndm_macro_value)) {
    foreach my $file (split(/\s+/, $ndm_macro_value)) {
      $line .= "$file \\\n";
    }
  }
  $line .= "}\n";
  $line .= "\n";

  $File->add_line($line);
}

sub INIT_LIBRARY_GDS {
  my ($Paramref, $File) = @_;
  my $line = "";

  # GDS
  my $std_gds   = $Paramref->get_param_value("GDS_std_list", "relaxed");
  $std_gds = &Hydra::Setup::Param::remove_param_value_linebreak($std_gds);
  $std_gds = &Hydra::Setup::Param::remove_param_value_indent($std_gds);
  my $macro_gds = $Paramref->get_param_value("GDS_macro_list", "relaxed");
  $macro_gds = &Hydra::Setup::Param::remove_param_value_linebreak($macro_gds);
  $macro_gds = &Hydra::Setup::Param::remove_param_value_indent($macro_gds);
  my $block_gds = $Paramref->get_param_value("GDS_block_list", "relaxed");
  $block_gds = &Hydra::Setup::Param::remove_param_value_linebreak($block_gds);
  $block_gds = &Hydra::Setup::Param::remove_param_value_indent($block_gds);

  $line .= "set GDS {\n";
  if (&Hydra::Setup::Param::has_value($std_gds)) {
    foreach my $file (split(/\s+/, $std_gds)) {
      $line .= "$file \\\n";
    }
  }
  if (&Hydra::Setup::Param::has_value($macro_gds)) {
    foreach my $file (split(/\s+/, $macro_gds)) {
      $line .= "$file \\\n";
    }
  }
  $line .= "}\n";
  $line .= "\n";

  $line .= "set GDS_FULLCHIP {\n";
  if (&Hydra::Setup::Param::has_value($std_gds)) {
    foreach my $file (split(/\s+/, $std_gds)) {
      $line .= "$file \\\n";
    }
  }
  if (&Hydra::Setup::Param::has_value($macro_gds)) {
    foreach my $file (split(/\s+/, $macro_gds)) {
      $line .= "$file \\\n";
    }
  }
  if (&Hydra::Setup::Param::has_value($block_gds)) {
    foreach my $file (split(/\s+/, $block_gds)) {
      $line .= "$file \\\n";
    }
  }
  $line .= "}\n";
  $line .= "\n";

  $File->add_line($line);
}

sub add_rtl_to_lib {
  my ($File, $aref_flists, $var_name) = @_;
  $var_name = "RTL" if (!defined $var_name);
  my %hashes = ();
  my $repo_max_len = 0;
  my $line = "set $var_name {\n";

  # Check flist for TCL environment variable usage
  my @processed_flists = ();
  foreach my $flist (@$aref_flists) {
    push(@processed_flists, &Hydra::Util::File::resolve_env($flist));
  }

  foreach my $flist (@processed_flists) {
    my ($aref_files, $aref_incdirs) = &Hydra::Util::File::expand_file_list($flist);
    foreach my $file (@$aref_files) {
      # Get git commit hash for every rtl file
      # my ($file_repo, $file_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($file));
      # if (defined $file_repo && defined $file_hash && defined $date) {
      #   $hashes{$file_repo} = $file_hash;
      #   if ($repo_max_len < length($file_repo)) {
      #     $repo_max_len = length($file_repo);
      #   }
      # }
      
      $line .= "$file \\\n";
    }

    # Check flist dir for git hash
    my ($file_repo, $file_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($flist));
    if (defined $file_repo && defined $file_hash && defined $date) {
      $hashes{$file_repo} = $file_hash;
      if ($repo_max_len < length($file_repo)) {
        $repo_max_len = length($file_repo);
      }
    }
  }

  $line .= "}\n";
  $line .= "\n";

  # If no hashes were found, then check the flist
  if (scalar(keys %hashes) <= 0) {
    foreach my $flist (@processed_flists) {
      my $fh_flist = &Hydra::Util::File::open_file_for_read($flist);
      while (my $line = <$fh_flist>) {
        if ($line =~ /^\/\/ (\S+) ([a-f0-9]{40})\s*$/) {
          $hashes{$1} = $2;
        }
      }
      &Hydra::Util::File::close_file($fh_flist);
    }
  }

  # Print filelists
  my $flist_line = "# File Lists\n";
  foreach my $flist (@processed_flists) {
    $flist_line .= "# $flist\n";
  }

  my $hash_line = "# Git Hashes\n";
  foreach my $repo_name (sort keys %hashes) {
    $hash_line .= sprintf "# %-${repo_max_len}s %s\n", $repo_name, $hashes{$repo_name};
  }
  
  $File->add_line($flist_line . $hash_line . $line);
}

sub get_lib_var {
  my ($Paramref, $lib_type, $process, $temp) = @_;
  $lib_type = uc($lib_type);

  my $std_value   = $Paramref->get_param_value("${lib_type}_std_list", "relaxed", ($process, $temp));
  my $macro_value = $Paramref->get_param_value("${lib_type}_macro_list", "relaxed", ($process, $temp));
  if (!&Hydra::Setup::Param::has_value($std_value) && !&Hydra::Setup::Param::has_value($macro_value)) {
    &Hydra::Setup::Control::register_error_param("${lib_type}_std_list: ($process)($temp) keys expected", "key");
    &Hydra::Setup::Control::register_error_param("${lib_type}_macro_list: ($process)($temp) keys expected", "key");
    return "";
  }
  else {
    return "${lib_type}(${process},${temp})";
  }
}

1;
