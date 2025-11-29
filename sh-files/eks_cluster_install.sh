

#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Variables
CLUSTER_NAME="new-titan-ci-one"
REGION="us-east-1"
NODEGROUP_NAME="new-titan-ci-nodegroup-one"
NODE_TYPE="t2.small"
NODES=1
NODES_MIN=1
NODES_MAX=3
K8S_VERSION="1.29"

# Step 1: Create EKS Cluster with Managed Node Group
echo "Creating EKS cluster: $CLUSTER_NAME in region: $REGION"
eksctl create cluster \
  --name $CLUSTER_NAME \
  --region $REGION \
  --version $K8S_VERSION \
  --nodegroup-name $NODEGROUP_NAME \
  --node-type $NODE_TYPE \
  --nodes $NODES \
  --nodes-min $NODES_MIN \
  --nodes-max $NODES_MAX \
  --managed

# Step 2: Update kubeconfig for kubectl
echo "Updating kubeconfig for cluster: $CLUSTER_NAME"
aws eks update-kubeconfig --name $CLUSTER_NAME --region $REGION

# Step 3: Verify cluster and nodes
echo "Verifying EKS cluster and nodes"
kubectl get svc
kubectl get nodes

