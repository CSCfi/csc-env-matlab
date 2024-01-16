# CSC Matlab Environment
In this repository contains intructions for creating a containerized [MATLAB](https://mathworks.com) and [MATLAB Parallel Server (MPS)](https://mathworks.com/products/matlab-parallel-server.html) installation for Linux with [Apptainer](https://apptainer.org/).
Containerized installation is useful for Linux cluster environments.
We need graphical user interface for installing MATLAB, for example, desktop or laptop computer.


## Creating local MATLAB installation
Files and directory

* `build/installer/r2023b.zip` is the downloaded installer renamed to the lowercase version string from `matlab_R2023b_glnxa64.zip`.
* `build/installer/r2023b` is the unarchived installer
* `matlab/build/r2023b` is the interactive matlab installation directory
* `mps/build/r2023b` is the matlab parallel server installation directory
* `license/academic.lic` is the network license for academic use in CSC


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
Then, create the `installer` directory and move the MATLAB installer to the installer directory and rename it to lowercase of the version string.

```bash
# Create the installer directory
mkdir -p installer

# Move and rename the installer
mv ~/Downloads/matlab_R2023b_glnxa64.zip installer/r2023b.zip
```

Then, create a new subdirectory for the installer version and unarchive the installer files to the directory.

```bash
# Create the installer directory for specific version
mkdir -p installer/r2023b

# Unarchive the installer into the directory
unzip installer/r2023b.zip -d installer/r2023b
```


### Create the installation
Create installation directory and install matlab using the graphical installer to the directory.

```bash
# Create the installation directory.
# We can install MPS by changing the path to `mps/build/r2023b`.
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
    - CSC's interactive installation path is `matlab/build/r2023b`
    - CSC's parallel server installation path is `mps/build/r2023b`
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

The matlab container definition `matlab/container/r2023b.def` copies the MATLAB installation to `/opt/matlab` directory and sets the file permissions such that the installation is available for all users.
Next, we can build the MATLAB container as follows:

```bash
apptainer build matlab/container/r2023b.sif matlab/container/r2023b.def
```

The container definition also has test which run the `ver` function and exits.
We can run it as follows as follows:

```bash
apptainer test matlab/container/r2023b.sif
```


## Using the container
We can use the container by creating wrapper scripts that call the MATLAB binaries from the container.
Write the following scripts to the `matlab` file and give it execution permissions `chmod u+x matlab`.

```bash
#!/bin/bash
apptainer exec matlab/container/r2023b.sif /opt/matlab/bin/matlab "$@"
```
