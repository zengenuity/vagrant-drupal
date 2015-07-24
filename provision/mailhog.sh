#!/usr/bin/env bash

# Daemonize
cd /tmp
git clone git://github.com/bmc/daemonize.git
cd /tmp/daemonize
./configure
make
make install
ln -s /usr/local/sbin/daemonize /sbin

# Mailhog
MAILHOG_BINARY_URL=$1
curl -s -L -o /tmp/mailhog "$MAILHOG_BINARY_URL"
mv /tmp/mailhog /usr/local/bin
chmod 755 /usr/local/bin/mailhog
cp /vagrant/config/apps/mailhog/init /etc/init.d/mailhog
chmod 755 /etc/init.d/mailhog
update-rc.d mailhog defaults
/etc/init.d/mailhog start

# SSMTP
apt-get install -y ssmtp
cp /vagrant/config/apps/mailhog/ssmtp.conf /etc/ssmtp
echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php5/apache2/conf.d/99-custom.ini
echo 'sendmail_path = "/usr/sbin/ssmtp -t"' >> /etc/php5/cli/conf.d/99-custom.ini
apache2ctl restart
