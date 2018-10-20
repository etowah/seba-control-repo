#!/bin/bash

imagelist=$1

if [ -z "$imagelist" ]
then
  echo "$0 <image-list-file>"
  exit 1
fi


for i in $(cat $imagelist)
do 
  echo $i
  docker pull $i

  if echo $i | grep --quiet foundry; 
  then
    shortname=$(echo $i | cut -d'/' -f2)
    docker tag $i docker-repo.seba.local:5000/voltha/$shortname
    docker push docker-repo.seba.local:5000/voltha/$shortname
  else
    docker tag $i docker-repo.seba.local:5000/$i
    docker push docker-repo.seba.local:5000/$i
  fi

done


