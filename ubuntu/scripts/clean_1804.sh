#!/bin/bash

echo "========== Mark hold cloud-init =========="
apt-mark hold cloud-init

echo "========== Remove ansible =========="
apt-get purge ansible -y
apt-get autoremove -y
apt-get clean
apt-add-repository --remove ppa:ansible/ansible -y
rm -f /etc/apt/sources.list.d/ansible*
rm -rf /root/ansible*
rm -rf ~/.ansible*
rm -rf /tmp/packer-provisioner-ansible-local
rm -rf /etc/ansible

echo "========== Remove user ubuntu =========="
userdel -f ubuntu
rm -rf /home/ubuntu

echo "========== Remove logs =========="
echo "" > /root/.bash_history
echo "" > /var/log/cloud-init.log
rm -f /var/log/dmesg.*
rm -f /root/.ssh/known_hosts
rm -f /root/.ssh/authorized_keys
echo "" > install.log
echo "" > /var/log/dmesg
echo "" > /var/log/dpkg.log
echo "" > /var/log/faillog
echo "" > /var/log/syslog
echo "" > /var/log/boot
echo "" > /var/log/boot.log
echo "" > /var/log/auth.log
echo "" > /var/log/apt/history.log
echo "" > /var/log/apt/term.log
echo "" > /var/log/installer/syslog
echo "" > /var/log/kern.log
> /var/log/wtmp
> /var/log/btmp
> /var/log/lastlog

echo "========== Remove cache apt =========="
rm -rf /var/cache/apt/archives/*
rm -rf /var/lib/apt/lists/*
rm -f /etc/apt/sources.list.save

exit 0
