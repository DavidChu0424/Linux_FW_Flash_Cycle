#!/bin/bash

# Code By David_Zhu
# Run this script need to set the "Startup Application" and "Sudo Password bypass" first. 


set -e
###################### User Input ############################

FW1="NP3020M7-C252_BIOS_02.02.00_Standard_20220906.ROM"
FW2="NP3020M7-C252_BIOS_02.02.00_Standard_20220906.ROM"
round="10"

###################### User Input ############################

passresult=" Process completed."
today=$(date)

if [ -f "count.txt" ]; then
	count=$(tail count.txt)
else
	echo 0 >> count.txt
fi


count=$(tail count.txt)
BIOSVersion=$(sudo dmidecode -s bios-version)


if [ "$count" -ge "$round" ];then
	echo "Count Expect !!!!!!"
	exit	
fi



if [ $(($count%2)) -eq 0 ];then
	incount=$(($count+1))
	echo "Count : $incount"
	echo "Count : $incount"  >>  log.txt
	echo  $today  >> log.txt

	echo "Count : $incount"  >>  FullLog.txt
	echo  $today  >> FullLog.txt

	sudo ./afulnx_64 $FW1 /P /B /N /R | tee buffer.txt | tee -a FullLog.txt
	grep "Done" buffer.txt >> log.txt -v
	result=$(grep "Process completed." buffer.txt)
	rm buffer.txt
	# result=$(ls)  >> log.txt
	# echo  $result >> log.txt
	# echo    $(ls)  | tee -a log.txt
	echo $incount > count.txt



elif [ $(($count%2)) -eq 1 ] ;then
	incount=$(($count+1))
	echo "Count : $incount"
	echo "Count : $incount"  >>  log.txt
	echo  $today  >> log.txt

	echo "Count : $incount"  >>  FullLog.txt
	echo  $today  >> FullLog.txt

	sudo ./afulnx_64 $FW2 /P /B /N /R | tee buffer.txt | tee -a FullLog.txt
	grep "Done" buffer.txt >> log.txt -v
	result=$(grep "Process completed" buffer.txt)
	rm buffer.txt
	# result=$(ls)  >> log.txt
	# echo  $result >> log.txt
	# echo    $(ls)  | tee -a log.txt
	echo $incount > count.txt

fi



if [ "$passresult" != "$result" ];then
	echo "Flash Fail!!!"
	exit
else
	echo "FW Flash Check Pass, Continue Next Round !!"
fi




echo "BIOSVersion: "  $BIOSVersion
echo  "BIOSVersion: "  $BIOSVersion  >> log.txt
echo  "----------------------------------"  >> log.txt

echo  "BIOSVersion: "  $BIOSVersion  >> FullLog.txt
echo  "----------------------------------"  >> FullLog.txt


sleep  120s 
init 6

#done

