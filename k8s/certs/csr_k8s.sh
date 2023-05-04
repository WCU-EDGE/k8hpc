
#!/bin/bash
set -x

myns="default"

for mypod in ondemand coldfront xdmod
do
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ${mypod}.${myns}
spec:
  request: $(cat ${mypod}.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - digital signature
  - key encipherment
  - server auth
EOF
done
