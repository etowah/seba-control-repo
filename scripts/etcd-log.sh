#!/bin/bash

/home/foundry/bin/etcd-mon.sh > /home/foundry/monitoring/voltha_etcd_monitoring_$(date +"%m_%d_%H_%M").txt 2>&1

