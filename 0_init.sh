#!/bin/bash

export PGDATABASE=gpadmin

#init

#rm -rf ./all_backup
mkdir -p ./all_backup/conf
mkdir -p ./all_backup/env
mkdir -p ./all_backup/pg_dumpall
mkdir -p ./all_backup/os
rm -rf *.sql
rm -rf *.ori
#rm -rf ./all_backup/*.*
#rm -rf ./all_backup/conf/*
#rm -rf ./all_backup/env/*
#rm -rf ./all_backup/os/*
