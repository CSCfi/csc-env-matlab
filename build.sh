#!/bin/bash
set -euo pipefail

TYPE=$1
VERSION=$2

apptainer build "$TYPE/$VERSION/matlab.sif" "$TYPE/$VERSION/matlab.def"
