#!/bin/bash

sed -i 's/requiretty/!requiretty/g' /etc/sudoers

sed -i '/^HOSTNAME/d' /etc/sysconfig/network
echo "HOSTNAME=`hostname -f`" >> /etc/sysconfig/network
systemctl restart network

echo "Configure docker device mapper"

DOCKERVG=$(lsscsi | grep \:5\] | awk '{print $7}')
echo "DEVS=${DOCKERVG}" >> /etc/sysconfig/docker-storage-setup
echo "VG=docker-vg" >> /etc/sysconfig/docker-storage-setup

echo "Installation finished"
