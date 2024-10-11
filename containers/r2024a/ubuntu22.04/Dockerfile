# Copyright 2024 The MathWorks, Inc.
FROM ubuntu:22.04

LABEL maintainer="The MathWorks"

ENV DEBIAN_FRONTEND="noninteractive" TZ="Etc/UTC"

COPY base-dependencies.txt /tmp/base-dependencies.txt

RUN apt-get update && apt-get install --no-install-recommends -y `cat /tmp/base-dependencies.txt` \
    && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

RUN [ -d /usr/share/X11/xkb ] || mkdir -p /usr/share/X11/xkb

WORKDIR /

# Uncomment the following RUN apt-get statement if you will be using Simulink
# code generation capabilities, or if you will be compiling your own mex files
# with gcc, g++, or gfortran.
#
RUN apt-get update -y && apt-get install -y gcc g++ gfortran && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment the following RUN apt-get statement to enable running a program
# that makes use of MATLAB's Engine API for C and Fortran
# https://www.mathworks.com/help/matlab/matlab_external/introducing-matlab-engine.html
#
RUN apt-get update -y && apt-get install -y csh && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment ALL of the following RUN apt-get statement to enable the playing of media files
# (mp3, mp4, etc.) from within MATLAB.
#
RUN apt-get update -y && apt-get install --no-install-recommends -y libgstreamer1.0-0 \
 gstreamer1.0-tools \
 gstreamer1.0-libav \
 gstreamer1.0-plugins-base \
 gstreamer1.0-plugins-good \
 gstreamer1.0-plugins-bad \
 gstreamer1.0-plugins-ugly \
 && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment the following line if you require the fuse filesystem
#RUN apt-get update -y && apt-get install --no-install-recommends -y libfuse2 && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment the following line if you require firefox
#RUN apt-get update -y && apt-get install --no-install-recommends -y firefox && apt-get clean && apt-get -y autoremove && rm -rf /var/lib/apt/lists/*

# Uncomment to resolve any license manager issues
#RUN ln -s /lib64/ld-linux-x86-64.so.2 /lib64/ld-lsb-x86-64.so.3


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
COPY mpm_input.txt /tmp/mpm_input.txt
RUN mkdir -p /tmp/build && \
    cd /tmp/build && \
    curl --location --remote-name https://www.mathworks.com/mpm/glnxa64/mpm && \
    chmod u+x mpm && \
    ./mpm install --inputfile /tmp/mpm_input.txt && \
    rm -r /tmp/build && \
    ln -sf /opt/matlab/bin/matlab /usr/local/bin/matlab


# Additional clean up
RUN rm /tmp/base-dependencies.txt /tmp/mathworks_root.log /tmp/mpm_input.txt


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
ARG MATLAB_PROXY_VERSION
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir "matlab-proxy==${MATLAB_PROXY_VERSION}"


# Do not add user site-packages directory to sys.path
ENV PYTHONNOUSERSITE="1"
