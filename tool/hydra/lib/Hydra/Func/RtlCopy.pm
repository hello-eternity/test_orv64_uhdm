#------------------------------------------------------
# Module Name: RtlCopy
# Date:        Thu Apr 11 14:27:03 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::RtlCopy;

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
sub rtl_copy {
  my $flist   = &Hydra::Util::Option::get_opt_value_scalar("-rtl_flist", "strict");
  my $working_dir = cwd;

  # Add cwd to flist if there is none
  if ($flist !~ /\//) {
    $flist = "${working_dir}/${flist}";
  }

  if (!-f $flist) {
    die "ERROR: rtl flist does not exist!\n";
  }

  my %git_hashes = ();
  my $repo_max_len = 0;
  my ($repo_name, $flist_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($flist));

  if (!defined $repo_name || !defined $flist_hash || !defined $date) {
    #die "ERROR: rtl flist is not within a git repo!\n";
    warn "WARN: rtl flist is not within a recognizable git repo...\n";
    warn "      rtl_copy will use generic names\n";
    
    $repo_name  = "no-repo" if (!defined $repo_name);
    $flist_hash = "no-hash" if (!defined $flist_hash);
    $date       = "no-date" if (!defined $date);
  }

  $git_hashes{$repo_name} = $flist_hash;
  if ($repo_max_len < length($repo_name)) {
    $repo_max_len = length($repo_name);
  }

  # Get block name
  &Hydra::Util::File::get_file_name_from_path($flist) =~ /^(\S+?)\./;
  my $block_name = $1;

  my $copy_dir = "${block_name}__${date}";
  &Hydra::Util::File::make_dir($copy_dir);
  chdir $copy_dir;

  my $dir = cwd;
  my ($aref_files, $aref_incdirs) = &Hydra::Util::File::expand_file_list($flist);

  my @copied_files = ();
  my $fh_flist     = &Hydra::Util::File::open_file_for_write(&Hydra::Util::File::get_file_name_from_path($flist));
  foreach my $file_path (@$aref_files) {
    # Get git hash for each individual file
    # my ($file_repo, $file_hash, $file_date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($file_path));
    # if (defined $file_repo && defined $file_hash && defined $date) {
    #   if (defined $git_hashes{$file_repo} && $git_hashes{$file_repo} ne $file_hash) {
    #     warn "WARN: Unmatching git hash found for repo $file_repo\n";
    #   }
    #   $git_hashes{$file_repo} = $file_hash;
    #   if ($repo_max_len < length($file_repo)) {
    #     $repo_max_len = length($file_repo);
    #   }
    # }

    # Copy every file to the copy dir
    my $file_name = &Hydra::Util::File::get_file_name_from_path($file_path);
    push(@copied_files, "${dir}/${file_name}");
    system("cp -p $file_path ./");
    &find_include_files("${dir}/${file_name}", $aref_incdirs);
  }

  # Print all git hashes
  print $fh_flist "// Git Hashes\n";
  foreach my $repo (sort keys %git_hashes) {
    printf $fh_flist "// %-${repo_max_len}s %s\n", $repo, $git_hashes{$repo};
  }

  # Print the new flist
  foreach my $file (@copied_files) {
    print $fh_flist "$file\n";
  }

  &Hydra::Util::File::close_file($fh_flist);

  chdir $working_dir;
}

sub find_include_files {
  my ($file, $aref_incdirs) = @_;

  my @incfiles = ();
  my $fh_out   = &Hydra::Util::File::open_file_for_write(".tmp_file");
  my $fh_in    = &Hydra::Util::File::open_file_for_read($file);
  while (my $line = <$fh_in>) {
    next if ($line =~ /^\s*\/\//);

    if ($line =~ /\`include\s+\"(\S+)\"/) {
      my $incfile = $1;
      if ($incfile !~ /^\//) {
        # Search incdirs for the incfile
        foreach my $incdir (@$aref_incdirs) {
          if (-f "${incdir}/${incfile}") {
            $incfile = "${incdir}/${incfile}";
          }
        }
      }

      if (!-f $incfile) {
        print "WARN: Include file ($incfile) NOT FOUND in source file ($file)\n";
        print $fh_out $line;
      }
      else {
        #print "WARN: Include file ($incfile) HACKED in source file ($file)\n";
        system("cp -p $incfile ./");
        $line = "//HYDRA_INCLUDE_HACK " . $line;
        print $fh_out $line;

        my $copied_incfile = cwd . "/" . &Hydra::Util::File::get_file_name_from_path($incfile);
        print $fh_out "\`include \"${copied_incfile}\"\n";

        push(@incfiles, $copied_incfile);
      }
    }
    else {
      print $fh_out $line;
    }
  }
  &Hydra::Util::File::close_file($fh_in);
  &Hydra::Util::File::close_file($fh_out);

  if (scalar(@incfiles) > 0) {
    system("cp -p .tmp_file $file");
  }
  unlink(".tmp_file");

  foreach my $incfile (@incfiles) {
    &find_include_files($incfile, $aref_incdirs);
  }

  return;
}

1;
