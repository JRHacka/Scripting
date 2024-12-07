#!/bin/bash
#A script to automate my nmap scanning 
filelocal="$HOME/TargetScans/"
cur_date="$( date '+%F_%H:%M:%S' )"
read -p "What directory name would you like to use for this data?" dirname
read -p "What IP would you like to target?" ipaddy

# If storage directory exists run nmap scan
check_directory() {
	while true; do
		#Get user input

		if [ -d $filelocal$dirname ]; then
			echo "Running an nmap scan against $ipaddy"
			nmap -sT -sV -Pn -p- -A -T3 $ipaddy -oN "$filelocal""$dirname"/"$ipaddy""$cur_date"
			echo "NMAP scan complete, and results are stored here:"
			echo "$filelocal""$dirname"/"$ipaddy""$cur_date"
			break
		else
			echo "The directory did not exist, but has been created."
			mkdir $filelocal$dirname
		fi
	done
}

#Call our function
check_directory

# Add logic to run nslookup(potentially rename file something more useful is the goal),
# dirbuster, and create a more specific directory
