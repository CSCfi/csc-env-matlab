#!/usr/bin/env bash
set -euo pipefail

# directory of the script
cd "${0%/*}"

# Build the container
sudo podman build --tag "ghcr.io/cscfi/matlab-proxy:r2023b-ubuntu22.04" .

# Login to GitHub container registry
# Prompts for an access token
sudo podman login -u cscfi ghcr.io

# Push the container
sudo podman push "ghcr.io/cscfi/matlab-proxy:r2023b-ubuntu22.04"
