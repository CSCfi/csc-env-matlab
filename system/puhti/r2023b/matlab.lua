family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "matlab", "mps", version, "bin")
prepend_path("PATH", bin_dir)

-- Path to the matlab container image to run using apptainer or singularity.
image = pathJoin(appl_dir, "matlab", "mps", version, "matlab.sif")
setenv("MATLAB_SING_IMAGE", image)

-- Set license
license_default = os.getenv("MLM_LICENSE_FILE")
if license_default == nil or license_default == "" then
    license = "1766@license4.csc.fi"
elseif license_default == "/opt/matlab/licenses/network.lic" then
    license = "1766@license10.csc.fi"
else
    license = license_default
end
setenv("MLM_LICENSE_FILE", license)

-- Load message and license disclaimer
loadmsg = "MATLAB\nVersion: " .. version .. "\nLicense: Academic\n----------\nThe terms of use of this software allow its use for only the affiliates (staff and students) of Finnish higher education institutions. If you are unsure whether you are allowed to use the software, please unload this module now.\n----------"

if (mode() == "load") then
  LmodMessage(loadmsg)
end
