#!/usr/bin/env bash

# Changes directory to script's location or exits on failure.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

MATLAB_VERSION=r2024a
MATLAB_PROXY_VERSION=0.23.1

build_sif() {
    apptainer build \
        --build-arg "MATLAB_PROXY_VERSION=$MATLAB_PROXY_VERSION" \
        ./matlab.sif \
        ./matlab.def
}

build_oci() {
    podman build \
        --build-arg "MATLAB_PROXY_VERSION=$MATLAB_PROXY_VERSION" \
        --tag "localhost/matlab:${MATLAB_VERSION}" \
        --file Dockerfile \
        .
}

case "$1" in
    sif) build_sif ;;
    oci) build_oci ;;
    *) exit 1 ;;
esac
