#!/usr/bin/env bash

# Changes directory to script's location or exits on failure.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

build_podman_puhti() {
    podman build \
        --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_puhti.txt" \
        --tag "localhost/matlab:r2024a-puhti" \
        --file Dockerfile \
        .
}

build_podman_lumi() {
    podman build \
        --build-arg "MLM_LICENSE_FILE=1766@license10.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_lumi.txt" \
        --tag "localhost/matlab:r2024a-lumi" \
        --file Dockerfile \
        .
}

build_apptainer_puhti() {
    apptainer build \
        --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_puhti.txt" \
        matlab-r2024a-puhti.sif \
        matlab.def
}

build_apptainer_lumi() {
    apptainer build \
        --build-arg "MLM_LICENSE_FILE=1766@license10.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_lumi.txt" \
        matlab-r2024a-lumi.sif \
        matlab.def
}

case "$1" in
    puhti) build_apptainer_puhti ;;
    lumi) build_apptainer_lumi ;;
    *) exit 1 ;;
esac
