cat <<EOF | kubectl apply -f -
kind: NetworkChaos
apiVersion: chaos-mesh.org/v1alpha1
metadata:
  namespace: canaria-66ee7fbcc59-prod
  name: networkpartition
spec:
  selector:
    namespaces:
      - openshift-apiserver
    labelSelectors:
      app: openshift-apiserver-a
  mode: all
  action: partition
  direction: both
  externalTargets:
    - $nodeDNS
EOF