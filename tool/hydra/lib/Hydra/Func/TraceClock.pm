#------------------------------------------------------
# Module Name: TraceClock
# Date:        Fri Aug 23 14:29:49 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::TraceClock;

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
# sub trace_clock {
#   my $start_time = time;

#   &trace_clock2;

#   my $run_time = (time - $start_time) / 60;
#   print "trace_clock finished in $run_time minutes\n";

#   ## DEBUG
#   use Memory::Usage;
#   my $Mem = Memory::Usage->new();
#   $Mem->record('mem usage after trace_clock');
#   $Mem->dump();
# }

sub trace_clock {
  &Hydra::Liberty::read_lib;
  &Hydra::Verilog::read_netlist;

  my $aref_clocks = &Hydra::Util::Option::get_opt_value_array("-clocks", "strict");
  my $top_module  = &Hydra::Util::Option::get_opt_value_scalar("-top_module", "strict");
  my $Design      = &Hydra::Verilog::get_design;

  # Check that all clock startpoints exist
  my @clocks = ();
  foreach my $clock_string (@$aref_clocks) {
    my ($clock_name, $clock_startp) = split(/\:/, $clock_string);
    $clock_startp = "${top_module}/${clock_startp}";
    my $Startp = &Hydra::Verilog::get_object_from_hier_name($Design, $clock_startp);
    if (!defined $Startp) {
      &Hydra::Util::File::print_unbuffered("WARN: Skipping clock $clock_name with non-existing startpoint: " . &remove_top_module($clock_startp) . "\n");
    }
    else {
      push(@clocks, $clock_string);
    }
  }
  
  my %roots = ();
  # %roots =
  #   trace|check = <startp>
  #
  # Trace is a list of startpoints to begin trace on
  # Check is a list of points that trace should stop on
  #
  foreach my $clock_string (@clocks) {
    my ($clock_name, $clock_startp) = split(/\:/, $clock_string);
    $clock_startp = "${top_module}/${clock_startp}";

    # If the startpoint is a module pin, then attempt to trace backwards until
    #   the driving instance is found and use that as the startpoint
    my $orig_startp = $clock_startp;
    my $move_warn   = "";
    while (&is_module_port($clock_startp)) {
      my $new_startp = &get_clock_driving_point($clock_startp);
      if (defined $new_startp) {
        $move_warn  = "INFO: Moved module pin startpoint for clock $clock_name\n";
        $move_warn .= "      " . &remove_top_module($clock_startp) . " --> " . &remove_top_module($new_startp) . "\n";
        $clock_startp = $new_startp;
      }
      else {
        $move_warn = "INFO: Unable to move module pin startpoint for clock $clock_name\n";
        $clock_startp = $orig_startp;
        last;
      }
    }
    if ($move_warn ne "") {
      &Hydra::Util::File::print_unbuffered($move_warn);
    }

    # Save all clock roots to identify stop points during trace
    if (defined $roots{trace}{$clock_startp}) {
      &Hydra::Util::File::print_unbuffered("WARN: Redefining previously defined clock point at name=${clock_name} point=" . &remove_top_module($clock_startp) . "\n");
    }
    $roots{trace}{$clock_startp} = $clock_name;
    $roots{check}{$clock_startp} = $clock_name;

    # Add instance of the startpoint to the root list so that trace stops on it
    #   even if the pin point is not reached (as long as D or CP is reached)
    $clock_startp =~ s/\/[^\s\/]+$//;
    $roots{check}{$clock_startp} = $clock_name;
  }

  my $clock_count = scalar(keys %{ $roots{trace} });
  &Hydra::Util::File::print_unbuffered("INFO: Tracing ${clock_count} clocks...\n");

  # First pass: mark all paths in netlist structure with breadcrumbs
  # This allows reconvergence paths to be identified
  my %startp_fanout = ();
  my %lb_insts      = ();
  foreach my $clock_startp (sort {$roots{trace}{$a} cmp $roots{trace}{$b}} keys %{ $roots{trace} }) {
    my $clock_name = $roots{trace}{$clock_startp};
    my $Startp     = &Hydra::Verilog::get_object_from_hier_name($Design, $clock_startp);
    
    my %fanout = ();
    my %comb   = ();
    # %comb => {
    #   global => {
    #     $Node => 1,
    #   }
    #   icg => {
    #     $icg_node => {
    #       status => pre|post,
    #       pre|post => {
    #         $Node => 1
    #       }
    #     }
    #   }
    &do_clock_trace("-mode"     => "mark",
                    "-node"      => $Startp,
                    "-fanout"   => \%fanout,
                    "-comb"     => \%comb,
                    "-roots"    => \%roots,
                    "-lb_insts" => \%lb_insts,
                    "-is_root"  => 1);
    $startp_fanout{$clock_name} = \%fanout;
  }

  # Second pass: trace and print through paths marked in first pass; stop at reconvergence points
  my $fh_out = &Hydra::Util::File::open_file_for_write("${top_module}.trace_clock.rpt");
  my $fh_sum = &Hydra::Util::File::open_file_for_write("${top_module}.trace_clock.rpt.sum");
  my $fh_icg = &Hydra::Util::File::open_file_for_write("${top_module}.trace_clock.rpt.collapse_icg");
  my %reconv = ();
  foreach my $clock_startp (sort {$roots{trace}{$a} cmp $roots{trace}{$b}} keys %{ $roots{trace} }) {
    my $clock_name = $roots{trace}{$clock_startp};
    my $Startp     = &Hydra::Verilog::get_object_from_hier_name($Design, $clock_startp);
    &multi_print([$fh_out, $fh_sum, $fh_icg], "\nCLOCK: $clock_name ROOT: " . &remove_top_module($clock_startp) . "\n");
    &do_clock_trace("-mode"     => "print",
                    "-node"      => $Startp,
                    "-fh_out"   => $fh_out,
                    "-fh_sum"   => $fh_sum,
                    "-fh_icg"   => $fh_icg,
                    "-level"    => 0,
                    "-icg_level" => 0,
                    "-reconv"   => \%reconv,
                    "-roots"    => \%roots,
                    "-lb_insts" => \%lb_insts,
                    "-is_root"  => 1,
                    "-root_name" => $clock_name);
  }



  # Third pass: trace and print through subtrees after every reconvergence point
  &do_subtree_trace($fh_out, $fh_sum, $fh_icg, \%reconv, \%roots, \%lb_insts);

  &Hydra::Util::File::close_file($fh_out);
  &Hydra::Util::File::close_file($fh_sum);
  &Hydra::Util::File::close_file($fh_icg);
}

