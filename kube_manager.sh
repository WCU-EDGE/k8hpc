#!/bin/bash 
set -x

sudo apt-get update
sudo apt-get install -y nfs-kernel-server
sudo mkdir -p /opt/keys/flagdir
sudo chown nobody:nogroup /opt/keys
sudo chmod -R a+rwx /opt/keys

hostname > /opt/keys/headnode
sed -i "s/KUBEHEAD/$(cat /opt/keys/headnode)/g" /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker

# Create the permissions file for the NFS directory.
computes=$(($1 + 1))
for i in $(seq 2 $computes)
do
  echo "/opt/keys 192.168.1.$i(rw,sync,no_root_squash,no_subtree_check)" | sudo tee -a /etc/exports
done

sudo systemctl restart nfs-kernel-server

kubeadm init --pod-network-cidr=10.244.0.0/16 > /opt/keys/kube.log

sudo cp /etc/kubernetes/manifests/kube-apiserver.yaml /local/repository/kube-apiserver.yaml.backup
sudo sed -i '/^    - --service-cluster-ip-range/a \ \ \ \ - --service-node-port-range=5000-50000' /etc/kubernetes/manifests/kube-apiserver.yaml

sleep 90

sudo touch /opt/keys/kube_done


# the username needs to be changed
while IFS= read -r line; do
  mkdir -p /users/$line/.kube
  sudo cp -i /etc/kubernetes/admin.conf /users/$line/.kube/config
  sudo chown $line: /users/$line/.kube/config
done < <( ls -l /users | grep 4096 | cut -d' ' -f3 )

sudo -H -u $1 kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml


