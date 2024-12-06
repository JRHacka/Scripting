#!/bin/bash
## This script is meant to automate the GIT process. 
read -p "What needs added? " addthis
read -p "What do you want the commit comment to say? " commitcomment

echo "Git adding $addthis"
git add $addthis
sleep .5s
echo "Done. Now adding the commit comment"
git commit -m "$commitcomment"
sleep .5s
echo "Done. Now adding to the main branch. Please enter your usernmae and password below."
git branch -M main
git push -u origin main
