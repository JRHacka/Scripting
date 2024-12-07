#!/bin/bash
## This script is meant to automate the GIT process. 

check_filename() {
	while true; do
		# Get user input for filename and commit comment
		read -p "What needs added? " filename
		read -p "What do you want the commit comment to say? " commitcomment

		# Check if the file exists an if so push it to github
		if [ -f $filename ]; then
			echo "Git adding $filename"
			git add $filename
			sleep .5s
			echo "Done. Now adding the commit comment"
			git commit -m "$commitcomment"
			sleep .5s
			echo "Done. Now adding to the main branch. Please enter your usernmae and password below."
			git branch -M main
			git push -u origin main
			break
		# If the file doesn't exist try again
		else
			echo "The file $filename does not exist. Please try again."
			echo "Here are your options:"
			ls -t
			sleep 5s
		fi
	done
}

# Call the function
check_filename

