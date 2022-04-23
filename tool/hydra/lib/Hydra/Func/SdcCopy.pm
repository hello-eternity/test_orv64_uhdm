#------------------------------------------------------
# Module Name: SdcCopy
# Date:        Mon Apr 15 19:14:05 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::SdcCopy;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub sdc_copy {
  my $source_sdc  = &Hydra::Util::Option::get_opt_value_scalar("-sdc", "strict");

  my ($repo_name, $git_hash, $date) = &Hydra::Util::File::get_git_info(&Hydra::Util::File::get_dir_from_path($source_sdc));

  my $dest_sdc = &Hydra::Util::File::get_file_name_from_path($source_sdc);
  $dest_sdc =~ s/\.sdc$//;
  $dest_sdc .= ".${date}.sdc";

  my $fh_out = &Hydra::Util::File::open_file_for_write($dest_sdc);
  if (defined $repo_name && defined $git_hash && defined $date) {
    print $fh_out "# Git Hash: $repo_name $git_hash\n";
  }
  &Hydra::Util::File::close_file($fh_out);

  system("cat $source_sdc >> $dest_sdc");
}

1;
