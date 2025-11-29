#!/bin/bash
set -e

# Step 1: Download the latest stable version of kubectl
echo "Downloading kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Step 2: Download the sha256 checksum for kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

# Step 3: Verify the checksum
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# Step 4: Install kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Step 5: Verify kubectl installation
kubectl version --client
