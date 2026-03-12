#!/bin/bash

# Repo containing the blockchain question
REPO_URL="https://github.com/Rakshanda26/asset-registry-hlf.git"

# Target directory where challenge files will live
TARGET_DIR="/home/ubuntu/challenge"

echo "Creating challenge directory..."
mkdir -p $TARGET_DIR

echo "Cloning repository..."
git clone $REPO_URL $TARGET_DIR

if [ $? -ne 0 ]; then
    echo "Failed to clone repository"
    exit 1
fi

echo "Fixing permissions for scripts..."

# Fix permissions for network and scripts
chmod +x $TARGET_DIR/test-network/network.sh
chmod +x $TARGET_DIR/test-network/scripts/*.sh

# Ensure candidate can access everything
chmod -R 755 $TARGET_DIR

echo "Setup complete. Challenge files ready."