sub do_subtree_trace {
  my ($fh_out, $fh_sum, $fh_icg, $href_reconv, $href_roots, $href_lb_insts, $href_traced_subtrees) = @_;
  $href_traced_subtrees = {} if (!defined $href_traced_subtrees);
  my %this_reconv = ();

  foreach my $subtree_name (sort keys %$href_reconv) {
    if (!defined $href_traced_subtrees->{$subtree_name}) {
      # Subtrees should only be printed once. 
      # This avoid a case where an already existing subtreeA can be nested inside another subtreeB,
      # resulting in subtreeA being printed again
      my $Node = $href_reconv->{$subtree_name}{node};
      &multi_print([$fh_out, $fh_sum, $fh_icg], "\nSUBTREE: $subtree_name\n");
      &do_clock_trace("-mode"     => "print",
                      "-node"     => $Node,
                      "-fh_out"   => $fh_out,
                      "-fh_sum"   => $fh_sum,
                      "-fh_icg"   => $fh_icg,
                      "-level"    => 0,
                      "-icg_level" => 0,
                      "-reconv"   => \%this_reconv,
                      "-roots"    => $href_roots,
                      "-lb_insts" => $href_lb_insts,
                      "-root_name" => $subtree_name);
      $href_traced_subtrees->{$subtree_name} = 1;
    }
  }

  # Trace nested subtrees if they exist
  if (scalar(keys %this_reconv) > 0) {
    &do_subtree_trace($fh_out, $fh_sum, $fh_icg, \%this_reconv, $href_roots, $href_lb_insts, $href_traced_subtrees);
  }

  return;
}

