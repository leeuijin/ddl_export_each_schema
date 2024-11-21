#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#OS Kernel
cp /etc/sysctl.conf ./all_backup/4_os/mst_sysctl.$TODAY
scp -r gpadmin@sdw1:/etc/sysctl.conf ./all_backup/4_os/seg_sysctl.$TODAY
