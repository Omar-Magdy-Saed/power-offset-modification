#!/bin/sh

path=`pwd`
file1=$path/check.sh        #directory cli script
ip_file=$path/ip.txt
user=root # debug login user
guiuser=admin # WebUI login user
# output_file=$path/out.txt      # output files
csv_file=$path/csv.txt
file2=$path/cli.sh        #directory cli script
file3=$path/dbread.txt
file4=$path/update.sh
file5=$path/fwstatus.sh
output_dir=$path/out
# > $output_file
> $csv_file
/usr/Systems/OTNE_1/script/dbread_pdu |grep '1830PSS-PHN' > $file3  # this line to retriving the OTE data base for all phtonic NEs to store there IP address and node id in dbread.txt file



InvProc () {
cat $ip_file | while read ip 
do
# ip variable bug fix
node_id=`grep "\b$ip\b" $file3 | awk '{print $2}'`
   $file1 $output_dir/$ip.$node.cli $ip $guiuser $guipass
#Report
done
}

ScanProc () {
echo $ip_file
#start cli session to get the shelf config
cat $ip_file | while IFS=, read -r ip shelf slot
do
   #start file
echo $ip $shelf $slot
$file2 $output_dir/$ip-$shelf-$slot.cli $ip $shelf $slot $guiuser $guipass
done
}


#read input
echo
echo "1830 PSS poweroffset Audit & Update script"
echo
echo Please enter NE WEBUI credential :
IFS= read -rs webui_pass
guipass="$webui_pass"
echo
echo Please enter Action type :  "scan" or "update":
read action_type
echo ActionType : $action_type

if [ $action_type == "scan" ]; then
InvProc
elif [ $action_type == "update" ]; then
ScanProc
else
 echo "no action performed"
fi;
exit;
exit;
