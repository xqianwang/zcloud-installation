#!/bin/bash

echo "INFO: Configuring cloud storage for postgres now."

PG_DISK=$(sudo -i lsscsi | grep \:6\] | awk '{print $7}')

PARTITION=$(sudo fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')

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
        PARTITION=$(sudo fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')
      fi
    fi
  fi
else
  echo "ERROR: Error for configuring storage."
  exit 6
fi

sudo mkdir -p /pgsql

sudo mkfs -t xfs $PARTITION

ID=$(blkid | grep $PARTITION | grep -oP 'UUID="\K[^"]+')
if [ -z $ID ]; then
  ID=$(uuidgen)
fi
echo "UUID=$ID    /pgsql    xfs    defaults,nofail    1    2" >> /etc/fstab

sudo mount $PARTITION /pgsql && sudo chown -R 26:26 /pgsql

if [ $? -eq 0 ]; then
  echo "Mounting successfully."
else
  echo "Something wrong with mounting"
  exit 7
fi

echo "INFO: Configuration finished!"
