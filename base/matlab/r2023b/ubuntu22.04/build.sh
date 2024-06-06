#!/usr/bin/env bash
set -euo pipefail

# directory of the script
cd "${0%/*}"

# Build the container
podman build --tag "ghcr.io/cscfi/matlab:r2023b-ubuntu22.04" .
