#!/bin/bash
TODAY=$(date "+%Y%m%d")

#only user database

DATNAME=$(psql -U gpadmin -t -A -c "select datname from pg_database where datname not in ('template0','template1','gpperfmon') order by 1;")


#each user schema ddl export

mkdir -p ./all_backup/6_each_database_ddl

PWD=./all_backup/6_each_database_ddl 

IFS=$'\n'
for datname in $DATNAME; do
  if [ -n "$datname" ]; then 
   export PGDATABASE=$datname

   #only user schema export
   SCHEMA_NAME=$(psql -U gpadmin -t -A -c "SELECT nspname FROM pg_catalog.pg_namespace where nspname not in ('gp_toolkit','pg_toast','pg_bitmapindex','pg_aoseg','pg_catalog','information_schema') order by 1;")

    for nspname in $SCHEMA_NAME; do
      if [ -n "$nspname" ]; then
	mkdir -p $PWD/$datname
	pg_dump --schema=$nspname --schema-only  > $PWD/$datname/$nspname.sql
	cp $PWD/$datname/$nspname.sql $PWD/$datname/$nspname.ori
	cat $PWD/$datname/$nspname.sql |grep -B 1 'PRIMARY KEY' > $PWD/$datname/$nspname_PK.sql
	sed 'N;s/\n/ /' $PWD/$datname/$nspname_PK.sql> $PWD/$datname/$nspname"_crt_idx".sql
	cat $PWD/$datname/$nspname.sql |grep 'CREATE INDEX' 		>> $PWD/$datname/$nspname"_crt_idx".sql 
	cat $PWD/$datname/$nspname.sql |sed 's/CREATE INDEX/ -- CREATE INDEX/g' | sed 's/ALTER TABLE ONLY/-- ALTER TABLE ONLY/g' | sed 's/ADD CONSTRAINT/-- ADD CONSTRAINT/g' > $PWD/$datname/$nspname"_without_index".sql
      fi
    done
  fi
 rm -rf $PWD/$datname/*_PK.sql
done
