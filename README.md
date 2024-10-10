# csc-env-matlab

This repository contains [MATLAB](https://mathworks.com) containers designed for use in High-Performance Computing (HPC) clusters.
The container definitions are adapted from the official MATLAB reference architecture:

- https://github.com/mathworks-ref-arch/container-images
- https://github.com/mathworks-ref-arch/matlab-dockerfile

They also include the MATLAB Proxy for an HTML-based web interface:

- https://github.com/mathworks/matlab-proxy

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

Documentation:

- https://docs.csc.fi/apps/matlab/
