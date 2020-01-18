#!/bin/bash

set -x # echo commands

docker_image=cmcquinn/snickerdoodle-docker:kernel
project=snickerdoodle-linux

docker pull ${docker_image}
docker rm ${project} &> /dev/null || true
docker run --privileged --name ${project} -i \
     -v "${PWD}:/${project}" ${docker_image} \
     /bin/bash -c "cd ${project}; ./build/Recipe"

# git clone https://github.com/cmcquinn/python-utils.git
# pip3 install requests
# python-utils/bintray.py cmcquinn replicookie-rootfs debian-buster ${workdir}/rootfs.tar.xz