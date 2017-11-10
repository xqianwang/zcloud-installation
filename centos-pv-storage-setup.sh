#!/bin/bash

echo "INFO: Configuring cloud storage for postgres now."

PG_DISK=$(lsscsi | grep \:6\] | awk '{print $7}')

PARTITION=$(fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')

if [ $? -eq 0 ]; then
  if [ -z $PARTITION ]; then
    parted $PG_DISK mklabel msdos
    if [ $? -ne 0 ]; then
      echo "Creating partition table failed!"
      exit 4
    else
      parted /dev/sdc mkpart primary xfs 0% 100%
      if [ $? -ne 0 ]; then
        echo "Creating lvm 1 failed!"
        exit 5
      else
        PARTITION=$(fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')
      fi
    fi
  fi
else
  echo "ERROR: Error for configuring storage."
  exit 6
fi

mkdir -p /pgsql

mkfs -t xfs $PARTITION

ID=$(blkid | grep $PARTITION | grep -oP 'UUID="\K[^"]+')
if [ -z $ID ]; then
  ID=$(uuidgen)
fi
echo "UUID=$ID    /pgsql    xfs    defaults,nofail    1    2" >> /etc/fstab

mount $PARTITION /pgsql && chown -R 26:26 /pgsql

if [ $? -eq 0 ]; then
  echo "Mounting successfully."
else
  echo "Something wrong with mounting"
  exit 7
fi

sed -i '/^HOSTNAME/d' /etc/sysconfig/network

echo "HOSTNAME=`hostname -f`" > /etc/sysconfig/network

systemctl restart network

echo "INFO: Configuration finished!"
