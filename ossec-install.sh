#!/bin/bash

# Update everything
yum update -y --exclude=WALinuxAgent
yum -y install curl

# Install ossec repo
cat > /etc/yum.repos.d/wazuh.repo <<\EOF
[wazuh_repo]
gpgcheck=1
gpgkey=https://packages.wazuh.com/key/GPG-KEY-WAZUH
enabled=1
name=CentOS-$releasever - Wazuh
baseurl=https://packages.wazuh.com/yum/el/$releasever/$basearch
protect=1
EOF

# Install ossec-server
yum -y install wazuh-manager

# Install ossec-api
curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -
yum -y install nodejs
yum -y install wazuh-api

# Configure ossec-manager
sed -i s%\<email_to\>recipient@example.wazuh.com\</email_to\>%\<email_to\>$1\</email_to\>%g /var/ossec/etc/ossec.conf
sed -i s%\<email_from\>ossecm@example.wazuh.com\</email_from\>%\<email_from\>$2\</email_from\>%g /var/ossec/etc/ossec.conf
sed -i s%\<smtp_server\>smtp.example.wazuh.com\</smtp_server\>%\<smtp_server\>$3\</smtp_server\>%g /var/ossec/etc/ossec.conf
sed -i s%\<email_notification\>no\</email_notification\>%\<email_notification\>yes\</email_notification\>%g /var/ossec/etc/ossec.conf

cat > /var/ossec/etc/share/agent.conf << EOF
<agent_config profile="zprofile">

  <syscheck>
    <scan_on_start>yes</scan_on_start>
    <frequency>1800</frequency>

    <directories check_all="yes">/etc,/usr/bin,/usr/sbin</directories>
    <directories check_all="yes">/bin,/sbin,/boot</directories>

    <ignore>/etc/mtab</ignore>
    <ignore>/etc/mnttab</ignore>
    <ignore>/etc/hosts.deny</ignore>
    <ignore>/etc/mail/statistics</ignore>
    <ignore>/etc/random-seed</ignore>
    <ignore>/etc/adjtime</ignore>
    <ignore>/etc/httpd/logs</ignore>
    <ignore>/etc/utmpx</ignore>
    <ignore>/etc/wtmpx</ignore>
    <ignore>/etc/cups/certs</ignore>
    <ignore>/etc/dumpdates</ignore>
    <ignore>/etc/svc/volatile</ignore>
  </syscheck>

  <rootcheck>
    <frequency>1800</frequency>
    <rootkit_files>/var/ossec/etc/shared/rootkit_files.txt</rootkit_files>
    <rootkit_trojans>/var/ossec/etc/shared/rootkit_trojans.txt</rootkit_trojans>
    <system_audit>/var/ossec/etc/shared/system_audit_rcl.txt</system_audit>
    <system_audit>/var/ossec/etc/shared/cis_debian_linux_rcl.txt</system_audit>
    <system_audit>/var/ossec/etc/shared/cis_rhel_linux_rcl.txt</system_audit>
    <system_audit>/var/ossec/etc/shared/cis_rhel5_linux_rcl.txt</system_audit>
  </rootcheck>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/messages</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/authlog</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/secure</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/xferlog</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/maillog</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/yum.log</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/auth.log</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/syslog</location>
  </localfile>

  <localfile>
    <log_format>syslog</log_format>
    <location>/var/log/dpkg.log</location>
  </localfile>

</agent_config>
EOF

# Create key and certificate
openssl genrsa -out /var/ossec/etc/sslmanager.key 2048
openssl req -new -x509 -key /var/ossec/etc/sslmanager.key -out /var/ossec/etc/sslmanager.cert -days 365 -subj "/C=CA/ST=Vancouver/L=Vancouver/O=Global Security/OU=IT Department/CN=zafin.com"
chmod 400 /var/ossec/etc/sslmanager.*

# Start ossec-authd
cat > /etc/systemd/system/ossec-authd.service << EOF
[Unit]
Description=ossec-authd Service
After=network.target
After=wazuh-manager.service
Requires=wazuh-manager.service

[Service]
Type=simple
User=root
ExecStart=/var/ossec/bin/ossec-authd -p 1515
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ossec-authd.service
systemctl start ossec-authd.service

# Install and configure FileBeat
rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch

cat > /etc/yum.repos.d/elastic.repo << EOF
[elastic-5.x]
name=Elastic repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum -y install filebeat
curl -so /etc/filebeat/filebeat.yml https://raw.githubusercontent.com/wazuh/wazuh/2.0/extensions/filebeat/filebeat.yml

sed -i s/ELASTIC_SERVER_IP/$4/g /etc/filebeat/filebeat.yml

systemctl daemon-reload
systemctl enable filebeat.service
systemctl start filebeat.service