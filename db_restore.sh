#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/config.sh"

if [ -f /var/data/db_backup.sql.gz ]; then
    gunzip -k /var/data/db_backup.sql
    mysql -u root --password=$MYSQL_PASSWORD < /var/data/db_backup.sql
    rm -f /var/data/db_backup.sql
fi
