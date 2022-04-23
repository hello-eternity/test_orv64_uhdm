#------------------------------------------------------
# Module Name: Drc
# Date:        Mon Jan 13 16:56:13 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary::Drc;

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
  my ($class, $run_dir, $tool, $std_iter, $rdl_iter, $ant_iter) = @_;
  my $self = {
    run_dir => $run_dir,
    tool    => $tool,
  };
  bless $self, $class;

  $self->{iters} = {
    STD => $std_iter,
    RDL => $rdl_iter,
    ANT => $ant_iter,
  };

  my $subref = \&{ "${tool}_sum_drc" };
  if (defined &$subref) {
    $self->$subref;
  }

  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub icv_sum_drc {
  my ($self) = @_;
  my $run_dir = $self->{run_dir};

  # Get all iteration names
  my $found_iter = 0;
  my @uncategorized = ();
  foreach my $entry (&Hydra::Util::File::get_sub_dirs($run_dir)) {
    if (-f "${run_dir}/${entry}/HYDRA.${entry}") {
      $found_iter = 1;
      
      if (!defined $self->{iters}{RDL} && $entry =~ /rdl/i) {
        $self->{iters}{RDL} = $entry;
      }
      elsif (!defined $self->{iters}{ANT} && $entry =~ /ant/i) {
        $self->{iters}{ANT} = $entry;
      }
      else {
        unless ((defined $self->{iters}{ANT} && $self->{iters}{ANT} eq $entry) ||
                (defined $self->{iters}{RDL} && $self->{iters}{RDL} eq $entry)) {
          push(@uncategorized, $entry);
        }
      }
      # elsif (!defined $self->{iters}{STD} && $entry =~ /drc/i) {
      #   $self->{iters}{STD} = $entry;
      # }
    }
  }

  foreach my $entry (@uncategorized) {
    if (!defined $self->{iters}{STD} && $entry =~ /drc/i) {
      # Iterations are categorized as STD unless they are already categorized as something else
      $self->{iters}{STD} = $entry;
    }
  }

  if (!$found_iter && !defined $self->{iters}{STD}) {
    # Non-iterated flow defaults to STD type
    $self->{iters}{STD} = "";
  }

  foreach my $type (sort keys %{ $self->{iters} }) {
    my $iter_name = $self->{iters}{$type};
    next if (!defined $iter_name);

    my $iter_dir;
    if ($iter_name ne "") {
      $iter_dir = "${run_dir}/${iter_name}";
    }
    else {
      $iter_dir = $run_dir;
    }

    # Find drc report without knowing block name
    my $rpt;
    foreach my $entry (&Hydra::Util::File::get_dir_files($iter_dir)) {
      if ($entry =~ /\.RESULTS$/) {
        $rpt = "${iter_dir}/${entry}";
        last;
      }
    }

    if (defined $rpt && -f $rpt) {
      my $fh_rpt = &Hydra::Util::File::open_file_for_read($rpt);
      while (my $line = <$fh_rpt>) {
        if ($line =~ /There are (\S+) total violations/) {
          $self->{total}{$type}{count} = $1;
          $self->{total}{$type}{iter} = $iter_name;
        }
      }
      &Hydra::Util::File::close_file($fh_rpt);
    }
  }
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub dump {
  my ($self) = @_;
  my $ret_val = "";

  foreach my $type (sort keys %{ $self->{total} }) {
    my $iter_name = $self->{total}{$type}{iter};
    if ($iter_name eq "") {
      $iter_name = "Non-iterated";
    }

    $ret_val .= "DRC $type Iter=${iter_name}\n";
    $ret_val .= "DRC $type Total=$self->{total}{$type}{count}\n";
  }

  return $ret_val;
}

1;
