#------------------------------------------------------
# Module Name: File
# Date:        Mon Jan 28 11:45:26 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Util::File;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;
use IO::Compress::Gzip;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
our %glb_month = ("Jan" => "01",
                  "Feb" => "02",
                  "Mar" => "03",
                  "Apr" => "04",
                  "May" => "05",
                  "Jun" => "06",
                  "Jul" => "07",
                  "Aug" => "08",
                  "Sep" => "09",
                  "Oct" => "10",
                  "Nov" => "11",
                  "Dec" => "12");

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub open_file_for_read {
  my ($file_path) = @_;
  if ($file_path =~ /\.gz$/) {
    return &open_gz_file_for_read($file_path);
  }
  else {
    open(my $fh_file, "<", $file_path) or die "ERROR: Cannot open file for read: $file_path\n";
    return $fh_file;
  }
}

sub open_gz_file_for_read {
  my ($file_path) = @_;
  open(my $fh_file, "zcat $file_path |");
  return $fh_file;
}

sub open_file_for_write {
  my ($file_path) = @_;
  open(my $fh_file, ">", $file_path) or die "ERROR: Cannot open file for write: $file_path\n";
  return $fh_file;
}

sub backup_and_open_file_for_write {
  my ($file_path) = @_;
  &backup_file($file_path);
  return &open_file_for_write($file_path);
}

sub backup_file {
  my ($file_path) = @_;
  if (-e $file_path) {
    my $file_dir  = &get_dir_from_path($file_path);
    my $file_name = &get_file_name_from_path($file_path);
    &make_dir("${file_dir}/backup");
    my $timestamp = &get_file_timestamp;
    system("cp ${file_path} ${file_dir}/backup/${file_name}.${timestamp}");
  }
}

sub open_file_for_append {
  my ($file_path) = @_;
  open(my $fh_file, ">>", $file_path) or die "ERROR: Cannot open file for append: $file_path\n";
  return $fh_file;
}

sub close_file {
  my ($fh_file) = @_;
  close($fh_file);
}

sub delete_file {
  my ($file_path) = @_;
  unlink($file_path);
}

sub slurp_file_into_array {
  my ($file_path) = @_;
  my $fh_in = &open_file_for_read($file_path);
  my @array = <$fh_in>;
  &close_file($fh_in);
  return @array;
}

sub make_dir {
  my ($dir_name) = @_;
  if (!-d $dir_name) {
    #mkdir($dir_name);
    system("mkdir -p $dir_name");
  }
}

sub chmod_script {
  my ($file_path) = @_;
  chmod 0775, $file_path;
}

sub get_file_timestamp {
  my ($file_path) = @_;
  my $mtime = (stat($file_path))[9];
  my ($sec, $min, $hour, $day, $month, $year) = (localtime($mtime))[0,1,2,3,4,5];
  $year += 1900;
  $month++;
  return "${month}-${day}-${year}_${hour}:${min}:${sec}";
}

sub print_unbuffered {
  my ($string) = @_;
  my $fh_old = select(STDOUT);
  $| = 1;
  print $string;
  $| = 0;
  select($fh_old);
  return;
}

sub get_file_name_from_path {
  my ($file_path) = @_;
  my $file_name;

  if ($file_path =~ /\/([^\/\s]+)$/) {
    $file_name = $1;
  }
  else {
    $file_name = $file_path;
  }

  return $file_name;
}

# Get all files in a directory; entries do NOT have full path pre-pended
sub get_dir_files {
  my ($dir_path) = @_;
  if (!-d $dir_path) {
    return ();
  }

  opendir(my $dh_dir, $dir_path) or die "ERROR: Cannot open directory $dir_path\n";
  my @entries = grep { $_ !~ /^\./ && -f "${dir_path}/$_" } readdir($dh_dir);
  closedir($dh_dir);
  return @entries;
}

sub get_dir_from_path {
  my ($file_path) = @_;
  my $dir = $file_path;

  if ($dir =~ /(\/[^\/\s]+)$/) {
    my $file_name = $1;
    $dir =~ s/${file_name}//;
  }
  else {
    $dir = ".";
  }

  return $dir;
}

# Get all sub-directories in a directory; entries do NOT have full path pre-pended
sub get_sub_dirs {
  my ($dir_path) = @_;
  if (!-d $dir_path) {
    return ();
  }

  opendir(my $dh_dir, $dir_path) or die "ERROR: Cannot open directory $dir_path\n";
  my @entries = grep { $_ !~ /^\./ && -d "${dir_path}/$_" } readdir($dh_dir);
  closedir($dh_dir);
  return @entries;
}

