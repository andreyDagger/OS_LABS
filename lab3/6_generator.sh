#!/bin/bash
while true; do
	read LINE
	case $LINE in
		"+")
			kill -USR1 $(cat .pid)
			;;
		"*")
			kill -USR2 $(cat .pid)
			;;
		"sq")
			kill -SIGRTMAX $(cat .pid)
			;;
		"rs")
			kill -SIGRTMIN $(cat .pid)
			;;
		"TERM")
			kill -SIGTERM $(cat .pid)
			exit 0
			;;
	esac
done
