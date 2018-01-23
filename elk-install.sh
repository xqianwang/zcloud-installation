#!/bin/bash

setup_yum_repo(){
cat << EOF
[base]
name=CentOS-7 - Base
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/centos/7/os/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[updates]
name=CentOS-7 - Updates
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/centos/7/updates/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[extras]
name=CentOS-7 - Extras
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/centos/7/extras/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7

[docker-ce-stable]
name=Docker CE Stable
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/docker-ce/7/x86_64/stable/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/Docker-GPG-KEY

[openlogic]
name=OpenLogic releases
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/openlogic/7.4.1708/openlogic/x86_64/
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/OpenLogic-GPG-KEY

[epel]
name=EPEL
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/epel/7/x86_64/
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

[elk-6.x]
name=ELK
baseurl=https://yum:$1@artifactory.zcloudcentral.com/artifactory/elk6
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/ELK-GPG-KEY
enabled=1
autorefresh=1
type=rpm-md

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

setup_epel_gpgkey(){
cat << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.11 (GNU/Linux)

mQINBFKuaIQBEAC1UphXwMqCAarPUH/ZsOFslabeTVO2pDk5YnO96f+rgZB7xArB
OSeQk7B90iqSJ85/c72OAn4OXYvT63gfCeXpJs5M7emXkPsNQWWSju99lW+AqSNm
jYWhmRlLRGl0OO7gIwj776dIXvcMNFlzSPj00N2xAqjMbjlnV2n2abAE5gq6VpqP
vFXVyfrVa/ualogDVmf6h2t4Rdpifq8qTHsHFU3xpCz+T6/dGWKGQ42ZQfTaLnDM
jToAsmY0AyevkIbX6iZVtzGvanYpPcWW4X0RDPcpqfFNZk643xI4lsZ+Y2Er9Yu5
S/8x0ly+tmmIokaE0wwbdUu740YTZjCesroYWiRg5zuQ2xfKxJoV5E+Eh+tYwGDJ
n6HfWhRgnudRRwvuJ45ztYVtKulKw8QQpd2STWrcQQDJaRWmnMooX/PATTjCBExB
9dkz38Druvk7IkHMtsIqlkAOQMdsX1d3Tov6BE2XDjIG0zFxLduJGbVwc/6rIc95
T055j36Ez0HrjxdpTGOOHxRqMK5m9flFbaxxtDnS7w77WqzW7HjFrD0VeTx2vnjj
GqchHEQpfDpFOzb8LTFhgYidyRNUflQY35WLOzLNV+pV3eQ3Jg11UFwelSNLqfQf
uFRGc+zcwkNjHh5yPvm9odR1BIfqJ6sKGPGbtPNXo7ERMRypWyRz0zi0twARAQAB
tChGZWRvcmEgRVBFTCAoNykgPGVwZWxAZmVkb3JhcHJvamVjdC5vcmc+iQI4BBMB
AgAiBQJSrmiEAhsPBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRBqL66iNSxk
5cfGD/4spqpsTjtDM7qpytKLHKruZtvuWiqt5RfvT9ww9GUUFMZ4ZZGX4nUXg49q
ixDLayWR8ddG/s5kyOi3C0uX/6inzaYyRg+Bh70brqKUK14F1BrrPi29eaKfG+Gu
MFtXdBG2a7OtPmw3yuKmq9Epv6B0mP6E5KSdvSRSqJWtGcA6wRS/wDzXJENHp5re
9Ism3CYydpy0GLRA5wo4fPB5uLdUhLEUDvh2KK//fMjja3o0L+SNz8N0aDZyn5Ax
CU9RB3EHcTecFgoy5umRj99BZrebR1NO+4gBrivIfdvD4fJNfNBHXwhSH9ACGCNv
HnXVjHQF9iHWApKkRIeh8Fr2n5dtfJEF7SEX8GbX7FbsWo29kXMrVgNqHNyDnfAB
VoPubgQdtJZJkVZAkaHrMu8AytwT62Q4eNqmJI1aWbZQNI5jWYqc6RKuCK6/F99q
thFT9gJO17+yRuL6Uv2/vgzVR1RGdwVLKwlUjGPAjYflpCQwWMAASxiv9uPyYPHc
ErSrbRG0wjIfAR3vus1OSOx3xZHZpXFfmQTsDP7zVROLzV98R3JwFAxJ4/xqeON4
vCPFU6OsT3lWQ8w7il5ohY95wmujfr6lk89kEzJdOTzcn7DBbUru33CQMGKZ3Evt
RjsC7FDbL017qxS+ZVA/HGkyfiu4cpgV8VUnbql5eAZ+1Ll6Dw==
=hdPa
-----END PGP PUBLIC KEY BLOCK-----

EOF
}

setup_elk_gpgkey(){
cat << EOF
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2.0.14 (GNU/Linux)

mQENBFI3HsoBCADXDtbNJnxbPqB1vDNtCsqhe49vFYsZN9IOZsZXgp7aHjh6CJBD
A+bGFOwyhbd7at35jQjWAw1O3cfYsKAmFy+Ar3LHCMkV3oZspJACTIgCrwnkic/9
CUliQe324qvObU2QRtP4Fl0zWcfb/S8UYzWXWIFuJqMvE9MaRY1bwUBvzoqavLGZ
j3SF1SPO+TB5QrHkrQHBsmX+Jda6d4Ylt8/t6CvMwgQNlrlzIO9WT+YN6zS+sqHd
1YK/aY5qhoLNhp9G/HxhcSVCkLq8SStj1ZZ1S9juBPoXV1ZWNbxFNGwOh/NYGldD
2kmBf3YgCqeLzHahsAEpvAm8TBa7Q9W21C8vABEBAAG0RUVsYXN0aWNzZWFyY2gg
KEVsYXN0aWNzZWFyY2ggU2lnbmluZyBLZXkpIDxkZXZfb3BzQGVsYXN0aWNzZWFy
Y2gub3JnPokBOAQTAQIAIgUCUjceygIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgEC
F4AACgkQ0n1mbNiOQrRzjAgAlTUQ1mgo3nK6BGXbj4XAJvuZDG0HILiUt+pPnz75
nsf0NWhqR4yGFlmpuctgCmTD+HzYtV9fp9qW/bwVuJCNtKXk3sdzYABY+Yl0Cez/
7C2GuGCOlbn0luCNT9BxJnh4mC9h/cKI3y5jvZ7wavwe41teqG14V+EoFSn3NPKm
TxcDTFrV7SmVPxCBcQze00cJhprKxkuZMPPVqpBS+JfDQtzUQD/LSFfhHj9eD+Xe
8d7sw+XvxB2aN4gnTlRzjL1nTRp0h2/IOGkqYfIG9rWmSLNlxhB2t+c0RsjdGM4/
eRlPWylFbVMc5pmDpItrkWSnzBfkmXL3vO2X3WvwmSFiQbkBDQRSNx7KAQgA5JUl
zcMW5/cuyZR8alSacKqhSbvoSqqbzHKcUQZmlzNMKGTABFG1yRx9r+wa/fvqP6OT
RzRDvVS/cycws8YX7Ddum7x8uI95b9ye1/Xy5noPEm8cD+hplnpU+PBQZJ5XJ2I+
1l9Nixx47wPGXeClLqcdn0ayd+v+Rwf3/XUJrvccG2YZUiQ4jWZkoxsA07xx7Bj+
Lt8/FKG7sHRFvePFU0ZS6JFx9GJqjSBbHRRkam+4emW3uWgVfZxuwcUCn1ayNgRt
KiFv9jQrg2TIWEvzYx9tywTCxc+FFMWAlbCzi+m4WD+QUWWfDQ009U/WM0ks0Kww
EwSk/UDuToxGnKU2dQARAQABiQEfBBgBAgAJBQJSNx7KAhsMAAoJENJ9ZmzYjkK0
c3MIAIE9hAR20mqJWLcsxLtrRs6uNF1VrpB+4n/55QU7oxA1iVBO6IFu4qgsF12J
TavnJ5MLaETlggXY+zDef9syTPXoQctpzcaNVDmedwo1SiL03uMoblOvWpMR/Y0j
6rm7IgrMWUDXDPvoPGjMl2q1iTeyHkMZEyUJ8SKsaHh4jV9wp9KmC8C+9CwMukL7
vM5w8cgvJoAwsp3Fn59AxWthN3XJYcnMfStkIuWgR7U2r+a210W6vnUxU4oN0PmM
cursYPyeV0NX/KQeUeNMwGTFB6QHS/anRaGQewijkrYYoTNtfllxIu9XYmiBERQ/
qPDlGRlOgVTd9xUfHFkzB52c70E=
=92oX
-----END PGP PUBLIC KEY BLOCK-----

EOF
}

#Change yum repo
rm -f /etc/yum.repos.d/*
sed -i 's/enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf
rm -rf /var/cache/yum
setup_yum_repo $1 > /etc/yum.repos.d/CentOS-Artifactory.repo
setup_openlogic_gpgkey > /etc/pki/rpm-gpg/OpenLogic-GPG-KEY
setup_docker_gpgkey > /etc/pki/rpm-gpg/Docker-GPG-KEY
setup_epel_gpgkey > /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
setup_elk_gpgkey > /etc/pki/rpm-gpg/ELK-GPG-KEY

# Update everything
yum update -y --exclude=WALinuxAgent

# Install Java
yum -y install java-1.8.0-openjdk.x86_64

# Install Elasticsearch
yum -y install elasticsearch

# Start Elasticsearch service
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

# Install Kibana
yum -y install kibana

# Start Kibana service
systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana.service

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

