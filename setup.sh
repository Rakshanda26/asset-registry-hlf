#!/bin/bash

# Repo containing the blockchain question
REPO_URL="https://github.com/Rakshanda26/asset-registry-hlf.git"

# Target directory where challenge files will live
TARGET_DIR="/home/ubuntu/challenge"

echo "Starting challenge setup..."

# Create challenge directory
echo "Creating challenge directory..."
mkdir -p $TARGET_DIR

# Clone repository
echo "Cloning repository..."
git clone $REPO_URL $TARGET_DIR

if [ $? -ne 0 ]; then
    echo "Failed to clone repository"
    exit 1
fi

echo "Repository cloned successfully."

# Fix permissions for Hyperledger Fabric scripts
echo "Fixing script permissions..."

chmod +x $TARGET_DIR/test-network/network.sh
chmod +x $TARGET_DIR/test-network/scripts/*.sh

# Ensure all test-network scripts are executable
chmod -R +x $TARGET_DIR/test-network

# Ensure candidate has access
chmod -R 755 $TARGET_DIR

echo "Setup complete. Challenge environment ready."

# Show directory for debugging
echo "Challenge directory structure:"
ls -la $TARGET_DIR
