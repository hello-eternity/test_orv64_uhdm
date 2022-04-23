#------------------------------------------------------
# Module Name: Doc
# Date:        Fri Feb 22 14:33:51 2019
# Author:      kvu
#------------------------------------------------------
package Hydra::Doc;

use Pod::Man;

use strict;
use warnings;
use Carp;
use Exporter;

our $VERSION = 1.00;
our @ISA     = qw(Exporter);

#------------------------------------------------------
# Global Variables
#------------------------------------------------------
my $glb_flow_module_dir = "$ENV{HYDRA_HOME}/lib/Hydra/Setup/Flow";
my $glb_top_man_dir     = "$ENV{HYDRA_HOME}/man";
my $glb_top_pod_dir     = "$ENV{HYDRA_HOME}/pod";
my %glb_headers = (
  "1" => "1h. Hydra User Commands",
  "2" => "2h. Hydra Commands",
  "3" => "3h. Hydra Setup Parameters",
  "4" => "4h. Hydra Setup Flows",
  "5" => "5h. Hydra File Formats",
    );
my @glb_all_sections = qw(1 2 3 4 5);

#------------------------------------------------------
# Subroutines
#------------------------------------------------------
sub convert_pod_docs {
  # Create man directories
  my @dirs = (
    "man",
    "man/man1",
    "man/man2",
    "man/man3",
    "man/man4",
    "man/man5",
      );
  foreach my $dir (@dirs) {
    &Hydra::Util::File::make_dir($dir);
  }

  # Convert pre-written pod docs
  foreach my $section (@glb_all_sections) {
    my $pod_dir = "${glb_top_pod_dir}/pod${section}h";
    my $man_dir = "${glb_top_man_dir}/man${section}";
    my @files = &Hydra::Util::File::get_dir_files($pod_dir);
    foreach my $file_name (@files) {
      if ($file_name =~ /^(\S+).pod$/) {
        my $name = $1;
        my $parser = new Pod::Man(
          release => $VERSION,
          section => "${section}h",
          center  => $glb_headers{$section},
          name    => $name,
            );
        $parser->parse_from_file("${pod_dir}/${name}.pod", "${man_dir}/${name}.${section}h");
      }
    }
  }

  # Initialize flow dispatcher
  &Hydra::Setup::Flow::initialize_flows();

  # Read param pods
  my %params = &read_param_docs;
  # my %params = ();
  # my $param_pod_dir = "${glb_top_pod_dir}/pod3h";
  # my @param_files = &Hydra::Util::File::get_dir_files($param_pod_dir);
  # foreach my $param_file (@param_files) {
  #   my $flow_name = &Hydra::Util::File::remove_extension($param_file);
  #   my $fh_param = &Hydra::Util::File::open_file_for_read("${param_pod_dir}/${param_file}");
  #   my $cur_param;
  #   while (my $line = <$fh_param>) {
  #     chomp($line);
  #     next if ($line =~ /^\s*$/);

  #     if ($line =~ /^\s*\=head1\s+(\S+)\s*$/) {
  #       $cur_param = $1;
  #     }
  #     elsif (defined $cur_param) {
  #       push(@{ $params{$flow_name}{$cur_param} }, $line);
  #     }
  #   }
  #   &Hydra::Util::File::close_file($fh_param);
  # }

  # Read flows from Hydra library
  my %flows = &read_flows;
  
  # Write flow and param to the same man
  my %param_in_flows = ();
  foreach my $flow_name (keys %flows) {
    my $man_dir = "${glb_top_man_dir}/man4";
    my $parser = new Pod::Man(
      release => $VERSION,
      section => "4h",
      center  => $glb_headers{4},
      name    => $flow_name,
        );

    my $eco_only = "";
    if (&Hydra::Setup::Flow::is_flow_eco_only($flow_name)) {
      $eco_only = "(eco only)";
    }

    my @header_lines = (
      "=head1 NAME",
      "",
      "$flow_name $eco_only",
      "",
        );
    my @flow_lines     = ();
    my @raw_flow_lines = ();
    my @param_lines    = ();
    
    foreach my $tool_name (keys %{ $flows{$flow_name} }) {
      my $aref_lines = $flows{$flow_name}{$tool_name}{std};
      push(@flow_lines, "=head1 FLOW - ${tool_name}");
      push(@flow_lines, "");
      push(@flow_lines, @$aref_lines);
      push(@flow_lines, "");

      my $aref_raw_lines = $flows{$flow_name}{$tool_name}{raw};
      push(@raw_flow_lines, "=head1 FLOW - ${tool_name}");
      push(@raw_flow_lines, "");
      push(@raw_flow_lines, @$aref_raw_lines);
      push(@raw_flow_lines, "");

      # Write param section
      push(@param_lines, "=head1 PARAM - ${tool_name}");
      push(@param_lines, "");
      # Write "HEAD" lines outside individual params but inside param doc
      my $aref_head_lines = $params{$flow_name}{$tool_name}{HEAD};
      if (defined $aref_head_lines) {
        push(@param_lines, @$aref_head_lines);
      }
      push(@param_lines, "");
      push(@param_lines, "=over");
      push(@param_lines, "");
      foreach my $param_name (sort keys %{ $params{$flow_name}{$tool_name} }) {
        next if ($param_name eq "HEAD");
        my $aref_lines = $params{$flow_name}{$tool_name}{$param_name};
        push(@param_lines, "=item B<${param_name}>");
        push(@param_lines, "");
        push(@param_lines, @$aref_lines);
        push(@param_lines, "");

        # Store flows that each param appears in for individual param docs
        $param_in_flows{$param_name}{$flow_name}{$tool_name} = $aref_lines;
      }
      push(@param_lines, "=back");
      push(@param_lines, "");
    }

    my @pod_lines     = (@header_lines, @flow_lines, @param_lines);
    my @raw_pod_lines = (@header_lines, @raw_flow_lines, @param_lines);

    # Convert flow pod to man
    my $fh_temp = &Hydra::Util::File::open_file_for_write(".tmp.pod");
    foreach my $line (@pod_lines) {
      print $fh_temp "$line\n";
    }
    &Hydra::Util::File::close_file($fh_temp);
    $parser->parse_from_file(".tmp.pod", "${man_dir}/${flow_name}.4h");
    unlink(".tmp.pod");

    # Convert raw flow pod to man
    $fh_temp = &Hydra::Util::File::open_file_for_write(".tmp.pod");
    foreach my $line (@raw_pod_lines) {
      print $fh_temp "$line\n";
    }
    &Hydra::Util::File::close_file($fh_temp);
    $parser->parse_from_file(".tmp.pod", "${man_dir}/${flow_name}.raw.4h");
    unlink(".tmp.pod");
  }

  # Write individual param man
  foreach my $param_name (keys %param_in_flows) {
    my $man_dir = "${glb_top_man_dir}/man3";
    my $parser = new Pod::Man(
      release => $VERSION,
      section => "3h",
      center  => $glb_headers{3},
      name    => $param_name,
        );

    my @pod_lines = (
      "=head1 NAME",
      "",
      "$param_name",
      "",
        );

    foreach my $flow_name (keys %{ $param_in_flows{$param_name} }) {
      foreach my $tool_name (keys %{ $param_in_flows{$param_name}{$flow_name} }) {
        my $aref_lines = $param_in_flows{$param_name}{$flow_name}{$tool_name};
        push(@pod_lines, "=head1 FLOW - ${tool_name} ${flow_name}");
        push(@pod_lines, "");
        push(@pod_lines, @$aref_lines);
        push(@pod_lines, "");
      }
    }

    # Convert param pod to man
    my $fh_temp = &Hydra::Util::File::open_file_for_write(".tmp.pod");
    foreach my $line (@pod_lines) {
      print $fh_temp "$line\n";
    }
    &Hydra::Util::File::close_file($fh_temp);
    $parser->parse_from_file(".tmp.pod", "${man_dir}/${param_name}.3h");
    unlink(".tmp.pod");
  }
}

