#!/usr/bin/bash

bat="$(acpi | grep -o -E '[0-9]+%')"
date="$(date "+%F %R")"
pomo_status=$(cat ~/.pomodoro_status)

echo " $date | $bat | Pomodoro: $pomo_status"

# cron
# * * * * * env DISPLAY=:0 xprop -root -set WM_NAME "$(/home/im7ffy/scripts/wm_name.sh)"
