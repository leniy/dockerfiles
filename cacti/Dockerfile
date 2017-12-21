FROM phusion/baseimage:0.9.22
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

#Copy all files to temp folder
COPY / /tmp/

RUN echo "#Add services" \
    ; mkdir /etc/service/mysqld \
    ; mkdir /etc/service/snmpd \
    ; mkdir /etc/service/apache2 \
    ; mv /tmp/service/mysqld.sh /etc/service/mysqld/run \
    ; mv /tmp/service/snmpd.sh /etc/service/snmpd/run \
    ; mv /tmp/service/apache2.sh /etc/service/apache2/run \
    ; chmod +x /etc/service/mysqld/run \
    ; chmod +x /etc/service/snmpd/run \
    ; chmod +x /etc/service/apache2/run \
    ; echo "#Set mysql user && Load configured cacti sql by Leniy, to prevent manually configuration at first visit" \
    ; mv /tmp/scripts/setmysqluser.sh /sbin/setmysqluser.sh \
    ; mkdir -p /var/cactibackups \
    ; mv /tmp/scripts/configured_cacti.sql /var/cactibackups/cacti_backups.sql \
    ; chmod +x /sbin/setmysqluser.sh \
    ; mkdir /var/run/mysqld \
    ; chown mysql:mysql /var/run/mysqld \
    ; /bin/bash -c /sbin/setmysqluser.sh \
    ; rm /sbin/setmysqluser.sh \
    ; echo "#Copy config files" \
    ; mv /tmp/config/cacti.conf /etc/dbconfig-common/cacti.conf \
    ; mv /tmp/config/debian.php /etc/cacti/debian.php \
    ; mv /tmp/config/snmpd.conf /etc/snmp/snmpd.conf \
    ; mv /tmp/config/spine.conf /etc/cacti/spine.conf \
    ; echo "#Backup and restore tools" \
    ; echo "#use 'docker inspect -f {{.Volumes}} <container-id>' to find where /var/cactibackups maps in host" \
    ; echo "#manually start bachup or restore, use ' docker exec <container-id> cactibackup/cactirestore'" \
    ; mv /tmp/scripts/cactibackup.sh /sbin/cactibackup \
    ; mv /tmp/scripts/cactirestore.sh /sbin/cactirestore \
    ; chmod +x /sbin/cactibackup /sbin/cactirestore \
    ; echo "#Copy website files to www-root" \
    ; mv /tmp/website/* /var/www/html/ \
    ; echo "#Install plugins to cacti folder" \
    ; mv /tmp/plugins/* /usr/share/cacti/site/plugins/ \
    ; cd /usr/share/cacti/site/plugins/ \
    ; tar -xvzf monitor-v1.3-1.tgz \
    ; tar -xvzf settings-v0.71-1.tgz \
    ; tar -xvzf thold-v0.5.0.tgz \
    ; tar -xvzf php-weathermap-0.97c.tgz \
    ; rm /usr/share/cacti/site/plugins/*.tgz \
    ; chown -R www-data:www-data weathermap/output/ weathermap/configs/

VOLUME ["/var/cactibackups"]

#Listen on the specified network ports
EXPOSE 80 161

#Provide defaults for an executing container
CMD ["/sbin/my_init"]
