-- Set license
license_default = os.getenv("MLM_LICENSE_FILE")
if license_default == nil or license_default == "" then
    license = "1766@license10.csc.fi"
elseif license_default == "/opt/matlab/licenses/network.lic" then
    license = "1766@license10.csc.fi"
else
    license = license_default
end
setenv("MLM_LICENSE_FILE", license)

-- Load message and license disclaimer
loadmsg = "MATLAB\nVersion: " .. version .. "\nLicense: Academic\n----------\nThe terms of use of this software allow its use for only in teaching and academic research at a degree-granting institute. If you are unsure whether you are allowed to use the software, please unload this module now.\n\nIf you want to use your own license with the installation, please contact LUMI support for help.\n----------"

if (mode() == "load") then
  LmodMessage(loadmsg)
end
