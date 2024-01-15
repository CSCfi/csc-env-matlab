# CSC Matlab Environment
In this repository contains intructions for creating a containerized MATLAB or MATLAB Parallel Server (MPS) installation for Linux with Apptainer.
Containerized installation is useful for Linux cluster environments.

The rollowing files will be created into the `build` directory.

```text
build/                         # build directory
├── matlab_R2023b_glnxa64.zip  # downloaded installer
├── matlab_R2023b_glnxa64/     # installer directory
├── matlab_r2023b/             # installation directory
├── matlab_r2023b.sif          # matlab apptainer container
└── ubuntu_22.04.sif           # base apptainer container
```

We should create it as follows:

```bash
mkdir -p build
```


## Creating local MATLAB installation
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


### Unarchive the installer
Create directory for the installer and unarchive the installer files to the directory.

```bash
# Create the installer directory
mkdir build/matlab_R2023b_glnxa64

# Unarchive the installer into the directory
unzip build/matlab_R2023b_glnxa64.zip -d build/matlab_R2023b_glnxa64
```


### Create the installation
Create installation directory and install matlab using the graphical installer to the directory.

```bash
# Create the installation directory
mkdir build/matlab_r2023b

# Run the installer
./build/matlab_R2023b_glnxa64/install
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
    - CSC's interactive installation requires `MATLAB`, `MATLAB Compiler`, `MATLAB Compiler SDK`, and `Parallel Computing Toolbox`
    - CSC's parallel server installation requires `MATLAB` and `MATLAB Parallel Server`
* OPTIONS
    - Unselect options to create symbolic links and sending information to matlab.
* CONFIRMATION
    - Confirm the installation.


## Container
### Building the base container
We define the base container using Ubuntu named `ubuntu_22.04.def` and build it as follows:

```bash
apptainer build build/ubuntu_22.04.sif container/ubuntu_22.04.def
```


### Building the matlab container

```bash
apptainer build matlab/container/r2023b.sif matlab/container/r2023b.def
```


### Run and test the container
Finally, we can run the container.

```bash
export MATLAB="/opt/matlab"
apptainer exec build/r2023b.sif bash
```

We can test matlab by running the following commands

```bash
$MATLAB/bin/matlab -nodisplay -nodesktop -nojvm -r "ver; quit;"
```
