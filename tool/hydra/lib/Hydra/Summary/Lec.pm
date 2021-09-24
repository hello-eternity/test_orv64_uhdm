#------------------------------------------------------
# Module Name: Lec
# Date:        Mon Jan 13 16:56:16 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Lec;

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
  my ($class, $run_dir, $tool, $pnr_iter, $synth_iter, $dft_iter) = @_;
  my $self = {
    run_dir => $run_dir,
    tool    => $tool,
    status  => undef,               
  };

  $self->{iters} = {
    PNR   => $pnr_iter,
    SYNTH => $synth_iter,
    DFT   => $dft_iter,
  };
  
  bless $self, $class;

  my $subref = \&{ "${tool}_sum_lec" };
  if (defined &$subref) {
    $self->$subref;
  }

  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub fm_sum_lec {
  my ($self) =  @_;
  my $run_dir = $self->{run_dir};
  my $log_dir = "${run_dir}/log";

  # Get all iteration names
  foreach my $entry (&Hydra::Util::File::get_dir_files($log_dir)) {
    my $iter_name = (split(/\./, $entry))[0];
    
    if (!defined $self->{iters}{PNR} && $iter_name =~ /pnr/i) {
      $self->{iters}{PNR} = $iter_name;
    }
    elsif (!defined $self->{iters}{SYNTH} && $iter_name =~ /synth/i) {
      $self->{iters}{SYNTH} = $iter_name;
    }
    elsif (!defined $self->{iters}{DFT} && $iter_name =~ /dft/i) {
      $self->{iters}{DFT} = $iter_name;
    }
    elsif (!defined $self->{iters}{PNR}) {
      # Non-iterated flow defaults to pnr type
      $self->{iters}{PNR} = "";
    }
  }
  
  foreach my $type (sort keys %{ $self->{iters} }) {
    my $iter_name = $self->{iters}{$type};
    next if (!defined $iter_name);

    my $log;
    if ($iter_name ne "") {
      $log = "${log_dir}/${iter_name}.lec.log";
    }
    else {
      $log = "${log_dir}/lec.log";
    }

    if (-f $log) {
      my $fh_log = &Hydra::Util::File::open_file_for_read($log);
      while (my $line = <$fh_log>) {
        if ($line =~ /^\s*(\S+) Failing compare points/) {
          $self->{failing}{$type}{count} = $1;
          $self->{failing}{$type}{iter}  = $iter_name;
        }
      }
      &Hydra::Util::File::close_file($fh_log);
    }
  }
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub dump {
  my ($self) = @_;
  my $ret_val = "";

  foreach my $type (sort keys %{ $self->{failing} }) {
    my $iter_name = $self->{failing}{$type}{iter};
    if ($iter_name eq "") {
      $iter_name = "Non-iterated";
    }

    $ret_val .= "LEC $type Iter=${iter_name}\n";
    $ret_val .= "LEC $type Failing=$self->{failing}{$type}{count}\n";
  }
  
  return $ret_val;
}

1;
