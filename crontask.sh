#!/bin/bash
# save the arguments
# we check if the directory to save exists
# if exists, then make backup

dir_files=$1
backups=$2
archive_file="$backups/backup.tgz"

if [ -d $dir_files ]; then
    tar -cvzf ${archive_file} $dir_files
else
    echo "The directory does not exist" >>$backups/test.log
fi
