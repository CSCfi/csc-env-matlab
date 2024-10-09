#!/usr/bin/env bash

# Changes directory to script's location or exits on failure.
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

build_apptainer_support() {
    apptainer build \
        --build-arg "MLM_LICENSE_FILE=" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./support/mpm_input_r2024b.txt" \
        ./support/matlab-r2024b.sif \
        matlab.def
}

build_apptainer_puhti() {
    apptainer build \
        --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./puhti/mpm_input_r2024b.txt" \
        ./puhti/matlab-r2024b.sif \
        matlab.def
}

build_apptainer_lumi() {
    apptainer build \
        --build-arg "MLM_LICENSE_FILE=1766@license10.csc.fi" \
        --build-arg "MATLAB_PROXY_VERSION=0.23.1" \
        --build-arg "MPM_INPUT_FILE=./lumi/mpm_input_r2024b.txt" \
        ./lumi/matlab-r2024b.sif \
        matlab.def
}

case "$1" in
    support) build_apptainer_support ;;
    puhti) build_apptainer_puhti ;;
    lumi) build_apptainer_lumi ;;
    *) exit 1 ;;
esac
