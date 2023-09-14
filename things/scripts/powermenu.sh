#!/usr/bin/env bash

op=$( echo -e " Poweroff\n Reboot\n Lock\n Logout" | tofi | awk '{print tolower($2)}' )

case $op in 
        poweroff)
		systemctl poweroff
		;&
        reboot)
		systemctl reboot
		;&
        lock)
		swaylock
                ;;
        logout)
                swaymsg exit
                ;;
esac
