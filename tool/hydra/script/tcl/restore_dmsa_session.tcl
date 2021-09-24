# restore_dmsa_session.tcl - create scenarios from a directory of saved sessions
# chrispy@synopsys.com
#
# v1.0  07/13/2006  chrispy
#  initial release

proc restore_dmsa_session {args} {
 parse_proc_arguments -args $args results

 if {[set dirs [glob -nocomplain -type f $results(dir_name)/*/lib_map]] eq {}} {
  echo "Error: no save_session directories found."
  return 0
 }
 
 foreach dir $dirs {
  set dir [file dirname $dir]
  echo "Defining scenario '[set name [file tail $dir]]'."
  create_scenario -name $name -image $dir
 }
}

define_proc_attributes restore_dmsa_session \
 -info "Restores PrimeTime sessions in DMSA" \
 -define_args \
 {
  {dir_name "Directory name to restore from" "dir_name" string required}
 }
