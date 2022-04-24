#!/bin/bash

kubectl create namespace jenkins
kubectl create clusterrolebinding permissive-binding --clusterrole=cluster-admin --user=admin --user=kubelet --group=system:serviceaccounts
kubectl -n kube-system create sa jenkins
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=jenkins:jenkins

ip_address=$(kubectl get nodes -o wide | grep master | awk '{print $6}')
sed -i "s/KUBEHEAD/${ip_address}/g" /local/repository/jenkins/jenkins.yaml
kubectl create -f /local/repository/jenkins/jenkins.yaml --namespace jenkins
kubectl create -f /local/repository/jenkins/jenkins-service.yaml --namespace jenkins