sub do_clock_trace {
  my %args = @_;
  my $Node        = $args{-node};
  my $mode        = $args{-mode};
  my $fh_out      = $args{-fh_out};
  my $fh_sum      = $args{-fh_sum};
  my $fh_icg      = $args{-fh_icg};
  my $href_reconv = $args{-reconv};
  my $level       = $args{-level};
  $level = 0 if (!defined $level);
  my $icg_level   = $args{-icg_level};
  $icg_level = 0 if (!defined $icg_level);
  my $href_fanout = $args{-fanout};
  $href_fanout    = {} if (!defined $href_fanout);
  my $is_root     = $args{-is_root};
  $is_root        = 0 if (!defined $is_root);
  my $href_roots  = $args{-roots};
  $href_roots     = {} if (!defined $href_roots);
  my $href_lb_insts = $args{-lb_insts};
  $href_lb_insts  = {} if (!defined $href_lb_insts);
  my $root_name   = $args{-root_name};

  # Comb count is reset at root so that pre count does not falsely include branches
  my $href_comb   = $args{-comb};
  $href_comb      = {} if (!defined $href_comb || $is_root);

  # Create a copy of the pre (global) comb count to pass down
  if ($mode eq "mark") {
    $href_comb   = &clone_comb($href_comb);
    $args{-comb} = $href_comb;
  }

  my $aref_user_macros = &Hydra::Util::Option::get_opt_value_array("-macro_cells", "relaxed", []);
  my %search_user_macros = map {$_ => 1} @$aref_user_macros;

  # %reconv => {
  #   $subtree_name => Pin_object
  # }
  # %fanout => {
  #   $type => <int> num of nodes of this type
  # }
  # %lb_insts => {
  #   $inst_name => 1, loopback exists in this inst
  # }

  my $indent     = "  " x $level;
  my $icg_indent = "  " x $icg_level;
  my $node_name  = $Node->get_name;
  my $cell_name  = $Node->get_parent->get_module->get_name;
  my $cell_type  = $Node->get_parent->get_module->get_type;
  my $inst_name  = $Node->get_parent->get_hier_name;
  my $inst_cell  = $cell_name;

  #&Hydra::Util::File::print_unbuffered("at Node mode=$mode level=$level node=$node_name inst=$inst_name cell=$cell_name cell_type=$cell_type dir=" . $Node->get_direction . "\n");

  # Check for loopback endpoint when marking
  if ($mode eq "mark" || $mode eq "loopback") {
    my $inst_breadcrumb = &get_breadcrumb($Node->get_parent);
    if (defined $inst_breadcrumb && $inst_breadcrumb =~ /loopback_endpoint/) {
      $href_lb_insts->{$inst_name} = 1;
    }
  }

  if ($mode eq "mark") {
    # Stop if this node was already traversed; for avoiding infinite inout loops
    return if (&has_breadcrumb($Node));
    &add_breadcrumb($Node);
    &add_breadcrumb($Node->get_parent);
  }
  elsif ($mode eq "print") {
    # Only trace through Nodes marked by mark mode
    return if (!&has_breadcrumb($Node));

    # Stop if this node was marked by print mode; for avoiding infinite inout loops
    return if (&get_breadcrumb($Node) =~ /:::${root_name}:::/);
    &append_breadcrumb($Node, ":::${root_name}:::");
    &append_breadcrumb($Node->get_parent, ":::${root_name}:::");
  }

  # Always stop at a clock root
  if ((defined $href_roots->{check}{"${inst_name}/${node_name}"} || defined $href_roots->{check}{$inst_name}) && !$is_root && $mode ne "loopback") {
    # For matching clock root instance (not pin): check that the current node is either the D or CP pin of a flop to be considered a CLOCK_ROOT
    my $skip_inst_match = 1;
    my $clock_name;
    if (defined $href_roots->{check}{"${inst_name}/${node_name}"}) {
      $skip_inst_match = 0;
      $clock_name = $href_roots->{check}{"${inst_name}/${node_name}"};
    }
    elsif (defined $href_roots->{check}{$inst_name}) {
      if (&Hydra::Verilog::is_flop($Node->get_parent)) {
        my $CellLib     = $Node->get_parent->get_module->get_lib; #&Hydra::Liberty::find_cell_lib($cell_name);
        my $PinLib      = $CellLib->find_pin($node_name);
        if ($PinLib->is_simple_attribute_equal_to("nextstate_type", "data") ||
            $PinLib->is_simple_attribute_true("clock")) {
          $skip_inst_match = 0;
          $clock_name = $href_roots->{check}{$inst_name};
        }
      }
    }
    
    unless ($skip_inst_match) {
      my $loopback = "";
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) ". &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] {CLOCK_ROOT:" . &remove_top_module($clock_name) . "}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) ". &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] {CLOCK_ROOT:" . &remove_top_module($clock_name) . "}\n" if ($mode eq "print");
      &increment_fanout($href_fanout, "CLOCK_ROOT") if ($mode eq "mark");
      return;
    }
  }

  my $direction = $Node->get_direction;
  my $fanout    = "";
  $fanout = &get_pin_clock_fanout($Node) if ($mode eq "print");

  if ($direction eq "input" || $direction eq "inout") {
    # Node is an input pin
    if ($cell_type eq "macro" || &is_user_macro(\%search_user_macros, $inst_cell)) {
      # Stop on macro
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {MACRO}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {MACRO}\n" if ($mode eq "print");
      &increment_fanout($href_fanout, "MACRO") if ($mode eq "mark");
      return;
    }
    elsif ($cell_type eq "module") {
      # Trace through module pins
      if ($is_root) {
        # Print if this is a module pin that is a clock root
        if ($mode eq "print") {
          if ($Node->get_parent->is_top) {
            &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {INPUT PORT}\n");
            print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {INPUT PORT}\n";
          }
          else {
            &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {INPUT MODULE PIN}\n");
            print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {INPUT MODULE PIN}\n";
          }

          my $sink_fanout = &get_non_macro_sink_fanout($Node);
          if ($sink_fanout > 0) {
            my $nextlevel  = $level+1;
            my $nextindent = "  " x $nextlevel;
            print $fh_sum "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${sink_fanout}\n";
          }
          my $icg_sink_fanout = &get_non_macro_sink_fanout($Node, "icg");
          if ($icg_sink_fanout > 0) {
            my $nextlevel  = $icg_level+1;
            my $nextindent = "  " x $nextlevel;
            print $fh_icg "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${icg_sink_fanout}\n";
          }
        }
        my %fanout = ();
        my %topts = %args;
        $topts{-level}     = $level+1;
        $topts{-icg_level} = $icg_level+1;
        $topts{-fanout}    = \%fanout;
        $topts{-is_root}   = 0;
        foreach my $Conn ($Node->get_connection_list("output_inout")) {
          $topts{-node} = $Conn;
          &do_clock_trace(%topts);
        }
        &propagate_icg_mode_fanout($href_fanout, \%fanout);
        if ($mode eq "mark" && !&has_breadcrumb_data($Node)) {
          &add_breadcrumb_data($Node, \%fanout);
        }
      }
      else {
        # Dont print if this is a module pin that is not a clock root
        my %topts = %args;
        $topts{-is_root} = 0;
        foreach my $Conn ($Node->get_connection_list("output_inout")) {
          $topts{-node} = $Conn;
          &do_clock_trace(%topts);
        }
      }
    }
    elsif ($cell_type eq "cell" || $cell_type eq "pad") {
      my $subtree_base_name = "SUBTREE_" . &remove_top_module($inst_name);
      if (&is_icg_clock_pin($Node)) {
        # Node is the clock pin at an icg; trace through
        if ($mode eq "mark") {
          # Store pre count in icg node
          my $href_icg_comb = &get_breadcrumb_data($Node->get_parent);
          $href_icg_comb = {} if (!defined $href_icg_comb);
          foreach my $CombNode (keys %{ $href_comb->{global} }) {
            $href_icg_comb->{pre}{$CombNode} = 1;
          }
          &add_breadcrumb_data($Node->get_parent, $href_icg_comb);

          # Start the ICG status at pre in case the ICG has no fanout
          $href_comb->{icg}{$Node->get_parent}{status} = "pre";
        }

        # Trace through ICG to output pin
        my @OutNodes  = &Hydra::Liberty::trace_to_icg_output($Node);
        if (scalar(@OutNodes) > 0) {
          foreach my $OutNode (@OutNodes) {
            my $pin_name = $OutNode->get_name;
            &add_breadcrumb($OutNode) if ($mode eq "mark");
            &append_breadcrumb($OutNode, ":::${root_name}:::") if ($mode eq "print");

            if ($mode eq "print") {
              # Check for reconvergence point
              my $inst_fanin = &get_output_pin_fanin($OutNode);
              if ($inst_fanin > 1) {
                my $subtree_name = "${subtree_base_name}_PIN_${pin_name}";
                # Stop at reconvergence point and store OutNode for later print/trace
                $href_reconv->{$subtree_name}{node}  = $OutNode;
                $href_reconv->{$subtree_name}{level} = $level+1;
                $href_reconv->{$subtree_name}{icg_level} = $icg_level+1;
                &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {${subtree_name}}\n");
                print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {${subtree_name}}\n";
                return;
              }
              elsif (defined $href_roots->{check}{"${inst_name}/${pin_name}"} && !$is_root) {
                # Always stop at clock root; check the output pin
                my $clock_name = $href_roots->{check}{"${inst_name}/${pin_name}"};
                &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] {CLOCK_ROOT:" . &remove_top_module($clock_name) . "}\n");
                print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] {CLOCK_ROOT:" . &remove_top_module($clock_name) . "}\n";
                return;
              }
              else {
                $fanout = &get_pin_clock_fanout($OutNode);
                my $pre_comb_cell_count  = &get_pre_icg_comb_cell_count($OutNode->get_parent);
                my $post_comb_cell_count = &get_post_icg_comb_cell_count($OutNode->get_parent);
                &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} ${pre_comb_cell_count} ${post_comb_cell_count} {ICG}\n");

                my $sink_fanout = &get_non_macro_sink_fanout($OutNode);
                if ($sink_fanout > 0) {
                  my $nextlevel  = $level+1;
                  my $nextindent = "  " x $nextlevel;
                  print $fh_sum "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${sink_fanout}\n";
                }
              }
            }
            if ($mode eq "mark") {
              &increment_fanout($href_fanout, "ICG");

              # Change status for this ICG to count comb cells towards post-count
              $href_comb->{icg}{$Node->get_parent}{status} = "post";
            }

            my %fanout = ();
            my %topts  = %args;
            $topts{-level}     = $level+1;
            $topts{-icg_level} = $icg_level;
            $topts{-fanout}    = \%fanout;
            $topts{-is_root}   = 0;
            foreach my $NextConn ($OutNode->get_connection_list("output_inout")) {
              $topts{-node} = $NextConn;
              &do_clock_trace(%topts);
            }

            if ($mode eq "mark" && !&has_breadcrumb_data($OutNode)) {
              &add_breadcrumb_data($OutNode, \%fanout);

              my $sink_fanout = &get_non_macro_sink_fanout($OutNode);
              if ($sink_fanout > 0) {
                # Add ICG flop sinks to the running total of the parent Node, for .icg rpt
                &increment_fanout(\%fanout, "SINK[ICG_MODE]", $sink_fanout);
              }
              my $icg_sink_fanout = &get_non_macro_sink_fanout($OutNode, "icg_only");
              if ($icg_sink_fanout > 0) {
                # If this ICG also has a SINK_ICG fanout entry, then propagate it
                &increment_fanout(\%fanout, "SINK[ICG_MODE]", $icg_sink_fanout);
              }
            }
            if ($mode eq "mark") {
              # Change status for this ICG to count comb cells towards pre-count
              $href_comb->{icg}{$Node->get_parent}{status} = "pre";

              # Store post count in icg node
              my $href_icg_comb = &get_breadcrumb_data($Node->get_parent);
              $href_icg_comb = {} if (!defined $href_icg_comb);
              foreach my $CombNode (keys %{ $href_comb->{icg}{$Node->get_parent}{post} }) {
                $href_icg_comb->{post}{$CombNode} = 1;
              }
              &add_breadcrumb_data($Node->get_parent, $href_icg_comb);
            }
            &propagate_icg_mode_fanout($href_fanout, \%fanout);
          }
        }
      }
      elsif (&is_sink_clock_pin($Node)) {
        # Node is the clock pin at a sink; stop trace
        print $fh_out "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {SINK}\n" if ($mode eq "print");
        &increment_fanout($href_fanout, "SINK") if ($mode eq "mark");
        return;
      }
      else {
        # Node is a regular pin at a std cell; trace through
        my @OutNodes  = &Hydra::Liberty::trace_to_std_cell_output($Node);
        if (scalar(@OutNodes) > 0) {
          foreach my $OutNode (@OutNodes) {
            my $pin_name = $OutNode->get_name;
            &add_breadcrumb($OutNode) if ($mode eq "mark");
            &append_breadcrumb($OutNode, ":::${root_name}:::") if ($mode eq "print");
            
            if ($mode eq "mark") {
              # Store node as comb cell
              $href_comb->{global}{$Node->get_parent} = 1;
              foreach my $ICG_Node (keys %{ $href_comb->{icg} }) {
                my $status = $href_comb->{icg}{$ICG_Node}{status};
                if ($status eq "post") {
                  # Post count guaranteed to be correct when doing this since ICG acts as the root
                  # Pre count is calculated separately or else other branches are falsely counted
                  $href_comb->{icg}{$ICG_Node}{$status}{$Node->get_parent} = 1;
                }
              }
            }

            if ($mode eq "print") {
              my $inst_fanin = &get_output_pin_fanin($OutNode);
              if ($inst_fanin > 1) {
                my $subtree_name = "${subtree_base_name}_PIN_${pin_name}";
                # Stop at reconvergence point and store OutNode for later print/trace
                $href_reconv->{$subtree_name}{node}  = $OutNode;
                $href_reconv->{$subtree_name}{level} = $level+1;
                $href_reconv->{$subtree_name}{icg_level} = $icg_level+1;
                &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {${subtree_name}}\n");
                print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {${subtree_name}}\n";
                return;
              }
              elsif (defined $href_roots->{check}{"${inst_name}/${pin_name}"} && !$is_root) {
                # Always stop at clock root; check the output pin
                my $clock_name = $href_roots->{check}{"${inst_name}/${pin_name}"};
                &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] {CLOCK_ROOT:" . &remove_top_module($clock_name) . "}\n");
                print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] {CLOCK_ROOT:" . &remove_top_module($clock_name) . "}\n";
                return;
              }
              else {
                $fanout = &get_pin_clock_fanout($OutNode);
                if ($cell_type eq "pad") {
                  &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {PAD}\n");
                  print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {PAD}\n";
                }
                else {
                  &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {STD}\n");
                  print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} -> ${pin_name} [ref: ${cell_name}] ${fanout} {STD}\n";
                }

                my $sink_fanout = &get_non_macro_sink_fanout($OutNode);
                if ($sink_fanout > 0) {
                  my $nextlevel  = $level+1;
                  my $nextindent = "  " x $nextlevel;
                  print $fh_sum "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${sink_fanout}\n";
                }
                my $icg_sink_fanout = &get_non_macro_sink_fanout($OutNode, "icg");
                if ($icg_sink_fanout > 0) {
                  my $nextlevel  = $icg_level+1;
                  my $nextindent = "  " x $nextlevel;
                  print $fh_icg "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${icg_sink_fanout}\n";
                }
              }
            }
            &increment_fanout($href_fanout, "STD") if ($mode eq "mark");
            
            my %fanout = ();
            my %topts = %args;
            $topts{-level}  = $level+1;
            $topts{-icg_level} = $icg_level+1;
            $topts{-fanout} = \%fanout;
            $topts{-is_root} = 0;
            foreach my $NextConn ($OutNode->get_connection_list("output_inout")) {
              $topts{-node} = $NextConn;
              &do_clock_trace(%topts);
            }
            &propagate_icg_mode_fanout($href_fanout, \%fanout);
            if ($mode eq "mark" && !&has_breadcrumb_data($OutNode)) {
              &add_breadcrumb_data($OutNode, \%fanout);
            }
          }
        }
        else {
          # Node is a sink if there was no path to trace through
          # Check whether this node was looped back into
          my $loopback = "";
          if ($mode eq "print" && defined $href_lb_insts->{$inst_name}) {
            $loopback = "{LOOPBACK}";
          }
          if ($cell_type eq "pad") {
            &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {PAD} ${loopback}\n") if ($mode eq "print");
            print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {PAD} ${loopback}\n" if ($mode eq "print");
          }
          else {
            &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {SINK} ${loopback}\n") if ($mode eq "print");
            print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {SINK} ${loopback}\n" if ($mode eq "print");
          }
          &increment_fanout($href_fanout, "OTHER_SINK") if ($mode eq "mark");

          return;
        }
      }
    }
    else {
      # Stop on unknown cell
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {NO_LIB}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {NO_LIB}\n" if ($mode eq "print");
      &increment_fanout($href_fanout, "NO_LIB") if ($mode eq "mark");
      return;
    }
  }

  if ($direction eq "output" || ($direction eq "inout" && $level == 0)) {
    # Node is an output pin
    # Node may also be an inout, but only trace through if it is level 0
    #   An inout as an output should only ever need to be encountered here if it is the root of a trace
    #   Since this is an output trace, an inout will always be encountered as an input (and should not trace back out through itself)

    if ($Node->get_parent->is_top && !$is_root) {
      # Stop on top module output port
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {OUTPUT PORT}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {OUTPUT PORT}\n" if ($mode eq "print");
      &increment_fanout($href_fanout, "OUTPUT_PORT") if ($mode eq "mark");
      return;
    }
    elsif ($cell_type eq "module") {
      # Module output port

      if ($is_root) {
        # Report if this module output port is a clock root
        if ($mode eq "print") {
          if ($Node->get_parent->is_top) {
            &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {OUTPUT PORT}\n");
            print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {OUTPUT PORT}\n";
          }
          else {
            &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {OUTPUT MODULE PIN}\n");
            print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${inst_cell}] ${fanout} {OUTPUT MODULE PIN}\n";
          }

          my $sink_fanout = &get_non_macro_sink_fanout($Node);
          if ($sink_fanout > 0) {
            my $nextlevel  = $level+1;
            my $nextindent = "  " x $nextlevel;
            print $fh_sum "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${sink_fanout}\n";
          }
          my $icg_sink_fanout = &get_non_macro_sink_fanout($Node, "icg");
          if ($icg_sink_fanout > 0) {
            my $nextlevel  = $icg_level+1;
            my $nextindent = "  " x $nextlevel;
            print $fh_icg "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${icg_sink_fanout}\n";
          }
        }
        my %fanout = ();
        my %topts = %args;
        $topts{-level}  = $level+1;
        $topts{-icg_level} = $icg_level+1;
        $topts{-fanout} = \%fanout;
        $topts{-is_root} = 0;
        foreach my $Conn ($Node->get_connection_list("output_inout")) {
          $topts{-node} = $Conn;
          &do_clock_trace(%topts);
        }
        &propagate_icg_mode_fanout($href_fanout, \%fanout);
        if ($mode eq "mark" && !&has_breadcrumb_data($Node)) {
          &add_breadcrumb_data($Node, \%fanout);
        }
      }
      else {
        # Dont report regular module output ports
        my %topts = %args;
        $topts{-is_root} = 0;
        foreach my $Conn ($Node->get_connection_list("output_inout")) {
          $topts{-node} = $Conn;
          &do_clock_trace(%topts);
        }
      }
    }
    else {
      # Output pin at a cell; continue trace
      # Typically this only happens at a clock root or subtree startpoint
      my $cell_type_string;
      if ($cell_type =~ /^(module|macro|pad)$/) {
        $cell_type_string = uc($1);
      }
      elsif (&is_user_macro(\%search_user_macros, $inst_cell)) {
        $cell_type_string = "MACRO";
      }
      elsif ($cell_type eq "unknown") {
        $cell_type_string = "NO_LIB";
      }
      else {
        $cell_type_string = "STD";
      }

      my $loopback = "";
      if ($mode eq "print" && defined $href_lb_insts->{$inst_name}) {
        $loopback = "{LOOPBACK}";
      }
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {${cell_type_string}} ${loopback}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {${cell_type_string}} ${loopback}\n" if ($mode eq "print");

      # Mark this cell as a possible loopback endpoint if it is a flop
      # Subtraces from this pin will look for the loopback endpoint while still recording the trace normally
      my $breadcrumb_backup = &get_breadcrumb($Node->get_parent);
      if (&Hydra::Verilog::is_flop($Node->get_parent) && $mode eq "mark") {
        &append_breadcrumb($Node->get_parent, "loopback_endpoint");
      }

      my $sink_fanout = &get_non_macro_sink_fanout($Node);
      if ($sink_fanout > 0) {
        my $nextlevel  = $level+1;
        my $nextindent = "  " x $nextlevel;
        print $fh_sum "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${sink_fanout}\n" if ($mode eq "print");
      }
      my $icg_sink_fanout = &get_non_macro_sink_fanout($Node, "icg");
      if ($icg_sink_fanout > 0) {
        my $nextlevel  = $icg_level+1;
        my $nextindent = "  " x $nextlevel;
        print $fh_icg "${nextindent}(${nextlevel}) ===== FLOP SINKS: ${icg_sink_fanout}\n" if ($mode eq "print");
      }

      &increment_fanout($href_fanout, $cell_type_string) if ($mode eq "mark");
      my %fanout = ();
      my %topts = %args;
      $topts{-level}  = $level+1;
      $topts{-icg_level} = $icg_level+1;
      $topts{-fanout} = \%fanout;
      $topts{-is_root} = 0;
      foreach my $Conn ($Node->get_connection_list("output_inout")) {
        $topts{-node} = $Conn;
        &do_clock_trace(%topts);
      }
      &propagate_icg_mode_fanout($href_fanout, \%fanout);
      if ($mode eq "mark" && !&has_breadcrumb_data($Node)) {
        &add_breadcrumb_data($Node, \%fanout);
      }

      # Unmark cell as loopback endpoint if it was set as one
      if (&Hydra::Verilog::is_flop($Node->get_parent) > 0 && $mode eq "mark") {
        &set_breadcrumb($Node->get_parent, $breadcrumb_backup);
      }
    }
  }
  elsif ($direction eq "undirected") {
    if ($cell_type eq "macro" || defined $search_user_macros{$inst_cell}) {
      # Stop on macro
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {MACRO}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {MACRO}\n" if ($mode eq "print");
      &increment_fanout($href_fanout, "MACRO") if ($mode eq "mark");
      return;
    }
    else {
      # Undirected means that this is an unknown cell; dont trace through
      &multi_print([$fh_out, $fh_sum], "${indent}(${level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {NO_LIB}\n") if ($mode eq "print");
      print $fh_icg "${icg_indent}(${icg_level}) " . &remove_top_module($inst_name) . " : ${node_name} [ref: ${cell_name}] ${fanout} {NO_LIB}\n" if ($mode eq "print");
      &increment_fanout($href_fanout, "NO_LIB") if ($mode eq "mark");
      return;
    }
  }
}

