#!/usr/bin/perl
#------------------------------------------------------
# Script Name: split_hex
# Date: 
# Author:      
#------------------------------------------------------
use strict;
use warnings;
use Carp;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub main {
  my $file = shift @ARGV;

  my $file_dir = $file;
  if ($file_dir =~ /\//) {
    $file_dir =~ s/\/[^\s\/]+//;
  }
  else {
    $file_dir =~ "./";
  }
  
  my $rank = 0;
  my $bank = 0;
  my $row  = 0;
  my $col  = 0;
  mkdir "${file_dir}/mem_partitions";
  my $outfile = "${file_dir}/mem_partitions/rank${rank}_bank${bank}_row${row}.hex";
  open(my $fh_out, ">", $outfile) or die "Cannot open $outfile\n";
  open(my $fh_header, ">", "${file_dir}/mem_partitions/header.hex") or die "Cannot open ${file_dir}/mem_partitions/header.hex\n";
  open(my $fh_in, "<", $file) or die "Cannot open $file\n";
  my $line;
  for (my $i = 0; $i < 4; $i++) {
    $line = <$fh_in>;
    print $fh_header $line;
  }
  while ($line = <$fh_in>) {
    my $data = $line;
    chomp($data);
    $data =~ s/^\s*//;
    $data =~ s/\s*$//;
    
    print $fh_out "$data\n";
    
    $col++;
    if ($col == 256) {
      $col = 0;
      $row++;
    }
    if ($row == 65536) {
      $row = 0;
      $bank++;
    }
    if ($bank == 8) {
      $bank = 0;
      $rank++;
    }

    if ($col == 0) {
      $outfile = "${file_dir}/mem_partitions/rank${rank}_bank${bank}_row${row}.hex";
      close($fh_out);
      open($fh_out, ">", $outfile) or die "Cannot open $outfile\n";
    }
  }
  close($fh_header);
  close($fh_out);
  close($fh_in);
}

&main;

1;
