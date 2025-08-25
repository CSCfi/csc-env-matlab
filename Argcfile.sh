#!/usr/bin/env bash

set -e

# @cmd Install MATLAB container and modulefiles
# @meta require-tools ansible-playbook
# @option --system![puhti|mahti|lumi]
# @option --version![=r2024b|r2025a|r2024a|r2023b]
install-matlab() {
    ansible-playbook \
        -i hosts.yaml \
        -l "${argc_system}" \
        -e "version=${argc_version}" \
        "./system/${argc_system}/install.yaml" "$@"
}

# @cmd Update MathWorks ServiceHost
print-latest-servicehost() {
    VERSION=$(curl --silent https://raw.githubusercontent.com/mathworks-ref-arch/administer-mathworks-service-host/refs/heads/main/admin-scripts/linux/admin-controlled-installation/latest_release.txt)
    echo "$VERSION"
    CHECKSUM=$(curl --silent https://ssd.mathworks.com/supportfiles/downloads/MathWorksServiceHost/v${VERSION}/release/glnxa64/managed_mathworksservicehost_${VERSION}_package_glnxa64.zip | sha256sum)
    echo "$CHECKSUM"
}

# @cmd Install MathWorks ServiceHost
# @meta require-tools ansible-playbook
# @option --system![puhti|mahti|lumi]
# @option --version![2025.3.0.2|2024.13.0.2]
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
