#!/bin/sh

DOCKER_CONTAINER_NAME="libadalang_tool_builder_container"
DOCKER_IMAGE_NAME="ghcr.io/dinkelk/libadalang_tool_builder:latest"
export DOCKER_CONTAINER_NAME
export DOCKER_IMAGE_NAME
export REPO_ROOT=`readlink -f "$0" | xargs dirname | xargs dirname`
echo $0

# Helper function to print out command as executed:
execute () {
  echo "$ $@"
  eval "$@"
}
