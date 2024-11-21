#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")



#only user schema export

SCHEMA_NAME=$(psql -U gpadmin -t -A -c "SELECT nspname FROM pg_catalog.pg_namespace where nspname not in ('gp_toolkit','pg_toast','pg_bitmapindex','pg_aoseg','pg_catalog','information_schema') order by 1;")

#each user schema ddl export

mkdir -p ./all_backup/5_ddl

PWD=./all_backup/5_ddl 

IFS=$'\n' 
for nspname in $SCHEMA_NAME; do
    if [ -n "$nspname" ]; then
	pg_dump --schema=$nspname --schema-only  > $PWD/$nspname.sql
	cp $PWD/$nspname.sql $PWD/$nspname.ori
	cat $PWD/$nspname.sql |grep -B 1 'PRIMARY KEY' > $PWD/PK.sql
	sed 'N;s/\n/ /' $PWD/PK.sql> $PWD/$nspname"_crt_idx".sql
	cat $PWD/$nspname.sql |grep 'CREATE INDEX' 		>> $PWD/$nspname"_crt_idx".sql 
	cat $PWD/$nspname.sql |sed 's/CREATE INDEX/ -- CREATE INDEX/g' | sed 's/ALTER TABLE ONLY/-- ALTER TABLE ONLY/g' | sed 's/ADD CONSTRAINT/-- ADD CONSTRAINT/g' > $PWD/$nspname"_without_index".sql	
	rm $PWD/PK.sql
    fi
done
