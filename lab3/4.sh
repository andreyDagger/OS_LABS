#!/bin/bash
bash 4_generator.sh &
pid1=$!
bash 4_generator.sh &
pid2=$!
bash 4_generator.sh &
pid3=$!

cpulimit -p $pid1 -l 10 &

echo "process 1 usage: $(top -b -n 1 -p $pid1 | awk '{if (NR>7){print $9}}')"
echo "process 2 usage: $(top -b -n 1 -p $pid2 | awk '{if (NR>7) {print $9}}')"
echo "process 3 usage $(top -b -n 1 -p $pid3 | awk '{if (NR>7) {print $9}}')"

for i in {1..8}
do
	sleep 1
	echo $(ps -p $pid1 -o %cpu | tail -n 1)
done
kill $pid3
