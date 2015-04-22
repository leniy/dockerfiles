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

RUN mkdir /etc/service/cacti
ADD cactiservice.sh /etc/service/cacti/run
RUN chmod +x /etc/service/cacti/run

COPY setmysqluser.sh /sbin/setmysqluser.sh
RUN chmod +x /sbin/setmysqluser.sh && /bin/bash -c /sbin/setmysqluser.sh && rm /sbin/setmysqluser.sh

COPY cacti.conf /etc/dbconfig-common/cacti.conf
COPY debian.php /etc/cacti/debian.php
COPY snmpd.conf /etc/snmp/snmpd.conf
COPY spine.conf /etc/cacti/spine.conf

EXPOSE 80 161

CMD ["/sbin/my_init"]
