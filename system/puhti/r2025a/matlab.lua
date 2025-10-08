family("matlab")

-- Version string
version = myModuleVersion()

-- Path to the application directory.
appl_dir = "/appl/soft/math"

-- Add scripts to the path.
bin_dir = pathJoin(appl_dir, "matlab", "mps", version, "bin")
prepend_path("PATH", bin_dir)

-- Set license
license = os.getenv("MLM_LICENSE_FILE") or "1766@license4.csc.fi"
setenv("MLM_LICENSE_FILE", license)

-- Load message and license disclaimer
if (mode() == "load") then
    LmodMessage("MATLAB  " .. version .. "\n")
    if (license == "1766@license4.csc.fi") then
        LmodMessage("License: Academic (" .. license .. ")\n----------\nThe terms of use of this software allow its use for only the affiliates (staff and students) of Finnish higher education institutions. If you are unsure whether you are allowed to use the software, please unload this module now.\n----------")
    end
end
