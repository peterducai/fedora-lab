#!/bin/bash

ISO=Fedora-Server-dvd-x86_64-31-1.9.iso
ISOPATH=/var/lib/libvirt/images/
KS=fedora31.ks

# dnf -y install virt-top libguestfs-tools virt-manager virt-install
# systemctl start libvirtd
# systemctl enable libvirtd

virt-install --name f31-base \
--memory 2048 \
--vcpus 1 \
--location $ISOPATH$ISO \
--initrd-inject=/tmp/$KS \
--os-type linux \
--os-variant=fedora31 \
--extra-args="ks=file:/$KS console=tty0 console=ttyS0,115200n8"  \
--disk size=20 \
--graphics none 

#virsh console fed31