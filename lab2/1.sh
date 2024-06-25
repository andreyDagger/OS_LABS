#!bin/bash

username="andrey"
output_file="1_answer"
ps -u $username > tmp
count=$(ps -u $username | wc -l)
count=$((count-1))  # because first line is bad
echo $count > $output_file
awk -F " " {'if (NR>1) {print $1 ":" $4}'} tmp >> $output_file
rm -f tmp