#------------------------------------------------------
# Utilities
#------------------------------------------------------
sub multi_print {
  my ($aref_fh, $line) = @_;
  foreach my $fh (@$aref_fh) {
    print $fh $line;
  }
}

sub remove_top_module {
  my ($name) = @_;
  $name =~ s/^([^\s\/]+)\///;
  return $name;
}

sub clone_comb {
  my ($href_comb) = @_;
  my %new_comb = ();
  
  # Copy pre count
  foreach my $Node (keys %{ $href_comb->{global} }) {
    $new_comb{global}{$Node} = 1;
  }

  # Point directly to post count
  $new_comb{icg} = $href_comb->{icg};
  
  return \%new_comb;
}

sub is_module_port {
  my ($startp) = @_;
  my $Design    = &Hydra::Verilog::get_design;
  my $StartPin  = &Hydra::Verilog::get_object_from_hier_name($Design, $startp);
  my $cell_type = $StartPin->get_parent->get_module->get_type;
  if ($cell_type eq "module") {
    return 1;
  }
  else {
    return 0;
  }
}

sub get_clock_driving_point {
  my ($startp) = @_;
  my $Design   = &Hydra::Verilog::get_design;
  my $StartPin = &Hydra::Verilog::get_object_from_hier_name($Design, $startp);
  return undef if (!defined $StartPin);

  # Get driving pin
  my @conn_list = $StartPin->get_connection_list("input");
  if (scalar(@conn_list) != 1) {
    return undef;
  }
  else {
    return $conn_list[0]->get_hier_name;
  }
}

