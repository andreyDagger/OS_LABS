declare -a arr
arr[0]="123"
arr[1]="456"
for ele in "${arr[@]}"
do
	echo $ele
done
