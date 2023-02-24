#!/bin/bash

convert() {
  kompose convert
}

vc() {
  ### Home volumes
  kubectl -f home-persistentvolumeclaim.yaml

  ### MongoDB volumes
  kubectl -f mongodb-claim0-persistentvolumeclaim.yaml
  kubectl -f data-db-persistentvolumeclaim.yaml

  ### Slurm volumes
  kubectl -f slurmdbd-state-persistentvolumeclaim.yaml
  kubectl -f slurmctld-state-persistentvolumeclaim.yaml
  kubectl -f etc-slurm-persistentvolumeclaim.yaml
  kubectl -f etc-munge-persistentvolumeclaim.yaml

  ### Compute volumes
  kubectl -f cpn01-slurmd-state-persistentvolumeclaim.yaml
  kubectl -f cpn02-slurmd-state-persistentvolumeclaim.yaml

  ### MySQL volumes
  kubectl -f mysql-claim0-persistentvolumeclaim.yaml
  kubectl -f mysql-claim1-persistentvolumeclaim.yaml
  kubectl -f mysql-claim2-persistentvolumeclaim.yaml
  kubectl -f var-lib-mysql-persistentvolumeclaim.yaml

  ### ColdFront volumes
  kubectl -f srv-www-persistentvolumeclaim.yaml

  ### XDMOD volumes
  kubectl -f etc-xdmod-persistentvolumeclaim.yaml
}

network() {
  kubectl -f hpc-toolset-tutorial-compute-networkpolicy.yaml
}

ldap() {
  kubectl -f ldap-deployment.yaml
  # missing service here
}

base() {
  kubectl -f base-deployment.yaml
}

mongodb() {
  kubectl -f mongodb-deployment.yaml
  kubectl -f mongodb-service.yaml                           
}

mysql() {
  kubectl -f mysql-deployment.yaml
  kubeclt -f mysql-service.yaml
}

slurmdbd() {
  kubectl -f slurmdbd-deployment.yaml
  kubectl -f slurmdbd-service.yaml
}

slurmctld() {
  kubectl -f slurmctld-deployment.yaml
  kubectl -f slurmctld-service.yaml
}

compute() {
  kubectl -f cpn01-deployment.yaml
  kubectl -f cpn01-service.yaml
  kubectl -f cpn02-deployment.yaml
  kubectl -f cpn02-service.yaml
}

frontend() {
  kubectl -f frontend-deployment.yaml
  kubectl -f frontend-service.yaml
}

coldfront() {
  kubectl -f coldfront-deployment.yaml
  kubectl -f coldfront-service.yaml
}

ondemand() {
  kubectl -f ondemand-deployment.yaml
  kubectl -f ondemand-service.yaml
}

xdmod() {
  kubectl -f xdmod-deployment.yaml
  kubectl -f xdmod-service.yaml
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
    slurmcltd
    compute
    frontend
    coldfront
    ondemand
    xdmod
    ;;
  *)
    log_info "Usage: $0 {all | ... | cleanup}"
    exit 1
    ;;
esac







