kubectl create secret generic postgres-secret --namespace dev  --from-literal=POSTGRES_DB=changeme  --from-literal=POSTGRES_USER=changeme  --from-literal=POSTGRES_PASSWORD=changeme  --dry-run=client -o yaml > postgres-secret-dev.yaml

kubeseal --controller-namespace kube-system --format yaml < postgres-secret-dev.yaml > sealed-postgres-dev.yaml