#!/bin/bash

export ETCDCTL_API=3

clusterip=$(dig +short voltha-etcd-cluster-client.default.svc.cluster.local @10.233.0.3)
etcdctl --endpoints=${clusterip}:2379 member list

#rev=$(etcdctl --endpoints=${clusterip}:2379 endpoint status --write-out="json" | egrep -o '"revision":[0-9]*' | egrep -o '[0-9].*')
#etcdctl --endpoints=${clusterip}:2379 compact $rev

for i in $(kubectl get pods --all-namespaces|grep etcd-cluster |awk '{ print $2 }');
do
  name=$i
  echo -ne "\n\n$name\n";
  host=$(dig +short ${name}.voltha-etcd-cluster.default.svc.cluster.local @10.233.0.3)

  etcdctl --endpoints=${host}:2379 defrag
done

