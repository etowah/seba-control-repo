#!/bin/bash

imagelist=$1

if [ -z "$imagelist" ]
then
  echo "Usage $0 <docker-image-list-file>"
  exit 1
fi

mkdir -p docker-images

for i in $(cat $imagelist)
do
  echo $i
  docker pull $i
  filename=$(echo $i|sed 's/[/,:]/-/g')
  docker save $i > docker-images/$filename.tar
done
