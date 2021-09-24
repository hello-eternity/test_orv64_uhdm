#------------------------------------------------------
# Module Name: TraceHierarchy
# Date:        Fri Sep 20 11:52:18 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::TraceHierarchy;

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
# sub trace_hierarchy {
#   my $start_time = time;

#   &trace_hierarchy2;

#   my $run_time = (time - $start_time) / 60;
#   print "trace_clock finished in $run_time minutes\n";

#   ## DEBUG
#   use Memory::Usage;
#   my $Mem = Memory::Usage->new();
#   $Mem->record('mem usage after trace_hierarchy');
#   $Mem->dump();
# }

sub trace_hierarchy {
  &Hydra::Liberty::read_lib;

  # Disable unnecessary net connection resolution when
  #   looking at only instance hierarchy
  &Hydra::Verilog::disable_resolve_conn;

  &Hydra::Verilog::read_netlist;

  my $Design        = &Hydra::Verilog::get_design;
  my $TopInst       = $Design->get_top_inst;
  my $top_inst_name = $TopInst->get_name;

  my %data = ();
  # %data => {
  #   $module_name => \%module
  # }
  # %module => {
  #     std_count|std_sum|mod_count|macro_count|pad_count|flop_count|flop_sum = <int>
  #     macro_list|pad_list => []
  #     submodules => { $module_name => \%module }
  # }

  &Hydra::Util::File::print_unbuffered("INFO: Tracing hierarchy of top module $top_inst_name...\n");

  $data{$top_inst_name} = {};
  &trace_hier($TopInst, $data{$top_inst_name});

  my $fh_out = &Hydra::Util::File::open_file_for_write("${top_inst_name}.hier_trace.rpt");
  &print_hier($fh_out, $top_inst_name, $data{$top_inst_name}, 0);
  &Hydra::Util::File::close_file($fh_out);
}

sub trace_hier {
  my ($Inst, $href_data) = @_;
  $href_data->{std_count}   = 0;
  $href_data->{std_sum}     = 0;
  $href_data->{mod_count}   = 0;
  $href_data->{macro_count} = 0;
  $href_data->{pad_count}   = 0;
  $href_data->{flop_count}  = 0;
  $href_data->{flop_sum}    = 0;
  $href_data->{macro_list}  = [];
  $href_data->{pad_list}    = [];
  $href_data->{cell}        = $Inst->get_module->get_name;

  foreach my $SubInst ($Inst->get_instance_list) {
    my $subinst_name = $SubInst->get_name;
    my $subinst_type = $SubInst->get_module->get_type;
    my $subinst_cell = $SubInst->get_module->get_name;

    # Override type if instance is a flop, which is not checked by verilog parser
    if (($subinst_type eq "cell" || $subinst_type eq "pad") &&
        &Hydra::Verilog::is_flop($SubInst)) {
      $subinst_type = "flop";
    }

    if ($subinst_type eq "module") {
      $href_data->{mod_count}++;
      $href_data->{submodules}{$subinst_name} = {};
      &trace_hier($SubInst, $href_data->{submodules}{$subinst_name});

      # Include subcounts in overall count for std_sum and flop_sum
      $href_data->{std_sum}  += $href_data->{submodules}{$subinst_name}{std_sum};
      $href_data->{flop_sum} += $href_data->{submodules}{$subinst_name}{flop_sum};
    }
    elsif ($subinst_type eq "cell") {
      $href_data->{std_count}++;
      $href_data->{std_sum}++;
    }
    elsif ($subinst_type eq "macro") {
      $href_data->{macro_count}++;
      push(@{ $href_data->{macro_list} }, "$subinst_name $subinst_cell");
    }
    elsif ($subinst_type eq "pad") {
      $href_data->{pad_count}++;
      push(@{ $href_data->{pad_list} }, "$subinst_name $subinst_cell");
    }
    elsif ($subinst_type eq "flop") {
      $href_data->{flop_count}++;
      $href_data->{flop_sum}++;
    }
    else {
      # Unknown counts as a std cell
      $href_data->{std_count}++;
      $href_data->{std_sum}++;
    }
  }
}

sub print_hier {
  my ($fh_out, $inst_name, $href_data, $level) = @_;
  my $cell_name = $href_data->{cell};
  my $indent = "  " x $level;

  my $std_count       = "";
  my $flop_count      = "";
  my $mod_count       = "mod=$href_data->{mod_count}";
  my $macro_count     = "macro=$href_data->{macro_count}";
  my $pad_count       = "pad=$href_data->{pad_count}";
  my $aref_macro_list = $href_data->{macro_list};
  my $aref_pad_list   = $href_data->{pad_list};
  if ($href_data->{std_count} == $href_data->{std_sum} && $href_data->{std_count} != 0) {
    $std_count = "std=$href_data->{std_count}";
  }
  else {
    $std_count .= "std=$href_data->{std_count} "   if ($href_data->{std_count} != 0);
    $std_count .= "std_sum=$href_data->{std_sum} " if ($href_data->{std_sum} != 0);
    $std_count =~ s/\s+$//;
  }
  $mod_count   = "" if ($href_data->{mod_count} == 0);
  $macro_count = "" if ($href_data->{macro_count} == 0);
  $pad_count   = "" if ($href_data->{pad_count} == 0);
  if ($href_data->{flop_count} == $href_data->{flop_sum} && $href_data->{flop_count} != 0) {
    $flop_count = "flop=$href_data->{flop_count}";
  }
  else {
    $flop_count .= "flop=$href_data->{flop_count} "   if ($href_data->{flop_count} != 0);
    $flop_count .= "flop_sum=$href_data->{flop_sum} " if ($href_data->{flop_sum} != 0);
    $flop_count =~ s/\s+$//;
  }

  print $fh_out "${indent}(${level}) ${inst_name} [module: ${cell_name}] ${std_count} ${mod_count} ${macro_count} ${pad_count} ${flop_count}\n";
  my $next_level = $level+1;
  foreach my $macro_string (@$aref_macro_list) {
    my ($macro_name, $macro_cell) = split(/\s+/, $macro_string);
    print $fh_out "  ${indent}(${next_level}) ${macro_name} [ref: ${macro_cell}] {MACRO}\n";
  }
  foreach my $pad_string (@$aref_pad_list) {
    my ($pad_name, $pad_cell) = split(/\s+/, $pad_string);
    print $fh_out "  ${indent}(${next_level}) ${pad_name} [ref: ${pad_cell}] {PAD}\n";
  }

  foreach my $sub_name (sort keys %{ $href_data->{submodules} }) {
    &print_hier($fh_out, $sub_name, $href_data->{submodules}{$sub_name}, $level+1);
  }
}

1;
