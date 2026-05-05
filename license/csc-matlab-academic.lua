-- Set license
license = os.getenv("MLM_LICENSE_FILE") or "1766@license4.csc.fi"
setenv("MLM_LICENSE_FILE", license)

-- Load message and license disclaimer
if (mode() == "load") then
    if (license == "1766@license4.csc.fi") then
        LmodMessage("License: Academic (" .. license .. ")\n----------\nThe terms of use of this software allow its use for only the affiliates (staff and students) of Finnish higher education institutions. If you are unsure whether you are allowed to use the software, please unload this module now.\n----------")
    end
end
