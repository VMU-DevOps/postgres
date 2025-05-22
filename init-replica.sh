#!/bin/bash
rm -rf /var/lib/postgresql/data/*
pg_basebackup -h primary -D /var/lib/postgresql/data -U postgres -P --wal-method=stream
echo "primary_conninfo = 'host=primary port=5432 user=postgres password=postgres'" >> "$PGDATA/postgresql.conf"
echo "hot_standby = on" >> "$PGDATA/postgresql.conf"
echo "recovery_target_timeline = 'latest'" >> "$PGDATA/postgresql.conf"