FROM ghcr.io/cscfi/matlab:r2023b-ubuntu22.04

ENV DEBIAN_FRONTEND="noninteractive"

# Install dependencies for matlab-proxy
RUN apt-get update -y && apt-get install -y xvfb \
    python3 \
    python3-pip \
    && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Do not add user site-packages directory to sys.path
ENV PYTHONNOUSERSITE=""

# Install matlab-proxy
RUN python3 -m pip install matlab-proxy
