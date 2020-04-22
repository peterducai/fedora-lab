#version=DEVEL
ignoredisk --only-use=vda


# Partition clearing information
zerombr
clearpart --none --initlabel
autopart

# Use text install
text
cdrom
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

#text or graphical

# Network information
network --onboot yes --hostname=fedbase.localdomain --bootproto=dhcp 
#network --bootproto=static --ip=192.168.122.99 --netmask=255.255.255.0 --gateway=192.168.122.1 --nameserver=192.168.122.1
#Root password
rootpw --lock
#or use --iscrypted with password from mkpasswd
user --groups=wheel --name=developer --iscrypted --password=$y$j9T$H8D99DMQ2zre5pY8FpOHx1$xWFKOIbvgfROIJuI0CGMOzLjnrGXgkT0ZxKLFOG7Rk8 --gecos="developer"
selinux --enforcing
authconfig --enableshadow --passalgo=sha512
firewall --enabled --ssh
# Run the Setup Agent on first boot
firstboot --enable
# System services
services --enabled="chronyd,ssh"
# System timezone
timezone Europe/Prague --isUtc

%packages
@^server-product-environment

%end

%addon com_redhat_kdump --disable --reserve-mb='128'

%end

%anaconda
pwpolicy root --minlen=6 --minquality=1 --notstrict --nochanges --notempty
pwpolicy user --minlen=6 --minquality=1 --notstrict --nochanges --emptyok
pwpolicy luks --minlen=6 --minquality=1 --notstrict --nochanges --notempty
%end
reboot