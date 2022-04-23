#------------------------------------------------------
# Module Name: Dashboard
# Date:        Tue Jan 14 12:13:53 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::Dashboard;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Summary;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub dashboard {
  my $proj_dir        = &Hydra::Util::Option::get_opt_value_scalar("-proj_dir", "strict");
  my $rtl_rel         = &Hydra::Util::Option::get_opt_value_scalar("-rtl_rel", "relaxed", undef);
  my $block           = &Hydra::Util::Option::get_opt_value_scalar("-block", "relaxed", undef);
  my $run             = &Hydra::Util::Option::get_opt_value_scalar("-run", "relaxed", undef);
  my $eco             = &Hydra::Util::Option::get_opt_value_scalar("-eco", "relaxed", undef);
  my $pnr_run         = &Hydra::Util::Option::get_opt_value_scalar("-PNR_Run", "relaxed", "pnr");
  my $sta_run         = &Hydra::Util::Option::get_opt_value_scalar("-STA_Run", "relaxed", "sta");
  my $lvs_run         = &Hydra::Util::Option::get_opt_value_scalar("-LVS_Run", "relaxed", "lvs");
  my $drc_run         = &Hydra::Util::Option::get_opt_value_scalar("-DRC_Run", "relaxed", "drc");
  my $lec_run         = &Hydra::Util::Option::get_opt_value_scalar("-LEC_Run", "relaxed", "lec");
  my $power_run       = &Hydra::Util::Option::get_opt_value_scalar("-POWER_Run", "relaxed", "power");
  my $rc_extract_run  = &Hydra::Util::Option::get_opt_value_scalar("-RC_EXTRACT_Run", "relaxed", "rc_extract");
  my $synth_run       = &Hydra::Util::Option::get_opt_value_scalar("-SYNTH_Run", "relaxed", "synth");
  my $lec_synth_iter  = &Hydra::Util::Option::get_opt_value_scalar("-LEC_SYNTH_Iter", "relaxed", undef);
  my $lec_dft_iter    = &Hydra::Util::Option::get_opt_value_scalar("-LEC_DFT_Iter", "relaxed", undef);
  my $lec_pnr_iter    = &Hydra::Util::Option::get_opt_value_scalar("-LEC_PNR_Iter", "relaxed", undef);
  my $drc_std_iter    = &Hydra::Util::Option::get_opt_value_scalar("-DRC_STD_Iter", "relaxed", undef);
  my $drc_ant_iter    = &Hydra::Util::Option::get_opt_value_scalar("-DRC_ANT_Iter", "relaxed", undef);
  my $drc_rdl_iter    = &Hydra::Util::Option::get_opt_value_scalar("-DRC_RDL_Iter", "relaxed", undef);
  my $out_file        = "dashboard.txt";

  # If block, rtl_rel, or run are not defined, then return a list of valid options instead of summary
  my $query_dir;
  if (!defined $block && !defined $rtl_rel && !defined $run) {
    $query_dir = "${proj_dir}/WORK";
  }
  elsif (defined $block && !defined $rtl_rel && !defined $run) {
    $query_dir = "${proj_dir}/WORK/${block}";
  }
  elsif (defined $block && defined $rtl_rel && !defined $run) {
    $query_dir = "${proj_dir}/WORK/${block}/${rtl_rel}";
  }
  elsif (defined $block && defined $rtl_rel && defined $run && defined $eco && $eco eq "?") {
    $query_dir = "${proj_dir}/WORK/${block}/${rtl_rel}/${run}";
  }

  if (defined $query_dir) {
    my @entries;
    if (defined $eco && $eco eq "?") {
      @entries = ();
      foreach my $entry (&Hydra::Util::File::get_sub_dirs($query_dir)) {
        if ($entry =~ /^eco/) {
          push(@entries, $entry);
        }
      }
    }
    else {
      @entries = &Hydra::Util::File::get_sub_dirs($query_dir);
    }
    my $line = join(",", @entries);
    #my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
    #print $fh_out "$line\r\n";
    #&Hydra::Util::File::close_file($fh_out);
    print "$line\r\n";
    return;
  }

  # Get param files from proj dir
  my @param_files = ();
  foreach my $entry (&Hydra::Util::File::get_dir_files("${proj_dir}/HYDRA/param")) {
    if ($entry =~ /\.param$/) {
      push(@param_files, "${proj_dir}/HYDRA/param/${entry}");
    }
  }

  my $Summary = new Hydra::Summary($block, $rtl_rel, $run, $eco, $proj_dir, @param_files);
  $Summary->set_run_names($pnr_run, $sta_run, $lvs_run, $drc_run, $lec_run, $power_run, $rc_extract_run, $synth_run);
  $Summary->set_iter_name("lec", "synth", $lec_synth_iter) if (defined $lec_synth_iter);
  $Summary->set_iter_name("lec", "dft", $lec_dft_iter) if (defined $lec_dft_iter);
  $Summary->set_iter_name("lec", "pnr", $lec_pnr_iter) if (defined $lec_pnr_iter);
  $Summary->set_iter_name("drc", "std", $drc_std_iter) if (defined $drc_std_iter);
  $Summary->set_iter_name("drc", "ant", $drc_ant_iter) if (defined $drc_ant_iter);
  $Summary->set_iter_name("drc", "rdl", $drc_rdl_iter) if (defined $drc_rdl_iter);
  $Summary->sum_all;

  #my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
  my $sum_dump = $Summary->dump_all;
  $sum_dump =~ s/\n/\r\n/g;
  #print $fh_out $sum_dump;
  print $sum_dump;
  #&Hydra::Util::File::close_file($fh_out);
}

1;
