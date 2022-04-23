#------------------------------------------------------
# Module Name: ReportInterfaceTimingMargin
# Date:        Fri Jun 28 15:50:49 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Func::ReportInterfaceTimingMargin;

use strict;
use warnings;
use Carp;
use Exporter;

use Hydra::Report::PtTiming;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub report_interface_margin {
  my $rpt_dir        = &Hydra::Util::Option::get_opt_value_scalar("-rpt_dir", "strict");
  my $aref_blocks    = &Hydra::Util::Option::get_opt_value_array("-blocks", "strict");
  my $set_name       = &Hydra::Util::Option::get_opt_value_scalar("-set", "relaxed", "all");
  my $pt_shell       = &Hydra::Util::Option::get_opt_value_scalar("-pt_shell", "strict");
  my $aref_skip      = &Hydra::Util::Option::get_opt_value_array("-skip", "relaxed", []);
  my $aref_scenarios = &Hydra::Util::Option::get_opt_value_array("-scenarios", "relaxed", []);
  my %user_scenarios = map {$_ => 1} @$aref_scenarios;

  # Get all scenarios
  my $scenario_pattern = '^([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)$';
  my %scenarios = ();
  # %scenarios =
  #   setup|hold = []
  #
  foreach my $entry (&Hydra::Util::File::get_sub_dirs($rpt_dir)) {
    # Skip non-matching scenarios -scenarios option is defined
    if (scalar(@$aref_scenarios) > 0 && !defined $user_scenarios{$entry}) {
      next;
    }

    if ($entry =~ /$scenario_pattern/) { 
      if ($entry =~ /_T$/) {
        push(@{ $scenarios{setup} }, $entry);
      }
      else {
        push(@{ $scenarios{hold} }, $entry);
      }
    }
  }

  my %pins = ();
  # %pins =
  #   $block =
  #     $block_pin =
  #       setup|hold =
  #         worst_slack    = <num>
  #         worst_scenario = <str>
  #
  foreach my $delay_type (qw(setup hold)) {
    foreach my $scenario (@{ $scenarios{$delay_type} }) {
      foreach my $block (@$aref_blocks) {
        my $rpt = "${rpt_dir}/${scenario}/${block}.${delay_type}.margin.rpt";
        next if (!-f $rpt);

        my $fh_in = &Hydra::Util::File::open_file_for_read($rpt);
        while (my $line = <$fh_in>) {
          chomp($line);
          next if ($line =~ /^\s*$/);
          
          if ($line =~ /^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)$/) {
            my $block_pin  = $1;
            my $slack      = $2;
            my $startpoint = $3;
            my $endpoint   = $4;
            
            # Get path type of block_pin - top2block, block2top, top2top, or block2block
            my $start_loc = "t";
            my $end_loc   = "t";
            my $block_hier = $block;
            $block_hier =~ s/__/\//g;
            if ($startpoint =~ /\Q${block_hier}\E\//) {
              $start_loc = "b";
            }
            if ($endpoint =~ /\Q${block_hier}\E\//) {
              $end_loc = "b";
            }
            my $path_type = "${start_loc}2${end_loc}";

            if (!defined $pins{$block}{$block_pin}{$delay_type}{worst_slack} ||
                $slack < $pins{$block}{$block_pin}{$delay_type}{worst_slack}) {
              $pins{$block}{$block_pin}{$delay_type}{worst_slack}      = $slack;
              $pins{$block}{$block_pin}{$delay_type}{worst_scenario}   = $scenario;
              $pins{$block}{$block_pin}{$delay_type}{worst_endpoint}   = $endpoint;
              $pins{$block}{$block_pin}{$delay_type}{worst_startpoint} = $startpoint;
              $pins{$block}{$block_pin}{$delay_type}{worst_path_type}  = $path_type;
            }
          }
        }
        &Hydra::Util::File::close_file($fh_in);
      }
    }
  }

  # Calculate margin and totals
  my %totals = ();
  $totals{all}{count} = 0;
  $totals{all}{hold}  = 0;
  $totals{all}{setup} = 0;
  # %totals =
  #   $block|all =
  #     count|hold|setup = <num>
  #
  my $max_pin_length  = 22;
  my $max_scen_length = 0;
  foreach my $block (sort keys %pins) {
    $totals{$block}{count} = 0;
    $totals{$block}{hold}  = 0;
    $totals{$block}{setup} = 0;
    foreach my $block_pin (sort keys %{ $pins{$block} }) {
      if (length($block_pin) > $max_pin_length) {
        $max_pin_length = length($block_pin);
      }
      foreach my $delay_type (qw(setup hold)) {
        # Worst slack is a good indicator of whether a set of "worst" values exist for this pin/delay
        if (defined $pins{$block}{$block_pin}{$delay_type}{worst_slack}) {
          if (length($pins{$block}{$block_pin}{$delay_type}{worst_scenario}) > $max_scen_length) {
            $max_scen_length = length($pins{$block}{$block_pin}{$delay_type}{worst_scenario})
          }
        }
      }
      
      my $setup_slack = $pins{$block}{$block_pin}{setup}{worst_slack};
      my $hold_slack  = $pins{$block}{$block_pin}{hold}{worst_slack};

      if (defined $setup_slack && defined $hold_slack) {
        $pins{$block}{$block_pin}{margin} = sprintf "%.3f", $hold_slack + $setup_slack;
      }

      # Update totals
      $totals{all}{count}++;
      $totals{$block}{count}++;
      if (defined $setup_slack) {
        $totals{all}{setup}    += $setup_slack;
        $totals{$block}{setup} += $setup_slack;
      }
      if (defined $hold_slack) {
        $totals{all}{hold}    += $hold_slack;
        $totals{$block}{hold} += $hold_slack;
      }
    }
  }

  # Add length of slack
  $max_scen_length += 12;
  # Add length of path type
  $max_scen_length += 5;
  
  # Write report
  my $outfile = "${rpt_dir}/${set_name}.margin.rpt";
  my $fh_out  = &Hydra::Util::File::open_file_for_write($outfile);
  print $fh_out "Hold Scenario Set:\n";
  foreach my $scenario_name (@{ $scenarios{hold} }) {
    print $fh_out "  $scenario_name\n";
  }
  print $fh_out "Setup Scenario Set:\n";
  foreach my $scenario_name (@{ $scenarios{setup} }) {
    print $fh_out "  $scenario_name\n";
  }
  print $fh_out "\n";

  foreach my $block (sort keys %pins) {
    print $fh_out "BLOCK: $block\n";
    printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "Pin", "Hold", "Setup";
    foreach my $block_pin (sort { &sort_by_margin2($pins{$block}, $a, $b) } keys %{ $pins{$block} }) {
      my $href_pin = $pins{$block}{$block_pin};

      my $hold_string  = "";
      my $setup_string = "";
      
      if (defined $href_pin->{hold}{worst_slack}) {
        $hold_string = "$href_pin->{hold}{worst_slack} ($href_pin->{hold}{worst_scenario}) ($href_pin->{hold}{worst_path_type})";
      }
      if (defined $href_pin->{setup}{worst_slack}) {
        $setup_string = "$href_pin->{setup}{worst_slack} ($href_pin->{setup}{worst_scenario}) ($href_pin->{setup}{worst_path_type})";
      }

      printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", $block_pin, $hold_string, $setup_string;
    }
    
    # Print block total
    printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "BLOCK TOTAL: " . $totals{$block}{count} . " pins", $totals{$block}{hold}, $totals{$block}{setup};
    print $fh_out "\n";
  }

  # Print grand total
  printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "GRAND TOTAL: " . $totals{all}{count} . " pins", $totals{all}{hold}, $totals{all}{setup};
  print $fh_out "\n";

  &Hydra::Util::File::close_file($fh_out);
}

