#!/bin/bash

while [ ! -f .pid ]
do
:
done

mode="+"
val=$((1))
(tail -f my_pipe4) |
while true; do
	read LINE
	case "$LINE" in
		"QUIT")
			echo "successfully finished"
			kill $(cat .pid)
			exit 0
			;;
		"*")
			echo "mode * now"
			mode="*"
			;;
		"+")
			mode="+"
			;;
		*)
			if [[ $LINE =~ ^[0-9]+$ ]]; then
				if [[ $mode == "*" ]]; then
					val=$((val*LINE))
				else
					val=$((val+LINE))
				fi
				echo $val
			else
				echo "undefined command"
				kill $(cat .pid)
				exit 0
			fi
			;;
	esac
done
