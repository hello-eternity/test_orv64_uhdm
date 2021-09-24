#------------------------------------------------------
# Module Name: RC_EXTRACT
# Date:        Mon Feb  4 15:29:28 2019
# Author:      kvu
# Type:        rc_extract
#------------------------------------------------------
package Hydra::Setup::Flow::RC_EXTRACT;

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

#++
# Tool: starrc
# Flow: RC_EXTRACT
#--
sub starrc_RC_EXTRACT {
  my ($Paramref) = @_;
  my $design_name = $Paramref->get_param_value("GLOBAL_design", "strict");
  
  # Get all RC corners from RC_EXTRACT param
  my @keysets = $Paramref->get_param_keysets("SCENARIO", 4);
  my %seen_scenarios = ();
  my @ScriptFiles = ();
  my @script_file_names = ();
  my $num_scenarios = 0;
  foreach my $aref_keys (sort { "$a->[3].$a->[2]" cmp "$b->[3].$b->[2]" } @keysets) {
    my $scenario_value = $Paramref->get_param_value("SCENARIO", "relaxed", @$aref_keys);
    my %scenario_tags  = &Hydra::Setup::Flow::parse_scenario_value($scenario_value);
    next if (!$scenario_tags{rc_extract});
    $num_scenarios++;

    #my ($rc, $temp) = @$aref_keys;
    my ($mode, $pv, $temp, $rc) = @$aref_keys;
    my $scenario_name = "${rc}.${temp}";
    next if (defined $seen_scenarios{$scenario_name});
    $seen_scenarios{$scenario_name} = 1;

    my $File = new Hydra::Setup::File("script/${scenario_name}.rc_extract.cmd", "rc_extract");
    push(@ScriptFiles, $File);
    push(@script_file_names, "script/${scenario_name}.rc_extract.cmd");
    my $line = "";

    $line .= "BLOCK: $design_name\n";
    $line .= "\n";

    # LEF
    my $ndm_db    = $Paramref->get_param_value("RC_EXTRACT_ndm_db", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($ndm_db)) {
      # NDM database
      $line .= &Hydra::Setup::Flow::write_repeating_param("NDM_DATABASE:", $ndm_db);
      $line .= "\n";
    }
    else {
      my $tech_lef  = $Paramref->get_param_value("LEF_tech", "strict", @$aref_keys);
      my $std_lef   = $Paramref->get_param_value("LEF_std_list", "strict", @$aref_keys);
      my $macro_lef = $Paramref->get_param_value("LEF_macro_list", "relaxed", @$aref_keys);
      $line .= "* Read libraries\n";
      $line .= &Hydra::Setup::Flow::write_repeating_param("LEF_FILE:", $tech_lef);
      $line .= &Hydra::Setup::Flow::write_repeating_param("LEF_FILE:", $std_lef);
      $line .= &Hydra::Setup::Flow::write_repeating_param("LEF_FILE:", $macro_lef);
      $line .= "\n";

      my $def       = $Paramref->get_param_value("RC_EXTRACT_def", "relaxed", @$aref_keys);
      my $macro_def = $Paramref->get_param_value("RC_EXTRACT_macro_def", "relaxed", @$aref_keys);
      $line .= &Hydra::Setup::Flow::write_repeating_param("TOP_DEF_FILE:", $def);
      $line .= &Hydra::Setup::Flow::write_repeating_param("MACRO_DEF_FILE:", $macro_def);
      $line .= "\n";
    }
    
    my $tcad_grd_file = $Paramref->get_param_value("RC_EXTRACT_tcad_grd", "strict", ($rc));
    $line .= "* Specify nxtgrd file which consists of capacitance models\n";
    $line .= "TCAD_GRD_FILE: $tcad_grd_file\n";
    $line .= "\n";

    my $mapping = $Paramref->get_param_value("RC_EXTRACT_mapping", "strict", @$aref_keys);
    $line .= "* Provide the mapping file in which design layers mapped to process layers\n";
    $line .= "MAPPING_FILE: $mapping\n";
    $line .= "\n";

    my $gds_layer_map = $Paramref->get_param_value("RC_EXTRACT_gds_layer_map", "relaxed", @$aref_keys);
    if (&Hydra::Setup::Param::has_value($gds_layer_map)) {
      $line .= "* GDS layer map\n";
      $line .= "GDS_LAYER_MAP_FILE: $gds_layer_map\n";
      $line .= "\n";
    }

    my $metal_fill_gds_block = $Paramref->get_param_value("RC_EXTRACT_metal_fill_gds_block", "relaxed", @$aref_keys);
    my $metal_fill_gds_file  = $Paramref->get_param_value("RC_EXTRACT_metal_fill_gds_file", "relaxed", @$aref_keys);
    $line .= "* Metal fill GDS\n";
    $line .= "METAL_FILL_POLYGON_HANDLING: FLOATING\n";
    if (&Hydra::Setup::Param::has_value($metal_fill_gds_block)) {
      $line .= "METAL_FILL_GDS_BLOCK: $metal_fill_gds_block\n";
    }
    if (&Hydra::Setup::Param::has_value($metal_fill_gds_file)) {
      $line .= "METAL_FILL_GDS_FILE: $metal_fill_gds_file\n";
    }
    $line .= "\n";

    my $temperature = $temp;
    $temperature =~ s/c//;
    $temperature =~ s/m|n/-/;

    $line .= sprintf <<EOF;
* Use '*' to extract all signal nets in the design. Otherwise, provide the net names to be extracted separated by a space. Wildcards '?' and '!' are accepted for net names
NETS: *

* Operating temperature in Celsius
OPERATING_TEMPERATURE: $temperature

NETLIST_NAME_MAP: YES

EXTRACT_VIA_CAPS: YES

* MODE: 400

* Database processing
SKIP_CELLS: *

* Output
COUPLE_TO_GROUND: NO

NETLIST_FORMAT: SPEF
NETLIST_COMPRESS_COMMAND: gzip
NETLIST_FILE: output/${design_name}.${scenario_name}.spef.gz

REDUCTION: NO_EXTRA_LOOPS

SUMMARY_FILE: rpt/summary.${scenario_name}.rpt

STAR_DIRECTORY: work.${scenario_name}

GPD: ${design_name}.${scenario_name}.gpd

REPORT_METAL_FILL_STATISTICS: YES

EOF

    $File->add_line($line);
  }

  # Error if no scenarios were defined
  if ($num_scenarios <= 0) {
    &Hydra::Setup::Control::register_error_param("RC_EXTRACT", "no_scenario");
  }

  # Run scripts
  my $KickoffFile = new Hydra::Setup::File("HYDRA.run", "rc_extract");
  #&Hydra::Setup::Flow::write_std_kickoff($Paramref, $KickoffFile, @script_file_names);
  my $time = localtime;
  $KickoffFile->add_line("#!/usr/bin/bash");
  $KickoffFile->add_line("# Generated by Hydra on $time");
  $KickoffFile->add_line("export HYDRA_HOME=$ENV{HYDRA_HOME}");
  $KickoffFile->add_linebreak;

  $KickoffFile->add_line("rm -rf work*/");
  $KickoffFile->add_line("rm -rf *gpd/");
  $KickoffFile->add_linebreak;

  foreach my $script_name (@script_file_names) {
    my $tool_command = &Hydra::Setup::Tool::get_tool_command($Paramref, $KickoffFile->get_type, $script_name);
    $KickoffFile->add_line($tool_command);
  }

  $KickoffFile->make_executable;

  return (@ScriptFiles, $KickoffFile);
}

