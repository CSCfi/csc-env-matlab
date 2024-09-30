#!/usr/bin/env bash
podman build \
    --build-arg "MLM_LICENSE_FILE=1766@license4.csc.fi" \
    --tag "localhost/matlab:R2024a" \
    --file Dockerfile \
    .
