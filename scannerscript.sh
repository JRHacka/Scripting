#!/bin/bash
#A script to automate my nmap scanning 
filelocal="$HOME/TargetScans/"
cur_date="$( date '+%F_%H:%M:%S' )"

figlet "Scanner Script" | lolcat -a -s 100 | boxes -d parchment
read -p "What directory name would you like to use for this data?" dirname
read -p "What IP would you like to target?" ipaddy

# If storage directory exists run nmap scan
check_directory() {
	while true; do
		#Get user input

		if [ -d $filelocal$dirname ]; then
			echo "Running an nmap scan against $ipaddy"
			nmap -sT -sV -Pn -p- -A -T3 $ipaddy -oN "$filelocal""$dirname"/"nmap_""$ipaddy""_""$cur_date" &
			pid=$!
			while kill -0 $pid 2>/dev/null; do
			    chars="/—\|"
			    i=0
			    while kill -0 $pid 2>/dev/null; do
			        printf "\r${chars:i++%4:1}"
			        sleep 0.15
			    done
			done
			echo "NMAP scan complete, and results are stored here:"
			echo "$filelocal""$dirname"/"nmap_""$ipaddy""_""$cur_date"
			wfuzz -c -z file,/usr/share/wfuzz/wordlist/general/common.txt --hc 404 http://"$ipaddy"/FUZZ > "$filelocal""$dirname"/"wfuzz_""$ipaddy""_""$cur_date"
			echo "WFUZZ scan complete, and results are stored here:"
			echo "$filelocal""$dirname"/"wfuzz_""$ipaddy""_""$cur_date"
			break
		else
			echo "The directory did not exist, but has been created."
			mkdir -p $filelocal$dirname
		fi
	done
}

#Call our function
check_directory

#Need to figure out how to create target scans directory ifit doesn't exist. Will create the dirname variable but not file_local