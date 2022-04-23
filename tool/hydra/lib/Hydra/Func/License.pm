#------------------------------------------------------
# Module Name: License
# Date:        Fri Jul  5 12:43:12 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::License;

use strict;
use warnings;
use Carp;
use Exporter;
use Time::Local;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my %month = ('jan' => 0,
             'feb' => 1,
             'mar' => 2,
             'apr' => 3,
             'may' => 4,
             'jun' => 5,
             'jul' => 6,
             'aug' => 7,
             'sep' => 8,
             'oct' => 9,
             'nov' => 10,
             'dec' => 11);
my $glb_week_seconds = 604800;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub license {
  my @licenses = ();
  my $current_time = time;
  foreach my $line (split(/\n/, `/work/tools/flexlm/x64_lsb/lmutil lmstat -i`)) {
    if ($line =~ /^\s*\S+\s+\S+\s+\d+\s+(\d+)\-(\S+)\-(\d+)/) {
      my %entry = (line => $line, expire => timelocal(0, 0, 0, $1, $month{lc($2)}, $3-1900));
      push(@licenses, \%entry);
    }
  }

  foreach my $entry (sort { $a->{expire} <=> $b->{expire} } @licenses) {
    my $line   = $entry->{line};
    my $diff   = $entry->{expire} - $current_time;
    my $notice = "";
    if ($diff < 0) {
      $notice = "EXPIRED";
    }
    elsif ($diff < $glb_week_seconds) {
      $notice = "< 1 WEEK";
    }

    printf "%-10s $line\n", $notice;
  }
}

1;
