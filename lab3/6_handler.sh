#!bin/bash
echo $$ > .pid
val=$((1))
mode="add"
MAX_VAL=$((10000))
usr1()
{
	mode="add"
}
usr2()
{
	mode="mul"
}
sigrtmin()
{
	mode="reset"
}
sigrtmax()
{
	mode="square"
}
sigterm()
{
	echo "stopped by other process"
	exit 0
}
trap 'usr1' USR1
trap 'usr2' USR2
trap 'sigrtmin' SIGRTMIN
trap 'sigrtmax' SIGRTMAX
trap 'sigterm' SIGTERM
while true; do
	case "$mode" in
		"add")
			val=$((val+2))
			;;
		"mul")
			val=$((val*2))
			;;
		"reset")
			val=$((1))
			mode="+"
			;;
		"square")
			val=$((val*val))
			;;
	esac
	if [[ $val -gt $MAX_VAL ]]; then
		echo "OVERFLOW"
		val=$((1))
		mode="+"
	fi
	echo $val
	sleep 1
done
