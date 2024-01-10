#!/usr/bin/bash

bat="$(acpi | grep -o -E '[0-9]+%')"
date="$(date "+%F %R")"
pomo_status=$(cat ~/.pomodoro_status)
pomo_time=$(cat ~/.pomodoro_remaining_time)
if [ "$pomo_time" != "" ]; then
	pomo_time="$pomo_time""m "
fi

echo " $date | $bat | Pomodoro: $pomo_status $pomo_time"

# cron
# * * * * * env DISPLAY=:0 xprop -root -set WM_NAME "$(/home/im7ffy/scripts/wm_name.sh)"
