#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

#OS Kernel
cp /etc/sysctl.conf ./all_backup/os/mst_sysctl.$TODAY
scp -r gpadmin@sdw1:/etc/sysctl.conf ./all_backup/os/seg_sysctl.$TODAY
