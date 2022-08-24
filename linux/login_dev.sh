set user root
set host 192.168.7.253
set port 22
set password youpassword


spawn ssh -o StrictHostKeyChecking=no $user@$host -p $port
expect "*password:"

send "$password\r"

#控制权移交
interact
