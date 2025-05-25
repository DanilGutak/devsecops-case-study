#!/bin/bash
set -e

echo "Installing cert-manager..."
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml

echo "Waiting for cert-manager pods to be ready..."
kubectl rollout status deployment/cert-manager -n cert-manager
kubectl rollout status deployment/cert-manager-cainjector -n cert-manager
kubectl rollout status deployment/cert-manager-webhook -n cert-manager

echo "cert-manager is installed."


echo "Applying cert-manager configurations..."
kubectl apply -f ../cert-manager/certificate-argocd.yaml
kubectl apply -f ../cert-manager/certificate-dev.yaml
kubectl apply -f ../cert-manager/certificate-prod.yaml
kubectl apply -f ../cert-manager/certificate-test.yaml
kubectl apply -f ../cert-manager/issuer-selfsigned.yaml



