# Building an Offline SEBA/VOLTHA POD

Workflow details and resources needed described here:  
https://github.com/etowah/seba-control-repo/blob/master/details.md

Network Diagram:  
https://github.com/etowah/seba-control-repo/blob/master/SEBA.pdf

The Build and Gather Artifacts steps are done on a build-box host with internet access.  Those artifacts are kept and used in the offline pod.   Assuming everything is gathered and staged, the Deployment steps can be done offline with no internet access.  





## Deployment
Typically done on-site by installation engineers, with NO internet connectivity.

### Install Physical Host OS
Local, offline install of Ubuntu 16.04 LTS.  Addition of local apt repo needed to install packages needed to run vm (mgmtvm and seba-control-repo vm)  
https://github.com/etowah/seba-control-repo/blob/master/offline-host-setup.txt

### Run Management VM
Virtual machine running routing and NAT between interior POD mgmt vlan and exterior OAM vlan (typically through BNG).  Also runs DNS for seba.local domain and mgmt DHCP (for laptops on site)  
https://github.com/etowah/seba-control-repo/blob/master/setup-mgmtvm.txt

### Run Control Repo VM and Repositories.
Offline docker repo, helm repo, oar repo installation and setup.  Deploy seba-control-repo vm, populate repositories within in an offline environment.  
https://github.com/etowah/seba-control-repo/blob/master/setup-control-repo.txt

### Run Kubernetes Ansible Kubespray Installation
Extract ansible inventory and run playbooks to install kubernetes.  
https://github.com/etowah/seba-control-repo/blob/master/install-k8s.txt

### Install VOLTHA/SEBA
Helm package installation.  Run from seba-node1.  Run helm install steps pulling from above mentioned repo  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha-install.txt

 
 
 
## Build and Gather Artifacts
Typically done by release management, with internet connectivity.  These are typically already provided and dont need to be built every time.  But if you wish to create your own from scratch, below is the process.   Much of this (~50GB) can provided easily

### Build control-repo vm qcow
Requires a physical host running KVM/libvirt.  Building a control-repo VM qcow that will host repositories; apt, docker-repo, helm, and oar.   This results in a vm qcow file that needs to be installed on a host in the pod later.  
This qcow will be versioned  
https://github.com/etowah/seba-control-repo/blob/master/building-control-vm.txt

### Build tarballs of software
Requires a build-box running docker, k8s, and helm.  Packaging the needed artifacts that will be needed within the control-repo vm.   Basically tarballs to go with the qcow above. The helm-charts, oar files and tgz will versioned.  The docker images youll need to download yourself as they are 20+GB.  This list of images needed is included in this repo.  
https://github.com/etowah/seba-control-repo/blob/master/package-artifacts.txt

List of k8s docker images needed:  
https://github.com/etowah/seba-control-repo/blob/master/kubespray-imagelist.txt

List of seba/voltha docker images needed:  
https://github.com/etowah/seba-control-repo/blob/master/seba-imagelist.txt
