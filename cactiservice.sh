#!/bin/bash
#请确保chmod +x

#1.启动mysqld
exec /sbin/setuser mysql /usr/bin/mysqld_safe >>/var/log/mysqld.log 2>&1 &

#2.启动snmpd
exec /usr/sbin/snmpd >>/var/log/snmpd.log 2>&1 &

#3.启动apache2
#脚本参考自http://askubuntu.com/questions/3126/upstart-supervised-init-script-for-apache
read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT
source /etc/apache2/envvars
apache2 -D FOREGROUND >>/var/log/apache2.log 2>&1

