### OPENSTACK IMAGE AUTOMATION BUILD WITH PACKER

- Use packer image builder

- Install Packer hashicorp:

```
wget https://releases.hashicorp.com/packer/1.3.5/packer_1.3.5_linux_amd64.zip
unzip packer_1.3.5_linux_amd64.zip
mv packer /usr/bin/
```

- Install kvm, qemu 

```
apt-get install -y kvm qemu-kvm libvirt-bin virtinst bridge-utils qemu-utils
```

- Create folder isos and put image downloaded in

```
├── ansible
│   ├── files
│   │   ├── 10periodic
│   │   ├── 20auto-upgrades
│   │   ├── cloud.cfg
│   │   ├── failsafe.conf
│   │   ├── fstab
│   │   ├── grub
│   │   ├── interfaces
│   │   └── sources.list
│   ├── handlers
│   │   └── main.yml
│   ├── local.yml
│   ├── tasks
│   │   └── main.yml
│   └── vars
│       └── main.yml
├── http
│   └── preseed.cfg
├── isos
│   └── ubuntu-14.04-server-amd64.iso
├── scripts
│   ├── clean.sh
│   └── update.sh
└── ubuntu-16.04-server-amd64.json
```

- Reconfig checksum

- Run:

```
# packer build template-file.json
```

- When done push this image to openstack, we call this base image.

- Reconfig env openstack and option for packer then run:

```
packer build  openstack-ubuntu-16.04-.json
```

####GLHF
