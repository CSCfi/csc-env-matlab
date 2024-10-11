# csc-env-matlab

This repository contains MATLAB containers designed for use in High-Performance Computing (HPC) clusters.
The container definitions use the official [MATLAB container dependencies](https://github.com/mathworks-ref-arch/container-images) and the [MATLAB Package Manager (MPM)](https://github.com/mathworks-ref-arch/matlab-dockerfile) to install MATLAB and all available toolboxes on Linux.
The installation also includes the [MATLAB Proxy](https://github.com/mathworks/matlab-proxy) for an HTML-based web interface.
We use Ansible playbooks to install the containerized MATLAB on the clusters.

We can build a specific MATLAB container using appropriate build script.
It uses Apptainer internally.

```bash
./containers/r2024b/ubuntu22.04/build.sh sif
```

To run with the default license:
```bash
apptainer exec --bind /run/user ./containers/r2024b/ubuntu22.04/matlab.sif matlab
```

To run with a custom license:
```bash
apptainer exec --bind /run/user --env "MLM_LICENSE_FILE=<path-to-license>" ./containers/r2024b/ubuntu22.04/matlab.sif matlab
```

Documentation for Puhti and LUMI installation is available on [documentation](https://docs.csc.fi/apps/matlab/).
