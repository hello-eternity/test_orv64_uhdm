#!/usr/bin/expect -f

if {[llength $argv] != 3} {
  puts "Usage: hydra incoming <USER> <DIR> <SSLPASS>"
  exit
}

set user    [lindex $argv 0]
set dir     [lindex $argv 1]
set sslpass [lindex $argv 2]

# Download from SFTP
set timeout -1
spawn sftp $user@ftp-china.synopsys.com
match_max 100000
expect -exact "$user@ftp-china.synopsys.com's password: "
stty -echo
expect_user -timeout 3600 -re "(.*)\[\r\n]"
stty echo
send "$expect_out(1,string)\r"
expect -exact "\r
Connected to ftp-china.synopsys.com.\r
sftp> "
send -- "cd outgoing\r"
expect -exact "cd outgoing\r
sftp> "
send -- "mget -r $dir"
expect -exact "$dir"
send -- "\r"
expect "sftp>"
send -- "exit\r"
expect eof

# Unencrypt .enc file
cd $dir
set encfile [glob "*.{tar.gz,tgz}.enc"]
set tgzfile [regsub ".enc" $encfile ""]
spawn openssl enc -aes-256-cbc -md sha256 -salt -in $encfile -out $tgzfile -d -pass pass:$sslpass
expect eof
if [file exists "../$tgzfile"] {
  file delete "../$tgzfile"
}
file rename $tgzfile "../$tgzfile"

# Untar gzipped tarball
cd ".."
set file_type [exec file -b --mime-type $tgzfile]
if {$file_type == "application/x-tar"} {
  spawn tar -xvf $tgzfile
} elseif {$file_type == "application/x-gzip"} {
  spawn tar -xvzf $tgzfile
}
expect eof

# Check MD5
set thishash [lindex [exec md5sum $tgzfile] 0]
set refhash [lindex [exec cat "$dir/$tgzfile.md5"] 0]
if {$thishash != $refhash} {
  puts "WARN: MD5 does not match"
}

# Delete everything
file delete -force $tgzfile
file delete -force $dir
