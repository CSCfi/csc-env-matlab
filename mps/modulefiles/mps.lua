-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "mps", version, "bin")
prepend_path("PATH", bin_dir)

-- Path to the squashfs containing matlab installation.
squashfs = pathJoin(appl_dir, "mps", version, "mps.sqfs")

-- Add matlab path to environment.
-- It is the path where matlab is mounted inside to the container.
matlab = "/opt/matlab"
setenv("MATLAB", matlab)

-- Path to the base container.
image = pathJoin(appl_dir, "container", "ubuntu_22.04.sif")

-- Image to run using `apptainer_wrapper`.
setenv("SING_IMAGE", image)

-- Flags for mounting the squashfs of matlab installation using `apptainer_wrapper`.
setenv("SING_FLAGS", "-B " .. squashfs .. ":" .. matlab .. ":image-src/")
