#!/bin/bash

declare -a files_array
declare -a parent_dir_array
declare -a links_array

home_dir=$HOME
index=$((0))
index2=$((0))
filename=""
parent_dir=""

if ! [ -e "${home_dir}/.trash.log" ]; then
	echo "error: couldn't find trash.log"
	exit 0
fi

if ! [ -e "${home_dir}/.trash" ]; then
	echo "error: couldn't find trash"
	exit 0
fi


while read LINE
do
	if [ $((index % 2)) -eq 0 ]; then
		filename=$(echo $LINE | awk -F "/" {'{print $NF}'} )
		parent_dir=$(dirname $LINE)
	else
		if [ "${filename}" == "$1" ]; then
			echo "${parent_dir}/${filename}"
			files_arrray[index2]=$filename
			parent_dir_array[index2]=$parent_dir
			links_array[index2]=$LINE
		fi
		index2=$((index2+1))
	fi
	index=$((index+1))
done < "${home_dir}/.trash.log"

echo "Print number of file that you want to restore, or any number out of range, if you don't want to restore"
read num
num=$((num-1))
if [ $num -lt 0 ] || [ $num -ge $index2 ]; then
	echo "Don't restore"
	exit 0
fi

if ! [ -e ${parent_dir[num]} ]; then
	echo "restoring in home"
	parent_dir_array[index2]=$HOME
fi

if [ -e "${parent_dir[num]}/$1" ]; then
	echo "already have file with this name, write other name:"
	read name
	files_array[num]=$name
fi

ln ${links_array[num]} "${parent_dir_array[num]}/${files_array[num]}"
rm ${links_array[num]}
echo "Done"
