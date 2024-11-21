#!/bin/bash

export PGDATABASE=gpadmin

#init

rm -rf ./all_backup
mkdir -p ./all_backup/conf
mkdir -p ./all_backup/env
rm -rf *.sql
rm -rf *.ori
rm -rf ./all_backup/*.*
rm -rf ./all_backup/conf/*
rm -rf ./all_backup/env/*

#pg_dumpall

pg_dumpall --globals-only > ./all_backup/role.sql
pg_dumpall --schema-only  > ./all_backup/pg_dump_all.sql

#postgresql.conf backup

cp /data/master/gpseg-1/postgresql.conf  ./all_backup/conf/mst_postgresql.conf
scp -r gpadmin@sdw1:/data1/primary/gpseg0/postgresql.conf ./all_backup/conf/seg_postgresql.conf
cp /data/master/gpseg-1/pg_hba.conf  ./all_backup/conf/mst_pg_hba.conf

# gpadmin env
cp /home/gpadmin/.bashrc ./all_backup/env/bashrc
cp /home/gpadmin/.bash_profile ./all_backup/env/bash_profile
cp /home/gpadmin/.pgpass ./all_backup/env/pgpass

#OS Kernel
cp /etc/sysctl.conf ./all_backup/env/mst_sysctl.conf
scp -r gpadmin@sdw1:/etc/sysctl.conf ./all_backup/env/seg_sysctl.conf

#user_schema_check

SCHEMA_NAME=$(psql -U gpadmin -t -A -c "SELECT nspname FROM pg_catalog.pg_namespace where nspname not in ('gp_toolkit','pg_toast','pg_bitmapindex','pg_aoseg','pg_catalog','information_schema') order by 1;")

#each user schema ddl export

IFS=$'\n' 
for nspname in $SCHEMA_NAME; do
    if [ -n "$nspname" ]; then
	pg_dump --schema=$nspname --schema-only  > $nspname.sql
	#cp $nspname.sql $nspname.ori
	cat $nspname.sql |grep -B 1 'PRIMARY KEY' > PK.sql
	sed 'N;s/\n/ /' PK.sql> $nspname"_crt_idx".sql
	cat $nspname.sql |grep 'CREATE INDEX' 		>> $nspname"_crt_idx".sql 
	cat $nspname.sql | sed 's/ALTER TABLE ONLY/-- ALTER TABLE ONLY/' | sed 's/ADD CONSTRAINT/-- ADD CONSTRAINT/' > $nspname"_without_index".sql
	rm PK.sql
    fi
done
