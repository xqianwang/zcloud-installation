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

# Install Java
yum -y install java-1.8.0-openjdk.x86_64

# Install Elsticsearch repo
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
cat > /etc/yum.repos.d/elasticsearch.repo <<\EOF
[elasticsearch-5.x]
name=Elasticsearch repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

# Install Elasticsearch
yum -y install elasticsearch

# Start Elasticsearch service
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

# Install Kibana repo
cat > /etc/yum.repos.d/kibana.repo <<\EOF
[kibana-5.x]
name=Kibana repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

# Install Kibana
yum -y install kibana

# Start Kibana service
systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana.service

# Install Logstash repo
cat > /etc/yum.repos.d/logstash.repo <<\EOF
[logstash-5.x]
name=Elastic repository for 5.x packages
baseurl=https://artifacts.elastic.co/packages/5.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

# Install Logstash
yum -y install logstash

# Configure Logstash
mkdir -p /etc/logstash/conf.d
cat > /etc/logstash/conf.d/input-beats.conf <<\EOF
input {
   beats {
     type => beats
     port => 5044
     congestion_threshold => 60
   }
}
EOF

cat > /etc/logstash/conf.d/filters.conf <<\EOF
filter {
    multiline {
        max_age => 10
        periodic_flush => false
        pattern => "^(?!%{TIMESTAMP_ISO8601})"
        negate => false
        what => previous
    }

    grok {
        match => {
            "message" => [
                "^%{TIMESTAMP_ISO8601:timestamp}\s+%{LOGLEVEL:severity}\s+\[%{DATA:service},%{DATA:trace},%{DATA:span},%{DATA:exportable}\]\s+%{NUMBER:pid}\s+---\s+\[\s*%{DATA:thread}\s*\]\s+%{DATA:class}\s*:\s*%{GREEDYDATA:log_message}"
            ]
        }
    }

    date {
        match => [ "timestamp" , "yyyy-MM-dd HH:mm:ss.SSS" ]
    }
}
EOF

cat > /etc/logstash/conf.d/output.conf <<\EOF
output {
  elasticsearch {
    hosts => "localhost:9200"
    manage_template => false
    index => "%{[@metadata][beat]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}
EOF


# Start Kibana service
systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash.service

