#!/usr/bin/env bash

# Changes directory to script's location or exits on failure.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

build_puhti() {
    podman build \
        --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_puhti.txt" \
        --tag "localhost/matlab:r2024a-puhti" \
        --file Dockerfile \
        .
}

build_lumi() {
    podman build \
        --build-arg "MLM_LICENSE_FILE=1766@license10.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_lumi.txt" \
        --tag "localhost/matlab:r2024a-lumi" \
        --file Dockerfile \
        .
}

case "$1" in
    puhti) build_puhti ;;
    lumi) build_lumi ;;
    *) exit ;;
esac
