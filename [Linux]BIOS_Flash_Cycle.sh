#!/bin/bash
set -e

FW1="../NP3020M7-C252_BIOS_02.02.00_Standard_20220906.ROM"
FW2="../NP3020M7-C252_BIOS_02.02.00_Standard_20220906.ROM"
round="10"
###################### User Input ############################


today=$(date)

if [ -f "count.txt" ]; then
	count=$(tail count.txt)
else
	echo 0 >> count.txt
fi


count=$(tail count.txt)


if [ "$count" -ge "$round" ];then
	echo "Count Expect !!!!!!"
	exit	
fi



if [ $(($count%2)) -eq 0 ];then
	
	incount=$(($count+1))
	echo "Count : $incount" | tee -a log.txt
	echo  $today  >> log.txt
	echo  $(./afulnx_64 $FW1 /P /B /N /R)  | tee -a log.txt
	# echo    $(ls)  | tee -a log.txt
	BIOSVersion=$(sudo dmidecode -s bios-version)
	echo  "BIOSVersion: "  $BIOSVersion  >> log.txt
	echo $incount > count.txt
	# echo "FW1 Flash Successfully!!"
	echo "BIOSVersion: "  $BIOSVersion
	sleep  60s 
	init 6
	echo  "----------------------------------"  >> log.txt


elif [ $(($count%2)) -eq 1 ] ;then
	incount=$(($count+1))
	echo "Count : $incount" | tee -a log.txt
	echo  $today  >> log.txt
	echo  $(./afulnx_64 $FW2 /P /B /N /R)  | tee -a log.txt
	# echo    $(ls)  | tee -a log.txt
	BIOSVersion=$(sudo dmidecode -s bios-version)
	echo  "BIOSVersion: "  $BIOSVersion  >> log.txt
	echo $incount > count.txt
	# echo "FW2 Flash Successfully!!"
	echo "BIOSVersion: "  $BIOSVersion
	sleep  60s 
	init 6
	echo  "----------------------------------"  >> log.txt
fi
#done

