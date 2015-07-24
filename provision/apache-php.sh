#!/usr/bin/env bash

# Apache / PHP
apt-get install -y apache2 php5 php5-xdebug php5-curl php-db php5-mcrypt php5-gd debconf-utils
echo 'xdebug.remote_connect_back = 1' >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo 'xdebug.remote_enable = 1' >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo 'xdebug.remote_handler = "dbgp"' >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo 'xdebug.remote_port = 9000' >> /etc/php5/apache2/conf.d/20-xdebug.ini
echo 'display_errors = On' >> /etc/php5/apache2/conf.d/99-custom.ini
echo "extension=mcrypt.so" >> /etc/php5/apache2/conf.d/99-custom.ini
cp /vagrant/config/apps/apache/000-default.conf /etc/apache2/sites-enabled/000-default.conf
a2enmod rewrite
apache2ctl restart
usermod -a -G www-data vagrant
