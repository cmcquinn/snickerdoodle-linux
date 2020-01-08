#!/bin/bash

set -x # echo commands

docker_image=cmcquinn/snickerdoodle-docker:kernel
project=snickerdoodle-linux

# get wl18xx firmware binaries
projectdir=${PWD}
cd ..
git clone http://git.ti.com/git/wilink8-wlan/wl18xx_fw.git
git clone https://github.com/krtkl/wlconf.git
mkdir -p ${projectdir}/firmware/ti-connectivity
cp wlconf/wl18xx-conf-default.bin ${projectdir}/firmware/ti-connectivity/wl18xx-conf.bin
cp wl18xx_fw/wl18xx-fw-4.bin ${projectdir}/firmware/ti-connectivity/wl18xx-fw-4.bin
cd ${projectdir}

docker pull ${docker_image}
docker rm ${project} &> /dev/null || true
docker run --privileged --name ${project} -i \
     -v "${PWD}:/${project}" ${docker_image} \
     /bin/bash -c "cd ${project}; ./build/Recipe"

# git clone https://github.com/cmcquinn/python-utils.git
# pip3 install requests
# python-utils/bintray.py cmcquinn replicookie-rootfs debian-buster ${workdir}/rootfs.tar.xz