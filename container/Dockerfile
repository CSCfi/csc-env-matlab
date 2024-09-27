FROM ghcr.io/cscfi/matlab:r2024a-ubuntu22.04


# Install dependencies for matlab-proxy
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get --yes update && \
    apt-get --yes upgrade && \
    apt-get --yes install \
        xvfb \
        python3 \
        python3-pip \
        && \
    apt-get --yes clean && \
    apt-get --yes autoremove && \
    rm -rf /var/lib/apt/lists/*


# Install matlab-proxy
ARG MATLAB_PROXY_VERSION=0.23.1
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir "matlab-proxy==${MATLAB_PROXY_VERSION}"


# Do not add user site-packages directory to sys.path
ENV PYTHONNOUSERSITE="1"


# Install mpm dependencies
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get --yes update && \
    apt-get --yes upgrade && \
    apt-get --yes install \
        ca-certificates \
        curl \
        unzip \
        && \
    apt-get --yes clean && \
    apt-get --yes autoremove && \
    rm -rf /var/lib/apt/lists/*


# Install MATLAB using mpm
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    curl --location --remote-name https://www.mathworks.com/mpm/glnxa64/mpm && \
    chmod u+x mpm && \
    ./mpm install \
        --release R2024a \
        --destination /opt/matlab \
        --products \
            MATLAB \
            MATLAB_Parallel_Server \
        && \
    rm -r /tmp/build && \
    ln -sf /opt/matlab/bin/matlab /usr/local/bin/matlab


# Copy license file
COPY ./license_puhti.lic /opt/matlab/licenses/network.lic
