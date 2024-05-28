cat <<EOF | kubectl apply -f -
apiVersion: chaos-mesh.org/v1alpha1
kind: Workflow
metadata:
  name: scenario1
  namespace: $namespace
spec:
  entry: scenario1
  templates:
    - name: scenario1
      templateType: Parallel
      children:
        - stress-adservice
        - stress-cartservice
        - stress-checkoutservice
        - stress-currencyservice
        - stress-emailservice
        - stress-frontend
        - stress-paymentservice
        - stress-productcatalogservice
        - stress-recommendationservice
        - stress-shippingservice
      deadline: 1h
    - name: stress-adservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: adservice
        mode: all
        stressors:
          memory:
            size: 250MiB
            workers: 3
    - name: stress-cartservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: cartservice
        mode: all
        stressors:
          memory:
            size: 50MiB
            workers: 1
    - name: stress-checkoutservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: checkoutservice
        mode: all
        stressors:
          memory:
            size: 100MiB
            workers: 2
    - name: stress-currencyservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: currencyservice
        mode: all
        stressors:
          memory:
            size: 100MiB
            workers: 2
    - name: stress-emailservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: emailservice
        mode: all
        stressors:
          memory:
            size: 100MiB
            workers: 2
    - name: stress-frontend
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: frontend
        mode: all
        stressors:
          memory:
            size: 100MiB
            workers: 2
    - name: stress-paymentservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: paymentservice
        mode: all
        stressors:
          memory:
            size: 100MiB
            workers: 2
    - name: stress-productcatalogservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: productcatalogservice
        mode: all
        stressors:
          memory:
            size: 800MiB
            workers: 5
    - name: stress-recommendationservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: recommendationservice
        mode: all
        stressors:
          memory:
            size: 200MiB
            workers: 2
    - name: stress-shippingservice
      templateType: StressChaos
      deadline: 1h
      stressChaos:
        selector:
          namespaces:
            - $namespace
          labelSelectors:
            app.kubernetes.io/component: shippingservice
        mode: all
        stressors:
          memory:
            size: 100MiB
            workers: 2
EOF