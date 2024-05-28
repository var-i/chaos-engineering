cat <<EOF | kubectl apply -f -
kind: IOChaos
apiVersion: chaos-mesh.org/v1alpha1
metadata:
  namespace: $namespace
  name: iodelay
spec:
  selector:
    namespaces:
      - $namespace
    labelSelectors:
      app.kubernetes.io/component: redis
  mode: all
  action: latency
  delay: 500ms
  percent: 100
  volumePath: /data
EOF