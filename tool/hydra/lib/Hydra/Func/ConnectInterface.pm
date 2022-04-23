#------------------------------------------------------
# Module Name: ConnectInterface
# Date:        Fri Mar 22 15:54:10 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::ConnectInterface;

use strict;
use warnings;
use Carp;
use Exporter;
use Math::BigInt;
use POSIX qw(ceil);

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my @glb_errors = ();
my @glb_warns  = ();
my $glb_int_port_sep = "_";
my $glb_waive_width = 0;
my %glb_disable_ifdef_skip_modules = ();

my $glb_hack_inst = 0;

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub connect_interface {
  my $config_file     = &Hydra::Util::Option::get_opt_value_scalar("-config", "strict");
  my $aref_vlg_files  = &Hydra::Util::Option::get_opt_value_array("-vlg_files", "relaxed", []);
  my $flist           = &Hydra::Util::Option::get_opt_value_scalar("-flist", "relaxed", "");
  my $top_name        = &Hydra::Util::Option::get_opt_value_scalar("-top_name", "relaxed", "soc_top");
  my $aref_disable_ifdef_skip_modules = &Hydra::Util::Option::get_opt_value_array("-disable_ifdef_skip_modules", "relaxed", []);
  %glb_disable_ifdef_skip_modules = map {$_ => 1} @$aref_disable_ifdef_skip_modules;
  $glb_waive_width = &Hydra::Util::Option::get_opt_value_scalar("-waive_width", "relaxed", 0);
  if ($glb_waive_width =~ /on/i) {
    $glb_waive_width = 1;
  }
  else {
    $glb_waive_width = 0;
  }

  if ($glb_waive_width) {
    print "WARN: Bus width check is being waived\n";
  }

  $glb_hack_inst = &Hydra::Util::Option::get_opt_value_scalar("-hack_multi_inst", "relaxed", 0);
  if ($glb_hack_inst =~ /on/i) {
    $glb_hack_inst = 1;
  }
  else {
    $glb_hack_inst = 0;
  }

  if ($glb_hack_inst) {
    print "WARN: Multiple instance hack activated\n";
    print "      Multiple instances with the same name will be blindly generated\n";
    print "      The LAST declared instance will be used to get port lists and for all sanity checks\n";
    print "      Make sure that all modules have the same ports\n";
    print "      Make sure that you arrange your ifdefs such that only one instance is actually used\n";
    print "      Any ifdefs that should normally be applied to the top level wires of these instances \n";
    print "        will be ignored so that they will always be available for each duplicate instance\n";
  }


  my ($aref_flist_files, $aref_incdirs) = &Hydra::Util::File::expand_file_list($flist);

  my @vlg_files = ();
  push(@vlg_files, @$aref_vlg_files) if (scalar(@$aref_vlg_files) > 0);
  push(@vlg_files, @$aref_flist_files) if ($flist ne "");

  my %config = ();
  # %config =
  #   $inst_name =
  #     mod = <str> # source module
  #     ints =
  #       $interface = # source interface
  #         [
  #           inst   = <str> # destination instance
  #           mod    = <str> # destination module
  #           conn   = <str> # destination interface
  #           ifdef  = <str> # wrap this connection in an ifdef
  #           ifndef = <str> # wrap this connection in an ifndef
  #           except =
  #             $base_name = 1 # dont connection ports with these names
  #         ]
  #     ports =
  #       $port = # source port
  #         [
  #           inst   = <str> # destination instance
  #           mod    = <str> # destination module
  #           conn   = <str> # destination port
  #           ifdef  = <str> # wrap this connection in an ifdef
  #           ifndef = <str> # wrap this connection in an ifndef
  #           except =
  #             $base_name = 1 # dont connection ports with these names
  #         ]
  #     ifdef  = <str> # wrap this instance in an ifdef
  #     ifndef = <str> # wrap this instance in an ifndef
  my @dup_config = ();
  # dup_config is the same as config, but with an array pushed in as the first level
  #
  my %config_ports = ();
  # %config_ports =
  #     $port_name = [
  #                    conn   = <str> # module/port
  #                    ifdef  = <str> # wrap this connection in an ifdef
  #                    ifndef = <str> # wrap this connection in an ifndef
  #                  ]
  #
  my %inst_params = ();
  # %inst_params =
  #   $module_name =
  #     $inst_name =
  #       args|parameters|defines|whitelist =
  #         $param_name = <param_val>
  #
  my %ifdefs = ();
  # %ifdefs =
  #   $define_name = \@list_of_ifdef_stmts
  #
  my @imports = ();
  my @unconn_top_ports = ();
  my %data = ();
  my %all_modules = &parse_config_file(\%config, \%config_ports, \%inst_params, \@imports, \@unconn_top_ports, \%ifdefs, \%data, \@dup_config, $config_file);

  #my %data = ();
  # %data =
  #   $module_name =
  #     ports =
  #       $port_name =
  #         $inst_name = # instance name or "default"
  #           type|dir|msb|lsb|width = <int>
  #           bus_type = packed|unpacked|none
  #           conn = # only for $inst_name = default
  #             $connecting_module
  #               $connecting_port = <str> # input|output|inout
  #           connected =
  #             $bit => 1
  #     parameters|defines =
  #       $param_name = <int> # value
  #     parameter_pattern|define_pattern = <str> # regex pattern for all params/defines at once
  foreach my $vlg_file (@vlg_files) {
    &parse_verilog_file(\%data, \%all_modules, \%inst_params, $aref_incdirs, $vlg_file);
  }

  # Check that user defined parameters for each instance are in the "whitelist" of available parameters
  foreach my $module_name (keys %inst_params) {
    foreach my $inst_name (keys %{ $inst_params{$module_name} }) {
      foreach my $inst_def_id (keys %{ $inst_params{$module_name}{$inst_name}{args} }) {
        foreach my $user_param (keys %{ $inst_params{$module_name}{$inst_name}{args}{$inst_def_id} }) {
          if (!defined $inst_params{$module_name}{$inst_name}{whitelist}{$user_param}) {
            &add_error("Parameter is not defined for module=$module_name: inst=$inst_name param=$user_param");
          }
        }
      }
    }
  }

  my $fh_out = &Hydra::Util::File::open_file_for_write("${top_name}.sv");
  my $wire_max_len   = 0;
  my $assign_max_len = 0;
  my %wire_block     = ();
  # %wire_block =
  #   $inst_name =
  #     wire =
  #       $wire_name = <str> # wire type
  #     ifdef  = <str> # wrap these wires in ifdef
  #     ifndef = <str> # wrap these wires in ifndef
  #
  my %assigns        = ();
  # %assigns =
  #   $code_block_name = <str> # source <-> dest comment
  #     assign =
  #       $left = $right
  #     ifdef  = <str> # wrap all assigns for this block in ifdef
  #     ifndef = <str> # wrap all assigns for this block in ifndef
  #
  my %insts          = ();
  # %insts =
  #   $inst_name =
  #     pins =
  #       $pin = <str> # connected wire
  #     mod = <str> # name of module
  #     ifdef  = <str> # wrap this instance in ifdef
  #     ifndef = <str> # wrap this instance in ifndef
  #
  my %top_ports      = ();
  # %top_ports =
  #   $port_name = <str> # dir/type/bus def
  #
  print $fh_out "module ${top_name}\n";
  foreach my $import_stmt (@imports) {
    if ($import_stmt !~ /;\s*$/) {
      $import_stmt .= ";";
    }
    print $fh_out "$import_stmt\n";
  }
  #print $fh_out "();\n";
  
  # Store literal connections
  my %literals = ();
  my %skipped_literals = ();

  # Pre-process signal connections to expand out buses that are connected to a single bit signal
  # foreach my $src_inst (sort keys %config) {
  #   my $src_mod = $config{$src_inst}{mod};
  #   my $conn_type = "ports";

  #   my %new_configs = ();
  #   foreach my $src_conn (sort keys %{ $config{$src_inst}{$conn_type} }) {
  #     my @new_list = ();
  #     foreach my $href_entry (@{ $config{$src_inst}{$conn_type}{$src_conn} }) {
  #       my $des_mod   = $href_entry->{mod};
  #       my $des_inst  = $href_entry->{inst};
  #       my $des_conn  = $href_entry->{conn};

  #       # Skip processing for literals
  #       if (!defined $des_mod) {
  #         push(@new_list, $href_entry);
  #         next;
  #       }

  #       my $src_port;
  #       my $des_port;
  #       my $src_bit;
  #       my $des_bit;
  #       if ($src_conn =~ /(\S+?)\[(\d+)\]/) {
  #         $src_port = $1;
  #         $src_bit  = $2;
  #       }
  #       else {
  #         $src_port = $src_conn;
  #       }

  #       if ($des_conn =~ /(\S+?)\[(\d+)\]/) {
  #         $des_port = $1;
  #         $des_bit  = $2;
  #       }
  #       else {
  #         $des_port = $des_conn;
  #       }

  #       my $src_width = &get_width(\%data, $src_mod, $src_port, $src_inst);
  #       my $des_width = &get_width(\%data, $des_mod, $des_port, $des_inst);
  #       $src_width = 1 if (defined $src_bit);
  #       $des_width = 1 if (defined $des_bit);
  #       my $src_msb   = &get_msb(\%data, $src_mod, $src_port, $src_inst);
  #       my $src_lsb   = &get_lsb(\%data, $src_mod, $src_port, $src_inst);
  #       my $des_msb   = &get_msb(\%data, $des_mod, $des_port, $des_inst);
  #       my $des_lsb   = &get_lsb(\%data, $des_mod, $des_port, $des_inst);
  #       if ($src_width != $des_width) {
  #         if ((defined $src_bit || ($src_msb eq "" && $src_lsb eq "")) &&
  #             (!defined $des_bit && $des_msb ne "" && $des_msb ne "")) {
  #           # Source is a single bit and des is a bus
  #           # Expand out des bits into @new_list
  #           my $low_bit;
  #           my $high_bit;
  #           if ($des_msb > $des_lsb) {
  #             $low_bit  = $des_lsb;
  #             $high_bit = $des_msb;
  #           }
  #           else {
  #             $low_bit  = $des_msb;
  #             $high_bit = $des_lsb;
  #           }

  #           foreach my $expand_bit ($low_bit..$high_bit) {
  #             my %new_conn = %$href_entry;
  #             $new_conn{conn} = "${des_conn}[${expand_bit}]";
  #             push(@new_list, \%new_conn);
  #           }
  #         }
  #         elsif ((!defined $src_bit && $src_msb ne "" && $src_lsb ne "") && 
  #                (defined $des_bit || ($des_msb eq "" && $des_lsb eq ""))) {
  #           # Source is a bus and des is a single bit
  #           # Expand out source bits into %new_configs
  #           my $low_bit;
  #           my $high_bit;
  #           if ($src_msb > $src_lsb) {
  #             $low_bit  = $src_lsb;
  #             $high_bit = $src_msb;
  #           }
  #           else {
  #             $low_bit  = $src_msb;
  #             $high_bit = $src_lsb;
  #           }

  #           foreach my $expand_bit ($low_bit..$high_bit) {
  #             my %new_conn = %$href_entry;
  #             push(@{ $new_configs{"${src_conn}[${expand_bit}]"} }, \%new_conn);
  #           }
  #         }
  #         else {
  #           # No change needed, copy this entry into @new_list
  #           push(@new_list, $href_entry);
  #         }
  #       }
  #       else {
  #         # No change needed, copy this entry into @new_list
  #         push(@new_list, $href_entry);
  #       }
  #     }

  #     # Replace des conn list with new list
  #     $config{$src_inst}{$conn_type}{$src_conn} = \@new_list;
  #   }

  #   # Add new src conns and delete src conns that no longer have a des conn list
  #   foreach my $src_conn (keys %{ $config{$src_inst}{$conn_type} }) {
  #     if (scalar(@{ $config{$src_inst}{$conn_type}{$src_conn} }) <= 0) {
  #       delete $config{$src_inst}{$conn_type}{$src_conn};
  #     }
  #   }
  #   foreach my $src_conn (keys %new_configs) {
  #     push(@{ $config{$src_inst}{$conn_type}{$src_conn} }, @{ $new_configs{$src_conn} });
  #   }
  # }

  # Process interfaces
  foreach my $src_inst (sort keys %config) {
    my $src_mod = $config{$src_inst}{mod};

    foreach my $conn_type (qw(ints ports int_port port_int)) {
      foreach my $src_conn (sort keys %{ $config{$src_inst}{$conn_type} }) {
        my $src_conn_bak = $src_conn;
        
        foreach my $href_entry (@{ $config{$src_inst}{$conn_type}{$src_conn} }) {
          # Restore backed up src_conn because it gets modified later on
          # This avoids issues if there are multiple connection entries for src_conn
          $src_conn = $src_conn_bak;

          # my $des_mod  = $config{$src_inst}{$conn_type}{$src_conn}{mod};
          # my $des_inst = $config{$src_inst}{$conn_type}{$src_conn}{inst};
          # my $des_conn = $config{$src_inst}{$conn_type}{$src_conn}{conn};
          my $des_mod  = $href_entry->{mod};
          my $des_inst = $href_entry->{inst};
          my $des_conn = $href_entry->{conn};
          my $ifdef    = $href_entry->{ifdef};
          my $ifndef   = $href_entry->{ifndef};

          my @src_ports = ();
          my @des_ports = ();

          if ($conn_type eq "ints") {
            my ($aref_src_ports, $aref_des_ports, $href_skipped);
            if (!defined $des_mod) {
              # Destination is a literal
              ($aref_src_ports, $aref_des_ports, $href_skipped) = &find_interface_ports_literal(\%data, $src_mod, $src_conn, $des_conn, $src_inst, $href_entry->{except});

              # Record skipped literals
              foreach my $port_name (keys %$href_skipped) {
                $skipped_literals{"${src_inst}/${src_conn}${glb_int_port_sep}${port_name}"} = 1;
              }
            }
            else {
              ($aref_src_ports, $aref_des_ports) = &find_interface_ports(\%data, $src_mod, $des_mod, $src_conn, $des_conn, $src_inst, $des_inst, $href_entry->{except});
            }
            @src_ports = @$aref_src_ports;
            @des_ports = @$aref_des_ports;
            # foreach my $base_port (&find_interface_ports(\%data, $src_mod, $des_mod, $src_conn, $des_conn)) {
            #   push(@src_ports, $base_port);
            #   push(@des_ports, $base_port);
            # }
          }
          elsif ($conn_type eq "int_port" || $conn_type eq "port_int") {
            my ($aref_src_ports, $aref_des_ports) = &find_interface_ports_mixed(\%data, $src_mod, $des_mod, $src_conn, $des_conn, $src_inst, $des_inst, $conn_type, $href_entry->{except});
            @src_ports = @$aref_src_ports;
            @des_ports = @$aref_des_ports;
          }
          elsif ($conn_type eq "ports") {
            push(@src_ports, $src_conn);
            push(@des_ports, $des_conn);
          }

          foreach my $index (0..$#src_ports) {
            my $src_name = $src_ports[$index];
            my $des_name = $des_ports[$index];
            my $src_orig_port;
            my $des_orig_port;
            my $src_bit = "";
            my $des_bit = "";
            my $src_bus = "";
            my $des_bus = "";
            my $src_int_bit = "";
            my $des_int_bit = "";
            my $src_sep;
            my $des_sep;
            
            if ($conn_type eq "ports") {
              my $literal_connected = 0;
              if ($des_name =~ /\'/) {
                # Dest is a literal
                $literal_connected = &sanity_check_literal(\%data, $src_mod, $src_name, $des_name, "port", undef, undef, $src_inst);
              }
              else {
                &sanity_check(\%data, $src_mod, $des_mod, $src_name, $des_name, "port", undef, undef, undef, $src_inst, $des_inst);
              }
              if ($src_name =~ /(\S+?)(\[\d+\])/) {
                $src_orig_port = $1;
                $src_bit  = $2;
              }
              else {
                $src_orig_port = $src_name;
              }
              if ($des_name =~ /(\S+?)(\[\d+\])/) {
                $des_orig_port = $1;
                $des_bit  = $2;
              }
              else {
                $des_orig_port = $des_name;
              }
              $src_sep = "/";
              $des_sep = "/";

              if ($des_name =~ /\'/) {
                if ($literal_connected) {
                  # Record literal
                  $literals{"${src_inst}/${src_orig_port}"} = 1;
                }
                else {
                  $skipped_literals{"${src_inst}/${src_orig_port}"} = 1;
                }
              }
            }
            elsif ($conn_type eq "ints") {
              if ($src_name =~ /(\S+?)(\[\d+\])/) {
                my $base_port = $1;
                $src_bit  = $2;
                $src_conn =~ s/\Q${src_bit}\E//;
                $src_int_bit = $src_bit;

                if ($src_conn eq "*") {
                  $src_orig_port = $base_port;
                }
                elsif ($src_conn =~ /\*\.(S+)/) {
                  my $src_suffix = $1;
                  $src_orig_port = "${base_port}${glb_int_port_sep}${src_suffix}";
                }
                elsif ($src_conn =~ /\./) {
                  my ($src_prefix, $src_suffix) = split(/\./, $src_conn);
                  $src_orig_port = "${src_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${src_suffix}";
                }
                else {
                  $src_orig_port = "${src_conn}${glb_int_port_sep}${base_port}";
                }
              }
              else {
                if ($src_conn eq "*") {
                  $src_orig_port = $src_name;
                }
                elsif ($src_conn =~ /\*\.(\S+)/) {
                  my $src_suffix = $1;
                  $src_orig_port = "${src_name}${glb_int_port_sep}${src_suffix}";
                }
                elsif ($src_conn =~ /\./) {
                  my ($src_prefix, $src_suffix) = split(/\./, $src_conn);
                  $src_orig_port = "${src_prefix}${glb_int_port_sep}${src_name}${glb_int_port_sep}${src_suffix}";
                }
                else {
                  $src_orig_port = "${src_conn}${glb_int_port_sep}${src_name}";
                }
              }
              if (!defined $des_mod) {
                # Dest is a literal
                $des_orig_port = $des_name;

                # Record literal
                $literals{"${src_inst}/${src_orig_port}"} = 1;
              }
              else {
                if ($des_name =~ /(\S+?)(\[\d+\])/) {
                  my $base_port = $1;
                  $des_bit  = $2;
                  $des_conn =~ s/\Q${des_bit}\E//;
                  $des_int_bit = $des_bit;

                  if ($des_conn eq "*") {
                    $des_orig_port = $base_port;
                  }
                  elsif ($des_conn =~ /\*\.(\S+)/) {
                    my $des_suffix = $1;
                    $des_orig_port = "${base_port}${glb_int_port_sep}${des_suffix}";
                  }
                  elsif ($des_conn =~ /\./) {
                    my ($des_prefix, $des_suffix) = split(/\./, $des_conn);
                    $des_orig_port = "${des_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${des_suffix}";
                  }
                  else {
                    $des_orig_port = "${des_conn}${glb_int_port_sep}${base_port}";
                  }
                }
                else {
                  if ($des_conn eq "*") {
                    $des_orig_port = $des_name;
                  }
                  elsif ($des_conn =~ /\*\.(\S+)/) {
                    my $des_suffix = $1;
                    $des_orig_port = "${des_name}${glb_int_port_sep}${des_suffix}";
                  }
                  elsif ($des_conn =~ /\./) {
                    my ($des_prefix, $des_suffix) = split(/\./, $des_conn);
                    $des_orig_port = "${des_prefix}${glb_int_port_sep}${des_name}${glb_int_port_sep}${des_suffix}";
                  }
                  else {
                    $des_orig_port = "${des_conn}${glb_int_port_sep}${des_name}";
                  }
                }
              }

              #$src_orig_port = "${src_conn}${glb_int_port_sep}${src_name}";
              #$des_orig_port = "${des_conn}${glb_int_port_sep}${des_name}";
              $src_sep = ".";
              $des_sep = ".";
            }
            elsif ($conn_type eq "port_int") {
              if ($src_name =~ /(\S+?)(\[\d+\])/) {
                $src_orig_port = $1;
                $src_bit  = $2;
              }
              else {
                $src_orig_port = $src_name;
              }

              if ($des_name =~ /(\S+?)(\[\d+\])/) {
                my $base_port = $1;
                $des_bit  = $2;
                $des_conn =~ s/\Q${des_bit}\E//;
                $des_int_bit = $des_bit;

                if ($des_conn eq "*") {
                  $des_orig_port = $base_port;
                }
                elsif ($des_conn =~ /\*\.(\S+)/) {
                  my $des_suffix = $1;
                  $des_orig_port = "${base_port}${glb_int_port_sep}${des_suffix}";
                }
                elsif ($des_conn =~ /\./) {
                  my ($des_prefix, $des_suffix) = split(/\./, $des_conn);
                  $des_orig_port = "${des_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${des_suffix}";
                }
                else {
                  $des_orig_port = "${des_conn}${glb_int_port_sep}${base_port}";
                }
              }
              else {
                if ($des_conn eq "*") {
                  $des_orig_port = $des_name;
                }
                elsif ($des_conn =~ /\*\.(\S+)/) {
                  my $des_suffix = $1;
                  $des_orig_port = "${des_name}${glb_int_port_sep}${des_suffix}";
                }
                elsif ($des_conn =~ /\./) {
                  my ($des_prefix, $des_suffix) = split(/\./, $des_conn);
                  $des_orig_port = "${des_prefix}${glb_int_port_sep}${des_name}${glb_int_port_sep}${des_suffix}";
                }
                else {
                  $des_orig_port = "${des_conn}${glb_int_port_sep}${des_name}";
                }
              }

              $src_sep = "/";
              $des_sep = ".";
            }
            elsif ($conn_type eq "int_port") {
              if ($src_name =~ /(\S+?)(\[\d+\])/) {
                my $base_port = $1;
                $src_bit  = $2;
                $src_conn =~ s/\Q${src_bit}\E//;
                $src_int_bit = $src_bit;

                if ($src_conn eq "*") {
                  $src_orig_port = $base_port;
                }
                elsif ($src_conn =~ /\*\.(\S+)/) {
                  my $src_suffix = $1;
                  $src_orig_port = "${base_port}${glb_int_port_sep}${src_suffix}";
                }
                elsif ($src_conn =~ /\./) {
                  my ($src_prefix, $src_suffix) = split(/\./, $src_conn);
                  $src_orig_port = "${src_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${src_suffix}";
                }
                else {
                  $src_orig_port = "${src_conn}${glb_int_port_sep}${base_port}";
                }
              }
              else {
                if ($src_conn eq "*") {
                  $src_orig_port = $src_name;
                }
                elsif ($src_conn =~ /\*\.(\S+)/) {
                  my $src_suffix = $1;
                  $src_orig_port = "${src_name}${glb_int_port_sep}${src_suffix}";
                }
                elsif ($src_conn =~ /\./) {
                  my ($src_prefix, $src_suffix) = split(/\./, $src_conn);
                  $src_orig_port = "${src_prefix}${glb_int_port_sep}${src_name}${glb_int_port_sep}${src_suffix}";
                }
                else {
                  $src_orig_port = "${src_conn}${glb_int_port_sep}${src_name}";
                }
              }

              if ($des_name =~ /(\S+?)(\[\d+\])/) {
                $des_orig_port = $1;
                $des_bit  = $2;
              }
              else {
                $des_orig_port = $des_name;
              }

              $src_sep = ".";
              $des_sep = "/";
            }

            #print "${src_mod}/${src_orig_port} ${des_mod}/${des_orig_port}\n";

            my $type = &get_type(\%data, $src_mod, $src_orig_port);
            if ($type =~ /^logic|none|wire$/) {
              $type = "wire";
            }

            if (&is_port_bus(\%data, $src_mod, $src_orig_port)) {
              my $src_msb = &get_msb(\%data, $src_mod, $src_orig_port, $src_inst);
              my $src_lsb = &get_lsb(\%data, $src_mod, $src_orig_port, $src_inst);
              $src_bus = "[${src_msb}:${src_lsb}]";
            }
            if (defined $des_mod && &is_port_bus(\%data, $des_mod, $des_orig_port)) {
              my $des_msb = &get_msb(\%data, $des_mod, $des_orig_port, $des_inst);
              my $des_lsb = &get_lsb(\%data, $des_mod, $des_orig_port, $des_inst);
              $des_bus = "[${des_msb}:${des_lsb}]";
            }

            my $src_bus_type = &get_bus_type(\%data, $src_mod, $src_orig_port, $src_inst);
            my $des_bus_type = "none";
            if (defined $des_mod) {
              # Dest is not a literal
              $des_bus_type = &get_bus_type(\%data, $des_mod, $des_orig_port, $des_inst);
            }
            my $src_dir = &get_direction(\%data, $src_mod, $src_orig_port, $src_inst);
            my $des_dir;
            if (!defined $des_mod) {
              # Dest is a literal
              $des_dir = "output";
            }
            else {
              $des_dir = &get_direction(\%data, $des_mod, $des_orig_port, $des_inst);
            }
            if ($src_dir eq "inout" || $des_dir eq "inout") {
              # If either side is inout, then a single top level wire must be directly connected to the instances
              my $wire_name;
              if ($src_dir eq "undirected") {
                # Src is a top level wire; use it as the wire name
                $wire_name = "${src_mod}__${src_conn}";
              }
              elsif ($des_dir eq "undirected") {
                # Des is a top level wire; use it as the wire name
                $wire_name = "${des_mod}__${des_conn}";
              }
              elsif (!defined $des_mod) {
                # Dest is a literal
                $wire_name = $des_conn;
              }
              else {
                $wire_name = "${src_inst}__${src_orig_port}___${des_inst}__${des_orig_port}";
              }

              # Inout has no assign, so set bit connected here
              &set_bit_connected(\%data, $src_mod, $src_orig_port, $src_inst, $src_bit);
              if (defined $des_mod) {
                &set_bit_connected(\%data, $des_mod, $des_orig_port, $des_inst, $des_bit);
              }

              if ($src_bit ne "" || $des_bit ne "") {
                # One side is a single bit, so the wire should be single bit
                # That side will also need a OURS_UNCONNECTED wire to fill out the bits
                if (defined $des_mod) {
                  # Dest is not a literal
                  if ($src_dir ne "undirected" && $des_dir ne "undirected") {
                    # Only create new wire when this inout connection is not on a top level wire
                    # Top level wires are always "undirected"
                    # A direct connection to the top level wire is used
                    $wire_block{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                    $wire_block{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                    $wire_block{$src_inst}{wire}{$wire_name} = $type;
                  }
                }
                $wire_block{$top_name}{wire}{"OURS_UNCONNECTED"} = "wire";
                &set_max_len(\$wire_max_len, $type);

                $insts{$src_inst}{mod} = $src_mod;
                $insts{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                $insts{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                if ($src_bit ne "") {
                  my $src_msb = &get_msb(\%data, $src_mod, $src_orig_port, $src_inst);
                  my $src_lsb = &get_lsb(\%data, $src_mod, $src_orig_port, $src_inst);
                  $src_bit =~ /\[(\d+)\]/;
                  my $bit_num = $1;
                  if (defined $insts{$src_inst}{pins}{$src_orig_port}) {
                    my $net = $insts{$src_inst}{pins}{$src_orig_port};
                    $net =~ s/\{|\}//g;
                    my @nets = split(/\s*\,\s*/, $net);
                    my $j = 0;
                    for (my $i = $src_msb; $i >= $src_lsb; $i--) {
                      if ($i == $bit_num) {
                        $nets[$j] = $wire_name;
                      }
                      $j++;
                    }
                    $net = join(", ", @nets);
                    $net = "{${net}}";
                    $insts{$src_inst}{pins}{$src_orig_port} = $net;
                  }
                  else {
                    my $net = "{";
                    for (my $i = $src_msb; $i >= $src_lsb; $i--) {
                      if ($i == $bit_num) {
                        $net .= "${wire_name}, ";
                      }
                      else {
                        $net .= "OURS_UNCONNECTED, ";
                      }
                    }
                    $net =~ s/\,\s*$//;
                    $net .= "}";
                    $insts{$src_inst}{pins}{$src_orig_port} = $net;
                  }
                }
                else {
                  $insts{$src_inst}{pins}{$src_orig_port} = $wire_name;
                }
                
                if (defined $des_mod) {
                  # Dest is not a literal
                  $insts{$des_inst}{mod} = $des_mod;
                  $insts{$des_inst}{ifdef}  = $config{$des_inst}{ifdef};
                  $insts{$des_inst}{ifndef} = $config{$des_inst}{ifndef};
                  if ($des_bit ne "") {
                    my $des_msb = &get_msb(\%data, $des_mod, $des_orig_port, $des_inst);
                    my $des_lsb = &get_lsb(\%data, $des_mod, $des_orig_port, $des_inst);
                    $des_bit =~ /\[(\d+)\]/;
                    my $bit_num = $1;
                    if (defined $insts{$des_inst}{pins}{$des_orig_port}) {
                      my $net = $insts{$des_inst}{pins}{$des_orig_port};
                      $net =~ s/\{|\}//g;
                      my @nets = split(/\s*\,\s*/, $net);
                      my $j = 0;
                      for (my $i = $des_msb; $i >= $des_lsb; $i--) {
                        if ($i == $bit_num) {
                          $nets[$j] = $wire_name;
                        }
                        $j++;
                      }
                      $net = join(", ", @nets);
                      $net = "{${net}}";
                      $insts{$des_inst}{pins}{$des_orig_port} = $net;
                    }
                    else {
                      my $net = "{";
                      for (my $i = $des_msb; $i >= $des_lsb; $i--) {
                        if ($i == $bit_num) {
                          $net .= "${wire_name}, ";
                        }
                        else {
                          $net .= "OURS_UNCONNECTED, ";
                        }
                      }
                      $net =~ s/\,\s*$//;
                      $net .= "}";
                      $insts{$des_inst}{pins}{$des_orig_port} = $net;
                    }
                  }
                  else {
                    $insts{$des_inst}{pins}{$des_orig_port} = $wire_name;
                  }
                }
              }
              else {
                # Assume the src and des have the same bus width and type
                my $width = &get_width(\%data, $src_mod, $src_orig_port, $src_inst);
                my $msb = $width - 1;
                my $lsb = 0;
                my $bus = "[${msb}:${lsb}]";
                if ($src_dir ne "undirected" && $des_dir ne "undirected") {
                  # Only create new wire when this inout connection is not on a top level wire
                  # Top level wires are always "undirected"
                  # A direct connection to the top level wire is used
                  if (defined $des_mod && (!defined $src_bus_type || $src_bus_type eq "none" || $src_bus_type eq "packed")) {
                    $wire_block{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                    $wire_block{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                    $wire_block{$src_inst}{wire}{$wire_name} = "${type}${bus}";
                    &set_max_len(\$wire_max_len, "${type}${bus}");
                  }
                  elsif (defined $des_mod && (defined $src_bus_type && $src_bus_type eq "unpacked")) {
                    $wire_block{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                    $wire_block{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                    $wire_block{$src_inst}{wire}{"${wire_name}${bus}"} = $type;
                    &set_max_len(\$wire_max_len, $type);
                  }
                }

                $insts{$src_inst}{mod} = $src_mod;
                $insts{$src_inst}{pins}{$src_orig_port} = $wire_name;
                $insts{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                $insts{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                if (defined $des_mod) {
                  # Dest is not a literal
                  $insts{$des_inst}{mod} = $des_mod;
                  $insts{$des_inst}{pins}{$des_orig_port} = $wire_name;
                  $insts{$des_inst}{ifdef}  = $config{$des_inst}{ifdef};
                  $insts{$des_inst}{ifndef} = $config{$des_inst}{ifndef};
                }
              }
            }
            else {
              my $src_wire_name = "${src_inst}__${src_orig_port}";
              my $des_wire_name;
              my $des_name;
              if (!defined $des_mod) {
                # Dest is a literal; add width to literal based on width of src
                #$des_wire_name = $des_conn;                

                if ($des_conn =~ /\'b(\d+)/) {
                  my $val = $1;
                  my $val_len = length($val);

                  # Zero pad literal value to the bit width of the signal
                  $des_wire_name = "{{(\$bits(${src_wire_name}${src_bit})-${val_len}){1'b0}}, ${val_len}${des_conn}}";
                  $des_name      = $des_conn;
                }
                else {
                  # Hack b in
                  my $literal_des_conn = $des_conn;
                  $literal_des_conn =~ s/\'/'b/;

                  $des_wire_name = "{\$bits(${src_wire_name}${src_bit}){1${literal_des_conn}}}";
                  $des_name      = $des_conn;
                }
              }
              else {
                $des_wire_name = "${des_inst}__${des_orig_port}";
                $des_name      = "${des_inst}${des_sep}${des_conn}${des_int_bit}";
              }
              if (!defined $src_bus_type || $src_bus_type eq "none" || $src_bus_type eq "packed") {
                $wire_block{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                $wire_block{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                $wire_block{$src_inst}{wire}{"${src_wire_name}"} = "${type}${src_bus}";
                &set_max_len(\$wire_max_len, "${type}${src_bus}");
              }
              elsif (defined $src_bus_type && $src_bus_type eq "unpacked") {
                $wire_block{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
                $wire_block{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
                $wire_block{$src_inst}{wire}{"${src_wire_name}${src_bus}"} = $type;
                &set_max_len(\$wire_max_len, $type);
              }
              if (defined $des_mod && (!defined $des_bus_type || $des_bus_type eq "none" || $des_bus_type eq "packed")) {
                $wire_block{$des_inst}{ifdef}  = $config{$des_inst}{ifdef};
                $wire_block{$des_inst}{ifndef} = $config{$des_inst}{ifndef};
                $wire_block{$des_inst}{wire}{"${des_wire_name}"} = "${type}${des_bus}";
                &set_max_len(\$wire_max_len, "${type}${des_bus}");
              }
              elsif (defined $des_mod && (defined $des_bus_type && $des_bus_type eq "unpacked")) {
                $wire_block{$des_inst}{ifdef}  = $config{$des_inst}{ifdef};
                $wire_block{$des_inst}{ifndef} = $config{$des_inst}{ifndef};
                $wire_block{$des_inst}{wire}{"${des_wire_name}${des_bus}"} = $type;
                &set_max_len(\$wire_max_len, $type);
              }

              if (&get_direction(\%data, $src_mod, $src_orig_port) =~ /^input$/ ||
                  (defined $des_mod && &get_direction(\%data, $des_mod, $des_orig_port) =~ /^output$/)) {
                $assigns{"${src_inst}${src_sep}${src_conn}${src_int_bit} <-> ${des_name}"}{ifdef}  = $ifdef;
                $assigns{"${src_inst}${src_sep}${src_conn}${src_int_bit} <-> ${des_name}"}{ifndef} = $ifndef;
                $assigns{"${src_inst}${src_sep}${src_conn}${src_int_bit} <-> ${des_name}"}{assign}{"${src_wire_name}${src_bit}"} = "${des_wire_name}${des_bit}";
                &set_max_len(\$assign_max_len, "${src_wire_name}${src_bit}");
                &set_bit_connected(\%data, $src_mod, $src_orig_port, $src_inst, $src_bit);
                if (defined $des_mod) {
                  &set_bit_connected(\%data, $des_mod, $des_orig_port, $des_inst, $des_bit);
                }
              }
              if (defined $des_mod && 
                  (&get_direction(\%data, $des_mod, $des_orig_port) =~ /^input$/ ||
                  &get_direction(\%data, $src_mod, $src_orig_port) =~ /^output$/)) {
                $assigns{"${src_inst}${src_sep}${src_conn}${src_int_bit} <-> ${des_name}"}{ifdef}  = $ifdef;
                $assigns{"${src_inst}${src_sep}${src_conn}${src_int_bit} <-> ${des_name}"}{ifndef} = $ifndef;
                $assigns{"${src_inst}${src_sep}${src_conn}${src_int_bit} <-> ${des_name}"}{assign}{"${des_wire_name}${des_bit}"} = "${src_wire_name}${src_bit}";
                &set_max_len(\$assign_max_len, "${des_wire_name}${des_bit}");
                &set_bit_connected(\%data, $src_mod, $src_orig_port, $src_inst, $src_bit);
                &set_bit_connected(\%data, $des_mod, $des_orig_port, $des_inst, $des_bit);
              }

              ### If either side is inout, then connect directly to the single top level wire
              ### A HYDRA_UNCONNECTED wire must be created if either side is a bus and only one bit is connected; use HYDRA_UNCONNECTED for the remaining bits
              ### Need to change the value to something other than a string; use hash with bits as keys?
              ### Need to check if there is a top level inout port connected to this pin somehow; top level ports will need to be processed before interfaces
              $insts{$src_inst}{mod} = $src_mod;
              $insts{$src_inst}{pins}{$src_orig_port} = "${src_wire_name}";
              $insts{$src_inst}{ifdef}  = $config{$src_inst}{ifdef};
              $insts{$src_inst}{ifndef} = $config{$src_inst}{ifndef};
              if (defined $des_mod) {
                # Dest is not a literal
                $insts{$des_inst}{mod} = $des_mod;
                $insts{$des_inst}{pins}{$des_orig_port} = "${des_wire_name}";
                $insts{$des_inst}{ifdef}  = $config{$des_inst}{ifdef};
                $insts{$des_inst}{ifndef} = $config{$des_inst}{ifndef};
              }
            }
          }
        }
      }
    }
  }

  # Process unconnected top ports
  foreach my $top_port_stmt (@unconn_top_ports) {
    $top_port_stmt =~ /^(input|output|inout)/;
    my $dir = $1;
    $top_port_stmt =~ s/^(input|output|inout)\s*//;
    $top_ports{$top_port_stmt}{val} = $dir;
  }

  # Process top ports
  foreach my $top_port (sort keys %config_ports) {
    # Sanity check all inst_ports first, while determining top port characteristics
    my $dir;
    my $port_type;
    my $wire_type;
    my $port_bus;
    my $width;
    my $bus_type;
    my $has_literal = 0;
    #foreach my $inst_port (sort @{ $config_ports{$top_port} }) {
    foreach my $href_entry (sort { $a->{conn} cmp $b->{conn} } @{ $config_ports{$top_port} }) {
      my $inst_port = $href_entry->{conn};

      if ($inst_port =~ /(\d+)\'/) {
        # Connection is to a literal
        $has_literal = 1;

        # Record literal connection
        $literals{$top_port} = 1;

        # This width
        my $this_width = $1;
        if (!defined $width) {
          $width = $this_width;
        }
        elsif ($width != $this_width) {
          if ($glb_waive_width) {
            &add_warn("Port has conflicting bus width: ${top_port}=${width}, ${inst_port}=${this_width}");
          }
          else {
            &add_error("Port has conflicting bus width: ${top_port}=${width}, ${inst_port}=${this_width}");
          }
        }

        # Check direction
        my $this_dir = "output";
        if (!defined $dir) {
          $dir = $this_dir;
        }
        elsif ($dir ne "inout" && $this_dir ne $dir) {
          &add_error("Port has conflicting direction: ${top_port}=${dir}, ${inst_port}=${this_dir}");
        }

        if (!defined $port_type) {
          $port_type = "";
        }
        if (!defined $wire_type) {
          $wire_type = "wire";
        }
        if (!defined $port_bus) {
          if ($this_width > 1) {
            $port_bus = "[" . ($this_width-1) . ":0]";
          }
          else {
            $port_bus = "";
          }
        }
      }
      else {
        my ($inst, $module_port) = split(/\//, $inst_port);
        my $module;
        foreach my $search_mod (keys %all_modules) {
          if (defined $all_modules{$search_mod}{$inst}) {
            $module = $search_mod;
            last;
          }
        }

        my $bit  = "";
        if ($module_port =~ /(\S+?)(\[\d+\])/) {
          $module_port = $1;
          $bit = $2;
        }

        # Sanity check that the module and port exists
        if (!&has_port(\%data, $module, $module_port, $inst)) {
          &add_error("Port does not exist in dest module: ${module}/${module_port}");
        }

        # Check direction
        my $this_dir = &get_direction(\%data, $module, $module_port, $inst);
        if ($this_dir eq "undirected") {
          # Cant have a port connected to an undirected wire; port direction is assumed from the direction of its connection
          #&add_error("Top level port cannot connect to an undirected wire: $top_port <=> ${module}/${module_port}");

          # Skip undirected top level wires and hope that the direction can be inferred from other connections
        }
        elsif (!defined $dir) {
          $dir = $this_dir;
        }
        elsif ($this_dir eq "inout") {
          # If any connected pin is inout, then the top port must be inout
          $dir = "inout";
        }
        elsif ($dir ne "inout" && $this_dir ne $dir) {
          &add_error("Port has conflicting direction: ${top_port}=${dir}, ${module}/${module_port}=${this_dir}");
        }

        # Check type
        my $type = &get_type(\%data, $module, $module_port, $inst);
        my $this_port_type;
        my $this_wire_type;
        if ($type =~ /^logic|none|wire$/) {
          $this_port_type = "";
          $this_wire_type = "wire";
        }
        else {
          $this_port_type = $type;
          $this_wire_type = $type;
        }
        if (!defined $port_type) {
          $port_type = $this_port_type;
        }
        if (!defined $wire_type) {
          $wire_type = $this_wire_type;
        }
        elsif ($wire_type ne $this_wire_type) {
          &add_error("Port has conflicting type: ${top_port}=${wire_type}, ${module}/${module_port}=${this_wire_type}");
        }

        # Check width
        my $this_width = 1;
        if ($bit eq "" && &is_port_bus(\%data, $module, $module_port, $inst)) {
          my $msb = &get_msb(\%data, $module, $module_port, $inst);
          my $lsb = &get_lsb(\%data, $module, $module_port, $inst);
          $this_width = abs($msb-$lsb)+1;
        }
        if (!defined $width) {
          $width = $this_width;
        }
        elsif ($width != $this_width) {
          if ($glb_waive_width) {
            &add_warn("Port has conflicting bus width: ${top_port}=${width}, ${inst}/${module_port}=${this_width}");
          }
          else {
            &add_error("Port has conflicting bus width: ${top_port}=${width}, ${inst}/${module_port}=${this_width}");
          }
        }
        if ($bit eq "") {
          if ($width > 1) {
            my $msb = $width-1;
            my $lsb = 0;
            $port_bus = "[${msb}:${lsb}]";
          }
          else {
            $port_bus = "";
          }
        }
        else {
          $port_bus = "";
        }

        # Check bus type
        my $this_bus_type = &get_bus_type(\%data, $module, $module_port, $inst);
        if ($this_dir eq "undirected") {
          # Dont copy bus type from an undirected top level wire
        }
        elsif (!defined $bus_type) {
          # Only use the current bus type if a single bit was not selected
          if ($bit ne "") {
            $bus_type = "none";
          }
          else {
            $bus_type = $this_bus_type;
          }
        }
        elsif ($bit eq "" && $bus_type ne $this_bus_type) {
          &add_error("Port has conflicting bus type: ${top_port}=${bus_type}, ${module}/${module_port}=${this_bus_type}");
        }
      }

      # Check for this port being inout and having a literal which is not allowed
      if ($has_literal && $dir eq "inout") {
        &add_error("Port cannot be both inout and connected to a literal: $top_port");
      }
    }

    # Check that direction was correctly found
    if (!defined $dir) {
      &add_error("Direction could not be inferred for top level port: $top_port");
    }

    # Process top port connections
    #foreach my $inst_port (sort @{ $config_ports{$top_port} }) {
    foreach my $href_entry (sort { $a->{conn} cmp $b->{conn} } @{ $config_ports{$top_port} }) {
      my $inst_port = $href_entry->{conn};
      my $ifdef     = $href_entry->{ifdef};
      my $ifndef    = $href_entry->{ifndef};

      # Because ports cant see custom defines defined inside top module, translate
      #   back to regular defines, but check that only one ifdef or ifndef is used
      my $define;
      my $nodefine;
      if (defined $ifdef) {
        my @stmts = split(/__/, $ifdef);
        if (scalar(@stmts) > 1) {
          &add_error("More than one ifdef in statement for top port $top_port: $ifdef\n");
        }
        else {
          $stmts[0] =~ /(IFDEF|IFNDEF)_(\S+)/;
          my $def_type = lc($1);
          my $def_name = $2;
          $define = "$def_type $def_name";
        }
      }
      elsif (defined $ifndef) {
        my @stmts = split(/__/, $ifndef);
        if (scalar(@stmts) > 1) {
          &add_error("More than one ifdef in statement for top port $top_port: $ifndef\n");
        }
        else {
          $stmts[0] =~ /(IFDEF|IFNDEF)_(\S+)/;
          my $def_type = lc($1);
          my $def_name = $2;

          if ($def_type eq "ifdef") {
            $def_type = "ifndef";
          }
          elsif ($def_type eq "ifndef") {
            $def_type = "ifdef";
          }

          $define = "$def_type $def_name";
        }
      }
      else {
        $nodefine = 1;
      }

      my $inst;
      my $module_port;
      my $module;
      my $bit      = "";
      my $wire_bus = "";
      if ($inst_port =~ /\'/) {

      }
      else {
        ($inst, $module_port) = split(/\//, $inst_port);
        #my $module;
        foreach my $search_mod (keys %all_modules) {
          if (defined $all_modules{$search_mod}{$inst}) {
            $module = $search_mod;
            last;
          }
        }

        #my $bit  = "";
        if ($module_port =~ /(\S+?)(\[\d+\])/) {
          $module_port = $1;
          $bit = $2;
        }

        #my $wire_bus  = "";
        if (&is_port_bus(\%data, $module, $module_port)) {
          my $msb = &get_msb(\%data, $module, $module_port, $inst);
          my $lsb = &get_lsb(\%data, $module, $module_port, $inst);
          $wire_bus = "[${msb}:${lsb}]";
        }

        if (&get_direction(\%data, $module, $module_port, $inst) eq "undirected") {
          &add_wire_connection(\%data, $module, $module_port, $top_name, $top_port, $dir);
        }
      }

      if ($dir eq "inout") {
        if (defined $ifdef || defined $ifndef) {
          # Warn when an ifdef is specified for an inout connection since there will be no
          # assign statement to wrap and ifdef around
          &add_error("Ifdef/ifndef invalid for inout top port connection: $top_port <-> $module/$module_port");
        }

        $insts{$inst}{mod}    = $module;
        $insts{$inst}{ifdef}  = $config{$inst}{ifdef};
        $insts{$inst}{ifndef} = $config{$inst}{ifndef};
        &set_bit_connected(\%data, $module, $module_port, $inst, $bit);
        if (!defined $bus_type || $bus_type eq "none" || $bus_type eq "packed") {
          $top_ports{$top_port}{val} = "${dir} ${port_type}${port_bus}";

          if (defined $nodefine) {
            $top_ports{$top_port}{nodefine} = $nodefine;
          }
          else {
            if (defined $top_ports{$top_port}{define} && $top_ports{$top_port}{define} ne $define) {
              &add_error("More than one ifdef in statement for top port $top_port: $top_ports{$top_port}{define}, $define\n");
            }
            else {
              $top_ports{$top_port}{define} = $define;
            }
          }
        }
        elsif (defined $bus_type && $bus_type eq "unpacked") {
          $top_ports{"${top_port}${port_bus}"}{val} = "${dir} ${port_type}";

          if (defined $nodefine) {
            $top_ports{"${top_port}${port_bus}"}{nodefine} = $nodefine;
          }
          else {
            if (defined $top_ports{"${top_port}${port_bus}"}{define} && $top_ports{"${top_port}${port_bus}"}{define} != $define) {
              &add_error("More than one ifdef in statement for top port $top_port: " . $top_ports{"${top_port}${port_bus}"}{define} . ", $define\n");
            }
            else {
              $top_ports{"${top_port}${port_bus}"}{define} = $define;
            }
          }
        }

        if ($bit ne "") {
          $wire_block{$top_name}{wire}{"OURS_UNCONNECTED"} = "wire";
          my $msb = &get_msb(\%data, $module, $module_port, $inst);
          my $lsb = &get_lsb(\%data, $module, $module_port, $inst);
          $bit =~ /\[(\d+)\]/;
          my $bit_num = $1;
          if (defined $insts{$inst}{pins}{$module_port}) {
            my $net = $insts{$inst}{pins}{$module_port};
            $net =~ s/\{|\}//g;
            my @nets = split(/\s*\,\s*/, $net);
            my $j = 0;
            for (my $i = $msb; $i >= $lsb; $i--) {
              if ($i == $bit_num) {
                $nets[$j] = $top_port;
              }
              $j++;
            }
            $net = join(", ", @nets);
            $net = "{${net}}";
            $insts{$inst}{pins}{$module_port} = $net;
          }
          else {
            my $net = "{";
            for (my $i = $msb; $i >= $lsb; $i--) {
              if ($i == $bit_num) {
                $net .= "${top_port}, ";
              }
              else {
                $net .= "OURS_UNCONNECTED, ";
              }
            }
            $net =~ s/\,\s*$//;
            $net .= "}";
            $insts{$inst}{pins}{$module_port} = $net;
          }
        }
        else {
          $insts{$inst}{pins}{$module_port} = $top_port;
        }
      }
      else {
        my $wire_name;
        my $dest_name;
        if ($inst_port =~ /\'/) {
          $wire_name = $inst_port;
          $dest_name = $inst_port;
        }
        else {
          $wire_name = "${inst}__${module_port}";
          $dest_name = "${inst}/${module_port}";
        }
        # Connection is not a literal
        if (!defined $bus_type || $bus_type eq "none" || $bus_type eq "packed") {
          $top_ports{$top_port}{val}    = "${dir} ${port_type}${port_bus}";

          if (defined $nodefine) {
            $top_ports{$top_port}{nodefine} = $nodefine;
          }
          else {
            if (defined $top_ports{$top_port}{define} && $top_ports{$top_port}{define} ne $define) {
              &add_error("More than one ifdef in statement for top port $top_port: $top_ports{$top_port}{define}, $define\n");
            }
            else {
              $top_ports{$top_port}{define} = $define;
            }
          }

          if ($inst_port !~ /\'/) {
            $wire_block{$inst}{ifdef}  = $config{$inst}{ifdef};
            $wire_block{$inst}{ifndef} = $config{$inst}{ifndef};
            $wire_block{$inst}{wire}{$wire_name} = "${wire_type}${wire_bus}";
          }
        }
        elsif (defined $bus_type && $bus_type eq "unpacked") {
          $top_ports{"${top_port}${port_bus}"}{val}    = "${dir} ${port_type}";

          if (defined $nodefine) {
            $top_ports{"${top_port}${port_bus}"}{nodefine} = $nodefine;
          }
          else {
            if (defined $top_ports{"${top_port}${port_bus}"}{define} && $top_ports{"${top_port}${port_bus}"}{define} != $define) {
              &add_error("More than one ifdef in statement for top port $top_port: " . $top_ports{"${top_port}${port_bus}"}{define} . ", $define\n");
            }
            else {
              $top_ports{"${top_port}${port_bus}"}{define} = $define;
            }
          }

          if ($inst_port !~ /\'/) {
            $wire_block{$inst}{ifdef}  = $config{$inst}{ifdef};
            $wire_block{$inst}{ifndef} = $config{$inst}{ifndef};
            $wire_block{$inst}{wire}{"${wire_name}${wire_bus}"} = $wire_type;
          }
        }

        # Check whether this instance was part of a set of multiple instances with the same name
        # Disable ifdef for these wires if so
        my $is_mult = 0;
        foreach my $href_inst (@dup_config) {
          if ($inst eq  (keys %$href_inst)[0]) {
            $is_mult = 1;
          }
        }

        if ($dir eq "input") {
          if (!defined $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{assign}{"${wire_name}${bit}"}) {
            $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{assign}{"${wire_name}${bit}"} = [];
          }

          # Propagate ifdef/ifndef from instance if necessary
          if (defined $ifdef && defined $config{$inst}{ifdef}) {
            if ($ifdef ne $config{$inst}{ifdef}) {
              &add_error("Ifdef conflict on top port $top_port and connection $dest_name: $ifdef, $config{$inst}{ifdef}\n");
            }
            else {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef}  = $ifdef;
            }
          }
          elsif (defined $ifdef) {
            $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef} = $ifdef;
          }
          elsif (defined $config{$inst}{ifdef}) {
            if (!$is_mult) {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef} = $config{$inst}{ifdef};
            }
          }
          if (defined $ifndef && defined $config{$inst}{ifndef}) {
            if ($ifndef ne $config{$inst}{ifndef}) {
              &add_error("Ifndef conflict on top port $top_port and connection $dest_name: $ifndef, $config{$inst}{ifndef}\n");
            }
            else {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef}  = $ifndef;
            }
          }
          elsif (defined $ifndef) {
            $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef} = $ifndef;
          }
          elsif (defined $config{$inst}{ifndef}) {
            if (!$is_mult) {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef} = $config{$inst}{ifndef};
            }
          }
          #$assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef}  = $ifdef;
          #$assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef} = $ifndef;

          push(@{ $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{assign}{"${wire_name}${bit}"} }, $top_port);
          &set_bit_connected(\%data, $module, $module_port, $inst, $bit);
          #$assigns{"${top_name}/${top_port} <-> ${dest_name}"}{"${wire_name}${bit}"} = $top_port;
        }
        if ($dir eq "output") {
          if (!defined $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{assign}{$top_port}) {
            $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{assign}{$top_port} = [];
          }

          # Propagate ifdef/ifndef from instance if necessary
          if (defined $ifdef && defined $config{$inst}{ifdef}) {
            if ($ifdef ne $config{$inst}{ifdef}) {
              &add_error("Ifdef conflict on top port $top_port and connection $dest_name: $ifdef, $config{$inst}{ifdef}\n");
            }
            else {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef}  = $ifdef;
            }
          }
          elsif (defined $ifdef) {
            $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef} = $ifdef;
          }
          elsif (defined $config{$inst}{ifdef}) {
            if (!$is_mult) {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef} = $config{$inst}{ifdef};
            }
          }
          if (defined $ifndef && defined $config{$inst}{ifndef}) {
            if ($ifndef ne $config{$inst}{ifndef}) {
              &add_error("Ifndef conflict on top port $top_port and connection $dest_name: $ifndef, $config{$inst}{ifndef}\n");
            }
            else {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef}  = $ifndef;
            }
          }
          elsif (defined $ifndef) {
            $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef} = $ifndef;
          }
          elsif (defined $config{$inst}{ifndef}) {
            if (!$is_mult) {
              $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef} = $config{$inst}{ifndef};
            }
          }
          #$assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifdef}  = $ifdef;
          #$assigns{"${top_name}/${top_port} <-> ${dest_name}"}{ifndef} = $ifndef;

          push(@{ $assigns{"${top_name}/${top_port} <-> ${dest_name}"}{assign}{$top_port} }, "${wire_name}${bit}");
          &set_bit_connected(\%data, $module, $module_port, $inst, $bit);
          #$assigns{"${top_name}/${top_port} <-> ${dest_name}"}{$top_port} = "${wire_name}${bit}";
        }
        
        if ($inst_port !~ /\'/) {
          $insts{$inst}{mod} = $module;
          $insts{$inst}{pins}{$module_port} = $wire_name;
          $insts{$inst}{ifdef}  = $config{$inst}{ifdef};
          $insts{$inst}{ifndef} = $config{$inst}{ifndef};
        }
      }
    }
  }
  
  # Check all top level wires to make sure that there is not more than one input connection
  foreach my $wire_name (keys %{ $data{$top_name}{ports} }) {
    my %count = (num  => {input => 0, output => 0, inout => 0},
                 list => {input => [], output => [], inout => []});
    # my %count = ();
    # $count{num}{input} = 0;
    # $count{num}{output} = 0;
    # $count{num}{inout} = 0;
    # $count{list}{input} = [];
    # $count{list}{output} = [];
    # $count{list}{inout} = [];
    # %count =
    #   num =
    #     input|output|inout = <int>
    #   list =
    #     input|output|inout = [] # list of port names
    #
    foreach my $conn_module (keys %{ $data{$top_name}{ports}{$wire_name}{default}{conn} }) {
      foreach my $conn_port (keys %{ $data{$top_name}{ports}{$wire_name}{default}{conn}{$conn_module} }) {
        my $dir = $data{$top_name}{ports}{$wire_name}{default}{conn}{$conn_module}{$conn_port};
        $count{num}{$dir}++;
        push(@{ $count{list}{$dir} }, "${conn_module}/${conn_port}");
      }
    }
    if ($count{num}{input} > 1) {
      my $inputs_list = join(", ", @{ $count{list}{input} });
      &add_warn("Top level wire has more than one input connection: ${top_name}/${wire_name} <= $inputs_list");
    }
    if ($count{num}{inout} > 0 && ($count{num}{output} > 0 || $count{num}{input} > 0)) {
      my $inout_list  = join(", ", @{ $count{list}{inout} });
      my $others_list = join(", ", @{ $count{list}{input} }, @{ $count{list}{output} });
      &add_warn("Top level wire is both connected to an inout port and input/output ports: ${top_name}/${wire_name} <= inouts: $inout_list; others: $others_list");
    }
  }

  # Add leftover instances
  foreach my $module_name (keys %all_modules) {
    foreach my $inst_name (keys %{ $all_modules{$module_name} }) {
      if (!defined $insts{$inst_name}) {
        $insts{$inst_name}{mod} = $module_name;
        $insts{$inst_name}{ifdef}  = $config{$inst_name}{ifdef};
        $insts{$inst_name}{ifndef} = $config{$inst_name}{ifndef};
      }
    }
  }

  # Add leftover unconnected ports
  my %unconnected = ();
  foreach my $inst_name (keys %insts) {
    my $module_name = $insts{$inst_name}{mod};
    my $ifdef       = $insts{$inst_name}{ifdef};
    my $ifndef      = $insts{$inst_name}{ifndef};
    foreach my $port_name (sort keys %{ $data{$module_name}{ports} }) {
      if (!defined $insts{$inst_name}{pins}{$port_name}) {
        # Save to print warning later
        $unconnected{$inst_name}{$port_name} = 1;

        my $type = &get_type(\%data, $module_name, $port_name);
        if ($type =~ /^logic|none|wire$/) {
          $type = "wire";
        }

        if (&is_port_bus(\%data, $module_name, $port_name)) {
          my $msb      = &get_msb(\%data, $module_name, $port_name, $inst_name);
          my $lsb      = &get_lsb(\%data, $module_name, $port_name, $inst_name);
          my $bus_type = &get_bus_type(\%data, $module_name, $port_name, $inst_name);
          if (!defined $bus_type || $bus_type eq "" || $bus_type eq "none" || $bus_type eq "packed") {
            $wire_block{$inst_name}{ifdef}  = $config{$inst_name}{ifdef};
            $wire_block{$inst_name}{ifndef} = $config{$inst_name}{ifndef};
            $wire_block{$inst_name}{wire}{"${inst_name}__${port_name}"} = "${type}[${msb}:${lsb}]";
            &set_max_len(\$wire_max_len, "${type}[${msb}:${lsb}]");
          }
          elsif ($bus_type eq "unpacked") {
            $wire_block{$inst_name}{ifdef}  = $config{$inst_name}{ifdef};
            $wire_block{$inst_name}{ifndef} = $config{$inst_name}{ifndef};
            $wire_block{$inst_name}{wire}{"${inst_name}__${port_name}[${msb}:${lsb}]"} = $type;
            &set_max_len(\$wire_max_len, $type);
          }
        }
        else {
          $wire_block{$inst_name}{ifdef}  = $config{$inst_name}{ifdef};
          $wire_block{$inst_name}{ifndef} = $config{$inst_name}{ifndef};
          $wire_block{$inst_name}{wire}{"${inst_name}__${port_name}"} = "${type}";
          &set_max_len(\$wire_max_len, $type);
        }
        $insts{$inst_name}{pins}{$port_name} = "${inst_name}__${port_name}";
      }
    }
  }

  # Add unconnected individual bits from array signals that are partially connected
  foreach my $module (keys %data) {
    foreach my $port (keys %{ $data{$module}{ports} }) {
      foreach my $inst (keys %{ $data{$module}{ports}{$port} }) {
        next if ($inst eq "default");

        if (&is_port_bus(\%data, $module, $port, $inst)) {
          my $msb = &get_msb(\%data, $module, $port, $inst);
          my $lsb = &get_lsb(\%data, $module, $port, $inst);
          my $upper = $msb;
          my $lower = $lsb;
          if ($msb < $lsb) {
            $lower = $msb;
            $upper = $lsb;
          }

          my %all_bits = ();
          foreach my $bit ($lower..$upper) {
            $all_bits{$bit} = 1;
          }

          foreach my $bit (keys %{ $data{$module}{ports}{$port}{$inst}{connected} }) {
            $bit =~ s/\[|\]//g;

            delete $all_bits{$bit};
          }

          foreach my $bit (keys %all_bits) {
            # Check that the port (full bus) is not already reported as unconnected or skipped
            if (!defined $unconnected{$inst}{$port} && !defined $skipped_literals{"${inst}/${port}"}) {
              $unconnected{$inst}{"${port}[${bit}]"} = 1;
            }
          }
        }
      }
    }
  }

  &print_warns;
  &print_errors;

  # Print top ports
  my $port_block = "(\n";
  foreach my $port_name (sort keys %top_ports) {
    my $define   = $top_ports{$port_name}{define};
    my $nodefine = $top_ports{$port_name}{nodefine};

    if (defined $define && !defined $nodefine) {
      $port_block .= "  \`$define\n";
    }

    $port_block .= "  $top_ports{$port_name}{val} ${port_name},\n";

    if (defined $define && !defined $nodefine) {
      $port_block .= "  \`endif\n";
    }
  }
  $port_block =~ s/\,$//;
  $port_block .= ");\n";
  print $fh_out "$port_block\n";

  # Print ifdef defines
  foreach my $define_name (sort keys %ifdefs) {
    my $level = 1;
    my $indent;
    foreach my $stmt (@{ $ifdefs{$define_name} }) {
      $indent = "  " x $level;
      print $fh_out "${indent}\`${stmt}\n";
      $level++;
    }
    $indent = "  " x $level;
    print $fh_out "${indent}\`define $define_name\n";
    foreach my $stmt (@{ $ifdefs{$define_name} }) {
      $level--;
      $indent = "  " x $level;
      print $fh_out "${indent}\`endif\n";
    }
    print $fh_out "\n";
  }

  # Print wires
  foreach my $inst (sort keys %wire_block) {
    my $ifdef  = $wire_block{$inst}{ifdef};
    my $ifndef = $wire_block{$inst}{ifndef};

    if ($glb_hack_inst) {
      # Check whether this instance was part of a set of multiple instances with the same name
      # Disable ifdef for these wires if so
      foreach my $href_inst (@dup_config) {
        if ($inst eq  (keys %$href_inst)[0]) {
          $ifdef = undef;
          $ifndef = undef;
        }
      }
    }

    if (defined $ifdef) {
      print $fh_out "  \`ifdef $ifdef\n";
    }
    if (defined $ifndef) {
      print $fh_out "  \`ifndef $ifndef\n";
    }

    foreach my $wire_name (sort keys %{ $wire_block{$inst}{wire} }) {
      my $type = $wire_block{$inst}{wire}{$wire_name};
      printf $fh_out "  %-${wire_max_len}s %s;\n", $type, $wire_name;
    }

    if (defined $ifdef || defined $ifndef) {
      print $fh_out "  \`endif\n";
    }
  }
  print $fh_out "\n";

  # Print assigns
  foreach my $conn_string (sort keys %assigns) {
    my $ifdef  = $assigns{$conn_string}{ifdef};
    my $ifndef = $assigns{$conn_string}{ifndef};

    if ($glb_hack_inst) {
      # Find src and des insts from conn_string
      my $src_inst;
      my $des_inst;
      my ($src_conn, $des_conn) = split(/\s*\<\-\>\s*/, $conn_string);
      if ($src_conn =~ /(\S+)(\.|\/)(\S+)/) {
        $src_inst = $1;
      }
      if ($des_conn =~ /(\S+)(\.|\/)(\S+)/) {
        $des_inst = $1;
      }

      # Check whether this instance was part of a set of multiple instances with the same name
      # Disable ifdef for these assigns if so
      # 
      # This is currently disabled because ifdef inheritance is disabled in parse_config_files
      # Direct ifdef definitions are now enabled for instances in multiple instance sets
      # foreach my $href_inst (@dup_config) {
      #   if ((defined $src_inst && $src_inst eq (keys %$href_inst)[0]) ||
      #       (defined $des_inst && $des_inst eq (keys %$href_inst)[0])) {
      #     $ifdef = undef;
      #     $ifndef = undef;
      #   }
      # }
    }

    if (defined $ifdef) {
      print $fh_out "  \`ifdef $ifdef\n";
    }
    if (defined $ifndef) {
      print $fh_out "  \`ifndef $ifndef\n";
    }

    print $fh_out "  // $conn_string\n";
    foreach my $left (sort keys %{ $assigns{$conn_string}{assign} }) {
      if (ref($assigns{$conn_string}{assign}{$left}) eq "ARRAY") {
        foreach my $right (@{ $assigns{$conn_string}{assign}{$left} }) {
          printf $fh_out "  assign %-${assign_max_len}s = %s;\n", $left, $right;
        }
      }
      else {
        my $right = $assigns{$conn_string}{assign}{$left};
        printf $fh_out "  assign %-${assign_max_len}s = %s;\n", $left, $right;
      }
    }

    if (defined $ifdef || defined $ifndef) {
      print $fh_out "  \`endif\n";
    }
    print $fh_out "\n";
  }
  print $fh_out "\n";

  # Print instances
  foreach my $inst_name (sort keys %insts) {
    next if ($inst_name eq $top_name);
    my $inst_block = "";
    my $module = $insts{$inst_name}{mod};
    my $ifdef  = $insts{$inst_name}{ifdef};
    my $ifndef = $insts{$inst_name}{ifndef};
    if (defined $ifdef) {
      print $fh_out "\`ifdef $ifdef\n";
    }
    if (defined $ifndef) {
      print $fh_out "\`ifndef $ifndef\n";
    }

      # Use an ID string if instance is ifdef wrapped for case where
      #   instance is duplicated with different params
      my $inst_def_id = "none";
      if (defined $ifdef) {
        $inst_def_id = "define:$ifdef";
      }
      if (defined $ifndef) {
        $inst_def_id = "ndefine:$ifndef";
      }

    if (defined $inst_params{$module}{$inst_name}) {
      $inst_block .= "$module #(";
      foreach my $param_name (sort keys %{ $inst_params{$module}{$inst_name}{args}{$inst_def_id} }) {
        my $param_val = $inst_params{$module}{$inst_name}{args}{$inst_def_id}{$param_name};
        $inst_block .= ".${param_name}(${param_val}), ";
      }
      $inst_block =~ s/\,\s+$//;
      $inst_block .= ") $inst_name(\n";
    }
    else {
      $inst_block .= "$module $inst_name(\n";
    }

    foreach my $pin_name (sort keys %{ $insts{$inst_name}{pins} }) {
      my $conn_name = $insts{$inst_name}{pins}{$pin_name};
      $inst_block .= "  .${pin_name}(${conn_name}),\n";
    }
    $inst_block =~ s/\,$//;
    $inst_block .= ");\n";
    print $fh_out $inst_block;

    if (defined $ifdef || defined $ifndef) {
      print $fh_out "\`endif\n";
    }
    print $fh_out "\n";
  }

  if ($glb_hack_inst) {
    # HACK: Print instances that were overwritten due to having the same name
    #   but different module
    foreach my $href_inst (@dup_config) {
      my $inst_name = (keys %$href_inst)[0];
      my $module    = $href_inst->{$inst_name}{mod};
      my $ifdef     = $href_inst->{$inst_name}{ifdef};
      my $ifndef    = $href_inst->{$inst_name}{ifndef};

      next if ($inst_name eq $top_name);
      my $inst_block = "";
      if (defined $ifdef) {
        print $fh_out "\`ifdef $ifdef\n";
      }
      if (defined $ifndef) {
        print $fh_out "\`ifndef $ifndef\n";
      }

      # Use an ID string if instance is ifdef wrapped for case where
      #   instance is duplicated with different params
      my $inst_def_id = "none";
      if (defined $ifdef) {
        $inst_def_id = "define:$ifdef";
      }
      if (defined $ifndef) {
        $inst_def_id = "ndefine:$ifndef";
      }

      if (defined $inst_params{$module}{$inst_name}) {
        $inst_block .= "$module #(";
        foreach my $param_name (sort keys %{ $inst_params{$module}{$inst_name}{args}{$inst_def_id} }) {
          my $param_val = $inst_params{$module}{$inst_name}{args}{$inst_def_id}{$param_name};
          $inst_block .= ".${param_name}(${param_val}), ";
        }
        $inst_block =~ s/\,\s+$//;
        $inst_block .= ") $inst_name(\n";
      }
      else {
        $inst_block .= "$module $inst_name(\n";
      }

      foreach my $pin_name (sort keys %{ $insts{$inst_name}{pins} }) {
        my $conn_name = $insts{$inst_name}{pins}{$pin_name};
        $inst_block .= "  .${pin_name}(${conn_name}),\n";
      }
      $inst_block =~ s/\,$//;
      $inst_block .= ");\n";
      print $fh_out $inst_block;

      if (defined $ifdef || defined $ifndef) {
        print $fh_out "\`endif\n";
      }
      print $fh_out "\n";
    }
  }
  
  print $fh_out "endmodule\n";

  &Hydra::Util::File::close_file($fh_out);

  # Print ports that were specified to be connected to a literal but skipped
  if (scalar(keys %skipped_literals) > 0) {
    print "WARN: The following ports were not connected to a literal due to not being input/inout:\n";
    foreach my $name (sort keys %skipped_literals) {
      print "        ${name}\n";
    }
  }

  # Print unconnected ports
  if (scalar(keys %unconnected) > 0) {
    print "WARN: The following ports were not configured and will be left unconnected on top level:\n";
    foreach my $inst_name (sort keys %unconnected) {
      foreach my $port_name (sort keys %{ $unconnected{$inst_name} }) {
        if (!defined $skipped_literals{"${inst_name}/${port_name}"}) {
          # Dont print unconnected ports that were skipped literals
          print "        ${inst_name}/${port_name}\n";
        }
      }
    }
  }

  # Print ports that were connected to a literal
  if (scalar(keys %literals) > 0) {
    print "WARN: The following ports were connected to a literal:\n";
    foreach my $port_name (sort keys %literals) {
      print "        ${port_name}\n";
    }
  }

  # Search assigns for multiple drivers and warn
  my $has_multi_driver = 0;
  my %sinks = ();
  # %sinks => 
  #   $sink_name => 
  #     $driver_name = 1
  #
  foreach my $code_block_name (keys %assigns) {
    foreach my $sink (keys %{ $assigns{$code_block_name}{assign} }) {
      my $driver = $assigns{$code_block_name}{assign}{$sink};
      if (defined $sinks{$sink}) {
        $has_multi_driver = 1;
      }

      if (ref($driver) eq "ARRAY") {
        foreach my $multi_driver (@$driver) {
          if (defined $sinks{$sink}) {
            $has_multi_driver = 1;
          }
          $sinks{$sink}{$multi_driver} = 1;
        }
      }
      else {
        $sinks{$sink}{$driver} = 1;
      }
    }
  }
  if ($has_multi_driver) {
    print "WARN: The following signals have multiple drivers:\n";
    foreach my $sink (sort keys %sinks) {
      if (scalar(keys %{ $sinks{$sink} }) > 1) {
        print "        $sink\n";
        foreach my $driver (sort keys %{ $sinks{$sink} }) {
          print "          <-- $driver\n";
        }
      }
    }
  }
}

sub is_port_bus {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  my $msb = &get_msb($href_data, $module, $port, $inst);
  my $lsb = &get_lsb($href_data, $module, $port, $inst);
  if ($msb ne "" && $lsb ne "") {
    return 1;
  }
  else {
    return 0;
  }
}

sub has_port {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} && 
      defined $href_data->{$module}{ports}{$port}{$inst}) {
    return 1;
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} && 
         defined $href_data->{$module}{ports}{$port}{default}) {
    return 1;
  }
  return 0;
}

sub get_direction {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} &&
      defined $href_data->{$module}{ports}{$port}{$inst}{dir}) {
    return $href_data->{$module}{ports}{$port}{$inst}{dir};
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} &&
         defined $href_data->{$module}{ports}{$port}{default}{dir}) {
    return $href_data->{$module}{ports}{$port}{default}{dir};
  }
  return "";
}

