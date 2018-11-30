#!/bin/bash

#
# docker and k8s block bridge traffic. allow mgmtbr to pass
#

iptables -A FORWARD -o mgmtbr -j ACCEPT
iptables -A FORWARD -i mgmtbr -j ACCEPT

iptables -A FORWARD -o oambr -j ACCEPT
iptables -A FORWARD -i oambr -j ACCEPT