sub expand_file_list {
  my ($flist) = @_;
  if (!-f $flist) {
    warn "ERROR: Flist does not exist: $flist\n";
    return ([], []);
  }

  my @files   = ();
  my @incdirs = ();
  &read_file_list($flist, \@files, \@incdirs);

  # Remove duplicate files/dirs
  my @unique_files = ();
  my @unique_dirs  = ();
  my %search_files = ();
  my %search_dirs  = ();
  my $has_v = 0;
  foreach my $file (@files) {
    if ($file =~ /\-v\s+(\S+)/) {
      $file = $1;
      $has_v = 1;
    }

    $file = Cwd::realpath($file);
    if (!defined $search_files{$file}) {
      push(@unique_files, $file);
      $search_files{$file} = 1;
    }
  }
  foreach my $dir (@incdirs) {
    $dir = Cwd::realpath($dir);
    if (!defined $search_dirs{$dir}) {
      push(@unique_dirs, $dir);
      $search_dirs{$dir} = 1;
    }
  }

  return (\@unique_files, \@unique_dirs, $has_v);
}

sub read_file_list {
  my ($flist, $aref_files, $aref_incdirs) = @_;
  my $flist_dir = &get_dir_from_path($flist);
  my $fh_in = &Hydra::Util::File::open_file_for_read($flist);
    while (my $line = <$fh_in>) {
    next if ($line =~ /^\s*\/\// || $line =~ /^\s*\#/ || $line =~ /^\s*\/\//);
    if ($line =~ /^\s*-v\s*(\S+)\s*$/) {
      # -v, same as single file
      my $file = $1;
      $file = &resolve_flist_env($file);
      $file = &resolve_flist_dir($file, $flist_dir);

      if (!-f $file) {
        warn "WARN: -v file does not exist in flist ${flist}: $file\n";
        next;
      }
      
      push(@$aref_files, "-v $file");
    }
    elsif ($line =~ /^\s*-y\s*(\S+)\s*$/) {
      #-y, get all .v and .sv files in given directory
      my $dir = $1;
      $dir = &resolve_flist_env($dir);
      $dir = &resolve_flist_dir($dir, $flist_dir);

      # Check that dir exists
      if (!-d $dir) {
        warn "WARN: -y directory does not exist in flist ${flist}: $dir\n";
        next;
      }

      my @entries = &get_dir_files($dir);
      foreach my $entry (@entries) {
        if ($entry =~ /\.v$/ || $entry =~ /\.sv$/) {
          push(@$aref_files, "${dir}/${entry}");
        }
      }
    }
    elsif ($line =~ /^\s*\+incdir\+(\S+)/) {
      # incdir
      my $dir = $1;

      # dir might have + at the end that needs to be pruned
      if ($dir =~ /\+$/) {
        $dir =~ s/\+$//;
      }

      $dir = &resolve_flist_env($dir);
      $dir = &resolve_flist_dir($dir, $flist_dir);

      # Check that dir exists
      if (!-d $dir) {
        warn "WARN: incdir directory does not exist in flist ${flist}: $dir\n";
        next;
      }
      
      push(@$aref_incdirs, $dir);
    }
    elsif ($line =~ /^\s*\+incdir\+\s*$/) {
      # incdir by itself means current directory
      push(@$aref_incdirs, $flist_dir);
    }
    elsif ($line =~ /^\s*-f\s+(\S+)/) {
      # nested flist
      my $nested_flist = $1;
      $nested_flist = &resolve_flist_env($nested_flist);
      $nested_flist = &resolve_flist_dir($nested_flist, $flist_dir);
      
      if (!-f $nested_flist) {
        warn "WARN: -f nested flist does not exist in flist ${flist}: $nested_flist\n";
        next;
      }

      &read_file_list($nested_flist, $aref_files, $aref_incdirs);
    }
    elsif ($line =~ /^\s*(\S+)\s*$/) {
      # single file
      my $file = $1;
      $file = &resolve_flist_env($file);
      $file = &resolve_flist_dir($file, $flist_dir);

      # Check that file exists
      if (!-f $file) {
        warn "WARN: File does not exist in flist ${flist}: $file\n";
        next;
      }

      push(@$aref_files, $file);
    }
  }
  &Hydra::Util::File::close_file($fh_in);
}

# sub expand_file_list {
#   my ($flist) = @_;
#   my $flist_script = "$ENV{HYDRA_HOME}/script/tcl/file_to_list.tcl";
#   my $out = `echo "source $flist_script; puts [expand_file_list $flist];" | tclsh`;
#   my @file_list = split(/[\s\n]+/, $out);

#   # Get incdirs
#       my @incdirs = ();
#   &get_incdirs_from_flist($flist, \@incdirs);


#   return (\@file_list, \@incdirs);
# }

# sub expand_file_list_hack {
#   my ($flist) = @_;
#   my $flist_script = "$ENV{HYDRA_HOME}/script/tcl/file_to_list.hack.tcl";
#   my $out = `echo "source $flist_script; puts [expand_file_list $flist];" | tclsh`;
#   my @file_list = split(/[\s\n]+/, $out);

#   # Get incdirs
#       my @incdirs = ();
#   &get_incdirs_from_flist($flist, \@incdirs);


#   return (\@file_list, \@incdirs);
# }

# sub get_incdirs_from_flist {
#   my ($flist, $aref_incdirs) = @_;
#   my $flist_dir = &get_dir_from_path($flist);
#   my $fh_in = &Hydra::Util::File::open_file_for_read($flist);
#   while (my $line = <$fh_in>) {
#     next if ($line =~ /^\s*\/\//);
#     if ($line =~ /^\s*\+incdir\+(\S+)/) {
#       my $resolved = &resolve_tcl_env($1);
#       push(@$aref_incdirs, "${flist_dir}/${resolved}");
#     }
#     elsif ($line =~ /^\s*\+incdir\+\s*$/) {
#       push(@$aref_incdirs, $flist_dir);
#     }
#     elsif ($line =~ /^\s*-f\s+(\S+)/) {
#       my $resolved = &resolve_tcl_env($1);
#       &get_incdirs_from_flist("${flist_dir}/${resolved}", $aref_incdirs);
#     }
#   }
#   &Hydra::Util::File::close_file($flist);
# }

sub get_git_info {
  my ($dir) = @_;
  if (-d $dir) {
    my $orig_dir = cwd;
    chdir $dir;
    
    my $git_hash = `git log -1 --format="%H" 2> /dev/null`;
    $git_hash =~ s/\n//;
    
    my @loglines = split(/\n/, `git log 2> /dev/null`);
    my $date;
    foreach my $line (@loglines) {
      if ($line =~ /Date\:\s+\S+\s+(\S+)\s+(\d+)\s+(\d+)\:(\d+)\:(\d+)\s+(\d+)/) {
        my $month = $glb_month{$1};
        my $day   = sprintf "%02d", $2;
        my $hour  = sprintf "%02d", $3;
        my $min   = sprintf "%02d", $4;
        my $sec   = sprintf "%02d", $5;
        my $year  = $6;
        $date = "${month}-${day}-${year}_${hour}.${min}.${sec}";
      }

      last if (defined $date);
    }

    my $repo_name;
    if (`git remote -v 2> /dev/null` =~ /^\s*\S+\s+\S+?([^\s\/]+)\s+\(fetch\)/) {
      $repo_name = $1;
    }

    chdir $orig_dir;
    return ($repo_name, $git_hash, $date);
  }

  return (undef, undef, undef);
}

sub resolve_env {
  my ($string) = @_;
  while ($string =~ /(\$::env\(([^\s\(\)]+)\))/g) {
    my $var      = $1;
    my $env_name = $2;
    if (defined $ENV{$env_name}) {
      $string =~ s/\Q${var}\E/$ENV{$env_name}/g;
    }
  }

  return $string;
}

sub resolve_flist_env {
  my ($string) = @_;
  while ($string =~ /(\$([^\s\/]+))/g) {
    my $var      = $1;
    my $env_name = $2;
    $env_name =~ s/^\{//;
    $env_name =~ s/\}$//;
    if (defined $ENV{$env_name}) {
      $string =~ s/\Q${var}\E/$ENV{$env_name}/g;
    }
  }

  return $string;
}

sub resolve_flist_dir {
  my ($file, $dir) = @_;
  if ($file !~ /^\//) {
    $file = "${dir}/${file}";
  }
  return $file;
}

sub gzip {
  my ($file) = @_;
  my $gzip_file = "${file}.gz";
  &IO::Compress::Gzip::gzip($file => $gzip_file);
  &delete_file($file);
}

1;
