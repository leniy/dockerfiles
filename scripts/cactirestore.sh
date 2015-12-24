#!/bin/bash
#Restore mysql

SQL_CACTI_PASSWD="leniy.org";
mysql -u cacti -p$SQL_CACTI_PASSWD cacti < /var/cactibackups/latest/cacti_backups.sql
