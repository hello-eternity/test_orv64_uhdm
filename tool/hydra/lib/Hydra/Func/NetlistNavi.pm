#------------------------------------------------------
# Module Name: NetlistNavi
# Date:        Mon Feb 17 11:08:40 2020
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::NetlistNavi;

use strict;
use warnings;
use Carp;
use Exporter;
use Cwd;
use Term::ANSIColor;
no warnings 'recursion';

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my %glb_condition_check = (
  "cell_type"      => \&check_cell_type_condition,
  "cell_name"      => \&check_cell_name_condition,
  "inst_hier_name" => \&check_inst_hier_name_condition,
  "inst_hier_pin"  => \&check_inst_hier_pin_condition,
  "inst_name"      => \&check_inst_name_condition,
);

my %glb_condition_check_cell_type = (
  "ff"         => \&check_cell_type_ff,
  "macro"      => \&check_cell_type_macro,
  "pad"        => \&check_cell_type_pad,
  "module"     => \&check_cell_type_module,
  "icg"        => \&check_cell_type_icg,
  "std"        => \&check_cell_type_std,
);

# Current node
my $glb_Cursor;

# Top module
my $glb_top_module;

# Previous command
my $glb_prev_cmd = "";

# For conditional trace
my $glb_marker;
my $glb_stop_trace = 0;
my $glb_trace_count = 0;
my $glb_trace_found = 0;

# For recording movements
my $glb_recording = 0;
my @glb_record    = ();

# For debugging
my $glb_fh_debug;
my $glb_debug = 0;

#------------------------------------------------------
# Function Command
#------------------------------------------------------
sub netlist_navi {
  &Hydra::Liberty::read_lib;
  &Hydra::Verilog::read_netlist;

  $glb_top_module = &Hydra::Util::Option::get_opt_value_scalar("-top_module", "strict");

  $glb_fh_debug = &Hydra::Util::File::open_file_for_write("debug.log") if ($glb_debug);

  my $Design  = &Hydra::Verilog::get_design;
  $glb_Cursor = (($Design->get_top_inst->get_pin_list)[0]->get_bit_list)[0];

  my $done = 0;
  while (!$done) {
    eval {
      my $digest = &get_cursor_digest;
      print "\n";
      print &Term::ANSIColor::color('red');
      print "$digest ";
      print &Term::ANSIColor::color('reset');
      print "%> ";
      my $line = <STDIN>;
      chomp($line);

      # Re-do previous command if no command is given
      if ($line =~ /^\s*$/) {
        $line = &get_prev_cmd;
      }
      &set_prev_cmd($line);
      
      my @tokens = split(/\s+/, $line);
      my $cmd = shift @tokens;

      my $starttime = time;
      
      if (defined $cmd) {
        if ($cmd =~ /^h/) {
          &do_help(@tokens);
        }
        elsif ($cmd =~ /^i/) {
          &do_info;
        }
        elsif ($cmd =~ /^p/) {
          &do_pin(@tokens);
        }
        elsif ($cmd =~ /^c/) {
          &do_connection;
        }
        elsif ($cmd =~ /^m/) {
          &do_move(@tokens);
        }
        elsif ($cmd =~ /^j/) {
          &do_jump(@tokens);
        }
        elsif ($cmd =~ /^t/) {
          &do_trace(@tokens);
          my $runtime = (time - $starttime) / 60;
          print "Command completed in $runtime minutes\n";
        }
        elsif ($cmd =~ /^r/) {
          &do_record(@tokens);
        }
        elsif ($cmd =~ /^n/) {
          &do_net;
        }
        elsif ($cmd =~ /^f/) {
          &do_find(@tokens);
          my $runtime = (time - $starttime) / 60;
          print "Command completed in $runtime minutes\n";
        }
        elsif ($cmd =~ /^s/) {
          &do_selection;
        }
        elsif ($cmd eq "exit") {
          $done = 1;
        }
      }
    };

    if ($@) {
      print "Something went wrong! $@\n";
    }
  }

  &Hydra::Util::File::close_file($glb_fh_debug) if ($glb_debug);
}

