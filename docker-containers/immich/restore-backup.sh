#!/bin/bash

# Crontab
# @reboot /path/to/script/restore-backup.sh

cd /path/to/docker-compose.yaml

docker compose down -v  # CAUTION! Deletes all Immich data to start from scratch.
docker compose create   # Create Docker containers for Immich apps without running them.
docker start immich_postgres    # Start Postgres server
sleep 10    # Wait for Postgres server to start up
gunzip < "/path/to/*_db_backup.sql.gz" \
| sed "s/SELECT pg_catalog.set_config('search_path', '', false);/SELECT pg_catalog.set_config('search_path', 'public, pg_catalog', true);/g" \
| docker exec -i immich_postgres psql --username=postgres    # Restore Backup
docker compose up -d    # Start remainder of Immich apps