sub clean_man_docs {
  &clean_flow_man;
  foreach my $section (@glb_all_sections) {
    my $man_dir = "${glb_top_man_dir}/man${section}";
    my @files = &Hydra::Util::File::get_dir_files($man_dir);
    foreach my $index (0..$#files) {
      $files[$index] = "${man_dir}/$files[$index]";
    }
    unlink(@files);
  }
}

sub display_man_page {
  my ($command_name, $sub_command) = @_;

  # Check that convert_pod_docs was already run
  if (!-d $glb_top_man_dir || !-f "${glb_top_man_dir}/man1/hydra.1h") {
    &convert_pod_docs;
  }

  foreach my $section (@glb_all_sections) {
    my $file_pattern = "^${command_name}\.${section}";
    if (defined $sub_command && $sub_command eq "raw") {
      $file_pattern = "^${command_name}\.raw\.${section}";
    }

    my $man_dir = "${glb_top_man_dir}/man${section}";
    my @files = &Hydra::Util::File::get_dir_files($man_dir);
    foreach my $file_name (@files) {
      if ($file_name =~ /$file_pattern/) {
        my $file_path = "${man_dir}/${file_name}";
        system("man ${file_path}");
        return;
      }
    }
  }

  die "ERROR: could not find man page for command=${command_name}\n";
}

