#!/bin/bash
set -x

myns="default"

for mypod in ondemand coldfront xdmod
do
  kubectl certificate approve ${mypod}.${myns}
done
