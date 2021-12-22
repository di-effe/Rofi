#!/usr/bin/env bash

# SETTINGS ####################################################
# Feather font icons:
# -bmon ~ bandwidth monitor and rate estimator
bmon=""
# -nmtui ~ Text User Interface for controlling NetworkManager
nmtui=""
# -nm-connection-editor ~ network connection editor for NetworkManager
nmce=""
# -misc
connected=""
disconnected=""
#
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
rofi_cmd="rofi -theme $LPATH/rasi/network.rasi"

# Command not found message
cnf() {
    rofi -theme "$LPATH/rasi/message.rasi" \
    -e "$1 not found on your system"
}


## Get info
IFACE="$(nmcli | grep -i interface | awk '/interface/ {print $2}')"
STATUS="$(nmcli radio wifi)"

active=""
urgent=""

if (ping -c 1 archlinux.org || \
    ping -c 1 google.com || \
    ping -c 1 bitbucket.org || \
    ping -c 1 github.com || \
    ping -c 1 sourceforge.net) \
    &>/dev/null; then
	if [[ $STATUS == *"enable"* ]]; then
        if [[ $IFACE == e* ]]; then
            connected="$connected"
        else
            connected="$connected"
        fi
	active="-a 0"
	SSID="﬉ $(iwgetid -r)"
	LIP="$(nmcli | grep -i server | awk '/server/ {print $2}')"
	fi
else
    urgent="-u 0"
    SSID="Disconnected"
    LIP="Not Available"
    connected="$disconnected"
fi

options="$connected\n$bmon\n$nmtui\n$nmce"

# Main
chosen="$(echo -e "$options" | \
$rofi_cmd -p " $SSID  ~  $LIP " -dmenu \
$active $urgent \
-theme-str 'window {location: '$LOCATION';}' \
-selected-row 2)"

# Use choosen 
case $chosen in
    $connected)
		if [[ $STATUS == *"enable"* ]]; then
			nmcli radio wifi off
		else
			nmcli radio wifi on
		fi 
        ;;
    $bmon)
        if ! [ -x "$(command -v bmon)" ]; then
            cnf bmon
            ${0}
        else
            if ! [ -x "$(command -v alacritty)" ]; then
                alacritty -e bmon
            else
                termite -e bmon
            fi
        fi
        ;;
    $nmtui)
        if ! [ -x "$(command -v nmtui)" ]; then
            cnf nmtui
            ${0}
        else
            if ! [ -x "$(command -v alacritty)" ]; then
                alacritty -e nmtui
            else
                termite -e nmtui
            fi
        fi
        ;;
    $nmce)
        if ! [ -x "$(command -v nm-connection-editor)" ]; then
            cnf nm-connection-editor
            ${0}
        else
            nm-connection-editor
        fi
        ;;
esac