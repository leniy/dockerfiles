FROM phusion/baseimage:0.9.19
MAINTAINER Leniy Tsan <m@leniy.org>

#Install packages
RUN echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse" > /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-security main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-proposed main restricted universe multiverse" >> /etc/apt/sources.list \
    && echo "deb http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-backports main restricted universe multiverse" >> /etc/apt/sources.list \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -yq snmpd cacti cacti-spine sendmail \
    && apt-get clean \
    && rm -rf /tmp/* \
    && rm -rf /var/tmp/* \
    && rm -rf /var/lib/apt/lists/*

#Add services
RUN mkdir /etc/service/mysqld \
          /etc/service/snmpd \
          /etc/service/apache2
COPY service/mysqld.sh /etc/service/mysqld/run
COPY service/snmpd.sh /etc/service/snmpd/run
COPY service/apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/mysqld/run \
             /etc/service/snmpd/run \
             /etc/service/apache2/run

#Set mysql user && Load configured cacti sql by Leniy, to prevent manually configuration at first visit
COPY scripts/setmysqluser.sh /sbin/setmysqluser.sh
COPY scripts/configured_cacti.sql /var/cactibackups/cacti_backups.sql
RUN chmod +x /sbin/setmysqluser.sh \
    && /bin/bash -c /sbin/setmysqluser.sh \
    && rm /sbin/setmysqluser.sh

#Copy config files
COPY config/cacti.conf /etc/dbconfig-common/cacti.conf
COPY config/debian.php /etc/cacti/debian.php
COPY config/snmpd.conf /etc/snmp/snmpd.conf
COPY config/spine.conf /etc/cacti/spine.conf

#Backup and restore tools
#use 'docker inspect -f {{.Volumes}} <container-id>' to find where /var/cactibackups maps in host
#manually start bachup or restore, use ' docker exec <container-id> cactibackup/cactirestore'
COPY scripts/cactibackup.sh /sbin/cactibackup
COPY scripts/cactirestore.sh /sbin/cactirestore
RUN chmod +x /sbin/cactibackup /sbin/cactirestore
VOLUME ["/var/cactibackups"]

#Copy website files to www-root
COPY website/* /var/www/html/

#Install plugins to cacti folder
COPY plugins/* /usr/share/cacti/site/plugins/
RUN cd /usr/share/cacti/site/plugins/ \
    && tar -xvzf monitor-v1.3-1.tgz \
    && tar -xvzf settings-v0.71-1.tgz \
    && tar -xvzf thold-v0.5.0.tgz \
    && tar -xvzf php-weathermap-0.97c.tgz \
    && rm /usr/share/cacti/site/plugins/*.tgz \
    && chown -R www-data:www-data weathermap/output/ weathermap/configs/

#RUN cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime

#Listen on the specified network ports
EXPOSE 80 161

#Provide defaults for an executing container
CMD ["/sbin/my_init"]
