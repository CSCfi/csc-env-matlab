family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "proxy", version, "bin")
prepend_path("PATH", bin_dir)

-- Path to the matlab container image run using `apptainer_wrapper`.
image = pathJoin(appl_dir, "proxy", version, "matlab.sif")
setenv("SING_IMAGE", image)

-- Flags
flags = "--bind=/usr/lib64/libmunge.so.2:/lib/x86_64-linux-gnu/libmunge.so.2,/var/run/munge --bind /run"
setenv("SING_FLAGS", flags)
