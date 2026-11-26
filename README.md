# csc-env-matlab

Documentation for Roihu and LUMI installation is available on [matlab](https://docs.csc.fi/apps/matlab/) and [matlab-parallel-server](https://docs.csc.fi/apps/matlab-parallel-server/) pages.

The container definitions use the official [MATLAB container dependencies](https://github.com/mathworks-ref-arch/container-images) and the [MATLAB Package Manager (MPM)](https://github.com/mathworks-ref-arch/matlab-dockerfile) to install MATLAB and all available toolboxes on Linux.
The installation also includes the [MATLAB Proxy](https://github.com/mathworks/matlab-proxy) for an HTML-based web interface.
We also install and use the [administered MathWorks Service Host](https://github.com/mathworks-ref-arch/administer-mathworks-service-host/).

We use Ansible playbooks to install the containerized MATLAB on the clusters.
Commands to build the containers and install the MATLAB environment are in the `Argcfile.sh` and we can invoke them using [argc](https://github.com/sigoden/argc).
Use the `argc --help` for more information.
The MathWorks ServiceHost is installed with the `servicehost.yaml` playbook (see below).

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
