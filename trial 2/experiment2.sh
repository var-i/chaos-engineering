#!/bin/bash

# Get the name of the node where the pod with label "app=frontend" is running
node_name=$(kubectl get pods -A -l app.kubernetes.io/component=frontend -o jsonpath='{.items[0].spec.nodeName}')

if [ -z "$node_name" ]; then
    echo "No pod with label app.kubernetes.io/component=frontend found"
    exit 1
fi

echo "Pod with label app.kubernetes.io/component=frontend is running on node: $node_name"

# Get the OVN pod running on the same node
ovn_pod_name=$(kubectl get pods -l app=ovnkube-node -o json -A | jq -r ".items[] | select(.spec.nodeName==\"$node_name\") | .metadata.name")

if [ -z "$ovn_pod_name" ]; then
    echo "No OVN pod found on node $node_name"
    exit 1
fi

echo "OVN pod on the same node is: $ovn_pod_name"

# Now create the PodChaos resource with the OVN pod name
cat <<EOF | kubectl apply -f -
kind: PodChaos
apiVersion: chaos-mesh.org/v1alpha1
metadata:
    namespace: openshift-ovn-kubernetes
    name: ovn
    annotations:
        experiment.chaos-mesh.org/pause: 'false'
spec:
    selector:
        namespaces:
            - openshift-ovn-kubernetes
        pods:
            openshift-ovn-kubernetes:
                - $ovn_pod_name
    mode: all
    action: pod-failure
EOF

# sleep 
sleep 1

kubectl delete pods -l app.kubernetes.io/component=currencyservice -n $namespace
kubectl delete pods -l app.kubernetes.io/component=productcatalogservice -n $namespace
kubectl delete pods -l app.kubernetes.io/component=cartservice -n $namespace
