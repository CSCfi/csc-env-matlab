#!/usr/bin/env bash

set -e

# @cmd Install MATLAB container and modulefiles
# @meta require-tools ansible-playbook
# @option --system![lumi|roihu_cpu|roihu_gpu]
# @option --version![=r2026b|r2026a|r2025b|r2025a|r2024b|r2024a|r2023b]
install-matlab() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "version=${argc_version}" \
        "./system/${argc_system}/install.yaml" "$@"
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