sub increment_fanout {
  my ($href_fanout, $type, $num) = @_;
  $num = 1 if (!defined $num);
  if (defined $href_fanout->{$type}) {
    $href_fanout->{$type} += $num;
  }
  else {
    $href_fanout->{$type} = $num;
  }
  return;
}

sub has_breadcrumb {
  my ($Node) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data->{breadcrumb} && $href_data->{breadcrumb}) {
    return 1;
  }
  return 0;
}

sub has_breadcrumb_data {
  my ($Node) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data->{breadcrumb_data}) {
    return 1;
  }
  return 0;
}

sub add_breadcrumb {
  my ($Node) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data) {
    $href_data->{breadcrumb} = 1;
  }
  else {
    $href_data = {breadcrumb => 1};
    $Node->set_data($href_data);
  }
}

sub add_breadcrumb_data {
  my ($Node, $href_breadcrumb) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data) {
    $href_data->{breadcrumb_data} = $href_breadcrumb;
  }
  else {
    $href_data = {breadcrumb_data => $href_breadcrumb};
    $Node->set_data($href_data);
  }
}

sub set_breadcrumb {
  my ($Node, $value) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data) {
    $href_data->{breadcrumb} = $value;
  }
  else {
    $href_data = {breadcrumb => $value};
    $Node->set_data($href_data);
  }
}

