#!/bin/bash

convert() {
  kompose convert
}

vc() {
  ### Home volumes
  kubectl apply -f home-persistentvolumeclaim.yaml

  ### MongoDB volumes
  kubectl apply -f mongodb-claim0-persistentvolumeclaim.yaml
  kubectl apply -f data-db-persistentvolumeclaim.yaml

  ### Slurm volumes
  kubectl apply -f slurmdbd-state-persistentvolumeclaim.yaml
  kubectl apply -f slurmctld-state-persistentvolumeclaim.yaml
  kubectl apply -f etc-slurm-persistentvolumeclaim.yaml
  kubectl apply -f etc-munge-persistentvolumeclaim.yaml

  ### Compute volumes
  kubectl apply -f cpn01-slurmd-state-persistentvolumeclaim.yaml
  kubectl apply -f cpn02-slurmd-state-persistentvolumeclaim.yaml

  ### MySQL volumes
  kubectl apply -f mysql-claim0-persistentvolumeclaim.yaml
  kubectl apply -f mysql-claim1-persistentvolumeclaim.yaml
  kubectl apply -f mysql-claim2-persistentvolumeclaim.yaml
  kubectl apply -f var-lib-mysql-persistentvolumeclaim.yaml

  ### ColdFront volumes
  kubectl apply -f srv-www-persistentvolumeclaim.yaml

  ### XDMOD volumes
  kubectl apply -f etc-xdmod-persistentvolumeclaim.yaml
}

network() {
  kubectl apply -f hpc-toolset-tutorial-compute-networkpolicy.yaml
}

ldap() {
  kubectl apply -f ldap-deployment.yaml
  # missing service here
}

base() {
  kubectl apply -f base-deployment.yaml
}

mongodb() {
  kubectl apply -f mongodb-deployment.yaml
  kubectl apply -f mongodb-service.yaml                           
}

mysql() {
  kubectl apply -f mysql-deployment.yaml
  kubectl apply -f mysql-service.yaml
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
    vc
    network
    ldap
    base
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
  *)
    log_info "Usage: $0 {all | convert | ... | cleanup}"
    exit 1
    ;;
esac







