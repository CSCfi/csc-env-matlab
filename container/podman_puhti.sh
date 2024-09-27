#!/usr/bin/env bash

MATLAB_RELEASE="R2024a"

MATLAB_PRODUCT_LIST="MATLAB MATLAB_Parallel_Server Parallel_Computing_Toolbox"

MATLAB_LICENSE_SERVER="1766@license4.csc.fi"

podman build \
    --build-arg "MATLAB_RELEASE=${MATLAB_RELEASE}" \
    --build-arg "MATLAB_PRODUCT_LIST=${MATLAB_PRODUCT_LIST}" \
    --build-arg "MATLAB_LICENSE_SERVER=${MATLAB_LICENSE_SERVER}" \
    --tag "localhost/matlab:${MATLAB_RELEASE}" \
    --file Dockerfile \
    .