sub append_breadcrumb {
  my ($Node, $value) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data) {
    if (defined $href_data->{breadcrumb}) {
      $href_data->{breadcrumb} .= "_$value";
    }
    else {
      $href_data->{breadcrumb} = $value;
    }
  }
  else {
    $href_data = {breadcrumb => $value};
    $Node->set_data($href_data);
  }
}

sub get_breadcrumb {
  my ($Node) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data->{breadcrumb}) {
    return $href_data->{breadcrumb};
  }
  else {
    return undef;
  }
}

sub get_breadcrumb_data {
  my ($Node) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data->{breadcrumb_data}) {
    return $href_data->{breadcrumb_data};
  }
  else {
    return undef;
  }
}

sub propagate_icg_mode_fanout {
  my ($href_parent_fanout, $href_child_fanout) = @_;
  # Propagate icg sinks one level up to the parent
  my $type = "SINK[ICG_MODE]";
  if (defined $href_child_fanout->{$type}) {
    if (defined $href_parent_fanout->{"SINK_ICG"}) {
      $href_parent_fanout->{"SINK_ICG"} += $href_child_fanout->{$type};
    }
    else {
      $href_parent_fanout->{"SINK_ICG"} = $href_child_fanout->{$type};
    }
    $href_child_fanout->{$type} = undef;
  }
}

