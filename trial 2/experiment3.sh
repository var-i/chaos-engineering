cat <<EOF | kubectl apply -f -
apiVersion: chaos-mesh.org/v1alpha1
kind: Workflow
metadata:
  name: experiment3
  namespace: 'chaos'
spec:
  entry: experiment3
  templates:
    - name: experiment3
      templateType: Parallel
      children:
        - currency-delay
        - argo-delay
    - name: currency-delay
      templateType: NetworkChaos
      deadline: 30m
      networkChaos:
        action: delay
        target:
          selector:
            namespaces:
              - $namespace
            labelSelectors:
              app.kubernetes.io/component: currencyservice
              app.kubernetes.io/component: productcatalogservice
          mode: all
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: frontend
        mode: all
        delay:
          latency: 5s
        direction: both
    - name: argo-delay
      templateType: NetworkChaos
      deadline: 30m
      networkChaos:
        action: delay
        target:
          selector:
            namespaces:
              - core-argocd
            labelSelectors:
              app.kubernetes.io/component: application-controller
          mode: all
        selector:
          namespaces:
            - core-argocd
          labelSelectors:
            app.kubernetes.io/component: server
        mode: all
        delay:
          latency: 5s
        direction: both
EOF