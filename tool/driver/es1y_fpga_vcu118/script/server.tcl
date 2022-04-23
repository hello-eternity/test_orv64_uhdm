proc do_command {channel} {
  #gets $channel message
  set message [read $channel 16]
  binary scan $message H* decoded
  set message $decoded
  #puts $message

  # Get instruction
  set instr [string range $message 0 1]
  #puts $instr

  # Get address
  set addr [string range $message 2 11]
  #puts $addr

  # Get length
  set len ""
  set data ""
  if {[string equal $instr "06"]} {
    # Get length field for burst-write command
    set len [string range $message 12 15]
    set len [format "%i" 0x$len]
    #puts $len
  } elseif {[string equal $instr "04"]} {
    # Get data field for write command
    set data1 [string range $message 12 19]
    set data2 [string range $message 20 27]
    set data ""
    append data $data1 "_" $data2
  }

  # Prepare read data
  set read_data ""

  if {[string equal $instr "04"]} {
    # Write
    create_hw_axi_txn wr [get_hw_axis hw_axi_1] -force -type write -address $addr -data [list $data]
    #report_property [get_hw_axi_txns wr]
    run_hw_axi [get_hw_axi_txns wr]
    delete_hw_axi_txn [get_hw_axi_txns wr]
  } elseif {[string equal $instr "05"]} {
    # Read
    create_hw_axi_txn rd [get_hw_axis hw_axi_1] -force -type read -address $addr
    #report_property [get_hw_axi_txns rd]
    run_hw_axi [get_hw_axi_txns rd]
    set rd_prop [report_property -return_string [get_hw_axi_txns rd]]
    regexp {DATA\s+string\s+false\s+([0-9A-Fa-f]+)} $rd_prop match read_data
    delete_hw_axi_txn [get_hw_axi_txns rd]
  } elseif {[string equal $instr "06"]} {
    # Burst write
    # Send ack for first packet
    set ack "00000000000000000000000000000000"
    set encoded [binary format H* $ack]
    set ack $encoded
    puts -nonewline $channel $ack
    if {[catch {flush $channel} err]} {
      puts "Channel $channel closed"
      close $channel
      return
    }

    # Get second packet for data
    set data [read $channel [expr $len * 8]]
    binary scan $data H* decoded
    set data $decoded

    # Prepare dma for burst write
    set addr [format "%016x" 0x$addr]
    create_hw_axi_txn dma0 [get_hw_axis hw_axi_1] -type write -address 0x005004e0 -data [list $addr] -force
    create_hw_axi_txn dma1 [get_hw_axis hw_axi_1] -type write -address 0x005004e8 -data {00000000_00000002} -force
    run_hw_axi [get_hw_axi_txns dma0]
    run_hw_axi [get_hw_axi_txns dma1]
    delete_hw_axi_txn [get_hw_axi_txns dma0]
    delete_hw_axi_txn [get_hw_axi_txns dma1]

    # Burst write
    create_hw_axi_txn wr [get_hw_axis hw_axi_1] -force -type write -address 0x005004f0 -len $len -data [list $data]
    #report_property [get_hw_axi_txns wr]
    run_hw_axi [get_hw_axi_txns wr]
    delete_hw_axi_txn [get_hw_axi_txns wr]
  }

  if {[string equal $instr "05"]} {
    # Send data back if command was read
    set ack ""
    append ack $instr $addr $read_data "0000"
    set encoded [binary format H* $ack]
    set ack $encoded
  } else {
    # Send ack if command was write or burst_write
    set ack "00000000000000000000000000000000"
    set encoded [binary format H* $ack]
    set ack $encoded
  }

  puts -nonewline $channel $ack
  if {[catch {flush $channel} err]} {
    puts "Channel $channel closed"
    close $channel
  }
}

proc Server {channel clientaddr clientport} {
  puts "Channel $channel opened"
  fconfigure $channel -translation binary
  fileevent $channel readable [list do_command $channel]
}

# Connect to board
open_hw
connect_hw_server -url TCP:localhost:3121
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/210308ABAD26]
set_property PARAM.FREQUENCY 15000000 [get_hw_targets */xilinx_tcf/Digilent/210308ABAD26]
open_hw_target
set_property PROGRAM.FILE $env(PROJ_ROOT)/hardware/soc/bitfile/pygmy_es1y_fpga_vcu118.bit [get_hw_devices xcvu9p_0]
set_property PROBES.FILE $env(PROJ_ROOT)/hardware/soc/bitfile/pygmy_es1y_fpga_vcu118.ltx [get_hw_devices xcvu9p_0]
set_property FULL_PROBES.FILE $env(PROJ_ROOT)/hardware/soc/bitfile/pygmy_es1y_fpga_vcu118.ltx [get_hw_devices xcvu9p_0]
current_hw_device [get_hw_devices xcvu9p_0]
refresh_hw_device [lindex [get_hw_devices xcvu9p_0] 0]
program_hw_devices [get_hw_devices xcvu9p_0]
refresh_hw_device [lindex [get_hw_devices xcvu9p_0] 0]
#open socket_server
socket -server Server 8900
vwait forever
