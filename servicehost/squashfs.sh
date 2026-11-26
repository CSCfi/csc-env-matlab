#!/usr/bin/env bash
set -eu
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT
mkdir -p "$TMP_DIR/$MSH_VERSION"
unzip "$ZIP_FILE" -d "$TMP_DIR/$MSH_VERSION"
{
    echo "LatestDSInstallerVersion ${MSH_VERSION}"
    echo "LatestDSInstallRoot ${ROOT_DIR}/${MSH_VERSION}"
    echo "DSLauncherExecutable ${ROOT_DIR}/${MSH_VERSION}/bin/glnxa64/MathWorksServiceHost"
} >>"$TMP_DIR/LatestInstall.info"
mksquashfs "$TMP_DIR" "$SQFS_FILE" -all-root
