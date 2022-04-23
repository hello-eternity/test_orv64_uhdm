#------------------------------------------------------
# Module Name: Lvs
# Date:        Mon Jan 13 16:56:11 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Lvs;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $run_dir, $tool) = @_;
  my $self = {
    run_dir => $run_dir,
    tool    => $tool,
    status  => undef,
  };
  bless $self, $class;

  my $subref = \&{ "${tool}_sum_lvs" };
  if (defined &$subref) {
    $self->$subref;
  }

  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub icv_sum_lvs {
  my ($self) = @_;
  my $run_dir = $self->{run_dir};

  # Find lvs report without knowing block name
  my $lvs_report;
  foreach my $entry (&Hydra::Util::File::get_dir_files($run_dir)) {
    if ($entry =~ /\.LVS_ERRORS$/) {
      $lvs_report = "${run_dir}/${entry}";
      last;
    }
  }

  if (defined $lvs_report && -f $lvs_report) {
    my $fh_rpt = &Hydra::Util::File::open_file_for_read($lvs_report);
    while (my $line = <$fh_rpt>) {
      if ($line =~ /Final comparison result\s*:\s*PASS/) {
        $self->{status} = "pass";
      }
      elsif ($line =~ /Final comparison result\s*:\s*FAIL/) {
        $self->{status} = "fail";
      }
    }
    &Hydra::Util::File::close_file($fh_rpt);
  }
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub dump {
  my ($self) = @_;
  my $ret_val = "";

  if (defined $self->{status}) {
    $ret_val .= "LVS Status=$self->{status}\n";
  }

  return $ret_val;
}

1;
