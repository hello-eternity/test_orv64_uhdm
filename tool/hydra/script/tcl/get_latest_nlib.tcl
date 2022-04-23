proc sort_nlibs {a b} {
  regexp {eco(\d+)([A-Za-z]+)?} $a a_num a_let
  regexp {eco(\d+)([A-Za-z]+)?} $b b_num b_let

  if {$a_num == $b_num} {
    set largest [lindex [lsort -decreasing -ascii {$a_let $b_let}] 0]
    if {$a_let == $b_let} {
      return 0;
    } elseif {$a_let == $largest} {
      return 1;
    } elseif {$b_let == $largest} {
      return -1;
    }
  } elseif {$a_num < $b_num} {
    return -1;
  } elseif {$a_num > $b_num} {
    return 1;
  }
}

proc get_latest_nlib {} {
  set nlibs [glob -type d db/*eco*.nlib]
  set sorted [lsort -decreasing -command sort_nlibs $nlibs]
  set target_nlib [lindex $sorted 0]
  echo "INFO: Using latest nlib: $target_nlib"
  return $target_nlib
}
