#!/bin/bash

sed -i 's/requiretty/!requiretty/g' /etc/sudoers

yum install epel-release -y
yum install wget git net-tools bind-utils iptables-services bridge-utils bash-completion yum-utils ansible docker -y

echo "Configure docker device mapper"

DOCKERVG=$(lsscsi | grep \:5\] | awk '{print $7}')
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

echo "Configuring network now!"

sed -i '/^HOSTNAME/d' /etc/sysconfig/network
echo "HOSTNAME=`hostname -f`" > /etc/sysconfig/network
sed -i 's/NM_CONTROLLED=no/NM_CONTROLLED=yes/g'  /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl enable NetworkManager.service
systemctl restart NetworkManager.service

if [ $? -ne 0 ]; then
   echo "Error: Cannot configure NetworkManager!"
   exit 4
fi

mkdir -p /etc/origin/node/
echo "server 168.63.129.16" > /etc/origin/node/resolv.conf

echo "Installation finished"
