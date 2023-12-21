# CSC Matlab Environment
In this repository we create a containerized MATLAB installation for Linux with Squashfs and Apptainer.

## Instructions
The rollowing files will be created into your working directory.

```text
.                              # working directory
├── lisence.dat                # lisence file
├── matlab_R2023b_glnxa64.zip  # downloaded installer
├── matlab_R2023b_glnxa64/     # installer directory
├── matlab_r2023b/             # installation directory
├── matlab_r2023b.sqfs         # squashfs of the installation directory
└── ubuntu_20.04.sif           # base apptainer container
```

Go to the [downloads page](https://mathworks.com/downloads/) and select the latest version and download matlab the installer for Linux.

Next go to the [license center](https://mathworks.com/licensecenter/) and download the appropriate license and name it as `lisense.dat`.

Create directory for the installer and unarchive the installer files to the directory.

```bash
mkdir matlab_R2023b_glnxa64  # create the installer directory
unzip matlab_R2023b_glnxa64.zip -d matlab_R2023b_glnxa64
```

Create installation directory and install matlab using the graphical installer to the directory.

```bash
mkdir matlab_r2023b  # create the installation directory
./matlab_R2023b_glnxa64/install
```

During the installation we must set the following options:

* Select appropriate license for the installation.
* Use the downloaded license file.
* Select path to the installation directory.
* Unselect options to create symbolic links and sending information to matlab.

We shoud add missing `toolbox/local/mpiLibConf.m` to the installation when installing Parallel Server.

Change permissive access rights to the installation.

```bash
chmod -R u=rwX,g=rX,o=rX matlab_r2023b
```

Create squashfs from the matlab installation.

```bash
mksquashfs matlab_r2023b matlab_r2023b.sqfs -progress -all-root
```

We define the base container using Ubuntu named `ubuntu_22.04.def`.

```sif
Bootstrap: docker
From: ubuntu:22.04

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
apptainer --silent exec --bind="matlab_r2023b.sqfs:$MATLAB:image-src=/" ubuntu_22.04.sif bash
```

We can test matlab by running the following commands

```bash
/opt/matlab/bin/matlab -nodisplay -nodesktop -nojvm -r "quit"
/opt/matlab/bin/matlab -batch "hello"
```
