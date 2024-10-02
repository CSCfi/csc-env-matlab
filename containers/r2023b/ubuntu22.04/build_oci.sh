#!/usr/bin/env bash

# Changes directory to script's location or exits on failure.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

build_podman_puhti() {
    podman build \
        --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2023b_puhti.txt" \
        --tag "localhost/matlab:r2023b-puhti" \
        --file Dockerfile \
        .
}

build_podman_lumi() {
    podman build \
        --build-arg "MLM_LICENSE_FILE=1766@license10.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2023b_lumi.txt" \
        --tag "localhost/matlab:r2023b-lumi" \
        --file Dockerfile \
        .
}

case "$1" in
    puhti) build_podman_puhti ;;
    lumi) build_podman_lumi ;;
    *) exit 1 ;;
esac
