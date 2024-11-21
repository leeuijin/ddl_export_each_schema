#!/bin/bash
export PGDATABASE=gpadmin

#OS Kernel
cp /etc/sysctl.conf ./all_backup/env/mst_sysctl.conf
scp -r gpadmin@sdw1:/etc/sysctl.conf ./all_backup/env/seg_sysctl.conf

