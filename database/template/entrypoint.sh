#!/bin/bash
set -e

# Start PostgreSQL
docker-entrypoint.sh postgres &

# Wait for PostgreSQL to start
sleep 10

# Restore database if backup exists
if [ -f "/docker-entrypoint-initdb.d/test.sql" ]; then
    echo "Restoring database..."
    psql -U $POSTGRES_USER -d $POSTGRES_DB < /docker-entrypoint-initdb.d/test.sql
fi

# Keep the container running
wait
