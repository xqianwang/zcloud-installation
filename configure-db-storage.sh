#!/bin/bash
################################################################################################
# Copyright (c) 2018 by Zafin, All rights reserved.                                            #
# This source code, and resulting software, is the confidential and proprietary information    #
# ("Proprietary Information") and is the intellectual property ("Intellectual Property")       #
# of Zafin ("The Company"). You shall not disclose such Proprietary Information and            #
# shall use it only in accordance with the terms and conditions of any and all license         #
# agreements you have entered into with The Company.                                           #
################################################################################################

echo "INFO: Configuring cloud storage for postgres now."

PG_DISK=$(lsscsi | grep \:6\] | awk '{print $7}')

PARTITION=$(fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')

if [ $? -eq 0 ]; then
  if [ -z $PARTITION ]; then
    parted $PG_DISK mklabel msdos
    if [ $? -ne 0 ]; then
      echo "Creating partition table failed!"
      exit 99921
    else
      parted $PG_DISK mkpart primary xfs 0% 100%
      if [ $? -ne 0 ]; then
        echo "Creating lvm 1 failed!"
        exit 99922
      else
        PARTITION=$(fdisk -l $PG_DISK | grep ${PG_DISK}1 | awk '{print $1}')
      fi
    fi
  fi
else
  echo "ERROR: Error for configuring storage."
  exit 99923
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
  exit 99924
fi

echo "INFO: Configuration finished!"
