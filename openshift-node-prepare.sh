#!/bin/bash
################################################################################################
# Copyright (c) 2018 by Zafin, All rights reserved.                                            #
# This source code, and resulting software, is the confidential and proprietary information    #
# ("Proprietary Information") and is the intellectual property ("Intellectual Property")       #
# of Zafin ("The Company"). You shall not disclose such Proprietary Information and            #
# shall use it only in accordance with the terms and conditions of any and all license         #
# agreements you have entered into with The Company.                                           #
################################################################################################


#Configure DNS settings for all nodes
mkdir -p /etc/origin/node/
echo "server 168.63.129.16" > /etc/origin/node/resolv.conf

yum -q -y install bridge-utils ansible docker samba-client samba-common cifs-utils
rm -rf /var/cache/yum

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
   exit 99911
fi

systemctl enable docker
systemctl start docker

if [ $? -ne 0 ]; then
   echo "Error: Cannot start docker service!"
   exit 99912
fi

# Install and configure FileBeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-6.1.2-x86_64.rpm
rpm -vi filebeat-6.1.2-x86_64.rpm

cd /etc/filebeat/
mv fields.yml filebeat.reference.yml /var/log/
cat > /etc/filebeat/filebeat.yml<< \EOF
filebeat.prospectors:
- input_type: log
  paths:
    - /var/log/messages
    - /var/log/*.log
    - /var/opt/jfrog/artifactory/logs/artifactory.log
    - /var/opt/jfrog/artifactory/logs/import.export.log
    - /var/opt/jfrog/artifactory/logs/request.log
    - /var/opt/jfrog/artifactory/logs/access/logs/request.log
    - /var/opt/jfrog/artifactory/logs/access.log
    - /var/opt/jfrog/artifactory/logs/access/logs/access.log
    - /var/log/nginx/access.log
output.logstash:
  hosts: ["sap-server:5044"]

EOF

systemctl daemon-reload
systemctl enable filebeat.service
systemctl start filebeat.service

/usr/sbin/setsebool -P virt_use_samba on
