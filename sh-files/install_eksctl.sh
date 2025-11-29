
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Install eksctl
echo "Installing eksctl..."
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin

# Step 2: Verify eksctl installation
echo "Verifying eksctl installation..."
eksctl version

echo "eksctl installation completed successfully!"
