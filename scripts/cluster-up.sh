#!/bin/bash

set -e

echo "Creating the cluster..."
terraform -chdir="../terraform" init
terraform -chdir="../terraform" apply -auto-approve


echo "The cluster is ready. Current context:"
kubectl config current-context
