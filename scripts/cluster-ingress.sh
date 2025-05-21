#!/bin/bash
set -e

echo "Adding Traefik Helm repo..."
helm repo add traefik https://traefik.github.io/charts
helm repo update

echo "Installing Traefik in namespace 'traefik'..."
helm install traefik traefik/traefik \
  --namespace traefik \
  --create-namespace \

echo " Waiting for Traefik to start..."
kubectl rollout status deployment/traefik -n traefik

echo " Traefik is installed and ready."