#!/usr/bin/bash

bat=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$bat" -le 20 ]; then
	notify-send -u critical "Low battery"
fi

# cron
# * * * * * env DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus /home/im7ffy/scripts/low_battery.sh
