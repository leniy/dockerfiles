#!/bin/bash
#Cacti Backup script

VERSION="v0.0.2"
NAME="Cacti-Backup"

MYSQL_USER='cacti'
MYSQL_PASS='leniy.org'
MYSQL_DB='cacti'
CACTI_RRA_DIR="/var/lib/cacti/rra/"

#create backup dir
CURRENT_DATE=`date +%Y%m%d_%H%M%S`
BACKUP_DIR1="/var/cactibackups/$CURRENT_DATE/"
BACKUP_DIR2="/var/cactibackups/latest/"
mkdir -p ${BACKUP_DIR1}
mkdir -p ${BACKUP_DIR2}

#backup mysql
DUMP_DB_FILE=${BACKUP_DIR1}"cacti_backups.sql"
mysqldump --user=${MYSQL_USER} --password=${MYSQL_PASS} ${MYSQL_DB} > ${DUMP_DB_FILE}
cp ${BACKUP_DIR1}"cacti_backups.sql" ${BACKUP_DIR2}"cacti_backups.sql"

#backup rra files
RRA_FILE=${BACKUP_DIR1}"rra_backups.tar.gz"
tar -zcvf ${RRA_FILE} ${CACTI_RRA_DIR}
cp ${BACKUP_DIR1}"rra_backups.tar.gz" ${BACKUP_DIR2}"rra_backups.tar.gz"
