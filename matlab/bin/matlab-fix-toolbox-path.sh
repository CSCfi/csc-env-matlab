#!/bin/bash
# Fixes errors about missing toolboxes
matlab -nodisplay -nodesktop -nojvm -r "rehash toolboxcache; restoredefaultpath; savepath; quit"
