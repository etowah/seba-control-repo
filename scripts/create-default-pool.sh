#!/bin/bash


mkdir -p /var/lib/libvirt/images
virsh pool-define-as default --type dir --target /var/lib/libvirt/images
virsh pool-autostart default
virsh pool-start default

