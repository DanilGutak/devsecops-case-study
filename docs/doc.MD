# DevSecOps Case Study
This repository corresponds to the work done during preparation for the final stage of selection proccess for DevSecOps Trainee position at Bawag. 

## 1. Overview

### 1.1 Objective
  To design and deploy a secure, automated Kubernetes development environment using KIND and GitOps, featuring separate dev, test, and prod namespaces. The goal is to implement a click counter demo app and enforce security best practices—such as RBAC, secret encryption, and vulnerability scanning—while managing everything declaratively via Git.

### 1.2 Key Features Implemented
  Comprehensive list of implemented features:
  - Automated cluster setup with Terraform and KIND

  - Three namespaces: dev, test, prod

  - GitOps deployment via ArgoCD and Kustomize overlays

  - Click counter app (frontend, backend, PostgreSQL)

  - RBAC for namespace and ArgoCD access control

  - Sealed Secrets for encrypted sensitive data

  - TLS/HTTPS via cert-manager and Ingress

  - NetworkPolicies to restrict internal traffic

  - SecurityContext hardening for all pods

  - Shell scripts for full automation

  - Documentation with diagrams and screenshots

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
### 2.6 Automation Scripts
Scripts in the scripts folder as well as makefile to consolidate them are used to have documented version of the infrastructure setup and cluster configuration.  

## 3. GitOps Workflow

### 3.1 Git Repository Structure
The repository has 4 branches:
 - main - all infrastructure and cluster manifests 
 - dev, test, prod for deploying application to corresponding namespaces

### 3.2 Kustomize: Base and Overlays
Kustomize was used to patch the application manifests .
The actual structure of the repository corresponds to the base being the common manifests across different enviroments and overlay being custom configuration based on the enviroment its running it:
    ├── manifests
    │   ├── base
    │   │   ├── backend-deployment.yaml
    │   │   ├── backend-service.yaml
    │   │   ├── frontend-deployment.yaml
    │   │   ├── frontend-service.yaml
    │   │   ├── kustomization.yaml
    │   │   ├── network-policy.yaml
    │   │   └── postgres-statefulset.yaml
    │   └── overlays
    │       ├── frontend-ingress.yaml
    │       ├── kustomization.yaml
    │       ├── patch-backend.yaml
    │       ├── patch-frontend.yaml
    │       ├── rbac
    │       │   ├── dev-role-binding.yaml
    │       │   ├── dev-role.yaml
    │       │   └── dev-service-account.yaml
    │       └── sealed-postgres-dev.yaml

        
### 3.3 ArgoCD Configuration & Applications
ArgoCD is listening for 3 branches in the repository and deploys any changes occuring to corresponding env.

### 3.4 Promotion Strategy
As a suggestion and practice to be followed the following promotion strategy for the new feature implementations should follow through  (dev → test → prod) pipeline conducting QA and checks before promoting changes to new enviroment.
### 3.5 Argo CD Chart
The following screenshot represent the structure of the application as seen on argoCD UI:
TODO: screenshot of the app



## 4. Application Architecture
### 4.1 Demo App Overview (Click Counter)
TODO: screenshot from the app
TODO: Schema of logic
### 4.2 Frontend Details

### 4.3 Backend Details

### 4.4 Database Setup with Postgres (StatefulSet)
As a db solution Postgres was chosen implemented as StatefulSet with attached PVC to keep the data persistent. Sealed Secrets were used for login credentials.
### 4.5 Ingress and Service Configuration
The Ingress for the application exposes the port 443 as the external access. Frontend and backend communicate through ingress while backend and postgres are communicating through internal communication.

## 5. Security Design
### 5.1 Kubernetes RBAC (dev, test, prod)
TODO: add table
### 5.2 ArgoCD RBAC & Policy Mapping
TODO: add table
### 5.3 Sealed Secrets Implementation
The secret there sealed using bitnami secret controller offering advance solution to secret handling compared to default solution. Secrets are sealed using the controller so that they cannot be decrypted without it. This allows to push sealed secrets to the cluster without risking an exposure.
### 5.4 Network Policies
The Deny-all default config were introduce to reduce potential threats. 
### 5.5 Pod & Container Hardening


### 5.6 TLS and Encrypted Communication



## 6. How to Run the Whole Setup

## 7. Conclusion
### 7.1 Achievements
### 7.2 Potential Improvements

## 8. Used Resources

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
