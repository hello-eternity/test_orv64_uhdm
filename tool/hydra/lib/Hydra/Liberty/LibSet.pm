#------------------------------------------------------
# Module Name: Library
# Date:        Mon Aug 19 13:22:27 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Liberty::LibSet;

use strict;
use warnings;
use Carp;
use Exporter;
use Storable;

use Hydra::Liberty::Group;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_cache_dir = "$ENV{HYDRA_HOME}/cache/lib";

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class) = @_;
  my $self = {
    libs => {},
  };
  bless $self, $class;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_library_list {
  my ($self) = @_;
  my @libs = ();
  foreach my $lib_name (sort keys %{ $self->{libs} }) {
    push(@libs, $self->get_library($lib_name));
  }
  return @libs;
}

sub get_library {
  my ($self, $lib_name) = @_;
  if (!defined $self->{libs}{$lib_name}) {
    return undef;
  }
  else {
    return $self->{libs}{$lib_name};
  }
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub add_library {
  my ($self, $Lib) = @_;
  my $lib_name = $Lib->get_name;
  if (defined $self->{libs}{$lib_name}) {
    print "ERROR: library=${lib_name} already defined! skipping...\n";
  }
  else {
    $self->{libs}{$lib_name} = $Lib;
  }
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub read_lib_file {
  my ($self, $lib_file) = @_;
  my ($lib_md5, $filename) = split(/\s+/, `md5sum $lib_file`);

  # Try cache first
  my $read_cache    = 0;
  my $cache_file    = $glb_cache_dir . "/" . &Hydra::Util::File::get_file_name_from_path($lib_file) . ".cache";
  my $cache_file_gz = "${cache_file}.gz";
  if (-f $cache_file_gz) {
    my $fh_cache = &Hydra::Util::File::open_file_for_read($cache_file_gz);
    my $href_lib = &Storable::fd_retrieve($fh_cache);
    &Hydra::Util::File::close_file($fh_cache);
    
    # Compare md5
    if ($href_lib->{md5} eq $lib_md5) {
      &Hydra::Util::File::print_unbuffered("INFO: Reading cached lib $lib_file\n");

      # Read cache into structure
      foreach my $Lib (@{ $href_lib->{libs} }) {
        $self->add_library($Lib);
      }
      $read_cache = 1;
    }
    else {
      # Delete cache if it's outdated
      &Hydra::Util::File::delete_file($cache_file_gz);
    }
  }

  if (!$read_cache) {
    &Hydra::Util::File::print_unbuffered("INFO: Reading lib $lib_file\n");

    my @libs = ();
    my $fh_in = &Hydra::Util::File::open_file_for_read($lib_file);
    my @lines = <$fh_in>;
    my $full_line = "";
    for (my $index = 0; $index <= $#lines; $index++) {
      my $line = $lines[$index];
      chomp($line);
      # Concat continuation lines
      $full_line .= $line;
      if ($line =~ /\\\s*$/) {
        $full_line =~ s/\\\s*$/ /;
        next;
      }
      else {
        if ($full_line =~ /^\s*(library\s*\(\s*(\S+)\s*\)\s*\{)\s*$/) {
          my $lib_stmt = $1;
          my $lib_name = $2;
          my $brace_counter = 1;
          $lib_name =~ s/^\"\s*//;
          $lib_name =~ s/\s*\"$//;
          
          # Gather contents of group
          my @lib_lines = ();
          push(@lib_lines, $full_line);
          while ($brace_counter != 0) {
            $index++;
            $full_line = $lines[$index];
            
            if ($full_line =~ /\}/) {
              $brace_counter--;

              # For cases where a statement directly follows a closing brace
              # Move the statement onto a new line
              if ($full_line =~ /(\})(.+)$/) {
                $full_line    = $1;
                my $next_line = $2;
                splice(@lines, $index+1, 0, $next_line);
              }
            }
            if ($full_line =~ /\{/) {
              $brace_counter++;
            }
            
            push(@lib_lines, $full_line);
          }

          # Remove library declaration and braces
          $lib_lines[0] =~ s/^\s*\Q${lib_stmt}\E//;
          $lib_lines[$#lib_lines] =~ s/\}\s*$//;
          
          my $LibGroup = new Hydra::Liberty::LibraryGroup("library", $lib_name);
          $LibGroup->parse_group_statements(\@lib_lines);
          $self->add_library($LibGroup);

          # Store for cache
          push(@libs, $LibGroup);
        }

        $full_line = "";
      }
    }
    &Hydra::Util::File::close_file($fh_in);

    # Write libs to cache
    my %lib_cache = (md5  => $lib_md5,
                     libs => \@libs);
    &Storable::store(\%lib_cache, $cache_file);
    &Hydra::Util::File::gzip($cache_file);
  }
}

1;
