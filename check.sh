#!/usr/local/bin/expect -f

set output [lindex $argv 0]
set ipaddress [lindex $argv 1]
set user [lindex $argv 2]
set pass [lindex $argv 3]

log_file -noappend $output

set timeout 10

#spawn telnet $ipaddress
#spawn ssh -p 5122 $user@$ipaddress
spawn ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null cli@$ipaddress
expect {
 "*assword:" {
 send -- "cli\r"
 exp_continue
}
 "*name:" {
 send -- "$user\n"
 expect "*assword:"
 send -- "$pass\n"
# interact
}
}
expect -- "Do you acknowledge? (Y/N)?"
send -- "Y\n"
expect "*#"
send -- "pag st dis\n"
expect "*#"
send -- "show card inventory *\n"
expect "*#"
sleep 1
send -- "sh int powermgmt *\n"
expect "*#"
sleep 1
send -- "pag st ena\n"
expect "*#"
send -- "lo\n"
expect eof
