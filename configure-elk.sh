#!/bin/bash
################################################################################################
# Copyright (c) 2018 by Zafin, All rights reserved.                                            #
# This source code, and resulting software, is the confidential and proprietary information    #
# ("Proprietary Information") and is the intellectual property ("Intellectual Property")       #
# of Zafin ("The Company"). You shall not disclose such Proprietary Information and            #
# shall use it only in accordance with the terms and conditions of any and all license         #
# agreements you have entered into with The Company.                                           #
################################################################################################

# Update everything
yum -qy update --exclude=WALinuxAgent

# Install Java
yum -qy install java-1.8.0-openjdk*

# Install Elasticsearch
yum -qy install elasticsearch

# Start Elasticsearch service
systemctl daemon-reload
systemctl enable elasticsearch.service
systemctl start elasticsearch.service

# Install Kibana
yum -qy install kibana

# Start Kibana service
systemctl daemon-reload
systemctl enable kibana.service
systemctl start kibana.service

# Install Logstash
yum -qy install logstash

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
    index => "%{[@metadata][beat]}-%{[@metadata][version]}-%{+YYYY.MM.dd}"
    document_type => "%{[@metadata][type]}"
  }
}
EOF

# Start Kibana service
systemctl daemon-reload
systemctl enable logstash.service
systemctl start logstash.service

# install filebeat plugin
/usr/share/logstash/bin/logstash-plugin install logstash-input-beats
curl -so filebeat-index-template.json https://gist.githubusercontent.com/thisismitch/3429023e8438cc25b86c/raw/d8c479e2a1adcea8b1fe86570e42abab0f10f364/filebeat-index-template.json
curl -XPUT -H 'Content-Type: application/json' 'http://localhost:9200/_template/filebeat?pretty' -d@filebeat-index-template.json
