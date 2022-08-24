#!/bin/bash
# show all host infos of serverList.txt
if [[ -f ~/.iplist ]]
then
	hostNum=`cat ~/.iplist | wc -l`
else
	echo "No iplist in dir, please create it and add server infos."
	exit
fi
while [ True ] 
do
	echo -e "+++++++++++ Host List ++++++++++++++++"
	awk -F' ' 'BEGIN {print "ID\tServerName\tUser@ServerIp"}{printf("%2d\t%-10s\t%s@%s\n", NR,$1,$2,$3)}'  ~/.iplist
	echo -e "\nEnter hostID at first column."
	echo -e "Enter q or Q to quit." 
	read hostID
	if [[ "$hostID" == 'q' ]] || [[ "$hostID" == 'Q' ]]
	then
		exit 
	elif [[ $hostID -lt 1 ]] || [[ $hostID -gt $hostNum ]]
	then
		echo "Wrong hostID is selected, Only $hostNum hosts are listed, please check."
		continue
	else
		break
	fi
done
servername=""
user=""
host=""
passwd=""
eval $(awk -v hostID=$hostID -F' ' '{if (NR==hostID) {printf("servername=%s;user=%s;host=%s;passwd=%s;",$1,$2,$3,$4);}}'  ~/.iplist) 
#echo $user, $host, $passwd
echo "logining $servername by $user@$host"


expect -c "
set timeout -1
spawn ssh $user@$host
expect \"password:\"; send $passwd\r
interact
"