sub add_wire_connection {
  my ($href_data, $top_name, $wire, $conn_module, $conn_port, $type) = @_;
  $href_data->{$top_name}{ports}{$wire}{default}{conn}{$conn_module}{$conn_port} = $type;
}

# sub set_direction {
#   my ($href_data, $module, $port, $dir) = @_;
#   $href_data->{$module}{ports}{$port}{default}{dir} = $dir;
# }

sub get_width {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  confess if (!defined $module);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} &&
      defined $href_data->{$module}{ports}{$port}{$inst}{width}) {
    return $href_data->{$module}{ports}{$port}{$inst}{width};
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} &&
         defined $href_data->{$module}{ports}{$port}{default}{width}) {
    return $href_data->{$module}{ports}{$port}{default}{width};
  }
  return 0;
}

sub get_msb {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} &&
      defined $href_data->{$module}{ports}{$port}{$inst}{msb}) {
    return $href_data->{$module}{ports}{$port}{$inst}{msb};
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} &&
         defined $href_data->{$module}{ports}{$port}{default}{msb}) {
    return $href_data->{$module}{ports}{$port}{default}{msb};
  }
  return "";
}

sub get_lsb {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} &&
      defined $href_data->{$module}{ports}{$port}{$inst}{lsb}) {
    return $href_data->{$module}{ports}{$port}{$inst}{lsb};
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} &&
         defined $href_data->{$module}{ports}{$port}{default}{lsb}) {
    return $href_data->{$module}{ports}{$port}{default}{lsb};
  }
  return "";
}

