#!/bin/bash
# Firewall and SNAT
# description: Starts and stops firewall services


function startfw {

  echo -n "Starting Firewall Services... "
  echo

  ## enable routing
  echo "1" > /proc/sys/net/ipv4/ip_forward
  echo "2" > /proc/sys/net/ipv4/conf/default/rp_filter
  echo "2" > /proc/sys/net/ipv4/conf/all/rp_filter

  # Flushing all rules and starting fresh
  iptables -F INPUT
  iptables -F OUTPUT
  iptables -F FORWARD
  iptables -t nat -F PREROUTING
  iptables -t nat -F POSTROUTING
  iptables -t nat -F OUTPUT
  conntrack -F

  # Setting default policies
  iptables -P INPUT DROP
  iptables -P OUTPUT ACCEPT
  iptables -P FORWARD DROP
  #iptables -P FORWARD ACCEPT #temp test allowing all packets to be forwarded


  ## eth0 is assumed to be public, with a public IP. Or in this case just "outside"
  ## eth1 is assumed to be private, with an RFC 1918 IP.

  # Allow everything on the loopback interface and from local networks
  iptables -A INPUT -p all -i lo -j ACCEPT
  iptables -A INPUT -p all -i eth1 -j ACCEPT

  # services on the local host open to the public side
  iptables -A INPUT -p icmp -j ACCEPT
  iptables -A INPUT -p tcp -i eth0 --dport 22 -j ACCEPT
  iptables -A INPUT -p udp --sport 123 -m state --state RELATED,ESTABLISHED -j ACCEPT

  # Allow incoming unpriviliged ports so network clients work.
  iptables -A INPUT -p tcp --destination-port 1024:65535 -m state --state RELATED,ESTABLISHED -j ACCEPT
  iptables -A INPUT -p udp --destination-port 1024:65535 -m state --state RELATED,ESTABLISHED -j ACCEPT

  # Setup internal network outgoing NAT
  iptables -t nat -A POSTROUTING -o eth0 -s 10.242.11.0/24 -j SNAT --to-source 192.168.90.8

  # Whats allowed to be routed through the firewall
  iptables -A FORWARD -i eth1 -j ACCEPT

  # coming from the public side going into the private side
  iptables -A FORWARD -i eth0 -o eth1 -m state --state RELATED,ESTABLISHED -j ACCEPT

}



function stopfw {

  echo -n "Stopping Firewall Services... "
  echo

  iptables -F INPUT
  iptables -F OUTPUT
  iptables -F FORWARD

  iptables -t nat -F POSTROUTING
  iptables -t nat -F PREROUTING
  iptables -t nat -F OUTPUT
  conntrack -F

  iptables -P INPUT ACCEPT
  iptables -P OUTPUT ACCEPT
  iptables -P FORWARD ACCEPT

}




##
## MAIN
##


case "$1" in
  start)
    startfw
  ;;
  stop)
    stopfw
  ;;
  restart|reload)
    $0 stop
    $0 start
  ;;
  *)
    echo "Usage: firewall {start|stop|reload|restart}"
    echo
    exit 1
esac

exit 0
