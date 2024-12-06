#!/bin/bash
#A script to automate my nmap scanning 
filelocal="$HOME/TargetScans/"
cur_date="$( date '+%F_%H:%M:%S' )"

# If storage directory exists run nmap scan
check_directory() {
	while true; do
		#Get user input
		read -p "What IP would you like to target?" ipaddy

		if [ -d $filelocal ]; then
			echo "Running an nmap scan against $ipaddy"
			nmap -sT -sV -Pn -p- -A -T3 $ipaddy -oN "$filelocal""$ipaddy""$cur_date"
			echo "NMAP scan complete, and results are stored here:"
			echo "$filelocal"$ipaddy""$cur_date""
			break
		else
			echo "The directory did not exist, but has been created."
			mkdir $filelocal
		fi
	done
}

#Call our function
check_directory
