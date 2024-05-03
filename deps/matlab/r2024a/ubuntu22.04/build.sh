#!/usr/bin/env bash
set -euo pipefail

# directory of the script
cd "${0%/*}"

# Build the container
podman build --tag "ghcr.io/cscfi/matlab:r2024a-ubuntu22.04" .

# Login to GitHub container registry
# Prompts for an access token
podman login -u cscfi ghcr.io

# Push the container
podman push "ghcr.io/cscfi/matlab:r2024a-ubuntu22.04"
