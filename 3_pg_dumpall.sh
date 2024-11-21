#!/bin/bash
export PGDATABASE=gpadmin

#pg_dumpall

pg_dumpall --globals-only > ./all_backup/role.sql
pg_dumpall --schema-only  > ./all_backup/pg_dump_all.sql

