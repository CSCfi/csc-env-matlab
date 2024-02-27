family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math/matlab"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "interactive", version, "bin")
prepend_path("PATH", bin_dir)

-- Path to the matlab container image run using `apptainer_wrapper`.
image = pathJoin(appl_dir, "interactive", version, "matlab.sif")
setenv("SING_IMAGE", image)
setenv("SING_FLAGS", "-B /run")

-- Load message and license disclaimer
loadmsg = "MATLAB\nVersion: " .. version .. "\nLicense: Academic\n----------\nThe terms of use of this software allow its use for only the affiliates (staff and students) of Finnish higher education institutions. If you are unsure whether you are allowed to use the software, please unload this module now.\n----------"

if (mode() == "load") then
  LmodMessage(loadmsg)
end