sub read_param_docs {
  my %params = ();
  my @all_flows = &Hydra::Setup::Flow::get_all_flows;
  foreach my $flow_name (@all_flows) {
    my $module    = &Hydra::Setup::Flow::get_flow_module($flow_name);
    my @all_tools = &Hydra::Setup::Flow::get_all_flow_tools($flow_name);

    foreach my $tool (@all_tools) {
      my $sub_name = &Hydra::Setup::Flow::get_flow_sub_name($flow_name, $tool);
      if (!defined $sub_name) {
        print "sub not found: $flow_name\n";
      }
      
      my $module_file = "${glb_flow_module_dir}/${module}.pm";
      my $fh_module = &Hydra::Util::File::open_file_for_read($module_file);
      my $in_doc = 0;
      my $param_name;
      while (my $line = <$fh_module>) {
        chomp($line);
        next if ($line =~ /^\s*$/);

        if ($line =~ /^\s*=head1\s+${tool}\s+${flow_name}\s*$/) {
          $in_doc = 1;
        }
        if ($line =~ /=back/) {
          $param_name = undef;
          $in_doc     = 0;
        }

        if ($in_doc && $line =~ /=item\s+(\S+)/) {
          $param_name = $1;
        }
        elsif (defined $param_name) {
          push(@{ $params{$flow_name}{$tool}{$param_name} }, $line);
        }
        elsif ($in_doc && $line !~ /(=head1|=over)/) {
          push(@{ $params{$flow_name}{$tool}{HEAD} }, $line);
        }
      }
      &Hydra::Util::File::close_file($fh_module);

      # Add params that were used in this flow but are missing from the doc
      my @param_list = &Hydra::Setup::Flow::parse_self_for_params($module_file, $sub_name);
      foreach my $param_name (@param_list) {
        if (!defined $params{$flow_name}{$tool}{$param_name}) {
          my $desc = "-";
          if ($param_name eq "GLOBAL_design") {
            # Use a global description for GLOBAL_design
            $desc = "The top module name of the design.";
          }

          push(@{ $params{$flow_name}{$tool}{$param_name} }, $desc);
        }
      }
    }
  }

  return %params;
}

sub read_flows {  
  my %flows = ();
  my @all_flows = &Hydra::Setup::Flow::get_all_flows;
  foreach my $flow_name (@all_flows) {
    my $module    = &Hydra::Setup::Flow::get_flow_module($flow_name);
    my @all_tools = &Hydra::Setup::Flow::get_all_flow_tools($flow_name);

    foreach my $tool (@all_tools) {
      my $sub_name = &Hydra::Setup::Flow::get_flow_sub_name($flow_name, $tool);
      if (!defined $sub_name) {
        print "sub not found: $flow_name\n";
      }
      
      my $module_file = "${glb_flow_module_dir}/${module}.pm";
      my @lines = &convert_single_flow_to_manpage($module_file, $sub_name);
      @lines = map { " $_" } @lines;
      $flows{$flow_name}{$tool}{std} = \@lines;

      my @raw_lines = &convert_single_flow_to_manpage_raw($module_file, $sub_name);
      @raw_lines = map{ " $_" } @raw_lines;
      $flows{$flow_name}{$tool}{raw} = \@raw_lines;
    }
  }
  return %flows;
}

sub clean_flow_man {
  my $man_dir = "$ENV{HYDRA_HOME}/man/man4";
  my @files = &Hydra::Util::File::get_dir_files($man_dir);
  foreach my $index (0..$#files) {
    $files[$index] = "${man_dir}/$files[$index]";
  }
  unlink(@files);
}

