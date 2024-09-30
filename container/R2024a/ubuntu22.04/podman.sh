#!/usr/bin/env bash
podman build \
    --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
    --build-arg "MPM_INPUT_FILE=./mpm_input_r2024a_puhti.txt" \
    --tag "localhost/matlab:R2024a" \
    --file Dockerfile \
    .
