#!/bin/bash

echo "INFO: Configuring cloud storage for postgres now."

PG_DISK=$(sudo -i lsscsi | grep \:6\] | awk '{print $7}')

PARTITION=$(sudo fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')

if [ $? -eq 0 ]; then
  if [ -z $PARTITION ]; then
    echo -e "n\np\n1\n\n\na\nw" | fdisk $PG_DISK
    if [ $? -ne 0 ]; then
      echo "Partition failed!"
      exit 5
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
