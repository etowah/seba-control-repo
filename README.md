# Building a SEBA/VOLTHA POD

Network Diagram:  
https://github.com/etowah/seba-control-repo/blob/master/SEBA.pdf




## Deployment
Typically done on-site by installation engineers, with internet connectivity.

### Install Physical or VM Host OS
Typical install of Ubuntu 16.04 or 18.04 LTS. One host/vm for ansible/seba-control repo.  Three hosts/vm for k8s/ceph workers.  Extra partitions are needed for ceph.  

### Run Control Repo VM and Repositories.
Local ansible control host, docker repo and helm repo.  Deployed as a vm.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-build-control-vm.txt  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-control-repo.txt  

### Run Ceph Installation and Kubernetes Ansible Kubespray Installation
Use ceph-deploy to deploy ceph to 3 workers.  Extract ansible inventory and run playbooks to install kubernetes and run other odds and ends.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-install-k8s.txt  

### Assign Ceph storage pool to k8s and test 
Run from node1/worker1.  Sets up ceph pool and modifies k8s config to use it.  Also runs a generic helm mysql install that uses PVC to verify everything.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-k8s-ceph-storage.txt  

### Install VOLTHA/SEBA
Helm package installation.  Run from node1/worker1.  Run helm install steps pulling from above mentioned repo.  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha2-install.txt  



## Simple Installs
Use below for a simple single instance kubeadm k8s install or a simplified (no ceph) kubespray install.  
https://github.com/etowah/seba-control-repo/blob/master/simple-kubeadm-setup.txt  
https://github.com/etowah/seba-control-repo/blob/master/simple-kubespray-setup.txt