sub write_flow_man {
  my $module_dir = "$ENV{HYDRA_HOME}/lib/Hydra/Setup/Flow";
  my $man_dir    = "$ENV{HYDRA_HOME}/man/man4";
  &Hydra::Setup::Flow::initialize_flows();
  
  my @all_flows = &Hydra::Setup::Flow::get_all_flows;
  foreach my $flow_name (@all_flows) {
    my $module    = &Hydra::Setup::Flow::get_flow_module($flow_name);
    my @all_tools = &Hydra::Setup::Flow::get_all_flow_tools($flow_name);
    # Write flow to pod, then convert to man
    my $parser = new Pod::Man(
      release => "1",
      section => "4h",
      center  => "Hydra Flows",
      name    => $flow_name,
        );

    my @pod_lines = (
      "=head1 NAME",
      "",
      "$flow_name",
      "",
        );

    foreach my $tool (@all_tools) {
      my $sub_name = &Hydra::Setup::Flow::get_flow_sub_name($flow_name, $tool);
      if (!defined $sub_name) {
        print "sub not found: $flow_name\n";
      }
      
      my $module_file = "${module_dir}/${module}.pm";
      my @lines = &convert_single_flow_to_manpage($module_file, $sub_name);
      
      push(@pod_lines, "=head1 TOOL - ${tool}");
      push(@pod_lines, "");
      push(@pod_lines, @lines);
      push(@pod_lines, "");
    }

    # Create man page converted from pod
    my $fh_temp = &Hydra::Util::File::open_file_for_write(".tmp.pod");
    foreach my $line (@pod_lines) {
      print $fh_temp "$line\n";
    }
    &Hydra::Util::File::close_file($fh_temp);

    $parser->parse_from_file(".tmp.pod", "${man_dir}/${flow_name}.4h");
    unlink(".tmp.pod");
  }
}

