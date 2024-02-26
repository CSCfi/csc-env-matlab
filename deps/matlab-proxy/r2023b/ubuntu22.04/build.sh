#!/usr/bin/env bash
set -euo pipefail

# directory of the script
cd "${0%/*}"

# Build the container
sudo docker build --tag "ghcr.io/cscfi/matlab-proxy:r2023b-ubuntu22.04" .
