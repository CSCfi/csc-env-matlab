# csc-env-matlab

Documentation for Puhti, Mahti, Roihu and LUMI installation is available on [documentation](https://docs.csc.fi/apps/matlab/).

The container definitions use the official [MATLAB container dependencies](https://github.com/mathworks-ref-arch/container-images) and the [MATLAB Package Manager (MPM)](https://github.com/mathworks-ref-arch/matlab-dockerfile) to install MATLAB and all available toolboxes on Linux.
The installation also includes the [MATLAB Proxy](https://github.com/mathworks/matlab-proxy) for an HTML-based web interface.
We also install and use the [administered MathWorks Service Host](https://github.com/mathworks-ref-arch/administer-mathworks-service-host/).

We use Ansible playbooks to install the containerized MATLAB on the clusters.
Commands to build the containers, install MATLAB environment and MathWorks ServiceHost are in the `Argcfile.sh` and we can invoke them using [argc](https://github.com/sigoden/argc).
Use the `argc --help` for more information.
