#!/usr/bin/env bash
set -euo pipefail

# directory of the script
cd "${0%/*}"

# Build the container
sudo docker build --tag "ghcr.io/cscfi/matlab-proxy:r2023b-ubuntu22.04" .

# Login to GitHub container registry
# Prompts for an access token
sudo docker login -u cscfi ghcr.io

# Push the container
sudo docker push "ghcr.io/cscfi/matlab-proxy:r2023b-ubuntu22.04"
