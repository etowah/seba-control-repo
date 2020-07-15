# Building a SEBA/VOLTHA POD

Network Diagram:  
https://github.com/etowah/seba-control-repo/blob/master/SEBA.pdf




## Deployment
Typically done on-site by installation engineers, with internet connectivity.

### Install Physical or VM Host OS
Typical install of Ubuntu 16.04 or 18.04 LTS.

### Run Control Repo VM and Repositories.
Local ansible control host, docker repo and helm repo.  Deployed as a vm.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-build-control-vm.txt  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-control-repo.txt  

### Run Ceph Installation and Kubernetes Ansible Kubespray Installation
Extract ansible inventory and run playbooks to install kubernetes.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-install-k8s.txt  

### Assign Ceph storage pool to k8s and test 
Run from node1.  Sets up ceph pool and modifies k8s config to use it.  
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-k8s-ceph-storage.txt  

### Install VOLTHA/SEBA
Helm package installation.  Run from node1.  Run helm install steps pulling from above mentioned repo  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha2-install.txt  