sub sort_by_margin2 {
  my ($href_data, $a, $b) = @_;
  if (defined $href_data->{$a}{margin} && $href_data->{$b}{margin}) {
    return $href_data->{$a}{margin} <=> $href_data->{$b}{margin};
  }
  elsif (defined $href_data->{$a}{margin}) {
    return 1;
  }
  elsif (defined $href_data->{$b}{margin}) {
    return -1;
  }
  elsif (defined $href_data->{$a}{hold}{worst_slack} && defined $href_data->{$b}{hold}{worst_slack}) {
    return $href_data->{$a}{hold}{worst_slack} <=> $href_data->{$b}{hold}{worst_slack};
  }
  elsif (defined $href_data->{$a}{setup}{worst_slack} && defined $href_data->{$b}{setup}{worst_slack}) {
    return $href_data->{$a}{setup}{worst_slack} <=> $href_data->{$b}{setup}{worst_slack};
  }
  elsif (defined $href_data->{$a}{hold}{worst_slack}) {
    return -1;
  }
  elsif (defined $href_data->{$b}{hold}{worst_slack}) {
    return 1;
  }
  else {
    return 0;
  }
}

sub report_interface_timing_margin {
  my $rpt_dir        = &Hydra::Util::Option::get_opt_value_scalar("-rpt_dir", "strict");
  my $aref_blocks    = &Hydra::Util::Option::get_opt_value_array("-blocks", "strict");
  my $threshold      = &Hydra::Util::Option::get_opt_value_scalar("-slack_threshold", "relaxed", 0);
  my $mode           = &Hydra::Util::Option::get_opt_value_scalar("-mode", "relaxed", undef);
  my $set_name       = &Hydra::Util::Option::get_opt_value_scalar("-set", "relaxed", "all");
  my $pt_shell       = &Hydra::Util::Option::get_opt_value_scalar("-pt_shell", "strict");
  my $aref_skip      = &Hydra::Util::Option::get_opt_value_array("-skip", "relaxed", []);
  my $rpt_only       = &Hydra::Util::Option::get_opt_value_array("-report_viols_only", "relaxed", 0);
  my $aref_scenarios = &Hydra::Util::Option::get_opt_value_array("-scenarios", "relaxed", []);
  my %user_scenarios = map {$_ => 1} @$aref_scenarios;

  if ($rpt_only =~ /true|on|yes/i) {
    $rpt_only = 1;
  }

  # Store pins to skip in searchable hash
  my %skip = map {$_ => 1} @$aref_skip;

  # Get all scenarios
  my $scenario_pattern = '^([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)\.([^\s\.]+)$';
  my %scenarios = ();
  # %scenarios =
  #   setup|hold = []
  #
  foreach my $entry (&Hydra::Util::File::get_sub_dirs($rpt_dir)) {
    # Skip non-matching scenarios -scenarios option is defined
    if (scalar(@$aref_scenarios) > 0 && !defined $user_scenarios{$entry}) {
      next;
    }

    if ($entry =~ /$scenario_pattern/) { 
      if ($entry =~ /_T$/) {
        push(@{ $scenarios{setup} }, $entry);
      }
      else {
        push(@{ $scenarios{hold} }, $entry);
      }
    }
  }

  # Read all timing reports
  my %data = ();
  # %data =
  #   setup|hold =
  #     $scenario =
  #       total|worst|count = <num>
  #
  my %pins = ();
  # %pins =
  #   setup|hold =
  #     $block =
  #       $block_pin =
  #         worst_slack    = <num>
  #         worst_scenario = <str>
  #         worst_endpoint = <str>
  #
  foreach my $delay_type (qw(setup hold)) {
    foreach my $scenario (@{ $scenarios{$delay_type} }) {
      if (defined $mode && $scenario !~ /^\Q${mode}\E/) {
        next;
      }

      foreach my $block (@$aref_blocks) {
        my $rpt = "${rpt_dir}/${scenario}/${block}.${delay_type}.timing.rpt";
        next if (!-f $rpt);

        my $Report = new Hydra::Report::PtTiming($scenario, $rpt, $threshold);
        foreach my $Path ($Report->get_path_list) {
          my $block_pin  = $Path->get_thrupin;
          my $startpoint = $Path->get_startpoint;
          my $endpoint   = $Path->get_endpoint;
          my $slack      = $Path->get_slack;

          # Get path type of block_pin - top2block, block2top, top2top, or block2block
          my $start_loc = "t";
          my $end_loc   = "t";
          my $block_hier = $block;
          $block_hier =~ s/__/\//g;
          if ($startpoint =~ /\Q${block_hier}\E\//) {
            $start_loc = "b";
          }
          if ($endpoint =~ /\Q${block_hier}\E\//) {
            $end_loc = "b";
          }
          my $path_type = "${start_loc}2${end_loc}";

          if (defined $block_pin) {
            if (!defined $pins{$delay_type}{$block}{$block_pin}{worst_slack} ||
                $slack < $pins{$delay_type}{$block}{$block_pin}{worst_slack}) {
              $pins{$delay_type}{$block}{$block_pin}{worst_slack}      = $slack;
              $pins{$delay_type}{$block}{$block_pin}{worst_scenario}   = $scenario;
              $pins{$delay_type}{$block}{$block_pin}{worst_endpoint}   = $endpoint;
              $pins{$delay_type}{$block}{$block_pin}{worst_startpoint} = $startpoint;
              $pins{$delay_type}{$block}{$block_pin}{worst_path_type}  = $path_type;
            }
          }
        }

        $data{$delay_type}{$block}{$scenario}{total} = $Report->get_tns;
        $data{$delay_type}{$block}{$scenario}{worst} = $Report->get_wns;
        $data{$delay_type}{$block}{$scenario}{count} = $Report->get_count;
      }
    }
  }

  if ($rpt_only) {
    # Reorder pin hash
    my %reordered = ();
    my $max_pin_length  = 0;
    my $max_scen_length = 0;
    foreach my $delay_type (keys %pins) {
      foreach my $block (keys %{ $pins{$delay_type} }) {
        foreach my $block_pin (keys %{ $pins{$delay_type}{$block} }) {
          my $href_pin = $pins{$delay_type}{$block}{$block_pin};
          $reordered{$block}{$block_pin}{$delay_type} = $href_pin;
          
          if (length($block_pin) > $max_pin_length) {
            $max_pin_length = length($block_pin);
          }
          if (length($href_pin->{worst_scenario}) > $max_scen_length) {
            $max_scen_length = length($href_pin->{worst_scenario});
          }
        }
      }
    }

    # Add length of slack
    $max_scen_length += 12;
    # Add length of path type
    $max_scen_length += 5;
    
    my $fh_out = &Hydra::Util::File::open_file_for_write("report_interface_timing_viols.rpt");
    foreach my $block (keys %reordered) {
      print $fh_out "BLOCK: $block\n";
      printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "Pin", "Hold", "Setup";

      my $num_pins = 0;
      foreach my $block_pin (sort { &viols_only_sort_by_hold_then_setup($reordered{$block}, $a, $b) } keys %{ $reordered{$block} }) {
        $num_pins++;
        my $href_hold  = $reordered{$block}{$block_pin}{hold};
        my $href_setup = $reordered{$block}{$block_pin}{setup};

        my $hold_string  = "";
        my $setup_string = "";
        if (defined $href_hold) {
          $hold_string = "$href_hold->{worst_slack} ($href_hold->{worst_scenario}) ($href_hold->{worst_path_type})";
        }
        if (defined $href_setup) {
          $setup_string = "$href_setup->{worst_slack} ($href_setup->{worst_scenario}) ($href_setup->{worst_path_type})";
        }

        printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", $block_pin, $hold_string, $setup_string;
      }
      
      print $fh_out "  BLOCK TOTAL: ${num_pins} pins\n";
      print $fh_out "\n";
    }
    &Hydra::Util::File::close_file($fh_out);
  }
  else {
    # Write PT scripts for checking slack on the opposite delay type
    my %scenario_scripts = ();
    # %scenario_scripts =
    #   $scenario_name =
    #     $script_name = \@lines
    #
    foreach my $delay_type (qw(setup hold)) {
      foreach my $block (sort keys %{ $pins{$delay_type} }) {
        foreach my $block_pin (sort keys %{ $pins{$delay_type}{$block} }) {
          next if (defined $skip{$block_pin});

          my $worst_slack     = $pins{$delay_type}{$block}{$block_pin}{worst_slack};
          my $worst_scenario  = $pins{$delay_type}{$block}{$block_pin}{worst_scenario};
          my $worst_path_type = $pins{$delay_type}{$block}{$block_pin}{worst_path_type};

          if ($delay_type eq "setup") {
            my $worst_endpoint = $pins{$delay_type}{$block}{$block_pin}{worst_endpoint};

            # Hold report
            foreach my $scenario (@{ $scenarios{hold} }) {
              my $script      = "./script/margin.${set_name}/margin_check.${scenario}.for_setup.tcl";
              
              if (!defined $scenario_scripts{$scenario}{$script}) {
                push(@{ $scenario_scripts{$scenario}{$script} }, "file delete ./rpt/${scenario}/${set_name}.for_setup.margin.rpt\n");
                push(@{ $scenario_scripts{$scenario}{$script} }, "echo \"REF_SCENARIO_SET\: " . join(" ", @{ $scenarios{setup} }) . "\" >> ./rpt/${scenario}/${set_name}.for_setup.margin.rpt\n");
              }

              push(@{ $scenario_scripts{$scenario}{$script} }, "echo \"BLOCK_PIN\: $block $block_pin $worst_slack $worst_scenario $worst_path_type\" >> ./rpt/${scenario}/${set_name}.for_setup.margin.rpt\n");
              push(@{ $scenario_scripts{$scenario}{$script} }, "report_timing -slack_lesser_than 1000 -path_type summary -significant_digits 3 -nosplit -max_paths 1 -nworst 1 -delay_type min -include_hierarchical_pins -through $block_pin -to $worst_endpoint >> ./rpt/${scenario}/${set_name}.for_setup.margin.rpt\n");
            }

            # Next setup report
            # Need to add Q pin for -from paths or else PT will add in -to D pin
            $worst_endpoint .= "/Q";
            foreach my $scenario (@{ $scenarios{setup} }) {
              my $script_plus = "./script/margin.${set_name}/margin_check.${scenario}.for_setup.plus.tcl";
              
              if (!defined $scenario_scripts{$scenario}{$script_plus}) {
                push(@{ $scenario_scripts{$scenario}{$script_plus} }, "file delete ./rpt/${scenario}/${set_name}.plus.for_setup.margin.rpt\n");
                push(@{ $scenario_scripts{$scenario}{$script_plus} }, "echo \"REF_SCENARIO_SET\: " . join(" ", @{ $scenarios{setup} }) . "\" >> ./rpt/${scenario}/${set_name}.plus.for_setup.margin.rpt\n");
              }

              push(@{ $scenario_scripts{$scenario}{$script_plus} }, "echo \"BLOCK_PIN\: $block $block_pin $worst_slack $worst_scenario $worst_path_type\" >> ./rpt/${scenario}/${set_name}.plus.for_setup.margin.rpt\n");
              push(@{ $scenario_scripts{$scenario}{$script_plus} }, "report_timing -slack_lesser_than 1000 -path_type summary -significant_digits 3 -nosplit -max_paths 1 -nworst 1 -delay_type max -include_hierarchical_pins -from $worst_endpoint >> ./rpt/${scenario}/${set_name}.plus.for_setup.margin.rpt\n");
            }
          }
          elsif ($delay_type eq "hold") {
            my $worst_startpoint = $pins{$delay_type}{$block}{$block_pin}{worst_startpoint};

            # Setup report
            foreach my $scenario (@{ $scenarios{setup} }) {
              my $script = "./script/margin.${set_name}/margin_check.${scenario}.for_hold.tcl";

              if (!defined $scenario_scripts{$scenario}{$script}) {
                push(@{ $scenario_scripts{$scenario}{$script} }, "file delete ./rpt/${scenario}/${set_name}.for_hold.margin.rpt\n");
                push(@{ $scenario_scripts{$scenario}{$script} }, "echo \"REF_SCENARIO_SET\: " . join(" ", @{ $scenarios{hold} }) . "\" >> ./rpt/${scenario}/${set_name}.for_hold.margin.rpt\n");
              }

              push(@{ $scenario_scripts{$scenario}{$script} }, "echo \"BLOCK_PIN\: $block $block_pin $worst_slack $worst_scenario $worst_path_type\" >> ./rpt/${scenario}/${set_name}.for_hold.margin.rpt\n");
              push(@{ $scenario_scripts{$scenario}{$script} }, "report_timing -slack_lesser_than 1000 -path_type summary -significant_digits 3 -nosplit -max_paths 1 -nworst 1 -delay_type max -include_hierarchical_pins -through $block_pin -from $worst_startpoint >> ./rpt/${scenario}/${set_name}.for_hold.margin.rpt\n");
              
              # Prev hold report
              # Need to add D pin for -to paths or else PT will add in -from Q pin
              # $worst_startpoint .= "/D";
              
              # print $fh_plus "echo \"BLOCK_PIN\: $block $block_pin $worst_slack $worst_scenario\" >> ./rpt/${scenario}/plus.for_hold.margin.rpt\n";
              # print $fh_plus "report_timing -slack_lesser_than 1000 -path_type summary -significant_digits 3 -nosplit -max_paths 10 -delay_type max -to $worst_startpoint >> ./rpt/${scenario}/plus.for_hold.margin.rpt\n";
            }
          }
        }
      }
    }

    # Write all opposing delay type scripts
    my $kickoff_script = "HYDRA.${set_name}.margin";
    my $fh_kickoff = &Hydra::Util::File::open_file_for_write($kickoff_script);
    print $fh_kickoff "#!/usr/bin/bash\n";
    print $fh_kickoff "# Generated by Hydra report_interface_timing_margin on " . localtime . "\n";
    print $fh_kickoff "export HYDRA_HOME=$ENV{HYDRA_HOME}\n";
    print $fh_kickoff "export SNPSLMD_QUEUE=true\n";
    print $fh_kickoff "\n";
    &Hydra::Util::File::make_dir("./script");
    &Hydra::Util::File::make_dir("./script/margin.${set_name}");
    &Hydra::Util::File::make_dir("./log");
    &Hydra::Util::File::make_dir("./log/margin.${set_name}");
    foreach my $scenario (keys %scenario_scripts) {
      # Create PT script for this scenario and source all margin scripts
      my $pt_script = "script/margin.${set_name}/${scenario}.margin.tcl";
      my $pt_log    = "log/margin.${set_name}/${scenario}.margin.log";
      my $fh_pt     = &Hydra::Util::File::open_file_for_write($pt_script);
      print $fh_pt "restore_session ./db/${scenario}.timing.session\n";
      print $fh_pt "\n";

      &Hydra::Util::File::make_dir("./rpt/${scenario}");
      foreach my $script (keys %{ $scenario_scripts{$scenario} }) {
        my $fh_out = &Hydra::Util::File::open_file_for_write($script);
        foreach my $line (@{ $scenario_scripts{$scenario}{$script} }) {
          print $fh_out $line;
        }
        &Hydra::Util::File::close_file($fh_out);      

        # Add to PT script
        print $fh_pt "source $script\n";
      }

      print $fh_pt "\n";
      print $fh_pt "exit\n";
      &Hydra::Util::File::close_file($fh_pt);

      # Add PT scenario script to kickoff
      print $fh_kickoff "$pt_shell -file $pt_script |& tee $pt_log &\n";
    }
    &Hydra::Util::File::close_file($fh_kickoff);
    chmod 0775, $kickoff_script;
  }
}

