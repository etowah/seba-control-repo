#Given a list of apt packages before and after installing a set of apt packages (apt list --installed)
#Run this with the two files as arguments to generate a list of packages that can be used to populate a repo

diff $1 $2 --suppress-common-lines | grep -v "^[0-9c0-9]" | awk '{print $2 " " $3 " " $4 " " $5}' | sed -r  's/ \[.*?\]//g' | sed -r 's/(^.*?)\/.*?[ ](.*?)[ ](.*?)$/\1:\3=\2/g' 
