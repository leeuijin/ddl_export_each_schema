#!/bin/bash
export PGDATABASE=gpadmin
TODAY=$(date "+%Y%m%d")

# gpadmin env
cp /home/gpadmin/.bashrc ./all_backup/2_env/bashrc_$TODAY
cp /home/gpadmin/.bash_profile ./all_backup/2_env/bash_profile_$TODAY
cp /home/gpadmin/.pgpass ./all_backup/2_env/pgpass_$TODAY



