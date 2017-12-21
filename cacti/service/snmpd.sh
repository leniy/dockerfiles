#!/bin/bash
#请确保chmod +x

exec /usr/sbin/snmpd >>/var/log/snmpd.log 2>&1
