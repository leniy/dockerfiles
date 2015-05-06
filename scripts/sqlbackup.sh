#!/bin/bash
#Backup mysql

SQL_ROOT_PASSWD="leniy.org";
mysqldump -u root -p$SQL_ROOT_PASSWD --all-databases > /var/backups/all_datebases.sql
