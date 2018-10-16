#!/bin/bash

imagedir=$1

if [ -z "$imagedir" ]
then
  echo "Usage $0 <directory-with-docker-image-tarballs>"
  exit 1
fi

for i in $(ls -1 $imagedir)
do
  echo $i
  docker image load -i $imagedir/$i
done
