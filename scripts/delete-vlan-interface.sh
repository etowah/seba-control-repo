#!/bin/bash

vm=$1
inf_name=$2
inf_vlan=$3

if [ -z "$vm" ] || [ -z "$inf_name" ] || [ -z "$inf_vlan" ]
then
  echo "Usage: $0 <vm-name-or-id> <new-interface-name> <new-interface-vlan-id>"
  exit 1
fi

tmpfile=$(mktemp /tmp/$0.XXXXXX)

cat << EOF > $tmpfile
<interface type='bridge'>
  <source bridge='inftrunkbr'/>
  <vlan>
    <tag id='$inf_vlan'/>
  </vlan>
  <virtualport type='openvswitch'/>
  <target dev='$inf_name'/>
  <model type='virtio'/>
</interface>
EOF

cat $tmpfile

set -x
virsh detach-device $vm $tmpfile --live --persistent

rm $tmpfile

