#!/bin/bash

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    sleep 1
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done
mysqladmin -uroot password leniy.org
mysqladmin -uroot -pleniy.org reload
mysqladmin -uroot -pleniy.org create cacti
mysql -uroot -pleniy.org cacti < /usr/share/cacti/conf_templates/cacti.sql
mysql -uroot -pleniy.org -e "GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY 'leniy.org'; flush privileges;"
mysqladmin -uroot -pleniy.org shutdown



