#!/bin/bash

DB_USER="root"
DB_PASS="test"
DB_NAME="codeby"
BACKUP_DIR="/opt/mysql_backup"

mkdir -p /opt/mysql_backup

while true
do
    current_time=$(date +'%Y%m%d_%H%M%S')

    backup_file="$BACKUP_DIR/backup_$current_time.sql"

    mysqldump -u$DB_USER -p$DB_PASS $DB_NAME > $backup_file

    sleep 3600
done