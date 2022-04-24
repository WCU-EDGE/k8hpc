#!/bin/bash

cd /local/repository/jenkins
sed -i "s/KUBEHEAD/$(cat /opt/keys/headnode)/g" /local/repository/jenkins/casc.yaml
docker build -t jenkins:jcasc .