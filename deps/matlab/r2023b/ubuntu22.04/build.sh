#!/usr/bin/env bash
set -euo pipefail
cd "${0%/*}"  # directory of the script
sudo docker build --tag "matlab:r2023b-ubuntu22.04" .
sudo docker save --output "matlab.tar" "matlab:r2023b-ubuntu22.04"
