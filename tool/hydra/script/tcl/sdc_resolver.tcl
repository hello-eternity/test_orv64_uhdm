proc create_clock {args} {
  foreach element $args {
    puts $element
  }
}

proc create_generated_clock {args} {
  foreach element $args {
    puts $element
  }  
}

proc resolve_args {args} {
  foreach element $args {
    puts $element
  }
}

proc get_pins {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRAPIN\$${element}"
  }
  return [join $val " "]
}

proc get_pin {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRAPIN\$${element}"
  }
  return [join $val " "]
}

proc get_ports {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRAPORT\$${element}"
  }
  return [join $val " "]
}

proc get_port {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRAPORT\$${element}"
  }
  return [join $val " "]
}

proc get_clocks {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRACLOCK\$${element}"
  }
  return [join $val " "]
}

proc get_clock {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRACLOCK\$${element}"
  }
  return [join $val " "]
}

proc get_cells {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRACELL\$${element}"
  }
  return [join $val " "]
}

proc get_cell {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRACELL\$${element}"
  }
  return [join $val " "]
}

proc get_nets {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRANET\$${element}"
  }
  return [join $val " "]
}

proc get_net {args} {
  set val [list]
  foreach element $args {
    lappend val "HYDRANET\$${element}"
  }
  return [join $val " "]
}

proc current_design {} {
  return "\[current_design\]"  
}
