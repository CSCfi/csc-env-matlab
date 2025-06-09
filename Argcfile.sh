#!/usr/bin/env bash

set -e

# @cmd Build MATLAB container in SIF format
# @meta require-tools apptainer
# @option --version![=r2024b|r2024a|r2023b]
# @option --proxy-version=0.23.1
# @option --os-version=ubuntu22.04
build-matlab-sif() {
    cd ./containers/${argc_version}/${argc_os_version} && \
    apptainer build \
        --build-arg "MATLAB_PROXY_VERSION=${argc_proxy_version}" \
        matlab.sif \
        matlab.def
}

# @cmd Build MATLAB container in OCI format
# @meta require-tools podman
# @option --version![=r2024b|r2024a|r2023b]
# @option --proxy-version=0.23.1
# @option --os-version=ubuntu22.04
build-matlab-oci() {
    cd ./containers/${argc_version}/${argc_os_version} && \
    podman build \
        --build-arg "MATLAB_PROXY_VERSION=${argc_proxy_version}" \
        --tag "localhost/matlab:${argc_version}" \
        --file "Dockerfile" \
        .
}

# @cmd Install MATLAB container and modulefiles
# @meta require-tools ansible-playbook
# @option --system![puhti|lumi]
# @option --version![=r2024b|r2024a|r2023b]
install-matlab() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "version=${argc_version}" \
        "./system/${argc_system}/install.yaml" "$@"
}

# @cmd Install MathWorks ServiceHost
# @meta require-tools ansible-playbook
# @option --system![puhti|lumi]
# @option --version=2024.13.0.2
install-servicehost() {
    local LATEST_VERSION
    LATEST_VERSION=$(curl --silent https://raw.githubusercontent.com/mathworks-ref-arch/administer-mathworks-service-host/refs/heads/main/admin-scripts/linux/admin-controlled-installation/latest_release.txt)
    if [ "${argc_version}" != "${LATEST_VERSION}" ]; then
        echo "Latest version: ${LATEST_VERSION}. Currently using version: ${argc_version}."
    fi
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "version=${argc_version}" \
        "./servicehost/install.yaml" "$@"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
