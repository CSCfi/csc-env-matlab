# csc-env-matlab

This repository contains MATLAB containers designed for use in High-Performance Computing (HPC) clusters.
The container definitions use the official [MATLAB container dependencies](https://github.com/mathworks-ref-arch/container-images) and the [MATLAB Package Manager (MPM)](https://github.com/mathworks-ref-arch/matlab-dockerfile) to install MATLAB and all available toolboxes on Linux.
The installation also include the [MATLAB Proxy](https://github.com/mathworks/matlab-proxy) for an HTML-based web interface.

Containers can be built and run using Apptainer or Singularity.

We use Ansible playbooks to install the containerized MATLAB on the clusters.

To run with the default license:

```bash
apptainer exec --bind /run/user matlab.sif matlab
```

To run with a custom license:

```bash
apptainer exec --bind /run/user --env "MLM_LICENSE_FILE=<path-to-license>" matlab.sif matlab
```

Documentation for Puhti and LUMI instllatio available on [documentation](https://docs.csc.fi/apps/matlab/).