sub is_icg_clock_pin {
  my ($Node) = @_;
  my $CellLib = $Node->get_parent->get_module->get_lib;
  my $NodeLib = $CellLib->find_pin($Node->get_name);
  if (defined $NodeLib && $NodeLib->is_simple_attribute_true("clock_gate_clock_pin")) {
    return 1;
  }
  return 0;
}

sub is_sink_clock_pin {
  my ($Node)= @_;
  my $CellLib = $Node->get_parent->get_module->get_lib;
  my $NodeLib = $CellLib->find_pin($Node->get_name);
  if (defined $NodeLib && $NodeLib->is_simple_attribute_true("clock") && $NodeLib->get_simple_attribute("direction") =~ /input/i) {
    return 1;
  }
  return 0;
}

sub get_output_pin_fanin {
  my ($Node) = @_;
  my $node_name = $Node->get_name;
  my $CellLib   = $Node->get_parent->get_module->get_lib;
  my $NodeLib   = $CellLib->find_pin($node_name);
  my $fanin     = 0;

  if (defined $NodeLib && $NodeLib->is_simple_attribute_true("clock_gate_out_pin")) {
    # Trace ICG cell
    my @InNodes = &Hydra::Liberty::trace_to_icg_input($Node);
    foreach my $InNode (@InNodes) {
      $fanin++ if (&has_breadcrumb($InNode));
    }
  }
  else {
    # Trace std cell
    my @InNodes = &Hydra::Liberty::trace_to_std_cell_input($Node);
    foreach my $InNode (@InNodes) {
      $fanin++ if (&has_breadcrumb($InNode));
    }
  }

  return $fanin;
}

