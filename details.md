# SEBA POD Installation Detail

Tasks related to installing an entire SEBA pod without internet connectivity.
Provide the needed software, packages, and repositories to setup a SEBA POD that does not have Internet access.

The goal of an offline or "air-gapped" installation is to be able to start with compute, switching, and OLT hardware still in the box from the OEM and build a fully functional POD without any Internet connectivity. Its assumed the installer brings a laptop and any installation media such as one or more USB drives. These USB drives contain the ISOs for installing Ubuntu and any files needed to bootstrap docker/helm repository installations.



## Elements needed:

- Ubuntu 16.04.X ISO Thumb Drive
- Big USB drive of apt, docker images (~50GB), helm chart files, oar files, control-repo setup files, mgmt vm and control-repo vm qcow files, openolt/bal edgecore executables
- Equipment on site
  - 3 servers
  - 1 mgmt switch
  - 1 agg switch
  - 1 olt (minimum)
  - Optics/Splitter/Attenuators
  - 1 ONU
  - 1 RG


## Software services and virtual machines

These will be packaged by release management and will be provided.  

- Management VM. Routes inside management vlan (10) to outside management vlan (4093).  NATs inside management vlan addresses to outside management vlan IP.  Also provides inside POD DNS, NAT to radius server, VPN/SSH management access.
- SEBA Control Repo VM.   Runs web servers needed for repos, and Ansible control for kubespray
  - Qcow build instructions: https://github.com/etowah/seba-control-repo/blob/master/building-control-vm.txt
  - Apt mirror of minimial BASIC xenial packages needed to run mgmt and repo vm
  - Apt mirror of docker-ce, k8s, other utility apt repos
  - docker image registry
  - helm chart repository
  - basic web server for custom OAR files, site helm values yaml files.
- Gathering artifacts for the repostitory: https://github.com/etowah/seba-control-repo/blob/master/package-artifacts.txt


## Northbound Network Connectivity

- Minimum a single physical link to the BNG, which provides both subscriber vlans and outside mgmt vlan (4093).
- OOB connectivity 


## Reserved interior POD DNS names:

Top level domain: seba.local

repo.seba.local  
gateway.sebal.local  



## Workflow

Start with installing the site mgmt virtual machine. It will provide interior pod management vlan (vlan 10) default routing, NATing to outside management vlan (4093), management ssh access, and private authoritative DNS within the pod.  Then install the control-repo vm. It will then get populated the stable versions of above apt pkg, docker images, helm charts, and oar files.  

Once the onsite mgmt vm and control-repo vm is ready, run ansible based k8s install, helm install. See below for workflow.

1) Unbox compute, switching, olt. wire network and power on
2) Install config into mgmt switch. Most importantly in-pod management vlan 10
3) Connect laptop to switch vlan 10, ip yourself
4) Connect 3 servers iLO/iDRAC and host interfaces
5) Use USB/Serial/VGA to configure iLO/iDRAC IP connectivity
6) Connect to iLO/iDRAC on each host, plug in Ubuntu ISO USB
7) Install Ubuntu 16.04 on all 3 servers 
  - https://github.com/etowah/seba-control-repo/blob/master/offline-host-setup.txt
  - Login to hosts, add local apt repo
  - Setup host networking and apt install bootstrap packages needed to run VM.  virtinst and prerequisites.
8) virtinst/virt-install  mgmt vm and setup networking
  - https://github.com/etowah/seba-control-repo/blob/master/setup-mgmtvm.txt
  - use provided vol-import.sh script to start vm
  - setup ip vlan 4093 ip and mgmt vlan 10 ip
  - setup natting firewall
  - setup dnsmasq
  - mgmt vm runs routing/natting for vlan 10 for whole pod.  Also runs authoritative and recursive dns for whole pod
  - seba control repo vm runs apt repository, docker image registry, helm chart repo, and onos oar web server
10) virtinst/virt-install  seba-control-repo vm and setup repositories
  - https://github.com/etowah/seba-control-repo/blob/master/setup-control-repo.txt
  - use provided vol-import.sh script to start vm
  - image already packaged with docker repo, apache, and apt mirror
  - setup docker registry/load images, load helm charts, load onos apps
  - setup apt repo
  - setup ansible inventory files
11) Run ansible install of k8s cluster from seba-control-repo vm
  - https://github.com/etowah/seba-control-repo/blob/master/install-k8s.txt
  - reads from ansible inventory files
  - reaches out to freshly installed compute hosts, installs packages needed to run k8s
  - run supplimental ansible ad-hoc commands
12) Install seba/voltha helm packages
  - https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha-install.txt
  - run from seba-node1.  possibly from seba-control-repo one day.
13) Setup Edgecore olt
  - Install needed apt packages (TODO)
  - Install build of protobuf (TODO)
  - scp and install bal/openolt packages
  - START bal/openolt
14) Install/Setup operating system on Agg switch
  - Using either ONL or vendor supplied OS
  - Install ofdpa packages if using ONL
  - Start ofdpa
  - If not using ofdpa optionally statically configure vlan trunking between OLT and BNG uplink
  - Vendor specific notes on agg switch configuration
15) Run curl yaml/abstract olt commands to commision a virtual chassis
16) Run curl yaml/abstract olt commands to add an edgcore olt linecard
17) Run curl yaml/abstract olt commands to add whitelist entries
18) Run curl yaml/abstract olt commands to add a TEST SUBSCRIBER
19) Plug in physical Optical Distribution Network
  - plugin test splitter and attenuator(s)
  - plugin test ONU
  - plugin test RG in ONU LAN Port 1
  - plug laptop into any LAN port of RG. Test connect to internet via real BNG.



