FROM ubuntu
MAINTAINER IronicBadger <ironicbadger@linuxserver.io>

# Install MHDDFS compile pre-reqs for 14.04
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
      build-essential \
      libattr1-dev \
      libglib2.0-dev \
      dpkg-dev \
      git \
      curl \
      libsepol1 \
      libsepol1-dev \
      libselinux1 \
      libselinux1-dev \
      libfuse2 \
      libfuse-dev \
      debhelper && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add source
RUN mkdir -p /tmp/mhddfs-nosegfault /artifact
ADD . /tmp/mhddfs-nosegfault/

RUN cd /tmp/mhddfs-nosegfault && \
    dpkg-buildpackage && \
    cp /tmp/*.deb /artifact/ && \
    rm -rf /tmp/mhddfs-nosegfault
