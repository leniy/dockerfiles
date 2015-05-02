#!/bin/bash

#注意，在config文件中，也写入了密码，这儿修改后要同步改过来
if [ -z $SQL_ROOT_PASSWD ]; then
		SQL_ROOT_PASSWD="leniy.org";
fi
if [ -z $SQL_CACTI_PASSWD ]; then
		SQL_CACTI_PASSWD="leniy.org";
fi

/usr/bin/mysqld_safe > /dev/null 2>&1 &

RET=1
while [[ RET -ne 0 ]]; do
    sleep 1
    mysql -uroot -e "status" > /dev/null 2>&1
    RET=$?
done

mysqladmin -uroot password $SQL_ROOT_PASSWD
mysqladmin -uroot -p$SQL_ROOT_PASSWD reload
mysqladmin -uroot -p$SQL_ROOT_PASSWD create cacti
mysql -uroot -p$SQL_ROOT_PASSWD cacti < /usr/share/cacti/conf_templates/cacti.sql
mysql -uroot -p$SQL_ROOT_PASSWD -e "GRANT ALL ON cacti.* TO cacti@localhost IDENTIFIED BY '$SQL_CACTI_PASSWD'; flush privileges;"
mysqladmin -uroot -p$SQL_ROOT_PASSWD shutdown