sub process_interface_timing_margin {
  my $rpt_dir        = &Hydra::Util::Option::get_opt_value_scalar("-rpt_dir", "strict");
  my $set_name       = &Hydra::Util::Option::get_opt_value_scalar("-set", "relaxed", "all");
  my $aref_scenarios = &Hydra::Util::Option::get_opt_value_array("-scenarios", "strict");
  
  my $max_pin_length  = 0;
  my $max_scen_length = 0;
  foreach my $scenario_name (@$aref_scenarios) {
    if (length($scenario_name) > $max_scen_length) {
      $max_scen_length = length($scenario_name);
    }
  }
  # Add length of slack
  $max_scen_length += 12;
  # Add length of path type
  $max_scen_length += 5;
  
  my %ref_scenarios = ();
  # %ref_scenarios =
  #   setup|hold =
  #     $scenario_name = 1
  #
  my %data = ();
  # %data =
  #   setup|hold =
  #     $block =
  #       $pin =
  #         worst = 
  #           orig|reg|plus
  #             slack     = <num>
  #             scenario  = <str>
  #         margin = 
  #           reg|plus = <num> # margin between orig slack and worst new slack
  #
  foreach my $delay_type (qw(setup hold)) {
    foreach my $scenario (@$aref_scenarios) {
      my %rpts;
      if ($delay_type eq "setup") {
        %rpts = ("reg"  => "${rpt_dir}/${scenario}/${set_name}.for_${delay_type}.margin.rpt",
                 "plus" => "${rpt_dir}/${scenario}/${set_name}.plus.for_${delay_type}.margin.rpt");
      }
      else {
        %rpts = ("reg"  => "${rpt_dir}/${scenario}/${set_name}.for_${delay_type}.margin.rpt")
      }

      foreach my $rpt_type (keys %rpts) {
        my $rpt = $rpts{$rpt_type};
        
        # Process rpt
        if (-f $rpt) {
          my $block              = undef;
          my $pin                = undef;
          my $pin_worst_slack    = undef;
          my $pin_worst_scenario = undef;
          my $fh_in = &Hydra::Util::File::open_file_for_read($rpt);
          while (my $line = <$fh_in>) {
            if ($line =~ /BLOCK_PIN\:\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/) {
              $block = $1;
              $pin   = $2;

              if (length($pin) > $max_pin_length) {
                $max_pin_length = length($pin);
              }
              
              $data{$delay_type}{$block}{$pin}{worst}{orig}{slack}     = $3;
              $data{$delay_type}{$block}{$pin}{worst}{orig}{scenario}  = $4;
              $data{$delay_type}{$block}{$pin}{worst}{orig}{path_type} = $5;
            }
            if ($line =~ /REF_SCENARIO_SET\:\s*(.*)\s*/) {
              my @scenarios  = split(/\s+/, $1);
              foreach my $scenario_name (@scenarios) {
                $ref_scenarios{$delay_type}{$scenario_name} = 1;
              }
            }
            if ($line =~ /^(\S+)\s+\(\S+\)\s+(\S+)\s+\(\S+\)\s+(\S+)/) {
              my $startpoint = $1;
              my $endpoint   = $2;
              my $slack      = $3;

              # Get path type of block_pin - top2block, block2top, top2top, or block2block
              my $start_loc = "t";
              my $end_loc   = "t";
              my $block_hier = $block;
              $block_hier =~ s/__/\//g;
              if ($startpoint =~ /\Q${block_hier}\E\//) {
                $start_loc = "b";
              }
              if ($endpoint =~ /\Q${block_hier}\E\//) {
                $end_loc = "b";
              }
              my $path_type = "${start_loc}2${end_loc}";

              if (!defined $data{$delay_type}{$block}{$pin}{worst}{$rpt_type}{slack} ||
                  $slack < $data{$delay_type}{$block}{$pin}{worst}{$rpt_type}{slack}) {
                $data{$delay_type}{$block}{$pin}{worst}{$rpt_type}{slack}     = $slack;
                $data{$delay_type}{$block}{$pin}{worst}{$rpt_type}{scenario}  = $scenario;
                $data{$delay_type}{$block}{$pin}{worst}{$rpt_type}{path_type} = $path_type;
                $data{$delay_type}{$block}{$pin}{margin}{$rpt_type}           = sprintf "%.3f", $data{$delay_type}{$block}{$pin}{worst}{orig}{slack} + $data{$delay_type}{$block}{$pin}{worst}{$rpt_type}{slack};
              }
            }
          }
          &Hydra::Util::File::close_file($fh_in);
        }
      }
    }
  }

  &Hydra::Util::File::make_dir("./rpt");
  my %totals = ();
  # %totals =
  #   setup|hold =
  #     $block|all =
  #       margin|plus_margin|orig|reg|plus|count
  #       
  foreach my $delay_type (qw(setup hold)) {
    # Initialize grand total
    $totals{$delay_type}{all} = {"margin" => 0, "plus_margin" => 0, "orig" => 0, "reg" => 0, "plus" => 0, "count" => 0};

    my $fh_out = &Hydra::Util::File::open_file_for_write("./rpt/${set_name}.${delay_type}.margin.rpt");

    # Print scenario sets
    my $opposing_delay_type;
    if ($delay_type eq "setup") {
      print $fh_out "Reference/Next Scenario Set:\n";
      $opposing_delay_type = "hold";
    }
    else {
      print $fh_out "Reference Scenario Set:\n";
      $opposing_delay_type = "setup";
    }
    foreach my $ref_scenario_name (sort keys %{ $ref_scenarios{$delay_type} }) {
      print $fh_out "  $ref_scenario_name\n";
    }
    print $fh_out "Opposing Scenario Set:\n";
    foreach my $ref_scenario_name (sort keys %{ $ref_scenarios{$opposing_delay_type} }) {
      print $fh_out "  $ref_scenario_name\n";
    }
    print $fh_out "\n";

    foreach my $block (sort keys %{ $data{$delay_type} }) {
      # Initialize block totals
      $totals{$delay_type}{$block} = {"margin" => 0, "plus_margin" => 0, "orig" => 0, "reg" => 0, "plus" => 0, "count" => 0};

      print $fh_out "BLOCK: $block\n";
      if ($delay_type eq "setup") {
        printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "Pin", "Hold (Opposing)", "Setup (Reference)", "Setup (Next)";
      }
      elsif ($delay_type eq "hold") {
        printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "Pin", "Setup (Opposing)", "Hold (Reference)";
      }
      
      #foreach my $pin (sort {$data{$delay_type}{$block}{$a}{margin}{reg} <=> $data{$delay_type}{$block}{$b}{margin}{reg}} keys %{ $data{$delay_type}{$block} }) {
      foreach my $pin (sort { &sort_by_orig($data{$delay_type}{$block}, $a, $b) } keys %{ $data{$delay_type}{$block} }) {
        my $margin             = $data{$delay_type}{$block}{$pin}{margin}{reg};
        my $orig_slack         = $data{$delay_type}{$block}{$pin}{worst}{orig}{slack};
        my $opposing_slack     = $data{$delay_type}{$block}{$pin}{worst}{reg}{slack};
        my $orig_scenario      = $data{$delay_type}{$block}{$pin}{worst}{orig}{scenario};
        my $opposing_scenario  = $data{$delay_type}{$block}{$pin}{worst}{reg}{scenario};
        my $plus_margin        = $data{$delay_type}{$block}{$pin}{margin}{plus};
        my $plus_slack         = $data{$delay_type}{$block}{$pin}{worst}{plus}{slack};
        my $plus_scenario      = $data{$delay_type}{$block}{$pin}{worst}{plus}{scenario};
        my $orig_path_type     = $data{$delay_type}{$block}{$pin}{worst}{orig}{path_type};
        my $opposing_path_type = $data{$delay_type}{$block}{$pin}{worst}{reg}{path_type};
        my $plus_path_type     = $data{$delay_type}{$block}{$pin}{worst}{plus}{path_type};

        # Record totals
        if (defined $orig_slack) {
          $totals{$delay_type}{$block}{orig} += $orig_slack;
          $totals{$delay_type}{all}{orig}    += $orig_slack;
        }
        if (defined $opposing_slack) {
          $totals{$delay_type}{$block}{reg} += $opposing_slack;
          $totals{$delay_type}{all}{reg}    += $opposing_slack;
        }
        if (defined $plus_slack) {
          $totals{$delay_type}{$block}{plus} += $plus_slack;
          $totals{$delay_type}{all}{plus}    += $plus_slack;
        }
        if (defined $margin) {
          $totals{$delay_type}{$block}{margin} += $margin;
          $totals{$delay_type}{all}{margin}    += $margin;
        }
        if (defined $plus_margin) {
          $totals{$delay_type}{$block}{plus_margin} += $plus_margin;
          $totals{$delay_type}{all}{plus_margin}    += $plus_margin;
        }
        $totals{$delay_type}{$block}{count} += 1;
        $totals{$delay_type}{all}{count}    += 1;

        # Construct slack strings
        $margin         = "" if (!defined $margin);
        $plus_margin    = "" if (!defined $plus_margin);
        if (!defined $orig_slack) {
          $orig_slack = "";
        }
        else {
          $orig_slack = "$orig_slack ($orig_scenario)";

          if (defined $orig_path_type) {
            $orig_slack .= " ($orig_path_type)";
          }
        }
        if (!defined $opposing_slack) {
          $opposing_slack = "";
        }
        else{
          $opposing_slack = "$opposing_slack ($opposing_scenario)";

          if (defined $opposing_path_type) {
            $opposing_slack .= " ($opposing_path_type)";
          }
        }
        if (!defined $plus_slack) {
          $plus_slack = "";
        }
        else {
          $plus_slack = "$plus_slack ($plus_scenario)";

          if (defined $plus_path_type) {
            $plus_slack .= " ($plus_path_type)";
          }
        }

        if ($delay_type eq "setup") {
          printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s %-${max_scen_length}s\n", $pin, $opposing_slack, $orig_slack, $plus_slack;
        }
        elsif ($delay_type eq "hold") {
          printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", $pin, $opposing_slack, $orig_slack;
        }
      }
      
      # Print block total
      if ($delay_type eq "setup") {
        printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "BLOCK TOTAL: " . $totals{$delay_type}{$block}{count} . " pins", $totals{$delay_type}{$block}{reg}, $totals{$delay_type}{$block}{orig}, $totals{$delay_type}{$block}{plus};
      }
      elsif ($delay_type eq "hold") {
        printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "BLOCK TOTAL: " . $totals{$delay_type}{$block}{count} . " pins", $totals{$delay_type}{$block}{reg}, $totals{$delay_type}{$block}{orig};
      }
      print $fh_out "\n";
    }

    # Print grand total
    if ($delay_type eq "setup") {
      printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "GRAND TOTAL: " . $totals{$delay_type}{all}{count} . " pins", $totals{$delay_type}{all}{reg}, $totals{$delay_type}{all}{orig}, $totals{$delay_type}{all}{plus};
    }
    elsif ($delay_type eq "hold") {
      printf $fh_out "  %-${max_pin_length}s %-${max_scen_length}s %-${max_scen_length}s\n", "GRAND TOTAL: " . $totals{$delay_type}{all}{count} . " pins", $totals{$delay_type}{all}{reg}, $totals{$delay_type}{all}{orig};
    }
    print $fh_out "\n";

    &Hydra::Util::File::close_file($fh_out);
  }
}

