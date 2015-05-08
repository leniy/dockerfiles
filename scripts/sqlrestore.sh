#!/bin/bash
#Restore mysql

SQL_CACTI_PASSWD="leniy.org";
mysql -u cacti -p$SQL_CACTI_PASSWD cacti < /var/backups/cacti_backups.sql
