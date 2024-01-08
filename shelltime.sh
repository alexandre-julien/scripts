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

# TODO: implement stopwatch mode
# time=0
# if [ "$arg" = "" ]; then
# 	while true; do
# 		echo -ne "\r\e[2K""$hours""h" "$minutes""m" "$i""s"
# 		sleep 1
# 		time=$((time+1))
# 	done
# fi

while [ "$hours" -ge 0 ]; do
	while [ "$minutes" -ge 0 ]; do
		for ((i=seconds; i>0; i--)); do
			echo -ne "\r\e[2K""$hours""h" "$minutes""m" "$i""s"
			sleep 1
		done
		minutes=$((minutes-1))
		seconds="59"
	done
	hours=$((hours-1))
	minutes="59"
done

notify-send "Timer done."
