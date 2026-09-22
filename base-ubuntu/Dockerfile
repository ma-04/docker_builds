# syntax=docker/dockerfile:1

# Ubuntu release to build on (also used as the image version tag).
ARG UBUNTU_VERSION=24.04

FROM ubuntu:${UBUNTU_VERSION}

# libcap2-bin provides setcap, which the iputils-ping postinst needs so that
# ping works for non-root users.
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        dnsutils \
        iputils-ping \
        libcap2-bin \
        net-tools \
        wget \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
