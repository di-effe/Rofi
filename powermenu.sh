#!/usr/bin/env bash

# SETTINGS ####################################################
shutdown=""
reboot=""
lock=""
suspend=""
logout=""
# Possible positions:
# center
# north
# northeast
# east
# southeast
# south
# southwest
# west
# northwest
LOCATION="center"
###############################################################

LPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Rofi config
rofi_cmd="rofi -theme $LPATH/rasi/powermenu.rasi"
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

# Main
chosen="$(echo -e "$options" | \
$rofi_cmd -dmenu \
-theme-str 'window {location: '$LOCATION';}' \
-selected-row 2\
)"

# Use choosen 
case $chosen in
    $lock)
		$LPATH/misc/lockscreen
	;;    
    $shutdown)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $suspend)
        mpc -q pause &
        amixer set Master mute &
        systemctl suspend
        ;;
    $logout)
        loginctl terminate-session ${XDG_SESSION_ID-}	
	;;
esac