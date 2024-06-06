Container for MATLAB dependencies are copied from:
https://github.com/mathworks-ref-arch/container-images/

Push containers as follows:

```bash
# Login to GitHub container registry
# Prompts for an access token
podman login -u cscfi ghcr.io

# Push the container
podman push "ghcr.io/cscfi/matlab:r2023b-ubuntu22.04"
```
