SHELL := /bin/bash

.PHONY: all  cluster cert-manager argocd ingress clean

all:  cluster traefik cert-manager argocd ingress

# Applies core namespaces, ArgoCD, etc.
cluster:
	@echo "Bootstrapping cluster resources..."
	bash cluster-up.sh
traefik:
	@echo "Bootstrapping Traefik..."
	bash cluster-ingress.sh
argocd:
	@echo "Bootstrapping ArgoCD..."
	bash cluster-argocd.sh
cert-manager:
	@echo "Bootstrapping Cert-Manager..."
	bash cluster-cert-manager.sh
clean:
	@echo "Cleaning up cluster resources..."
	bash cluster-down.sh
