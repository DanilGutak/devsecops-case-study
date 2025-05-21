#!/bin/bash

set -e
# ArgoCD installation
if ! kubectl get ns | grep -q argocd
then
    echo "Installing ArgoCD..."
    kubectl create namespace argocd
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v3.0.3/manifests/install.yaml
else
    echo "ArgoCD already installed"
fi

sleep 5
kubectl wait --for=condition=available --timeout=600s deployment/argocd-server -n argocd
echo "ArgoCD server is up and running"

echo "Applying ArgoCD config..."
kubectl apply -f ../argocd/applications.yaml

echo "Apply rbac config..."
kubectl apply -f ../argocd/argo-cmkubectl apply -f argocd/argocd-cm.yaml