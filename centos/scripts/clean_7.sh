#!/bin/bash

echo "========== Remove ansible =========="
yum remove ansible -y 
rm -rf /root/ansible*
rm -rf ~/.ansible*
rm -rf /tmp/packer-provisioner-ansible-local
rm -rf /etc/ansible
rm -rf /root/.ansible*
rm -rf /tmp/.ansible*

echo "=========== Clean package ==========="
yum remove git -y
rm -rf /root/.git*
yum clean all -y
yum autoremove -y
rm -rf /var/cache/yum/x86_64/7/

echo "=========== Remove logs ============" 
echo "" > /root/.ssh/known_hosts 
echo "" > /root/.bash_history 
echo "" > /root/.ssh/authorized_keys

rm -f /var/log/dmesg.*
rm -rf /var/log/dmesg.old
echo "" > install.log
echo "" > /var/log/yum.log
echo "" > install.log.syslog
echo "" > anaconda-ks.cfg
echo "" > original-ks.cfg
echo "" > /var/log/secure
echo "" > /var/log/anaconda.log
echo "" > /var/log/messages
echo "" > /var/log/cloud-init.log
echo "" > /var/log/tallylog
rm -f /tmp/ks-script*

> /var/log/wtmp
> /var/log/btmp
> /var/log/lastlog

history -c
exit 0
