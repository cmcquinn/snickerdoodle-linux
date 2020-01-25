#!/bin/bash

set -x # echo commands

docker_image=cmcquinn/snickerdoodle-docker:kernel
project=snickerdoodle-linux

docker pull ${docker_image}
docker rm ${project} &> /dev/null || true
docker run --privileged --name ${project} -i \
     -v "${PWD}:/${project}" \
     -v "${HOME}/.ccache:/ccache" -e CCACHE_DIR=/ccache \
     ${docker_image} \
     /bin/bash -c "cd ${project}; ./build/Recipe"