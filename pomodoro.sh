#!/usr/bin/bash

already_running() {
	pid="$(pgrep pomodoro)"
	if [ "$pid" != "$$" ] ; then
		echo "Found running instance PID: $pid"
		exit
	fi
}

refresh_status_bar() {
	env DISPLAY=:0 xprop -root -set WM_NAME "$(/home/im7ffy/scripts/wm_name.sh)"
}

reset() {
	echo "0" > ~/.pomodoro_counter && echo "Pomodo counter reset, done."
	echo "inactive" > ~/.pomodoro_status
	echo "" > ~/.pomodoro_remaining_time
	refresh_status_bar
}

cycle() {
	refresh_status_bar
	echo -ne "\r$i""min"
	sleep 60
}

notify() {
	echo -e "\n"
	notify-send -u critical "Done."
}

if [[ $1 != "" ]] && [[ $(echo "$1" | grep -E "reset|break") == "" ]]; then
	echo "USAGE:"
	echo "	pomodoro"
	echo "	pomodoro reset"
	echo "	pomodoro break short|long"
fi

if [[ $1 == "reset" ]]; then
	reset
fi

if [[ $1 == "break" ]]; then
	if [[ $2 == "short" ]]; then
		for i in {0..4}; do
			echo "$((5-i))" > ~/.pomodoro_remaining_time
			cycle
		done
		notify
		echo "" > ~/.pomodoro_remaining_time
	elif [[ $2 == "long" ]]; then
		for i in {0..19}; do
			echo "$((20-i))" > ~/.pomodoro_remaining_time
			cycle
		done
		notify
		echo "" > ~/.pomodoro_remaining_time
	else
		echo "Need to specify break type, either 'short' or 'long'"
	fi
fi


if [[ $1 == "" ]]; then
	already_running
	if [[ "$(cat ~/.pomodoro_counter)" -ge 4 ]]; then
		echo "Counter =""$(cat ~/.pomodoro_counter)"", take a break!"
	else
		echo "active" > ~/.pomodoro_status
		for i in {0..24}; do
			echo $((25-i)) > ~/.pomodoro_remaining_time
			cycle
		done && echo $(("$(cat ~/.pomodoro_counter)"+1)) > ~/.pomodoro_counter
		echo "inactive" > ~/.pomodoro_status
		echo -e "\nBreak"
		notify-send -u critical "Break"
		echo "" > ~/.pomodoro_remaining_time
		refresh_status_bar
	fi
fi