sub get_pre_icg_comb_cell_count {
  my ($Instance) = @_;
  my $href_comb = &get_breadcrumb_data($Instance);
  if (defined $href_comb->{pre}) {
    return "[pre_comb_count: " . scalar(keys %{ $href_comb->{pre} }) . "]";
  }
  return "";
}

sub get_post_icg_comb_cell_count {
  my ($Instance) = @_;
  my $href_comb = &get_breadcrumb_data($Instance);
  if (defined $href_comb->{post}) {
    return "[post_comb_count: " . scalar(keys %{ $href_comb->{post} }) . "]";
  }
  return "";
}

sub get_pin_clock_fanout {
  my ($Node, $mode) = @_;
  $mode = "normal" if (!defined $mode);
  my $href_fanout = &get_breadcrumb_data($Node);
  return "" if (!defined $href_fanout);

  my $fanout = 0;
  foreach my $type (keys %$href_fanout) {
    next if ($type =~ /\[.*\]/);
    if ($mode eq "icg") {
      $fanout += $href_fanout->{$type};
    }
    else {
      next if ($type eq "SINK_ICG");
      $fanout += $href_fanout->{$type};
    }
  }

  if ($fanout == 0) {
    return "";
  }
  else {
    return "[fanout: ${fanout}]";
  }
}

sub get_non_macro_sink_fanout {
  my ($Node, $mode) = @_;
  $mode = "normal" if (!defined $mode);
  my $href_fanout = &get_breadcrumb_data($Node);
  return 0 if (!defined $href_fanout);

  my $fanout = 0;
  foreach my $type (keys %$href_fanout) {
    next if ($type =~ /\[.*\]/);
    if ($mode eq "icg") {
      if ($type eq "SINK" || $type eq "SINK_ICG") {
        $fanout += $href_fanout->{$type};
      }
    }
    elsif ($mode eq "icg_only") {
      if ($type eq "SINK_ICG") {
        $fanout += $href_fanout->{$type};
      }
    }
    else {
      if ($type eq "SINK") {
        $fanout += $href_fanout->{$type};
      }
    }
  }
  
  return $fanout;
}

sub is_user_macro {
  my ($href_search_user_macros, $inst_cell) = @_;
  #if (defined $href_search_user_macros->{$inst_cell}) {
  #  return 1;
  #}

  # Support wildcards
  foreach my $pattern (sort keys %$href_search_user_macros) {
    $pattern = quotemeta($pattern);
    $pattern =~ s/\\\*/.*/g;
    if ($inst_cell =~ /^${pattern}$/) {
      return 1;
    }
  }

  return 0;
}

1;