sub get_type {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} &&
      defined $href_data->{$module}{ports}{$port}{$inst}{type}) {
    return $href_data->{$module}{ports}{$port}{$inst}{type};
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} &&
         defined $href_data->{$module}{ports}{$port}{default}{type}) {
    return $href_data->{$module}{ports}{$port}{default}{type};
  }
  return "";
}

sub get_bus_type {
  my ($href_data, $module, $port, $inst) = @_;
  $inst = "default" if (!defined $inst);
  if (defined $href_data->{$module} && 
      defined $href_data->{$module}{ports}{$port} &&
      defined $href_data->{$module}{ports}{$port}{$inst}{bus_type}) {
    return $href_data->{$module}{ports}{$port}{$inst}{bus_type};
  }
  elsif (defined $href_data->{$module} && 
         defined $href_data->{$module}{ports}{$port} &&
         defined $href_data->{$module}{ports}{$port}{default}{bus_type}) {
    return $href_data->{$module}{ports}{$port}{default}{bus_type};
  }
  return "";
}

sub add_error {
  my ($string) = @_;
  push(@glb_errors, $string);
}

sub add_warn {
  my ($string) = @_;
  push(@glb_warns, $string);
}

sub print_errors {
  if (scalar(@glb_errors) > 0) {
    print "ERROR: Fix the following errors and re-run:\n";
    foreach my $string (@glb_errors) {
      print "  $string\n";
    }
    die;
  }
}

