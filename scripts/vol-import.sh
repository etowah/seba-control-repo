#!/bin/bash

qcowfile=$1
newvmname=$2

if [ -z "$qcowfile" ] || [ -z "$newvmname" ]
then
  echo "Usage: $0 <qcow-file> <new-vm-name>"
  exit 1
fi

set -x

size=$(stat -Lc%s ${qcowfile})
virsh vol-create-as default ${newvmname}.qcow2 $size --format qcow2
sleep 1
virsh vol-upload --pool default ${newvmname}.qcow2 ${qcowfile}

sleep 1

virt-install --connect qemu:///system --vcpus=4 --ram=4096 --name=${newvmname} \
--network bridge=mgmtbr,model=virtio --os-type=linux --os-variant=virtio26 \
--disk path=/var/lib/libvirt/images/${newvmname}.qcow2,device=disk,bus=virtio,format=qcow2 \
--vnc --noautoconsole --import

