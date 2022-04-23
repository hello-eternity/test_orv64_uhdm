#------------------------------------------------------
# Module Name: Padframe
# Date:        Thu Dec  5 17:42:13 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::Padframe;

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
sub padframe {
  my $id_csv = &Hydra::Util::Option::get_opt_value_scalar("-id_csv", "strict");
  
  my @pads       = ();
  my %pad_groups = ();
  my %used_names = ();
  my %length     = (pad => 0, coord => 0);
  my $fh_id      = &Hydra::Util::File::open_file_for_read($id_csv);
  my $line_num   = 0;
  while (my $line = <$fh_id>) {
    $line_num++;
    # Skip line 1 header
    next if ($line_num == 1);
    my ($id, $signal, $inst_base, $cell, $ori, $width, $x, $y, $phys) = split(/\,/, $line);
    next if ($id eq "");
    if ($inst_base eq "" || $cell eq "" || $ori eq "" ||
        $x eq "" || $y eq "" || $phys eq "") {
      print "WARN: Skipping csv row $line_num with missing entries\n";
      next;
    }

    my %pad = (id        => $id,
               signal    => $signal,
               inst_base => $inst_base,
               cell      => $cell,
               ori       => $ori,
               width     => $width,
               x         => $x,
               y         => $y,
               phys      => $phys);
    $pad{inst_full} = &get_inst_name(\%pad, \%pad_groups);
    push(@pads, \%pad);

    $length{pad}   = length($pad{inst_full}) if (length($pad{inst_full}) > $length{pad});
    $length{coord} = length($x) if (length($x) > $length{coord});
    $length{coord} = length($y) if (length($y) > $length{coord});
  }
  &Hydra::Util::File::close_file($fh_id);
  $length{coord} = ($length{coord} * 2) + 4;

  &sanity_check_coordinates(\@pads);

  my $fh_icc = &Hydra::Util::File::open_file_for_write("icc2.padframe.tcl");
  foreach my $href_pad (@pads) {
    my $inst_name = $href_pad->{inst_full};
    if (defined $used_names{$inst_name}) {
      print "WARN: Duplicate instance name $inst_name used for pad $href_pad->{id}\n";
      print "      Previously used with $used_names{$inst_name}{id}\n";
    }
    else {
      $used_names{$inst_name} = $href_pad;
    }

    print $fh_icc "# $href_pad->{id} $href_pad->{signal}\n";
    if (&is_phys($href_pad)) {
      printf $fh_icc "create_cell       %-$length{pad}s [get_lib_cells */*$href_pad->{cell}]\n", $inst_name;
    }
    printf $fh_icc "set_cell_location -coordinates %-$length{coord}s -orientation %-4s %-$length{pad}s -fixed\n", "{ $href_pad->{x} $href_pad->{y} }", $href_pad->{ori}, $inst_name;
    print $fh_icc "\n";
  }
  &Hydra::Util::File::close_file($fh_icc);
}

sub is_phys {
  my ($href_pad) = @_;
  if ($href_pad->{phys} =~ /y/i) {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_inst_name {
  my ($href_pad, $href_groups) = @_;
  my $inst_name;
  if (&is_phys($href_pad)) {
    $inst_name = $href_pad->{inst_base} . "_" . $href_pad->{cell} . "_" . &get_pad_num($href_pad, $href_groups);
  }
  else {
    $inst_name = $href_pad->{inst_base};
  }
  return $inst_name;
}

sub get_pad_num {
  my ($href_pad, $href_groups) = @_;
  my $inst_name = $href_pad->{inst_base} . "_" . $href_pad->{cell};
  if (!defined $href_groups->{$inst_name}) {
    $href_groups->{$inst_name} = -1;
  }
  $href_groups->{$inst_name} += 1;
  return $href_groups->{$inst_name};
}

sub sanity_check_coordinates {
  my ($aref_pads) = @_;
  my @errors = ();

  # This sanity check uses shortcuts to avoid complex data structures for doing
  #   real 2D overlap checks. Groups of horizontal and vertical pads are gathered and
  #   sorted, e.g. a horizontal row of pads are sorted by X coordinate. Only pads that
  #   are adjacent in the list are compared for overlapping.

  # Get largest width to add to group dimension to account for stagger
  my $largest_width = (sort { $b->{width} <=> $a->{width} } @$aref_pads)[0]->{width};

  foreach my $hv (qw(horizontal vertical)) {
    my $group_dim;
    my $target_dim;
    if ($hv eq "horizontal") {
      $group_dim  = "y";
      $target_dim = "x";
    }
    else {
      $group_dim  = "x";
      $target_dim = "y";
    }

    my %groups = ();
    foreach my $href_pad (sort { $a->{$target_dim} <=> $b->{$target_dim} } @$aref_pads) {
      # Account for staggered rows/columns by grouping by range (+/- largest width)
      #   instead of actual coord
      my $group_coord = $href_pad->{$group_dim};
      foreach my $search_coord (sort {$a <=> $b} keys %groups) {
        if ($group_coord <= ($search_coord + $largest_width) &&
            $group_coord >= ($search_coord - $largest_width)) {
          $group_coord = $search_coord;
        }
      }

      push(@{ $groups{$group_coord} }, $href_pad);
    }
    foreach my $group_coord (keys %groups) {
      my $href_prev_pad;
      
      foreach my $href_pad (@{ $groups{$group_coord} }) {
        # Check both X and Y dimensions because grouping is imperfect and will
        #   probably group pads that are not actually next to each other
        # Since height is not known, assume that height = width
        if (defined $href_prev_pad && 
            $href_pad->{x} < ($href_prev_pad->{x} + $href_prev_pad->{width}) &&
            $href_pad->{y} < ($href_prev_pad->{y} + $href_prev_pad->{width})) {
          push(@errors, [$href_prev_pad, $href_pad]);
        }
        
        $href_prev_pad = $href_pad;
      }
    }
  }

  if (scalar(@errors) > 0) {
    print "ERROR: Overlapping coordinates detected on the following pads:\n";
    foreach my $aref_error (@errors) {
      my ($href_pad1, $href_pad2) = @$aref_error;
      print "       $href_pad1->{id} (x=$href_pad1->{x}, y=$href_pad1->{y}, w=$href_pad1->{width}) overlaps $href_pad2->{id} (x=$href_pad2->{x}, y=$href_pad2->{y}, w=$href_pad2->{width})\n";
    }
    die;
  }
}

1;
