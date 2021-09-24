#------------------------------------------------------
# Module Name: Summary
# Date:        Mon Jan 13 16:51:54 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Summary;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Summary::Pnr;
use Hydra::Summary::Sta;
use Hydra::Summary::Lvs;
use Hydra::Summary::Drc;
use Hydra::Summary::Lec;
use Hydra::Summary::Power;
use Hydra::Summary::Synth;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $block, $rtl, $run, $eco, $proj_dir, @param_files) = @_;
  my $self = {
    run_dir        => "${proj_dir}/WORK/${block}/${rtl}/${run}",
    block          => $block,
    rtl            => $rtl,
    run            => $run,
    eco            => $eco,
    pnr_run        => "pnr",
    sta_run        => "sta",
    lvs_run        => "lvs",
    drc_run        => "drc",
    lec_run        => "lec",
    power_run      => "power",
    synth_run      => "synth",
    tools          => {},
    sums           => {},
  };
  bless $self, $class;
  $self->initialize_tools(@param_files);
  return $self;
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub set_run_names {
  my ($self, $pnr, $sta, $lvs, $drc, $lec, $power, $synth) = @_;
  $self->{pnr_run} = $pnr;
  $self->{sta_run} = $sta;
  $self->{lvs_run} = $lvs;
  $self->{drc_run} = $drc;
  $self->{lec_run} = $lec;
  $self->{power_run} = $power;
  $self->{synth_run} = $synth;
}

sub set_iter_name {
  my ($self, $flow_type, $iter_type, $name) = @_;
  $self->{"${flow_type}_${iter_type}_iter"} = $name;
}

sub initialize_tools {
  my ($self, @param_files) = @_;
  my $Param = new Hydra::Setup::Param(@param_files);
  $self->{tools} = &Hydra::Setup::Tool::get_initialized_tools($Param);
}

sub sum_all {
  my ($self) = @_;
  foreach my $type (qw(pnr sta lvs drc lec power synth)) {
    my $subref = \&{ "sum_${type}"};
    if (defined &$subref) {
      $self->$subref;
    }
  }
}

sub sum_pnr {
  my ($self) = @_;
  $self->{sums}{pnr} = new Hydra::Summary::Pnr($self->get_run_dir("pnr"), $self->{tools}{pnr});
}

sub sum_sta {
  my ($self) = @_;
  $self->{sums}{sta} = new Hydra::Summary::Sta($self->get_run_dir("sta"), $self->{tools}{sta});
}

sub sum_lvs {
  my ($self) = @_;
  $self->{sums}{lvs} = new Hydra::Summary::Lvs($self->get_run_dir("lvs"), $self->{tools}{lvs});
}

sub sum_drc {
  my ($self) = @_;
  $self->{sums}{drc} = new Hydra::Summary::Drc($self->get_run_dir("drc"), $self->{tools}{drc}, $self->{drc_std_iter}, $self->{drc_rdl_iter}, $self->{drc_ant_iter});
}

sub sum_lec {
  my ($self) = @_;
  $self->{sums}{lec} = new Hydra::Summary::Lec($self->get_run_dir("lec"), $self->{tools}{lec}, $self->{lec_pnr_iter}, $self->{lec_synth_iter}, $self->{lec_dft_iter});
}

sub sum_power {
  my ($self) = @_;
  $self->{sums}{power} = new Hydra::Summary::Power($self->get_run_dir("power"), $self->{tools}{power});
}

sub sum_synth {
  my ($self) = @_;
  $self->{sums}{synth} = new Hydra::Summary::Synth($self->get_run_dir("synth"), $self->{tools}{synth});
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_run_dir {
  my ($self, $type) = @_;
  if ($self->has_eco) {
    return $self->{run_dir} . "/" . $self->{eco} . "/" . $self->{"${type}_run"};
  }
  else {
    return $self->{run_dir} . "/" . $self->{"${type}_run"};
  }
}

sub has_eco {
  my ($self) = @_;
  return 1 if (defined $self->{eco});
  return 0;
}

sub dump_all {
  my ($self) = @_;
  my $ret_val = "";

  foreach my $type (qw(pnr sta lvs drc lec power synth)) {
    my $subref = \&{ "dump_${type}" };
    if (defined &$subref) {
      $ret_val .= $self->$subref;
    }
  }

  return $ret_val;
}

sub dump_pnr {
  my ($self) = @_;
  my $ret_val = "";

  $ret_val .= "PNR Run=$self->{pnr_run}\n";
  $ret_val .= $self->{sums}{pnr}->dump;

  return $ret_val;
}

sub dump_sta {
  my ($self) = @_;
  my $ret_val = "";

  $ret_val .= "STA Run=$self->{sta_run}\n";
  $ret_val .= $self->{sums}{sta}->dump;
  
  return $ret_val;
}

sub dump_lec {
  my ($self) = @_;
  my $ret_val = "";
  
  $ret_val .= "LEC Run=$self->{lec_run}\n";
  $ret_val .= $self->{sums}{lec}->dump;

  return $ret_val;
}

sub dump_lvs {
  my ($self) = @_;
  my $ret_val = "";

  $ret_val .= "LVS Run=$self->{lvs_run}\n";
  $ret_val .= $self->{sums}{lvs}->dump;

  return $ret_val;
}

sub dump_synth {
  my ($self) = @_;
  my $ret_val;

  $ret_val .= "SYNTH Run=$self->{synth_run}\n";
  $ret_val .= $self->{sums}{synth}->dump;
  
  return $ret_val;
}

sub dump_drc {
  my ($self) = @_;
  my $ret_val;

  $ret_val .= "DRC Run=$self->{drc_run}\n";
  $ret_val .= $self->{sums}{drc}->dump;

  return $ret_val;
}

1;
