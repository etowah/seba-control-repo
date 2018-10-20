#This can be used to build and apt repo from a set of files. 
#The files used to build the current version are stored in the apt-mirror-lists folder
#Copy this and the lists files into the same directory, then run this to generate a mirror

ls install-*.list | xargs cat | xargs apt download 
dpkg-scanpackages -m . /dev/null | gzip -9c >  Packages.gz
