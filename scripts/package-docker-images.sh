#!/bin/bash

imagelist=$1
destdir=$2

if [ -z "$imagelist" ] || [ -z "$destdir" ]
then
  echo "Usage $0 <docker-image-list-file> <destination-directory>"
  exit 1
fi

mkdir -p $destdir

for i in $(cat $imagelist)
do
  echo $i
  docker pull $i
  filename=$(echo $i|sed 's/[/,:]/-/g')
  docker save $i > $destdir/$filename.tar
done
