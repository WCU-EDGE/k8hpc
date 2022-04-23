#!/bin/bash

sudo cp /etc/kubernetes/manifests/kube-apiserver.yaml /local/repository/kube-apiserver.yaml.backup
sudo sed -i '/^    - --service-cluster-ip-range/a \ \ \ \ - --service-node-port-range=5000-50000' /etc/kubernetes/manifests/kube-apiserver.yaml
sleep 90
kubectl create namespace jenkins
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
kubectl -n kube-system create sa jenkins
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=jenkins:jenkins
kubectl create -f /local/repository/jenkins/jenkins.yaml --namespace jenkins
kubectl create -f /local/repository/jenkins/jenkins-service.yaml --namespace jenkins
