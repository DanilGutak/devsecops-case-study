SHELL := /bin/bash

.PHONY: all  cluster cert-manager argocd ingress clean

all:  cluster cert-manager argocd ingress

# Applies core namespaces, ArgoCD, etc.
cluster:
	@echo "Bootstrapping cluster resources..."
	bash cluster-up.sh
ingress:
	@echo "Bootstrapping Ingress..."
	bash cluster-ingress.sh
secret:
	@echo "Bootstrapping Secrets..."
	bash cluster-secret-manager.sh
argocd:
	@echo "Bootstrapping ArgoCD..."
	bash cluster-argocd.sh
cert-manager:
	@echo "Bootstrapping Cert-Manager..."
	bash cluster-cert-manager.sh
clean:
	@echo "Cleaning up cluster resources..."
	bash cluster-down.sh
