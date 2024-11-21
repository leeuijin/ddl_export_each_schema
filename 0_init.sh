#!/bin/bash

export PGDATABASE=gpadmin

#init

#rm -rf ./all_backup
mkdir -p ./all_backup/1_conf
mkdir -p ./all_backup/2_env
mkdir -p ./all_backup/3_pg_dumpall
mkdir -p ./all_backup/4_os
rm -rf *.sql
rm -rf *.ori
#rm -rf ./all_backup/*.*
#rm -rf ./all_backup/1_conf/*
#rm -rf ./all_backup/2_env/*
#rm -rf ./all_backup/3_pg_dumpall/*
#rm -rf ./all_backup/4_os/*
