#!bin/bash

echo $$ >> .pid
while true; do
	read LINE
	echo "$LINE" >> my_pipe4
done
