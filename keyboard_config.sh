#!/usr/bin/bash

mode=$(echo -e "laptop only\nlaptop + keyboard\nworkstation" | dmenu)

if [[ $mode == "laptop only" ]]; then
	setxkbmap && setxkbmap -option ctrl:nocaps -option compose:ralt -option altwin:swap_alt_win
elif [[ $mode == "laptop + keyboard" ]]; then
	setxkbmap && setxkbmap -option ctrl:nocaps -option compose:rwin
else
	setxkbmap 
fi
