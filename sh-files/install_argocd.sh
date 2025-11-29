
#!/bin/bash

# ================================
# Script to install ArgoCD using Helm
# ================================

# Step 1: Add Argo Helm repo
echo "Adding Argo Helm repository..."
helm repo add argo https://argoproj.github.io/argo-helm

# Step 2: Update Helm repositories
echo "Updating Helm repositories..."
helm repo update

# Step 3: Create the ArgoCD namespace if it doesn't exist
echo "Creating namespace 'argocd'..."
kubectl create namespace argocd

# Step 4: Install ArgoCD using Helm
echo "Installing ArgoCD using Helm..."
helm install argocd argo/argo-cd --namespace argocd

# Step 5: Check all resources in the argocd namespace
echo "Listing all resources in 'argocd' namespace..."
kubectl get all -n argocd

# Step 6: Expose ArgoCD server with LoadBalancer
echo "Patching ArgoCD service to use LoadBalancer..."
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'

echo "ArgoCD installation completed."
#kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

