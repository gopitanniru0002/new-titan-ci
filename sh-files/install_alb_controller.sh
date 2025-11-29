
#!/bin/bash
set -e

# ==============================
# Variables (UPDATED FOR YOUR CLUSTER)
# ==============================
CLUSTER_NAME="new-titan-ci-one"
REGION="us-east-1"
ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)
POLICY_NAME="AWSLoadBalancerControllerIAMPolicy"
SERVICE_ACCOUNT="aws-load-balancer-controller"
NAMESPACE="kube-system"

echo "===== Step 0: Checking Kubernetes Context ====="
kubectl config current-context

echo "===== Step 1: Associating IAM OIDC Provider ====="
eksctl utils associate-iam-oidc-provider \
  --region $REGION \
  --cluster $CLUSTER_NAME \
  --approve

echo "===== Step 2: Downloading IAM Policy ====="
curl -o iam_policy.json \
  https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json

echo "===== Step 3: Creating IAM Policy ====="
aws iam create-policy \
  --policy-name $POLICY_NAME \
  --policy-document file://iam_policy.json \
  || echo "IAM policy already exists — continuing..."

echo "===== Step 4: Creating IAM Service Account ====="
eksctl create iamserviceaccount \
  --cluster $CLUSTER_NAME \
  --namespace $NAMESPACE \
  --name $SERVICE_ACCOUNT \
  --attach-policy-arn arn:aws:iam::$ACCOUNT_ID:policy/$POLICY_NAME \
  --approve \
  --override-existing-serviceaccounts

echo "===== Step 5: Installing AWS Load Balancer Controller via Helm ====="
helm repo add eks https://aws.github.io/eks-charts
helm repo update

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n $NAMESPACE \
  --set clusterName=$CLUSTER_NAME \
  --set serviceAccount.create=false \
  --set serviceAccount.name=$SERVICE_ACCOUNT \
  --set region=$REGION \
  --set vpcId=$(aws eks describe-cluster --name $CLUSTER_NAME --region $REGION --query "cluster.resourcesVpcConfig.vpcId" --output text)

echo "===== Step 6: Verifying Installation ====="
kubectl get deployment -n $NAMESPACE aws-load-balancer-controller
