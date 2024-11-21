#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#pg_dumpall

pg_dumpall --globals-only > ./all_backup/3_pg_dumpall/role_$TODAY.sql
pg_dumpall --schema-only  > ./all_backup/3_pg_dumpall/pg_dumpall_$TODAY.sql

