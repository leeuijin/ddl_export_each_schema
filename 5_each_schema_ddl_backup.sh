#!/bin/bash

export PGDATABASE=gpadmin

#only user schema export

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
	sed 's/CREATE INDEX/-- CREATE INDEX/g' $nspname.sql  > $nspname"_without_index_temp".sql
	sed 's/ALTER TABLE ONLY/-- ALTER TABLE ONLY/g' $nspname"_without_index_temp".sql > $nspname"_without_index".sql
	rm $nspname"_without_index_temp".sql
	rm PK.sql
    fi
done