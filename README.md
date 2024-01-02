# CSC Matlab Environment
In this repository we create a containerized MATLAB or MATLAB Parallel Server (MPS) installation for Linux with Squashfs and Apptainer.
This guide is useful for installing matlab into a cluster or server that uses a license manager.

## Instructions
The rollowing files will be created into your working directory.

```text
.                              # working directory
├── network.lic                # network license file
├── matlab_R2023b_glnxa64.zip  # downloaded installer
├── matlab_R2023b_glnxa64/     # installer directory
├── matlab_r2023b/             # installation directory
├── matlab_r2023b.sqfs         # squashfs of the installation directory
└── ubuntu_20.04.sif           # base apptainer container
```

### Network license file
Create `network.lic` file that contains appropriate values to use a license server.

```text
SERVER <server-name> <host-id> <lmgrd-port>
USE_SERVER
```

### Download the installer
Go to the [downloads page](https://mathworks.com/downloads/) and select the latest version and download matlab the installer for Linux.

### Unarchive the installer
Create directory for the installer and unarchive the installer files to the directory.

```bash
mkdir matlab_R2023b_glnxa64  # create the installer directory
unzip matlab_R2023b_glnxa64.zip -d matlab_R2023b_glnxa64
```

### Create the installation
Create installation directory and install matlab using the graphical installer to the directory.

```bash
mkdir matlab_r2023b  # create the installation directory
./matlab_R2023b_glnxa64/install
```

During the installation we must set the following options:

* Select appropriate license for the installation.
* Use the network license.
* Select path to the installation directory.
* Unselect options to create symbolic links and sending information to matlab.
* Select necessary toolboxes to install.

If we are installing MATLAB Parallel Server, we can add missing `mpiLibConf.m` to the installation the `matlab_r2023b/toolbox/local/` directory.

Change permissive access rights to the installation.

```bash
chmod -R u=rwX,g=rX,o=rX matlab_r2023b
```

### Create squashfs from the installation
Create squashfs from the matlab installation.

```bash
mksquashfs matlab_r2023b matlab_r2023b.sqfs -progress -all-root
```

### Build the base container
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

### Run and test the container
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