#----------------------------------------------------------------------------------------------
# Commands
#----------------------------------------------------------------------------------------------
sub do_help {
  my ($cmd) = @_;

  if (!defined $cmd) {
    print "Commands:\n";
    print "  i(nfo)      - Show info on the current node\n";
    print "  p(in)       - Show or move to pins on the instance of the current node\n";
    print "  c(onnection)- Show all connections to the current node\n";
    print "  m(ove)      - Move in the specified direction\n";
    print "  j(ump)      - Jump to the specified hierarchical pin\n";
    print "  t(race)     - Trace until the specified condition is met\n";
    print "  r(ecord)    - Record all movements and save to a file\n";
    print "  n(et)       - Show the net connected to the current node\n";
    print "  f(ind)      - Find and move to any instance\n";
    print "  s(election) - Print an icc2 command that will select the current node\n";
    print "  exit        - Exit the navi\n";
  }
  elsif ($cmd =~ /^i/) {
    print "info\n";
    print "  Show info on the current node.\n";
  }
  elsif ($cmd =~ /^p/) {
    print "pin [NAME]\n";
    print "  Show all pins on the instance of the current node.\n";
    print "  NAME - If a pin name is provided, then you will move to this pin.\n";
  }
  elsif ($cmd =~ /^c/) {
    print "connection\n";
    print "  Show all connections to the current node. This does not include connections through lib cells.\n";
  }
  elsif ($cmd =~ /^m/) {
    print "move input|output\n";
    print "  Move towards the input or output connection of the current node. This includes connections through lib cells.\n";
  }
  elsif ($cmd =~ /^j/) {
    print "jump HIERNAME\n";
    print "  Jump directly to the specified node.\n";
    print "  HIERNAME - The full hierarchical name of the pin, instance, or net to jump to.\n";
  }
  elsif ($cmd =~ /^t/) {
    print "trace input|output COND=NAME\n";
    print "  Trace towards the specified direction (input or output) until the specified condition is met. Input CTRL-C to stop the trace prematurely.\n";
    print "  COND - The type of condition. Possible values:\n";
    foreach my $key (sort keys %glb_condition_check) {
      print "    $key\n";
    }
    print "  NAME - The name of the target, depending on the condition. If the condition is cell_type, then the possible values are:\n";
    foreach my $key (sort keys %glb_condition_check_cell_type) {
      print "    $key\n";
    }
  }
  elsif ($cmd =~ /^r/) {
    print "record start|stop|save [FILE]\n";
    print "  Record all manual trace movements.\n";
    print "  start - Start recording\n";
    print "  stop  - Stop recording\n";
    print "  save  - Save the recording to a file.\n";
    print "  FILE  - Specify a filename to save the recording to for the save command. By default \"record.rpt\" will be used.\n";
  }
  elsif ($cmd =~ /^n/) {
    print "net\n";
    print "  Show the net connected to the current node.\n";
  }
  elsif ($cmd =~ /^f/) {
    print "find MODULE INST\n";
    print "  Find and move to any instance.\n";
    print "  MODULE - The module name of the instance.\n";
    print "  INST   - The non-hierarchical name of the instance.\n";
  }
  elsif ($cmd =~ /^s/) {
    print "selection\n";
    print "  Print an icc2 command that will select the current node.\n";
  }
}

sub do_info {
  print &get_info($glb_Cursor) . "\n";
}

sub do_pin {
  my ($name) = @_;
  if (defined $name) {
    my ($base, $bit) = &Hydra::Verilog::parse_bit($name);
    my $PinHeader = $glb_Cursor->get_parent->get_pin_header($base);
    if ($bit eq "-1" && $PinHeader->has_bus) {
      print "ERROR: Must select bit on bus pin\n";
    }
    else {
      &move_cursor($PinHeader->get_bit($bit));
    }
  }
  else {
    foreach my $Pin ($glb_Cursor->get_parent->get_pin_list) {
      if ($Pin->has_bus) {
        print $Pin->get_name . "[" . $Pin->get_msb . ":" . $Pin->get_lsb . "] (" . $Pin->get_direction . ")\n";
      }
      else {
        print $Pin->get_name . " (" . $Pin->get_direction . ")\n";
      }
    }
  }
}

