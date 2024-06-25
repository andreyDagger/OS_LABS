filename="students"
group=$1
res=$(awk -v var="$group" -F " " {'if ($4 == var) {print $5}'} $filename)
if [ -z "$res" ]
then
    echo "There's no students with such group"
    exit 0
fi
res=$(echo $res | sed 's/ /+/g')
count=$(echo $res | tr -cd '+' | wc -c)
count=$((count+1))
res="(${res})/${count}"
echo $res | bc -l
