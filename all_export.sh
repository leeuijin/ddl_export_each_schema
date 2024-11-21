#!/bin/bash

export PGDATABASE=gpadmin
sh 0_init.sh
sh 1_conf_backup.sh
sh 2_profile_backup.sh
sh 3_pg_dumpall.sh
sh 4_sysctl_backup.sh
sh 5_each_schema_ddl_backup.sh
sh 6_each_database_schema_ddl_backup.sh
sh 7_gen_ddl_gpdb_4_to_6.sh
