#!/bin/bash
set -e

# Start MariaDB
docker-entrypoint.sh mariadbd &

# Wait for MariaDB to start
sleep 10

# Restore database if backup exists
if [ -f "/docker-entrypoint-initdb.d/test.sql" ]; then
    if [ "$PRODUCTION" -ne "true" ]; then
        mysql -u "$MARIADB_USER" -p"$MARIADB_PASSWORD" "$MARIADB_DATABASE" < /docker-entrypoint-initdb.d/mock_data.sql
    fi
fi
wait