=pod

=head1 starrc RC_EXTRACT

=over

=item SCENARIO

Specify the scenarios that will be run. Use param keys for mode, process, temperature, and RC corner. The param key order matters. The value is a space-delimited list indicating what flow types the scenario is valid for. Use "rc_extract" for RC_EXTRACT. For RC_EXTRACT, only the RC corner and temperature are used.
 SCENARIO(<mode>)(<process>)(<temp>)(<rc>) = <value>
 SCENARIO(func)(ff_0p99)(125c)(cbest) = rc_extract

=item RC_EXTRACT_macro_def

The macro def file. This param can be used with the same param keys as SCENARIO.

=item RC_EXTRACT_def

The def file. This param can be used with the same param keys as SCENARIO.

=item RC_EXTRACT_ndm_db

An nlib database from icc2. This param can be used with the same param keys as SCENARIO. If this has a value, then RC_EXTRACT_def, RC_EXTRACT_macro_def, LEF_tech, LEF_std_list, and LEF_macro_list will not be used.

=item RC_EXTRACT_tcad_grd

The tcad grd file. This param can be used with the same RC corner keys as SCENARIO.
 SCENARIO(func)(ff_0p99)(125c)(cbest) = rc_extract
 RC_EXTRACT_tcad_grd(cbest) = file.nxtgrd

=item RC_EXTRACT_gds_layer_map 

The gds layer map. This param can be used with the same param keys as SCENARIO.

=item RC_EXTRACT_metal_fill_gds_block 

The metal fill gds block. This param can be used with the same param keys as SCENARIO.

=item RC_EXTRACT_mapping

The mapping file. This param can be used with the same param keys as SCENARIO.

=item RC_EXTRACT_metal_fill_gds_file 

The metal fill gds file. This param can be used with the same param keys as SCENARIO.


=back

=cut

1;
