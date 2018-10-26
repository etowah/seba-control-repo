# Building an Offline SEBA/VOLTHA POD

Workflow details and resources needed described here:  
https://github.com/etowah/seba-control-repo/blob/master/details.md

Network Diagram:  
https://github.com/etowah/seba-control-repo/blob/master/SEBA.pdf

The Build and Gather Artifacts steps are done on a build-box host with internet access.  Those artifacts are kept and used in the offline pod.   Assuming everything is gathered and staged, the Deployment steps can be done offline with no internet access.  


## Build and Gather Artifacts
Typically done by release management, with internet connectivity.

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


## Deployment
Typically done on-site by installation engineers, with NO internet connectivity.

### Run Control Repo VM and Repositories.
Offline docker repo, helm repo, oar repo installation and setup.  Deploy seba-control-repo vm, populate repositories within in an offline environment.  
https://github.com/etowah/seba-control-repo/blob/master/setup-control-repo.txt

### Run Kubernetes Ansible Kubespray Installation
Extract ansible inventory and run playbooks to install kubernetes.
https://github.com/etowah/seba-control-repo/blob/master/install-k8s.txt

### Install VOLTHA/SEBA
Helm package installation.    Run from seba-node1.   Run helm install steps pulling from above mentioned repo  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha-install.txt

 
