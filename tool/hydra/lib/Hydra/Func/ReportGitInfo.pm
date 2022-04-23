#------------------------------------------------------
# Module Name: ReportGitInfo
# Date:        Tue Apr 16 17:22:29 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::ReportGitInfo;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub report_git_info {
  my $aref_flist = &Hydra::Util::Option::get_opt_value_array("-rtl_flist", "strict");
  my $out_file   = &Hydra::Util::Option::get_opt_value_scalar("-out_file", "strict");
  my %hashes = ();
  my $repo_max_len = 0;

  print "INFO: Writing $out_file report...\n";

  # Check flist for TCL environment variable usage
  my @processed_flists = ();
  foreach my $flist (@$aref_flist) {
    push(@processed_flists, &Hydra::Util::File::resolve_env($flist));
  }
  
  my @all_files = ();
  foreach my $flist (@processed_flists) {
    my ($aref_files, $aref_incdirs) = &Hydra::Util::File::expand_file_list($flist);
    push(@all_files, @$aref_files);
    # Get git commit hash for every rtl file
    # foreach my $file_path (@$aref_files) {
    #   my ($file_repo, $file_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($file_path));
    #   if (defined $file_repo && defined $file_hash && defined $date) {
    #     $hashes{$file_repo} = $file_hash;
    #     if ($repo_max_len < length($file_repo)) {
    #       $repo_max_len = length($file_repo);
    #     }
    #   }
    # }

    # Check flist dir for git hash
    my ($file_repo, $file_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($flist));
    if (defined $file_repo && defined $file_hash && defined $date) {
      $hashes{$file_repo} = $file_hash;
      if ($repo_max_len < length($file_repo)) {
        $repo_max_len = length($file_repo);
      }
    }
  }

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

  my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
  print $fh_out "# Git Hashes\n";
  foreach my $repo_name (sort keys %hashes) {
    printf $fh_out "# %-${repo_max_len}s %s\n", $repo_name, $hashes{$repo_name};
  }
  foreach my $file_path (@all_files) {
    print $fh_out "$file_path\n";
  }
  &Hydra::Util::File::close_file($fh_out);
}

sub report_regr_build_id {
  my $aref_flist = &Hydra::Util::Option::get_opt_value_array("-rtl_flist", "strict");
  my %hashes = ();

  # Check flist for TCL environment variable usage
  my @processed_flists = ();
  foreach my $flist (@$aref_flist) {
    push(@processed_flists, &Hydra::Util::File::resolve_env($flist));
  }

  my @all_files = ();
  foreach my $flist (@processed_flists) {
    my ($aref_files, $aref_incdirs) = &Hydra::Util::File::expand_file_list($flist);
    push(@all_files, @$aref_files);
    foreach my $file_path (@$aref_files) {
      my ($file_repo, $file_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($file_path));
      if (defined $file_repo && defined $file_hash && defined $date) {
        $hashes{$file_repo} = $file_hash;
      }
    }
  }

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

  my $build_id = "";
  foreach my $repo_name (sort keys %hashes) {
    $build_id .= "${repo_name}:$hashes{$repo_name},";
  }
  $build_id =~ s/,$//;

  print $build_id;
}

1;
