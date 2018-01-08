#!/bin/bash

setup_yum_repo(){
cat << EOF
[base]
name=CentOS-7 - Base
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/centos/7/os/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released updates
[updates]
name=CentOS-7 - Updates
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/centos/7/updates/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#released extras
[extras]
name=CentOS-7 - Extras
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/centos/7/extras/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

#docker ce
[docker-ce-stable]
name=Docker CE Stable
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/docker-ce/7/x86_64/stable/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/Docker-GPG-KEY

#openlogic
[openlogic]
name=OpenLogic releases
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/openlogic/7/openlogic/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/OpenLogic-GPG-KEY

EOF
}

setup_openlogic_gpgkey(){
cat << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.14 (GNU/Linux)

mQENBFLWzI0BCAC4HfUh5EYvJiDdE3u/Vz6dwe+77S15F3CcwPZaTbys02Cf8xp5
W/P9oSV0yBYGSRLEYTZE8RWyC4pdBjG9uxeoDnRsBG5BZnq3WbX2FiQzjSohtjbV
SqfTiY9d+RqEmXnVR2TeHJxEZgzFUre13x9KtNJxAb1aTOeF6lyoFXeKo1d7fwVL
8es7OYpsWTw4j94iNNK3Af3FSNPU+Q8sjxwCy/VCDCchCNbVTaWuQy7XlbfFHGY7
FZj8lX8KTJY7oQvISMhvHFron5O5/N97sNwMSPRDSfseo4CtbsuEN0ogzwLRPZXQ
+ykXBWPabpbT4lTNwb0KautMpmA/4maVWsxRABEBAAG0QU9wZW5Mb2dpYyBJbmMg
KE9wZW5Mb2dpYyBSUE0gRGV2ZWxvcG1lbnQpIDxzdXBwb3J0QG9wZW5sb2dpYy5j
b20+iQE4BBMBAgAiBQJS1syNAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAK
CRALPtwGKqBNvVWaB/0XEPMnxLGXM+OPWbAgaNHKQ5HD7p+qW/nwofJq/KbntQXS
Ud147D5K0zc9wyejXQOiAr/OoAwoziajdswinUmLnfcm5k9XLTd/Yc34a4/D2Ho0
iBxybhx3mlvw42dP7Mdxs2BAbuVq3betHvdXaSgCBdgAis8qGtus954NpteTc3tK
/SRzfjIG9iN5Oqyxsz3MA0vmvBE/eb8MZxPVG2RKHof0IogpQ3+louZBdDjQQ8U1
lebdqNH9yew6ANu45EOgLDzaaDmFb27mvkVxODdXMIQKRXBg4HXfpL7d9D+xyOXT
Ag/VDx7vu31BlAOX6qwXt2qyPEHByVa96nsAy1hfuQENBFLWzI0BCADYW9A/937b
n1Xt0rekaur6NYCCrIRr7hMfQ6t+QOPch6AI6YU9SaWkeXFExzp8J2AOT3q9H9zf
UHJndya+hVQcinNmzn+BmvAwjE86oIbLdeuycxsNqIgo47TQ0BNH06bFPHRreUz2
ophRyqRRt4HZlnrqPrj3/NbwqpeXC5R2GuNaPUATPnvswxwzeMEr649ypfCH6amY
9hSQ+Iaxomq7n2lPhw6ubDqL8MYY+pMvGNqRUIDgsBv0e/Ept4YNWewcOjp2muoM
hC5qDr5oTf3yHn68bnWKJSoUyoQkIIB7euB+v3ThUu5u1e+6OyalSCP/Eu4VUJG3
elKO4seEmU5xABEBAAGJAR8EGAECAAkFAlLWzI0CGwwACgkQCz7cBiqgTb1sdAgA
tkNerkIOUPHcvxhbI0EZ9Z7dYHc1WMmlujYxtFEErjDoWmxpgjHaZ8hxgZhh4qhI
jd9qvcVswMPoVbpPNWHc0wy77SaHHppf8NvR3REBOzBLqTdfBnoJmbdEysxdLkLT
EvcKl89Z8HChe23LRDov5orN+MFCD/7s85pe2HHYfnhfD7vV9lyu+wXSNPkjmyE+
L8cKyhODQ3JWJ3jk1TooJbja3cdx+XwbYkhxkrIkxJnFIiY7EV2pP9X9YrmebtUB
ydoONT+f+x7RDrGJd4vgCPLPCGz1TbEooo+d/k95NeMgUJkLj8DlopMKrAwHgtfW
B66zoGSEBTT/yu550aayTQ==
=ZInH
-----END PGP PUBLIC KEY BLOCK-----

EOF
}