sub convert_single_flow_to_manpage_raw {
  my ($module_file, $sub_name) = @_;

  my @lines  = ();
  my $in_sub = 0;
  my $fh_in  = &Hydra::Util::File::open_file_for_read($module_file);
  while (my $line = <$fh_in>) {
    #next if ($line =~ /^\s*\#/);
    chomp($line);
    if ($line =~ /^\s*sub\s+${sub_name}\s+\{/) {
      $in_sub = 1;
    }
    elsif ($line =~ /^\s*sub\s+/ || $line =~ /^\s*\=pod/ || $line =~ /^\s*\#\+\+/) {
      $in_sub = 0;
    }
    next if (!$in_sub);

    push(@lines, $line);
  }
  &Hydra::Util::File::close_file($fh_in);

  return @lines;
}

sub convert_single_flow_to_manpage {
  my ($module_file, $sub_name) = @_;

  my %param_vars = ();
  my @lines      = ();
  my $if_level   = 0;
  my $in_sub     = 0;
  my $package_name = "";
  my $fh_in = &Hydra::Util::File::open_file_for_read($module_file);
  while (my $line = <$fh_in>) {
    next if ($line =~ /^\s*\#/);
    chomp($line);
    if ($line =~ /^\s*package\s+(\S+?)\;/) {
      $package_name = $1;
    }

    if ($line =~ /^\s*sub\s+${sub_name}\s+\{/) {
      $in_sub = 1;
    }
    elsif ($line =~ /^\s*sub\s+/) {
      $in_sub = 0;
    }
    next if (!$in_sub);

    if ($line =~ /\&([^\s\(\)]+)\(/) {
      # Call to subflow
      my $sub_name = $1;
      if ($sub_name !~ /\:\:/) {
        $sub_name = "${package_name}::${sub_name}";
      }

      my ($flow_name, $tool) = &Hydra::Setup::Flow::get_flow_from_sub_name($sub_name);
      if (defined $flow_name && defined $tool) {
        push(@lines, "SUBFLOW: $flow_name $tool");
      }
    }

    if ($line =~ /my\s+\$(\S+)\s+\=\s+.*get_param_value\(\"(\S+)\"/) {
      # Call to get_param_value
      $param_vars{$1} = $2;
    }
    elsif ($line =~ /my\s+\@(\S+)\s+\=\s+.*get_param_keysets\(\"(\S+)\"/) {
      # Call to get_param_keysets
      $param_vars{$1} = $2;
    }
    elsif ($line =~ /\$line\s+\.\=.*EOF/) {
      # Sprintf into line
      while ($line = <$fh_in>) {
        chomp($line);
        last if ($line =~ /EOF/);
        while ($line =~ /\$([0-9A-Za-z_{}]+)/g) {
          my $orig_var = $1;
          my $var      = $orig_var;
          $var =~ s/({|})//g;
          if (defined $param_vars{$var}) {
            $line =~ s/\$\Q$orig_var\E/<$param_vars{$var}>/;
          }
        }

        $line =~ s/\\n//g;
        push(@lines, "  " x $if_level . $line);
      }
    }
    elsif ($line =~ /\$line\s+\.\=.*write_source_catchall.*\"(\S+)\"/) {
      # Call to write_source_catchall
      my $prefix = $1;
      push(@lines, "  " x $if_level . "source <${prefix}_source_catchall_global>");
      push(@lines, "  " x $if_level . "source <${prefix}_source_catchall_local>");
      push(@lines, "");
    }
    elsif ($line =~ /\$line\s+\.\=.*write_repeating_param.*?\"(.*?)\"\s*\,\s*\$([0-9A-Za-z_{}]+)/) {
      # Call to write_repeating param
      my $command = $1;
      my $var     = $2;
      if (defined $param_vars{$var}) {
        push(@lines, "  " x $if_level . "$command <$param_vars{$var}>");
      }
    }
    elsif ($line =~ /\$line\s+\.\=\s+\"(.*)\"/) {
      # Line append
      my $string = $1;
      while ($string =~ /\$([0-9A-Za-z_{}]+)/g) {
        my $orig_var = $1;
        my $var      = $orig_var;
        $var =~ s/({|})//g;
        if (defined $param_vars{$var}) {
          $string =~ s/\$\Q$orig_var\E/<$param_vars{$var}>/;
        }
      }

      $string =~ s/\\n//g;
      push(@lines, "  " x $if_level . $string);
    }
    elsif ($line =~ /if\s*\(.*(has_value|is_on).*\$([0-9A-Za-z_{}]+)/) {
      # Call to has_value or is_on
      my $if_type = $1;
      my $var     = $2;
      next if ($var eq "enable_scenario");
      if (defined $param_vars{$var}) {
        push(@lines, "  " x $if_level . "[if $if_type <$param_vars{$var}>]");
        #$if_level++;
      }
    }
    elsif ($line =~ /next\s+if\s+\(\!\$scenario_tags\{(\S+)\}\)/) {
      # Skip scenario without the target tag
      my $tag = $1;
      push(@lines, "  " x $if_level . "[skip <SCENARIO> without tag \"$tag\"]");
    }
    elsif ($line =~ /if\s*\(\$(\S+)\s+\=\~\s+\/(.+)\/\)/) {
      # Regex search on a param value
      my $var     = $1;
      my $pattern = $2;
      if (defined $param_vars{$var}) {
        push(@lines, "  " x $if_level . "[if <$param_vars{$var}> has ($pattern)]");
      }
    }
    elsif ($line =~ /foreach.*keys.*\(\@(\S+)\)/) {
      # Foreach on param value
      my $var = $1;
      if (defined $param_vars{$var}) {
        push(@lines, "  " x $if_level . "[foreach keys <$param_vars{$var}>]");
      }
    }
    elsif ($line =~ /if\s*\(.*sub_?type\s+eq\s+\"(\S+)\"/) {
      # Check subtype to branch flow
      push(@lines, "  " x $if_level . "[if is_subtype \"$1\"]");
    }
    elsif ($line =~ /foreach.*split.*\$([^\s\(\)]+)\)/) {
      # Foreach on split-by-whitespace param value
      my $var = $1;
      if (defined $param_vars{$var}) {
        push(@lines, "  " x $if_level . "[foreach <$param_vars{$var}>]");
      }
    }
    elsif ($line =~ /else/) {
      push(@lines, "  " x $if_level . "[else]");
      #$if_level++;
    }

    if ($line =~ /(\)|else)\s*\{/) {
      $if_level++;
    }
    elsif ($line =~ /^\s*\}\s*$/) {
      $if_level--;
    }
  }
  &Hydra::Util::File::close_file($fh_in);

  return @lines;
}

1;
