#------------------------------------------------------
# Module Name: Incoming
# Date:        Fri Jun 14 11:53:36 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::Incoming;

use strict;
use warnings;
use Carp;
use Exporter;
use Sys::Hostname;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub incoming {
  my $opts = &Hydra::Util::Option::get_raw_options;
  if ($opts =~ /-h/) {
    print "Usage: hydra incoming <USER> <DIR> <SSLPASS>\n";
    exit;
  }
  exec("$ENV{HYDRA_HOME}/script/expect/incoming.tcl ${opts}");
}

sub incoming_gpg {
  my $opts = &Hydra::Util::Option::get_raw_options;
  if ($opts =~ /-h/) {
    print "Usage: hydra incoming <USER> <GPGFILE> <GPGPASS>\n";
    exit;
  }
  exec("$ENV{HYDRA_HOME}/script/expect/incoming_gpg.tcl ${opts}");
}

1;
