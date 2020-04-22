#!/bin/bash

ISO=Fedora-Server-dvd-x86_64-31-1.9.iso
ISOPATH=/var/lib/libvirt/images/
KS=fedora31.ks

# dnf -y install virt-top libguestfs-tools virt-manager virt-install
# systemctl start libvirtd
# systemctl enable libvirtd

virt-install --name f31-base --memory 2048 \
--vcpus 1 --metadata description=base_image_f31 --location $ISOPATH$ISO \
--initrd-inject=/tmp/$KS --os-variant=fedora31 \
--extra-args="ks=file:/$KS console=tty0 console=ttyS0,115200n8"  \
--disk size=20 \
--nographics

# virt-install \
# --name fed31 \
# --ram 1024 \
# --vcpus 1 \
# --disk path=/var/lib/libvirt/images/fed31.img,size=20 \
# --os-variant fedora31 \
# --os-type linux \
# --network bridge=br0 \
# --graphics none \
# --console pty,target_type=serial \
# --location 'http://fedora.inode.at/releases/31/Server/x86_64/os/' \
# --extra-args 'console=ttyS0,115200n8 serial'

#virsh console fed31