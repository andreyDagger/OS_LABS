#!/bin/bash

home_dir=$HOME

dir_name="${home_dir}/Backup-$(date +%Y-%m-%d)"
my_days_format=$(($(date -d $(date +%Y-%m-%d) +%s) / 86400))

created_dir=1

for full_dir_path in ${home_dir}/*/;
do
	full_dir_path=$(echo $full_dir_path | sed 's/.$//') #remove last "/"
	cur_dir_name=$(echo $full_dir_path | awk -F "/" {'{print $NF}'})
	if [[ $cur_dir_name == "Backup"* ]]; then
		year=$(echo $cur_dir_name | awk -F "-" {'{print $2}'})
		month=$(echo $cur_dir_name | awk -F "-" {'{print $3}'})
		day=$(echo $cur_dir_name | awk -F "-" {'{print $4}'})
		if [[ $year =~ ^[0-9]+$ ]] && [[ $month =~ ^[0-9]+$ ]] && [[ $day =~ ^[0-9]+$ ]]; then
			days_format=$(($(date -d "${year}-${month}-${day}" +%s) / 86400))
			if [ $((my_days_format - days_format)) -lt 7 ]; then
				created_dir=0
				dir_name="${home_dir}/${cur_dir_name}"
				break
			fi
		fi
	fi
done

if [[ $created_dir == 0 ]]; then
	declare -a new_files
	declare -a old_files

	new_files_counter=$((0))
	old_files_counter=$((0))

	for full_file_path in ${home_dir}/source/*; do
		file=$(echo $full_file_path | awk -F "/" {'{print $NF}'})
		if [ -e "${dir_name}/$file" ]; then
			size_from=$(stat --printf="%s" "${home_dir}/source/${file}")
			size_to=$(stat --printf="%s" "${dir_name}/$file")
			if [[ $size_from != $size_to ]]; then
				mv "${dir_name}/$file" "${dir_name}/$file.$(date +%Y-%m-%d)"
				cp "${home_dir}/source/${file}" "${dir_name}"
				old_files[new_files_counter]="New file: ${file} ; Old file: ${file}.$(date +%Y-%m-%d)"
				old_files_counter=$((old_files_counter+1))
			fi
		else
			cp "${home_dir}/source/${file}" "${dir_name}"
			new_files[new_files_counter]="${file}"
			new_files_counter=$((new_files_counter+1))
		fi
	done
	
	report_filename="${home_dir}/backup-report"
	if ! [ -e $report_filename ]; then
		touch $report_filename
	fi
	
	echo "Made changes in ${dir_name} on $(date +%Y-%m-%d)" >> $report_filename
	for fname in "${new_files[@]}"
	do
		echo "New file ${fname}" >> $report_filename
	done
	for fname in "${old_files[@]}"
	do
		echo "Already had: ${fname}" >> $report_filename
	done
else
	mkdir $dir_name
	cp "${home_dir}/source/"* "${dir_name}"

	report_filename="${home_dir}/backup-report"
	if ! [ -e $report_filename ]; then
		touch $report_filename
	fi
	
	dd=$(date +%Y-%m-%d)
	echo "Backup directory ${dir_name} was created on ${dd}" >> $report_filename
	for file in ${home_dir}/source/*;
	do
		echo $file >> $report_filename
	done
fi
