#------------------------------------------------------
# Module Name: ManError
# Date:        Mon Feb 17 10:11:05 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::ManError;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_tools_dir = "/work/tools/synopsys";

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub man_error {
  my $code = &Hydra::Util::Option::get_opt_value_array("", "relaxed", [""])->[0];

  my %matched = ();
  # %matched =>
  #   $tool =>
  #     $rel => <path_to_man>
  #
  foreach my $tool_entry (&Hydra::Util::File::get_sub_dirs($glb_tools_dir)) {
    my $tool_dir = "${glb_tools_dir}/${tool_entry}";
    
    # Get latest release
    my $latest_rel;
    my $latest_mtime;
    my @rel_entries = &Hydra::Util::File::get_sub_dirs($tool_dir);
    foreach my $rel_entry (@rel_entries) {
      my $mtime = (stat("${tool_dir}/${rel_entry}"))[9];
      if (!defined $latest_rel || $mtime > $latest_mtime) {
        $latest_rel   = $rel_entry;
        $latest_mtime = $mtime;
      }
    }

    if (defined $latest_rel) {
      my $rel_dir     = "${tool_dir}/${latest_rel}";
      my $install_log = "${rel_dir}/install.log";
      if (-f $install_log) {
        my $fh_log = &Hydra::Util::File::open_file_for_read($install_log);
        while (my $line = <$fh_log>) {
          if ($line =~ /([^\/\s]+)\.n$/) {
            if ($1 eq $code) {
              chomp($line);
              $matched{$tool_entry} = "${rel_dir}/${line}";
            }
          }
        }
        &Hydra::Util::File::close_file($fh_log);
      }
    }
  }

  my $selected_tool;
  if (scalar(keys %matched) > 1) {
    while (!defined $selected_tool) {
      my %opts = ();
      
      my $count = 1;
      foreach my $tool (sort keys %matched) {
        print "  ${count}. ${tool}\n";
        $opts{$count} = $tool;
        $count++;
      }
      print "Select tool manpage to view: ";

      my $selected_opt = <STDIN>;
      chomp($selected_opt);
      if (defined $opts{$selected_opt}) {
        $selected_tool = $opts{$selected_opt};
      }
    }
  }
  elsif (scalar(keys %matched) == 1) {
    $selected_tool = (keys %matched)[0];
  }
  else {
    print "Error code $code not found!\n";
    return;
  }

  system("man $matched{$selected_tool}");
}

1;
