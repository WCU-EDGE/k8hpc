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
  kubectl apply -f k8s/compute-network.yaml
}

volume() {
  kubectl apply -f k8s/volumes.yaml
}

ldap() {
  kubectl apply -f k8s/ldap/ldap-deployment.yaml
  kubectl apply -f k8s/ldap/ldap-service.yaml
}

base() {
  kubectl apply -f base-deployment.yaml
}

mongodb() {
  kubectl apply -f k8s/mongodb/mongodb-service.yaml 
  kubectl apply -f k8s/mongodb/mongodb-deployment.yaml                         
}

mysql() {
  kubectl apply -f k8s/mysql/mysql-service.yaml 
  kubectl apply -f k8s/mysql/mysql-deployment.yaml
}

slurmdbd() {
  kubectl apply -f k8s/slurmdbd/slurmdbd-service.yaml
  kubectl apply -f k8s/slurmdbd/slurmdbd-deployment.yaml
}

slurmctld() {
  kubectl apply -f k8s/slurmctld/slurmctld-deployment.yaml
  kubectl apply -f k8s/slurmctld/slurmctld-service.yaml
}

compute() {
  kubectl apply -f k8s/cpn/cpn01-deployment.yaml
  kubectl apply -f k8s/cpn/cpn01-service.yaml
  kubectl apply -f k8s/cpn/cpn02-deployment.yaml
  kubectl apply -f k8s/cpn/cpn02-service.yaml
}

frontend() {
  kubectl apply -f k8s/frontend/frontend-deployment.yaml
  kubectl apply -f k8s/frontend/frontend-service.yaml
}

coldfront() {
  kubectl apply -f k8s/coldfront/coldfront-deployment.yaml
  kubectl apply -f k8s/coldfront/coldfront-service.yaml
}

ondemand() {
  kubectl apply -f k8s/ondemand/ondemand-deployment.yaml
  kubectl apply -f k8s/ondemand/ondemand-service.yaml
}

xdmod() {
  kubectl apply -f k8s/xdmod/xdmod-deployment.yaml
  kubectl apply -f k8s/xdmod/xdmod-service.yaml
}

case "$1" in
  'all')
    network
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
  'slurmdbd')
    slurmdbd
    ;;
  'frontend')
    frontend
    ;;
  *)
    log_info "Usage: $0 {all | convert | ... | cleanup}"
    exit 1
    ;;
esac