sub do_connection {
  foreach my $Conn ($glb_Cursor->get_connection_list("input_output_inout_undirected")) {
    print &get_info($Conn) . "\n";
  }
}

sub do_move {
  my ($directive) = @_;
  if (!defined $directive) {
    &do_help("move");
    return;
  }

  my @Conns = ();
  if ($directive =~ /^i/) {
    # Trace towards input
    if ($glb_Cursor->get_direction =~ /^input|inout$/) {
      @Conns = $glb_Cursor->get_connection_list("input_inout");
    }
    elsif ($glb_Cursor->get_direction eq "output") {
      # Trace through cell
      my $cell_type = $glb_Cursor->get_parent->get_module->get_type;
      if ($cell_type eq "macro") {
        print "Cell is an untraceable macro; listing all output pins:\n";
        foreach my $Pin (@{ $glb_Cursor->get_parent->get_pin_list }) {
          if ($Pin->get_direction =~ /^input|inout$/) {
            push(@Conns, $Pin);
          }
        }
      }
      elsif ($cell_type eq "module") {
        @Conns = $glb_Cursor->get_connection_list("input_inout");
      }
      else {
        @Conns = &Hydra::Liberty::trace_to_input($glb_Cursor);
      }
    }
  }
  elsif ($directive =~ /^o/) {
    # Trace towards output
    if ($glb_Cursor->get_direction eq "input") {
      # Trace through cell
      my $cell_type = $glb_Cursor->get_parent->get_module->get_type;
      if ($cell_type eq "macro") {
        print "Cell is an untraceable macro; listing all output pins:\n";
        foreach my $Pin (@{ $glb_Cursor->get_parent->get_pin_list }) {
          if ($Pin->get_direction =~ /^output|inout$/) {
            push(@Conns, $Pin);
          }
        }
      }
      elsif ($cell_type eq "module") {
        @Conns = $glb_Cursor->get_connection_list("output_inout");
      }
      else {
        @Conns = &Hydra::Liberty::trace_to_output($glb_Cursor);
      }
    }
    elsif ($glb_Cursor->get_direction =~ /^output|inout$/) {
      @Conns = $glb_Cursor->get_connection_list("output_inout");
    }
  }

  if (scalar(@Conns) == 0) {
    print "No connection\n";
  }
  elsif (scalar(@Conns) > 1) {
    my $index = &request_node_selection("Select a route: ", @Conns);
    if (defined $index) {
      &move_cursor($Conns[$index]);
    }
  }
  else {
    &move_cursor($Conns[0]);
  }
}

sub do_jump {
  my ($hier_name) = @_;
  $hier_name = "" if (!defined $hier_name);
  $hier_name = &add_top_module($hier_name);

  my $Design = &Hydra::Verilog::get_design;
  my $Node   = &get_object_from_hier_name($Design, $hier_name);
  if (defined $Node) {
    &move_cursor($Node);
  }
}

