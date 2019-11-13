# Building a SEBA/VOLTHA POD

Network Diagram:  
https://github.com/etowah/seba-control-repo/blob/master/SEBA.pdf




## Deployment
Typically done on-site by installation engineers, with internet connectivity.

### Install Physical Host OS
Install of Ubuntu 16.04 LTS or Centos 7. Optionally capable of running VM
https://github.com/etowah/seba-control-repo/blob/master/centos-host-setup.txt
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-host-setup.txt

### Run Control Repo VM and Repositories.
Local ansible control host, docker repo and helm repo.  Deployed as a vm.
https://github.com/etowah/seba-control-repo/blob/master/centos-setup-control-repo.txt
https://github.com/etowah/seba-control-repo/blob/master/centos-setup-control-vm.txt
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-control-repo.txt
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-setup-control-vm.txt

### Run Ceph Installation and Kubernetes Ansible Kubespray Installation
Extract ansible inventory and run playbooks to install kubernetes.  
https://github.com/etowah/seba-control-repo/blob/master/centos-install-k8s.txt
https://github.com/etowah/seba-control-repo/blob/master/ubuntu-install-k8s.txt

### Assign Ceph storage pool to k8s and test 
https://github.com/etowah/seba-control-repo/blob/master/setup-k8s-ceph-storage.txt

### Install VOLTHA/SEBA
Helm package installation.  Run from node1.  Run helm install steps pulling from above mentioned repo  
https://github.com/etowah/seba-control-repo/blob/master/helm-seba-voltha1.7-install.txt

