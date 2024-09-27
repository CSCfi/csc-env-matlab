#!/usr/bin/env bash
podman build \
    --tag "localhost/matlab:R2024a" \
    --file Dockerfile \
    .
