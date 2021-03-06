#!/bin/bash

set -x
sudo apt-get install -y nfs-common
sudo mkdir -p /opt/keys

while [ ! -d /opt/keys/flagdir ]; do
  sudo mount 192.168.1.1:/opt/keys /opt/keys
  sleep 10
done

while [ ! -f /opt/keys/kube_done ]; do
  sleep 20
done

sed -i "s/KUBEHEAD/$(cat /opt/keys/headnode)/g" /etc/docker/daemon.json
sudo systemctl daemon-reload
sudo systemctl restart docker

command=`tail -n 2 /opt/keys/kube.log | tr -d '\\'`
echo $command
sudo $command
