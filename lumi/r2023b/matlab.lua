family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/local/csc/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "interactive", version, "bin")
prepend_path("PATH", bin_dir)

-- Path to the matlab container image run using `apptainer_wrapper`.
image = pathJoin(appl_dir, "interactive", version, "matlab.sif")
setenv("SING_IMAGE", image)
setenv("SING_FLAGS", "-B /run")
