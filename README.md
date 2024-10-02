# csc-env-matlab
This repository contains [MATLAB](https://mathworks.com) containers intended for HPC clusters, specifically Puhti and LUMI.
There are also Ansible playbooks for installing the containerized MATLAB to these clusters.

The container definitions are adapted from the official matlab reference archicture:

- https://github.com/mathworks-ref-arch/container-images
- https://github.com/mathworks-ref-arch/matlab-dockerfile

They also include the MATLAB Proxy for HTML based web interface:

- https://github.com/mathworks/matlab-proxy

Containers are built using Podman and they are compatible with Apptainer and Singularity.

Run with default license:

```bash
apptainer exec --bind /run/user matlab.sif matlab
```

Run with custom license:

```bash
apptainer exec --bind /run/user --env "MLM_LICENSE_FILE=<path-to-license>" matlab.sif matlab
```

Documentation

- https://docs.csc.fi/apps/matlab/
