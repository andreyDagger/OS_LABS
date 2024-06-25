#!/bin/bash

home_dir=$HOME
restore_dir="${home_dir}/restore"

if ! [ -e $restore_dir ]; then
	mkdir $restore_dir
fi

backup_dir=""
latest_date=0

for full_dir_path in ${home_dir}/*/;
do
	full_dir_path=$(echo $full_dir_path | sed 's/.$//') #remove last "/"
	cur_dir_name=$(echo $full_dir_path | awk -F "/" {'{print $NF}'})
	if [[ $cur_dir_name == "Backup"* ]]; then
		year=$(echo $cur_dir_name | awk -F "-" {'{print $2}'})
		month=$(echo $cur_dir_name | awk -F "-" {'{print $3}'})
		day=$(echo $cur_dir_name | awk -F "-" {'{print $4}'})
		seconds_format=$(date -d "${year}-${month}-${day}" +%s)
		if [ $((latest_date)) -lt $((seconds_format)) ]; then
			latest_date=$seconds_format
			backup_dir=$cur_dir_name
		fi
	fi
done

if [ $backup_dir == "" ]; then
	echo "No backup directory"
	exit 0
fi

echo "Backup directory: ${backup_dir}"

for full_file_path in ${home_dir}/${backup_dir}/*;
do
	file=$(echo $full_file_path | awk -F "/" {'{print $NF}'})
	if ! [[ $file =~ ^.+\.([0-9]{4}-[0-9]{2}-[0-9]{2})$ ]]; then
		cp "${full_file_path}" "${restore_dir}"
	else
		without_extension="${file:0:-11}"
		if ! [ -f  ${home_dir}/${backup_dir}/${without_extension} ]; then
			cp "${full_file_path}" "${restore_dir}"
			mv "${restore_dir}/${file}" "${restore_dir}/${without_extension}"
		fi
	fi
done
