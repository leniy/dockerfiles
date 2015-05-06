#使用docker上最流行的、接近50万次下载的基础系统
FROM phusion/baseimage
MAINTAINER Leniy Tsan <m@leniy.org>

# Install packages
#COPY aliyunsources.lst /etc/apt/sources.list
RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y snmpd cacti cacti-spine \
	&& apt-get clean \
	&& rm -rf /tmp/* \
	&& rm -rf /var/tmp/* \
	&& rm -rf /var/lib/apt/lists/*

#add services
RUN mkdir /etc/service/mysqld \
          /etc/service/snmpd \
		  /etc/service/apache2
COPY service/mysqld.sh /etc/service/mysqld/run
COPY service/snmpd.sh /etc/service/snmpd/run
COPY service/apache2.sh /etc/service/apache2/run
RUN chmod +x /etc/service/mysqld/run \
             /etc/service/snmpd/run \
			 /etc/service/apache2/run

#set mysql user
COPY setmysqluser.sh /sbin/setmysqluser.sh
RUN chmod +x /sbin/setmysqluser.sh && /bin/bash -c /sbin/setmysqluser.sh && rm /sbin/setmysqluser.sh

#copy config files
COPY config/cacti.conf /etc/dbconfig-common/cacti.conf
COPY config/debian.php /etc/cacti/debian.php
COPY config/snmpd.conf /etc/snmp/snmpd.conf
COPY config/spine.conf /etc/cacti/spine.conf

#copy website files to www-root
COPY website/* /var/www/html/

#listen on the specified network ports
EXPOSE 80 161

#provide defaults for an executing container
CMD ["/sbin/my_init"]
