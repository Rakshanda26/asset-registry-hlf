#!/bin/bash

REPO_URL="https://github.com/Rakshanda26/asset-registry-hlf.git"
TARGET_DIR="/home/ubuntu/challenge"

echo "Starting setup..."

mkdir -p $TARGET_DIR

echo "Cloning repository..."
git clone $REPO_URL $TARGET_DIR

if [ $? -ne 0 ]; then
  echo "Failed to clone repository"
  exit 1
fi

echo "Installing system dependencies..."
apt-get update -y
apt-get install -y curl jq git docker.io docker-compose

echo "Starting docker..."
systemctl start docker || service docker start

echo "Installing Go..."

GO_VERSION="1.20.5"
curl -L https://golang.org/dl/go${GO_VERSION}.linux-amd64.tar.gz -o go.tar.gz
tar -xzf go.tar.gz
mv go /usr/local/

export PATH=$PATH:/usr/local/go/bin
ln -s /usr/local/go/bin/go /usr/local/bin/go

rm go.tar.gz

echo "Installing Hyperledger Fabric binaries..."

FABRIC_VERSION="2.4.7"

curl -L https://github.com/hyperledger/fabric/releases/download/v${FABRIC_VERSION}/hyperledger-fabric-linux-amd64-${FABRIC_VERSION}.tar.gz -o fabric.tar.gz

tar -xzf fabric.tar.gz

cp bin/* /usr/local/bin/

rm -rf bin builders config fabric.tar.gz

echo "Fixing permissions..."

chmod +x $TARGET_DIR/test-network/network.sh
chmod +x $TARGET_DIR/test-network/scripts/*.sh
chmod -R +x $TARGET_DIR/test-network

echo "Setup completed successfully."
