#!/bin/bash

echo "INFO: Configuring cloud storage for postgres now."

PG_DISK=$(lsscsi | grep \:6\] | awk '{print $7}')

PARTITION=$(fdisk -l $PG_DISK | grep {$PG_DISK}1 | awk '{print $1}')

if [ $? -ne 0 ]; then
  if [ -z $PARTITION ]; then
    echo -e "n\np\n1\n\n\nt\nc\na\n1\nw" | fdisk $PG_DISK
  fi
else
  echo "ERROR: Error for configuring storage."
  exit 6
fi

mkdir -p /pgsql

mount $PARTITION /pgsql && chown -R 26:26 /pgsql

ID=$(blkid | grep $PARTITION | grep -oP 'UUID="\K[^"]+')
if [ -z $ID ]; then
  ID=$(uuidgen)
fi

echo "UUID=$ID    /pgsql    xfs    defaults,nofail    1    2" >> /etc/fstab

echo "INFO: Configuration finished!"
