#!/usr/bin/env bash

DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
. "$DIR/config.sh"

MYSQL_PASSWORD=$(get_var config_mysql_password)

mysqldump -u root --password=$MYSQL_PASSWORD --add-drop-database --flush-privileges --routines --all-databases > /var/data/db_backup.sql

if [ -f /var/data/db_backup.sql.gz ]; then
    rm -f /var/data/db_backup.sql.gz
fi

gzip /var/data/db_backup.sql
