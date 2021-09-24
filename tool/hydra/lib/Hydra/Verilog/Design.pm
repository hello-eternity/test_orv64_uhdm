#------------------------------------------------------
# Module Name: Design
# Date:        Fri Aug  2 16:12:07 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Verilog::Design;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Verilog::Module;
use Hydra::Verilog::Literal;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Constructor
#------------------------------------------------------
sub new {
  my ($class, $top_module) = @_;
  my $self = {
    top_module  => $top_module,
    top_inst    => undef,
    modules     => {},
    lib_cells   => {},
    literals    => {},
    stmt_cursor => 0,
  };
  bless $self, $class;
  return $self;
}

#------------------------------------------------------
# Getters
#------------------------------------------------------
sub get_top_module {
  my ($self) = @_;
  return $self->get_module($self->{top_module});
}

sub get_top_inst {
  my ($self) = @_;
  return $self->{top_inst};
}

sub get_module {
  my ($self, $name) = @_;
  if (!defined $self->{modules}{$name}) {
    warn "WARN: module=${name} not found!\n";
    return undef;
  }
  else {
    return $self->{modules}{$name};
  }
}

sub find_cell {
  my ($self, $cell_name) = @_;
  if (defined $self->{modules}{$cell_name}) {
    return $self->{modules}{$cell_name};
  }
  else {
    if (defined $self->{lib_cells}{$cell_name}) {
      # Return cached module object for cell
      return $self->{lib_cells}{$cell_name};
    }
    else {
      # Create module object for cell if not found
      my $Cell = $self->create_lib_cell($cell_name);
      $self->{lib_cells}{$cell_name} = $Cell if (defined $Cell);
      return $Cell;
    }
  }
}

sub create_lib_cell {
  my ($self, $cell_name) = @_;

  my $Cell = new Hydra::Verilog::Module($self, $cell_name);
  $Cell->set_type("unknown");
  
  my $CellLib = &Hydra::Liberty::find_cell_lib($cell_name);
  if (defined $CellLib) {
    #$Cell->set_type($CellLib->get_type);
    $Cell->set_type(&Hydra::Liberty::get_cell_type($CellLib));
    $Cell->set_lib($CellLib);
  }

  return $Cell;
}

sub get_stmt_cursor {
  my ($self) = @_;
  return $self->{stmt_cursor};
}

sub get_literal {
  my ($self, $name) = @_;
  if (defined $self->{literals}{$name}) {
    return $self->{literals}{$name};
  }
  else {
    my $Literal = new Hydra::Verilog::Literal($self, $name);
    $self->{literals}{$name} = $Literal;
    return $Literal;
  }
}

#------------------------------------------------------
# Setters
#------------------------------------------------------
sub add_module {
  my ($self, $Module) = @_;
  my $name = $Module->get_name;
  if (defined $self->{modules}{$name}) {
    warn "WARN: module=${name} previously defined! ...skipping\n";
  }
  else {
    $self->{modules}{$name} = $Module;
  }
}

sub set_top_inst {
  my ($self, $Instance) = @_;
  $self->{top_inst} = $Instance;
}

sub set_stmt_cursor {
  my ($self, $cursor) = @_;
  $self->{stmt_cursor} = $cursor;
}

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub parse_verilog_files {
  my ($self, $aref_files, $aref_bb_modules, $aref_bb_insts) = @_;
  local $/ = ";";
  my %bb_modules = map {$_ => 1} @$aref_bb_modules;
  my %bb_insts   = map {$_ => 1} @$aref_bb_insts;

  my $module_num = 0;
  my %module_stmts = ();

  foreach my $file (@$aref_files) {
    &Hydra::Util::File::print_unbuffered("INFO: Reading verilog $file\n");
    my $fh_in = &Hydra::Util::File::open_file_for_read($file);
    while (my $stmt = <$fh_in>) {
      # Remove comments
      $stmt =~ s/\/\/.*\n//g;

      # Remove group comments
      if ($stmt =~ /\/\*/) {
        while ($stmt !~ /\*\//) {
          $stmt .= <$fh_in>;
        }
        $stmt =~ s/\/\*.*\*\///s;
      }

      # Remove backtick stmts
      $stmt =~ s/\s*\`.*\n//g;

      # Remove newlines
      $stmt =~ s/\n//g;

      # Remove stmts that dont end in semicolon
      $stmt =~ s/\s*endmodule\s*//;

      # Module stmt
      if ($stmt =~ /^\s*module\s+(\S+?)\s*\((.*)\)\s*\;\s*$/) {
        my $module_name  = $1;
        my $port_string  = $2;
        $port_string =~ s/^\s*//;
        $port_string =~ s/\s*$//;
        
        my @port_declarations = split(/\s*\,\s*/, $port_string);
        my @module_stmts      = ();
        my @port_stmts        = ();
        my @net_stmts         = ();

        my $cursor = tell($fh_in);
        $stmt = <$fh_in>;
        while ($stmt !~ /endmodule/) {
          # Remove comments
          $stmt =~ s/\/\/.*\n*//g;

          # Remove group comments
          if ($stmt =~ /\/\*/) {
            while ($stmt !~ /\*\//) {
              $stmt .= <$fh_in>;
            }
            $stmt =~ s/\/\*.*\*\///s;
          }
          
          if ($stmt =~ /^\s*(input|output|inout)\s+/) {
            push(@port_stmts, $stmt);
          }
          elsif ($stmt =~ /^\s*wire\s+/) {
            push(@net_stmts, $stmt);
          }
          else {
            push(@module_stmts, $stmt);
          }
          $cursor = tell($fh_in);
          $stmt = <$fh_in>;
        }

        # Endmodule has no semi-colon; will be part of next statement
        # Move cursor one stmt back; endmodule gets removed from stmt at beginning
        seek($fh_in, $cursor, 0);

        my $Module = new Hydra::Verilog::Module($self, $module_name, \@port_declarations, \@port_stmts, \@net_stmts, \@module_stmts);
        $Module->set_type("module");
        $self->add_module($Module);

        # Print feedback to screen
        $module_num++;
        if (($module_num % 1000) == 0 && $module_num != 0) {
          &Hydra::Util::File::print_unbuffered("INFO:  read $module_num modules...\n");
        }
      }
    }
    &Hydra::Util::File::close_file($fh_in);
  }

  # Instantiate top module
  my $TopModule = $self->get_top_module;
  my $TopInst   = $TopModule->instantiate(undef, $self->{top_module}, 1);
  $self->set_top_inst($TopInst);

  #&test_print($TopInst);
}

# sub test_print {
#   my ($Inst, $level) = @_;
#   $level = 0 if (!defined $level);
#   my $indent = "  " x $level;

#   print "${indent}inst=" . $Inst->get_name . "\n";
#   foreach my $Pin ($Inst->get_pin_list) {
#     print "${indent}>pin=" . $Pin->get_name . "\n";
#   }
  
#   $level++;
#   foreach my $SubInst ($Inst->get_instance_list) {
#     &test_print($SubInst, $level);
#   }
# }

1;
