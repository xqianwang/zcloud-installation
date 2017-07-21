#!/bin/bash

sed -i 's/requiretty/!requiretty/g' /etc/sudoers

echo "Install dependencies"

yum install epel-release -y
yum install wget git net-tools bind-utils iptables-services bridge-utils bash-completion yum-utils ansible docker -y

echo "Configure docker device marrer"
DOCKERVG=$( parted -m /dev/sda print all 2>/dev/null | grep unknown | grep /dev/sd | head -1 | cut -d':' -f1 )
echo "DEVS=${DOCKERVG}" >> /etc/sysconfig/docker-storage-setup
echo "VG=docker-vg" >> /etc/sysconfig/docker-storage-setup

docker-storage-setup
if [ $? -eq 0 ]
then
   echo "Docker thin pool logical volume created successfully"
else
   echo "Error creating logical volume for Docker"
   exit 3
fi

systemctl enable docker
systemctl start docker

echo "Installation finished"
