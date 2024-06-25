#!/bin/bash
truncate -s 0 before_sleep
truncate -s 0 result
truncate -s 0 7_answer
for pid in $(ps -axo pid --sort=ppid | tail -n +2)
do
	io_file="/proc/$pid/io"
	pid_directory="/proc/$pid/"
	if [ -d $pid_directory ]; then
		read_bytes=$(awk -F " " {'if ($1 == "read_bytes:") {print $2}'} $io_file)
		echo "$pid $read_bytes" >> before_sleep
	fi
done

sleep 60

while read line; do
	pid=$(echo $line | awk -F " " {'{print $1}'})
	io_file="/proc/$pid/io"
	pid_directory="/proc/$pid/"
	if [ -d $pid_directory ]; then
		read_bytes=$(awk -F " " {'if ($1 == "read_bytes:") {print $2}'} $io_file)
		read_bytes_before_sleep=$(echo $line | awk -F " " {'{print $2}'})
		delta=$(($read_bytes - $read_bytes_before_sleep))
		echo "$pid $delta" >> result
	fi
done < before_sleep

sort -nk2 result | tail -n 3 > tmp

while read line; do
	pid=$(echo $line | awk -F " " {'{print $1}'})
	read_bytes=$(echo $line | awk -F " " {'{print $2}'})
	cmd="NO_CMD"
	if [ -e "/proc/$pid/cmdline" ]; then
		cmd=$(cat /proc/"$pid"/cmdline)
	fi
	echo "PID=$pid : CMDLine=$cmd : Read_bytes=$read_bytes" >> 7_answer
done < tmp