sub print_warns {
  if (scalar(@glb_warns) > 0) {
    print "WARN: The following are non-fatal warnings:\n";
    foreach my $string (@glb_warns) {
      print "  $string\n";
    }
  }
}

sub set_max_len {
  my ($sref_len, $string) = @_;
  if (length($string) > $$sref_len) {
    $$sref_len = length($string);
  }
  return;
}

sub sanity_check_literal {
  my ($href_data, $src_mod, $src_obj, $des_literal, $mode, $base_port, $src_bit, $src_inst) = @_;
  my $src_port;
  if ($mode eq "port") {
    if ($src_obj =~ /(\S+?)\[(\d+)\]/) {
      $src_port = $1;
      $src_bit  = $2;
    }
    else {
      $src_port = $src_obj;
    }
  }
  elsif ($mode eq "interface") {
    if ($src_obj =~ /\./) {
      my ($src_prefix, $src_suffix) = split(/\./, $src_obj);
      $src_port = "${src_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${src_suffix}";
    }
    else {
      $src_port = "${src_obj}${glb_int_port_sep}${base_port}";
    }
  }

  # Check that src port exists
  if (!&has_port($href_data, $src_mod, $src_port, $src_inst)) {
    &add_error("Port does not exist in source module: ${src_mod}/${src_port}");
  }

  if (&has_port($href_data, $src_mod, $src_port, $src_inst)) {
    # Check that directions are correct (literals are always output)
    if (&get_direction($href_data, $src_mod, $src_port, $src_inst) eq "undirected") {
      # Modify src direction to input
      #&set_direction($href_data, $src_mod, $src_port, "input");
      # Record connection direction for this wire for later inspection
      &add_wire_connection($href_data, $src_mod, $src_port, "HYDRA_LITERAL", $des_literal, "input");
    }
    elsif (&get_direction($href_data, $src_mod, $src_port, $src_inst) !~ /input|inout/) {
      # Skip non-input/output pins instead of erroring out
      #&add_warn("Skipping connect of src port to literal since it is not input/inout: ${src_mod}/${src_port}");
      return 0;
    }

    # Check that the port bit is between the msb/lsb
    if (defined $src_bit) {
      my $src_msb = &get_msb($href_data, $src_mod, $src_port, $src_inst);
      my $src_lsb = &get_lsb($href_data, $src_mod, $src_port, $src_inst);
      if ($src_msb eq "" || $src_lsb eq "") {
        &add_error("Bit specified on non-bus port: ${src_mod}/${src_port}[${src_bit}]");
      }
      elsif (!($src_bit <= $src_msb && $src_bit >= $src_lsb)) {
        &add_error("Port bit is not in bus: ${src_mod}/${src_port}[${src_bit}] is outside [${src_msb}:${src_lsb}]");
      }
    }
  }

  return 1;
}

