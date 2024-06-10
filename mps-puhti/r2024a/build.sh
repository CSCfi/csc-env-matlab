#!/usr/bin/env bash
set -euo pipefail

# directory of the script
cd "${0%/*}"

# Build the container
apptainer build matlab.sif matlab.def
