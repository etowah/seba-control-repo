#!/bin/bash

host=$1
updfile=$2

if [ -n "$updfile" ] && [ -n "$host" ]
then
  set -x
  curl -v --user onos:rocks -X POST -H "Content-Type: application/json" http://${host}:30120/onos/v1/network/configuration/ -d @$updfile
else
  echo "$0 <onos-host> <onos-netcfg-update-json file>"
fi
