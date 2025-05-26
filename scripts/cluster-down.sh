#!/bin/bash

set -e

echo "Destroying the cluster..."
terraform init

terraform -chdir="../terraform" destroy -auto-approve



