-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "mps", version, "bin")
prepend_path("PATH", bin_dir)

-- Add matlab path to environment.
-- It is the path where matlab is mounted inside to the container.
matlab = "/opt/matlab"
setenv("MATLAB", matlab)

-- Path to the matlab container run with `apptainer_wrapper`.
image = pathJoin(appl_dir, "mps", version, "matlab.sif")
setenv("SING_IMAGE", image)
