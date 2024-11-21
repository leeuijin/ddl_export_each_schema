#!/bin/bash

export PGDATABASE=gpadmin
sh 0_init.sh
sh 1_conf_backup.sh
sh 2_profile_backup.sh
sh 3_pg_dumpall.sh
sh 4_sysctl_backup.sh
sh 5_each_schema_ddl_backup.sh

