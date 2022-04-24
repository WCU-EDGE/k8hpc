#!/bin/bash


sudo cp /etc/kubernetes/manifests/kube-apiserver.yaml /local/repository/kube-apiserver.yaml.backup
sudo sed -i '/^    - --service-cluster-ip-range/a \ \ \ \ - --service-node-port-range=5000-50000' /etc/kubernetes/manifests/kube-apiserver.yaml
sleep 90

# launch registry container on Kubernetes
cd /local/registry/registry
kubectl create -f registry.yaml 
kubectl create -f registry-service.yaml
