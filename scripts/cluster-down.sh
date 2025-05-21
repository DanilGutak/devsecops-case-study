#!/bin/bash

set -e

echo "Destroying the cluster..."

terraform -chdir="../terraform" destroy -auto-approve

