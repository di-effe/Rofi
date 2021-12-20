#!/usr/bin/env bash

# SETTINGS ####################################################
shutdown=""
reboot=""
lock=""
suspend=""
logout=""
###############################################################

LPATH="$( cd "$(dirname "$0")" ; pwd -P )"
rofi_command="rofi -theme $LPATH/rasi/powermenu.rasi"


options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
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