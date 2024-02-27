family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "proxy", version, "bin")
prepend_path("PATH", bin_dir)

-- Add matlab path to environment.
-- It is the path where matlab is mounted inside to the container.
matlab = "/opt/matlab"
setenv("MATLAB", matlab)
prepend_path("MATLABPATH", matlab)

-- Add binaries inside the MATLAB container to path
matlab_bin = "/opt/matlab/bin"
prepend_path("PATH", matlab_bin)

-- Path to the matlab container image run using `apptainer_wrapper`.
image = pathJoin(appl_dir, "proxy", version, "matlab.sif")
setenv("SING_IMAGE", image)

-- Flags
flags = "--bind=/usr/lib64/libmunge.so.2:/lib/x86_64-linux-gnu/libmunge.so.2,/var/run/munge --bind /run"
setenv("SING_FLAGS", flags)
