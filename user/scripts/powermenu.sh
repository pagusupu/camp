op=$( echo -e '󰐥 Poweroff\n Reboot\n Suspend\n Logout' | rofi -dmenu | awk '{print tolower($2)}' )

                       case $op in
                               poweroff)
	                 	       systemctl poweroff
		                       ;&
                               reboot)
		                       systemctl reboot
		                       ;&
                               suspend)
                                       systemctl suspend
		                       ;&
                               logout)
                                       bspc exit
                                       ;;
                       esac
