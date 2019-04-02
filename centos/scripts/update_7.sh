#!/bin/bash

echo "========= Enable EPEL repo ========="
yum install -y epel-release
echo "========= Install ansible =========="
yum install -y ansible

echo "========= Update package =========="
yum update -y

echo "========= Config /etc/ansible/hosts ========="
cat << EOF > /etc/ansible/hosts
[local]
127.0.0.1
EOF

