#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#postgresql.conf backup

cp /data/master/gpseg-1/postgresql.conf  ./all_backup/1_conf/mst_postgresql.$TODAY
scp -r gpadmin@sdw1:/data1/primary/gpseg0/postgresql.conf ./all_backup/1_conf/seg_postgresql.$TODAY
cp /data/master/gpseg-1/pg_hba.conf  ./all_backup/1_conf/mst_pg_hba.$TODAY
