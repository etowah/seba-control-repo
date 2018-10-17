DEPENDENCIES=`apt-cache depends $1 | grep 'Depends' | awk '{print $2}'`
printf "$DEPENDENCIES\n$1"
