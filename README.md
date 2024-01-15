# CSC Matlab Environment
In this repository contains intructions for creating a containerized [MATLAB](https://mathworks.com) or MATLAB Parallel Server (MPS) installation for Linux with [Apptainer](https://apptainer.org/).
Containerized installation is useful for Linux cluster environments.


## Creating local MATLAB installation
* `build/installer/r2023b.zip` is the downloaded installer renamed to the lowercase version string
* `build/installer/r2023b` is the unarchived installer
* `matlab/build/r2023b` is the interactive matlab installation directory
* `mps/build/r2023b` is the matlab parallel server installation directory


### Network license file
We use a network license for the installation.
Network license queries the license permissions from a license server
We need a license file (such as `license.lic`) to connect to the license server with contents as follows:

```text
SERVER <hostname> <host-id> <lmgrd-port>
USE_SERVER
```

The license file must contain appropriate values for hostname and host ID (MAC address) of the license server and TCP/IP port number of the license manager daemon (lmgrd) on the license server.


### Download the installer
Go to the [downloads page](https://mathworks.com/downloads/) and select the latest version and download matlab the installer for Linux.
Move the installer to `installer` directory and rename it as the version string in lowercase.

Create directory for the installer and unarchive the installer files to the directory.

```bash
# Create the installer directory
mkdir -p installer/r2023b

# Unarchive the installer into the directory
unzip installer/r2023b.zip -d installer/r2023b
```


### Create the installation
Create installation directory and install matlab using the graphical installer to the directory.

```bash
# Create the installation directory
mkdir -p matlab/build/r2023b

# Run the installer
./installer/r2023b/install
```

Supply your login information.
During the installation we must set the following options:

* LICENSING
    - Select appropriate license for the installation.
    - If required, supply the license file.
      For CSC's academic installations, we can use the `license/academic.lic` file.
* DESTINATION
    - Select path to the installation directory.
* PRODUCTS
    - Select necessary toolboxes to install.
    - CSC's interactive installation requires *MATLAB*, *MATLAB Compiler*, *MATLAB Compiler SDK*, and *Parallel Computing Toolbox*
    - CSC's parallel server installation requires *MATLAB* and *MATLAB Parallel Server*
* OPTIONS
    - Unselect options to create symbolic links and sending information to matlab.
* CONFIRMATION
    - Confirm the installation.


## Building the container
First we build the base container which installs `xorg` and supported versions of `gcc` and `gfortran` compilers.
We use Ubuntu as the base and build it as follows:

```bash
apptainer build base/ubuntu_22.04.sif base/ubuntu_22.04.def
```

Next, we can build the MATLAB container as follows:

```bash
apptainer build matlab/container/r2023b.sif matlab/container/r2023b.def
```

You can test the container as follows:

```bash
apptainer test matlab/container/r2023b.sif
```


## Using the container

```bash
apptainer exec matlab/container/r2023b.sif /opt/matlab/bin/matlab
```
