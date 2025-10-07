family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math"

-- Add wrapper scripts to the path.
bin_dir = pathJoin(appl_dir, "matlab", "mps", version, "bin")
prepend_path("PATH", bin_dir)

-- Unset the legacy default value in OOD.
if os.getenv("MLM_LICENSE_FILE") == "/opt/matlab/licenses/network.lic" then
    unsetenv("MLM_LICENSE_FILE")
end

-- Mathworks servicehost
setenv("MATHWORKS_SERVICE_HOST_MANAGED_INSTALL_ROOT", pathJoin(appl_dir, "mathworksservicehost"))
