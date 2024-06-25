#g++ main.cpp
N=$1
FILE_SIZE=20000000
declare -a pids
for ((i=1; i<=N; i++))
do
	./multiplier.out $FILE_SIZE $i &
	pids[i]=$!
done

while true;
do
	have_alive=0
	for pid in "${pids[@]}"
	do
		if ps -p $pid > /dev/null
		then
			have_alive=1
		fi
	done
	if [ $have_alive -eq 0 ]; then
		break
	fi
done
