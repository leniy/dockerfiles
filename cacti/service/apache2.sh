#!/bin/bash
#请确保chmod +x

#脚本参考自http://askubuntu.com/questions/3126/upstart-supervised-init-script-for-apache
read pid cmd state ppid pgrp session tty_nr tpgid rest < /proc/self/stat
trap "kill -TERM -$pgrp; exit" EXIT TERM KILL SIGKILL SIGTERM SIGQUIT
source /etc/apache2/envvars
apache2 -D FOREGROUND >>/var/log/apache2.log 2>&1
