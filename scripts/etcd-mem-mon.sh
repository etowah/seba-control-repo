#!/bin/bash

ps -o pid,user,rss,vsize,command ax |grep "/usr/local/bin/etcd --data-dir" |grep -v grep
echo -ne "\n\n"
sudo pmap -x $(ps -o pid,user,rss,vsize,command ax |grep "/usr/local/bin/etcd --data-dir" |grep -v grep|awk '{ print $1 }') |egrep "(Address|total)"

