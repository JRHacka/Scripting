#!/bin/bash
## This script is meant to automate the GIT process. 

# automate the git pull
sync_files() {
	while true; do
		# Get user input for if they would like to sync first
		read -p "Do you want to sync your files before starting?" yesorno

		# Check if the answer is yes
		if [ "$yesorno" == "yes" ]; then
			echo "Syncing the repository."
			git pull
			break
		elif [ "$yesorno" == "no" ]; then
			echo "Thank you."
			break
		else
			echo "Invalid response please choose yes or no as an answer."
		fi
	done
}


# automate the git push process
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

# Call the correct function
figlet "Automatic GIT Script" | lolcat -a -s 100 | boxes -d bear
echo "Do you want to sync the repository or are you ready to push changes?"
read -p "Choose Pull or Push: " pullorpush

if [ "$pullorpush" = "Push" ]; then
	check_filename
elif [ "$pullorpush" = "Pull" ]; then
	sync_files
else
	echo "Invalid choice."
fi

