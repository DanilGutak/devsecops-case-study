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


echo "Apply ingress config..."
kubectl apply -f ../argocd/ingress.yaml

#!/bin/bash

set -e

echo "Patching argocd-cm with RBAC settings..."

kubectl patch configmap argocd-cm -n argocd \
  --type merge \
  -p '
data:
  policy.csv: |
    p, role:admin, applications, *, */*, allow
    p, role:readonly, applications, get, */*, allow
    g, administrator, role:admin
    g, reader, role:readonly
  accounts.administrator: apiKey, login
  accounts.reader: apiKey, login
  policy.default: role:readonly
'

kubectl rollout restart deployment argocd-server -n argocd

echo "✅ ArgoCD RBAC patched and restarted"

echo "ArgoCD is ready."