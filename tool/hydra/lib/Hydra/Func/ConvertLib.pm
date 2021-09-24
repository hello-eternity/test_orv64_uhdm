#------------------------------------------------------
# Module Name: ConvertLib
# Date:        Thu Sep 19 14:20:36 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::ConvertLib;

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
# Subroutines
#------------------------------------------------------
sub convert_lib {
  my $dir      = &Hydra::Util::Option::get_opt_value_scalar("-dir", "relaxed", "./");
  my $lc_shell = &Hydra::Util::Option::get_opt_value_scalar("-lc_shell", "relaxed", "/work/tools/synopsys/lc/M-2017.06-SP3/bin/lc_shell");
  if (!-f $lc_shell) {
    print "ERROR: lc_shell not found: $lc_shell\n";
    die   "       use option -lc_shell to specify the library compiler binary\n";
  }

  my @lib_files = ();
  foreach my $file (&Hydra::Util::File::get_dir_files($dir)) {
    if ($file =~ /\.lib$/) {
      push(@lib_files, $file);
    }
  }

  foreach my $lib_file (@lib_files) {
    my $lib_name = $lib_file;
    $lib_name =~ s/\.lib//;

    my $db_file  = "${lib_name}.db";
    my $lib_path = "${dir}/${lib_file}";
    my $db_path  = "${dir}/${db_file}";
    
    system("$lc_shell -x \"read_lib ${lib_path}; write_lib -format db ${lib_name} -output ${db_path}; quit;\"");
  }
}

1;
