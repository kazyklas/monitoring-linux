#!/bin/bash

# Crontab
# chmod +x /path/to/script/create-backup.sh
# 0 * * * * /path/to/script/create-backup.sh

docker exec \
	-t immich_postgres pg_dumpall \
	--clean --if-exists --username=postgres \
	| gzip > "/home/tklas/$(date +%Y%m%d%H_db_backup.sql.gz)"