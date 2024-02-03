#!/usr/bin/bash

arg=$1
hours=${arg%*h*}
minutes=${arg#*h*} && minutes=${minutes%m*}
seconds=${arg#*m} && seconds=${seconds%s}

if [[ "$hours" == *[[:alpha:]]* ]]; then
	hours=0
fi

if [[ "$minutes" == *[[:alpha:]]* ]] || [[ $minutes == "" ]]; then
	minutes=0
fi

if [[ "$seconds" == *[[:alpha:]]* ]]; then
	seconds=0
fi

if [ "$arg" = "" ]; then
	hours=0
	minutes=0
	seconds=0
	while true; do
		if [ "$seconds" -ge 60 ]; then
			minutes=$((minutes+1))
			seconds=0
		fi
		if [ "$minutes" -ge 60 ]; then
			minutes=0
			hours=$((hours+1))
		fi
		echo -ne "\r\e[2K$hours""h""$minutes""m""$seconds""s"
		sleep 1
		seconds=$((seconds+1))
	done
fi

while [ "$hours" -ge 0 ]; do
	while [ "$minutes" -ge 0 ]; do
		for ((i=seconds; i>0; i--)); do
			echo -ne "\r\e[2K$hours h$minutes m $i s"
			sleep 1
		done
		minutes=$((minutes-1))
		seconds="59"
	done
	hours=$((hours-1))
	minutes="59"
	echo ""
done

notify-send "Timer done."
