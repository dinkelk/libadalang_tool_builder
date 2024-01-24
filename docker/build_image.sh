#!/bin/sh

. ./docker_config.sh
cd ../..
execute "docker build --no-cache --progress=plain -t $DOCKER_IMAGE_NAME -f $REPO_ROOT/docker/Dockerfile ."
cd - >/dev/null
