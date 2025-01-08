# csc-env-matlab

This repository contains MATLAB containers designed for use in High-Performance Computing (HPC) clusters.
The container definitions use the official [MATLAB container dependencies](https://github.com/mathworks-ref-arch/container-images) and the [MATLAB Package Manager (MPM)](https://github.com/mathworks-ref-arch/matlab-dockerfile) to install MATLAB and all available toolboxes on Linux.
The installation also includes the [MATLAB Proxy](https://github.com/mathworks/matlab-proxy) for an HTML-based web interface.
We also install and use the [administered MathWorks Service Host](https://github.com/mathworks-ref-arch/administer-mathworks-service-host/).
We use Ansible playbooks to install the containerized MATLAB on the clusters.
Commands to build the containers, install MATLAB environment and MathWorks ServiceHost is in the `Argcfile.sh` which uses [argc](https://github.com/sigoden/argc).
Use the `argc --help` for more information.

To run with the default license:

```bash
apptainer exec --bind /run/user ./containers/r2024b/ubuntu22.04/matlab.sif matlab
```

To run with a custom license:

```bash
apptainer exec --bind /run/user --env "MLM_LICENSE_FILE=<path-to-license>" ./containers/r2024b/ubuntu22.04/matlab.sif matlab
```

Documentation for Puhti and LUMI installation is available on [documentation](https://docs.csc.fi/apps/matlab/).
