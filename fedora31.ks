#version=DEVEL
ignoredisk --only-use=vda

autopart
# Partition clearing information
zerombr
clearpart --all
autopart
#clearpart --none --initlabel
# Use graphical install
graphical
cdrom
keyboard --vckeymap=us --xlayouts='us'
# System language
lang en_US.UTF-8

# Network information
network --onboot yes --hostname=localhost.localdomain --bootproto=dhcp 
#network --bootproto=static --ip=192.168.122.99 --netmask=255.255.255.0 --gateway=192.168.122.1 --nameserver=192.168.122.1
#Root password
rootpw --lock
#or use --iscrypted with password from mkpasswd
user --groups=wheel --name=developer --password=Ved@#123 --plaintext --gecos="developer"
selinux --enforcing
authconfig --enableshadow --passalgo=sha512
#Sfirewall --service=ssh
# Run the Setup Agent on first boot
firstboot --enable
# System services
services --enabled="chronyd"
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