setup_docker_gpgkey(){
cat << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----

mQINBFit5IEBEADDt86QpYKz5flnCsOyZ/fk3WwBKxfDjwHf/GIflo+4GWAXS7wJ
1PSzPsvSDATV10J44i5WQzh99q+lZvFCVRFiNhRmlmcXG+rk1QmDh3fsCCj9Q/yP
w8jn3Hx0zDtz8PIB/18ReftYJzUo34COLiHn8WiY20uGCF2pjdPgfxE+K454c4G7
gKFqVUFYgPug2CS0quaBB5b0rpFUdzTeI5RCStd27nHCpuSDCvRYAfdv+4Y1yiVh
KKdoe3Smj+RnXeVMgDxtH9FJibZ3DK7WnMN2yeob6VqXox+FvKYJCCLkbQgQmE50
uVK0uN71A1mQDcTRKQ2q3fFGlMTqJbbzr3LwnCBE6hV0a36t+DABtZTmz5O69xdJ
WGdBeePCnWVqtDb/BdEYz7hPKskcZBarygCCe2Xi7sZieoFZuq6ltPoCsdfEdfbO
+VBVKJnExqNZCcFUTEnbH4CldWROOzMS8BGUlkGpa59Sl1t0QcmWlw1EbkeMQNrN
spdR8lobcdNS9bpAJQqSHRZh3cAM9mA3Yq/bssUS/P2quRXLjJ9mIv3dky9C3udM
+q2unvnbNpPtIUly76FJ3s8g8sHeOnmYcKqNGqHq2Q3kMdA2eIbI0MqfOIo2+Xk0
rNt3ctq3g+cQiorcN3rdHPsTRSAcp+NCz1QF9TwXYtH1XV24A6QMO0+CZwARAQAB
tCtEb2NrZXIgUmVsZWFzZSAoQ0UgcnBtKSA8ZG9ja2VyQGRvY2tlci5jb20+iQI3
BBMBCgAhBQJYrep4AhsvBQsJCAcDBRUKCQgLBRYCAwEAAh4BAheAAAoJEMUv62ti
Hp816C0P/iP+1uhSa6Qq3TIc5sIFE5JHxOO6y0R97cUdAmCbEqBiJHUPNQDQaaRG
VYBm0K013Q1gcJeUJvS32gthmIvhkstw7KTodwOM8Kl11CCqZ07NPFef1b2SaJ7l
TYpyUsT9+e343ph+O4C1oUQw6flaAJe+8ATCmI/4KxfhIjD2a/Q1voR5tUIxfexC
/LZTx05gyf2mAgEWlRm/cGTStNfqDN1uoKMlV+WFuB1j2oTUuO1/dr8mL+FgZAM3
ntWFo9gQCllNV9ahYOON2gkoZoNuPUnHsf4Bj6BQJnIXbAhMk9H2sZzwUi9bgObZ
XO8+OrP4D4B9kCAKqqaQqA+O46LzO2vhN74lm/Fy6PumHuviqDBdN+HgtRPMUuao
xnuVJSvBu9sPdgT/pR1N9u/KnfAnnLtR6g+fx4mWz+ts/riB/KRHzXd+44jGKZra
IhTMfniguMJNsyEOO0AN8Tqcl0eRBxcOArcri7xu8HFvvl+e+ILymu4buusbYEVL
GBkYP5YMmScfKn+jnDVN4mWoN1Bq2yMhMGx6PA3hOvzPNsUoYy2BwDxNZyflzuAi
g59mgJm2NXtzNbSRJbMamKpQ69mzLWGdFNsRd4aH7PT7uPAURaf7B5BVp3UyjERW
5alSGnBqsZmvlRnVH5BDUhYsWZMPRQS9rRr4iGW0l+TH+O2VJ8aQ
=0Zqq
-----END PGP PUBLIC KEY BLOCK-----

EOF
}

#Change yum repo
rm -f /etc/yum.repos.d/*
setup_yum_repo $1 > /etc/yum.repos.d/CentOS-Artifactory.repo
setup_openlogic_gpgkey > /etc/pki/rpm-gpg/OpenLogic-GPG-KEY
setup_docker_gpgkey > /etc/pki/rpm-gpg/Docker-GPG-KEY

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