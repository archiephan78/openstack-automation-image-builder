#!/bin/bash

echo "========== Install parted and linux-rootfs-resize ========="
yum install perl -y
yum install git parted dracut-modules-growroot -y
git clone https://github.com/flegmatik/linux-rootfs-resize.git
cd linux-rootfs-resize
./install
cd ~
rm -rf linux-rootfs-resize

echo "========= Install ansible =========="
yum install ansible -y

echo "========= Update package =========="
yum --exclude=kernel\* update -y

echo "========= Config /etc/ansible/hosts ========="
cat << EOF > /etc/ansible/hosts
[local]
127.0.0.1
EOF

exit 0