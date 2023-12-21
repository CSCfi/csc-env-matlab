# CSC Matlab Environment
In this repository we create a containerized MATLAB installation for Linux with Apptainer.

```text
.                              # working directory
├── matlab_R2023b_glnxa64.zip  # downloaded matlab installer archive
├── lisence.dat                # lisence file
├── r2023b_installer/          # directory for unarchiving the matlab installer
└── r2023b/                    # directory for installing matlab
```

Go to the [downloads page](https://mathworks.com/downloads/) and select the latest version and download matlab the installer for Linux.

Next go to the [license center](https://mathworks.com/licensecenter/) and download the appropriate license and name it as `lisense.dat`.

Create directory for the installer and unarchive the installer files to the directory.

```bash
mkdir r2023b_installer
unzip matlab_R2023b_glnxa64.zip -d r2023_installer
```

Create installation directory and install matlab using the graphical installer to the directory.

```bash
mkdir r2023b
./r2023_installer/install
```

During the installation we must set the following options:

* Select appropriate license for the installation.
* Use the downloaded license file named `lisence.dat`.
* Select path ot the installation directory as `r2023b`.
* Unselect options to create symbolic links and sending information to matlab.

We shoud add missing `toolbox/local/mpiLibConf.m` to the installation when installing Parallel Server.

Change permissive access rights to the installation.

```bash
chmod -R u=rwX,g=rX,o=rX r2023b
```

Create squashfs from the matlab installation.

```bash
mksquashfs r2023b r2023b.sqfs -progress -all-root
```

We define the base container using Ubuntu named `ubuntu_22.04.def`.

```sif
Bootstrap: docker
From: ubuntu:22.04

%environment
    export LC_ALL=C

%post
    apt-get --quiet update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y \
        xorg && \
    rm -rf /var/lib/apt/lists/*
```

Then, we can build it.

```bash
apptainer build ubuntu_22.04.sif ubuntu_22.04.def
```

Finally, we can run the container.

```bash
export MATLAB="/opt/matlab"
apptainer --silent exec --bind="r2023b.sqfs:$MATLAB:image-src=/" ubuntu_22.04.sif bash
```

We can test matlab by running the following commands

```bash
/opt/matlab/bin/matlab -nodisplay -nodesktop -nojvm -r "quit"
/opt/matlab/bin/matlab -batch "hello"
```
