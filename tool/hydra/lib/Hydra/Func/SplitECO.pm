#------------------------------------------------------
# Module Name: SplitECO
# Date:        Sun Mar 15 00:21:44 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::SplitECO;

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
sub split_eco {
  my $script      = &Hydra::Util::Option::get_opt_value_scalar("-script", "strict");
  my $aref_blocks = &Hydra::Util::Option::get_opt_value_array("-blocks", "strict");
  #my %blocks      = map {$_ => 1} @$aref_blocks;

  my %cmds = ();
  # %cmds =
  #   $block_name = []
  #

  my $current_block = "top";
  my $fh_in = &Hydra::Util::File::open_file_for_read($script);
  while (my $line = <$fh_in>) {
    if ($line =~ /^\s*current_instance\s*$/) {
      $current_block = "top";
      push(@{ $cmds{$current_block} }, $line);
    }
    elsif ($line =~ /^\s*current_instance\s+\{(\S+)\}/) {
      my $inst_name = $1;

      my ($block_name, $pruned_inst_name) = &prune_user_inst($aref_blocks, $inst_name);
      if (defined $block_name && defined $pruned_inst_name) {
        $current_block = $block_name;

        if ($pruned_inst_name eq "") {
          push(@{ $cmds{$current_block} }, "current_instance\n");
        }
        else {
          push(@{ $cmds{$current_block} }, "current_instance\n");
          push(@{ $cmds{$current_block} }, "current_instance {${pruned_inst_name}}\n");
        }
      }
      else {
        push(@{ $cmds{$current_block} }, $line);
      }
    }
    else {
      push(@{ $cmds{$current_block} }, $line);
    }
  }
  &Hydra::Util::File::close_file($script);

  foreach my $block_name (sort keys %cmds) {
    my $out_file = "${block_name}.tcl";
    $out_file =~ s/\//__/g;
    my $fh_out = &Hydra::Util::File::open_file_for_write($out_file);
    foreach my $line (@{ $cmds{$block_name} }) {
      print $fh_out $line;
    }
    &Hydra::Util::File::close_file($fh_out);
  }
}

# If the given instance is inside a user block, then return the instance name
#   without the block hierarchy
# Return undef if the instance is not inside a user block
sub prune_user_inst {
  my ($aref_blocks, $inst_name) = @_;
  foreach my $block_name (@$aref_blocks) {
    if ($inst_name =~ /^${block_name}$/) {
      return ($block_name, "");
    }
    elsif ($inst_name =~ /^${block_name}\/(\S+)$/) {
      return ($block_name, $1);
    }
  }

  return (undef, undef);
}

1;
