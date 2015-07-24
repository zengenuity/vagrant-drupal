#!/usr/bin/env bash

MYSQL_PASSWORD=$1

# MySQL Server and PHPMyAdmin
echo "MySQL Root Password: $MYSQL_PASSWORD"
echo "mysql-server-5.5 mysql-server/root_password password $MYSQL_PASSWORD" | debconf-set-selections
echo "mysql-server-5.5 mysql-server/root_password_again password $MYSQL_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/dbconfig-install boolean true" | debconf-set-selections
echo "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_PASSWORD" | debconf-set-selections
echo "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2" | debconf-set-selections
apt-get install -y mysql-server phpmyadmin php5-mysql
echo '<?php' >> /etc/phpmyadmin/conf.d/custom.php
echo "\$cfg['LoginCookieValidity'] = 28800;" >> /etc/phpmyadmin/conf.d/custom.php
echo 'session.gc_maxlifetime = 28800' >> /etc/php5/apache2/conf.d/99-custom.ini
apache2ctl restart
