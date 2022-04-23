#------------------------------------------------------
# Module Name: Synth
# Date:        Tue Jan 14 12:00:28 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Synth;

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
  };
  bless $self, $class;

  # # Initialize cell count
  # foreach my $type (qw(comb seq macro)) {
  #   $self->{cell_count}{$type} = 0;
  # }

  # # Initialize cell area
  # foreach my $type (qw(comb noncomb macro total)) {
  #   $self->{cell_area}{$type} = 0;
  # }

  my $subref = \&{ "${tool}_sum_synth" };
  if (defined &$subref) {
    $self->$subref;
  }
  
  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub dc_sum_synth {
  my ($self) = @_;
  my $run_dir = $self->{run_dir};
  my $rpt_dir = "${run_dir}/rpt";
  
  my $area_rpt = "${rpt_dir}/synth.area.hier.rpt";
  if (-f $area_rpt) {
    my $fh_area = &Hydra::Util::File::open_file_for_read($area_rpt);
    while (my $line = <$fh_area>) {
      if ($line =~ /Number of combinational cells:\s+(\S+)/) {
        $self->{cell_count}{comb} = $1;
      }
      elsif ($line =~ /Number of sequential cells:\s+(\S+)/) {
        $self->{cell_count}{seq} = $1;
      }
      elsif ($line =~ /Number of macros\/black boxes:\s+(\S+)/) {
        $self->{cell_count}{macro} = $1;
      }
      elsif ($line =~ /Combinational area:\s+(\S+)/) {
        $self->{cell_area}{comb} = $1;
      }
      elsif ($line =~ /Noncombinational area:\s+(\S+)/) {
        $self->{cell_area}{noncomb} = $1;
      }
      elsif ($line =~ /Macro\/Black Box area:\s+(\S+)/) {
        $self->{cell_area}{macro} = $1;
      }
      elsif ($line =~ /Total cell area:\s+(\S+)/) {
        $self->{cell_area}{total} = $1;
      }
    }
    &Hydra::Util::File::close_file($fh_area);
  }
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub dump {
  my ($self) = @_;
  my $ret_val = "";

  # Cell count
  foreach my $type (qw(comb seq macro)) {
    #$ret_val .= "synth/cell_count/${type} = $self->{cell_count}{$type}\n";
    if (defined $self->{cell_count}{$type}) {
      $ret_val .= "  <cell_count type=\"${type}\">$self->{cell_count}{$type}</cell_count>\n";
    }
  }

  # Cell area
  foreach my $type (qw(comb noncomb macro total)) {
    #$ret_val .= "synth/cell_area/${type} = $self->{cell_area}{$type}\n";
    if (defined $self->{cell_area}{$type}) {
      $ret_val .= "  <cell_area type=\"${type}\">$self->{cell_area}{$type}</cell_area>\n";
    }
  }

  return $ret_val;
}

1;
