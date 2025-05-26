# DevSecOps Case Study
This repository corresponds to the work done during preparation for the final stage of selection proccess for DevSecOps Trainee position at Bawag. 

## 1. Overview

### 1.1 Objective
    TODO: copy from task replace with chatgpt

### 1.2 Key Features Implemented
    Comprehensive list of implemented features:
    TODO: chat

## 2. Infrastructure Setup

### 2.1 KIND Multi-Node Cluster via Terraform
As to emulate real life infrastructure setup and follow IaC (Infrastructure as Code) Terraform was used to create the cluster.
    
Possible use to manually run Terraform:

    terraform -chdir="../terraform" init
    terraform -chdir="../terraform" apply -auto-approve
### 2.2 Cluster Topology & Node Roles
As for better availability multi-node structure is required so 1 control and 2 worker nodes were created inside the cluster.
### 2.3 Namespace Structure: dev, test, prod
To simulate real enviroments 3 namespaces were created for 3 intended enviroments: dev, test and prod
### 2.4 Ingress Controller Setup (NGINX)
The Ingress Controller was installed for ArgoCD exposure as well as for main application ingress management. 
### 2.5 TLS Certificates with cert-manager
Cert-manager is used to issue appropriate certificates for both argoCD and main application to enhance security through SSL cerificates.

## 3. GitOps Workflow

### 3.1 Git Repository Structure
The repository has 4 branches:
 - main - all infrastructure and cluster manifests 
 - dev, test, prod for deploying application to corresponding namespaces

### 3.2 Kustomize: Base and Overlays
Kustomize was used to patch the application manifests .
The actual structure of the repository corresponds to the base being the common manifests across different enviroments and overlay being custom configuration based on the enviroment its running it:
    
### 3.3 ArgoCD Configuration & Applications
### 3.4 Promotion Strategy (dev → test → prod)


## 4. Application Architecture
### 4.1 Demo App Overview (Click Counter)
### 4.2 Frontend Details
### 4.3 Backend Details
### 4.4 Database Setup with Postgres (StatefulSet)
### 4.5 Ingress and Service Configuration
### 4.6 Image Tagging & DockerHub Integration

## 5. Security Design
### 5.1 Kubernetes RBAC (dev, test, prod)
### 5.2 ArgoCD RBAC & Policy Mapping
### 5.3 Sealed Secrets Implementation
### 5.4 Network Policies
  ### 5.4.1 Deny-All Defaults
  ### 5.4.2 Ingress and Backend Egress Rules
### 5.5 Pod & Container Hardening
  ### 5.5.1 Security Contexts
  ### 5.5.2 Non-root Users & Capabilities
  ### 5.5.3 Resource Limits
### 5.6 TLS and Encrypted Communication


## 6. Scripts & Automation
### 9.1 cluster-up.sh
### 9.2 cluster-down.sh
### 9.3 cluster-ingress.sh
### 9.4 cluster-cert-manager.sh
### 9.5 cluster-argocd.sh
### 9.6 patch-argocd-rbac.sh
### 9.7 image-publish-[frontend|backend].sh
### 9.8 Makefile Workflow
## 7. How to Run the Whole Setup

## 8. Conclusion
### 11.1 Achievements
### 11.3 Potential Improvements

## 9. Used Resources









We create cluster with 

terraform  init
terraform apply -auto-approve

then create namespaces for cluster
kubectl create namespace dev
kubectl create namespace test
kubectl create namespace prod

or using cluster-up.sh script





we delete it with 
terraform  destroy -auto-approve

or using cluster-down.sh script

in terraform with have logic for cleaning cluster





##argocd 

we create argo cd from repo(use version) then load 3 applications and then we need to change password for admin user

to get password use:
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
and save it into password manager keepass for example


to rotate password:
kubectl -n argocd delete secret argocd-initial-admin-secret
argocd account update-password



for correct redir and local functioning add this to your /etc/hosts

127.0.0.1       argocd.local
127.0.0.1       click.dev.local
127.0.0.1       click.test.local
127.0.0.1       click.prod.local





to push application to dockerhub you can use image-publish-backend.sh and image-publish-frontend.sh


Images were built from hardened base images:
- Backend: node:18-alpine
- Frontend: node:18-alpine
- Postgres: postgres:15

Used trivy for analysing vulnerabilities


All workloads follow Kubernetes Pod Security Standards:

Containers run as non-root (runAsNonRoot)

Default seccomp profiles enforced

Filesystem is read-only where possible

ArgoCD and PostgreSQL security contexts are applied

No :latest image tags used

Resource limits and requests defined

All secrets are sealed and managed per environment
