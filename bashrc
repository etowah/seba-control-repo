export EDITOR=vi
export HELM_HOME=/home/foundry/.helm
export ETCDCTL_API=3

source <(kubectl completion bash)
alias onos='ssh-keygen -f "/home/foundry/.ssh/known_hosts" -R [seba-node1]:30115; ssh -p 30115 -o StrictHostKeyChecking=no karaf@seba-node1'
alias vcli='ssh-keygen -f "/home/foundry/.ssh/known_hosts" -R [seba-node1]:30110; ssh -p 30110 -o StrictHostKeyChecking=no voltha@seba-node1'
alias kgp='kubectl get pods --all-namespaces -o wide'

kol ()
{
    pod=$(kubectl get pods -n voltha |grep onos |grep Running | awk '{print $1}');
    kubectl logs $pod -n voltha $@
}
kvl ()
{
    pod=$(kubectl get pods -n voltha |grep vcore |grep Running | awk '{print $1}');
    kubectl logs $pod -n voltha $@
}
