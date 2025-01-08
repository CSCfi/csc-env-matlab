#!/usr/bin/env bash

set -e

# @cmd Build MATLAB container
# @meta require-tools apptainer
# @option --version![=r2024b|r2024a|r2023b]
build-matlab() {
    echo TODO build-matlab
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
install-servicehost() {
    echo TODO install-servicehost
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
