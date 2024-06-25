truncate -s 0 killlist
truncate -s 0 kek
# l = 4821776, r = 4824812
N=$((4821776))
K=$((30))
for ((i=1; i<=K; i++));
do
	bash newmem.bash $N &
	echo $! >> kek
	echo $! >> killlist
	sleep 1
done
