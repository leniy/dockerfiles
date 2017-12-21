#!/bin/bash
#请确保chmod +x

exec /sbin/setuser mysql /usr/bin/mysqld_safe >>/var/log/mysqld.log 2>&1
