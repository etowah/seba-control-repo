# Building a SEBA/VOLTHA POD

Network Diagram:  
https://github.com/etowah/seba-control-repo/blob/master/SEBA.pdf




## Full Deployment with k8s, ceph, certificate authority, helm repo and docker registry
Run with internet connectivity.  Needed to apt install and pull docker images.  Optionally installs the CA, helm repo and docker registry.  See offline notes for populating these registries.  Fully offline install (thumb drives of images) is possible but very tedious.  

### Install Physical or VM Host OS
Typical install of Ubuntu 16.04 or 18.04 LTS. One host/vm for ansible/seba-control repo.  Three hosts/vm for k8s/ceph workers.  Extra partitions are needed for ceph.  Kubespray takes care of apt installing requirements.  

### Run Ansible Control VM and Repositories.
Local ansible control host, docker repo and helm repo.  Deployed as a vm.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-build-control-vm.txt  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-control-repo.txt  

### Run Ceph Installation and Kubernetes Ansible Kubespray Installation
Use ceph-deploy to deploy ceph to 3 workers.  Extract ansible inventory and run playbooks to install kubernetes and run other odds and ends.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-install-k8s.txt  

### Assign Ceph storage pool to k8s and test helm install
Run from node1/worker1.  Sets up ceph pool and modifies k8s config to use it.  Also runs a generic helm mysql install that uses PVC to verify everything.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-k8s-ceph-storage.txt  

### Helm Install SEBA/VOLTHA
Helm package installation.  Run from node1/worker1.  Run helm install steps pulling from above mentioned repo.  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha2-prep.txt  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha2-install.txt  



## Simple Installs of just k8s
Use below for a simple single instance kubeadm k8s install or a simplified (no ceph) kubespray install.  
https://github.com/etowah/seba-control-repo/blob/master/simple-kubeadm-setup.txt  
https://github.com/etowah/seba-control-repo/blob/master/simple-kubespray-setup.txt

