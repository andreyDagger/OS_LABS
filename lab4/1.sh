#!/bin/bash

filename=$1
cur_dir=$PWD
home_dir=$HOME
date=$(date +%d_%m_%Y_%H:%M:%S.%3N)
if ! [ -f "${filename}" ]; then
	echo "error: no such file exist"
	exit 0
fi
if ! [ -e "${home_dir}/.trash" ]; then
	mkdir "${home_dir}/.trash"
fi

ln -f "${filename}" "${home_dir}/.trash/strong_link_${date}"
rm $filename

if ! [ -e "${home_dir}/.trash.log" ]; then
	touch "${home_dir}/.trash.log"
fi

printf "${cur_dir}/${filename}\n${home_dir}/.trash/strong_link_${date}\n" >> ~/.trash.log
