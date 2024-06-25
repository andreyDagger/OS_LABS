#!/bin/bash

cpu_burst_file="4_answer"
truncate -s 0 tmp

prev_ppid="0 "
art_sum=$((0))
art_count=$((0))

while read line; do
	cur_ppid=$(echo $line | cut -d":" -f2 | cut -d"=" -f2)
	cur_art=$(echo $line | cut -d":" -f3 | cut -d"=" -f2)
	if [[ "$cur_ppid" != "$prev_ppid" ]]
	then
		arc=$(echo "scale=6; $art_sum / $art_count" | bc)
		echo "Average_Running_Children_of_ParentID=$prev_ppid is $arc" >> tmp
		art_sum=$cur_art
		art_count=$((1))
	else
		art_count=$((art_count + 1))
		art_sum=$(echo "$art_sum + $cur_art" | bc)
	fi
	echo $line >> tmp
	prev_ppid=$cur_ppid
done < $cpu_burst_file

arc=$(echo "scale=6; $art_sum / $art_count" | bc)
echo "Average_Running_Children_of_ParentID=$prev_ppid is $arc" >> tmp
cat tmp > cpu_burst_file
rm -f tmp
