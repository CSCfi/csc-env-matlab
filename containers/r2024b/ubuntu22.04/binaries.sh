#!/usr/bin/env bash
mkdir -p bin bin/util bin/glnxa64
apptainer exec --bind /run/user matlab.sif bash -c "
cp -n /opt/matlab/bin/mw_mpiexec bin/mw_mpiexec
cp -n /opt/matlab/bin/mw_smpd bin/mw_smpd
cp -n /opt/matlab/bin/util/arch.sh bin/util/arch.sh
cp -n /opt/matlab/bin/glnxa64/mpiexec bin/glnxa64/mpiexec
cp -n /opt/matlab/bin/glnxa64/mpiexec.hydra bin/glnxa64/mpiexec.hydra
cp -n /opt/matlab/bin/glnxa64/hydra_pmi_proxy bin/glnxa64/hydra_pmi_proxy
cp -n /opt/matlab/bin/glnxa64/mpiexec2 bin/glnxa64/mpiexec2
cp -n /opt/matlab/bin/glnxa64/smpd bin/glnxa64/smpd
cp -n /opt/matlab/bin/glnxa64/libssl-mw.so.3 bin/glnxa64/libssl-mw-so.3
cp -n /opt/matlab/bin/glnxa64/libcrypto-mw.so.3 bin/glnxa64/libcrypto-mw-so.3
"
