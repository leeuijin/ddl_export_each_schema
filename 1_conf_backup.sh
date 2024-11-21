#!/bin/bash
export PGDATABASE=gpadmin

#postgresql.conf backup

cp /data/master/gpseg-1/postgresql.conf  ./all_backup/conf/mst_postgresql.conf
scp -r gpadmin@sdw1:/data1/primary/gpseg0/postgresql.conf ./all_backup/conf/seg_postgresql.conf
cp /data/master/gpseg-1/pg_hba.conf  ./all_backup/conf/mst_pg_hba.conf
