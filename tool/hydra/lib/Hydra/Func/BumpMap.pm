#------------------------------------------------------
# Module Name: BumpMap
# Date:        Wed Jun 19 17:55:14 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::BumpMap;

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
sub bump_map {
  my $design           = &Hydra::Util::Option::get_opt_value_scalar("-design", "strict");
  my $map_csv          = &Hydra::Util::Option::get_opt_value_scalar("-map_csv", "strict");
  my $id_csv           = &Hydra::Util::Option::get_opt_value_scalar("-id_csv", "relaxed", undef);
  my $bump_width       = &Hydra::Util::Option::get_opt_value_scalar("-bump_size", "strict");
  my $bump_height      = $bump_width;
  my $hori_spacing     = &Hydra::Util::Option::get_opt_value_scalar("-hori_spacing", "strict");
  my $vert_spacing     = &Hydra::Util::Option::get_opt_value_scalar("-vert_spacing", "strict");
  my $signal_bump_name = &Hydra::Util::Option::get_opt_value_scalar("-signal_bump_cell", "strict");
  my $ur_chip_coords   = &Hydra::Util::Option::get_opt_value_scalar("-ur_chip_coords", "strict");
  my $block_via_layer  = &Hydra::Util::Option::get_opt_value_scalar("-block_via_layer", "relaxed", undef);

  # Read id csv file
  my %id_to_sig = ();
  if (defined $id_csv) {
    my $line_num = 0;
    my $fh_id = &Hydra::Util::File::open_file_for_read($id_csv);
    while (my $line = <$fh_id>) {
      $line_num++;
      # Skip line 1 header
      next if ($line_num == 1);
      my ($id, $signal, $inst_base, $cell, $ori, $width, $x, $y, $phys) = split(/\,/, $line);
      next if ($id eq "");
      $id_to_sig{$id} = $signal;
    }
    &Hydra::Util::File::close_file($fh_id);
  }
  
  # Read map csv file
  my @map = ();
  my $row_count  = 0;
  my $col_count  = 0;
  my $col_cursor = 0;
  my $bump_max_length = 0;
  my $fh_map = &Hydra::Util::File::open_file_for_read($map_csv);

  # Push empty row into element 0 so that we can start at row 1
  push(@map, []);

  while (my $line = <$fh_map>) {
    # Remove extra commas from the end of all lines
    $line =~ s/\,+\s*$//;

    my @row    = ();
    my @tokens = split(/\,/, $line);
    while (scalar(@tokens) > 0) {
      # Remove leading and trailing spaces so that bump+id whitespace check works
      my $token = shift @tokens;
      $token    =~ s/^\s*//;
      $token    =~ s/\s*$//;

      my $bump_name = "";
      my $pad_id    = "";
      
      if ($token =~ /\s+/) {
        # Both bump name and pad id are here
        ($bump_name, $pad_id) = split(/\s+/, $token);
      }
      elsif ($token =~ /^(T|B|R|L)\d+/) {
        # Only pad id is here
        # Try to map to a bump name from id csv
        $pad_id = $token;
        if ($pad_id ne "" && !defined $id_to_sig{$pad_id}) {
          warn "WARN: Pad ID ${pad_id} not found in ID csv\n";
          $bump_name = "";
        }
        else {
          $bump_name = $id_to_sig{$pad_id};
        }
      }
      else {
        # Only bump name is here
        $bump_name = $token;
        $pad_id    = "";
      }

      $bump_name = "" if (!defined $bump_name);
      $pad_id    = "" if (!defined $pad_id);

      $bump_name =~ s/\r//g;
      $pad_id    =~ s/\r//g;
      chomp($bump_name);
      chomp($pad_id);

      push(@row, "${bump_name},${pad_id}");
      $col_cursor++;

      if (length($bump_name) > $bump_max_length) {
        $bump_max_length = length($bump_name);
      }
    }

    push(@map, \@row);
    $row_count++;
    $col_count = $col_cursor if ($col_cursor > $col_count);
    $col_cursor = 0;
  }

  # Remove final empty rows, if present
  for (my $row = $#map; $row >= 0; $row--) {
    my $aref_row = $map[$row];
    my $is_empty = 1;
    foreach my $entry (@$aref_row) {
      if ($entry !~ /^\s*\,\s*$/) {
        $is_empty = 0;
        last;
      }
    }

    if ($is_empty) {
      pop(@map);
    }
    else {
      last;
    }
  }

  &Hydra::Util::File::close_file($fh_map);

  # Update row_count and col_count
  $row_count = $#map;

  # Figure out starting LL coords if we want to place the bump grid in the center of the chip
  # Get coords for middle of chip each dimension
  my $cx1 = 0;
  my $cy1 = 0;
  my ($cx2, $cy2) = split(/\,/, $ur_chip_coords);
  my $midx = ($cx1 + $cx2) / 2;
  my $midy = ($cy1 + $cy2) / 2;
  
  # Get width and height of bump grid
  # Width is the number of elements in a row times the bump width, plus the empty space between cells times the number of elements minus 1
  my $hori_empty_spacing;
  my $vert_empty_spacing;
  my $grid_width;
  my $grid_height;
  $hori_empty_spacing = $hori_spacing - $bump_width;
  $vert_empty_spacing = $vert_spacing - $bump_height;
  $grid_width  = ($col_count * $bump_width) + ($hori_empty_spacing * ($col_count - 1));
  $grid_height = ($row_count * $bump_height) + ($vert_empty_spacing * ($row_count - 1));

  # Starting coord is middle coord minus half the width/height of the bump grid, for each dimension
  my $starting_x = $midx - ($grid_width / 2);
  my $starting_y = $midy + ($grid_height / 2);

  # Coords are for center of bump
  $starting_x += ($bump_width / 2);
  $starting_y -= ($bump_height / 2);

  # Sanity checks
  # Bump grid should be smaller than chip
  my $die_flag = 0;
  if ($grid_width > ($cx2 - $cx1)) {
    my $chip_width = $cx2 - $cx1;
    warn "ERROR: Bump grid width=${grid_width} is greater than chip width=${chip_width}!\n";
    $die_flag = 1;
  }
  if ($grid_height > ($cy2 - $cy1)) {
    my $chip_height = $cy2 - $cy1;
    warn "ERROR: Bump grid height=${grid_height} is greater than chip height=${chip_height}!\n";
    $die_flag = 1;
  }
  # All inputs should be positive
  if ($bump_width < 0 || $hori_spacing < 0 || $vert_spacing < 0 || $cx2 < 0 || $cy2 < 0) {
    warn "ERROR: Bump or chip dimensions given are negative!\n";
    $die_flag = 1;
  }

  die if ($die_flag);

  # Write output script starting from UL corner
  my $mapped_count   = 0;
  my $unmapped_count = 0;
  my %seen = ();
  my $CSV_fh = &Hydra::Util::File::open_file_for_write("$design.bump_map.csv");
  my $AIF_fh = &Hydra::Util::File::open_file_for_write("$design.bump_map.aif");
  my $fh_blockage;
  if (defined $block_via_layer) {
    $fh_blockage = &Hydra::Util::File::open_file_for_write("${design}.bump_via_blockage.tcl");
  }
  my $cur_x = $starting_x;
  my $cur_y = $starting_y;

  # Prep the AIF file header
  print $AIF_fh "[DATABASE]\n";
  print $AIF_fh "TYPE=AIF\n";
  print $AIF_fh "VERSION=2.0\n";
  print $AIF_fh "UNITS=UM\n";
  print $AIF_fh "\n";
  print $AIF_fh "[DIE]\n";
  print $AIF_fh "NAME=$design\n";
  print $AIF_fh "WIDTH=$cx2\n";
  print $AIF_fh "HEIGHT=$cy2\n";
  print $AIF_fh "\n";
  print $AIF_fh "[NETLIST]\n";
  #print $AIF_fh ";\t\tNetBumpName\t\tBumpRef\tBump_X\tBump_Y\tBall#\n";
  printf $AIF_fh "\;%-${bump_max_length}s %-40s %-20s %-10s %-10s %-10s\n", "Net", "BumpName", "BumpRef", "Bump_X", "Bump_Y", "Ball#";
  print $AIF_fh "\n";

  #for (my $row = $#map; $row >= 0; $row--) {
  for (my $row = 1; $row <= $#map; $row++) {
    my $aref_row = $map[$row];
    print $AIF_fh ";Row $row\n";

    for (my $col = 0; $col <= $#$aref_row; $col++) {
      my ($bump_name, $pad_id) = split(/\,/, $aref_row->[$col]);
      if ($bump_name eq "") {
        # If no bump name specified, then do not create a bump and leave the space empty
        $cur_x += $hori_spacing;
        next;
      }

      # Bump name in spreadsheet denotes net name to be connected to bump
      my $bump_net_name = $bump_name;

      # Use flag for not doing assignSigToBump on DUMMY/NC since bump_name gets modified later on and cant be checked
      my $assign_sig = 1;
      if ($bump_name eq "DUMMY" || $bump_name eq "NC") {
        $assign_sig = 0;
        $bump_net_name = "-";
      }

      # Remove brackets for naming purposes
      $bump_name =~ s/\[(\S+?)\]/$1/g;

      # Use signal bump for entries with empty bump type
      my $bump_cell_name = $signal_bump_name;
      
      # Edit name for duplicates
      if (defined $seen{$bump_name}) {
        my $suffix = $seen{$bump_name};
        $seen{$bump_name} += 1;
      }
      else {
        $seen{$bump_name} = 1;
      }
      # Add pad ID if it exists
      if ($pad_id !~ /^\s*$/) {
        $bump_name = "${bump_name}__${pad_id}"
      }
      else {
        # Bumps without a pad ID get the row/col appended instead
        $bump_name = "${bump_name}__r${row}c${col}";
      }
 
      my $x_text;
      my $y_text;
      my $x_out;
      my $y_out;
      $x_text = "${cur_x}";
      $y_text = "${cur_y}";
      $x_out = $cur_x;
      $y_out = $cur_y;
      $x_text =~ s/\.0+$//;
      $y_text =~ s/\.0+$//;
      $x_text =~ s/\./p/;
      $y_text =~ s/\./p/;
      my $x_aif = $x_out - $midx;
      my $y_aif = $y_out - $midy;
      # Removed coordinates from instance name
      #my $bump_inst_name = "${x_text}_${y_text}_${bump_name}";
      my $bump_inst_name = $bump_name;

      # Trim bump inst name down to 31 characters
      if (length($bump_inst_name) > 31) {
        my $len_diff = length($bump_inst_name) - 31 + 1;
        if ($bump_inst_name =~ /^(\S+?)(__.*)?$/) {
          my $net = $1;
          my $rest = $2;
          $net =~ s/\S{$len_diff}$/X/;
          print("Trimmed $bump_inst_name to");
          $bump_inst_name = "${net}";
          $bump_inst_name .= "${rest}" if defined $rest;
          print(" $bump_inst_name\n");
        }
      }

      printf $AIF_fh "%-${bump_max_length}s %-40s %-20s %-10s %-10s %-10s\n", $bump_net_name, $bump_inst_name, $bump_cell_name, $x_aif, $y_aif, "";
      printf $CSV_fh "${bump_inst_name},${x_out},${y_out},${bump_net_name}\n"; 
      if (defined $block_via_layer) {
        # Coords x_out and y_out are for center of current bump
        # Get LL and UR coords
        my $x1 = $x_out - ($bump_width / 2);
        my $y1 = $y_out - ($bump_height / 2);
        my $x2 = $x1 + $bump_width;
        my $y2 = $y1 + $bump_height;
        # Extra 4um of boundary around bounding box of bump
        $x1 -= 4;
        $y1 -= 4;
        $x2 += 4;
        $y2 += 4;
        print $fh_blockage "create_routing_blockage -layers $block_via_layer -boundary {{$x1 $y1} {$x2 $y2}} -name_prefix BUMP_VIA_BLOCKAGE\n";
      }
      $mapped_count++;

      $cur_x += $hori_spacing;
    }

    $cur_x = $starting_x;
    $cur_y -= $vert_spacing;
  }

  # Report stats
  my $hori_chip_edge_to_bump_edge_distance = $starting_x - ($cx1 + ($bump_width / 2));
  my $vert_chip_edge_to_bump_edge_distance = ($cy2 - ($bump_width / 2)) - $starting_y;
  print "# Mapped bumps: $mapped_count\n";
  #print "# Unmapped bumps: $unmapped_count\n";
  print "# Horizontal distance from chip edge to edge of first bump: $hori_chip_edge_to_bump_edge_distance\n";
  print "# Vertical distance from chip edge to edge of first bump: $vert_chip_edge_to_bump_edge_distance\n";

  &Hydra::Util::File::close_file($CSV_fh);
  &Hydra::Util::File::close_file($AIF_fh);
  if (defined $block_via_layer) {
    &Hydra::Util::File::close_file($fh_blockage);
  }
}

