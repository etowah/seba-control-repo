# SEBA POD Installation Detail

Tasks related to installing an entire SEBA pod without internet connectivity.
Provide the needed software, packages, and repositories to setup a SEBA POD that does not have Internet access.

 

The goal of an offline or "air-gapped" installation is to be able to start with compute, switching, and OLT hardware still in the box from the OEM and build a fully functional POD without any Internet connectivity. Its assumed the installer brings a laptop and any installation media such as one or more USB drives. These USB drives contain the ISOs for installing Ubuntu and Open Network Linux and also any files needed to bootstrap repository installations.



## Elements needed:

- Ubuntu 16.04.X ISO Thumb Drive
- OpenNetworkLinux XX.XX ISO Thumb Drive
- Big USB drive of apt, docker images (~30GB), helm chart files, mgmt vm and control-repo vm qcow files, installation scripts.
- Equipment on site


## Software services needed

- Management VM. Runs outside management vlan access, Inside POD DNS, NATTING to radius, VPN/SSH, remote access
- SEBA Control Repo VM.   Runs web servers needed for repos, and Ansible control for kubespray
- Apt mirror of minimial BASIC xenial packages needed to run mgmt and repo vm
- Apt mirror of docker-ce, k8s, other utility apt repos
- docker image registry
- helm chart repository
- basic web server for custom OAR files, site helm values yaml files.

 

Once the onsite mgmt vm is running, it will provide interior pod management vlan (vlan 10) default routing, NATing, outside ssh access, and private authoritative DNS within the pod.  
Once the control-repo VM is running it will get populated the stable versions of above apt pkg, docker images, helm charts, and oar files.  
Once the onsite mgmt vm and control-repo vm is ready, run ansible based k8s install, helm install


## Reserved interior POD DNS names:

Top level domain: seba.local

repo.seba.local  
gateway.sebal.local  

 

## Rough workflow

1) Unbox compute, switching, olt. wire network and power on
2) Install config into mgmt switch. Most importantly in-pod management vlan 10
3) Connect laptop to switch vlan 10, ip yourself
4) Connect 3 servers iLO/iDRAC and host interfaces
5) Use USB/Serial/VGA to configure iLO/iDRAC IP connectivity
6) Connect to iLO/iDRAC on each host, plug in Ubuntu ISO USB
7) Install base ubuntu, install libvirt, ssh, set network, gateway (to TBD mgmt vm)
8) Login to ubuntu, add usb thumb drive BOOTSTRAP apt repo
9) apt install bootstrap packages needed to run VM
10) virtinst/virt-install  mgmt vm and seba-control-repo vm.
  - mgmt vm runs routing/natting for vlan 10 for whole pod.  Also runs authoritative and recursive dns for whole pod
  - seba control repo vm runs apt repository, docker image registry, helm chart repo, and onos oar web server
  - setup each physical host to allow access to VM (mgmt vm setup notes)
  - other steps on physical hosts?
11) Console into mgmt vm and control-repo vm and set vlan 10 ip (package qcow with correct ip..?)
12) Login to control-repo vm and setup repositories
  - image already packaged with docker repo, apache, and apt mirror
  - setup docker registry/load images, load helm charts, load onos apps
  - setup apt repo
  - setup ansible inventory files
13) Run ansible install of k8s cluster from seba-control-repo vm
  - reads from ansible inventory files
  - reaches out to freshly installed compute hosts, installs packages needed to run k8s
  - run supplimental ansible ad-hoc commands
14) Install seba/voltha helm packages
  - run from seba-node1.  possibly from seba-control-repo
15) Install ONL ISO on Edgecore OLT
16) IP edgecore olt
17) scp and install bal/openolt packages
18) START bal/openolt
19) Install ONL ISO on Agg switch
20) Install ofdpa packages
21) START ofdpa
  - If not using ofdpa optionally statically configure vlan trunking between OLT and BNG uplink
22) Run curl yaml/abstract olt commands to commision a virtual chassis
23) Run curl yaml/abstract olt commands to add an edgcore olt linecard
24) Run curl yaml/abstract olt commands to add whitelist entries
25) Run curl yaml/abstract olt commands to add a TEST SUBSCRIBER
26) plugin test splitter, test ONU
27) plugin test RG
28) plug laptop into LAN port of RG. Test connect to internet via real BNG.
