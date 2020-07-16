#!/bin/bash

export ETCDCTL_API=3

clusterip=$(dig +short voltha-etcd-cluster-client.default.svc.cluster.local @10.233.0.3)
etcdctl --endpoints=${clusterip}:2379 member list

for i in $(kubectl get pods --all-namespaces|grep etcd-cluster |awk '{ print $2 }'); 
do 
  name=$i
  echo -ne "\n\n$name\n"; 
  host=$(dig +short ${name}.voltha-etcd-cluster.default.svc.cluster.local @10.233.0.3)

  etcdctl --endpoints=${host}:2379 endpoint status -w table
  etcdctl --endpoints=${host}:2379 endpoint health
  echo -ne "\n\n"

  stats=$(curl -s http://${host}:2379/metrics) 
  echo "$stats"
  #echo "$stats" |egrep "(etcd_disk_wal_fsync_duration_seconds|backend_commit_duration_seconds|etcd_network_peer_sent_failures_total|go_memstats_sys_bytes|etcd_debugging_mvcc_keys_total|process_resident_memory_bytes|compact|revision)"
done

totalkeys=$(etcdctl --endpoints=${clusterip}:2379 get --command-timeout=60s --from-key=true --keys-only=true "" | egrep "^.+$"| wc -l)
echo -ne "\n\nTotal Keys: $totalkeys\n\n"

#/home/foundry/bin/etcd-mem-mon.sh

#echo -ne "\n\n"
#ssh foundry@lab-kube-02 /home/foundry/bin/etcd-mem-mon.sh
#echo -ne "\n\n"
#ssh foundry@lab-kube-03 /home/foundry/bin/etcd-mem-mon.sh

