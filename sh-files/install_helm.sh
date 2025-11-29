
#!/bin/bash

# Exit on error
set -e

echo "🔹 Downloading and installing Helm from official source..."

# Official Helm install script
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo "🔹 Helm installation completed!"

# Enable bash completion
echo "🔹 Enabling Helm bash completion..."
helm completion bash | sudo tee /etc/bash_completion.d/helm > /dev/null

# Add alias
echo "alias h=helm" >> ~/.bashrc
echo "🔹 Alias 'h' added for Helm."

# Reload shell settings
source ~/.bashrc

echo "✅ Helm installed and configured successfully!"
