# csc-env-matlab

Documentation for Roihu and LUMI installation is available on [matlab](https://docs.csc.fi/apps/matlab/) and [matlab-parallel-server](https://docs.csc.fi/apps/matlab-parallel-server/) pages.

The container definitions use the official [MATLAB container dependencies](https://github.com/mathworks-ref-arch/container-images) and the [MATLAB Package Manager (MPM)](https://github.com/mathworks-ref-arch/matlab-dockerfile) to install MATLAB and all available toolboxes on Linux.
The installation also includes the [MATLAB Proxy](https://github.com/mathworks/matlab-proxy) for an HTML-based web interface.
We also install and use the [administered MathWorks Service Host](https://github.com/mathworks-ref-arch/administer-mathworks-service-host/).

We use Ansible playbooks to install the containerized MATLAB on the clusters.
The MathWorks ServiceHost is installed with the `servicehost.yaml` playbook (see below).

## Install MATLAB on a cluster

Run the root `install.yaml` from the repository root. The `system` picks the target host group and the `version` picks the release:

```bash
ansible-playbook -i hosts.yaml -e system=<lumi|roihu_cpu|roihu_gpu> -e version=<release> install.yaml
```

For example, to install R2025a on Roihu CPU:

```bash
ansible-playbook -i hosts.yaml -e system=roihu_cpu -e version=r2025a install.yaml
```

The `system` and `version` are required. The `version` must have a directory at `system/<system>/version/<release>/`. List the available releases with:

```bash
ls system/<system>/version/
```

Dry-run first to see what would change on the target, without changing anything:

```bash
ansible-playbook --check --diff -i hosts.yaml -e system=<system> -e version=<release> install.yaml
```

These playbooks write to shared `/appl` trees on production hosts. Run them only with explicit approval, and check the target system and version first.

## Build and run the MATLAB container

Build the container image (replace `r2025a/rockylinux9/x86_64` with the release and architecture you need):

```bash
make --directory=matlab/r2025a/rockylinux9/x86_64
```

Run the container:

```bash
apptainer exec --bind=/run/user matlab/r2025a/rockylinux9/x86_64/matlab.sif matlab
```

Run with custom license file or license server:

```bash
apptainer exec --bind=/run/user --env="MLM_LICENSE_FILE=<license-file-or-server>" matlab/r2025a/rockylinux9/x86_64/matlab.sif matlab
```

Start MATLAB Proxy:

```bash
apptainer exec --bind=/run/user matlab/r2025a/rockylinux9/x86_64/matlab.sif matlab-proxy-app
```

## Install the MathWorks Service Host

Install the squashfs file of the [administered MathWorks Service Host](https://github.com/mathworks-ref-arch/administer-mathworks-service-host/) used with the MATLAB container. The playbook builds it on the target into `{{ appl_dir }}/mathworks/servicehost`:

```bash
ansible-playbook -i hosts.yaml -l roihu_cpu -e version=2026.3.0.6 servicehost.yaml
```

Use the squashfs with the container:

```bash
apptainer exec \
    --bind=/run/user \
    --bind={{ appl_dir }}/mathworks/servicehost/mathworksservicehost.sqfs:/opt/mathworksservicehost:image-src=/ \
    --env=MATHWORKS_SERVICE_HOST_MANAGED_INSTALL_ROOT=/opt/mathworksservicehost \
    matlab/r2025a/rockylinux9/x86_64/matlab.sif matlab
```
