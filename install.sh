#!/bin/bash
set -euo pipefail

USAGE="
Install MATLAB using Ansible.

USAGE
    install.sh <systemname> <target> <version>

EXAMPLES
    # Install MATLAB version r2023b to Puhti:

    install.sh puhti matlab-puhti r2023b
"

case ${1:-} in
    local|localhost)
        GROUPNAME=group_localhost
        ;;
    puhti)
        GROUPNAME=group_puhti
        ;;
    lumi)
        GROUPNAME=group_lumi
        ;;
    help|-h|--help)
        echo "$USAGE"
        exit 0
        ;;
    *)
        echo "$USAGE" >&2
        exit 1
        ;;
esac
shift 1

TARGET=$1
shift 1

VERSION=$1
shift 1

ansible-playbook -i hosts.yaml -l "$GROUPNAME" -e "version=$VERSION" "$TARGET/install.yaml" "$@"
