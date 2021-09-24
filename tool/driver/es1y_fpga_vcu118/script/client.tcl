set sockChan [socket localhost 9900]
#gets $sockChan line
fconfigure $sockChan -translation binary
set x 0x0401234567890123456789abcdef0000
puts -nonewline $sockChan $x
#gets $sockChan ack
#set ack [read $sockChan 34]
#puts $ack
close $sockChan
#puts "Client: $line"
