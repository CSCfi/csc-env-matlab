% Intalled to: `$MATLAB/toolbox/local/mpiLibConf.m`
function [primaryLib, extras] = mpiLibConf

% Copyright 2014-2019 The MathWorks, Inc.

% Specified in the communicatingJobWrapper, if being used
mpi = getenv('I_MPI_ROOT');

if isempty(mpi)
    % Check first if we're running the local scheduler.  If so, use the
    % default.
    [primaryLib, extras] = distcomp.mpiLibConfs( 'default' );
else
    % Otherwise, use the specified MPI with a 3rd party scheduler
    primaryLib = fullfile(mpi,'lib64','libmpi.so');
    % No extra libraries needed
    extras = {};
end

end
