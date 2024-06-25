#g++ main.cpp
N=$1
FILE_SIZE=20000000
for ((i=1; i<=N; i++))
do
	./multiplier.out $FILE_SIZE $i
done
