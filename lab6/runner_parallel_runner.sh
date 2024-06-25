for ((N=1; N<=20; N++))
do
	echo "${N}:"
	sum=0
	
	./file_generator.out $N
	exit 0
	
	for i in {0..9}
	do
		exec_time=$({ time -p (bash runner_parallel.sh $N); } 2>&1 | grep real | awk '{print $2}')
		exec_time=$(echo "$exec_time" | tr ',' '.')
		sum=$(echo "$sum + $exec_time" | bc)
		echo $exec_time
	done
	mean=$(echo "scale=2; ${sum} / 10" | bc)
	echo "Mean: ${mean}"
done