sub sanity_check {
  my ($href_data, $src_mod, $des_mod, $src_obj, $des_obj, $mode, $base_port, $src_bit, $des_bit, $src_inst, $des_inst) = @_;
  my $src_port;
  my $des_port;
  #my $src_bit;
  #my $des_bit;
  if ($mode eq "port") {
    if ($src_obj =~ /(\S+?)\[(\d+)\]/) {
      $src_port = $1;
      $src_bit  = $2;
    }
    else {
      $src_port = $src_obj;
    }

    if ($des_obj =~ /(\S+?)\[(\d+)\]/) {
      $des_port = $1;
      $des_bit  = $2;
    }
    else {
      $des_port = $des_obj;
    }
  }
  elsif ($mode eq "interface") {
    # if ($src_obj =~ /(\S+?)\[(\d+)\]/) {
    #   $src_port = "${src_obj}${glb_int_port_sep}${1}";
    #   $src_bit  = $2;
    # }
    # else {
    #   $src_port = "${src_obj}${glb_int_port_sep}${base_port}";
    # }

    # if ($des_obj =~ /(\S+?)\[(\d+)\]/) {
    #   $des_port = "${des_obj}${glb_int_port_sep}${1}";
    #   $des_bit  = $2;
    # }
    # else {
    #   $des_port = "${des_obj}${glb_int_port_sep}${base_port}";
    # }

    if ($src_obj eq "*") {
      $src_port = $base_port;
    }
    elsif ($src_obj =~ /\*\.(\S+)/) {
      my $src_suffix = $1;
      $src_port = "${base_port}${glb_int_port_sep}${src_suffix}";
    }
    elsif ($src_obj =~ /\./) {
      my ($src_prefix, $src_suffix) = split(/\./, $src_obj);
      $src_port = "${src_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${src_suffix}";
    }
    else {
      $src_port = "${src_obj}${glb_int_port_sep}${base_port}";
    }

    if ($des_obj eq "*") {
      $des_port = $base_port;
    }
    elsif ($des_obj =~ /\*\.(\S+)/) {
      my $des_suffix = $1;
      $des_port = "${base_port}${glb_int_port_sep}${des_suffix}";
    }
    elsif ($des_obj =~ /\./) {
      my ($des_prefix, $des_suffix) = split(/\./, $des_obj);
      $des_port = "${des_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${des_suffix}";
    }
    else {
      $des_port = "${des_obj}${glb_int_port_sep}${base_port}";
    }
  }
  elsif ($mode eq "port_int") {
    if ($src_obj =~ /(\S+?)\[(\d+)\]/) {
      $src_port = $1;
      $src_bit  = $2;
    }
    else {
      $src_port = $src_obj;
    }

    if ($des_obj =~ /\./) {
      my ($des_prefix, $des_suffix) = split(/\./, $des_obj);
      $des_port = "${des_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${des_suffix}";
    }
    else {
      $des_port = "${des_obj}${glb_int_port_sep}${base_port}";
    }
  }
  elsif ($mode eq "int_port") {
    if ($src_obj =~ /\./) {
      my ($src_prefix, $src_suffix) = split(/\./, $src_obj);
      $src_port = "${src_prefix}${glb_int_port_sep}${base_port}${glb_int_port_sep}${src_suffix}";
    }
    else {
      $src_port = "${src_obj}${glb_int_port_sep}${base_port}";
    }

    if ($des_obj =~ /(\S+?)\[(\d+)\]/) {
      $des_port = $1;
      $des_bit  = $2;
    }
    else {
      $des_port = $des_obj;
    }
  }

  # Check that the port exists in both modules
  if (!&has_port($href_data, $src_mod, $src_port, $src_inst)) {
    &add_error("Port does not exist in source module: ${src_mod}/${src_port}");
  }
  if (!&has_port($href_data, $des_mod, $des_port, $des_inst)) {
    &add_error("Port does not exist in dest module: ${des_mod}/${des_port}");
  }

  if (&has_port($href_data, $src_mod, $src_port, $src_inst) &&
      &has_port($href_data, $des_mod, $des_port, $des_inst)) {
    # Check that the directions are correct
    my $src_dir = &get_direction($href_data, $src_mod, $src_port, $src_inst);
    my $des_dir = &get_direction($href_data, $des_mod, $des_port, $des_inst);

    if ($src_dir eq "undirected" &&
        $des_dir eq "undirected") {
      # Both are undirected wires; do nothing
    }
    elsif ($src_dir eq "undirected") {
      # Modify src direction to correspond with des direction
      #&set_direction($href_data, $src_dir, $src_port, $des_dir);
      # Record connection direction for this wire for later inspection
      if ($des_dir eq "input") {
        &add_wire_connection($href_data, $src_mod, $src_port, $des_mod, $des_port, "output");
      }
      elsif ($des_dir eq "output") {
        &add_wire_connection($href_data, $src_mod, $src_port, $des_mod, $des_port, "input");
      }
      elsif ($des_dir eq "inout") {
        &add_wire_connection($href_data, $src_mod, $src_port, $des_mod, $des_port, "inout");
      }
    }
    elsif ($des_dir eq "undirected") {
      # Modify des direction to correspond with src direction
      #&set_direction($href_data, $des_dir, $des_port, $src_dir);
      # Record connection direction for this wire for later inspection
      if ($src_dir eq "input") {
        &add_wire_connection($href_data, $des_mod, $des_port, $src_mod, $src_port, "output");
      }
      elsif ($src_dir eq "output") {
        &add_wire_connection($href_data, $des_mod, $des_port, $src_mod, $src_port, "input");
      }
      elsif ($src_dir eq "inout") {
        &add_wire_connection($href_data, $des_mod, $des_port, $src_mod, $src_port, "inout");
      }
    }
    elsif ($src_dir eq "input" &&
        $des_dir !~ /^output|inout$/) {
      &add_error("Direction of dest port is not output/inout: ${des_mod}/${des_port}");
    }
    elsif ($src_dir eq "output" &&
           $des_dir !~ /^input|inout$/) {
      &add_error("Direction of dest port is not input/inout: ${des_mod}/${des_port}");
    }

    # Check that the bus widths match
    my $src_width = &get_width($href_data, $src_mod, $src_port, $src_inst);
    $src_width = 1 if (defined $src_bit);
    my $des_width = &get_width($href_data, $des_mod, $des_port, $des_inst);
    $des_width = 1 if (defined $des_bit);
    if ($src_width != $des_width) {
      if ($glb_waive_width) {
        &add_warn("Port widths do not match: ${src_inst}/${src_port}=${src_width}, ${des_inst}/${des_port}=${des_width}");
      }
      else {
        &add_error("Port widths do not match: ${src_inst}/${src_port}=${src_width}, ${des_inst}/${des_port}=${des_width}");
      }
    }

    # Check that the port bit is between the msb/lsb
    if (defined $src_bit) {
      my $src_msb = &get_msb($href_data, $src_mod, $src_port, $src_inst);
      my $src_lsb = &get_lsb($href_data, $src_mod, $src_port, $src_inst);
      if ($src_msb eq "" || $src_lsb eq "") {
        &add_error("Bit specified on non-bus port: ${src_mod}/${src_port}[${src_bit}]");
      }
      elsif (!($src_bit <= $src_msb && $src_bit >= $src_lsb)) {
        &add_error("Port bit is not in bus: ${src_inst}/${src_port}[${src_bit}] is outside [${src_msb}:${src_lsb}]");
      }
    }
    if (defined $des_bit) {
      my $des_msb = &get_msb($href_data, $des_mod, $des_port, $des_inst);
      my $des_lsb = &get_lsb($href_data, $des_mod, $des_port, $des_inst);
      if ($des_msb eq "" || $des_lsb eq "") {
        &add_error("Bit specified on non-bus port: ${des_mod}/${des_port}[${des_bit}]");
      }
      elsif (!($des_bit <= $des_msb && $des_bit >= $des_lsb)) {
        &add_error("Port bit is not in bus: ${des_inst}/${des_port}[${des_bit}] is outside [${des_msb}:${des_lsb}]");
      }
    }

    # Check that the data type is the same
    if (&get_type($href_data, $src_mod, $src_port, $src_inst) ne &get_type($href_data, $des_mod, $des_port, $des_inst)) {
      my $src_type = &get_type($href_data, $src_mod, $src_port, $src_inst);
      my $des_type = &get_type($href_data, $des_mod, $des_port, $des_inst);
      unless ($src_type =~ /^wire|logic|none$/ && $des_type =~ /^wire|logic|none$/) {
        &add_error("Port types do not match: ${src_mod}/${src_port}=${src_type}, ${des_mod}/${des_port}=${des_type}");
      }
    }
  }
}

