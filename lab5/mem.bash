echo $$ > .pid

truncate -s 0 "report.log"

if ! [ -f "report.log" ]; then
	touch report.log
fi

declare -a arr
iters=$((0))
size=$((0))
while true
do
	for i in {0..9}
	do
		arr[$((size+i))]=$i
	done
	iters=$((iters+1))
	size=$((size+10))
	if [ $((iters % 100000)) -eq 0 ]; then
		echo $size >> report.log
	fi
done
