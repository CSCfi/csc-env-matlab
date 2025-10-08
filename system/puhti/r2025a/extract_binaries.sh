#!/usr/bin/env bash
MATLAB_CONTAINER=${1:-matlab.sif}
mkdir -p bin bin/util bin/glnxa64
apptainer exec --bind=/run/user --bind="$PWD" "$MATLAB_CONTAINER" bash -c "
cp -f /opt/matlab/bin/mw_mpiexec $PWD/bin/mw_mpiexec
cp -f /opt/matlab/bin/util/arch.sh $PWD/bin/util/arch.sh
cp -f /opt/matlab/bin/glnxa64/mpiexec $PWD/bin/glnxa64/mpiexec
cp -f /opt/matlab/bin/glnxa64/mpiexec.hydra $PWD/bin/glnxa64/mpiexec.hydra
cp -f /opt/matlab/bin/glnxa64/hydra_pmi_proxy $PWD/bin/glnxa64/hydra_pmi_proxy
cp -f /opt/matlab/bin/glnxa64/libssl-mw.so.3 $PWD/bin/glnxa64/libssl-mw.so.3
cp -f /opt/matlab/bin/glnxa64/libcrypto-mw.so.3 $PWD/bin/glnxa64/libcrypto-mw.so.3
cp -rf /opt/matlab/bin/glnca64/impi $PWD/bin/glnxa64/impi
"
