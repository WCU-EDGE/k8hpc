#!/bin/bash
set -x

myns="default"

for mypod in ondemand coldfront xdmod
do
  cat <<EOF | cfssl genkey - | cfssljson -bare server
  {
    "hosts": [
      "${mypod}.${myns}.svc.cluster.local",
      "${mypod}.${myns}.pod.cluster.local"
    ],
    "CN": "${mypod}.${myns}.svc.cluster.local",
    "key": {
      "algo": "ecdsa",
      "size": 256
    }
  }
  EOF
done