sub find_interface_ports_mixed {
  my ($href_data, $src_mod, $des_mod, $src_conn, $des_conn, $src_inst, $des_inst, $conn_type, $href_except) = @_;
  my @src_ports = ();
  my @des_ports = ();
  my $src_bit;
  my $des_bit;

  if ($src_conn =~ /(\S+?)\[(\d+)\]/) {
    $src_conn = $1;
    $src_bit  = $2;
  }
  if ($des_conn =~ /(\S+?)\[(\d+)\]/) {
    $des_conn = $1;
    $des_bit  = $2;
  }

  my %all_ports = ();
  if ($conn_type ne "port_int") {
    if ($src_conn =~ /\./) {
      # Support for asymmetric suffix
      my ($src_prefix, $src_suffix) = split(/\./, $src_conn);
      foreach my $port_name (keys %{ $href_data->{$src_mod}{ports} }) {
        if ($port_name =~ /^\Q${src_prefix}${glb_int_port_sep}/ &&
            $port_name =~ /\Q${glb_int_port_sep}${src_suffix}$/) {
          $port_name =~ s/^${src_prefix}${glb_int_port_sep}//;
          $port_name =~ s/${glb_int_port_sep}${src_suffix}//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
    else {
      foreach my $port_name (keys %{ $href_data->{$src_mod}{ports} }) {
        if ($port_name =~ /^\Q${src_conn}${glb_int_port_sep}/) {
          $port_name =~ s/^${src_conn}${glb_int_port_sep}//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
  }
  if ($conn_type ne "int_port") {
    if ($des_conn =~ /\./) {
      # Support for asymmetric suffix
      my ($des_prefix, $des_suffix) = split(/\./, $des_conn);
      foreach my $port_name (keys %{ $href_data->{$des_mod}{ports} }) {
        if ($port_name =~ /^\Q${des_prefix}${glb_int_port_sep}/ &&
            $port_name =~ /\Q${glb_int_port_sep}${des_suffix}$/) {
          $port_name =~ s/^${des_prefix}${glb_int_port_sep}//;
          $port_name =~ s/${glb_int_port_sep}${des_suffix}//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
    else {
      foreach my $port_name (keys %{ $href_data->{$des_mod}{ports} }) {
        if ($port_name =~ /^\Q${des_conn}${glb_int_port_sep}/) {
          $port_name =~ s/^${des_conn}${glb_int_port_sep}//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
  }

  foreach my $base_port (sort keys %all_ports) {
    &sanity_check($href_data, $src_mod, $des_mod, $src_conn, $des_conn, $conn_type, $base_port, $src_bit, $des_bit, $src_inst, $des_inst);
    if ($conn_type eq "port_int") {
      if (defined $src_bit) {
        push(@src_ports, "${src_conn}[${src_bit}]");
      }
      else {
        push(@src_ports, $src_conn);
      }
      if (defined $des_bit) {
        push(@des_ports, "${base_port}[${des_bit}]");
      }
      else {
        push(@des_ports, $base_port);
      }
    }
    elsif ($conn_type eq "int_port") {
      if (defined $src_bit) {
        push(@src_ports, "${base_port}[${src_bit}]");
      }
      else {
        push(@src_ports, $base_port);
      }
      if (defined $des_bit) {
        push(@des_ports, "${des_conn}[${des_bit}]");
      }
      else {
        push(@des_ports, $des_conn);
      }
    }
  }

  return (\@src_ports, \@des_ports);
}

sub find_interface_ports_literal {
  my ($href_data, $src_mod, $src_int, $literal, $src_inst, $href_except) = @_;
  my @src_ports = ();
  my @des_ports = ();
  my $src_bit;
  my $des_bit;

  if ($src_int =~ /(\S+?)\[(\d+)\]/) {
    $src_int = $1;
    $src_bit = $2;
  }

  my %all_ports = ();
  my %skipped   = ();
  foreach my $port_name (keys %{ $href_data->{$src_mod}{ports} }) {
    if ($src_int =~ /\./) {
      # Support for asymmetric suffix
      my ($src_prefix, $src_suffix) = split(/\./, $src_int);
      foreach my $port_name (keys %{ $href_data->{$src_mod}{ports} }) {
        if ($port_name =~ /^\Q${src_prefix}${glb_int_port_sep}/ &&
            $port_name =~ /\Q${glb_int_port_sep}${src_suffix}$/) {
          $port_name =~ s/^${src_prefix}${glb_int_port_sep}//;
          $port_name =~ s/${glb_int_port_sep}${src_suffix}$//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
    else {
      if ($port_name =~ /^\Q${src_int}${glb_int_port_sep}/) {
        $port_name =~ s/^${src_int}${glb_int_port_sep}//;
        next if (defined $href_except->{$port_name});
        $all_ports{$port_name} = 1;
      }
    }
  }

  foreach my $base_port (sort keys %all_ports) {
    my $is_sane = &sanity_check_literal($href_data, $src_mod, $src_int, $literal, "interface", $base_port, $src_bit, $src_inst);
    if (!$is_sane) {
      if (defined $src_bit) {
        $skipped{"${base_port}[${src_bit}]"} = 1;
      }
      else {
        $skipped{$base_port} = 1;
      }
      next;
    }

    if (defined $src_bit) {
      push(@src_ports, "${base_port}[${src_bit}]");
    }
    else {
      push(@src_ports, $base_port);
    }
    push(@des_ports, $literal);
  }

  #return @ret_ports;
  return (\@src_ports, \@des_ports, \%skipped);
}

sub find_interface_ports {
  my ($href_data, $src_mod, $des_mod, $src_int, $des_int, $src_inst, $des_inst, $href_except) = @_;
  #my @ret_ports = ();
  my @src_ports = ();
  my @des_ports = ();
  my $src_bit;
  my $des_bit;

  if ($src_int =~ /(\S+?)\[(\d+)\]/) {
    $src_int = $1;
    $src_bit = $2;
  }
  if ($des_int =~ /(\S+?)\[(\d+)\]/) {
    $des_int = $1;
    $des_bit = $2;
  }

  my %all_ports = ();
  if ($src_int ne "*") {
    if ($src_int =~ /\./) {
      # Support for asymmetric suffix
      my ($src_prefix, $src_suffix) = split(/\./, $src_int);
      foreach my $port_name (keys %{ $href_data->{$src_mod}{ports} }) {
        if ($port_name =~ /^\Q${src_prefix}${glb_int_port_sep}/ &&
            $port_name =~ /\Q${glb_int_port_sep}${src_suffix}$/) {
          $port_name =~ s/^${src_prefix}${glb_int_port_sep}//;
          $port_name =~ s/${glb_int_port_sep}${src_suffix}$//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
    else {
      foreach my $port_name (keys %{ $href_data->{$src_mod}{ports} }) {
        if ($port_name =~ /^\Q${src_int}${glb_int_port_sep}/) {
          $port_name =~ s/^${src_int}${glb_int_port_sep}//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
  }
  if ($des_int ne "*") {
    if ($des_int =~ /\./) {
      # Support for asymmetric suffix
      my ($des_prefix, $des_suffix) = split(/\./, $des_int);
      foreach my $port_name (keys %{ $href_data->{$des_mod}{ports} }) {
        if ($port_name =~ /^\Q${des_prefix}${glb_int_port_sep}/ &&
            $port_name =~ /\Q${glb_int_port_sep}${des_suffix}$/) {
          $port_name =~ s/^${des_prefix}${glb_int_port_sep}//;
          $port_name =~ s/${glb_int_port_sep}${des_suffix}$//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
    else {
      foreach my $port_name (keys %{ $href_data->{$des_mod}{ports} }) {
        if ($port_name =~ /^\Q${des_int}${glb_int_port_sep}/) {
          $port_name =~ s/^${des_int}${glb_int_port_sep}//;
          next if (defined $href_except->{$port_name});
          $all_ports{$port_name} = 1;
        }
      }
    }
  }

  foreach my $base_port (sort keys %all_ports) {
    &sanity_check($href_data, $src_mod, $des_mod, $src_int, $des_int, "interface", $base_port, $src_bit, $des_bit, $src_inst, $des_inst);
    #push(@ret_ports, $base_port);
    if (defined $src_bit) {
      push(@src_ports, "${base_port}[${src_bit}]");
    }
    else {
      push(@src_ports, $base_port);
    }
    if (defined $des_bit) {
      push(@des_ports, "${base_port}[${des_bit}]");
    }
    else {
      push(@des_ports, $base_port);
    }
  }

  #return @ret_ports;
  return (\@src_ports, \@des_ports);
}

sub parse_config_file {
  my ($href_config, $href_ports, $href_inst_params, $aref_imports, $aref_unconn_top_ports, $href_ifdefs, $href_data, $aref_dup, $config_file) = @_;

  my %all_modules = ();
  my %insts = ();
  # %insts =
  #   $module =
  #     list = [] # ordered list of insts
  #     insts =
  #       $inst = 1
  #
  my $fh_in = &Hydra::Util::File::open_file_for_read($config_file);
  my $full_line = "";
  my $in_module_param = 0;
  my $module_param_paren_count = 0;
  my $define_name;
  my $ndefine_name;
  my $define_stmt;
  my $line_num = 0;
  while (my $line = <$fh_in>) {
    $line_num++;
    next if ($line =~ /^\s*\#/);
    next if ($line =~ /^\s*\/\//);

    $full_line .= $line;
    if ($line =~ /\\\s*$/) {
      $full_line =~ s/\\\s*$/ /;
      next;
    }

    $line = $full_line;
    $full_line = "";

    if ($line =~ /^\s*(import.*)\s*$/) {
      push(@$aref_imports, $1);
    }
    elsif ($line =~ /ifdef|ifndef/) {
      chomp($line);
      $define_stmt = $line;
      $line =~ s/^\s*//;
      $line =~ s/\s*$//;
      my @ifdefs = ();
      my @tokens = split(/\s+/, $line);
      while (scalar(@tokens) > 0) {
        my $def  = shift @tokens;
        my $name = shift @tokens;
        if ($def !~ /ifdef|ifndef/) {
          &add_error("Incorrect ifdef syntax: $line");
        }

        push(@ifdefs, "$def $name");
        $define_name .= uc($def) . "_${name}__";
      }
      
      $define_name =~ s/__$//;
      $href_ifdefs->{$define_name} = \@ifdefs;
    }
    elsif ($line =~ /else/) {
      if (defined $define_name) {
        $ndefine_name = $define_name;
        $define_name = undef;
      }
      else {
        chomp($line);
        &add_error("Else found with no ifdef on line ${line_num}: $line");
      }
    }
    elsif ($line =~ /endif/) {
      if (defined $define_name || defined $ndefine_name) {
        $define_name  = undef;
        $ndefine_name = undef;
      }
      else {
        chomp($line);
        &add_error("Endif found with no ifdef on line ${line_num}: $line");
      }
    }
    elsif ($line =~ /^\s*var\s+(.*)/) {
      # Top level wires
      my $top_name = &Hydra::Util::Option::get_opt_value_scalar("-top_name", "relaxed", "soc_top");
      my $stmt = $1;
      my $msb;
      my $lsb;
      my $width = 1;
      my $wire;
      my $type = "none";
      my $bus_type = "none";

      # Add top level as an "inst"
      $insts{$top_name}{insts}{$top_name} = 1;
      $insts{$top_name}{list} = [$top_name];
      $all_modules{$top_name}{$top_name} = 1;
      
      # Search for bus first and remove it
      if ($stmt =~ /(\[\s*([^\[\]\:]+)\s*\:\s*([^\[\]\:]+)\s*\])/) {
        my $bus_stmt = $1;
        my $raw_msb  = $2;
        my $raw_lsb  = $3;
        $msb = &evaluate_bit($href_data, $top_name, $raw_msb);
        $lsb = &evaluate_bit($href_data, $top_name, $raw_lsb);
        $width = abs($msb-$lsb)+1;
        $stmt =~ s/\Q${bus_stmt}\E/ HYDRA_BUS /;
      }
      elsif ($stmt =~ /(\[\s*([^\[\]\:]+)\s*\])/) {
        my $bus_stmt  = $1;
        my $raw_width = $2;
        $width = &evaluate_bit($href_data, $top_name, $raw_width);
        $msb   = $width - 1;
        $lsb   = 0;
        $stmt =~ s/\Q${bus_stmt}\E/ HYDRA_BUS /;
      }

      $stmt =~ s/^\s+//;
      $stmt =~ s/\s+$//;

      my @tokens = split(/\s+/, $stmt);

      if ($tokens[$#tokens] eq "HYDRA_BUS") {
        # Bus statement is the last token; this is a unpacked bus type
        $bus_type = "unpacked";
        pop(@tokens);
      }
      elsif ($width > 1) {
        # Bus statement is not the last token and there is a bus; this is a packed bus type
        $bus_type = "packed";
      }

      foreach my $i (0..$#tokens) {
        my $val = $tokens[$i];
        next if ($val eq "HYDRA_BUS");

        if ($i == $#tokens) {
          $wire = $val;
        }
        else {
          $type = $val;
        }
      }

      # Record the wire as a "port" under the top "module"
      # Direction is "undirected" until a connection is made
      # Then change the direction to reflect the connection
      $href_data->{$top_name}{ports}{$wire}{default}{dir}      = "undirected";
      $href_data->{$top_name}{ports}{$wire}{default}{width}    = $width;
      $href_data->{$top_name}{ports}{$wire}{default}{type}     = $type;
      $href_data->{$top_name}{ports}{$wire}{default}{bus_type} = $bus_type;
      if (defined $msb && defined $lsb) {
        $href_data->{$top_name}{ports}{$wire}{default}{msb} = $msb;
        $href_data->{$top_name}{ports}{$wire}{default}{lsb} = $lsb;
      }
    }
    elsif ($line =~ /^\s*((input|output|inout).*)\s*$/) {
      # Unconnected top level ports
      push(@$aref_unconn_top_ports, $1);
    }
    elsif ($line =~ /^\s*port\s+(\S+)\s+(.*)\s*$/) {
      my $top_port = $1;
      #my $inst_port = $2;
      my $port_string = $2;

      # Check for ifdef
      # my $ifdef;
      # my $ifndef;
      # if ($port_string =~ /(\s*ifdef\s+(\S+)\s*)/) {
      #   my $ifdef_stmt = $1;
      #   $ifdef = $2;
      #   $port_string =~ s/\Q${ifdef_stmt}\E//;
      # }
      # if ($port_string =~ /(\s*ifndef\s+(\S+)\s*)/) {
      #   my $ifndef_stmt = $1;
      #   $ifndef = $2;
      #   $port_string =~ s/\Q${ifndef_stmt}\E//;
      # }
      # if (defined $ifdef && defined $ifndef) {
      #   &add_error("Both ifdef and ifndef not allowed: $line");
      # }
      
      foreach my $inst_port (split(/\s+/, $port_string)) {
        next if ($inst_port =~ /^\s*$/);

        if ($inst_port =~ /\'/) {
          # Connection is to a literal

          # Check that the literal is sized
          if ($inst_port !~ /\d+\'/) {
            &add_error("Literal must be sized: $line");
          }
          
          if (!defined $href_ports->{$top_port}) {
            $href_ports->{$top_port} = [];
          }

          # Check for duplicate entry
          foreach my $href_conn (@{ $href_ports->{$top_port} }) {
            if ($href_conn->{conn} eq $inst_port) {
              chomp($line);
              &add_warn("Duplicate port statement found: $line");
              last;
            }
          }

          push(@{ $href_ports->{$top_port} }, {conn => $inst_port, ifdef => $define_name, ifndef => $ndefine_name});
        }
        else {
          my ($inst, $port) = split(/\//, $inst_port);

          # Sanity check inst
          my $inst_module;
          foreach my $module (keys %insts) {
            if (defined $insts{$module}{insts}{$inst}) {
              $inst_module = $module
            }
          }
          if (!defined $inst_module) {
            &add_error("Instance name not found on config line: $line");
            next;
          }

          # Check for instance ifdef
          my $ifdef  = $define_name;
          my $ifndef = $ndefine_name;
          if (!defined $ifdef && defined $href_config->{$inst_module}{ifdef}) {
            $ifdef = $href_config->{$inst_module}{ifdef};
          }
          if (!defined $ifndef && defined $href_config->{$inst_module}{ifndef}) {
            $ifndef = $href_config->{$inst_module}{ifndef};
          }
          if (defined $ifdef && defined $ifndef) {
            &add_error("Both ifdef and ifndef not allowed: $line");
          }

          if (!defined $href_ports->{$top_port}) {
            $href_ports->{$top_port} = [];
          }

          # Check for duplicate entry
          foreach my $href_conn (@{ $href_ports->{$top_port} }) {
            if ($href_conn->{conn} eq $inst_port) {
              chomp($line);
              &add_warn("Duplicate port statement found: $line");
              last;
            }
          }

          push(@{ $href_ports->{$top_port} }, {conn => $inst_port, ifdef => $ifdef, ifndef => $ifndef});
        }
      }
    }
    elsif ($line =~ /^\s*([^\s\:]+)\s*\:\s*(.*?)\s*$/) {
      my $module = $1;
      my @insts = split(/\s*\,\s*/, $2);
      $insts{$module}{list} = \@insts;
      foreach my $inst_name (@insts) {
        # Check for ifdef
        # my $ifdef;
        # my $ifndef;
        # if ($inst_name =~ /(\s*ifdef\s+(\S+)\s*)/) {
        #   my $ifdef_stmt = $1;
        #   $ifdef = $2;
        #   $inst_name =~ s/\Q${ifdef_stmt}\E//;
        # }
        # if ($inst_name =~ /(\s*ifndef\s+(\S+)\s*)/) {
        #   my $ifndef_stmt = $1;
        #   $ifndef = $2;
        #   $inst_name =~ s/\Q${ifndef_stmt}\E//;
        # }
        # if (defined $ifdef && defined $ifndef) {
        #   &add_error("Both ifdef and ifndef not allowed: $line");
        # }

        # Look for parameters
        if ($inst_name =~ /(\(.*\))/) {
          my $full_param_stmt = $1;
          $inst_name =~ s/\Q${full_param_stmt}\E//;
          $full_param_stmt =~ s/^\(//;
          $full_param_stmt =~ s/\)$//;

          foreach my $param_stmt (split(/\s*\;\s*/, $full_param_stmt)) {
            my ($param_name, $param_val) = split(/\s*\=\s*/, $param_stmt);
            
            # Use an ID string if instance is ifdef wrapped for case where
            #   instance is duplicated with different params
            my $inst_def_id = "none";
            if (defined $define_name) {
              $inst_def_id = "define:$define_name";
            }
            if (defined $ndefine_name) {
              $inst_def_id = "ndefine:$ndefine_name";
            }
            $href_inst_params->{$module}{$inst_name}{args}{$inst_def_id}{$param_name} = $param_val;
          }
        }

        $insts{$module}{insts}{$inst_name} = 1;
        $all_modules{$module}{$inst_name} = 1;

        # Check for duplicate instance
        if (defined $href_config->{$inst_name}) {
          chomp($line);
          &add_warn("Duplicate instance statement found: $line");

          # HACK: For printing multiple instances with the same name
          #   Save the first instance and overwrite with the second
          my %inst = ($inst_name => \%{ $href_config->{$inst_name} });
          my $dup_module = $inst{$inst_name}{mod};
          push(@$aref_dup, \%inst);
          delete $href_config->{$inst_name};
          
          # Only delete module of duplicate inst if it is different from this inst
          if ($module ne $dup_module) {
            delete $all_modules{$dup_module}{$inst_name};
            if (scalar(keys %{ $all_modules{$dup_module} }) <= 0) {
              delete $all_modules{$dup_module};
            }
            delete $insts{$dup_module}{insts}{$inst_name};
            if (scalar(keys %{ $insts{$dup_module}{insts} }) <= 0) {
              delete $insts{$dup_module};
            }
          }
        }

        $href_config->{$inst_name}{mod}    = $module;
        $href_config->{$inst_name}{ifdef}  = $define_name;
        $href_config->{$inst_name}{ifndef} = $ndefine_name;
      }
    }
    elsif ($line =~ /(\S+?)(\.|\/)(\S+)\s+((\d+)?\'\S+)/) {
      # Connection is a literal
      my $src_ref  = $1;
      my $src_type = $2;
      my $src_conn = $3;
      my $literal  = $4;

      # Check that the literal is unsized
      if ($literal =~ /\d+\'/) {
        &add_error("Literal must be unsized: $line");
      }

      # Except feature
      my %except = ();
      if ($line =~ /except\s+(.*?)\s*$/) {
        foreach my $except_name (split(/\s+/, $1)) {
          $except{$except_name} = 1;
        }
      }

      my @src_insts = ();
      #push(@src_insts, $src_ref);

      # Support bracket expansion
      my @src_expan = ();
      if ($src_ref =~ /(\[([^\s\[\]]+)\])/) {
        my $num_expan = 0;
        while ($src_ref =~ /(\[([^\s\[\]]+)\])/g) {
          $num_expan++;
        }
        if ($num_expan > 1) {
          &add_error("More than one bracket expansion not allowed on config line: $line");
          next;
        }

        my $directive = $1;
        my @tokens = split(/\,/, $2);
        push(@tokens, $directive);
        @src_expan = @tokens;
      }
      
      if (scalar(@src_expan) > 0) {
        my $src_directive = pop(@src_expan);
        foreach my $index (0..$#src_expan) {
          my $src_token = $src_expan[$index];
          my $src_ref_expanded = $src_ref;
          $src_ref_expanded =~ s/\Q$src_directive\E/$src_token/;
          push(@src_insts, $src_ref_expanded);
        }
      }
      else {
        push(@src_insts, $src_ref);
      }

      foreach my $index (0..$#src_insts) {
        my $src_inst = $src_insts[$index];
        my $conn_type;
        if ($src_type eq ".") {
          $conn_type = "ints";
        }
        elsif ($src_type eq "/") {
          $conn_type = "ports";
        }
        my $src_mod;
        foreach my $module (keys %insts) {
          if (defined $insts{$module}{insts}{$src_inst}) {
            $src_mod = $module;
          }
        }

        if (!defined $src_mod) {
          &add_error("Instance name not found on config line: $line");
          next;
        }

        # Check that * is not used
        if ($src_conn eq "*") {
          &add_error("Literal connections may not use \"*\": $line");
          next;
        }

        # Check for ifdef
        # my $ifdef;
        # my $ifndef;
        # if ($line =~ /ifdef\s+(\S+)\s*$/) {
        #   $ifdef = $1;
        # }
        # elsif (defined $href_config->{$src_inst}{ifdef}) {
        #   $ifdef = $href_config->{$src_inst}{ifdef};
        # }
        # if ($line =~ /ifndef\s+(\S+)\s*$/) {
        #   $ifndef = $1;
        # }
        # elsif (defined $href_config->{$src_inst}{ifndef}) {
        #   $ifndef = $href_config->{$src_inst}{ifndef};
        # }
        # if (defined $ifdef && defined $ifndef) {
        #   &add_error("Both ifdef and ifndef not allowed: $line");
        # }

        my $ifdef  = $define_name;
        my $ifndef = $ndefine_name;
        # Inherit ifdef from instance definition, but not if the instance was part of a set of
        #   multiple instances with the same name
        my $mult_inst = 0;
        foreach my $href_inst (@$aref_dup) {
          if (defined $src_inst && $src_inst eq (keys %$href_inst)[0]) {
            $mult_inst = 1;
          }
        }
        if (!$mult_inst) {
          if (!defined $ifdef && defined $href_config->{$src_inst}{ifdef}) {
            $ifdef = $href_config->{$src_inst}{ifdef};
          }
          if (!defined $ifndef && defined $href_config->{$src_inst}{ifndef}) {
            $ifndef = $href_config->{$src_inst}{ifndef};
          }
          if (defined $ifdef && defined $ifndef) {
            &add_error("Both ifdef and ifndef not allowed: $line");
          }
        }

        $href_config->{$src_inst}{mod} = $src_mod;
        #$href_config->{$src_inst}{$conn_type}{$src_conn}{conn} = $literal;
        my %config = (conn => $literal, ifdef => $ifdef, ifndef => $ifndef, except => \%except);

        # Check for duplicate connection
        foreach my $href_conn (@{ $href_config->{$src_inst}{$conn_type}{$src_conn} }) {
          if ($href_conn->{conn} eq $literal) {
            chomp($line);
            &add_warn("Duplicate connection statement found: $line");
            last;
          }
        }

        push(@{ $href_config->{$src_inst}{$conn_type}{$src_conn} }, \%config);
      }
    }
    elsif ($line =~ /(\S+?)(\.|\/)(\S+)\s+(\S+?)(\.|\/)(\S+)/) {
      my $src_ref   = $1;
      my $src_type  = $2;
      my $src_conn  = $3;
      my $des_ref   = $4;
      my $des_type  = $5;
      my $des_conn  = $6;

      my @src_insts = ();
      my @des_insts = ();
      
      # # Determine whether source is a module or instance reference
      # if (defined $all_modules{$src_ref}) {
      #   # Module reference; resolve to list of instances
      #   @src_insts = @{ $insts{$src_ref}{list} };
      # }
      # else {
      #   # Instance reference; add to list of instances
      #   push(@src_insts, $src_ref);
      # }

      # # Determine whether dest is a module or instance reference
      # if (defined $all_modules{$des_ref}) {
      #   # Module reference; resolve to list of instances
      #   @des_insts = @{ $insts{$des_ref}{list} };
      # }
      # else {
      #   # Instance reference; add to list of instances
      #   push(@des_insts, $des_ref);
      # }

      # Support bracket expansion
      my @src_expan = ();
      my @des_expan = ();
      if ($src_ref =~ /(\[([^\s\[\]]+)\])/) {
        my $num_expan = 0;
        while ($src_ref =~ /(\[([^\s\[\]]+)\])/g) {
          $num_expan++;
        }
        if ($num_expan > 1) {
          &add_error("More than one bracket expansion not allowed on config line: $line");
          next;
        }

        my $directive = $1;
        my @tokens = split(/\,/, $2);
        push(@tokens, $directive);
        @src_expan = @tokens;
      }
      if ($des_ref =~ /(\[([^\s\[\]]+)\])/) {
        my $num_expan = 0;
        while ($des_ref =~ /(\[([^\s\[\]]+)\])/g) {
          $num_expan++;
        }
        if ($num_expan > 1) {
          &add_error("More than one bracket expansion not allowed on config line: $line");
          next;
        }

        my $directive = $1;
        my @tokens = split(/\,/, $2);
        push(@tokens, $directive);
        @des_expan = @tokens;
      }

      if (scalar(@src_expan) > 0 && scalar(@des_expan) > 0) {
        if (scalar(@src_expan) != scalar(@des_expan)) {
          &add_error("Unmatched number of source to dest expansions on config line: $line");
          next;
        }

        my $src_directive = pop(@src_expan);
        my $des_directive = pop(@des_expan);
        foreach my $index (0..$#src_expan) {
          my $src_token = $src_expan[$index];
          my $des_token = $des_expan[$index];
          my $src_ref_expanded = $src_ref;
          my $des_ref_expanded = $des_ref;
          $src_ref_expanded =~ s/\Q$src_directive\E/$src_token/;
          $des_ref_expanded =~ s/\Q$des_directive\E/$des_token/;
          push(@src_insts, $src_ref_expanded);
          push(@des_insts, $des_ref_expanded);
        }
      }
      elsif (scalar(@src_expan) > 0) {
        my $directive = pop(@src_expan);
        foreach my $token (@src_expan) {
          my $src_ref_expanded = $src_ref;
          $src_ref_expanded =~ s/\Q$directive\E/$token/;
          push(@src_insts, $src_ref_expanded);
          push(@des_insts, $des_ref);
        }
      }
      elsif (scalar(@des_expan) > 0) {
        my $directive = pop(@des_expan);
        foreach my $token (@des_expan) {
          my $des_ref_expanded = $des_ref;
          $des_ref_expanded =~ s/\Q$directive\E/$token/;
          push(@des_insts, $des_ref_expanded);
          push(@src_insts, $src_ref);
        }
      }
      else {
        push(@src_insts, $src_ref);
        push(@des_insts, $des_ref);
      }

      # Reference is always an instance
      #push(@src_insts, $src_ref);
      #push(@des_insts, $des_ref);

      # Sanity check number of instances
      if (scalar(@src_insts) != scalar(@des_insts)) {
        chomp($line);
        &add_error("Number of instances do not match on config line: $line");
        next;
      }

      # if ($src_ref =~ /\[\S+\]/ || $des_ref =~ /\[\S+\]/) {
      #   foreach my $index (0..$#src_insts) {
      #     print "DEBUG src=$src_insts[$index] des=$des_insts[$index] $src_ref $des_ref\n";
      #   }
      # }

      # Sanity check connection type
      # if ($src_type ne $des_type) {
      #   chomp($line);
      #   &add_error("Connection type (interface/port) does not match on config line: $line");
      #   next;
      # }

      # Except feature
      my %except = ();
      if ($line =~ /except\s+(.*?)\s*$/) {
        foreach my $except_name (split(/\s+/, $1)) {
          $except{$except_name} = 1;
        }
      }

      my $conn_type;
      if ($src_type eq $des_type) {
        if ($src_type eq ".") {
          $conn_type = "ints";
        }
        elsif ($src_type eq "/") {
          $conn_type = "ports";
        }
      }
      else {
        if ($src_type eq "." && $des_type eq "/") {
          $conn_type = "int_port";
        }
        elsif ($src_type eq "/" && $des_type eq ".") {
          $conn_type = "port_int";
        }
      }
      foreach my $index (0..$#src_insts) {
        my $src_inst = $src_insts[$index];
        my $des_inst = $des_insts[$index];
        # my $conn_type;
        # if ($src_type eq ".") {
        #   $conn_type = "ints";
        # }
        # elsif ($src_type eq "/") {
        #   $conn_type = "ports";
        # }
        my $src_mod;
        my $des_mod;
        foreach my $module (keys %insts) {
          if (defined $insts{$module}{insts}{$src_inst}) {
            $src_mod = $module;
          }
          if (defined $insts{$module}{insts}{$des_inst}) {
            $des_mod = $module;
          }
        }

        # Sanity check instance name
        if (!defined $src_mod || !defined $des_mod) {
          &add_error("Instance name not found on config line: $line");
          next;
        }

        # Check that port type has no *
        if ($conn_type eq "ports" && ($src_conn eq "*" || $des_conn eq "*")) {
          &add_error("Direct port connections may not use \"*\": $line");
          next;
        }

        # Check that mixed type has no *
        if (($conn_type eq "int_port" || $conn_type eq "port_int") &&
            ($src_conn eq "*" || $des_conn eq "*")) {
          &add_error("Mixed port-to-interface connections may not use \"*\": $line");
        }

        # Check that both interfaces are not *
        if ($conn_type eq "ints" && $src_conn eq "*" && $des_conn eq "*") {
          &add_error("Both source and dest interfaces may not be \"*\": $line");
          next;
        }

        # Check for ifdef
        # my $ifdef;
        # my $ifndef;
        # if ($line =~ /ifdef\s+(\S+)\s*$/) {
        #   $ifdef = $1;
        # }
        # elsif (defined $href_config->{$src_inst}{ifdef} || defined $href_config->{$des_inst}{ifdef}) {
        #   if (defined $href_config->{$src_inst}{ifdef} && defined $href_config->{$des_inst}{ifdef} &&
        #       $href_config->{$src_inst}{ifdef} ne $href_config->{$des_inst}{ifdef}) {
        #     &add_error("Source and dest instances have differing ifdef: $line");
        #   }
        #   elsif (defined $href_config->{$src_inst}{ifdef}) {
        #     $ifdef = $href_config->{$src_inst}{ifdef};
        #   }
        #   elsif (defined $href_config->{$des_inst}{ifdef}) {
        #     $ifdef = $href_config->{$des_inst}{ifdef};
        #   }
        # }
        # if ($line =~ /ifndef\s+(\S+)\s*$/) {
        #   $ifndef = $1;
        # }
        # elsif (defined $href_config->{$src_inst}{ifndef} || defined $href_config->{$des_inst}{ifndef}) {
        #   if (defined $href_config->{$src_inst}{ifndef} && defined $href_config->{$des_inst}{ifndef} &&
        #       $href_config->{$src_inst}{ifndef} ne $href_config->{$des_inst}{ifndef}) {
        #     &add_error("Source and dest instances have differing ifndef: $line");
        #   }
        #   elsif (defined $href_config->{$src_inst}{ifndef}) {
        #     $ifndef = $href_config->{$src_inst}{ifndef};
        #   }
        #   elsif (defined $href_config->{$des_inst}{ifndef}) {
        #     $ifndef = $href_config->{$des_inst}{ifndef};
        #   }
        # }
        # if (defined $ifdef && defined $ifndef) {
        #   &add_error("Both ifdef and ifndef not allowed: $line");
        # }

        my $ifdef  = $define_name;
        my $ifndef = $ndefine_name;
        # Inherit ifdefs from instance definition, but not if the instance was part of a set of
        #   multiple instances with the same name
        my $mult_inst = 0;
        foreach my $href_inst (@$aref_dup) {
          if ((defined $src_inst && $src_inst eq (keys %$href_inst)[0]) ||
              (defined $des_inst && $des_inst eq (keys %$href_inst)[0])) {
            $mult_inst = 1;
          }
        }
        if (!$mult_inst) {
          if (!defined $ifdef) {
            if (defined $href_config->{$src_inst}{ifdef} || defined $href_config->{$des_inst}{ifdef}) {
              if (defined $href_config->{$src_inst}{ifdef} && defined $href_config->{$des_inst}{ifdef} &&
                  $href_config->{$src_inst}{ifdef} ne $href_config->{$des_inst}{ifdef}) {
                &add_error("Source and dest instances have differing ifdef: $line");
              }
              elsif (defined $href_config->{$src_inst}{ifdef}) {
                $ifdef = $href_config->{$src_inst}{ifdef};
              }
              elsif (defined $href_config->{$des_inst}{ifdef}) {
                $ifdef = $href_config->{$des_inst}{ifdef};
              }
            }
          }
          if (!defined $ifndef) {
            if (defined $href_config->{$src_inst}{ifndef} || defined $href_config->{$des_inst}{ifndef}) {
              if (defined $href_config->{$src_inst}{ifndef} && defined $href_config->{$des_inst}{ifndef} &&
                  $href_config->{$src_inst}{ifndef} ne $href_config->{$des_inst}{ifndef}) {
                &add_error("Source and dest instances have differing ifndef: $line");
              }
              elsif (defined $href_config->{$src_inst}{ifndef}) {
                $ifndef = $href_config->{$src_inst}{ifndef};
              }
              elsif (defined $href_config->{$des_inst}{ifndef}) {
                $ifndef = $href_config->{$des_inst}{ifndef};
              }
            }
          }
        }

        $href_config->{$src_inst}{mod} = $src_mod;
        #$href_config->{$src_inst}{$conn_type}{$src_conn}{inst} = $des_inst;
        #$href_config->{$src_inst}{$conn_type}{$src_conn}{mod}  = $des_mod;
        #$href_config->{$src_inst}{$conn_type}{$src_conn}{conn} = $des_conn;
        my %conn = (inst => $des_inst, mod => $des_mod, conn => $des_conn, ifdef => $ifdef, ifndef => $ifndef, except => \%except);

        # Check for duplicate connection
        foreach my $href_conn (@{ $href_config->{$src_inst}{$conn_type}{$src_conn} }) {
          if ($href_conn->{conn} eq $des_conn && $href_conn->{inst} eq $des_inst && $href_conn->{mod} eq $des_mod) {
            chomp($line);
            &add_warn("Duplicate connection statement found: $line");
            last;
          }
        }

        # Check for duplicate connection when src and des are swapped
        if (defined $href_config->{$des_inst} &&
            defined $href_config->{$des_inst}{$conn_type} &&
            defined $href_config->{$des_inst}{$conn_type}{$des_conn}) {
          foreach my $href_conn (@{ $href_config->{$des_inst}{$conn_type}{$des_conn} }) {
            if ($href_conn->{conn} eq $src_conn && $href_conn->{inst} eq $src_inst && $href_conn->{mod} eq $src_mod) {
              chomp($line);
              &add_warn("Duplicate connection statement found: $line");
              last;
            }
          }
        }

        push(@{ $href_config->{$src_inst}{$conn_type}{$src_conn} }, \%conn);
      }
    }
  }

  if (defined $define_name || defined $ndefine_name) {
    &add_error("Missing endif for ifdef statement: $define_stmt");
  }

  &Hydra::Util::File::close_file($fh_in);

  return %all_modules;
}

sub parse_verilog_file {
  my ($href_data, $href_all_modules, $href_inst_params, $aref_incdirs, $vlg_file, $mode) = @_;
  if (!defined $mode) {
    $mode = "normal";
  }

  my $fh_in = &Hydra::Util::File::open_file_for_read($vlg_file);
  my $module;
  my $in_ifdef = 0;
  my $in_param = 0;
  my $in_param_paren_count = 0;
  while (my $line = <$fh_in>) {
    # Remove comments
    $line =~ s/\/\/.*$//;

    if ($mode eq "normal" && $line =~ /module\s+([^\s\(\)]+)/) {
      # Set module
      $module = $1;
      if (defined $href_all_modules->{$module} && !defined $href_data->{$module}) {
        &Hydra::Util::File::print_unbuffered("INFO: Reading module $module ($vlg_file)\n");
      }
      else {
        $module = undef;
      }
    }

    if (defined $module && $line =~ /(ifdef|ifndef)\s+(\S+)/ && 
        !defined $glb_disable_ifdef_skip_modules{$module}) {
      $in_ifdef = 1;
      my $ifdef_type   = $1;
      my $ifdef_target = $2;
      &Hydra::Util::File::print_unbuffered("WARN:   $ifdef_type $ifdef_target ignored while reading ports\n");
    }
    if (defined $module && $line =~ /endif/) {
      $in_ifdef = 0;
    }    
    next if ($in_ifdef);

    # Check whether we are currently in a module parameter statement
    if (defined $module && $in_param) {
      for ($line =~ /\(/g) {
        $in_param_paren_count++;
      }
      for ($line =~ /\)/g) {
        $in_param_paren_count--;
      }

      if ($in_param_paren_count <= 0) {
        $in_param = 0;
        $in_param_paren_count = 0;
      }
    }
    if (defined $module && !$in_param && $line =~ /\#\s*\(/) {
      $in_param = 1;
      $in_param_paren_count++;
    }

    if (defined $module && $line =~ /^\s*\,?(input|output|inout)\s+(.*)/) {
      my $dir = $1;
      #my $msb;
      #my $lsb;
      #my $width = 1;
      my %msb   = (default => undef);
      my %lsb   = (default => undef);
      my %width = (default => 1);
      my $port;
      my $type = "none";
      my $bus_type = "none";
      my $stmt = $2;
      $stmt =~ s/(\,|\;|\))\s*$//;

      # Initialize bits for all instances
      if (defined $href_inst_params->{$module}) {
        foreach my $inst_name (keys %{ $href_inst_params->{$module} }) {
          $msb{$inst_name}   = undef;
          $lsb{$inst_name}   = undef;
          $width{$inst_name} = 1;
        }
      }

      # Search for bus first and remove it
      if ($stmt =~ /(\[\s*([^\[\]\:]+)\s*\:\s*([^\[\]\:]+)\s*\])/) {
        my $bus_stmt = $1;
        my $raw_msb  = $2;
        my $raw_lsb  = $3;
        $msb{default}   = &evaluate_bit($href_data, $module, $raw_msb);
        $lsb{default}   = &evaluate_bit($href_data, $module, $raw_lsb);
        $width{default} = abs($msb{default}-$lsb{default})+1;
        $stmt =~ s/\Q${bus_stmt}\E/ HYDRA_BUS /;

        # Evaluate bits for each instance for param overriding
        if (defined $href_inst_params->{$module}) {
          foreach my $inst_name (keys %{ $href_inst_params->{$module} }) {
            $msb{$inst_name}   = &evaluate_bit($href_data, $module, $raw_msb, $href_inst_params->{$module}{$inst_name});
            $lsb{$inst_name}   = &evaluate_bit($href_data, $module, $raw_lsb, $href_inst_params->{$module}{$inst_name});
            $width{$inst_name} = abs($msb{$inst_name}-$lsb{$inst_name})+1;
          }
        }
      }
      elsif ($stmt =~ /(\[\s*([^\[\]\:]+)\s*\])/) {
        my $bus_stmt  = $1;
        my $raw_width = $2;
        $width{default} = &evaluate_bit($href_data, $module, $raw_width);
        $msb{default}   = $width{default} - 1;
        $lsb{default}   = 0;
        $stmt =~ s/\Q${bus_stmt}\E/ HYDRA_BUS /;

        # Evaluate bits for each instance for param overriding
        if (defined $href_inst_params->{$module}) {
          foreach my $inst_name (keys %{ $href_inst_params->{$module} }) {
            $width{$inst_name} = &evaluate_bit($href_data, $module, $raw_width, $href_inst_params->{$module}{$inst_name});
            $msb{$inst_name}   = $width{$inst_name} - 1;
            $lsb{$inst_name}   = 0;
          }
        }
      }

      $stmt =~ s/^\s+//;
      $stmt =~ s/\s+$//;

      my @tokens = split(/\s+/, $stmt);
      
      if ($tokens[$#tokens] eq "HYDRA_BUS") {
        # Bus statement is the last token; this is a unpacked bus type
        $bus_type = "unpacked";
        pop(@tokens);
      }
      elsif ($width{default} > 1) {
        # Bus statement is not the last token and there is a bus; this is a packed bus type
        $bus_type = "packed";
      }

      foreach my $i (0..$#tokens) {
        my $val = $tokens[$i];
        next if ($val eq "HYDRA_BUS");

        if ($i == $#tokens) {
          # Remove trailing comma from port name
          $val =~ s/(\,|\;|\))$//;
          $port = $val;
        }
        else {
          $type = $val;
        }
      }

      # Record data for default
      $href_data->{$module}{ports}{$port}{default}{dir}      = $dir;
      $href_data->{$module}{ports}{$port}{default}{width}    = $width{default};
      $href_data->{$module}{ports}{$port}{default}{type}     = $type;
      $href_data->{$module}{ports}{$port}{default}{bus_type} = $bus_type;
      if (defined $msb{default} && defined $lsb{default}) {
        $href_data->{$module}{ports}{$port}{default}{msb} = $msb{default};
        $href_data->{$module}{ports}{$port}{default}{lsb} = $lsb{default};
      }

      # Record data for instances
      if (defined $href_inst_params->{$module}) {
        foreach my $inst_name (keys %{ $href_inst_params->{$module} }) {
          $href_data->{$module}{ports}{$port}{$inst_name}{dir}      = $dir;
          $href_data->{$module}{ports}{$port}{$inst_name}{width}    = $width{$inst_name};
          $href_data->{$module}{ports}{$port}{$inst_name}{type}     = $type;
          $href_data->{$module}{ports}{$port}{$inst_name}{bus_type} = $bus_type;
          if (defined $msb{$inst_name} && defined $lsb{$inst_name}) {
            $href_data->{$module}{ports}{$port}{$inst_name}{msb} = $msb{$inst_name};
            $href_data->{$module}{ports}{$port}{$inst_name}{lsb} = $lsb{$inst_name};
          }
        }
      }
    }
    elsif ($line =~ /(parameter|localparam)(\s+\S+)?(\s+\[[^\s\[\]]+\])?\s+(\S+)\s*=\s*(.+)/) {
      my $param_type = $2;
      my $param_name = $4;
      my $param_val  = $5;

      # Check parameter value for close parens that belongs to the module parameter statement.
      #   Parens pairs are counted; if an unexpected close parens occurs, then discard that parens
      #   and everything after it.
      my $open_parens_count = 0;
      my $valid_val = "";
      foreach my $token (split(//, $param_val)) {
        if ($token eq "(") {
          $open_parens_count++;
        }
        if ($token eq ")") {
          $open_parens_count--;
        }

        if ($open_parens_count < 0 || $token eq ";" || $token eq ",") {
          last;
        }
        else {
          $valid_val .= $token;
        }
      }
      $param_val = $valid_val;

      # Remove trailing comma (from parameter list) or semicolon (from single parameter)
      $param_val =~ s/\s*$//;
      # $param_val =~ s/\s*(\,|\;)\s*$//;

      # Add paren back in for clog
      # if ($param_val =~ /clog2\([^\s\(\)]+$/) {
      #   $param_val .= ")";
      # }

      my $param_module;
      if ($mode ne "normal") {
        $param_module = $mode;
      }
      elsif (defined $module) {
        $param_module = $module;
      }
      else {
        $param_module = "HYDRA_TOP";
      }

      if (defined $param_module) {
        my $evaluated = &evaluate_bit($href_data, $param_module, $param_val);
        # If this parameter is not a real data type, then truncate decimal
        if (defined $param_type && $param_type !~ /real/i && $evaluated =~ /^[0-9\.\-]+$/) {
          $evaluated =~ s/\..*//;
        }

        $href_data->{$param_module}{parameters}{$param_name} = $evaluated;
        &add_pattern($href_data->{$param_module}, $param_name, "parameter");

        # Evaluate bits for each instance for param overriding
        if (defined $href_inst_params->{$param_module}) {
          foreach my $inst_name (keys %{ $href_inst_params->{$param_module} }) {
            my $inst_evaluated = &evaluate_bit($href_data, $param_module, $param_val, $href_inst_params->{$param_module}{$inst_name});
            # If this parameter is not a real data type, then truncate decimal
            if (defined $param_type && $param_type !~ /real/i && $inst_evaluated =~ /^[0-9\.\-]+$/) {
              $inst_evaluated =~ s/\..*//;
            }

            $href_inst_params->{$param_module}{$inst_name}{parameters}{$param_name} = $inst_evaluated;
          }
        }

        # Store a module parameter to check against user specified parameters later
        if ($in_param) {
          if (defined $href_inst_params->{$param_module}) {
            foreach my $inst_name (keys %{ $href_inst_params->{$param_module} }) {
              $href_inst_params->{$param_module}{$inst_name}{whitelist}{$param_name} = 1;
            }
          }
        }
      }
    }
    elsif ($line =~ /\`define\s+(\S+)(\s+.+)?\s*$/) {
      my $def_name = $1;
      my $def_val  = $2;
      $def_val =~ s/^\s*// if (defined $def_val);
      #$def_val =~ s/(\,|\;|\))$//;

      my $def_module;
      if ($mode ne "normal") {
        $def_module = $mode;
      }
      elsif (defined $module) {
        $def_module = $module;
      }
      else {
        $def_module = "HYDRA_TOP";
      }

      if (defined $def_module) {
        if (defined $def_val) {
          $href_data->{$def_module}{defines}{$def_name} = &evaluate_bit($href_data, $def_module, $def_val);
          &add_pattern($href_data->{$def_module}, $def_name, "define");

          if (defined $href_inst_params->{$def_module}) {
            foreach my $inst_name (keys %{ $href_inst_params->{$def_module} }) {
              $href_inst_params->{$def_module}{$inst_name}{defines}{$def_name} = &evaluate_bit($href_data, $def_module, $def_val, $href_inst_params->{$def_module}{$inst_name});
            }
          }
        }
        else {
          $href_data->{$def_module}{defines}{$def_name} = "HYDRA_DEFINED";
          &add_pattern($href_data->{$def_module}, $def_name, "define");
        }
      }
    }
    elsif (defined $module && $line =~ /\`include\s+\"(\S+)\"/) {
      my $include_file = $1;

      # my $inc_module;
      # if ($mode ne "normal") {
      #   $inc_module = $mode;
      # }
      # elsif (defined $module) {
      #   $inc_module = $module;
      # }
      # else {
      #   $inc_module = "HYDRA_TOP";
      # }

      foreach my $incdir (@$aref_incdirs) {
        my $fullpath_include_file = "${incdir}/${include_file}";
        if (-f $fullpath_include_file) {
          &parse_verilog_file($href_data, $href_all_modules, $href_inst_params, $aref_incdirs, $fullpath_include_file, $module);
        }
      }
    }
    elsif ($line =~ /endmodule/) {
      $module = undef;
    }
  }
  &Hydra::Util::File::close_file($fh_in);

  return;
}

sub evaluate_bit {
  my ($href_data, $module, $bit, $href_inst) = @_;
  my $test_bit = $bit;

  $test_bit =~ s/\+|\-|\/|\*|\(|\)/ /g;
  my @tokens = split(/\s+/, $test_bit);
  #foreach my $token (@tokens) {
  while (scalar(@tokens) > 0) {
    my $token = shift @tokens;
    if ($token =~ /^\$clog2$/) {
      #my $value      = shift @tokens;

      # Get value that is being clog2'ed
      my $parens_count = 1;
      my $value = "";
      my $first_value = shift @tokens;
      $bit =~ /(\Q$first_value\E.*)/;
      foreach my $char (split(//, $1)) {
        if ($char eq "(") {
          $parens_count++;
        }
        if ($char eq ")") {
          $parens_count--;
        }

        if ($parens_count == 0) {
          last;
        }
        else {
          $value .= $char;
        }
      }
      if ($parens_count != 0) {
        $value = "";
      }

      if ($value ne "") {
        my $test_value = $value;
        $test_value =~ s/\+|\-|\/|\*|\(|\)/ /g;
        my $num_tokens = scalar(split(/\s+/, $test_value));
        
        # Remove clog2 values from the future token array
        for (my $i = 0; $i < $num_tokens-1; $i++) {
          shift @tokens;
        }

        my $eval_value = &evaluate_bit($href_data, $module, $value, $href_inst);
        if ($eval_value eq "0") {
          # Hack to prevent clog2 from erroring out
          $eval_value = 1;
        }
        elsif ($eval_value =~ /\$bits/) {
          # Hack to prevent $clog2 of $bits from erroring out
          # This should be ok as long as the bit is not actually used
          $eval_value = 1;
        }
        my $converted = 1;
        if ($eval_value > 0) {
          $converted  = ceil(log($eval_value) / log(2));
        }
        $bit =~ s/\$clog2\s*\(\s*\Q$value\E\s*\)/$converted/g;
      }
    }
    elsif ($token =~ /^(\d+)?\'(h|o|d|b)(\S+)$/) {
      my $num_type = $2;
      my $value    = $3;
      my $converted;
      if ($num_type eq "d") {
        $converted = $value;
      }
      elsif ($num_type eq "h") {
        $converted = Math::BigInt->from_hex($value);
      }
      elsif ($num_type eq "o") {
        $converted = Math::BigInt->from_oct($value);
      }
      elsif ($num_type eq "b") {
        $converted = Math::BigInt->from_bin("0b" . $value);
      }
      
      if (defined $converted) {
        $bit =~ s/\Q$token\E/$converted/g;
      }
    }
    elsif ($token =~ /^\`(\S+)$/) {
      my $define_name = $1;
      if (defined $href_inst->{defines}{$define_name}) {
        $bit =~ s/\`${define_name}/$href_inst->{defines}{$define_name}/g;
      }
      if (defined $href_data->{$module}{defines}{$define_name}) {
        $bit =~ s/\`${define_name}/$href_data->{$module}{defines}{$define_name}/g;
      }
      if (defined $href_data->{HYDRA_TOP}{defines}{$define_name}) {
        $bit =~ s/\`${define_name}/$href_data->{HYDRA_TOP}{defines}{$define_name}/g;
      }
    }
    else {
      my $param_name = $token;
      # HACK
      # For bit evaluation, always use inst_def_id "none", or whatever inst_def_id there is
      #   if there is only one
      # Allowing changing bits would open up changing bit widths for ifdef-wrapped
      #   duplicate instances, which would change too much of the script at this point
      my $inst_def_id = "none";
      if (scalar(keys %{ $href_inst->{args} }) == 1) {
        $inst_def_id = (keys %{ $href_inst->{args} })[0];
      }
      
      if (defined $href_inst->{args}{$inst_def_id}{$param_name}) {
        $bit =~ s/${param_name}/$href_inst->{args}{$inst_def_id}{$param_name}/g;
      }
      if (defined $href_inst->{parameters}{$param_name}) {
        $bit =~ s/${param_name}/$href_inst->{parameters}{$param_name}/g;
      }
      if (defined $href_data->{$module}{parameters}{$param_name}) {
        $bit =~ s/${param_name}/$href_data->{$module}{parameters}{$param_name}/g;
      }
      if (defined $href_data->{HYDRA_TOP}{parameters}{$param_name}) {
        $bit =~ s/${param_name}/$href_data->{HYDRA_TOP}{parameters}{$param_name}/g;
      }
    }
  }
  
  if ($bit =~ /^[\d\+\-\/\*\s\(\)]+$/) {
    $bit = eval "$bit";
  }

  return $bit;
}

sub add_pattern {
  my ($href_module, $new_name, $type) = @_;
  return;
  my $key = "${type}_pattern";
  if (defined $href_module->{$key}) {
    $href_module->{$key} .= "|" . quotemeta($new_name);
  }
  else {
    $href_module->{$key} = quotemeta($new_name);
  }
}

sub set_bit_connected {
  my ($href_data, $module, $port, $inst, $bit) = @_;
  confess if (!defined $inst);
  $inst = "default" if (!defined $inst);

  if (&is_port_bus($href_data, $module, $port, $inst)) {
    if ($bit eq "") {
      # Set all bits if there is no bit string
      my $msb = &get_msb($href_data, $module, $port, $inst);
      my $lsb = &get_lsb($href_data, $module, $port, $inst);
      my $upper = $msb;
      my $lower = $lsb;
      if ($msb < $lsb) {
        $upper = $lsb;
        $lower = $msb;
      }
      
      foreach my $this_bit ($lower..$upper) {
        $href_data->{$module}{ports}{$port}{$inst}{connected}{"[${this_bit}]"} = 1;
      }
    }
    else {
      $href_data->{$module}{ports}{$port}{$inst}{connected}{$bit} = 1;
    }
  }
}

1;
