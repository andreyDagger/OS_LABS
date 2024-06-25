#!/bin/bash

answer_filename="4_answer"
truncate -s 0 $answer_filename
processes=$(ps -axo pid --sort=ppid | tail -n +2)

for pid in $processes
do
	pid_directory="/proc/$pid/"
	status_filename="$pid_directory/status"
	sched_filename="$pid_directory/sched"
	if [ -d $pid_directory ]; then # check if we have this directory
		ppid=$(awk -F " " {'if ($1 == "PPid:") {print $2}'} $status_filename)
		sum_exec_runtime=$(awk -F " " {'if ($1 == "se.sum_exec_runtime") {print $3}'} $sched_filename)
		nr_switches=$(awk -F " " {'if ($1 == "nr_switches") {print $3}'} $sched_filename)
		art=$(echo "scale=6; $sum_exec_runtime / $nr_switches" | bc)
		echo "ProcessID=$pid : Parent_ProcessID=$ppid : Average_Running_Time=$art" >> $answer_filename
  	fi
done
