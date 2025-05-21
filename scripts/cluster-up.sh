#!/bin/bash

set -e

echo "Creating the cluster..."
terraform -chdir="../terraform" init
terraform -chdir="../terraform" apply -auto-approve

echo "Cluster created. Creating namespaces..."
kubectl create namespace dev
kubectl create namespace test
kubectl create namespace prod

echo "The cluster is ready. Current context:"
kubectl config current-context

