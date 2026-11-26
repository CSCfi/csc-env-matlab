# AGENTS.md

Guidance for AI agents working in this repository. `CLAUDE.md` is a symlink to this file.

## What this repo is

Install recipes for containerized MATLAB on CSC and partner HPC systems:

- **LUMI** (`lumi`, x86_64)
- **Roihu CPU** (`roihu_cpu`, x86_64)
- **Roihu GPU** (`roihu_gpu`, aarch64)

Installation is driven by Ansible. The container definitions build on the MathWorks container images and MPM (MATLAB Package Manager), and include MATLAB Proxy and the MathWorks Service Host. User-facing docs live at https://docs.csc.fi/apps/matlab/.

## Layout

- `Argcfile.sh`: entry point for all tasks, run through [argc](https://github.com/sigoden/argc). Run `argc --help` to list commands.
  - `install-matlab --system <lumi|roihu_cpu|roihu_gpu> --version <release>`: runs `system/<system>/install.yaml` with `hosts.yaml`.
  - `print-latest-servicehost`: prints the latest Service Host version and checksum.
  - `install-servicehost --system lumi --version <version>`: runs `servicehost/install.yaml`. Defaults to 2026.3.0.6 and warns if that is not the latest release.
- `hosts.yaml`: inventory. Hostnames, interpreter paths, group, and install dirs per system.
- `system/<system>/install.yaml`: per-system Ansible playbook. It creates directories, copies scripts, and runs the version-specific install.
- `system/<system>/version/<release>/`: per-release files. `matlab.lua` or `matlab.lua.j2` is the modulefile, `extract_binaries.sh` extracts binaries, and `bin/` holds launch wrappers (`matlab`, `matlab-proxy-app`, `worker.j2`, `matlab-apptainer-exec.j2` or `matlab-singularity-exec.j2`). Files with `.j2` are Jinja2 templates.
- `servicehost/`: Service Host install playbook, templates, and per-version YAML (`version/<release>.yaml`).
- `mathworks/`: container build material. `matlab/<release>/` builds include MATLAB Proxy. `servicehost/` has a Makefile and `squashfs.sh`.
- `license/`: license server config for the CSC and LUMI academic licenses (Lua).
- `test/`: smoke tests run after installation. `test/mps/` covers parallel pools (serial, threads, processes, GPU), and `test/mex/` covers MEX builds.
- `extras/`: extra MATLAB config (`mpiLibConf.m`).
- `config/`: desktop launcher material (`csc.Desktop.zip`).

## Conventions

- Adding a MATLAB release means adding `system/<system>/version/<release>/` for each system it targets, and registering the release in the `--version` list in `Argcfile.sh`. Copy the closest existing release directory rather than writing from scratch.
- Keep the `system/*/version/*` layout consistent across systems. The three systems differ by architecture and paths, which `hosts.yaml` holds.
- Templates (`.j2`) are rendered by Ansible. Edit the template, not any rendered output.
- Shared install directories are group-writable with the setgid bit (`ug=rwx,o=rx,g+s`). Keep that mode when adding directories.
- Do not commit container images or artifacts. `.gitignore` already excludes `*.sif`, `*.sqfs`, `*.tar`, `*.tar.gz`, `*.sha256`, and `.tmp/`.

## Safety

- The playbooks run against production login and installation hosts (`*.csc.fi`) and write to shared `/appl` trees. Do not run `install-matlab` or `install-servicehost` without explicit user approval, and always check the target system and version first.
- Do not edit or delete files under an installed version directory on a cluster. Changes go through the repo and a new install.
- Do not put license files, credentials, or host secrets in the repo.

## Verification

- There is no automated test suite for the playbooks. Lint or dry-run changes with `ansible-playbook --check --diff -i hosts.yaml -l <system> -e version=<release> system/<system>/install.yaml` before a real run.
- After a real install, run the scripts in `test/mps/` on the target system to check parallel pools and GPU use.
- Use `uv` for any Python tooling added to the repo, not bare `pip`.
