# Scripts and Tools Needed to Run an Offline SEBA/VOLTHA POD

Workflow details and resources needed described here:  
https://github.com/etowah/seba-control-repo/blob/master/details.md


There are 2 high level steps that need to be done from a build host with internet access.  Those artifacts are kept and used in the offline pod.   The final 3 high level steps are done offline.  

## Build and Gather Artifacts
Building a control-repo VM qcow that will host repositories; apt, docker-repo, helm, and oar.   This results in a vm qcow file that needs to be installed on a host in the pod later.  
This qcow will be versioned  
https://github.com/etowah/seba-control-repo/blob/master/building-control-vm.txt

Packaging the needed artifacts needed within the control-repo vm.   Basically tarballs to go with the qcow above. The helm-charts, oar files and tgz will versioned.  The docker images youll need to download yourself as they are 20+GB.  This list of images needed is included in this repo.  
https://github.com/etowah/seba-control-repo/blob/master/package-artifacts.txt

## Run Control Repo VM and Repositories. 
Offline docker repo, helm repo, oar repo installation and setup.  Deploy seba-control-repo vm, populate repositories within in an offline environment.  
https://github.com/etowah/seba-control-repo/blob/master/setup-control-repo.txt

## Run Kubernetes Ansible Kubespray Installation
Extract ansible inventory and run playbooks to install kubernetes.  CURRENTLY STILL REQUIRES INTERNET
https://github.com/etowah/seba-control-repo/blob/master/install-k8s.txt

## Install VOLTHA/SEBA
Helm package installation.    Run from seba-node1.   Run helm install steps pulling from above mentioned repo  
https://github.com/etowah/seba-control-repo/blob/master/postinstall-node-setup.txt

## Image lists
List of docker images needed:  
https://github.com/etowah/seba-control-repo/blob/master/seba-imagelist.txt
