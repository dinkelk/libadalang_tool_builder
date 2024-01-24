#
# This Dockerfile needs to be run from within the project/ directory (AKA ../../ from here)
# so that docker has access to all the files it needs. ie.
#
# $ docker build -t $DOCKER_IMAGE_NAME -f libadalang_tool_builder/docker/Dockerfile .
#
# For best results use the ./build_image.sh and ./create_container.sh scripts
# provided in this directory.
#
FROM ubuntu:22.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

# install common dependencies
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install \
    software-properties-common \
    apt-utils \
    locales \
    git \
    sudo \
    curl \
    build-essential \
    && DEBIAN_FRONTEND=noninteractive apt-get -yq clean

# ensure we have the en_US.UTF-8 locale available
RUN locale-gen en_US.UTF-8
RUN rm /etc/apt/apt.conf.d/docker-clean

# Add environment variables:
ENV BIN_DIR=/usr/local/bin

# Install Alire:
FROM base AS install_alire
ENV ALIRE_VERSION="1.2.2"
ENV ALIRE_FILE=alr-$ALIRE_VERSION-bin-x86_64-linux.zip
ENV ALIRE_URL=https://github.com/alire-project/alire/releases/download/v$ALIRE_VERSION/$ALIRE_FILE
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq wget unzip \
    && mkdir -p /root/alire \
    && cd /root/alire \
    && wget $ALIRE_URL \
    && rm -rf bin \
    && unzip $ALIRE_FILE \
    && cp -r /root/alire/bin/alr $BIN_DIR

# Install GNAT tools like gnatpp and gnatmetric:
FROM install_alire AS install_libadalang
RUN mkdir -p /root/libadalang \
    && cd /root/libadalang \
    && git clone https://github.com/dinkelk/libadalang_tool_builder.git \
    && cd libadalang_tool_builder \
    && alr -n build --release \
    && mkdir tools \
    && sh install.sh tools

# Construct the final image from the multi-step build images above:
FROM base AS final
LABEL org.opencontainers.image.source=https://github.com/dinkelk/libadalang_tool_builder
LABEL org.opencontainers.image.description="libadalang-tools builder"
LABEL org.opencontainers.image.licenses=MIT
COPY --from=install_alire /root/alire/bin/alr $BIN_DIR
COPY --from=install_libadalang /root/libadalang/libadalang_tool_builder/tools/* $BIN_DIR

# Make sure user is root at end.
USER root
