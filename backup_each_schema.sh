#!/bin/bash

export PGDATABASE=gpadmin

#init

mkdir -p ./pg_dumpall
rm -rf *.sql
rm -rf *.ori
rm -rf ./pg_dumpall/*.sql

#pg_dumpall

pg_dumpall --globals-only > ./all_bk/role.sql
pg_dumpall --schema-only  > ./all_bk/schema_all.sql


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
	sed 's/CREATE INDEX/-- CREATE INDEX/g' $nspname.sql  > $nspname"_without_index".sql
	rm PK.sql
    fi
done