sub bump_map2 {
  my $design           = &Hydra::Util::Option::get_opt_value_scalar("-design", "strict");
  my $id_csv           = &Hydra::Util::Option::get_opt_value_scalar("-id_csv", "relaxed", undef);
  my $bump_width       = &Hydra::Util::Option::get_opt_value_scalar("-bump_size", "strict");
  my $bump_height      = $bump_width;
  my $signal_bump_name = &Hydra::Util::Option::get_opt_value_scalar("-signal_bump_cell", "strict");
  my $ur_chip_coords   = &Hydra::Util::Option::get_opt_value_scalar("-ur_chip_coords", "strict");
  my $block_via_layer  = &Hydra::Util::Option::get_opt_value_scalar("-block_via_layer", "relaxed", undef);

  # Read id csv file
  my @bumps = ();
  my $bump_max_length = 0;
  if (defined $id_csv) {
    my $line_num = 0;
    my $fh_id = &Hydra::Util::File::open_file_for_read($id_csv);
    while (my $line = <$fh_id>) {
      $line_num++;
      # Skip line 1 header
      next if ($line_num == 1);
      my ($id, $signal, $inst_base, $cell, $ori, $width, $pad_x, $pad_y, $bump_x, $bump_y, $phys) = split(/\,/, $line);
      next if ($id eq "");

      if (length($signal) > $bump_max_length) {
        $bump_max_length = length($signal);
      }

      my %bump = (id     => $id,
                  signal => $signal,
                  x      => $bump_x,
                  y      => $bump_y);
      push(@bumps, \%bump);
    }
    &Hydra::Util::File::close_file($fh_id);
  }

  # Write output script
  my $mapped_count   = 0;
  my $unmapped_count = 0;
  my %seen = ();
  my $CSV_fh = &Hydra::Util::File::open_file_for_write("$design.bump_map.csv");
  my $AIF_fh = &Hydra::Util::File::open_file_for_write("$design.bump_map.aif");
  my $fh_blockage;
  if (defined $block_via_layer) {
    $fh_blockage = &Hydra::Util::File::open_file_for_write("${design}.bump_via_blockage.tcl");
  }

  my ($cx2, $cy2) = split(/\,/, $ur_chip_coords);
  my $midx = $cx2 / 2;
  my $midy = $cy2 / 2;
  # Prep the AIF file header
  print $AIF_fh "[DATABASE]\n";
  print $AIF_fh "TYPE=AIF\n";
  print $AIF_fh "VERSION=2.0\n";
  print $AIF_fh "UNITS=UM\n";
  print $AIF_fh "\n";
  print $AIF_fh "[DIE]\n";
  print $AIF_fh "NAME=$design\n";
  print $AIF_fh "WIDTH=$cx2\n";
  print $AIF_fh "HEIGHT=$cy2\n";
  print $AIF_fh "\n";
  print $AIF_fh "[NETLIST]\n";
  #print $AIF_fh ";\t\tNetBumpName\t\tBumpRef\tBump_X\tBump_Y\tBall#\n";
  printf $AIF_fh "\;%-${bump_max_length}s %-40s %-20s %-10s %-10s %-10s\n", "Net", "BumpName", "BumpRef", "Bump_X", "Bump_Y", "Ball#";
  print $AIF_fh "\n";

  foreach my $href_bump (@bumps) {
    my $pad_id    = $href_bump->{id};
    my $bump_name = $href_bump->{signal};

    # If no bump name specified, then do not create a bump and leave the space empty
    next if ($bump_name eq "" || $pad_id eq "");

    # Bump name in spreadsheet denotes net name to be connected to bump
    my $bump_net_name = $bump_name;

    # Use flag for not doing assignSigToBump on DUMMY/NC since bump_name gets modified later on and cant be checked
    my $assign_sig = 1;
    if ($bump_name eq "DUMMY" || $bump_name eq "NC") {
      $assign_sig = 0;
      $bump_net_name = "-";
    }

    # Remove brackets for naming purposes
    $bump_name =~ s/\[(\S+?)\]/$1/g;

    # Use signal bump for entries with empty bump type
    my $bump_cell_name = $signal_bump_name;
    
    # Edit name for duplicates
    if (defined $seen{$bump_name}) {
      my $suffix = $seen{$bump_name};
      $seen{$bump_name} += 1;
    }
    else {
      $seen{$bump_name} = 1;
    }

    # Add pad ID
    $bump_name = "${bump_name}__${pad_id}";
    
    my $x_out = $href_bump->{x};
    my $y_out = $href_bump->{y};
    my $x_aif = $x_out - $midx;
    my $y_aif = $y_out - $midy;
    my $bump_inst_name = $bump_name;

    # Trim bump inst name down to 31 characters
    if (length($bump_inst_name) > 31) {
      my $len_diff = length($bump_inst_name) - 31 + 1;
      if ($bump_inst_name =~ /^(\S+?)(__.*)?$/) {
        my $net = $1;
        my $rest = $2;
        $net =~ s/\S{$len_diff}$/X/;
        print("Trimmed $bump_inst_name to");
        $bump_inst_name = "${net}";
        $bump_inst_name .= "${rest}" if defined $rest;
        print(" $bump_inst_name\n");
      }
    }

    printf $AIF_fh "%-${bump_max_length}s %-40s %-20s %-10s %-10s %-10s\n", $bump_net_name, $bump_inst_name, $bump_cell_name, $x_aif, $y_aif, "";
    printf $CSV_fh "${bump_inst_name},${x_out},${y_out},${bump_net_name}\n"; 
    if (defined $block_via_layer) {
      # Coords x_out and y_out are for center of current bump
      # Get LL and UR coords
      my $x1 = $x_out - ($bump_width / 2);
      my $y1 = $y_out - ($bump_height / 2);
      my $x2 = $x1 + $bump_width;
      my $y2 = $y1 + $bump_height;
      # Extra 4um of boundary around bounding box of bump
      $x1 -= 4;
      $y1 -= 4;
      $x2 += 4;
      $y2 += 4;
      print $fh_blockage "create_routing_blockage -layers $block_via_layer -boundary {{$x1 $y1} {$x2 $y2}} -name_prefix BUMP_VIA_BLOCKAGE\n";
    }
    $mapped_count++;
  }

  # Report stats
  print "# Mapped bumps: $mapped_count\n";
  &Hydra::Util::File::close_file($CSV_fh);
  &Hydra::Util::File::close_file($AIF_fh);
  if (defined $block_via_layer) {
    &Hydra::Util::File::close_file($fh_blockage);
  }
}

1;
