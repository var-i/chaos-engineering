cat <<EOF | kubectl apply -f -
kind: PodChaos
apiVersion: chaos-mesh.org/v1alpha1
metadata:
  namespace: openshift-apiserver
  name: machinefailure
spec:
  selector:
    namespaces:
      - openshift-apiserver
    labelSelectors:
      app: openshift-apiserver-a
  mode: one
  action: pod-kill
EOF