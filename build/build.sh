#!/bin/bash

set -x # echo commands

docker_image=cmcquinn/snickerdoodle-docker:kernel
project=snickerdoodle-linux

# get wl18xx firmware binaries
mkdir -p firmware/ti-connectivity
curl -L "https://dl.bintray.com/cmcquinn/snickerdoodle-wilink/wilink8fw.tar.gz" -o fw.tar.gz
tar xf fw.tar.gz
mv wl18xx-fw-4.bin wl18xx-conf.bin wl1271-nvs.bin firmware/ti-connectivity
rm wilink8fw.tar.gz

docker pull ${docker_image}
docker rm ${project} &> /dev/null || true
docker run --privileged --name ${project} -i \
     -v "${PWD}:/${project}" ${docker_image} \
     /bin/bash -c "cd ${project}; ./build/Recipe"

# git clone https://github.com/cmcquinn/python-utils.git
# pip3 install requests
# python-utils/bintray.py cmcquinn replicookie-rootfs debian-buster ${workdir}/rootfs.tar.xz