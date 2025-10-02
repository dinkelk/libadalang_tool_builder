#
# This Dockerfile copies the repository contents from disk to build with the latest code.
# It should be run with the repository root as the build context:
#
# $ cd libadalang_tool_builder
# $ docker build -t $IMAGE_NAME -f docker/Dockerfile .
#
# For best results use docker-compose or the ./env.sh script in the docker/ directory.
#
FROM ubuntu:24.04 AS base

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
ENV ALIRE_VERSION="2.1.0"
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
RUN mkdir -p /root/libadalang
RUN cd /root/libadalang \
    && alr index --update-all \
    && alr -n get libadalang_tools=23.0.0 \
    && cd libadalang_tools* \
    && echo '' >> alire.toml \
    && echo '[[depends-on]]' >> alire.toml \
    && echo 'gnat = "^13.0"' >> alire.toml \
    && alr -n -v build --release
RUN mkdir -p /root/libadalang/libadalang_tool_builder/tools/

# Construct the final image from the multi-step build images above:
FROM base AS final
LABEL org.opencontainers.image.source=https://github.com/dinkelk/libadalang_tool_builder
LABEL org.opencontainers.image.description="libadalang-tools builder"
LABEL org.opencontainers.image.licenses=MIT
COPY --from=install_alire /root/alire/bin/alr $BIN_DIR
COPY --from=install_libadalang /root/libadalang/libadalang_tools*/bin/* $BIN_DIR
COPY --from=install_libadalang /root/libadalang/libadalang_tools*/bin/* /root/libadalang/libadalang_tool_builder/tools/

# Make sure user is root at end.
USER root
