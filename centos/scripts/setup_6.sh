#!/bin/bash

echo "========== Show usage =========="
df -h
free -m
ls -l /etc/sysconfig/network-scripts/

echo "========== Install ca-certificate =========="
yum install ca-certificates -y


echo "========== Install epel repo and cloud-init packages ==========="
rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
yum install -y cloud-init cloud-utils-growpart cloud-utils

echo "========== Install parted and linux-rootfs-resize ========="
yum install perl -y
yum install git parted -y
git clone https://github.com/flegmatik/linux-rootfs-resize.git
cd linux-rootfs-resize
./install
cd ~
rm -rf linux-rootfs-resize

echo "========== Config cloud.cfg =========="
cat << 'EOF' > /etc/cloud/cloud.cfg
users: root
disable_root: 0
ssh_pwauth:   1
preseve_hostname: False

locale_configfile: /etc/sysconfig/i18n
mount_default_fields: [~, ~, 'auto', 'defaults,nofail', '0', '2']
resize_rootfs_tmp: /dev
ssh_deletekeys:   0
ssh_genkeytypes:  ~
syslog_fix_perms: ~

cloud_init_modules:
 - bootcmd
 - write-files
 - resizefs
 - set_hostname
 - update_hostname
 - update_etc_hosts
 - rsyslog
 - users-groups
 - ssh
 - resolv-conf

cloud_config_modules:
 - mounts
 - locale
 - set-passwords
 - timezone
 - puppet
 - chef
 - salt-minion
 - mcollective
 - disable-ec2-metadata
 - runcmd

cloud_final_modules:
 - rightscale_userdata
 - scripts-per-once
 - scripts-per-boot
 - scripts-per-instance
 - scripts-user
 - ssh-authkey-fingerprints
 - keys-to-console
 - phone-home
 - final-message

system_info:
  distro: rhel
  default_user:
    name: root
  paths:
    cloud_dir: /var/lib/cloud
    templates_dir: /etc/cloud/templates
  ssh_svcname: sshd

# vim:syntax=yaml
EOF

echo "========== Config network =========="
cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth0
TYPE=Ethernet
DEVICE=eth0
ONBOOT=yes
BOOTPROTO=dhcp
NM_CONTROLLED=no
EOF

cat << EOF > /etc/sysconfig/network-scripts/ifcfg-eth1
TYPE=Ethernet
DEVICE=eth1
ONBOOT=yes
BOOTPROTO=dhcp
NM_CONTROLLED=no
EOF

echo 'NOZEROCONF=yes' >> /etc/sysconfig/network

rm -rf /etc/udev/rules.d/70-persistent-net.rules
rm -rf /lib/udev/write_net_rules

exit 0
