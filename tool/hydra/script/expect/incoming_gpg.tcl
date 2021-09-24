#!/usr/bin/expect -f

if {[llength $argv] != 3} {
  puts "Usage: hydra incoming_gpg <USER> <GPGFILE> <GPGPASS>"
  exit
}

set user     [lindex $argv 0]
set gpgfile  [lindex $argv 1]
set pass     [lindex $argv 2]
set tgzfile  [regsub {\.gpg$} $gpgfile ""]
set dirname  [regsub {\..*?$} $tgzfile ""]
set cur_user $::env(USER)

if [file exists $tgzfile] {
  file delete $tgzfile
}

# Download from FTP
set timeout -1
spawn ftp ftp-asia.synopsys.com
match_max 100000
expect "Name (ftp-asia.synopsys.com:$cur_user): "
send -- "$user\r"
expect "Password:"
stty -echo
expect_user -timeout 3600 -re "(.*)\[\r\n]"
stty echo
send "$expect_out(1,string)\r"
expect "ftp> "
send -- "binary\r"
expect "ftp> "
send -- "cd /pub/outgoing\r"
expect "ftp> "
send -- "get $gpgfile\r"
expect "ftp> "
send -- "quit\r"
expect eof

# Move to directory
if ![file isdirectory $dirname] {
  file mkdir $dirname
}
file rename -force $gpgfile "$dirname/$gpgfile"
cd $dirname

# Decrypt gpg file
set timeout -1
spawn gpg --batch --passphrase-fd 0 --output $tgzfile --decrypt $gpgfile
match_max 100000
send -- "$pass\r"
expect eof

# Untar gzipped tarball
set file_type [exec file -b --mime-type $tgzfile]
if {$file_type == "application/x-tar"} {
  spawn tar -xvf $tgzfile
} elseif {$file_type == "application/x-gzip"} {
  spawn tar -xvzf $tgzfile
}
expect eof

# Delete everything
file delete -force $tgzfile
file delete -force $gpgfile

cd ..