sub do_trace {
  my ($direction, $condition_string) = @_;
  if (!defined $direction | !defined $condition_string) {
    &do_help("trace");
    return;
  }

  my ($condition_type, $condition_name) = split(/\=/, $condition_string);
  &prepare_trace;

  my $ref_backup = $SIG{INT};
  $SIG{INT} = \&halt_trace;
  print "Starting trace; do CTRL-C to halt\n";
  my @paths = &trace_to_condition($glb_Cursor, $direction, $condition_type, $condition_name);
  $SIG{INT} = $ref_backup;

  my $rpt    = cwd . "/${condition_type}.rpt";
  my $fh_out = &Hydra::Util::File::open_file_for_write($rpt);
  print $fh_out "# Condition Type : $condition_type\n";
  print $fh_out "# Condition Name : $condition_name\n";
  print $fh_out "# Total Paths    : " . scalar(@paths) . "\n";
  print $fh_out "# Startpoint     : " . &get_info($glb_Cursor) . "\n";
  print $fh_out "\n";
  foreach my $aref_path (@paths) {
    print $fh_out "# Endpoint : " . &get_info($aref_path->[$#$aref_path]) . "\n";
    foreach my $Conn (@$aref_path) {
      print $fh_out &get_info($Conn) . "\n";
    }
    print $fh_out "\n";
  }
  &Hydra::Util::File::close_file($fh_out);
  print "Trace report written to $rpt\n";
}

sub do_record {
  my ($cmd, $file) = @_;

  if ($cmd eq "start") {
    $glb_recording = 1;
    @glb_record    = ();
  }
  elsif ($cmd eq "stop") {
    $glb_recording = 0;
    push(@glb_record, $glb_Cursor);
  }
  elsif ($cmd eq "save") {
    $file = cwd . "/record.rpt" if (!defined $file);
    my $fh_out = &Hydra::Util::File::open_file_for_write($file);
    foreach my $Node (@glb_record) {
      print $fh_out &get_info($Node) . "\n";
    }
    &Hydra::Util::File::close_file($fh_out);
    print "Record report written to $file\n";
  }
}

sub do_net {
  #print &remove_top_module($glb_Cursor->get_net) . "\n";
  my @nets = $glb_Cursor->get_net;
  @nets = map { &remove_top_module($_) } @nets;
  print join(" , ", @nets) . "\n";
}

sub do_find {
  my ($module_name, $inst_name) = @_;
  my $module_pattern = &create_pattern($module_name);
  my $inst_pattern   = &create_pattern($inst_name);

  &Hydra::Verilog::disable_resolve_conn;

  my $Design  = &Hydra::Verilog::get_design;
  my $TopInst = $Design->get_top_inst;
  my @Insts = ();
  &do_find_inst($TopInst, $module_pattern, $inst_pattern, \@Insts);

  &Hydra::Verilog::enable_resolve_conn;

  if (scalar(@Insts) == 1) {
    # Do get_object_from_hier_name to force resolve connections
    my $TargetNode = &Hydra::Verilog::get_object_from_hier_name($Design, (($Insts[0]->get_pin_list)[0]->get_bit_list)[0]->get_hier_name);
    &move_cursor($TargetNode);
  }
  elsif (scalar(@Insts) > 1) {
    # Do get_object_from_hier_name to force resolve connections
    my $index = &request_node_selection("Select an instance: ", @Insts);
    if (defined $index) {
      my $TargetNode = &Hydra::Verilog::get_object_from_hier_name($Design, (($Insts[$index]->get_pin_list)[0]->get_bit_list)[0]->get_hier_name);
      &move_cursor($TargetNode);
    }
  }
  else {
    print "No instances found\n";
  }
}

sub do_find_inst {
  my ($Inst, $module_pattern, $inst_pattern, $aref_found) = @_;
  if ($Inst->get_name =~ /^$inst_pattern$/ && $Inst->get_module->get_name =~ /^$module_pattern$/) {
    push(@$aref_found, $Inst);
    return;
  }

  foreach my $SubInst ($Inst->get_instance_list) {
    &do_find_inst($SubInst, $module_pattern, $inst_pattern, $aref_found);
  }
}

sub do_selection {
  print "change_selection [get_pins " . &remove_top_module($glb_Cursor->get_hier_name) . "]\n";
}

#----------------------------------------------------------------------------------------------
# Trace Subroutines
#----------------------------------------------------------------------------------------------
# sub trace_to_condition {
#   my ($Node, $direction, $condition_type, $condition_name, @superpath) = @_;
#   return () if (&stop_trace);

#   &check_trace_count;

#   print "DEBUG: at Node " . $Node->get_hier_name . "\n" if ($glb_debug);
#   print $glb_fh_debug "DEBUG: at Node " . $Node->get_hier_name . "\n" if ($glb_debug);

#   # Prevent infinite loops
#   if (&has_mark($Node)) {
#     print "DEBUG: returned from already marked node\n" if ($glb_debug);
#     print $glb_fh_debug "DEBUG: returned from already marked node\n" if ($glb_debug);
#     return ();
#   }
#   &mark_node($Node);

#   my @subpaths = ();
#   my @Conns;
#   if ($direction eq "output") {
#     if ($Node->get_direction =~ /^output|inout$/) {
#       @Conns = $Node->get_connection_list("output_inout");
#     }
#     elsif ($Node->get_direction eq "input") {
#       my $cell_type = $Node->get_parent->get_module->get_type;
#       if ($cell_type eq "macro") {
#         # Dont trace through macros
#         print "DEBUG: returned from macro\n" if ($glb_debug);
#         print $glb_fh_debug "DEBUG: returned from macro\n" if ($glb_debug);
#         return ();
#       }
#       elsif ($cell_type eq "module") {
#         @Conns = $Node->get_connection_list("output_inout");
#       }
#       else {
#         @Conns = &Hydra::Liberty::trace_to_output($Node);
#       }
#     }
#   }
#   elsif ($direction eq "input") {
#     if ($Node->get_direction =~ /^input|inout$/) {
#       @Conns = $Node->get_connection_list("input_inout");
#     }
#     elsif ($Node->get_direction eq "output") {
#       my $cell_type = $Node->get_parent->get_module->get_type;
#       if ($cell_type eq "macro") {
#         # Dont trace through macros
#         print "DEBUG: returned from macro\n" if ($glb_debug);
#         print $glb_fh_debug "DEBUG: returned from macro\n" if ($glb_debug);
#         return ();
#       }
#       elsif ($cell_type eq "module") {
#         @Conns = $Node->get_connection_list("input_inout");
#       }
#       else {
#         @Conns = &Hydra::Liberty::trace_to_input($Node);
#       }
#     }
#   }

#   foreach my $Conn (@Conns) {
#     last if (&stop_trace);

#     if (&check_trace_condition($Conn, $condition_type, $condition_name)) {
#       push(@subpaths, [$Node, $Conn]);
#       &increment_trace_found;
#       #&set_stop_trace;
#     }
#     else {
#       my @path = @superpath;
#       push(@path, $Conn);
#       my @tracepaths = &trace_to_condition($Conn, $direction, $condition_type, $condition_name, @path);

#       if (scalar(@tracepaths) > 0) {
#         foreach my $aref_tracepath (@tracepaths) {
#           push(@subpaths, [($Node), @$aref_tracepath]);
#         }
#       }
#     }
#   }

#   print "DEBUG: normal return\n" if ($glb_debug);
#   print $glb_fh_debug "DEBUG: normal return\n" if ($glb_debug);
#   return @subpaths;
# }

sub trace_to_condition {
  my ($StartNode, $direction, $condition_type, $condition_name, @superpath) = @_;
  my @queue = ();
  my $TraceNode;
  my $Node;

  $TraceNode = new Hydra::Func::NetlistNavi::TraceNode($StartNode, undef);
  unshift(@queue, $TraceNode);
  &mark_node($StartNode);

  my @paths = ();
  while (scalar(@queue) > 0) {
    return @paths if (&stop_trace);
    &check_trace_count;

    $TraceNode = pop(@queue);
    $Node      = $TraceNode->get_node;
    if (&check_trace_condition($Node, $condition_type, $condition_name)) {
      &increment_trace_found;
      my @path = ();
      my $MatchedTraceNode = $TraceNode;
      
      while ($MatchedTraceNode->has_parent) {
        unshift(@path, $MatchedTraceNode->get_node);
        $MatchedTraceNode = $MatchedTraceNode->get_parent;
      }
      unshift(@path, $MatchedTraceNode->get_node);

      push(@paths, \@path);
    }
    else {
      my @Conns;
      if ($direction eq "output") {
        if ($Node->get_direction =~ /^output|inout$/) {
          @Conns = $Node->get_connection_list("output_inout");
        }
        elsif ($Node->get_direction eq "input") {
          my $cell_type = $Node->get_parent->get_module->get_type;
          if ($cell_type eq "macro") {
            # Dont trace through macros
            @Conns = ();
          }
          elsif ($cell_type eq "module") {
            @Conns = $Node->get_connection_list("output_inout");
          }
          else {
            @Conns = &Hydra::Liberty::trace_to_output($Node);
          }
        }
      }
      elsif ($direction eq "input") {
        if ($Node->get_direction =~ /^input|inout$/) {
          @Conns = $Node->get_connection_list("input_inout");
        }
        elsif ($Node->get_direction eq "output") {
          my $cell_type = $Node->get_parent->get_module->get_type;
          if ($cell_type eq "macro") {
            # Dont trace through macros
            @Conns = ();
          }
          elsif ($cell_type eq "module") {
            @Conns = $Node->get_connection_list("input_inout");
          }
          else {
            @Conns = &Hydra::Liberty::trace_to_input($Node);
          }
        }
      }

      foreach my $Conn (@Conns) {
        if (!&has_mark($Conn)) {
          &mark_node($Conn);
          my $TraceConn = new Hydra::Func::NetlistNavi::TraceNode($Conn, $TraceNode);
          unshift(@queue, $TraceConn);
        }
      }
    }
  }

  return @paths;
}

sub check_trace_condition {
  my ($Node, $condition_type, $condition_name) = @_;
  if (defined $glb_condition_check{$condition_type}) {
    return $glb_condition_check{$condition_type}->($Node, $condition_name);
  }
  else {
    # Always stop if condition_type is invalid
    print "ERROR: Invalid condition_type=${condition_type}\n";
    return 1;
  }
}

sub check_cell_name_condition {
  my ($Node, $condition_name) = @_;
  if ($Node->get_parent->get_module->get_name eq $condition_name) {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_inst_hier_name_condition {
  my ($Node, $condition_name) = @_;
  if (&remove_top_module($Node->get_parent->get_hier_name) eq $condition_name) {
    &set_stop_trace;
    return 1;
  }
  else {
    return 0;
  }
}

sub check_inst_hier_pin_condition {
  my ($Node, $condition_name) = @_;
  if (&remove_top_module($Node->get_hier_name) eq $condition_name) {
    &set_stop_trace;
    return 1;
  }
  else {
    return 0;
  }
}

sub check_inst_name_condition {
  my ($Node, $condition_name) = @_;
  if ($Node->get_parent->get_name eq $condition_name) {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_cell_type_condition {
  my ($Node, $condition_name) = @_;
  if (defined $glb_condition_check_cell_type{$condition_name}) {
    return $glb_condition_check_cell_type{$condition_name}->($Node);
  }
  else {
    # Always stop if condition_name is invalid
    print "ERROR: Invalid cell_type=${condition_name}\n";
    return 1;
  }
}

sub check_cell_type_ff {
  my ($Node) = @_;
  if (&Hydra::Verilog::is_flop($Node->get_parent)) {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_cell_type_macro {
  my ($Node) = @_;
  if ($Node->get_parent->get_module->get_type eq "macro") {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_cell_type_pad {
  my ($Node) = @_;
  if ($Node->get_parent->get_module->get_type eq "pad") {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_cell_type_module {
  my ($Node) = @_;
  if ($Node->get_parent->get_module->get_type eq "module") {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_cell_type_icg {
  my ($Node) = @_;
  if (&Hydra::Verilog::is_icg($Node->get_parent)) {
    return 1;
  }
  else {
    return 0;
  }
}

sub check_cell_type_std {
  my ($Node) = @_;
  if ($Node->get_parent->get_module->get_type eq "cell" &&
      !&Hydra::Verilog::is_flop($Node->get_parent) &&
      !&Hydra::Verilog::is_icg($Node->get_parent)) {
    return 1;
  }
  else {
    return 0;
  }
}

#----------------------------------------------------------------------------------------------
# Trace Helper Subroutines
#----------------------------------------------------------------------------------------------
sub mark_node {
  my ($Node) = @_;
  $Node->set_data({$glb_marker => 1});
}

sub unmark_node {
  my ($Node) = @_;
  $Node->set_data(undef);
}

sub has_mark {
  my ($Node) = @_;
  my $href_data = $Node->get_data;
  if (defined $href_data && defined $href_data->{$glb_marker} && $href_data->{$glb_marker}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub set_glb_marker {
  if (!defined $glb_marker) {
    $glb_marker = 'a';
  }
  elsif ($glb_marker eq 'z') {
    $glb_marker = 'z';
  }
  else {
    $glb_marker++;
  }
}

sub set_stop_trace {
  $glb_stop_trace = 1;
}

sub unset_stop_trace {
  $glb_stop_trace = 0;
}

sub stop_trace {
  return $glb_stop_trace;
}

sub reset_trace_count {
  $glb_trace_count = 0;
  $glb_trace_found = 0;
}

sub check_trace_count {
  $glb_trace_count++;
  if ($glb_trace_count % 10000 == 0) {
   print "Traced ${glb_trace_count} nodes...\n";
  }
}

sub increment_trace_found {
  $glb_trace_found++;
  if ($glb_trace_found == 1 || $glb_trace_found % 1000 == 0) {
    print "Found ${glb_trace_found} matches so far...\n";
  }
}

sub prepare_trace {
  &set_glb_marker;
  &unset_stop_trace;
  &reset_trace_count;
}

sub halt_trace {
  &set_stop_trace;
  print "Halting trace...\n";
  print "Do CTRL-C once more to exit\n";
  $SIG{INT} = 'DEFAULT';
}

#----------------------------------------------------------------------------------------------
# General Subroutines
#----------------------------------------------------------------------------------------------
sub request_node_selection {
  my ($prompt, @Nodes) = @_;
  my $index = -1;

  while ($index < 0 || $index > $#Nodes) {
    foreach my $index (0..$#Nodes) {
      print "${index}. " . &remove_top_module($Nodes[$index]->get_hier_name) . "\n";
    }
    print $#Nodes+1 . ". Cancel\n";
    print $prompt;
    $index = <STDIN>;
    
    # Allow user to cancel selection
    if ($index =~ /^\d+$/ && $index == $#Nodes+1) {
      return undef;
    }
    
    # Keep asking if input is invalid
    $index = -1 if ($index !~ /^\d+$/);
  }

  return $index;
}

sub move_cursor {
  my ($Node) = @_;
  if ($glb_recording) {
    push(@glb_record, $glb_Cursor);
  }
  $glb_Cursor = $Node;

  print "Moved to " . &get_info($glb_Cursor) . "\n";
}

sub get_info {
  my ($Cursor) = @_;
  my $name      = &remove_top_module($Cursor->get_hier_name);
  my $cell      = $Cursor->get_parent->get_module->get_name;
  my $direction = $Cursor->get_direction;
  return "$name ($cell) ($direction)";
}

sub get_prev_cmd {
  return $glb_prev_cmd;
}

sub set_prev_cmd {
  my ($cmd) = @_;
  $glb_prev_cmd = $cmd;
}

sub remove_top_module {
  my ($name) = @_;
  if ($name !~ /\//) {
    $name = "";
  }
  else {
    $name =~ s/^([^\s\/]+)\///;
  }
  return $name;
}

sub add_top_module {
  my ($name) = @_;
  $name = "${glb_top_module}/${name}";
  return $name;
}

sub get_cursor_digest {
  my $digest = "";

  my $hier_name = &remove_top_module($glb_Cursor->get_hier_name);
  my @hiers = split(/\//, $hier_name);

  # Print only pin and the last two hierarchies
  $digest = pop @hiers;
  foreach my $count (0..1) {
    if (scalar(@hiers) > 0) {
      my $hier = pop @hiers;
      $digest = $hier . "/${digest}";
    }
  }

  if (scalar(@hiers) > 0) {
    $digest = ".../${digest}";
  }

  return $digest;
}

# Modified from Hydra::Verilog version to work when hier_name refers to instance
sub get_object_from_hier_name {
  my ($Design, $hier_name) = @_;
  my @levels = split(/\//, $hier_name);

  my $Cursor = $Design->get_top_inst;
  my $name   = shift @levels;

  if ($name ne $Cursor->get_name) {
    warn "ERROR: ${hier_name} not contained in top module " . $Cursor->get_name . "!\n";
    return undef;
  }

  my $obj_type = "inst";
  while ($name = shift @levels) {
    if ($Cursor->has_instance($name)) {
      $Cursor = $Cursor->get_instance($name);
      $obj_type = "inst";
    }
    elsif ($Cursor->has_pin_header($name)) {
      $Cursor = $Cursor->get_pin_header($name);
      $obj_type = "pin";
      last;
    }
    elsif ($Cursor->has_net($name)) {
    #elsif ($Cursor->has_net($hier_name)) {
      $obj_type = "net";
      last;
    }
    else {
      print "It is pitch black. You are likely to be eaten by a Grue.\n";
      print "ERROR: Could not find $name in " . &remove_top_module($Cursor->get_hier_name) . "\n";
      return undef;
    }
  }

  # If hier_name is an instance, then move cursor to first pin
  if ($obj_type eq "inst") {
    $Cursor = (($Cursor->get_pin_list)[0]->get_bit_list)[0];
  }
  elsif ($obj_type eq "pin") {
    my $pin_name = $name;
    my ($base, $bit) = &Hydra::Verilog::parse_bit($pin_name);
    if ($bit eq "-1" && $Cursor->has_bus) {
      print "ERROR: Must select bit on bus pin " . $Cursor->get_name . "\n";
      return undef;
    }
    else {
      $Cursor = $Cursor->get_bit($bit);
    }
  }
  elsif ($obj_type eq "net") {
    # hier_name is a net; Cursor is currently an instance; find nodes connected to the net
    my @matches = ();
    foreach my $Inst (($Cursor, $Cursor->get_instance_list)) {
      foreach my $PinHeader ($Inst->get_pin_list) {
        foreach my $Bit ($PinHeader->get_bit_list) {
          foreach my $bit_net ($Bit->get_net) {
            if ($bit_net eq $hier_name) {
              push(@matches, $Bit);
              last;
            }
          }
        }
      }
    }

    #my @matches = $Cursor->get_net($hier_name);

    if (scalar(@matches) == 0) {
      print "Net or connected pin not found\n";
      $Cursor = undef;
    }
    elsif (scalar(@matches) > 1) {
      my $index = &request_node_selection("Net detected. Select a connected pin: ", @matches);
      if (defined $index) {
        $Cursor = $matches[$index];
      }
      else {
        $Cursor = undef;
      }
    }
    else {
      $Cursor = $matches[0];
    }
  }

  return $Cursor;
}

sub create_pattern {
  my ($name) = @_;
  my $pattern = quotemeta($name);
  $pattern =~ s/\\\*/.*/g;
  return $pattern;
}

#----------------------------------------------------------------------------------------------
# Class for trace
#----------------------------------------------------------------------------------------------
package Hydra::Func::NetlistNavi::TraceNode;

sub new {
  my ($class, $Node, $Parent) = @_;
  my $self = {
    Node      => $Node,
    Parent    => $Parent,
  };
  bless $self, $class;
  
  return $self;
}

sub get_node {
  my ($self) = @_;
  return $self->{Node};
}

sub get_parent {
  my ($self) = @_;
  return $self->{Parent};
}

sub has_parent {
  my ($self) = @_;
  return 1 if (defined $self->{Parent});
  return 0;
}

1;
