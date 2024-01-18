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

-- Load message and license disclaimer
loadmsg = "\n----------\nThe terms of use of this software allow its use for only the affiliates (staff and students) of Finnish higher education institutions. If you are unsure whether you are allowed to use the software, please unload this module now.\n----------\n\n MATLAB Parallel Server (MPS) is not intended to be used as a batch job and this module is for debuggin. Read more about how to use MPS from the documentation at https://docs.csc.fi/apps/matlab/"

if (mode() == "load") then
  LmodMessage(loadmsg)
end
