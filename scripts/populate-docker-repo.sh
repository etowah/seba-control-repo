#!/bin/bash

imagelist=$1
pull=$2

if [ -z "$imagelist" ]
then
  echo "$0 <image-list-file>"
  exit 1
fi


for i in $(cat $imagelist)
do 
  echo $i

  if [ -n "$pull" ]
  then
    docker pull $i
  fi

  if echo $i | grep --quiet foundry; 
  then
    shortname=$(echo $i | cut -d'/' -f2)
    docker tag $i repo.seba.local:5000/voltha/$shortname
    docker push repo.seba.local:5000/voltha/$shortname
  else
    docker tag $i repo.seba.local:5000/$i
    docker push repo.seba.local:5000/$i
  fi

done


