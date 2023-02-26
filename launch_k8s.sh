#!/bin/bash

log_info() {
  printf "\n\e[0;35m $1\e[0m\n\n"
}

log_warn() {
  printf "\e[0;33m $1\e[0m\n"
}

convert() {
  kompose convert
}

network() {
  kubectl apply -f k8s/compute-networkpolicy.yaml
}

volume() {
  kubectl apply -f k8s/volumes.yaml
}

ldap() {
  kubectl apply -f k8s/ldap-deployment.yaml
  # missing service here
}

base() {
  kubectl apply -f base-deployment.yaml
}

mongodb() {
  kubectl apply -f k8s/mongodb/data-db-persistentvolumeclaim.yaml
  kubectl apply -f k8s/mongodb-claim0-persistentvolumeclaim.yaml
  kubectl apply -f k8s/mongodb/mongodb-service.yaml 
  kubectl apply -f k8s/mongodb/mongodb-deployment.yaml                         
}

mysql() {
  kubectl apply -f k8s/mysql/mysql-claim0-persistentvolumeclaim.yaml 
  kubectl apply -f k8s/mysql/mysql-claim1-persistentvolumeclaim.yaml 
  kubectl apply -f k8s/mysql/mysql-claim2-persistentvolumeclaim.yaml 
  kubectl apply -f k8s/mysql/mysql-service.yaml 
  kubectl apply -f k8s/mysql/mysql-deployment.yam
}

slurmdbd() {
  kubectl apply -f slurmdbd-deployment.yaml
  kubectl apply -f slurmdbd-service.yaml
}

slurmctld() {
  kubectl apply -f slurmctld-deployment.yaml
  kubectl apply -f slurmctld-service.yaml
}

compute() {
  kubectl apply -f cpn01-deployment.yaml
  kubectl apply -f cpn01-service.yaml
  kubectl apply -f cpn02-deployment.yaml
  kubectl apply -f cpn02-service.yaml
}

frontend() {
  kubectl apply -f frontend-deployment.yaml
  kubectl apply -f frontend-service.yaml
}

coldfront() {
  kubectl apply -f coldfront-deployment.yaml
  kubectl apply -f coldfront-service.yaml
}

ondemand() {
  kubectl apply -f ondemand-deployment.yaml
  kubectl apply -f ondemand-service.yaml
}

xdmod() {
  kubectl apply -f xdmod-deployment.yaml
  kubectl apply -f xdmod-service.yaml
}

case "$1" in
  'all')
    network
    volume
    ldap
    mongodb
    mysql
    slurmdbd
    slurmctld
    compute
    frontend
    coldfront
    ondemand
    xdmod
    ;;
  'convert')
    convert
    ;;
  'network')
    network
    ;;
  'volume')
    volume
    ;;
  'ldap')
    ldap
    ;;
  'mongodb')
    mongodb
    ;;
  'mysql')
    mysql
    ;;
  *)
    log_info "Usage: $0 {all | convert | ... | cleanup}"
    exit 1
    ;;
esac







