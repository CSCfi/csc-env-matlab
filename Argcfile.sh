#!/usr/bin/env bash

set -e

# @cmd Build MATLAB container in SIF format
# @meta require-tools apptainer
# @option --version![=r2024b|r2024a|r2023b]
# @option --proxy-version=0.23.1
# @option --os-version=ubuntu22.04
build-matlab-sif() {
    apptainer build \
        --build-arg "MATLAB_PROXY_VERSION=${argc_proxy_version}" \
        "./containers/${argc_version}/${argc_os_version}/matlab.sif" \
        "./containers/${argc_version}/${argc_os_version}/matlab.def"
}

# @cmd Build MATLAB container in OCI format
# @meta require-tools podman
# @option --version![=r2024b|r2024a|r2023b]
# @option --proxy-version=0.23.1
# @option --os-version=ubuntu22.04
build-matlab-oci() {
    podman build \
        --build-arg "MATLAB_PROXY_VERSION=${argc_proxy_version}" \
        --tag "localhost/matlab:${argc_version}" \
        --file "./containers/${argc_version}/${argc_os_version}/Dockerfile" \
        "./containers/${argc_version}/${argc_os_version}"
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

# @cmd Install Mathworks ServiceHost
# @meta require-tools ansible-playbook
# @option --system![puhti|lumi]
# @option --version=2024.13.0.2
install-servicehost() {
    # TODO: check whether newer version is available
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "version=${argc_version}" \
        "./servicehost/install.yaml" "$@"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
