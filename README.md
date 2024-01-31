# CSC MATLAB Environment
In this repository contains intructions for creating a containerized [MATLAB](https://mathworks.com) and [MATLAB Parallel Server (MPS)](https://mathworks.com/products/matlab-parallel-server.html) installation for Linux with [Apptainer](https://apptainer.org/).
Containerized installation is useful for Linux cluster environments.
We need graphical user interface for installing MATLAB, for example, desktop or laptop computer.
Currently, there are instructions for installing MATLAB version *R2023b*.


## Installing MATLAB on local computer
### License file
We use a network license for the installation.
Network license queries the license permissions from a license server
We need a license file (such as `license.lic`) to connect to the license server with contents as follows:

```text
SERVER <hostname> <host-id> <lmgrd-port>
USE_SERVER
```

The license file must contain appropriate values for hostname and host ID (MAC address) of the license server and TCP/IP port number of the license manager daemon (lmgrd) on the license server.


### Download the MATLAB installer
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


### Creating the MATLAB installation
Create installation directory and install matlab using the graphical installer to the directory.

```bash
# Create the installation directory.
mkdir -p matlab/r2023b/build

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
    - CSC's MATLB interactive installation path is `matlab/r2023b/build`
    - CSC's MATLB Parallel Server installation path is `mps/r2023b/build`
* PRODUCTS
    - Select necessary toolboxes to install.
    - CSC's MATLAB interactive installation requires *MATLAB*, *MATLAB Compiler*, *MATLAB Compiler SDK*, and *Parallel Computing Toolbox* toolboxes
    - CSC's MATLAB Parallel Server installation requires *MATLAB* and *MATLAB Parallel Server* toolboxes
* OPTIONS
    - Unselect options to create symbolic links and sending information to matlab.
* CONFIRMATION
    - Confirm the installation.


## Building the MATLAB container
First we build the base container with required dependencies.
Base container definitions are modified from the [MathWorks official container images](https://github.com/mathworks-ref-arch/container-images/).

```bash
./deps/matlab/r2023b/ubuntu22.04/build.sh
```

The matlab container definition `matlab/container/r2023b.def` copies the MATLAB installation to `/opt/matlab` directory and sets the file permissions such that the installation is available for all users.
Next, we can build the MATLAB container as follows:

```bash
apptainer build matlab/r2023b/matlab.sif matlab/r2023b/matlab.def
```


## Testing the MATLAB container
We can test the MATLAB container by running the `ver` function as follows as follows:

```bash
apptainer exec matlab/r2023b/matlab.sif /opt/matlab/bin/matlab -nodisplay -r 'ver; quit;'
```


## Using the MATLAB container with wrapper scripts
We can use the container by creating wrapper scripts that call the MATLAB binaries from the container.
Write the following scripts to the `matlab` file and give it execution permissions `chmod u+x matlab`.

```bash
#!/bin/bash
apptainer exec matlab/r2023b/matlab.sif /opt/matlab/bin/matlab "$@"
```

On CSC's Puhti cluster, we can use the `apptainer_wrapper` which automatically bind mounts the cluster specific directories to the container.
You can read about [running container in CSC clusters](https://docs.csc.fi/computing/containers/run-existing/).
