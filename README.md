# Scripts and Tools Needed to Run an Offline SEBA/VOLTHA POD

There are 4 high level steps that need to be done.   The first 2 are done on a host with internet access as part of prep.

## On an internet connected host
Building a control-repo VM that will host repositories; apt, docker-repo, helm, and oar.   This results in a vm qcow file that needs to be installed on a host in the pod later.  
This qcow will be versioned
https://github.com/etowah/seba-control-repo/blob/master/building-control-vm.txt

Packaging the needed artifacts needed within the control-repo vm.   Basically tarballs to go with the qcow above. The helm-charts, oar files and tgz will versioned.  The docker images youll need to download yourself as they are 20+GB.  This list of images needed is included in this repo.
https://github.com/etowah/seba-control-repo/blob/master/package-artifacts.txt

## On-site without internet
Offline docker repo, helm repo, and kubernetes installation.  Deploy control-repo vm, populate repositories within in an offline environment.  Notes ends with running kubespray WHICH CURRENTLY STILL REQUIRES INTERNET.    
https://github.com/etowah/seba-control-repo/blob/master/build-offline-pod.txt

Helm package installation.    Run from seba-node1.   Run helm install steps pulling from above mentioned repo
https://github.com/etowah/seba-control-repo/blob/master/postinstall-node-setup.txt



## Odds and ends
List of docker images needed:
https://github.com/etowah/seba-control-repo/blob/master/seba-imagelist.txt
