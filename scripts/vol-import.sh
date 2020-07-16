#!/bin/bash

qcowfile=$1
newvmname=$2
cpu=$3
mem_gigs=$4

if [ -z "$qcowfile" ] || [ -z "$newvmname" ]
then 
  echo "$0 <template-qcow> <new-vm-name> (<num-cpu> <gigs-of-memory>)" 
  exit 1
fi


if [ -z "$cpu" ]
then
  cpu=2
fi

if [ -z "$mem_gigs" ]
then 
   mem=4096
else
   mem=$((mem_gigs * 1024))
fi

set -x

size=$(stat -Lc%s ${qcowfile})
virsh vol-create-as default ${newvmname}.qcow2 $size --format qcow2
sleep 1
virsh vol-upload --pool default ${newvmname}.qcow2 ${qcowfile}

sleep 1

virt-install --connect qemu:///system --vcpus=$cpu --ram=$mem --name=${newvmname} \
--network bridge=mgmtbr,model=virtio --os-type=linux --os-variant=virtio26 \
--disk path=/var/lib/libvirt/images/${newvmname}.qcow2,device=disk,bus=virtio,format=qcow2 \
--vnc --noautoconsole --import

