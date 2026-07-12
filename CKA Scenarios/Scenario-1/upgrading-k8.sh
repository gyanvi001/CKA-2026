# Run the appropriate command to check the current version of the API server, controller manager, scheduler, kube-proxy, CoreDNS, and etcd.
kubeadm upgrade plan
# get the version of kubeadm
kubeadm version -o json | jq
# upgrade kubeadm to version 1.34.2
sudo apt install -y kubeadm=1.34.2-1.1
# run upgrade plan again
kubeadm upgrade plan
# upgrade components to version v1.34.2
kubeadm upgrade apply v1.34.2