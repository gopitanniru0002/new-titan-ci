nano ci_install.sh

#!/bin/bash

# This script will install Git, Docker, Docker Compose, GitHub CLI, AWS CLI, and Apache2 on Ubuntu

# Update and upgrade the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install Git
echo "Installing Git..."
sudo apt install -y git

# Install Docker (Stable version from Docker's official repo)
echo "Installing Docker..."
# Install required dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Add Docker's official stable repository
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Install Docker from the repository
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Install Docker-Compose (latest stable release)
echo "Installing Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Enable Docker service to start on boot
echo "Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

# Install GitHub CLI (gh)
echo "Installing GitHub CLI..."
# Add GitHub CLI's GPG key
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /usr/share/keyrings/githubcli-archive-keyring.gpg > /dev/null

# Add GitHub CLI repository
echo "deb [signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# Update the package index and install GitHub CLI
sudo apt update
sudo apt install gh

# Install curl (required for GitHub Actions)
echo "Installing curl..."
sudo apt install -y curl

# Install AWS CLI
echo "Installing AWS CLI..."

# Download the AWS CLI version 2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"

# Unzip the downloaded file
unzip awscliv2.zip

# Install AWS CLI
sudo ./aws/install

# Verify AWS CLI installation
echo "Verifying AWS CLI installation..."
aws --version

# Clean up installation files
echo "Cleaning up installation files..."
rm -f awscliv2.zip
rm -rf aws

# Install Apache2
echo "Installing Apache2..."
sudo apt install -y apache2

# Verify Apache2 installation
echo "Verifying Apache2 installation..."
apache2 -v

# Enable Apache2 service to start on boot
echo "Enabling Apache2 service..."
sudo systemctl enable apache2
sudo systemctl start apache2

# Verify installations
echo "Verifying installations..."

# Check if Git is installed
git --version
if [ $? -eq 0 ]; then
    echo "Git installation successful!"
else
    echo "Git installation failed."
fi

# Check if Docker is installed
docker --version
if [ $? -eq 0 ]; then
    echo "Docker installation successful!"
else
    echo "Docker installation failed."
fi

# Check if Docker Compose is installed
docker-compose --version
if [ $? -eq 0 ]; then
    echo "Docker Compose installation successful!"
else
    echo "Docker Compose installation failed."
fi

# Check if GitHub CLI is installed
gh --version
if [ $? -eq 0 ]; then
    echo "GitHub CLI installation successful!"
else
    echo "GitHub CLI installation failed."
fi

# Check if AWS CLI is installed
aws --version
if [ $? -eq 0 ]; then
    echo "AWS CLI installation successful!"
else
    echo "AWS CLI installation failed."
fi

# Check if Apache2 is installed
apache2 -v
if [ $? -eq 0 ]; then
    echo "Apache2 installation successful!"
else
    echo "Apache2 installation failed."
fi

# Finished installation
echo "Installation complete!"
