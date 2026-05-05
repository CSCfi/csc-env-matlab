% Define local MATLAB configuration directory.
if ispc()
    % Windows
    confroot = fullfile(getenv("APPDATA"), "Mathworks", "MATLAB");
elseif isunix() || ismac()
    % Unix (Linux) or MacOS
    confroot = fullfile(getenv("HOME"), ".matlab");
else
     % Operating system not supported
     exit();
end

% Path to where the ZIP file is downloaded.
confzip = fullfile(confroot, "mps_puhti.zip");
delete(confzip);  % remove previous zipfile

% Path to the directory where configuration files are extracted.
confdir = fullfile(confroot, "mps_puhti");
rmdir(confdir, 's');  % remove previous config directory

% Download the configuration files as a ZIP file.
websave(confzip, "https://github.com/CSCfi/csc-env-matlab/raw/refs/heads/main/config/mps_puhti.zip")

% Extract the configuration files to the configuration directory.
unzip(confzip, confdir)

% Persist path to the configuration files.
addpath(confdir)
savepath()