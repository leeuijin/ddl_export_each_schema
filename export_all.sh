#!/bin/bash
TODAY=$(date "+%Y%m%d%H%M")

export PGDATABASE=gpadmin

sh 0_init.sh > ./all_backup/log/0_init.log.$TODAY 2>&1
sh 1_conf_backup.sh > ./all_backup/log/1_conf_backup.log.$TODAY 2>&1
sh 2_profile_backup.sh > ./all_backup/log/2_profile_backup.log.$TODAY 2>&1
sh 3_pg_dumpall.sh > ./all_backup/log/3_pg_dumpall.log.$TODAY 2>&1
sh 4_sysctl_backup.sh > ./all_backup/log/4_sysctl_backup.log.$TODAY 2>&1
sh 5_each_schema_ddl_backup.sh > ./all_backup/log/5_each_schema_ddl_backup.log.$TODAY 2>&1
sh 6_each_database_schema_ddl_backup.sh > ./all_backup/log/6_each_database_schema_ddl_backup.log.$TODAY 2>&1
sh 7_gen_ddl_gpdb_4_to_6.sh > ./all_backup/log/7_gen_ddl_gpdb_4_to_6.log.$TODAY 2>&1