sub sort_by_margin {
  my ($href_data, $a, $b) = @_;
  if (defined $href_data->{$a}{margin}{reg} && $href_data->{$b}{margin}{reg}) {
    return $href_data->{$a}{margin}{reg} <=> $href_data->{$b}{margin}{reg};
  }
  elsif (defined $href_data->{$a}{margin}{reg}) {
    return 1;
  }
  elsif (defined $href_data->{$b}{margin}{reg}) {
    return -1;
  }
  else {
    return 0;
  }
}

sub sort_by_orig {
  my ($href_data, $a, $b) = @_;
  if (defined $href_data->{$a}{worst}{orig}{slack} && $href_data->{$b}{worst}{orig}{slack}) {
    return $href_data->{$a}{worst}{orig}{slack} <=> $href_data->{$b}{worst}{orig}{slack};
  }
  elsif (defined $href_data->{$a}{worst}{orig}{slack}) {
    return 1;
  }
  elsif (defined $href_data->{$b}{worst}{orig}{slack}) {
    return -1;
  }
  else {
    return 0;
  }
}

sub viols_only_sort_by_hold_then_setup {
  my ($href_data, $a, $b) = @_;
  if (defined $href_data->{$a}{hold} && defined $href_data->{$b}{hold}) {
    return $href_data->{$a}{hold}{worst_slack} <=> $href_data->{$b}{hold}{worst_slack};
  }
  elsif (defined $href_data->{$a}{hold} && !defined $href_data->{$b}{hold}) {
    return 1;
  }
  elsif (!defined $href_data->{$a}{hold} && defined $href_data->{$b}{hold}) {
    return -1;
  }
  elsif (defined $href_data->{$a}{setup} && defined $href_data->{$b}{setup}) {
    return $href_data->{$a}{setup}{worst_slack} <=> $href_data->{$b}{setup}{worst_slack};
  }
  elsif (defined $href_data->{$a}{setup} && !defined $href_data->{$b}{setup}) {
    return 1;
  }
  elsif (!defined $href_data->{$a}{setup} && defined $href_data->{$b}{setup}) {
    return -1;
  }
  else {
    return $a cmp $b;
  }
}

1;
