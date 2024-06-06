family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "proxy", version, "bin")
prepend_path("PATH", bin_dir)

-- Path to the matlab container image to run using apptainer or singularity.
image = pathJoin(appl_dir, "proxy", version, "matlab.sif")
setenv("MATLAB_SING_IMAGE", image)
