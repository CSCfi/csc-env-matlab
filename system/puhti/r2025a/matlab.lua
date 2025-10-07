family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "matlab", "mps", version, "bin")
prepend_path("PATH", bin_dir)

-- Set license
license_default = os.getenv("MLM_LICENSE_FILE")
if license_default == nil or license_default == "" then
    license = "1766@license4.csc.fi"
elseif license_default == "/opt/matlab/licenses/network.lic" then
    license = "1766@license4.csc.fi"
else
    license = license_default
end
setenv("MLM_LICENSE_FILE", license)

-- Mathworks servicehost
setenv("MATHWORKS_SERVICE_HOST_MANAGED_INSTALL_ROOT", pathJoin(appl_dir, "mathworksservicehost"))
