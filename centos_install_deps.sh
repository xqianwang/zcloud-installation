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

sed -i 's/requiretty/!requiretty/g' /etc/sudoers

yum install epel-release -y && yum clean all
yum install wget git net-tools bind-utils iptables-services bridge-utils bash-completion yum-utils ansible docker -y
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
   exit 3
fi

systemctl enable docker
systemctl start docker

echo "Configuring network now!"

sed -i 's/NM_CONTROLLED=no/NM_CONTROLLED=yes/g'  /etc/sysconfig/network-scripts/ifcfg-eth0
systemctl enable NetworkManager.service
systemctl restart NetworkManager.service

if [ $? -ne 0 ]; then
   echo "Error: Cannot configure NetworkManager!"
   exit 4
fi

sed -i '/^HOSTNAME/d' /etc/sysconfig/network
echo "HOSTNAME=`hostname -f`" > /etc/sysconfig/network
sudo systemctl restart network

if [ $? -ne 0 ]; then
   echo "Error: Cannot restart network service!"
   exit 5
fi

mkdir -p /etc/origin/node/
echo "server 168.63.129.16" > /etc/origin/node/resolv.conf

echo "Installation finished"
