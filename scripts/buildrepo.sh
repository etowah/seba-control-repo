#!/bin/bash

#This can be used to build and apt repo from a set of files. 
#The files used to build the current version are stored in the apt-mirror-lists folder

listdir=$1
packagedir=$2
currentdir=$(pwd)

if [ -z "$listdir" ] || [ -z "$packagedir" ]
then
  echo "$0 <directory-apt-mirror-lists> <pkg-output-dir>"
  exit 1
fi

for i in $(ls -1 $listdir/install-*.list)
do
  echo "List: $i"

  pkglist=$(cat $i)

  cd $packagedir
  for j in $pkglist
  do
    echo "Package: $j"
    apt download $j
  done
  cd $currentdir
done

set -x
dpkg-scanpackages -m $packagedir /dev/null | gzip -9c >  $packagedir/Packages.gz
